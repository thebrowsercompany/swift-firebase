// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase

@_spi(Internal)
public typealias FutureCompletionType = swift_firebase.swift_cxx_shims.firebase.FutureCompletionType

@_spi(Internal)
public protocol FutureProtocol {
  associatedtype ResultType
  func error() -> Int32
  func __error_messageUnsafe() -> UnsafePointer<CChar>?
  func __resultUnsafe() -> UnsafePointer<ResultType>?
  func CallOnCompletion(_ completion: FutureCompletionType, _ user_data: UnsafeMutableRawPointer?)
}

@_spi(Internal)
public extension FutureProtocol {
  func setCompletion(_ completion: @escaping () -> Void) {
    withUnsafePointer(to: completion) { completion in
      CallOnCompletion({ pvCompletion in
        let pCompletion = pvCompletion?.assumingMemoryBound(to: (() -> Void).self)
        pCompletion.pointee()
      }, UnsafeMutableRawPointer(mutating: completion))
    }
  }

  var resultAndError: (ResultType?, Error?) {
    let error = error()
    guard error == 0 else {
      let message = String(cString: __error_messageUnsafe()!)
      return (nil, FirebaseError(code: error, message: message))
    }
    return (__resultUnsafe().pointee, nil)
  }
}
