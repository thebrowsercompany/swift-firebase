// SPDX-License-Identifier: BSD-3-Clause

// Wraps a DocumentSnapshot providing a `data(with:)` implementation that
// cannot return `nil`.
public struct QueryDocumentSnapshot {
  private let snapshot: DocumentSnapshot

  internal init(snapshot: DocumentSnapshot) {
    self.snapshot = snapshot
  }

  public var reference: DocumentReference {
    snapshot.reference
  }

  public var exists: Bool {
    snapshot.exists
  }

  public var documentID: String {
    snapshot.documentID
  }

  public func data(with serverTimestampBehavior: ServerTimestampBehavior = .default) -> [String : Any] {
    snapshot.data(with: serverTimestampBehavior)! // This should never fail
  }
}
