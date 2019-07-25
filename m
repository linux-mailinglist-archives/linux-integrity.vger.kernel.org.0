Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7A74723
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfGYG0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 02:26:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42344 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfGYG0w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 02:26:52 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 410C072CC6C;
        Thu, 25 Jul 2019 09:18:57 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0FA254A4AE8;
        Thu, 25 Jul 2019 09:18:57 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH] ima-evm-utils: Add some tests for evmctl
Date:   Thu, 25 Jul 2019 09:18:55 +0300
Message-Id: <20190725061855.3734-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Run `make check' to execute the tests.
Currently only ima_hash, ima_sign (v2), and ima_verify are tested.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 Makefile.am           |   2 +-
 configure.ac          |   1 +
 tests/Makefile.am     |  14 ++++
 tests/functions       | 135 ++++++++++++++++++++++++++++++++++++
 tests/gen-keys.sh     |  75 ++++++++++++++++++++
 tests/ima_hash.test   |  84 +++++++++++++++++++++++
 tests/ima_sign.test   | 186 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ima_verify.test |  79 +++++++++++++++++++++
 8 files changed, 575 insertions(+), 1 deletion(-)
 create mode 100644 tests/Makefile.am
 create mode 100755 tests/functions
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
index 0000000..8c6256c
--- /dev/null
+++ b/tests/Makefile.am
@@ -0,0 +1,14 @@
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
+distclean: distclean-keys
+.PHONY: distclean-keys
+distclean-keys:
+	-rm -f *.pub *.key *.cer
diff --git a/tests/functions b/tests/functions
new file mode 100755
index 0000000..7ad6c7c
--- /dev/null
+++ b/tests/functions
@@ -0,0 +1,135 @@
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
+declare -i pass=0 fail=0 skip=0
+
+_require() {
+  RET=
+  for i; do
+    if ! type $i; then
+      echo "$i is required for test"
+      RET=1
+    fi
+  done
+  [ $RET ] && exit 99
+}
+
+if tty -s; then
+     RED=$'\e[1;31m'
+  YELLOW=$'\e[1;33m'
+    BLUE=$'\e[1;34m'
+    NORM=$'\e[m'
+fi
+
+# Define EXITEARLY to exit testing on the first error.
+exit_early() {
+  if [ $EXITEARLY ]; then
+    exit $1
+  fi
+}
+
+# Defaults
+MODE=+
+HOWFAILED=
+pos() {
+  MODE=+
+  HOWFAILED=
+  eval "$@"
+  case $? in
+    0)  pass+=1 ;;
+    77) skip+=1 ;;
+    99) fail+=1; exit_early 1 ;;
+    *)  fail+=1; exit_early 2 ;;
+  esac
+}
+
+neg() {
+  MODE=-
+  HOWFAILED=properly
+  eval "$@"
+  case $? in
+    0)  fail+=1; exit_early 3 ;;
+    77) skip+=1 ;;
+    99) fail+=1; exit_early 4 ;;
+    *)  pass+=1 ;;
+  esac
+# Restore defaults
+  MODE=+
+  HOWFAILED=
+}
+
+_ispos() {
+  [ -z "$HOWFAILED" ]
+}
+
+_isneg() {
+  [ "$HOWFAILED" ]
+}
+
+red_if_pos() {
+  _ispos && echo $@ $RED
+}
+
+norm_if_pos() {
+  _ispos && echo $@ $NORM
+}
+
+_evmctl_catch() {
+  local ret=$1 out=$2 cmd=$3 for=$4 del=${@:5}
+
+  if [ $ret -gt 128 -a $ret -lt 255 ]; then
+    echo $RED
+    echo "evmctl $cmd failed hard with $ret for $for"
+    sed 's/^/  /' $out
+    echo $NORM
+    rm -f $out $del
+    return 99
+  elif [ $ret -gt 0 ]; then
+    red_if_pos
+    echo "evmctl $cmd failed" $HOWFAILED "with $ret for $for"
+    sed 's/^/  /' $out
+    norm_if_pos
+    rm -f $out $del
+    return 1
+  elif [ -n "$HOWFAILED" ]; then
+    echo $RED
+    echo "evmctl $cmd wrongly succeeded for $for"
+    sed 's/^/  /' $out
+    echo $NORM
+  fi
+  rm -f $out
+  return 0
+}
+
+_enable_gost_engine() {
+  # Do not enable if it already enabled by user
+  if ! openssl md_gost12_256 /dev/null >/dev/null 2>&1 \
+    && openssl engine gost >/dev/null 2>&1; then
+    ENGINE=gost
+  fi
+}
+
+_report_exit() {
+  echo "PASS: $pass SKIP: $skip FAIL: $fail"
+  if [ $fail -gt 0 ]; then
+    exit 1
+  elif [ $pass -gt 0 ]; then
+    exit 0
+  else
+    exit 77
+  fi
+}
+
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
new file mode 100755
index 0000000..c4073a2
--- /dev/null
+++ b/tests/gen-keys.sh
@@ -0,0 +1,75 @@
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
+if [ ! -e test-ca.conf ]; then
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
+  if [ ! -e test-rsa$m.key ]; then
+    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
+      -config test-ca.conf \
+      -newkey rsa:$m \
+      -out test-rsa$m.cer -outform DER \
+      -keyout test-rsa$m.key
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
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
new file mode 100755
index 0000000..cf4af57
--- /dev/null
+++ b/tests/ima_hash.test
@@ -0,0 +1,84 @@
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
+source ./functions
+_require evmctl openssl
+
+# Check with constant
+check_const() {
+  local a=$1 p=$2 h=$3 f=$4
+
+  cmd=(evmctl ima_hash -v ${ENGINE:+--engine $ENGINE} -a $a --xattr-user $f)
+  echo $YELLOW$MODE "${cmd[@]}" $NORM
+  eval "${cmd[@]}" >$a.out 2>&1
+  _evmctl_catch $? $a.out ima_hash $a $f || return
+
+  if ! getfattr -n user.ima -e hex $f | grep -qx user.ima=$p$h; then
+    red_if_pos
+    echo "Did not find expected hash value for $a:"
+    echo "    user.ima=$p$h"
+    echo ""
+    echo "Actual output below:"
+    getfattr -n user.ima -e hex $f | sed 's/^/    /'
+    norm_if_pos
+    rm -f $f
+    return 1
+  fi
+  rm -f $f
+  return 0
+}
+
+check() {
+  local a=$1 p=$2 h=$3
+  local f=$a-hash.txt
+
+  rm -f $f
+  touch $f
+  cmd=(openssl dgst ${ENGINE:+--engine $ENGINE} -$a $f)
+  echo $BLUE - "${cmd[@]}" $NORM
+  h=$(set -o pipefail; eval "${cmd[@]}" 2>/dev/null | cut -d' ' -f2)
+  if [ $? -ne 0 -a -z "$HOWFAILED" ]; then
+    echo "$a test is skipped"
+    rm -f $f
+    return 77
+  fi
+  check_const $a $p "$h" $f
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
index 0000000..5d8edd5
--- /dev/null
+++ b/tests/ima_sign.test
@@ -0,0 +1,186 @@
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
+source ./functions
+_require evmctl openssl xxd getfattr
+./gen-keys.sh >/dev/null 2>&1
+
+# Determine keyid from .cer
+keyid() {
+  id=$(openssl x509 ${ENGINE:+-engine $ENGINE} \
+      -in $1.cer -inform DER -pubkey -noout 2>/dev/null \
+    | openssl asn1parse \
+    | grep BIT.STRING \
+    | cut -d: -f1)
+  if [ -z "$id" ]; then
+    echo "Cannot asn1parse $1.cer" >&2
+    exit 1
+  fi
+  openssl x509 ${ENGINE:+-engine $ENGINE} \
+      -in $1.cer -inform DER -pubkey -noout 2>/dev/null \
+    | openssl asn1parse -strparse $id -out - -noout \
+    | openssl dgst -c -sha1 \
+    | cut -d' ' -f2 \
+    | grep -o ":..:..:..:..$" \
+    | tr -d :
+}
+
+_ima_sign() {
+  local k=$1 a=$2 f=$3
+
+  cmd=(evmctl ima_sign ${ENGINE:+--engine $ENGINE} -a $a \
+	   -k $k.key --xattr-user --sigfile $f)
+  echo $YELLOW$MODE ${cmd[@]} $NORM
+  eval "${cmd[@]}" >$a.out 2>&1
+  _evmctl_catch $? $a.out ima_sign "$a ($k.key)" $f || return
+
+  # Check that detached signature matches xattr signature
+  if [ ! -e $f.sig ]; then
+    echo "evmctl ima_sign: no detached signature $f.sig"
+    return 1
+  fi
+
+  getfattr -n user.ima --only-values $f > $f.sig2
+  if ! cmp -bl $f.sig $f.sig2; then
+    echo "evmctl ima_sign: xattr signature differ from detached $f.sig"
+    rm -f $f.sig $f.sig2
+    return 1
+  fi
+
+  rm -f $f.sig $f.sig2
+}
+
+check_rsa() {
+  local k=test-rsa1024 a=$1 p=$2
+  local f=$a.txt
+
+  # Append suffix to files for negative tests, because we need
+  # to leave only good files for ima_verify.test
+  _isneg && f+=-
+  rm -f $f
+
+  keyid=$(keyid $k)
+  if [ $? -ne 0 ]; then
+    echo "Unable to determine keyid for $k"
+    return 99
+  fi
+  p=$(echo $p | sed "s/K/$keyid/")
+
+  if ! openssl dgst -$a /dev/null >/dev/null 2>&1; then
+    echo "$a ($k.key) test is skipped (openssl cannot handle $a digest)"
+    return 77
+  fi
+  touch $f
+  cmd=(openssl dgst -$a -sign $k.key -hex $f)
+  echo $BLUE - "${cmd[@]}" $NORM
+  sig=$(set -o pipefail; eval "${cmd[@]}" 2>/dev/null | cut -d' ' -f2)
+  if [ $? -ne 0 ] && _ispos; then
+    echo "$a ($k.key) test is skipped (openssl cannot sign with $a+$k.key)"
+    rm -f $f
+    return 77
+  fi
+
+  _ima_sign $k $a $f || return
+  if ! getfattr -n user.ima -e hex $f | grep -qx user.ima=$p$sig; then
+    red_if_pos
+    echo "Did not find expected hash value for $a:"
+    echo "    user.ima=$p$sig"
+    echo ""
+    echo "Actual output below:"
+    getfattr -n user.ima -e hex $f | sed 's/^/    /'
+    norm_if_pos
+    rm -f $f
+    return 1
+  fi
+  return 0
+}
+
+check_ecrdsa() {
+  local k=$1 a=$2 p=$3
+
+  # Sign different files not only depending on a hash algo,
+  # but also on a key. Append curve letter to the hash algo.
+  curve=${k##*-}
+  f=$a${curve,,}.txt
+
+  # Append suffix to files for negative tests, because we need
+  # to leave only good files for ima_verify.test
+  _isneg && f+=-
+  rm -f $f
+
+  # Older openssl unable to parse 512-bit keys
+  if ! openssl pkey ${ENGINE:+-engine $ENGINE} -in $k.key >/dev/null 2>&1; then
+    echo "$a ($k.key) test is skipped"
+    return 77
+  fi
+
+  keyid=$(keyid $k)
+  if [ $? -ne 0 ]; then
+    echo "Unable to determine keyid for $k"
+    return 99
+  fi
+  p=$(echo $p | sed "s/K/$keyid/")
+
+  touch $f
+  _ima_sign $k $a $f || return
+  # Only verify prefix here.
+  if ! getfattr -n user.ima -e hex $f | grep -q ^user.ima=$p; then
+    red_if_pos
+    echo "Signature prefix does not match for $a ($k):"
+    echo "Expected:  user.ima=$p..."
+    echo ""
+    echo "Actual output below:"
+    getfattr -n user.ima -e hex $f | sed 's/^/    /'
+    norm_if_pos
+    rm -f $f
+    return 1
+  fi
+
+  # Extract signature from xattr
+  getfattr -n user.ima -e hex $f \
+    | grep ^user.ima= \
+    | sed s/^user.ima=$p// \
+    | xxd -r -p > $a.sig2
+
+  # Verify with openssl
+  if ! openssl dgst ${ENGINE:+-engine $ENGINE} -$a \
+	-verify $k.pub -signature $a.sig2 $f >/dev/null 2>&1; then
+    return 1
+  fi
+  rm $a.sig2
+}
+
+# check args: algo prefix hex-signature-prefix (K in place of keyid.)
+pos check_rsa md5    0x030201K0080
+pos check_rsa sha1   0x030202K0080
+pos check_rsa sha224 0x030207K0080
+pos check_rsa sha256 0x030204K0080
+pos check_rsa sha384 0x030205K0080
+pos check_rsa sha512 0x030206K0080
+pos check_rsa rmd160 0x030203K0080
+neg check_rsa invalid-hash-algo  0x030202K0080
+_enable_gost_engine
+pos check_ecrdsa test-gost2012_256-A md_gost12_256 0x030212K0040
+pos check_ecrdsa test-gost2012_256-B md_gost12_256 0x030212K0040
+pos check_ecrdsa test-gost2012_256-C md_gost12_256 0x030212K0040
+pos check_ecrdsa test-gost2012_512-A md_gost12_512 0x030213K0080
+pos check_ecrdsa test-gost2012_512-B md_gost12_512 0x030213K0080
+neg check_ecrdsa test-gost2012_256-A md_gost12_512 0x030212K0040
+neg check_ecrdsa test-gost2012_512-A md_gost12_256 0x030212K0040
+
+_report_exit
diff --git a/tests/ima_verify.test b/tests/ima_verify.test
new file mode 100755
index 0000000..6a9c876
--- /dev/null
+++ b/tests/ima_verify.test
@@ -0,0 +1,79 @@
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
+source ./functions
+_require evmctl openssl
+
+# Check with constant
+check() {
+  local k=$1 a=$2 f=$3
+
+  if [ ! -e $f ]; then
+    echo "Signed file $f is not found. Skipping verify $a ($k) test."
+    return 77
+  fi
+  if ! openssl dgst ${ENGINE:+--engine $ENGINE} -$a /dev/null >/dev/null 2>&1; then
+    echo "$a ($k.key) test is skipped (openssl does not support $a)"
+    rm -f $f
+    return 77
+  fi
+
+  cmd=(evmctl ima_verify ${ENGINE:+--engine $ENGINE} -v -k $k --xattr-user $f)
+  echo $YELLOW$MODE "${cmd[@]}" $NORM
+  eval "${cmd[@]}" >$f.out 2>&1
+  _evmctl_catch $? $f.out ima_verify "$f ($k)"
+}
+
+# Tests (check args: key hash-algo signed-file
+for a in md5 sha1 sha224 sha256 sha384 sha512 rmd160; do
+  f=$a.txt
+  pos check test-rsa1024.cer $a $f
+  pos check /dev/zero,test-rsa1024.cer $a $f
+  pos check /dev/null,test-rsa1024.cer $a $f
+  pos check test-rsa1024.cer,test-rsa2048.cer $a $f
+  pos check test-rsa2048.cer,test-rsa1024.cer $a $f
+  pos check ,,test-rsa1024.cer $a $f
+  pos check test-rsa1024.cer,,, $a $f
+  neg check test-rsa2048.cer $a $f
+  neg check /dev/absent $a $f
+  neg check /dev/null $a $f
+  neg check /dev/zero $a $f
+done
+
+_enable_gost_engine
+wk=test-gost2012_512-B.cer # first wrong key
+for k in gost2012_256-A gost2012_256-B gost2012_256-C \
+         gost2012_512-A gost2012_512-B; do
+  tmp=${k#gost2012_}
+  bits=${tmp%-?}
+  wbits=$(( $bits == 256 ? 512 : 256 ))
+  curve=${k#*-}
+  a=md_gost12_$bits   # proper hash algo
+  f=$a${curve,,}.txt  # file signed in ima_sign test
+  k=test-$k.cer
+  wwk=test-gost2012_$wbits-$curve.cer # key with wrong bit length
+
+  pos check $k     $a $f
+  pos check $wk,$k $a $f
+  pos check $k,$wk $a $f
+  neg check $wk    $a $f
+  neg check $wwk   $a $f
+  wk=$k # previous key is always wrong
+done
+
+_report_exit
-- 
2.11.0

