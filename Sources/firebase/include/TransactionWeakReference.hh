#ifndef firebase_include_TransactionWeakReference_hh
#define firebase_include_TransactionWeakReference_hh

#include <memory>

namespace swift_firebase::swift_cxx_shims::firebase::firestore {

// Transaction is non-copyable so we need a wrapper type that is copyable.
// This type will hold a valid Transaction during the scope of a RunTransaction
// callback (see Firestore+Swift.swift for details).
class TransactionWeakReference {
 public:
  ~TransactionWeakReference() = default;

  TransactionWeakReference(const TransactionWeakReference& other)
      : container_(other.container_) {}
  TransactionWeakReference& operator=(const TransactionWeakReference& other) {
    container_ = other.container_;
    return *this;
  }

  TransactionWeakReference(::firebase::firestore::Transaction* transaction = nullptr)
      : container_(std::make_shared<Container>(transaction)) {}
  void reset() {
    container_->transaction = nullptr;
  }

 private:
  struct Container {
    Container(::firebase::firestore::Transaction* transaction)
        : transaction(transaction) {}
    ::firebase::firestore::Transaction* transaction;
  };
  std::shared_ptr<Container> container_;
};

} // namespace swift_firebase::swift_cxx_shims::firebase::firestore

#endif
