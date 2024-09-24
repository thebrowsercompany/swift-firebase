// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

import CxxShim

public class Functions {
  let impl: swift_firebase.swift_cxx_shims.firebase.functions.FunctionsRef

  init(_ impl: swift_firebase.swift_cxx_shims.firebase.functions.FunctionsRef) {
    self.impl = impl
  }

  public static func functions(app: FirebaseApp) -> Functions {
#if os(Android)
    let appp = app.pointer
#else
    let appp = app
#endif
    let instance = swift_firebase.swift_cxx_shims.firebase.functions.functions_get_instance(appp)
    guard swift_firebase.swift_cxx_shims.firebase.functions.functions_is_valid(instance) else {
      fatalError("Invalid Functions Instance")
    }
    return .init(instance)
  }

  public func httpsCallable(_ name: String) -> HTTPSCallable {
    .init(swift_firebase.swift_cxx_shims.firebase.functions.functions_get_https_callable(impl, name))
  }
}
