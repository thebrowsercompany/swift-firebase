@_exported
import firebase

@_spi(Internal)
public typealias FutureCompletionType = swift_firebase.swift_cxx_shims.firebase.FutureCompletionType

@_spi(Internal)
public protocol FutureProtocol {
  //associatedtype ResultType
  func CallOnCompletion(_ completion: FutureCompletionType, _ user_data: UnsafeMutableRawPointer?)
}

@_spi(Internal)
public extension FutureProtocol {
  /*
  func setCompletion(_ completion: @escaping (ResultType?, Error?) -> Void) {
    withUnsafePointer(to: completion) { completion in
      setOnCompletion({ future, pvCompletion in
        // XXX
      }, UnsafeMutableRawPointer(mutating: completion))
    }
  }
  */

  func setCompletion(_ completion: @escaping () -> Void) {
    withUnsafePointer(to: completion) { completion in
      CallOnCompletion({ pvCompletion in
        // XXX
      }, UnsafeMutableRawPointer(mutating: completion))
    }
  }
}
