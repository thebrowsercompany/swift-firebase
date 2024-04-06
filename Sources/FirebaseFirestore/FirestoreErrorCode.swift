// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

public struct FirestoreErrorCode: RawRepresentable, FirebaseError {
  public typealias RawValue = Int

  public let rawValue: Int
  public let localizedDescription: String

  public init(rawValue: Int) {
    self.rawValue = rawValue
    localizedDescription = "\(rawValue)"
  }

  @_spi(FirebaseInternal)
  public init(code: Int32, message: String) {
    self.rawValue = Int(code)
    localizedDescription = message
  }

  private init(_ error: firebase.firestore.Error) {
    self.init(rawValue: Int(error.rawValue))
  }
}

extension FirestoreErrorCode {
  init(_ error: firebase.firestore.Error, errorMessage: String?) {
    self.init(code: error.rawValue, message: errorMessage ?? "\(error.rawValue)")
  }

  init?(_ error: firebase.firestore.Error?, errorMessage: UnsafePointer<CChar>?) {
    guard let actualError = error, actualError.rawValue != 0 else { return nil }
    var errorMessageString: String?
    if let errorMessage {
      errorMessageString = .init(cString: errorMessage)
    }
    self.init(actualError, errorMessage: errorMessageString)
  }
}

extension FirestoreErrorCode {
  public static let ok: Self = .init(firebase.firestore.kErrorOk)
  public static let none: Self = .init(firebase.firestore.kErrorNone)
  public static let cancelled: Self = .init(firebase.firestore.kErrorCancelled)
  public static let unknown: Self = .init(firebase.firestore.kErrorUnknown)
  public static let invalidArgument: Self = .init(firebase.firestore.kErrorInvalidArgument)
  public static let deadlineExceeded: Self = .init(firebase.firestore.kErrorDeadlineExceeded)
  public static let notFound: Self = .init(firebase.firestore.kErrorNotFound)
  public static let alreadyExists: Self = .init(firebase.firestore.kErrorAlreadyExists)
  public static let permissionDenied: Self = .init(firebase.firestore.kErrorPermissionDenied)
  public static let resourceExhausted: Self = .init(firebase.firestore.kErrorResourceExhausted)
  public static let failedPrecondition: Self = .init(firebase.firestore.kErrorFailedPrecondition)
  public static let aborted: Self = .init(firebase.firestore.kErrorAborted)
  public static let outOfRange: Self = .init(firebase.firestore.kErrorOutOfRange)
  public static let unimplemented: Self = .init(firebase.firestore.kErrorUnimplemented)
  public static let `internal`: Self = .init(firebase.firestore.kErrorInternal)
  public static let unavailable: Self = .init(firebase.firestore.kErrorUnavailable)
  public static let dataLoss: Self = .init(firebase.firestore.kErrorDataLoss)
  public static let unauthenticated: Self = .init(firebase.firestore.kErrorUnauthenticated)
}

extension FirestoreErrorCode: Equatable {}

extension FirestoreErrorCode {
  public typealias Code = FirestoreErrorCode

  // This allows us to re-expose self as a code similarly
  // to what the Firebase SDK does when it creates the
  // underlying NSErrors on iOS/macOS.
  public var code: Code {
    return self
  }

  public init(_ code: Code) {
    self.init(rawValue: code.rawValue)
  }
}
