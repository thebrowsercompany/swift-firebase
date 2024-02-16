// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase

import CxxShim
import Foundation

public typealias Transaction = swift_firebase.swift_cxx_shims.firebase.firestore.TransactionWeakReference

extension Transaction {
  public @discardableResult func setData(_ data: [String : Any], forDocument document: DocumentReference) -> Transaction {
    setData(data, forDocument: document, merge: false)
  }

  public @discardableResult func setData(_ data: [String : Any], forDocument document: DocumentReference, merge: Bool) -> Transaction {
    guard is_valid() else { fatalError("Transaction accessed outside of updateBlock") }
    self.Set(document, FirestoreDataConverter.firestoreValue(document: data), merge ? .Merge() : .init())
    return self
  }

  /* TODO: implement
  public @discardableResult func setData(_ data: [String : Any], forDocument document: DocumentReference, mergeFields: [Any]) -> Transaction {
  }
  */

  public @discardableResult func updateData(_ fields: [String : Any], forDocument document: DocumentReference) -> Transaction {
    guard is_valid() else { fatalError("Transaction accessed outside of updateBlock") }
    self.Update(document, FirestoreDataConverter.firestoreValue(document: fields))
    return self
  }

  public @discardableResult func deleteDocument(_ document: DocumentReference) -> Transaction {
    guard is_valid() else { fatalError("Transaction accessed outside of updateBlock") }
    Delete(document)
    return self
  }

  public func getDocument(_ document: DocumentReference) throws -> DocumentSnapshot {
    guard is_valid() else { fatalError("Transaction accessed outside of updateBlock") }

    var error = firebase.firestore.kErrorNone
    var errorMessage = std.string()

    let snapshot = Get(document, &error, &errorMessage)

    if error != firebase.firestore.kErrorNone {
      throw NSError.firestore(error, errorMessage: String(errorMessage))
    }

    return snapshot
  }
}
