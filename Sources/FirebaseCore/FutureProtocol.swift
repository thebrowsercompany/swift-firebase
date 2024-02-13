// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase

import Foundation

@_spi(Internal)
public typealias FutureCompletionType = swift_firebase.swift_cxx_shims.firebase.FutureCompletionType

// This protocol enables extracting common code for Future handling. Because
// C++ interop is limited for templated class types, we need to invent a
// protocol to reflect the features of a Future<R> that should be generically
// available. This works by having a C++ annotation (see ConformingFuture<R>)
// that specifies this protocol conformance.
@_spi(Internal)
public protocol FutureProtocol {
  associatedtype ResultType
  func error() -> Int32
  func __error_messageUnsafe() -> UnsafePointer<CChar>?
  func __resultUnsafe() -> UnsafePointer<ResultType>?
  func CallOnCompletion(_ completion: FutureCompletionType, _ user_data: UnsafeMutableRawPointer?)
}

// A home for various helper functions that make it easier to work with
// Firebase Future objects from Swift.
@_spi(Internal)
public extension FutureProtocol {
  // Callsites retain their own reference to the Future<R>, but they still need
  // a way to know when the Future completes. This provides that mechanism.
  // While the underlying Firebase `OnCompletion` method can provide a reference
  // back to the Future, we don't need to expose that here.
  func setCompletion(_ completion: @escaping () -> Void) {
    CallOnCompletion({ ptr in
      Unmanaged<CompletionWrapper>.fromOpaque(ptr!).takeRetainedValue().completion()
    }, Unmanaged.passRetained(CompletionWrapper(completion)).toOpaque())
  }

  // A convenient way to access the result or error of a Future. Handles the
  // messy details.
  var resultAndError: (ResultType?, Error?) {
    let error = error()
    guard error == 0 else {
      let message = String(cString: __error_messageUnsafe()!)
      return (nil, FirebaseError(code: error, message: message))
    }
    return (__resultUnsafe().pointee, nil)
  }
}

// The Unmanaged type only works with classes, so we need a wrapper for the
// completion callback.
private class CompletionWrapper {
  let completion: () -> Void
  init(_ completion: @escaping () -> Void) {
    self.completion = completion
  }
}
