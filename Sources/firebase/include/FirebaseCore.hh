#ifndef firebase_include_FirebaseCore_hh
#define firebase_include_FirebaseCore_hh

#include <firebase/util.h>

#include <stdio.h>

namespace swift_firebase::swift_cxx_shims::firebase {

typedef void (*FutureCompletionType)(void*);

// This class exists to provide protocol conformance to FutureProtocol.  It
// also provides a method to invoke `OnCompletion` in a way that works from
// Swift. We can ignore the `FutureBase` param as the Swift caller can just
// retain the Future as part of its closure.
template <class R>
class __attribute__((swift_attr("conforms_to:FirebaseCore.FutureProtocol")))
  Future : public ::firebase::Future<R> {
 public:
  typedef R ResultType;

  Future(const ::firebase::Future<R>& rhs) : ::firebase::Future<R>(rhs) {}

  // Allow explicit conversion from `Future<void>` in support of `VoidFuture`.
  static Future From(const ::firebase::Future<void>& other) {
    return Future(*reinterpret_cast<const ::firebase::Future<R>*>(&other));
  }
  
  void OnCompletion(
      _Nonnull FutureCompletionType completion,
      _Nullable void* user_data) const {
    ::firebase::FutureBase::OnCompletion(
        [completion, user_data](const FutureBase&) {
          completion(user_data);
        });
  }
};

// As a workaround, use `int` here instead of `void` for futures with no
// result. Swift is not able to handle a `ResultType` of `void`.
typedef Future<int> VoidFuture;

} // namespace swift_firebase::swift_cxx_shims::firebase

#endif
