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
