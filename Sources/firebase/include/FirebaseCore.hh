#ifndef firebase_include_FirebaseCore_hh
#define firebase_include_FirebaseCore_hh

#include <firebase/util.h>

#include <stdio.h>

namespace swift_firebase::swift_cxx_shims::firebase {

typedef void (*FutureCompletionType)(void*);

// This class exists to provide protocol conformance to FutureProtocol.
template <class R> class ConformingFuture: public ::firebase::Future<R> {
 public:
  typedef R ResultType;
  typedef ::firebase::Future<R> FutureType;

  ConformingFuture(const FutureType& rhs) : FutureType(rhs) {}

  void CallOnCompletion(
      _Nonnull FutureCompletionType completion,
      _Nullable void* user_data) const {
    OnCompletion([completion, user_data](const FutureBase&) {
      completion(user_data);
    });
  }
} __attribute__((swift_attr("conforms_to:FirebaseCore.FutureProtocol")));

} // namespace swift_firebase::swift_cxx_shims::firebase

#endif
