Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2846D913B2
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2019 01:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfHQXeG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Aug 2019 19:34:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51366 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHQXeG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Aug 2019 19:34:06 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C748172CCE6;
        Sun, 18 Aug 2019 02:33:49 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id A20BA4A4AE7;
        Sun, 18 Aug 2019 02:33:49 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7] ima-evm-utils: Add some tests for evmctl
Date:   Sun, 18 Aug 2019 02:33:48 +0300
Message-Id: <20190817233348.22349-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Run `make check' to execute the tests.
Currently only ima_hash, (evm) sign, (evm) verify, ima_sign, and
ima_verify are tested.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changelog since v6:
- ima_hash.test: Compare generated hashes with known values.
  I found that on power8 qemu with default -cpu calculates hashes wrongly.
  For exmaple: `openssl dgst -sha224 -hex /dev/null' results in
  83b2514951547ee00c7062fa3eb42079ff19f280ec81eedbdb0e3997 instead of
  d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f.
- Make `_keyid' use temporary files to not rely on presence of `/des/stdout'.
- evm sign: add `--generation 0' option.
  I found that on overlay fs (with ext4 over 9p) FS_IOC_GETVERSION does
  not work.
- gen-keys.sh: allows `force' argument to regenerate all test keys.

Changelog since v5:
- Fix tests if gost-engine is not present. Thx to Mimi Zohar for testing on
  Xenial.

