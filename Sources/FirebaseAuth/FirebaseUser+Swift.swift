// SPDX-License-Identifier: BSD-3-Clause

import CxxStdlib
import Foundation

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

import CxxShim

public typealias AuthResult = firebase.auth.AuthResult

public protocol UserInfo {
  var providerID: String { get }
  var uid: String { get }
  var displayName: String? { get }
  var photoURL: URL? { get }
  var email: String? { get }
  var phoneNumber: String? { get }
}

// TODO(WPP-1581): Improve the API to match the ObjC one better.
public final class User {
  let impl: firebase.auth.User

  init(_ impl: firebase.auth.User) {
    self.impl = impl
  }

  public var isAnonymous: Bool {
    impl.is_anonymous()
  }

  public var isEmailVerified: Bool {
    impl.is_email_verified()
  }

  public var refreshToken: String? {
    fatalError("\(#function) not yet implemented")
  }

  // public var providerData: [UserInfo] {
  //   fatalError("\(#function) not yet implemented")
  // }

  // public var metadata: UserMetadata {
  //   fatalError("\(#function) not yet implemented")
  // }

  public var tenantID: String? {
    fatalError("\(#function) not yet implemented")
  }

  // public var multiFactor: MultiFactor {
  //   fatalError("\(#function) not yet implemented")
  // }

  public func updateEmail(to email: String) async throws {
    fatalError("\(#function) not yet implemented")
  }

  public func updatePassword(to password: String) async throws {
    fatalError("\(#function) not yet implemented")
  }

  // public func updatePhoneNumber(_ credential: PhoneAuthCredential) async throws {
  //   fatalError("\(#function) not yet implemented")
  // }

  // public func createProfileChangeRequest() -> UserProfileChangeRequest {
  //   fatalError("\(#function) not yet implemented")
  // }

  public func reload(completion: ((Error?) -> Void)?) {
    reloadImpl() { error in
      if let completion {
        DispatchQueue.main.async {
          completion(error)
        }
      }
    }
  }

