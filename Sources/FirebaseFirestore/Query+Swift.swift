// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

import CxxShim
import Foundation

public typealias Query = firebase.firestore.Query

extension Query {
  public var firestore: Firestore {
    swift_firebase.swift_cxx_shims.firebase.firestore.query_firestore(self)
  }

  // This variant is provided for compatibility with the ObjC API.
  public func getDocuments(source: FirestoreSource = .default, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.firestore.query_get(self, source)
    future.setCompletion({
      let (snapshot, error) = future.resultAndError
      DispatchQueue.main.async {
        completion(snapshot, error)
      }
    })
  }

  public func getDocuments(source: FirestoreSource = .default) async throws -> QuerySnapshot {
    try await withCheckedThrowingContinuation { continuation in
      let future = swift_firebase.swift_cxx_shims.firebase.firestore.query_get(self, source)
      future.setCompletion({
        let (snapshot, error) = future.resultAndError
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: snapshot ?? .init())
        }
      })
    }
  }

  public func addSnapshotListener(_ listener: @escaping (QuerySnapshot?, Error?) -> Void) -> ListenerRegistration {
    addSnapshotListener(includeMetadataChanges: false, listener: listener)
  }

  public func addSnapshotListener(includeMetadataChanges: Bool, listener: @escaping (QuerySnapshot?, Error?) -> Void) -> ListenerRegistration {
    typealias ListenerCallback = (QuerySnapshot?, Error?) -> Void
    let boxed = Unmanaged.passRetained(listener as AnyObject)
    let instance = swift_firebase.swift_cxx_shims.firebase.firestore.query_add_snapshot_listener(self, { snapshot, errorCode, errorMessage, pvListener in
      let callback = Unmanaged<AnyObject>.fromOpaque(pvListener!).takeUnretainedValue() as! ListenerCallback

      let error = NSError.firestore(errorCode, errorMessage: errorMessage)
      // We only return a snapshot if the error code isn't 0 (aka the 'ok' error code)
      let returned = error == nil ? snapshot?.pointee : nil

      // Make sure we dispatch our callback back into the main thread to keep consistent
      // with the reference API which will call back on the 'user_executor' which typically
      // ends up being the main queue.
      // Relevant code:
      // - https://github.com/firebase/firebase-ios-sdk/blob/main/Firestore/Source/API/FIRFirestore.mm#L210-L218
      // - https://github.com/firebase/firebase-ios-sdk/blob/main/Firestore/core/src/api/document_reference.cc#L236-L237
      DispatchQueue.main.async {
        callback(returned, error)
      }
    }, UnsafeMutableRawPointer(boxed.toOpaque()))

    return ListenerRegistration(boxed, instance)
  }
}
