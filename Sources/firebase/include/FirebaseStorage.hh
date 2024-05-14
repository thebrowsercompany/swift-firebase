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

inline ::swift_firebase::swift_cxx_shims::firebase::Future<::std::string>
storage_reference_get_download_url(::firebase::storage::StorageReference ref) {
  return ref.GetDownloadUrl();
}

typedef std::map<std::string, std::string> CustomMetadata;

inline CustomMetadata
metadata_get_custom_metadata(const ::firebase::storage::Metadata& metadata) {
  return *metadata.custom_metadata();
}

inline CustomMetadata::const_iterator
custom_metadata_begin(const CustomMetadata& custom_metadata) {
  return custom_metadata.begin();
}

inline CustomMetadata::const_iterator
custom_metadata_end(const CustomMetadata& custom_metadata) {
  return custom_metadata.end();
}

inline bool
custom_metadata_iterators_equal(const CustomMetadata::const_iterator& a,
                                const CustomMetadata::const_iterator& b) {
  return a == b;
}

inline const std::string&
custom_metadata_iterator_first(const CustomMetadata::const_iterator& it) {
  it->first;
}

inline const std::string&
custom_metadata_iterator_second(const CustomMetadata::const_iterator& it) {
  it->second;
}

} // namespace swift_firebase::swift_cxx_shims::firebase::functions

#endif
