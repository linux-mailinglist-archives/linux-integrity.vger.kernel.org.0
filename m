Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D23776AB
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jul 2019 06:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfG0ElX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jul 2019 00:41:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:38058 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfG0ElX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jul 2019 00:41:23 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 16F1572CC6C;
        Sat, 27 Jul 2019 07:41:15 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id DB8544A4AE8;
        Sat, 27 Jul 2019 07:41:14 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2] ima-evm-utils: Add some tests for evmctl
Date:   Sat, 27 Jul 2019 07:41:13 +0300
Message-Id: <20190727044113.3865-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Run `make check' to execute the tests.
Currently only ima_hash, ima_sign, and ima_verify are tested.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
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

Please test the tests.

 Makefile.am           |   2 +-
 configure.ac          |   1 +
 tests/Makefile.am     |  15 ++++
 tests/functions.sh    | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/gen-keys.sh     |  90 +++++++++++++++++++++
 tests/ima_hash.test   |  72 +++++++++++++++++
 tests/ima_sign.test   | 211 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ima_verify.test |  93 +++++++++++++++++++++
 8 files changed, 701 insertions(+), 1 deletion(-)
 create mode 100644 tests/Makefile.am
 create mode 100755 tests/functions.sh
 create mode 100755 tests/gen-keys.sh
 create mode 100755 tests/ima_hash.test
 create mode 100755 tests/ima_sign.test
 create mode 100755 tests/ima_verify.test

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
index 3fc63b3..dccdd92 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,7 @@ EVMCTL_MANPAGE_DOCBOOK_XSL
 
 AC_CONFIG_FILES([Makefile
 		src/Makefile
+		tests/Makefile
 		packaging/ima-evm-utils.spec
 		])
 AC_OUTPUT
diff --git a/tests/Makefile.am b/tests/Makefile.am
new file mode 100644
index 0000000..145ea30
--- /dev/null
+++ b/tests/Makefile.am
@@ -0,0 +1,15 @@
+check_SCRIPTS =
+TESTS = $(check_SCRIPTS)
+
+check_SCRIPTS += ima_hash.test ima_verify.test ima_sign.test
+
+# ima_verify depends on results of ima_hash
+ima_verify.log: ima_sign.log
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
index 0000000..8794120
--- /dev/null
+++ b/tests/functions.sh
@@ -0,0 +1,218 @@
+#!/bin/bash
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
+# tests accounting
+declare -i testspass=0 testsfail=0 testsskip=0
+
+# exit codes (compatible with automake)
+declare -r OK=0
+declare -r FAIL=1
+declare -r HARDFAIL=99 # hard failure no matter testing mode
+declare -r SKIP=77     # skip test
+
+# you can set env VERBOSE=1 to see more output from evmctl
+V=vvvv
+V=${V:0:$VERBOSE}
+V=${V:+-$V}
+
+# require particular executables to be present
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
+# only allow color output on tty
+if tty -s; then
+     RED=$'\e[1;31m'
+   GREEN=$'\e[1;32m'
+  YELLOW=$'\e[1;33m'
+    BLUE=$'\e[1;34m'
+    CYAN=$'\e[1;36m'
+    NORM=$'\e[m'
+fi
+
+# Define FAILEARLY to exit testing on the first error.
+exit_early() {
+  if [ $FAILEARLY ]; then
+    exit $1
+  fi
+}
+
+# Test mode determined by TNEG variable:
+#   undefined: to positive testing
+#   defined: negative testing
+TNEG=
+TMODE=+
+
+# Eval positive test and account its result
+pos() {
+  TNEG= TMODE=+
+  [ "$VERBOSE" ] && echo "Start positive test $*"
+  eval "$@"
+  E=$?
+  [ "$VERBOSE" ] && echo "Stop ($E) positive test $*"
+  case $E in
+    0)  testspass+=1 ;;
+    77) testsskip+=1 ;;
+    99) testsfail+=1; exit_early 1 ;;
+    *)  testsfail+=1; exit_early 2 ;;
+  esac
+}
+
+# Eval negative test and accoutn its result
+neg() {
+  TNEG=1 TMODE=-
+  [ "$VERBOSE" ] && echo "Start negative test $*"
+  eval "$@"
+  E=$?
+  [ "$VERBOSE" ] && echo "Stop ($E) negative test $*"
+  case $E in
+    0)  testsfail+=1; exit_early 3 ;;
+    77) testsskip+=1 ;;
+    99) testsfail+=1; exit_early 4 ;;
+    *)  testspass+=1 ;;
+  esac
+  TNEG= # Restore default
+}
+
+# return true if current test is positive
+_is_positive_test() {
+  [ -z "$TNEG" ]
+}
+
+# return true if current test is negative
+_is_negative_test() {
+  [ "$TNEG" ]
+}
+
+# Color following text to red if it's real error
+red_if_pos() {
+  _is_positive_test && echo $@ $RED
+}
+
+norm_if_pos() {
+  _is_positive_test && echo $@ $NORM
+}
+
+DEL=
+FOR=
+# _evmctl_run should be run as `_evmctl_run ... || return'
+_evmctl_run() {
+  local cmd=$1 out=$1-$$.out
+  # Additional parameters:
+  # FOR: append to text as 'for $FOR'
+  # DEL: additional files to rm if test failed
+
+  set -- evmctl $V ${ENGINE:+--engine $ENGINE} "$@"
+  echo $YELLOW$TMODE $*$NORM
+  eval "$@" >$out 2>&1
+  ret=$?
+
+  if [ $ret -ge 126 -a $ret -lt 255 ]; then
+    echo $RED
+    echo "evmctl $cmd failed hard with ($ret) ${FOR:+for $FOR}"
+    sed 's/^/  /' $out
+    echo $NORM
+    rm $out $DEL
+    FOR= DEL=
+    return $SKIP
+  elif [ $ret -gt 0 ]; then
+    red_if_pos
+    echo "evmctl $cmd failed" ${TNEG:+properly} "with ($ret) ${FOR:+for $FOR}"
+    sed 's/^/  /' $out
+    norm_if_pos
+    rm $out $DEL
+    FOR= DEL=
+    return $FAIL
+  elif _is_negative_test; then
+    echo $RED
+    echo "evmctl $cmd wrongly succeeded ${FOR:+for $FOR}"
+    sed 's/^/  /' $out
+    echo $NORM
+  else
+    [ "$VERBOSE" ] && sed 's/^/  /' $out
+  fi
+  rm $out
+  FOR= DEL=
+  return $OK
+}
+
+_extract_ima_xattr() {
+  local file=$1 out=$2 pref=$3
+
+  getfattr -n user.ima -e hex $file \
+    | grep ^user.ima= \
+    | sed s/^user.ima=$pref// \
+    | xxd -r -p > $out
+}
+
+_test_ima_xattr() {
+  local file=$1 pref=$2
+
+  if ! getfattr -n user.ima -e hex $file | egrep -qx "user.ima=$pref"; then
+    red_if_pos
+    echo "Did not find expected hash${FOR:+ for $FOR}:"
+    echo "    user.ima=$pref"
+    echo ""
+    echo "Actual output below:"
+    getfattr -n user.ima -e hex $file | sed 's/^/    /'
+    norm_if_pos
+    rm $file
+    FOR=
+    return $FAIL
+  fi
+  FOR=
+}
+
+_enable_gost_engine() {
+  # Do not enable if it's already working (enabled by user)
+  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
+    && openssl engine gost >/dev/null 2>&1; then
+    ENGINE=gost
+  fi
+}
+
+# Show test stats and exit into automake test system
+# with proper exit code (same as ours).
+_report_exit() {
+  if [ $testsfail -gt 0 ]; then
+    echo "=============================="
+    echo "Run with FAILEARLY=1 $0 $@"
+    echo "To stop after first failure"
+    echo "=============================="
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
index 0000000..056cd68
--- /dev/null
+++ b/tests/gen-keys.sh
@@ -0,0 +1,90 @@
+#!/bin/bash
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
+elif [ ! -e test-ca.conf ]; then
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
+  if [ "$1" = clean ]; then
+    rm -f test-rsa$m.cer test-rsa$m.key test-rsa$m.pub
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
+    if [ "$1" = clean ]; then
+      rm -f test-$algo-$param.key test-$algo-$param.cer test-$algo-$param.pub
+      continue
+    fi
+    [ -e test-$algo-$param.key ] && continue
+    log openssl req -nodes -x509 -utf8 -days 10000 -batch \
+      -config test-ca.conf \
+      -newkey $algo \
+      -pkeyopt paramset:$param \
+      -out    test-$algo-$param.cer -outform DER \
+      -keyout test-$algo-$param.key
+    log openssl pkey -in test-$algo-$param.key -out test-$algo-$param.pub -pubout
+done
+
+# This script leaves test-ca.conf, *.cer, *.pub, *.key files for sing/verify tests.
+# They are never deleted except by `make distclean'.
+
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
new file mode 100755
index 0000000..d4bfe19
--- /dev/null
+++ b/tests/ima_hash.test
@@ -0,0 +1,72 @@
+#!/bin/bash
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
+_require evmctl openssl
+
+# Check with constant
+check_const() {
+  local alg=$1 pref=$2 hash=$3 file=$4
+
+  FOR=$alg DEL=$file \
+    _evmctl_run ima_hash --hashalgo $alg --xattr-user $file || return
+  FOR=$alg \
+    _test_ima_xattr $file $pref$hash || return
+  rm $file
+  return $OK
+}
+
+check() {
+  local alg=$1 pref=$2 hash=$3
+  local file=$alg-hash.txt
+
+  rm -f $file
+  touch $file
+  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg $file"
+  echo - $cmd
+  hash=$(set -o pipefail; eval "$cmd" 2>/dev/null | cut -d' ' -f2)
+  if [ $? -ne 0 ] && _is_positive_test; then
+    echo $CYAN"$alg test is skipped"$NORM
+    rm $file
+    return $SKIP
+  fi
+  check_const $alg $pref "$hash" $file
+}
+
+# check args: algo prefix hex-hash
+pos check md4    0x01
+pos check md5    0x01
+pos check sha1   0x01
+neg check SHA1   0x01 # uppercase
+neg check sha512-224 0x01 # valid for pkcs1
+neg check sha512-256 0x01 # valid for pkcs1
+neg check unknown 0x01 # nonexistent
+pos check sha224 0x0407
+pos check sha256 0x0404
+pos check sha384 0x0405
+pos check sha512 0x0406
+pos check rmd160 0x0403
+neg check sm3     0x01
+neg check sm3-256 0x01
+_enable_gost_engine
+pos check md_gost12_256 0x0412
+pos check streebog256   0x0412
+pos check md_gost12_512 0x0413
+pos check streebog512   0x0413
+
+_report_exit
diff --git a/tests/ima_sign.test b/tests/ima_sign.test
new file mode 100755
index 0000000..5af2bbb
--- /dev/null
+++ b/tests/ima_sign.test
@@ -0,0 +1,211 @@
+#!/bin/bash
+#
+# evmctl ima_sign tests
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
+# Determine keyid from cert
+keyid() {
+  local cer=$1.cer
+
+  id=$(openssl x509 ${ENGINE:+-engine $ENGINE} \
+      -in $cer -inform DER -pubkey -noout 2>/dev/null \
+    | openssl asn1parse \
+    | grep BIT.STRING \
+    | cut -d: -f1)
+  if [ -z "$id" ]; then
+    echo "Cannot asn1parse $cer" >&2
+    exit 1
+  fi
+  openssl x509 ${ENGINE:+-engine $ENGINE} \
+      -in $cer -inform DER -pubkey -noout 2>/dev/null \
+    | openssl asn1parse -strparse $id -out - -noout \
+    | openssl dgst -c -sha1 \
+    | cut -d' ' -f2 \
+    | grep -o ":..:..:..:..$" \
+    | tr -d :
+}
+
+# Check that detached signature matches xattr signature
+_test_sigfile() {
+  local file=$1 file_sig=$2 file_sig2=$3
+
+  if [ ! -e $file_sig ]; then
+    red_if_pos
+    echo "evmctl ima_sign: no detached signature $file_sig"
+    norm_if_pos
+    rm $file
+    return $FAIL
+  fi
+
+  _extract_ima_xattr $file $file_sig2
+  #getfattr -n user.ima --only-values $file > $file_sig2
+  if ! cmp -bl $file_sig $file_sig2; then
+    red_if_pos
+    echo "evmctl ima_sign: xattr signature on $file differ from detached $file_sig"
+    norm_if_pos
+    rm $file $file_sig $file_sig2
+    return $FAIL
+  fi
+
+  rm $file_sig $file_sig2
+}
+
+_ima_sign() {
+  local key=$1 alg=$2 file=$3 opts=$4
+
+  FOR="$alg ($key.key)" DEL=$file \
+    _evmctl_run ima_sign $opts \
+      --hashalgo $alg --key $key.key --xattr-user --sigfile $file || return
+  _test_sigfile $file $file.sig $file.sig2
+}
+
+# Test RSA signature v1
+# This is simpler test than v2 tests as we don't try to verify
+# correctness of the signature here.
+check_rsa1() {
+  local key=test-rsa1024 alg=$1 pref=$2
+  local file=${alg}-v1.txt
+
+  # Append suffix to files for negative tests, because we need
+  # to leave only good files for ima_verify.test
+  _is_negative_test && file+='~'
+
+  rm -f $file
+  touch $file
+  _ima_sign $key $alg $file "--rsa" || return
+  FOR=$alg \
+    _test_ima_xattr $file $pref || return
+  return $OK
+}
+
+# Test RSA signature v2
+check_rsa2() {
+  local key=test-rsa1024 alg=$1 pref=$2
+  local file=$alg.txt
+
+  # Append suffix to files for negative tests, because we need
+  # to leave only good files for ima_verify.test
+  _is_negative_test && file+='~'
+  rm -f $file
+
+  keyid=$(keyid $key)
+  if [ $? -ne 0 -o -z "$keyid" ]; then
+    echo "Unable to determine keyid for $key"
+    return $HARDFAIL
+  fi
+  pref=$(echo $pref | sed "s/K/$keyid/")
+
+  # Calculate signature with openssl to compare later
+  if _is_positive_test && ! openssl dgst -$alg /dev/null >/dev/null 2>&1; then
+    echo $CYAN"$alg ($key.key) test is skipped (openssl cannot handle $alg digest)"$NORM
+    return $SKIP
+  fi
+  touch $file
+  cmd="openssl dgst -$alg -sign $key.key -hex $file"
+  echo - "$cmd"
+  sig=$(set -o pipefail; eval "$cmd" 2>/dev/null | cut -d' ' -f2)
+  if [ $? -ne 0 ] && _is_positive_test; then
+    echo $CYAN"$alg ($key.key) test is skipped (openssl cannot sign with $alg+$key.key)"$NORM
+    rm $file
+    return $SKIP
+  fi
+
+  _ima_sign $key $alg $file || return
+  FOR=$alg \
+    _test_ima_xattr $file $pref$sig || return
+  return $OK
+}
+
+# Test EC-RDSA signature v2
+check_ecrdsa() {
+  local key=test-$1 alg=$2 pref=$3
+
+  # Sign different files not only depending on alg hash algo,
+  # but also on alg key. Append curve letter to the hash algo.
+  curve=${key##*-}
+  file=$alg${curve,,}.txt
+
+  # Append suffix to files for negative tests, because we need
+  # to leave only good files for ima_verify.test
+  _is_negative_test && file+='~'
+  rm -f $file
+
+  # Older openssl unable to parse 512-bit EC-RDSA keys
+  if ! openssl pkey ${ENGINE:+-engine $ENGINE} -in $key.key >/dev/null 2>&1; then
+    echo $CYAN"$alg ($key.key) test is skipped"$NORM
+    return $SKIP
+  fi
+
+  keyid=$(keyid $key)
+  if [ $? -ne 0 ]; then
+    echo "Unable to determine keyid for $key"
+    return $HARDFAIL
+  fi
+  pref=$(echo $pref | sed "s/K/$keyid/")
+
+  touch $file
+  _ima_sign $key $alg $file || return
+  FOR="$alg ($key)" \
+    _test_ima_xattr $file $pref.* || return
+
+  _extract_ima_xattr $file $file.sig2 $pref
+
+  # Verify with openssl
+  cmd="openssl dgst ${ENGINE:+-engine $ENGINE} -$alg -verify $key.pub \
+	-signature $file.sig2 $file"
+  echo - "$cmd"
+  if ! eval "$cmd"; then
+    red_if_pos
+    echo "Signature verification with openssl is failed."
+    norm_if_pos
+    rm $file.sig2
+    return $FAIL
+  fi
+
+  rm $file.sig2
+  return $OK
+}
+
+set -f # disable globbing
+
+# check args: algo prefix hex-signature-prefix (K in place of keyid.)
+neg check_rsa1 md5    0x0301.*
+pos check_rsa1 sha1   0x0301.{290}
+pos check_rsa1 sha256 0x0301.{290}
+pos check_rsa2 md5    0x030201K0080
+pos check_rsa2 sha1   0x030202K0080
+pos check_rsa2 sha224 0x030207K0080
+pos check_rsa2 sha256 0x030204K0080
+pos check_rsa2 sha384 0x030205K0080
+pos check_rsa2 sha512 0x030206K0080
+pos check_rsa2 rmd160 0x030203K0080
+neg check_rsa2 noalgo 0x0302
+_enable_gost_engine
+pos check_ecrdsa gost2012_256-A md_gost12_256 0x030212K0040
+pos check_ecrdsa gost2012_256-B md_gost12_256 0x030212K0040
+pos check_ecrdsa gost2012_256-C md_gost12_256 0x030212K0040
+pos check_ecrdsa gost2012_512-A md_gost12_512 0x030213K0080
+pos check_ecrdsa gost2012_512-B md_gost12_512 0x030213K0080
+neg check_ecrdsa gost2012_256-A md_gost12_512 0x030212K0040
+neg check_ecrdsa gost2012_512-A md_gost12_256 0x030212K0040
+
+# This test leaves signed *.txt files for ima_verify.test.
+# they are never deleted except by `make clean'.
+_report_exit
diff --git a/tests/ima_verify.test b/tests/ima_verify.test
new file mode 100755
index 0000000..c85331d
--- /dev/null
+++ b/tests/ima_verify.test
@@ -0,0 +1,93 @@
+#!/bin/bash
+#
+# evmctl ima_verify tests
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
+_require evmctl openssl
+
+# Note: This test uses *.txt files signed by ima_sign.test as input.
+
+# Check with constant
+check() {
+  local key=$1 alg=$2 files=${@:3}
+
+  if ! openssl dgst ${ENGINE:+-engine $ENGINE} -$alg /dev/null >/dev/null 2>&1; then
+    echo $CYAN"$alg ($key.key) test is skipped (openssl does not support $alg)"$NORM
+    return $SKIP
+  fi
+
+  FOR="$files ($key)" \
+    _evmctl_run ima_verify --key $key --xattr-user $files
+}
+
+# Tests (check args: key hash-algo signed-file)
+for alg in sha1 sha256; do
+  file=$alg-v1.txt
+
+  pos check test-rsa1024.pub $alg $file
+  neg check test-rsa2048.pub $alg $file
+  neg check /dev/null $alg $file
+  neg check /dev/zero $alg $file
+done
+
+for alg in md5 sha1 sha224 sha256 sha384 sha512 rmd160; do
+  file=$alg.txt
+
+  if [ ! -e $file ]; then
+    echo $CYAN"Signed file $file is not found. Skipping verify $alg test."$NORM
+    testsskip+=1
+    continue
+  fi
+  pos check test-rsa1024.cer $alg $file
+  neg check test-rsa1024.cer $alg /dev/null /proc/absent $file
+  neg check test-rsa1024.cer $alg $file /dev/null /proc/absent
+  pos check test-rsa1024.cer $alg $file $prev
+  pos check test-rsa1024.cer $alg $prev $file
+  pos check /dev/zero,test-rsa1024.cer $alg $file
+  pos check /dev/null,test-rsa1024.cer $alg $file
+  pos check test-rsa1024.cer,test-rsa2048.cer $alg $file
+  pos check test-rsa2048.cer,test-rsa1024.cer $alg $file
+  pos check ,,test-rsa1024.cer $alg $file
+  neg check test-rsa2048.cer $alg $file
+  neg check /dev/absent $alg $file
+  neg check /dev/null $alg $file
+  neg check /dev/zero $alg $file
+  prev=$file
+done
+
+_enable_gost_engine
+wk=test-gost2012_512-B.cer # wrong key (other than first)
+for key in gost2012_256-A gost2012_256-B gost2012_256-C \
+	   gost2012_512-A gost2012_512-B; do
+  tmp=${key#gost2012_}
+  bits=${tmp%-?}	  # correct bit length
+  wbits=$(( $bits == 256 ? 512 : 256 )) # wrong bit length
+  curve=${key#*-}	  # curve letter
+  alg=md_gost12_$bits	  # proper hash algo
+  file=$alg${curve,,}.txt # file signed in ima_sign test
+  key=test-$key.cer	  # correct key in a cert
+  wwk=test-gost2012_$wbits-$curve.cer # key with wrong bit length
+
+  pos check $key     $alg $file
+  pos check $wk,$key $alg $file
+  pos check $key,$wk $alg $file
+  neg check $wk    $alg $file
+  neg check $wwk   $alg $file
+  wk=$key # previous key is always wrong
+done
+
+_report_exit
-- 
2.11.0

