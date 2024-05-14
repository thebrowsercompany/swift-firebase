// SPDX-License-Identifier: BSD-3-Clause

#ifndef firebase_include_FirebaseStorage_hh
#define firebase_include_FirebaseStorage_hh

#include <memory>

#include <firebase/storage.h>
#include <firebase/storage/storage_reference.h>

#include "FirebaseCore.hh"

namespace swift_firebase::swift_cxx_shims::firebase::storage {

typedef std::shared_ptr<::firebase::storage::Storage> StorageRef;

inline bool
storage_is_valid(const StorageRef& ref) {
  return ref.operator bool();
}

inline StorageRef
storage_get_instance(::firebase::App* app) {
  return StorageRef(::firebase::storage::Storage::GetInstance(app));
}

inline ::firebase::storage::StorageReference
storage_get_reference(const StorageRef& ref, const char* path) {
  return ref->GetReference(path);
}

/*
inline ::firebase::functions::HttpsCallableReference
functions_get_https_callable(StorageRef ref, const char* name) {
  return ref.get()->GetHttpsCallable(name);
}

inline ::swift_firebase::swift_cxx_shims::firebase::Future<
    ::firebase::functions::HttpsCallableResult>
https_callable_call(::firebase::functions::HttpsCallableReference ref) {
  return ref.Call();
}
*/

inline ::swift_firebase::swift_cxx_shims::firebase::Future<::std::string>
storage_reference_get_download_url(::firebase::storage::StorageReference ref) {
  return ref.GetDownloadUrl();
}

/*
inline ::firebase::Variant
https_callable_result_data(
    const ::firebase::functions::HttpsCallableResult& result) {
  return result.data();
}
*/

} // namespace swift_firebase::swift_cxx_shims::firebase::functions

#endif
