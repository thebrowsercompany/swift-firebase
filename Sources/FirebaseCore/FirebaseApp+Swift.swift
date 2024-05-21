// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase

import CxxShim

#if os(Android)
private import FirebaseAndroid
#endif

public typealias FirebaseApp = UnsafeMutablePointer<firebase.App>

extension FirebaseApp {
  public static func configure() {
#if os(Android)
    _ = firebase.App.Create(SwiftFirebase_GetJavaEnvironment(),
                            SwiftFirebase_GetActivity())
#else
    _ = firebase.App.Create()
#endif
  }

  public static func configure(options: FirebaseOptions) {
#if os(Android)
    _ = firebase.App.Create(options.pointee, SwiftFirebase_GetJavaEnvironment(),
                            SwiftFirebase_GetActivity())
#else
    _ = firebase.App.Create(options.pointee)
#endif
  }

  public static func configure(name: String, options: FirebaseOptions) {
#if os(Android)
    _ = firebase.App.Create(options.pointee, name,
                            SwiftFirebase_GetJavaEnvironment(),
                            SwiftFirebase_GetActivity())
#else
    _ = firebase.App.Create(options.pointee, name)
#endif
  }

  public static func app() -> FirebaseApp? {
    firebase.App.GetInstance()
  }

  public static func app(name: String) -> FirebaseApp? {
    swift_firebase.swift_cxx_shims.firebase.app.hook_firebase_log()
    return firebase.App.GetInstance(name)

  }

  public static var allApps: [String:FirebaseApp]? {
    let applications = firebase.App.GetApps()
    guard !applications.isEmpty else { return nil }
    return .init(uniqueKeysWithValues: applications.compactMap {
        guard let application = $0 else { return nil }
        return (application.name, application)
    })
  }

  public func delete() async -> Bool {
    fatalError("\(#function) not yet implemented")
  }

  public var name: String {
    String(cString: self.pointee.__nameUnsafe()!)
  }

  public var options: UnsafePointer<firebase.AppOptions> {
    // TODO(compnerd) ensure that the `FirebaseOptions` API is applied to this.
    self.pointee.__optionsUnsafe()
  }

  public var isDataCollectionDefaultEnabled: Bool {
    get { self.pointee.IsDataCollectionDefaultEnabled() }
    set { self.pointee.SetDataCollectionDefaultEnabled(newValue) }
  }
}
