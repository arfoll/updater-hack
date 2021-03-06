// Copyright 2017 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "bsdiff/bz2_decompressor.h"

#include <algorithm>
#include <limits>

#include <bzlib.h>

#include "bsdiff/logging.h"

namespace bsdiff {

BZ2Decompressor::~BZ2Decompressor() {
  // Release the memory on destruction if needed.
  if (stream_initialized_)
    BZ2_bzDecompressEnd(&stream_);
}

bool BZ2Decompressor::SetInputData(const uint8_t* input_data, size_t size) {
  // TODO(xunchang) update the avail_in for size > 2GB.
  if (size > std::numeric_limits<unsigned int>::max()) {
    LOG(ERROR) << "Oversized input data" << size;
    return false;
  }

  stream_.next_in = reinterpret_cast<char*>(const_cast<uint8_t*>(input_data));
  stream_.avail_in = size;
  stream_.bzalloc = nullptr;
  stream_.bzfree = nullptr;
  stream_.opaque = nullptr;
  int bz2err = BZ2_bzDecompressInit(&stream_, 0, 0);
  if (bz2err != BZ_OK) {
    LOG(ERROR) << "Failed to bzinit control stream: " << bz2err;
    return false;
  }
  stream_initialized_ = true;
  return true;
}

bool BZ2Decompressor::Read(uint8_t* output_data, size_t bytes_to_output) {
  if (!stream_initialized_) {
    LOG(ERROR) << "BZ2Decompressor not initialized";
    return false;
  }
  stream_.next_out = reinterpret_cast<char*>(output_data);
  while (bytes_to_output > 0) {
    size_t output_size = std::min<size_t>(
        std::numeric_limits<unsigned int>::max(), bytes_to_output);
    stream_.avail_out = output_size;

    size_t prev_avail_in = stream_.avail_in;
    int bz2err = BZ2_bzDecompress(&stream_);
    if (bz2err != BZ_OK && bz2err != BZ_STREAM_END) {
      LOG(ERROR) << "Failed to decompress " << output_size
                 << " bytes of data, error: " << bz2err;
      return false;
    }
    bytes_to_output -= (output_size - stream_.avail_out);
    if (bytes_to_output && prev_avail_in == stream_.avail_in &&
        output_size == stream_.avail_out) {
      LOG(ERROR) << "BZ2Decompressor made no progress, pending "
                 << bytes_to_output << " bytes to decompress";
      return false;
    }
  }
  return true;
}

bool BZ2Decompressor::Close() {
  if (!stream_initialized_) {
    LOG(ERROR) << "BZ2Decompressor not initialized";
    return false;
  }
  int bz2err = BZ2_bzDecompressEnd(&stream_);
  if (bz2err != BZ_OK) {
    LOG(ERROR) << "BZ2_bzDecompressEnd returns with " << bz2err;
    return false;
  }
  stream_initialized_ = false;
  return true;
}

}  // namespace bsdiff
