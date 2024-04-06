// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

public struct AuthErrorCode: RawRepresentable, FirebaseError {
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

  private init(_ error: firebase.auth.AuthError) {
    self.init(rawValue: Int(error.rawValue))
  }
}

extension AuthErrorCode {
  public static let none: Self = .init(firebase.auth.kAuthErrorNone)
  public static let unimplemented: Self = .init(firebase.auth.kAuthErrorUnimplemented)
  public static let invalidCustomToken: Self = .init(firebase.auth.kAuthErrorInvalidCustomToken)
  public static let customTokenMismatch: Self = .init(firebase.auth.kAuthErrorCustomTokenMismatch)
  public static let invalidCredential: Self = .init(firebase.auth.kAuthErrorInvalidCredential)
  public static let userDisabled: Self = .init(firebase.auth.kAuthErrorUserDisabled)
  public static let accountExistsWithDifferentCredential: Self = .init(firebase.auth.kAuthErrorAccountExistsWithDifferentCredentials)
  public static let operationNotAllowed: Self = .init(firebase.auth.kAuthErrorOperationNotAllowed)
  public static let emailAlreadyInUse: Self = .init(firebase.auth.kAuthErrorEmailAlreadyInUse)
  public static let requiresRecentLogin: Self = .init(firebase.auth.kAuthErrorRequiresRecentLogin)
  public static let credentialAlreadyInUse: Self = .init(firebase.auth.kAuthErrorCredentialAlreadyInUse)
  public static let invalidEmail: Self = .init(firebase.auth.kAuthErrorInvalidEmail)
  public static let wrongPassword: Self = .init(firebase.auth.kAuthErrorWrongPassword)
  public static let tooManyRequests: Self = .init(firebase.auth.kAuthErrorTooManyRequests)
  public static let userNotFound: Self = .init(firebase.auth.kAuthErrorUserNotFound)
  public static let providerAlreadyLinked: Self = .init(firebase.auth.kAuthErrorProviderAlreadyLinked)
  public static let noSuchProvider: Self = .init(firebase.auth.kAuthErrorNoSuchProvider)
  public static let invalidUserToken: Self = .init(firebase.auth.kAuthErrorInvalidUserToken)
  public static let userTokenExpired: Self = .init(firebase.auth.kAuthErrorUserTokenExpired)
  public static let networkError: Self = .init(firebase.auth.kAuthErrorNetworkRequestFailed)
  public static let invalidAPIKey: Self = .init(firebase.auth.kAuthErrorInvalidApiKey)
  public static let appNotAuthorized: Self = .init(firebase.auth.kAuthErrorAppNotAuthorized)
  public static let userMismatch: Self = .init(firebase.auth.kAuthErrorUserMismatch)
  public static let weakPassword: Self = .init(firebase.auth.kAuthErrorWeakPassword)
  public static let noSignedInUser: Self = .init(firebase.auth.kAuthErrorNoSignedInUser)
  public static let apiNotAvailable: Self = .init(firebase.auth.kAuthErrorApiNotAvailable)
  public static let expiredActionCode: Self = .init(firebase.auth.kAuthErrorExpiredActionCode)
  public static let invalidActionCode: Self = .init(firebase.auth.kAuthErrorInvalidActionCode)
  public static let invalidMessagePayload: Self = .init(firebase.auth.kAuthErrorInvalidMessagePayload)
  public static let invalidPhoneNumber: Self = .init(firebase.auth.kAuthErrorInvalidPhoneNumber)
  public static let missingPhoneNumber: Self = .init(firebase.auth.kAuthErrorMissingPhoneNumber)
  public static let invalidRecipientEmail: Self = .init(firebase.auth.kAuthErrorInvalidRecipientEmail)
  public static let invalidSender: Self = .init(firebase.auth.kAuthErrorInvalidSender)
  public static let invalidVerificationCode: Self = .init(firebase.auth.kAuthErrorInvalidVerificationCode)
  public static let invalidVerificationID: Self = .init(firebase.auth.kAuthErrorInvalidVerificationId)
  public static let missingVerificationCode: Self = .init(firebase.auth.kAuthErrorMissingVerificationCode)
  public static let missingVerificationID: Self = .init(firebase.auth.kAuthErrorMissingVerificationId)
  public static let missingEmail: Self = .init(firebase.auth.kAuthErrorMissingEmail)
  public static let missingPassword: Self = .init(firebase.auth.kAuthErrorMissingPassword)
  public static let quotaExceeded: Self = .init(firebase.auth.kAuthErrorQuotaExceeded)
  public static let retryPhoneAuth: Self = .init(firebase.auth.kAuthErrorRetryPhoneAuth)
  public static let sessionExpired: Self = .init(firebase.auth.kAuthErrorSessionExpired)
  public static let appNotVerified: Self = .init(firebase.auth.kAuthErrorAppNotVerified)
  public static let appVerificationUserInteractionFailure: Self = .init(firebase.auth.kAuthErrorAppVerificationFailed)
  public static let captchaCheckFailed: Self = .init(firebase.auth.kAuthErrorCaptchaCheckFailed)
  public static let invalidAppCredential: Self = .init(firebase.auth.kAuthErrorInvalidAppCredential)
  public static let missingAppCredential: Self = .init(firebase.auth.kAuthErrorMissingAppCredential)
  public static let invalidClientID: Self = .init(firebase.auth.kAuthErrorInvalidClientId)
  public static let invalidContinueURI: Self = .init(firebase.auth.kAuthErrorInvalidContinueUri)
  public static let missingContinueURI: Self = .init(firebase.auth.kAuthErrorMissingContinueUri)
  public static let keychainError: Self = .init(firebase.auth.kAuthErrorKeychainError)
  public static let missingAppToken: Self = .init(firebase.auth.kAuthErrorMissingAppToken)
  public static let missingIosBundleID: Self = .init(firebase.auth.kAuthErrorMissingIosBundleId)
  public static let notificationNotForwarded: Self = .init(firebase.auth.kAuthErrorNotificationNotForwarded)
  public static let unauthorizedDomain: Self = .init(firebase.auth.kAuthErrorUnauthorizedDomain)
  public static let webContextAlreadyPresented: Self = .init(firebase.auth.kAuthErrorWebContextAlreadyPresented)
  public static let webContextCancelled: Self = .init(firebase.auth.kAuthErrorWebContextCancelled)
  public static let dynamicLinkNotActivated: Self = .init(firebase.auth.kAuthErrorDynamicLinkNotActivated)
  public static let cancelled: Self = .init(firebase.auth.kAuthErrorCancelled)
  public static let invalidProviderID: Self = .init(firebase.auth.kAuthErrorInvalidProviderId)
  public static let webInternalError: Self = .init(firebase.auth.kAuthErrorWebInternalError)
  // There's a typo in the Firebase error, carrying it over here.
  public static let webStorateUnsupported: Self = .init(firebase.auth.kAuthErrorWebStorateUnsupported)
  public static let tenantIDMismatch: Self = .init(firebase.auth.kAuthErrorTenantIdMismatch)
  public static let unsupportedTenantOperation: Self = .init(firebase.auth.kAuthErrorUnsupportedTenantOperation)
  public static let invalidDynamicLinkDomain: Self = .init(firebase.auth.kAuthErrorInvalidLinkDomain)
  public static let rejectedCredential: Self = .init(firebase.auth.kAuthErrorRejectedCredential)
  public static let phoneNumberNotFound: Self = .init(firebase.auth.kAuthErrorPhoneNumberNotFound)
  public static let invalidTenantID: Self = .init(firebase.auth.kAuthErrorInvalidTenantId)
  public static let missingClientIdentifier: Self = .init(firebase.auth.kAuthErrorMissingClientIdentifier)
  public static let missingMultiFactorSession: Self = .init(firebase.auth.kAuthErrorMissingMultiFactorSession)
  public static let missingMultiFactorInfo: Self = .init(firebase.auth.kAuthErrorMissingMultiFactorInfo)
  public static let invalidMultiFactorSession: Self = .init(firebase.auth.kAuthErrorInvalidMultiFactorSession)
  public static let multiFactorInfoNotFound: Self = .init(firebase.auth.kAuthErrorMultiFactorInfoNotFound)
  public static let adminRestrictedOperation: Self = .init(firebase.auth.kAuthErrorAdminRestrictedOperation)
  public static let unverifiedEmail: Self = .init(firebase.auth.kAuthErrorUnverifiedEmail)
  public static let secondFactorAlreadyEnrolled: Self = .init(firebase.auth.kAuthErrorSecondFactorAlreadyEnrolled)
  public static let maximumSecondFactorCountExceeded: Self = .init(firebase.auth.kAuthErrorMaximumSecondFactorCountExceeded)
  public static let unsupportedFirstFactor: Self = .init(firebase.auth.kAuthErrorUnsupportedFirstFactor)
  public static let emailChangeNeedsVerification: Self = .init(firebase.auth.kAuthErrorEmailChangeNeedsVerification)
  #if INTERNAL_EXPERIMENTAL
  public static let invalidEventHandler: Self = .init(firebase.auth.kAuthErrorInvalidEventHandler)
  public static let federatedProviderAlreadyInUse: Self = .init(firebase.auth.kAuthErrorFederatedProviderAlreadyInUse)
  public static let invalidAuthenticatedUserData: Self = .init(firebase.auth.kAuthErrorInvalidAuthenticatedUserData)
  public static let federatedSignInUserInteractionFailure: Self = .init(firebase.auth.kAuthErrorFederatedSignInUserInteractionFailure)
  public static let missingOrInvalidNonce: Self = .init(firebase.auth.kAuthErrorMissingOrInvalidNonce)
  public static let userCancelled: Self = .init(firebase.auth.kAuthErrorUserCancelled)
  public static let unsupportedPassthroughOperation: Self = .init(firebase.auth.kAuthErrorUnsupportedPassthroughOperation)
  public static let tokenRefreshUnavailable: Self = .init(firebase.auth.kAuthErrorTokenRefreshUnavailable)
  #endif

  // Errors that are not represented in the C++ SDK, but are
  // present in the reference API.
  public static let missingAndroidPackageName: Self = .init(rawValue: 17037)
  public static let webNetworkRequestFailed: Self = .init(rawValue: 17061)
  public static let webSignInUserInteractionFailure: Self = .init(rawValue: 17063)
  public static let localPlayerNotAuthenticated: Self = .init(rawValue: 17066)
  public static let nullUser: Self = .init(rawValue: 17067)
  public static let gameKitNotLinked: Self = .init(rawValue: 17076)
  public static let secondFactorRequired: Self = .init(rawValue: 17078)
  public static let blockingCloudFunctionError: Self = .init(rawValue: 17105)
  public static let internalError: Self = .init(rawValue: 17999)
  public static let malformedJWT: Self = .init(rawValue: 18000)
}

extension AuthErrorCode: Equatable {}

extension AuthErrorCode {
  public typealias Code = AuthErrorCode

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