Changelog since v4:
- Fix bugs found by Mimi Zohar:
 - Fix typos in variable names
 - Fix `-out -' in asn1parse for openssl 1.0.x

Changelog since v3:
- Apply changes based on some suggestions from Petr Vorel, such as
- Add .gitignore
- Do not color output if stdout is not tty.
- Fix blkid error with --uuid option.
- Remove or change some comments
- Replace ENGINE with EVMCTL_ENGINE and OPENSSL_ENGINE.
- All tests pass over next branch.

Changelog since v2:
- ima_sign.test and ima_verify.test merged into sign_verify.test
  which is also able to test evm signatures.
- Apply Mimi Zohar suggestions regarding commenting, variable renaming,
  code rearranging, etc. with intent to simplify the code and review.

Changelog since v1:
- Apply suggestions by Petr Vorel:
 - Rename function names and variables to be more understandable.
 - Rename tests/functions to tests/functions.sh.
 - Define exit codes (77, 99, ...) as variables.
- Added more comments and remove single letter variables (for Mimi Zohar).
- Move getfattr check into function.
- Move evmctl run and check into single function.
- Add sign/verify tests for v1 signatures.
- Minor improvements.
- Since I still edit all 5 files I did not split the patch into multiple
  commits to separate the files, otherwise editing will become too
  complicated, as I ought to continuously rebase and edit different
  commits. This was really non-productive suggestion.

 .gitignore             |   2 +-
 Makefile.am            |   2 +-
 configure.ac           |   1 +
 tests/.gitignore       |  16 +++
 tests/Makefile.am      |  12 ++
 tests/functions.sh     | 272 ++++++++++++++++++++++++++++++++++++
 tests/gen-keys.sh      |  97 +++++++++++++
 tests/ima_hash.test    |  80 +++++++++++
 tests/sign_verify.test | 366 +++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 846 insertions(+), 2 deletions(-)
 create mode 100644 tests/.gitignore
 create mode 100644 tests/Makefile.am
 create mode 100755 tests/functions.sh
 create mode 100755 tests/gen-keys.sh
 create mode 100755 tests/ima_hash.test
 create mode 100755 tests/sign_verify.test

diff --git a/.gitignore b/.gitignore
index cb82166..c579199 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,7 +21,7 @@ missing
 compile
 libtool
 ltmain.sh
-
+test-driver
 
 # Compiled executables
 *.o
diff --git a/Makefile.am b/Makefile.am
index dba408d..45c6f82 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS = src
+SUBDIRS = src tests
 dist_man_MANS = evmctl.1
 
 doc_DATA =  examples/ima-genkey-self.sh examples/ima-genkey.sh examples/ima-gen-local-ca.sh
diff --git a/configure.ac b/configure.ac
index 5aca4c1..3f21ba4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,7 @@ EVMCTL_MANPAGE_DOCBOOK_XSL
 
 AC_CONFIG_FILES([Makefile
 		src/Makefile
+		tests/Makefile
 		packaging/ima-evm-utils.spec
 		])
 AC_OUTPUT
diff --git a/tests/.gitignore b/tests/.gitignore
new file mode 100644
index 0000000..9ecc984
--- /dev/null
+++ b/tests/.gitignore
@@ -0,0 +1,16 @@
+# Generated by test driver
+*.log
+*.trs
+
+# Generated by tests
+*.txt
+*.out
+*.sig
+*.sig2
+
+# Generated certs and keys (by gen-keys.sh)
+*.cer
+*.pub
+*.key
+*.conf
+
diff --git a/tests/Makefile.am b/tests/Makefile.am
new file mode 100644
index 0000000..029f2ff
--- /dev/null
+++ b/tests/Makefile.am
@@ -0,0 +1,12 @@
+check_SCRIPTS =
+TESTS = $(check_SCRIPTS)
+
+check_SCRIPTS += ima_hash.test sign_verify.test
+
+clean-local:
+	-rm -f *.txt *.out *.sig *.sig2
+
+distclean: distclean-keys
+.PHONY: distclean-keys
+distclean-keys:
+	./gen-keys.sh clean
diff --git a/tests/functions.sh b/tests/functions.sh
new file mode 100755
index 0000000..16c8d89
--- /dev/null
+++ b/tests/functions.sh
@@ -0,0 +1,272 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# ima-evm-utils tests bash functions
+#
+# Copyright (C) 2019 Vitaly Chikunov <vt@altlinux.org>
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
+# Tests accounting
+declare -i testspass=0 testsfail=0 testsskip=0
+
+# Exit codes (compatible with automake)
+declare -r OK=0
+declare -r FAIL=1
+declare -r HARDFAIL=99 # hard failure no matter testing mode
+declare -r SKIP=77
+
+# You can set env VERBOSE=1 to see more output from evmctl
+V=vvvv
+V=${V:0:$VERBOSE}
+V=${V:+-$V}
+
+# Exit if env FAILEARLY is defined.
+# Used in expect_{pass,fail}.
+exit_early() {
+  if [ $FAILEARLY ]; then
+    exit $1
+  fi
+}
+
+# Require particular executables to be present
+_require() {
+  ret=
+  for i; do
+    if ! type $i; then
+      echo "$i is required for test"
+      ret=1
+    fi
+  done
+  [ $ret ] && exit $HARDFAIL
+}
+
+# Only allow color output on tty
+if [ -t 1 ]; then
+     RED=$'\e[1;31m'
+   GREEN=$'\e[1;32m'
+  YELLOW=$'\e[1;33m'
+    BLUE=$'\e[1;34m'
+    CYAN=$'\e[1;36m'
+    NORM=$'\e[m'
+fi
+
+# Test mode determined by TFAIL variable:
+#   undefined: to success testing
+#   defined: failure testing
+TFAIL=
+TMODE=+ # mode character to prepend running command in log
+declare -i TNESTED=0 # just for sanity checking
+
+# Run positive test (one that should pass) and account its result
+expect_pass() {
+  local ret
+
+  if [ $TNESTED -gt 0 ]; then
+    echo $RED"expect_pass should not be run nested"$NORM
+    testsfail+=1
+    exit $HARDFAIL
+  fi
+  TFAIL=
+  TMODE=+
+  TNESTED+=1
+  [[ "$VERBOSE" -gt 1 ]] && echo "____ START positive test: $@"
+  "$@"
+  ret=$?
+  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) positive test: $@"
+  TNESTED+=-1
+  case $ret in
+    0)  testspass+=1 ;;
+    77) testsskip+=1 ;;
+    99) testsfail+=1; exit_early 1 ;;
+    *)  testsfail+=1; exit_early 2 ;;
+  esac
+  return $ret
+}
+
+# Eval negative test (one that should fail) and account its result
+expect_fail() {
+  local ret
+
+  if [ $TNESTED -gt 0 ]; then
+    echo $RED"expect_fail should not be run nested"$NORM
+    testsfail+=1
+    exit $HARDFAIL
+  fi
+
+  TFAIL=yes
+  TMODE=-
+  TNESTED+=1
+  [[ "$VERBOSE" -gt 1 ]] && echo "____ START negative test: $@"
+  "$@"
+  ret=$?
+  [[ "$VERBOSE" -gt 1 ]] && echo "^^^^ STOP ($ret) negative test: $@"
+  TNESTED+=-1
+  case $ret in
+    0)  testsfail+=1; exit_early 3 ;;
+    77) testsskip+=1 ;;
+    99) testsfail+=1; exit_early 4 ;;
+    *)  testspass+=1 ;;
+  esac
+  # Restore defaults (as in positive tests)
+  # for tests to run without wrappers
+  TFAIL=
+  TMODE=+
+  return $ret
+}
+
+# return true if current test is positive
+_is_expect_pass() {
+  [ ! $TFAIL ]
+}
+
+# return true if current test is negative
+_is_expect_fail() {
+  [ $TFAIL ]
+}
+
+# Show blank line and color following text to red
+# if it's real error (ie we are in expect_pass mode).
+red_if_failure() {
+  if _is_expect_pass; then
+    echo $@ $RED
+    COLOR_RESTORE=1
+  fi
+}
+
+# For hard errors
+red_always() {
+  echo $@ $RED
+  COLOR_RESTORE=1
+}
+
+color_restore() {
+  [ $COLOR_RESTORE ] && echo $@ $NORM
+  COLOR_RESTORE=
+}
+
+ADD_DEL=
+ADD_TEXT_FOR=
+# _evmctl_run should be run as `_evmctl_run ... || return'
+_evmctl_run() {
+  local op=$1 out=$1-$$.out
+  local text_for=${FOR:+for $ADD_TEXT_FOR}
+  # Additional parameters:
+  # ADD_DEL: additional files to rm on failure
+  # ADD_TEXT_FOR: append to text as 'for $ADD_TEXT_FOR'
+
+  cmd="evmctl $V $EVMCTL_ENGINE $@"
+  echo $YELLOW$TMODE $cmd$NORM
+  $cmd >$out 2>&1
+  ret=$?
+
+  # Shell special and signal exit codes (except 255)
+  if [ $ret -ge 126 -a $ret -lt 255 ]; then
+    red_always
+    echo "evmctl $op failed hard with ($ret) $text_for"
+    sed 's/^/  /' $out
+    color_restore
+    rm $out $ADD_DEL
+    ADD_DEL=
+    ADD_TEXT_FOR=
+    return $HARDFAIL
+  elif [ $ret -gt 0 ]; then
+    red_if_failure
+    echo "evmctl $op failed" ${TFAIL:+properly} "with ($ret) $text_for"
+    # Show evmctl output only in verbose mode or if real failure.
+    if _is_expect_pass || [ "$VERBOSE" ]; then
+      sed 's/^/  /' $out
+    fi
+    color_restore
+    rm $out $ADD_DEL
+    ADD_DEL=
+    ADD_TEXT_FOR=
+    return $FAIL
+  elif _is_expect_fail; then
+    red_always
+    echo "evmctl $op wrongly succeeded $text_for"
+    sed 's/^/  /' $out
+    color_restore
+  else
+    [ "$VERBOSE" ] && sed 's/^/  /' $out
+  fi
+  rm $out
+  ADD_DEL=
+  ADD_TEXT_FOR=
+  return $OK
+}
+
+# Extract xattr $attr from $file into $out file skipping $pref'ix
+_extract_xattr() {
+  local file=$1 attr=$2 out=$3 pref=$4
+
+  getfattr -n $attr -e hex $file \
+    | grep "^$attr=" \
+    | sed "s/^$attr=$pref//" \
+    | xxd -r -p > $out
+}
+
+# Test if xattr $attr in $file matches $pref'ix
+# Show error and fail otherwise.
+_test_xattr() {
+  local file=$1 attr=$2 pref=$3
+  local text_for=${ADD_TEXT_FOR:+ for $ADD_TEXT_FOR}
+
+  if ! getfattr -n $attr -e hex $file | egrep -qx "$attr=$pref"; then
+    red_if_failure
+    echo "Did not find expected hash$text_for:"
+    echo "    $attr=$pref"
+    echo ""
+    echo "Actual output below:"
+    getfattr -n $attr -e hex $file | sed 's/^/    /'
+    color_restore
+    rm $file
+    ADD_TEXT_FOR=
+    return $FAIL
+  fi
+  ADD_TEXT_FOR=
+}
+
+# Try to enable gost-engine if needed.
+_enable_gost_engine() {
+  # Do not enable if it's already working (enabled by user)
+  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
+    && openssl engine gost >/dev/null 2>&1; then
+    EVMCTL_ENGINE="--engine gost"
+    OPENSSL_ENGINE="-engine gost"
+  fi
+}
+
+# Show test stats and exit into automake test system
+# with proper exit code (same as ours).
+_report_exit() {
+  if [ $testsfail -gt 0 ]; then
+    echo "================================="
+    echo " Run with FAILEARLY=1 $0 $@"
+    echo " To stop after first failure"
+    echo "================================="
+  fi
+  [ $testspass -gt 0 ] && echo -n $GREEN || echo -n $NORM
+  echo -n "PASS: $testspass"
+  [ $testsskip -gt 0 ] && echo -n $YELLOW || echo -n $NORM
+  echo -n " SKIP: $testsskip"
+  [ $testsfail -gt 0 ] && echo -n $RED || echo -n $NORM
+  echo " FAIL: $testsfail"
+  echo $NORM
+  if [ $testsfail -gt 0 ]; then
+    exit $FAIL
+  elif [ $testspass -gt 0 ]; then
+    exit $OK
+  else
+    exit $SKIP
+  fi
+}
+
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
new file mode 100755
index 0000000..53eb32f
--- /dev/null
+++ b/tests/gen-keys.sh
@@ -0,0 +1,97 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate keys for the tests
+#
+# Copyright (C) 2019 Vitaly Chikunov <vt@altlinux.org>
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
+cd $(dirname $0)
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
+      rm -f test-$algo-$param.key test-$algo-$param.cer test-$algo-$param.pub
+    fi
+    if [ "$1" = clean ]; then
+      continue
+    fi
+    [ -e test-$algo-$param.key ] && continue
+    log openssl req -nodes -x509 -utf8 -days 10000 -batch \
+      -config test-ca.conf \
+      -newkey $algo \
+      -pkeyopt paramset:$param \
+      -out    test-$algo-$param.cer -outform DER \
+      -keyout test-$algo-$param.key
+    if [ -s test-$algo-$param.key ]; then
+      log openssl pkey -in test-$algo-$param.key -out test-$algo-$param.pub -pubout
+    fi
+done
+
+# This script leaves test-ca.conf, *.cer, *.pub, *.key files for sing/verify tests.
+# They are never deleted except by `make distclean'.
+
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
new file mode 100755
index 0000000..30aec19
--- /dev/null
+++ b/tests/ima_hash.test
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# evmctl ima_hash tests
+#
+# Copyright (C) 2019 Vitaly Chikunov <vt@altlinux.org>
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
+cd $(dirname $0)
+PATH=../src:$PATH
+source ./functions.sh
+_require evmctl openssl getfattr
+
+trap _report_exit EXIT
+set -f # disable globbing
+
+check() {
+  local alg=$1 pref=$2 chash=$3 hash
+  local file=$alg-hash.txt
+
+  rm -f $file
+  touch $file
+  # Generate hash with openssl, if it's failed skip test,
+  # unless it's negative test, then pass to evmctl
+  cmd="openssl dgst $OPENSSL_ENGINE -$alg $file"
+  echo - $cmd
+  hash=$(set -o pipefail; $cmd 2>/dev/null | cut -d' ' -f2)
+  if [ $? -ne 0 ] && _is_expect_pass; then
+    echo $CYAN"$alg test is skipped"$NORM
+    rm $file
+    return $SKIP
+  fi
+  if [ "$chash" ] && [ "$chash" != "$hash" ]; then
+    red_always
+    echo "Invalid hash for $alg from openssl"
+    echo "Expected: $chash"
+    echo "Returned: $hash"
+    color_restore
+    rm $file
+    return $HARDFAIL
+  fi
+
+  ADD_TEXT_FOR=$alg ADD_DEL=$file \
+    _evmctl_run ima_hash --hashalgo $alg --xattr-user $file || return
+  ADD_TEXT_FOR=$alg \
+    _test_xattr $file user.ima $pref$hash || return
+  rm $file
+  return $OK
+}
+
+# check args: algo hdr-prefix canonic-hash
+expect_pass check  md4        0x01 31d6cfe0d16ae931b73c59d7e0c089c0
+expect_pass check  md5        0x01 d41d8cd98f00b204e9800998ecf8427e
+expect_pass check  sha1       0x01 da39a3ee5e6b4b0d3255bfef95601890afd80709
+expect_fail check  SHA1       0x01 # uppercase
+expect_fail check  sha512-224 0x01 # valid for pkcs1
+expect_fail check  sha512-256 0x01 # valid for pkcs1
+expect_fail check  unknown    0x01 # nonexistent
+expect_pass check  sha224     0x0407 d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f
+expect_pass check  sha256     0x0404 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
+expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b
+expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
+expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
+expect_fail check  sm3        0x01
+expect_fail check  sm3-256    0x01
+_enable_gost_engine
+expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
+expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
+expect_pass check  md_gost12_512 0x0413 8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a
+expect_pass check  streebog512   0x0413 8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a
+
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
new file mode 100755
index 0000000..2bad2fb
--- /dev/null
+++ b/tests/sign_verify.test
@@ -0,0 +1,366 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# evmctl {,ima_}{sign,verify} tests
+#
+# Copyright (C) 2019 Vitaly Chikunov <vt@altlinux.org>
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
+cd $(dirname $0)
+PATH=../src:$PATH
+source ./functions.sh
+_require evmctl openssl xxd getfattr
+./gen-keys.sh >/dev/null 2>&1
+
+trap _report_exit EXIT
+set -f # disable globbing
+
+# Determine keyid from a cert
+_keyid() {
+  local cer=${1%.*}.cer cmd
+  local tmp
+
+  cer=test-${cer#test-}
+  cmd="openssl x509 $OPENSSL_ENGINE \
+          -in $cer -inform DER -pubkey -noout"
+  id=$($cmd 2>/dev/null \
+    | openssl asn1parse \
+    | grep BIT.STRING \
+    | cut -d: -f1)
+  if [ -z "$id" ]; then
+    echo - $cmd >&2
+    echo "Cannot asn1parse $cer to determine keyid" >&2
+    exit 1
+  fi
+  tmp=$(mktemp)
+  openssl x509 $OPENSSL_ENGINE \
+      -in $cer -inform DER -pubkey -noout 2>/dev/null \
+    | openssl asn1parse -strparse $id -out $tmp -noout
+  cat $tmp \
+    | openssl dgst -c -sha1 \
+    | cut -d' ' -f2 \
+    | grep -o ":..:..:..:..$" \
+    | tr -d :
+  rm -f $tmp
+}
+
+# Convert test $type into evmctl op prefix
+_op() {
+  if [ $1 = ima ]; then
+    echo ima_
+  fi
+}
+
+# Convert test $type into xattr name
+_xattr() {
+  if [ $1 = ima ]; then
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
+  if [ ! -e $file_sig ]; then
+    red_always
+    echo "evmctl ima_sign: no detached signature $file_sig"
+    color_restore
+    rm $file
+    return $FAIL
+  fi
+
+  _extract_xattr $file $attr $file_sig2
+  if ! cmp -bl $file_sig $file_sig2; then
+    red_always
+    echo "evmctl ima_sign: xattr signature on $file differ from detached $file_sig"
+    color_restore
+    rm $file $file_sig $file_sig2
+    return $FAIL
+  fi
+
+  rm $file_sig $file_sig2
+}
+
+# Run single sign command
+_evmctl_sign() {
+  local type=$1 key=$2 alg=$3 file=$4 opts=$5
+
+  # Can check --sigfile for ima_sign
+  [ $type = ima ] && opts+=" --sigfile"
+
+  ADD_TEXT_FOR="$alg ($key)" ADD_DEL=$file \
+    _evmctl_run $(_op $type)sign $opts \
+    --hashalgo $alg --key $key --xattr-user $file || return
+
+  if [ $type = ima ]; then
+    _test_sigfile $file $(_xattr $type) $file.sig $file.sig2
+  fi
+}
+
+# Run and test {ima_,}sign operation
+check_sign() {
+  # Arguments are passed via global vars:
+  # TYPE (ima or evm),
+  # KEY,
+  # ALG (hash algo),
+  # PREF (signature header prefix),
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
+  _is_expect_fail && FILE+='~'
+
+  rm -f $FILE
+  if ! touch $FILE; then
+    red_always
+    echo "Can't create test file: $FILE"
+    color_restore
+    return $HARDFAIL
+  fi
+
+  if _is_expect_pass; then
+    # Can openssl work with this digest?
+    cmd="openssl dgst $OPENSSL_ENGINE -$ALG $FILE"
+    echo - $cmd
+    if ! $cmd >/dev/null; then
+      echo $CYAN"$ALG ($KEY) test is skipped (openssl is unable to digest)"$NORM
+      return $SKIP
+    fi
+
+    if [ ! -e $KEY ]; then
+      red_always
+      echo "Key $KEY does not exist."
+      color_restore
+      return $HARDFAIL
+    fi
+
+    # Can openssl sign with this digest and key?
+    cmd="openssl dgst $OPENSSL_ENGINE -$ALG -sign $KEY -hex $FILE"
+    echo - $cmd
+    if ! $cmd >/dev/null; then
+      echo $CYAN"$ALG ($KEY) test is skipped (openssl is unable to sign)"$NORM
+      return $SKIP
+    fi
+  fi
+
+  # Fix keyid in the prefix.
+  if [[ $PREF =~ K ]]; then
+    keyid=$(_keyid $KEY)
+    if [ $? -ne 0 ]; then
+      red_always
+      echo "Unable to determine keyid for $KEY"
+      color_restore
+      return $HARDFAIL
+    fi
+    [[ "$VERBOSE" -gt 2 ]] && echo "  Expected keyid: $keyid"
+    PREF=$(echo $PREF | sed "s/K/$keyid/")
+  fi
+
+  # Perform signing by evmctl
+  _evmctl_sign $TYPE $KEY $ALG $FILE "$OPTS" || return
+
+  # First simple pattern match the signature.
+  ADD_TEXT_FOR=$ALG \
+    _test_xattr $FILE $(_xattr $TYPE) $PREF.* || return
+
+  # This is all we can do for v1 signatures.
+  [[ "$OPTS" =~ --rsa ]] && return $OK
+
+  # This is all we can do for evm.
+  [[ $TYPE =~ evm ]] && return $OK
+
+  # Extract signature to a file
+  _extract_xattr $FILE $(_xattr $TYPE) $FILE.sig2 $PREF
+
+  # Verify extracted signature with openssl
+  cmd="openssl dgst $OPENSSL_ENGINE -$ALG -verify ${KEY%.*}.pub \
+	-signature $FILE.sig2 $FILE"
+  echo - $cmd
+  if ! $cmd; then
+    red_if_failure
+    echo "Signature v2 verification with openssl is failed."
+    color_restore
+    rm $FILE.sig2
+    return $FAIL
+  fi
+
+  rm $FILE.sig2
+  return $OK
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
+  if ! openssl dgst $OPENSSL_ENGINE -$ALG /dev/null >/dev/null 2>&1; then
+    echo $CYAN"$ALG ($KEY) test is skipped (openssl does not support $ALG)"$NORM
+    return $SKIP
+  fi
+
+  ADD_TEXT_FOR="$FILE ($KEY)" \
+    _evmctl_run $(_op $TYPE)verify --key $KEY --xattr-user $OPTS $FILE
+}
+
+# Test runners
+
+# Perform sign and verify ima and evm testing
+sign_verify() {
+  local key=$1 alg=$2 pref="$3" opts="$4"
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
+  PREF=$pref
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
+    expect_fail check_verify FILE=/dev/null,$file
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
+    expect_pass check_verify KEY=test-rsa2048.cer,$KEY
+    expect_pass check_verify KEY=/dev/null,$KEY,
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
+  expect_pass check_sign OPTS="$OPTS --portable" PREF=0x05
+  # Cannot be verified
+
+  # Test -i (immutable)
+  expect_pass check_sign OPTS="$OPTS -i" PREF=0x0303
+  # Cannot be verified
+}
+
+# Single test args: type key hash signature-prefix "evmctl-options"
+# sign_verify args:      key hash signature-prefix "evmctl-options"
+# Only single test can be prefixed with expect_{fail,pass}
+# `sign_verify' can not be prefixed with expect_{fail,pass} because
+# it runs multiple tests inside. See more tests there.
+# signature-prefix can contain `K' which will be resolved to keyid (v2 only)
+
+## Test v1 signatures
+# Signature v1 only supports sha1 and sha256 so any other should fail
+expect_fail \
+  check_sign TYPE=ima KEY=rsa1024 ALG=md5 PREF=0x0301 OPTS=--rsa
+
+sign_verify  rsa1024  sha1    0x0301 --rsa
+sign_verify  rsa1024  sha256  0x0301 --rsa
+  try_different_keys
+  try_different_sigs
+
+## Test v2 signatures with RSA PKCS#1
+# List of allowed hashes much greater but not all are supported.
+sign_verify  rsa1024  md5     0x030201K0080
+sign_verify  rsa1024  sha1    0x030202K0080
+sign_verify  rsa1024  sha224  0x030207K0080
+sign_verify  rsa1024  sha256  0x030204K0080
+  try_different_keys
+  try_different_sigs
+sign_verify  rsa1024  sha384  0x030205K0080
+sign_verify  rsa1024  sha512  0x030206K0080
+sign_verify  rsa1024  rmd160  0x030203K0080
+
+# Test v2 signatures with EC-RDSA
+_enable_gost_engine
+sign_verify  gost2012_256-A md_gost12_256 0x030212K0040
+sign_verify  gost2012_256-B md_gost12_256 0x030212K0040
+sign_verify  gost2012_256-C md_gost12_256 0x030212K0040
+sign_verify  gost2012_512-A md_gost12_512 0x030213K0080
+sign_verify  gost2012_512-B md_gost12_512 0x030213K0080
+# Test if signing with wrong key length does not work.
+expect_fail \
+  check_sign TYPE=ima KEY=gost2012_512-B ALG=md_gost12_256 PREF=0x0302 OPTS=
+expect_fail \
+  check_sign TYPE=ima KEY=gost2012_256-B ALG=md_gost12_512 PREF=0x0302 OPTS=
+
-- 
2.11.0