  public func reload() async throws {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
      reloadImpl() { error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume()
        }
      }
    }
  }

  private func reloadImpl(completion: @escaping (Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.auth.user_reload(impl)
    future.setCompletion({
      let (_, error) = future.resultAndError { AuthErrorCode($0) }
      completion(error)
    })
  }

  public func reauthenticate(with credential: Credential, completion: ((AuthResult?, Error?) -> Void)?) {
    reauthenticateImpl(with: credential) { result, error in
      if let completion {
        DispatchQueue.main.async {
          completion(result, error)
        }
      }
    }
  }

  public func reauthenticate(with credential: Credential) async throws {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
      reauthenticateImpl(with: credential) { result, error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume()
        }
      }
    }
  }

  public func reauthenticateImpl(with credential: Credential, completion: @escaping (AuthResult?, Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.auth.user_reauthenticate_and_retrieve_data(impl, credential)
    future.setCompletion({
      let (result, error) = future.resultAndError { AuthErrorCode($0) }
      completion(result, error)
    })
  }

  // -reauthenticateWithProvider:UIDelegate:completion:

  public func getIDTokenResult() async throws -> AuthTokenResult {
    return try await getIDTokenResult(forcingRefresh: false)
  }

  public func getIDTokenResult(forcingRefresh forceRefresh: Bool) async throws
      -> AuthTokenResult {
    return try await AuthTokenResult(idTokenForcingRefresh(forceRefresh))
  }

  public func getIDToken(completion: ((String?, Error?) -> Void)?) {
    idTokenForcingRefresh(false, completion: completion)
  }

  public func getIDToken() async throws -> String {
    return try await idTokenForcingRefresh(false)
  }

  public func idTokenForcingRefresh(_ forceRefresh: Bool, completion: ((String?, Error?) -> Void)?) {
    idTokenForcingRefreshImpl(forceRefresh) { result, error in
      if let completion {
        DispatchQueue.main.async {
          completion(result, error)
        }
      }
    }
  }

  public func idTokenForcingRefresh(_ forceRefresh: Bool) async throws
      -> String {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String, any Error>) in
      idTokenForcingRefreshImpl(forceRefresh) { result, error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: result ?? .init())
        }
      }
    }
  }

  private func idTokenForcingRefreshImpl(_ forceRefresh: Bool, completion: @escaping (String?, Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.auth.user_get_token(impl, forceRefresh)
    future.setCompletion({
      let (result, error) = future.resultAndError { AuthErrorCode($0) }
      let stringResult: String?
      if let result {
        stringResult = String(result)
      } else {
        stringResult = nil
      }
      completion(stringResult, error)
    })
  }

  // public func link(with credential: AuthCredential) async throws
  //     -> AuthDataResult {
  //   fatalError("\(#function) not yet implemented")
  // }

  // -linkWithProvider:UIDelegate:completion

  public func unlink(from provider: String) async throws -> User {
    fatalError("\(#function) not yet implemented")
  }

  public func sendEmailVerification(completion: ((Error?) -> Void)?) {
    sendEmailVerificationImpl() { error in
      if let completion {
        DispatchQueue.main.async {
          completion(error)
        }
      }
    }
  }

  public func sendEmailVerification() async throws {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
      sendEmailVerificationImpl() { error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume()
        }
      }
    }
  }

  public func sendEmailVerificationImpl(completion: @escaping (Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.auth.user_send_email_verification(impl)
    future.setCompletion({
      let (_, error) = future.resultAndError { AuthErrorCode($0) }
      completion(error)
    })
  }

  // public func sendEmailVerification(with actionCodeSettings: ActionCodeSettings) async throws {
  //   fatalError("\(#function) not yet implemented")
  // }

  public func delete(completion: ((Error?) -> Void)?) {
    deleteImpl() { error in
      if let completion {
        DispatchQueue.main.async {
          completion(error)
        }
      }
    }
  }

  public func delete() async throws {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, any Error>) in
      deleteImpl() { error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume()
        }
      }
    }
  }

  private func deleteImpl(completion: @escaping (Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.auth.user_delete(impl)
    future.setCompletion({
      let (_, error) = future.resultAndError { AuthErrorCode($0) }
      completion(error)
    })
  }

  public func sendEmailVerification(beforeUpdatingEmail email: String) async throws {
    fatalError("\(#function) not yet implemented")
  }

  // public func sendEmailVerification(beforeUpdatingEmail email: String,
  //                                   actionCodeSettings: ActionCodeSettings) async throws {
  //   fatalError("\(#function) not yet implemented")
  // }
}

extension User: UserInfo {
  public var providerID: String {
    String(swift_firebase.swift_cxx_shims.firebase.auth.user_provider_id(impl))
  }

  public var uid: String {
    String(swift_firebase.swift_cxx_shims.firebase.auth.user_uid(impl))
  }

  public var displayName: String? {
    let name = String(swift_firebase.swift_cxx_shims.firebase.auth.user_display_name(impl))
    return name.isEmpty ? nil : name
  }

  public var photoURL: URL? {
    let url = String(swift_firebase.swift_cxx_shims.firebase.auth.user_photo_url(impl))
    return url.isEmpty ? nil : URL(string: url)
  }

  public var email: String? {
    let email = String(swift_firebase.swift_cxx_shims.firebase.auth.user_email(impl))
    return email.isEmpty ? nil : email
  }

  public var phoneNumber: String? {
    let number = String(swift_firebase.swift_cxx_shims.firebase.auth.user_phone_number(impl))
    return number.isEmpty ? nil : number
  }
}


import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import Android

func debugLog(_ s: String) {
  __android_log_write(Int32(ANDROID_LOG_DEBUG.rawValue), "swift-firebase", s)
}

public typealias JEnvParam = UnsafeMutablePointer<JNIEnv>

extension String {
  init(_ env: UnsafeMutablePointer<JNIEnv>, _ jstring: jstring) {
    guard let stringPointer = env.pointee.GetStringUTFChars(jstring, nil) else {
      fatalError("failed to get utf8 sequence for a jstring")
    }
    defer {
      env.pointee.ReleaseStringUTFChars(jstring, stringPointer)
    }
    self.init(cString: stringPointer)
  }
}

