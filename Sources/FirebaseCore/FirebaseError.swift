// SPDX-License-Identifier: BSD-3-Clause

public protocol FirebaseError: Error {
  init(code: Int32, message: String)
}
