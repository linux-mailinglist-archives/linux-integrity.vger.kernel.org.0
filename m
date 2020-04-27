Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCE1B9FB7
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2020 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0JVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Apr 2020 05:21:09 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34966 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgD0JVJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Apr 2020 05:21:09 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A214072CCDC;
        Mon, 27 Apr 2020 12:20:59 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [83.220.44.62])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5D3284A4AEE;
        Mon, 27 Apr 2020 12:20:59 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v10 2/2] ima-evm-utils: Add sign/verify tests for evmctl
Date:   Mon, 27 Apr 2020 12:20:27 +0300
Message-Id: <20200427092027.8639-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200427092027.8639-1-vt@altlinux.org>
References: <20200427092027.8639-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This commit adds (evm) sign, (evm) verify, ima_sign, and
ima_verify tests for different algos.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tests/Makefile.am      |   7 +-
 tests/gen-keys.sh      |  97 +++++++++++++
 tests/sign_verify.test | 370 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100755 tests/gen-keys.sh
 create mode 100755 tests/sign_verify.test

diff --git a/tests/Makefile.am b/tests/Makefile.am
index e37b958..029f2ff 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,7 +1,12 @@
 check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
-check_SCRIPTS += ima_hash.test
+check_SCRIPTS += ima_hash.test sign_verify.test
 
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
+
+distclean: distclean-keys
+.PHONY: distclean-keys
+distclean-keys:
+	./gen-keys.sh clean
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
new file mode 100755
index 0000000..407876b
--- /dev/null
+++ b/tests/gen-keys.sh
@@ -0,0 +1,97 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate keys for the tests
+#
+# Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+cd "$(dirname "$0")" || exit 1
+PATH=../src:$PATH
+type openssl
+
+log() {
+  echo - "$*"
+  eval "$@"
+}
+
+if [ "$1" = clean ]; then
+  rm -f test-ca.conf
+elif [ "$1" = force ] || [ ! -e test-ca.conf ]; then
+cat > test-ca.conf <<- EOF
+	[ req ]
+	distinguished_name = req_distinguished_name
+	prompt = no
+	string_mask = utf8only
+	x509_extensions = v3_ca
+
+	[ req_distinguished_name ]
+	O = IMA-CA
+	CN = IMA/EVM certificate signing key
+	emailAddress = ca@ima-ca
+
+	[ v3_ca ]
+	basicConstraints=CA:TRUE
+	subjectKeyIdentifier=hash
+	authorityKeyIdentifier=keyid:always,issuer
+EOF
+fi
+
+# RSA
+# Second key will be used for wrong key tests.
+for m in 1024 2048; do
+  if [ "$1" = clean ] || [ "$1" = force ]; then
+    rm -f test-rsa$m.cer test-rsa$m.key test-rsa$m.pub
+  fi
+  if [ "$1" = clean ]; then
+    continue
+  fi
+  if [ ! -e test-rsa$m.key ]; then
+    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
+      -config test-ca.conf \
+      -newkey rsa:$m \
+      -out test-rsa$m.cer -outform DER \
+      -keyout test-rsa$m.key
+    # for v1 signatures
+    log openssl pkey -in test-rsa$m.key -out test-rsa$m.pub -pubout
+  fi
+done
+
+# EC-RDSA
+for m in \
+  gost2012_256:A \
+  gost2012_256:B \
+  gost2012_256:C \
+  gost2012_512:A \
+  gost2012_512:B; do
+    IFS=':' read -r algo param <<< "$m"
+    if [ "$1" = clean ] || [ "$1" = force ]; then
+      rm -f "test-$algo-$param.key" "test-$algo-$param.cer" "test-$algo-$param.pub"
+    fi
+    if [ "$1" = clean ]; then
+      continue
+    fi
+    [ -e "test-$algo-$param.key" ] && continue
+    log openssl req -nodes -x509 -utf8 -days 10000 -batch \
+      -config test-ca.conf \
+      -newkey "$algo" \
+      -pkeyopt "paramset:$param" \
+      -out    "test-$algo-$param.cer" -outform DER \
+      -keyout "test-$algo-$param.key"
+    if [ -s "test-$algo-$param.key" ]; then
+      log openssl pkey -in "test-$algo-$param.key" -out "test-$algo-$param.pub" -pubout
+    fi
+done
+
+# This script leaves test-ca.conf, *.cer, *.pub, *.key files for sing/verify tests.
+# They are never deleted except by `make distclean'.
+
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
new file mode 100755
index 0000000..118c3f6
--- /dev/null
+++ b/tests/sign_verify.test
@@ -0,0 +1,370 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# evmctl {,ima_}{sign,verify} tests
+#
+# Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+cd "$(dirname "$0")" || exit 1
+PATH=../src:$PATH
+source ./functions.sh
+_require evmctl openssl xxd getfattr
+./gen-keys.sh >/dev/null 2>&1
+
+trap _report_exit EXIT
+set -f # disable globbing
+
+# Determine keyid from a cert
+_keyid_from_cert() {
+  local cer=${1%.*}.cer cmd
+  local tmp
+
+  cer=test-${cer#test-}
+  # shellcheck disable=SC2086
+  cmd="openssl x509 $OPENSSL_ENGINE \
+          -in $cer -inform DER -pubkey -noout"
+  id=$($cmd 2>/dev/null \
+    | openssl asn1parse \
+    | grep BIT.STRING \
+    | cut -d: -f1)
+  if [ -z "$id" ]; then
+    echo - "$cmd" >&2
+    echo "Cannot asn1parse $cer to determine keyid" >&2
+    exit 1
+  fi
+  tmp=$(mktemp)
+  # shellcheck disable=SC2086
+  openssl x509 $OPENSSL_ENGINE \
+      -in "$cer" -inform DER -pubkey -noout 2>/dev/null \
+    | openssl asn1parse -strparse "$id" -out "$tmp" -noout
+  # shellcheck disable=SC2002
+  cat "$tmp" \
+    | openssl dgst -c -sha1 \
+    | cut -d' ' -f2 \
+    | grep -o ":..:..:..:..$" \
+    | tr -d :
+  rm -f "$tmp"
+}
+
+# Convert test $type into evmctl op prefix
+_op() {
+  if [ "$1" = ima ]; then
+    echo ima_
+  fi
+}
+
+# Convert test $type into xattr name
+_xattr() {
+  if [ "$1" = ima ]; then
+    echo user.ima
+  else
+    echo user.evm
+  fi
+}
+
+# Check that detached signature matches xattr signature
+_test_sigfile() {
+  local file=$1 attr=$2 file_sig=$3 file_sig2=$4
+
+  if [ ! -e "$file_sig" ]; then
+    color_red
+    echo "evmctl ima_sign: no detached signature $file_sig"
+    color_restore
+    rm "$file"
+    return "$FAIL"
+  fi
+
+  _extract_xattr "$file" "$attr" "$file_sig2"
+  if ! cmp -bl "$file_sig" "$file_sig2"; then
+    color_red
+    echo "evmctl ima_sign: xattr signature on $file differ from detached $file_sig"
+    color_restore
+    rm "$file" "$file_sig" "$file_sig2"
+    return "$FAIL"
+  fi
+
+  rm "$file_sig" "$file_sig2"
+}
+
+# Run single sign command
+_evmctl_sign() {
+  local type=$1 key=$2 alg=$3 file=$4 opts=$5
+
+  # Can check --sigfile for ima_sign
+  [ "$type" = ima ] && opts+=" --sigfile"
+
+  # shellcheck disable=SC2086
+  ADD_TEXT_FOR="$alg ($key)" ADD_DEL=$file \
+    _evmctl_run "$(_op "$type")sign" $opts \
+    --hashalgo "$alg" --key "$key" --xattr-user "$file" || return
+
+  if [ "$type" = ima ]; then
+    _test_sigfile "$file" "$(_xattr "$type")" "$file.sig" "$file.sig2"
+  fi
+}
+
+# Run and test {ima_,}sign operation
+check_sign() {
+  # Arguments are passed via global vars:
+  # TYPE (ima or evm),
+  # KEY,
+  # ALG (hash algo),
+  # PREFIX (signature header prefix in hex),
+  # OPTS (additional options for evmctl),
+  # FILE (working file to sign).
+  local "$@"
+  local KEY=${KEY%.*}.key
+  local FILE=${FILE:-$ALG.txt}
+
+  # Normalize key filename
+  KEY=test-${KEY#test-}
+
+  # Append suffix to files for negative tests, because we may
+  # leave only good files for verify tests.
+  _test_expected_to_fail && FILE+='~'
+
+  rm -f $FILE
+  if ! touch $FILE; then
+    color_red
+    echo "Can't create test file: $FILE"
+    color_restore
+    return "$HARDFAIL"
+  fi
+
+  if _test_expected_to_pass; then
+    # Can openssl work with this digest?
+    cmd="openssl dgst $OPENSSL_ENGINE -$ALG $FILE"
+    echo - "$cmd"
+    if ! $cmd >/dev/null; then
+      echo "${CYAN}$ALG ($KEY) test is skipped (openssl is unable to digest)$NORM"
+      return "$SKIP"
+    fi
+
+    if [ ! -e "$KEY" ]; then
+      echo "${CYAN}$ALG ($KEY) test is skipped (key file not found)$NORM"
+      return "$SKIP"
+    fi
+
+    # Can openssl sign with this digest and key?
+    cmd="openssl dgst $OPENSSL_ENGINE -$ALG -sign $KEY -hex $FILE"
+    echo - "$cmd"
+    if ! $cmd >/dev/null; then
+      echo "${CYAN}$ALG ($KEY) test is skipped (openssl is unable to sign)$NORM"
+      return "$SKIP"
+    fi
+  fi
+
+  # Insert keyid from cert into PREFIX in-place of marker `:K:'
+  if [[ $PREFIX =~ :K: ]]; then
+    keyid=$(_keyid_from_cert "$KEY")
+    if [ $? -ne 0 ]; then
+      color_red
+      echo "Unable to determine keyid for $KEY"
+      color_restore
+      return "$HARDFAIL"
+    fi
+    [ "$VERBOSE" -gt 2 ] && echo "  Expected keyid: $keyid"
+    PREFIX=${PREFIX/:K:/$keyid}
+  fi
+
+  # Perform signing by evmctl
+  _evmctl_sign "$TYPE" "$KEY" "$ALG" "$FILE" "$OPTS" || return
+
+  # First simple pattern match the signature.
+  ADD_TEXT_FOR=$ALG \
+    _test_xattr "$FILE" "$(_xattr "$TYPE")" "$PREFIX.*" || return
+
+  # This is all we can do for v1 signatures.
+  [[ "$OPTS" =~ --rsa ]] && return "$OK"
+
+  # This is all we can do for evm.
+  [[ "$TYPE" =~ evm ]] && return "$OK"
+
+  # Extract signature to a file
+  _extract_xattr "$FILE" "$(_xattr "$TYPE")" "$FILE.sig2" "$PREFIX"
+
+  # Verify extracted signature with openssl
+  cmd="openssl dgst $OPENSSL_ENGINE -$ALG -verify ${KEY%.*}.pub \
+	-signature $FILE.sig2 $FILE"
+  echo - "$cmd"
+  if ! $cmd; then
+    color_red_on_failure
+    echo "Signature v2 verification with openssl is failed."
+    color_restore
+    rm "$FILE.sig2"
+    return "$FAIL"
+  fi
+
+  rm "$FILE.sig2"
+  return "$OK"
+}
+
+# Test verify operation
+check_verify() {
+  # Arguments are passed via global vars:
+  # TYPE (ima or evm),
+  # KEY,
+  # ALG (hash algo),
+  # OPTS (additional options for evmctl),
+  # FILE (filename to verify).
+  local "$@"
+
+  # shellcheck disable=SC2086
+  if ! openssl dgst $OPENSSL_ENGINE -"$ALG" /dev/null >/dev/null 2>&1; then
+    echo $CYAN"$ALG ($KEY) test is skipped (openssl does not support $ALG)"$NORM
+    return $SKIP
+  fi
+
+  # shellcheck disable=SC2086
+  ADD_TEXT_FOR="$FILE ($KEY)" \
+    _evmctl_run "$(_op "$TYPE")verify" --key "$KEY" --xattr-user $OPTS "$FILE"
+}
+
+# Test runners
+
+# Perform sign and verify ima and evm testing
+sign_verify() {
+  local key=$1 alg=$2 prefix="$3" opts="$4"
+  local file=$alg.txt
+
+  # Set defaults:
+  # Public key is different for v1 and v2 (where x509 cert is used).
+  if [[ $opts =~ --rsa ]]; then
+    KEY=test-$key.pub
+  else
+    KEY=test-$key.cer
+  fi
+  ALG=$alg
+  PREFIX=$prefix
+  OPTS=$opts
+  FILE=$file
+
+  TYPE=ima
+  if expect_pass check_sign; then
+
+    # Normal verify with proper key should pass
+    expect_pass check_verify
+
+    # Multiple files and some don't verify
+    expect_fail check_verify FILE="/dev/null $file"
+  fi
+
+  TYPE=evm
+  # Avoid running blkid for evm tests which may require root
+  # No generation on overlayfs:
+  # ioctl(3, FS_IOC_GETVERSION, 0x7ffd8e0bd628) = -1 ENOTTY (Inappropriate ioctl for device)
+  OPTS="$opts --uuid --generation 0"
+  if expect_pass check_sign; then
+
+    # Normal verify with proper key
+    expect_pass check_verify
+
+    # Verify with wrong key
+    expect_fail check_verify KEY=rsa2048
+  fi
+
+  # Note: Leaving TYPE=evm and file is evm signed
+}
+
+# Test --keys
+try_different_keys() {
+  # This run after sign_verify which leaves
+  # TYPE=evm and file is evm signed
+
+  # v2 signing can work with multiple keys in --key option
+  if [[ ! $OPTS =~ --rsa ]]; then
+
+    # Have correct key in the key list
+    expect_pass check_verify KEY="test-rsa2048.cer,$KEY"
+    expect_pass check_verify KEY="/dev/null,$KEY,"
+  fi
+
+  # Try key that is not used for signing
+  expect_fail check_verify KEY=rsa2048
+
+  # Try completely wrong key files
+  expect_fail check_verify KEY=/dev/null
+  expect_fail check_verify KEY=/dev/zero
+}
+
+try_different_sigs() {
+  # TYPE=evm and file is evm signed
+
+  # Test --imasig
+  if expect_pass check_sign OPTS="$OPTS --imasig"; then
+
+    # Verify both evm and ima sigs
+    expect_pass check_verify
+    expect_pass check_verify TYPE=ima
+  fi
+
+  # Test --imahash
+  if expect_pass check_sign OPTS="$OPTS --imahash"; then
+
+    expect_pass check_verify
+
+    # IMA hash is not verifiable by ima_verify
+    expect_fail check_verify TYPE=ima
+  fi
+
+  # Test --portable
+  expect_pass check_sign OPTS="$OPTS --portable" PREFIX=0x05
+  # Cannot be verified for now, until that support is added to evmctl
+
+  # Test -i (immutable)
+  expect_pass check_sign OPTS="$OPTS -i" PREFIX=0x0303
+  # Cannot be verified for now
+}
+
+# Single test args: type key hash signature-prefix "evmctl-options"
+# sign_verify args:      key hash signature-prefix "evmctl-options"
+# Only single test can be prefixed with expect_{fail,pass}
+# `sign_verify' can not be prefixed with expect_{fail,pass} because
+# it runs multiple tests inside. See more tests there.
+# signature-prefix can contain `:K:' which will be resolved to keyid (v2 only)
+
+## Test v1 signatures
+# Signature v1 only supports sha1 and sha256 so any other should fail
+expect_fail \
+  check_sign TYPE=ima KEY=rsa1024 ALG=md5 PREFIX=0x0301 OPTS=--rsa
+
+sign_verify  rsa1024  sha1    0x0301 --rsa
+sign_verify  rsa1024  sha256  0x0301 --rsa
+  try_different_keys
+  try_different_sigs
+
+## Test v2 signatures with RSA PKCS#1
+# List of allowed hashes much greater but not all are supported.
+sign_verify  rsa1024  md5     0x030201:K:0080
+sign_verify  rsa1024  sha1    0x030202:K:0080
+sign_verify  rsa1024  sha224  0x030207:K:0080
+sign_verify  rsa1024  sha256  0x030204:K:0080
+  try_different_keys
+  try_different_sigs
+sign_verify  rsa1024  sha384  0x030205:K:0080
+sign_verify  rsa1024  sha512  0x030206:K:0080
+sign_verify  rsa1024  rmd160  0x030203:K:0080
+
+# Test v2 signatures with EC-RDSA
+_enable_gost_engine
+sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
+sign_verify  gost2012_256-B md_gost12_256 0x030212:K:0040
+sign_verify  gost2012_256-C md_gost12_256 0x030212:K:0040
+sign_verify  gost2012_512-A md_gost12_512 0x030213:K:0080
+sign_verify  gost2012_512-B md_gost12_512 0x030213:K:0080
+# Test if signing with wrong key length does not work.
+expect_fail \
+  check_sign TYPE=ima KEY=gost2012_512-B ALG=md_gost12_256 PREFIX=0x0302 OPTS=
+expect_fail \
+  check_sign TYPE=ima KEY=gost2012_256-B ALG=md_gost12_512 PREFIX=0x0302 OPTS=
+
-- 
2.11.0

