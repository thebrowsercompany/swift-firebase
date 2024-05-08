// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

import CxxShim

public class HTTPSCallableResult {
  let impl: firebase.functions.HttpsCallableResult

  init(_ impl: firebase.functions.HttpsCallableResult = .init()) {
    self.impl = impl
  }
}
