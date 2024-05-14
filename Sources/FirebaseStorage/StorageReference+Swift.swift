// SPDX-License-Identifier: BSD-3-Clause

@_exported
import firebase
@_spi(FirebaseInternal)
import FirebaseCore

import CxxShim
import Foundation

public class StorageReference {
  let impl: firebase.storage.StorageReference

  init(_ impl: firebase.storage.StorageReference) {
    self.impl = impl
  }

  public func child(_ path: String) -> StorageReference {
    .init(impl.Child(path))
  }

  public func downloadURL(completion: @escaping (URL?, Error?) -> Void) {
    downloadURLImpl() { result, error in
      DispatchQueue.main.async {
        completion(result, error)
      }
    }
  }

  public func downloadURL() async throws -> URL {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<URL, any Error>) in
      downloadURLImpl() { result, error in
        if let error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: result!)
        }
      }
    }
  }

  private func downloadURLImpl(completion: @escaping (URL?, Error?) -> Void) {
    let future = swift_firebase.swift_cxx_shims.firebase.storage.storage_reference_get_download_url(impl)
    future.setCompletion({
      let (result, error) = future.resultAndError { StorageErrorCode($0) }
      completion(result.flatMap { .init(string: String($0)) }, error)
    })
  }

  public func putDataAsync(
    _ uploadData: Data,
    metadata: StorageMetadata? = nil,
    onProgress: ((Progress?) -> Void)? = nil
  ) async throws -> StorageMetadata {
    try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<StorageMetadata, any Error>) in
      uploadData.withUnsafeBytes { ptr in
        let future = swift_firebase.swift_cxx_shims.firebase.storage.storage_reference_put_bytes(
          self.impl, ptr.baseAddress!.assumingMemoryBound(to: UInt8.self), uploadData.count
          // XXX support `metadata`
          // XXX support `onProgress`
        )
        future.setCompletion({
          let (result, error) = future.resultAndError { StorageErrorCode($0) }
          if let error {
            continuation.resume(throwing: error)
          } else {
            continuation.resume(returning: result.map { .init($0) } ?? .init())
          }
        })
      }
    }
  }
}
