// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(Internal)
import FirebaseCore

import CxxShim

public typealias Query = firebase.firestore.Query

extension Query {
  var firestore: Firestore {
    swift_firebase.swift_cxx_shims.firebase.firestore.query_firestore(self)
  }

  func getDocuments(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.firestore.query_get(self, .default)
    future.setCompletion({
      let (snapshot, error) = future.resultAndError
      completion(snapshot, error)
    })
  }

  func getDocuments() async throws -> QuerySnapshot {
    try await withCheckedThrowingContinuation { continuation in
      getDocuments() { snapshot, error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: snapshot ?? .init())
        }
      }
    }
  }
}
