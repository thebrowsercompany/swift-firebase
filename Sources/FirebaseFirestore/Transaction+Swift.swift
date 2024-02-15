// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase

import CxxShim

public typealias Transaction = swift_firebase.swift_cxx_shims.firebase.firestore.TransactionWeakReference

extension Transaction {
  /*
  public func setData(_ data: [String : Any], forDocument document: DocumentReference) -> Transaction {
  }

  public func setData(_ data: [String : Any], forDocument document: DocumentReference, merge: Bool) -> Transaction {
  }

  public func setData(_ data: [String : Any], forDocument document: DocumentReference, mergeFields: [Any]) -> Transaction {
  }

  public func updateData(_ fields: [AnyHashable : Any], forDocument document: DocumentReference) -> Transaction {
  }

  public func deleteDocument(_ document: DocumentReference) -> Transaction {
  }

  public func getDocument(_ document: DocumentReference) throws -> DocumentSnapshot {
  }
  */
}
