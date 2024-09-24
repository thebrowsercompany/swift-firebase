// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase

#if os(Android)
private import FirebaseAndroid
#endif

#if os(Android)
public struct FirebaseApp {
  public init(_ p: UnsafeMutablePointer<firebase.App>) {
    self.pointer = p
  }

  @_alwaysEmitIntoClient
  public var pointee: firebase.App {
    @_transparent unsafeAddress {
      return UnsafePointer<firebase.App>(pointer)
    }
    @_transparent unsafeMutableAddress {
      return pointer
    }
  }

  public var pointer: UnsafeMutablePointer<firebase.App>
}
#else

public typealias FirebaseApp = UnsafeMutablePointer<firebase.App>

#endif

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
#if os(Android)
    firebase.App.GetInstance().flatMap(FirebaseApp.init)
#else
    firebase.App.GetInstance()
#endif
  }

  public static func app(name: String) -> FirebaseApp? {
#if os(Android)
    firebase.App.GetInstance(name).flatMap(FirebaseApp.init)
#else
    firebase.App.GetInstance(name)
#endif
  }

  public static var allApps: [String:FirebaseApp]? {
    let applications = firebase.App.GetApps()
    guard !applications.isEmpty else { return nil }
    return .init(uniqueKeysWithValues: applications.compactMap { (app: UnsafeMutablePointer<firebase.App>?) -> (String, FirebaseApp)? in
        guard let application = app else { return nil }
  #if os(Android)
        let app = FirebaseApp(application)
        return (app.name, app)
  #else
        return (application.name, application)
  #endif
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
