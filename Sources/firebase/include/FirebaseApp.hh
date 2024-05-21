// SPDX-License-Identifier: BSD-3-Clause

#ifndef firebase_include_FirebaseApp_hh
#define firebase_include_FirebaseApp_hh

#include <iostream>

#include <firebase/app.h>
#include <firebase/log.h>

namespace firebase {

//typedef int LogLevel;

typedef void (*LogCallback)(LogLevel log_level, const char* log_message,
                            void* callback_data);
// Set the log callback.
void LogSetCallback(LogCallback callback, void* callback_data);

} //

namespace swift_firebase::swift_cxx_shims::firebase::app {

void LogPrint(::firebase::LogLevel log_level, const char* log_message, void* callback_data) {
  std::cout << ">>> firebase log: " << log_message << std::endl;
}

inline void
hook_firebase_log() {
  ::firebase::LogSetCallback(LogPrint, nullptr);
}

} // 

#endif