struct JNICallback_String_to_Void: ~Copyable {
  init(env: UnsafeMutablePointer<JNIEnv>, callback: jobject) {
    assert(Thread.isMainThread)
    var vm: UnsafeMutablePointer<JavaVM>?
    withUnsafeMutablePointer(to: &vm) { (ptr: UnsafeMutablePointer<UnsafeMutablePointer<JavaVM>?>) in
      _ = env.pointee.GetJavaVM(ptr)
    }
    self.vm = vm!
    retainedCallback = env.pointee.NewGlobalRef(callback)
    let functionClass = env.pointee.GetObjectClass(retainedCallback)
    method = env.pointee.GetMethodID(functionClass, "invoke", "(Ljava/lang/Object;)Ljava/lang/Object;")
  }

  deinit {
    var env: UnsafeMutablePointer<JNIEnv>?
    guard withUnsafeMutablePointer(to: &env) { (ptr: UnsafeMutablePointer<UnsafeMutablePointer<JNIEnv>?>) -> jint in
      vm.pointee.AttachCurrentThread(ptr, nil)
    } == JNI_OK else {
      fatalError("failed to aquire jni environment on current thread")
    }
    env!.pointee.DeleteGlobalRef(retainedCallback)
    vm.pointee.DetachCurrentThread()
  }

  func call(_ arg: String) {
    var envOpt: UnsafeMutablePointer<JNIEnv>?
    guard withUnsafeMutablePointer(to: &envOpt) { (ptr: UnsafeMutablePointer<UnsafeMutablePointer<JNIEnv>?>) -> jint in
      vm.pointee.AttachCurrentThread(ptr, nil)
    } == JNI_OK else {
      fatalError("failed to aquire jni environment on current thread")
    }
    let env = envOpt!
    guard let javaArg = env.pointee.NewStringUTF(arg) else {
      fatalError("failed to create a java string from \(arg)")
    }

    let jo: jobject = jobject(OpaquePointer(javaArg))
    var jv = jvalue()
    let result: jobject? = withUnsafeMutablePointer(to: &jv) { argPtr in
      // assing the first argument value
      UnsafeMutableRawPointer(argPtr).assumingMemoryBound(to: jobject.self).pointee = jo
      // invoke the callback method
      return env.pointee.CallObjectMethodA(retainedCallback, method, argPtr)
    }
    env.pointee.DeleteLocalRef(jo)
    if let result {
      env.pointee.DeleteLocalRef(result)
    }
    vm.pointee.DetachCurrentThread()
  }

  let vm: UnsafeMutablePointer<JavaVM>
  let retainedCallback: jobject
  let method: jmethodID
}

public func firebaseSignInAndFetch(user: String, password: String, callback: @escaping (String) async -> ()) {
  debugLog("firebase sign-in test with '\(user)'")
  let options = FirebaseOptions.defaultOptions()
  FirebaseApp.configure(options: options)
  guard let app = FirebaseApp.app() else {
    return
  }
  debugLog("firebase application aquired")
  Task {
    do {
      _ = try await Auth.auth().signIn(withEmail: user, password: password)
      debugLog("sign in succeded!")
      guard let user = Auth.auth().currentUser else {
        debugLog("error: failed to get the current user!")
        return
      }
      let firestore = Firestore.firestore()
      let document = firestore
        .collection("users")
        .document(user.uid)
      let snapshot = try await document.getDocument()
      debugLog("user document snapshot aquired: \(snapshot.debugDescription)")
      await callback(snapshot.debugDescription)
    } catch {
      debugLog("error: sign in failed: \(error.localizedDescription)")
    }
  }
}

@_cdecl("Java_com_example_firebasetest_MainActivity_tryFirebase2")//Java_com_thebrowsercompany_SwiftSupportTestApp_MainActivity_tryFirebase")
public func tryFirebaseSigninAndFetch(_ env: UnsafeMutablePointer<JNIEnv>, _ this: jobject, _ user: jstring, _ password: jstring, completionCallback: jobject) {    
  let cb = JNICallback_String_to_Void(env: env, callback: completionCallback)
  firebaseSignInAndFetch(user: String(env, user), password: String(env, password)) { msg in
    cb.call(msg)
    debugLog("all done in swift!")
  }
  debugLog("returned from direct jni call to test firebase interop")
}
