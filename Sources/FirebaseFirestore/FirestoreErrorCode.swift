// SPDX-License-Identifier: BSD-3-Clause

public struct FirestoreErrorCode: Error {
  public typealias Code = firebase.firestore.Error

  public let code: Code
  public let localizedDescription: String

  public init(_ error: firebase.firestore.Error, errorMessage: String?) {
    code = error
    localizedDescription = errorMessage ?? "\(code.rawValue)"
  }

  public init?(_ error: firebase.firestore.Error?, errorMessage: UnsafePointer<CChar>? = nil) {
    guard let actualError = error, actualError.rawValue != 0 else { return nil }
    var errorMessageString: String?
    if let errorMessage {
      errorMessageString = .init(cString: errorMessage)
    }
    self.init(actualError, errorMessage: errorMessageString)
  }
}

extension FirestoreErrorCode: Equatable {}

// Unfortunately `Error` is not defined as a `enum class` so we need to add
// these wrappers.
extension FirestoreErrorCode.Code {
  static var ok: Self { firebase.firestore.kErrorOk }
  static var none: Self { firebase.firestore.kErrorNone }
  static var cancelled: Self { firebase.firestore.kErrorCancelled }
  static var unknown: Self { firebase.firestore.kErrorUnknown }
  static var invalidArgument: Self { firebase.firestore.kErrorInvalidArgument }
  static var deadlineExceeded: Self { firebase.firestore.kErrorDeadlineExceeded }
  static var notFound: Self { firebase.firestore.kErrorNotFound }
  static var alreadyExists: Self { firebase.firestore.kErrorAlreadyExists }
  static var permissionDenied: Self { firebase.firestore.kErrorPermissionDenied }
  static var resourceExhausted: Self { firebase.firestore.kErrorResourceExhausted }
  static var failedPrecondition: Self { firebase.firestore.kErrorFailedPrecondition }
  static var aborted: Self { firebase.firestore.kErrorAborted }
  static var outOfRange: Self { firebase.firestore.kErrorOutOfRange }
  static var unimplemented: Self { firebase.firestore.kErrorUnimplemented }
  static var `internal`: Self { firebase.firestore.kErrorInternal }
  static var unavailable: Self { firebase.firestore.kErrorUnavailable }
  static var dataLoss: Self { firebase.firestore.kErrorDataLoss }
  static var unauthenticated: Self { firebase.firestore.kErrorUnauthenticated }
}
