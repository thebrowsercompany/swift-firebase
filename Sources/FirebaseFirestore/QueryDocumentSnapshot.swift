// SPDX-License-Identifier: BSD-3-Clause

public struct QueryDocumentSnapshot {
  private let snapshot: DocumentSnapshot

  internal init(snapshot: DocumentSnapshot) {
    self.snapshot = snapshot
  }

  func data() -> [String : Any] {
    snapshot.data()!
  }

  func data(with serverTimestampBehavior: ServerTimestampBehavior) -> [String : Any] {
    snapshot.data(with: serverTimestampBehavior)!
  }
}
