Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A713B3E5C12
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbhHJNqY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241831AbhHJNqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADafiv014188
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=LD57shOZxkdCJAg6arxVDxENX9rlGvSNd3eeLcaNG7M=;
 b=CXRoDHGQmA8rAQJXpVEKzvAjKjYCDD/tG/g6WSqS3sh5Wmi/ABTdaGsmvquIv0qFa/74
 TBnbAfQnKm9pGvzgp6p44aTU2JGQCsrx5Kpgz9ZpnJA4RTONIPa4LibnDKEudGu7qqHe
 +4cEpgYgSMizEG2zYgB+5741G92h5aGm3MAmQGAkTooZI+BOoQH5LnJTQDUZSqHjcWBZ
 cPcj1uG2CuesxIJoL+aWKc5YZdwwgz3BET/cy6qGqbYMVSOrnc6AK4gaYHugc0m3ki/Z
 aR44ejJxDrVl80y0SIfBeMixpsoJlkJQDoAonJmrLbHIol4ZRrv+ne0eF5YMy7Lkwz4K kw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abt6agu5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADhYk8006340
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3a9htc3y0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxq741943500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98A65B2068;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86B3EB2072;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 7/8] tests: Extend sign_verify test with pkcs11-specific test
Date:   Tue, 10 Aug 2021 09:45:56 -0400
Message-Id: <20210810134557.2444863-8-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cK8eBDOIim21mrFCMLTcLVqm9aEbhxmu
X-Proofpoint-ORIG-GUID: cK8eBDOIim21mrFCMLTcLVqm9aEbhxmu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=938
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Extend the sign_verify test with a pkcs11-specific test.
Import softhsm_setup script from my swtpm project and contribute
it to this porject under dual license BSD 3-clause and GLP 2.0.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functions.sh     |  26 ++++
 tests/sign_verify.test |  50 +++++--
 tests/softhsm_setup    | 290 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 352 insertions(+), 14 deletions(-)
 create mode 100755 tests/softhsm_setup

diff --git a/tests/functions.sh b/tests/functions.sh
index 91cd5d9..cbb7ea4 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -272,3 +272,29 @@ _report_exit() {
   fi
 }
 
+_at_exit() {
+  _report_exit
+  if [ -n "${WORKDIR}" ]; then
+    rm -f "${WORKDIR}"
+  fi
+}
+
+_softhsm_setup() {
+  local workdir="$1"
+
+  local msg
+
+  export SOFTHSM_SETUP_CONFIGDIR="${workdir}"
+  export SOFTHSM2_CONF="${workdir}/softhsm2.conf"
+
+  msg=$(./softhsm_setup setup 2>&1)
+  if [ $? -eq 0 ]; then
+    echo "softhsm_setup setup succeeded: $msg"
+    PKCS11_KEYURI=$(echo $msg | sed -n 's|^keyuri: \(.*\)|\1|p')
+
+    export OPENSSL_ENGINE="-engine pkcs11"
+    export OPENSSL_KEYFORM="-keyform engine"
+  else
+    echo "softhsm_setup setup failed: ${msg}"
+  fi
+}
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 3b42eec..369765e 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -28,7 +28,8 @@ fi
 
 ./gen-keys.sh >/dev/null 2>&1
 
-trap _report_exit EXIT
+trap _at_exit EXIT
+WORKDIR=$(mktemp -d)
 set -f # disable globbing
 
 # Determine keyid from a cert
@@ -132,11 +133,16 @@ check_sign() {
   # OPTS (additional options for evmctl),
   # FILE (working file to sign).
   local "$@"
-  local KEY=${KEY%.*}.key
+  local key verifykey
   local FILE=${FILE:-$ALG.txt}
 
-  # Normalize key filename
-  KEY=test-${KEY#test-}
+  # Normalize key filename if it's not a pkcs11 URI
+  if [ ${KEY:0:7} != pkcs11: ]; then
+    key=${KEY%.*}.key
+    key=test-${key#test-}
+  else
+    key=${KEY}
+  fi
 
   # Append suffix to files for negative tests, because we may
   # leave only good files for verify tests.
@@ -152,33 +158,33 @@ check_sign() {
 
   if _test_expected_to_pass; then
     # Can openssl work with this digest?
-    cmd="openssl dgst $OPENSSL_ENGINE -$ALG $FILE"
+    cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG $FILE"
     echo - "$cmd"
     if ! $cmd >/dev/null; then
-      echo "${CYAN}$ALG ($KEY) test is skipped (openssl is unable to digest)$NORM"
+      echo "${CYAN}$ALG ($key) test is skipped (openssl is unable to digest)$NORM"
       return "$SKIP"
     fi
 
-    if [ ! -e "$KEY" ]; then
-      echo "${CYAN}$ALG ($KEY) test is skipped (key file not found)$NORM"
+    if [ "${key:0:7}" != pkcs11: ] && [ ! -e "$key" ]; then
+      echo "${CYAN}$ALG ($key) test is skipped (key file not found)$NORM"
       return "$SKIP"
     fi
 
     # Can openssl sign with this digest and key?
-    cmd="openssl dgst $OPENSSL_ENGINE -$ALG -sign $KEY -hex $FILE"
+    cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -sign $key -hex $FILE"
     echo - "$cmd"
     if ! $cmd >/dev/null; then
-      echo "${CYAN}$ALG ($KEY) test is skipped (openssl is unable to sign)$NORM"
+      echo "${CYAN}$ALG ($key) test is skipped (openssl is unable to sign)$NORM"
       return "$SKIP"
     fi
   fi
 
   # Insert keyid from cert into PREFIX in-place of marker `:K:'
   if [[ $PREFIX =~ :K: ]]; then
-    keyid=$(_keyid_from_cert "$KEY")
+    keyid=$(_keyid_from_cert "$key")
     if [ $? -ne 0 ]; then
       color_red
-      echo "Unable to determine keyid for $KEY"
+      echo "Unable to determine keyid for $key"
       color_restore
       return "$HARDFAIL"
     fi
@@ -187,7 +193,7 @@ check_sign() {
   fi
 
   # Perform signing by evmctl
-  _evmctl_sign "$TYPE" "$KEY" "$ALG" "$FILE" "$OPTS" || return
+  _evmctl_sign "$TYPE" "$key" "$ALG" "$FILE" "$OPTS" || return
 
   # First simple pattern match the signature.
   ADD_TEXT_FOR=$ALG \
@@ -207,7 +213,13 @@ check_sign() {
   _extract_xattr "$FILE" "$(_xattr "$TYPE")" "$FILE.sig2" "$PREFIX"
 
   # Verify extracted signature with openssl
-  cmd="openssl dgst $OPENSSL_ENGINE -$ALG -verify ${KEY%.*}.pub \
+  if [ "${key:0:7}" != pkcs11: ]; then
+      verifykey=${key%.*}.pub
+  else
+      verifykey=${key}
+  fi
+
+  cmd="openssl dgst $OPENSSL_ENGINE $OPENSSL_KEYFORM -$ALG -verify ${verifykey} \
 	-signature $FILE.sig2 $FILE"
   echo - "$cmd"
   if ! $cmd; then
@@ -413,3 +425,13 @@ expect_fail \
 expect_fail \
   check_sign TYPE=ima KEY=gost2012_256-B ALG=md_gost12_512 PREFIX=0x0302 OPTS=
 
+_softhsm_setup "${WORKDIR}"
+if [ -n "${PKCS11_KEYURI}" ]; then
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY=${PKCS11_KEYURI} ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS=--keyid=aabbccdd
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY=${PKCS11_KEYURI} ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS=--keyid=aabbccdd
+else
+  # skip these two tests
+  __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return $SKIP; }
+  expect_pass __skip
+  expect_pass __skip
+fi
diff --git a/tests/softhsm_setup b/tests/softhsm_setup
new file mode 100755
index 0000000..f89a2e6
--- /dev/null
+++ b/tests/softhsm_setup
@@ -0,0 +1,290 @@
+#!/usr/bin/env bash
+
+# This program originates from 'swtpm' project (https://github.com/stefanberger/swtpm/)
+# and is provided to ima-evm-utils under a dual license:
+# - BSD 3-clause
+# - GPL-2.0
+
+# This script may not work with softhsm2 2.0.0 but with >= 2.2.0
+
+if [ -z "$(type -P p11tool)" ]; then
+	echo "Need p11tool from gnutls"
+	exit 77
+fi
+
+if [ -z "$(type -P softhsm2-util)" ]; then
+	echo "Need softhsm2-util from softhsm2 package"
+	exit 77
+fi
+
+NAME=swtpm-test
+PIN=${PIN:-1234}
+SO_PIN=${SO_PIN:-1234}
+SOFTHSM_SETUP_CONFIGDIR=${SOFTHSM_SETUP_CONFIGDIR:-~/.config/softhsm2}
+export SOFTHSM2_CONF=${SOFTHSM_SETUP_CONFIGDIR}/softhsm2.conf
+
+UNAME_S="$(uname -s)"
+
+case "${UNAME_S}" in
+Darwin)
+	msg=$(sudo -v -n)
+	if [ $? -ne 0 ]; then
+		echo "Need password-less sudo rights on OS X to change /etc/gnutls/pkcs11.conf"
+		exit 1
+	fi
+	;;
+esac
+
+teardown_softhsm() {
+	local configdir=${SOFTHSM_SETUP_CONFIGDIR}
+	local configfile=${SOFTHSM2_CONF}
+	local bakconfigfile=${configfile}.bak
+	local tokendir=${configdir}/tokens
+
+	softhsm2-util --token "${NAME}" --delete-token &>/dev/null
+
+	case "${UNAME_S}" in
+	Darwin*)
+		if [ -f /etc/gnutls/pkcs11.conf.bak ]; then
+			sudo rm -f /etc/gnutls/pkcs11.conf
+			sudo mv /etc/gnutls/pkcs11.conf.bak \
+			   /etc/gnutls/pkcs11.conf &>/dev/null
+		fi
+		;;
+	esac
+
+	if [ -f "$bakconfigfile" ]; then
+		mv "$bakconfigfile" "$configfile"
+	else
+		rm -f "$configfile"
+	fi
+	if [ -d "$tokendir" ]; then
+		rm -rf "${tokendir}"
+	fi
+	return 0
+}
+
+setup_softhsm() {
+	local msg tokenuri keyuri
+	local configdir=${SOFTHSM_SETUP_CONFIGDIR}
+	local configfile=${SOFTHSM2_CONF}
+	local bakconfigfile=${configfile}.bak
+	local tokendir=${configdir}/tokens
+	local rc
+
+	case "${UNAME_S}" in
+	Darwin*)
+		if [ -f /etc/gnutls/pkcs11.conf.bak ]; then
+			echo "/etc/gnutls/pkcs11.conf.bak already exists; need to 'teardown' first"
+			return 1
+		fi
+		sudo mv /etc/gnutls/pkcs11.conf \
+			/etc/gnutls/pkcs11.conf.bak &>/dev/null
+		if [ $(id -u) -eq 0 ]; then
+			SONAME="$(sudo -u nobody brew ls --verbose softhsm | \
+				  grep -E "\.so$")"
+		else
+			SONAME="$(brew ls --verbose softhsm | \
+				  grep -E "\.so$")"
+		fi
+		sudo mkdir -p /etc/gnutls &>/dev/null
+		sudo bash -c "echo "load=${SONAME}" > /etc/gnutls/pkcs11.conf"
+		;;
+	esac
+
+	if ! [ -d $configdir ]; then
+		mkdir -p $configdir
+	fi
+	mkdir -p ${tokendir}
+
+	if [ -f $configfile ]; then
+		mv "$configfile" "$bakconfigfile"
+	fi
+
+	if ! [ -f $configfile ]; then
+		cat <<_EOF_ > $configfile
+directories.tokendir = ${tokendir}
+objectstore.backend = file
+log.level = DEBUG
+slots.removable = false
+_EOF_
+	fi
+
+	msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}" | tail -n1)
+	if [ $? -ne 0 ]; then
+		echo "Could not list existing tokens"
+		echo "$msg"
+	fi
+	tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+
+	if [ -z "$tokenuri" ]; then
+		msg=$(softhsm2-util \
+			--init-token --pin ${PIN} --so-pin ${SO_PIN} \
+			--free --label ${NAME} 2>&1)
+		if [ $? -ne 0 ]; then
+			echo "Could not initialize token"
+			echo "$msg"
+			return 2
+		fi
+
+		slot=$(echo "$msg" | \
+		       sed -n 's/.* reassigned to slot \([0-9]*\)$/\1/p')
+		if [ -z "$slot" ]; then
+			slot=$(softhsm2-util --show-slots | \
+			       grep -E "^Slot " | head -n1 |
+			       sed -n 's/Slot \([0-9]*\)/\1/p')
+			if [ -z "$slot" ]; then
+				echo "Could not parse slot number from output."
+				echo "$msg"
+				return 3
+			fi
+		fi
+
+		msg=$(p11tool --list-tokens 2>&1 | \
+			grep "token=${NAME}" | tail -n1)
+		if [ $? -ne 0 ]; then
+			echo "Could not list existing tokens"
+			echo "$msg"
+		fi
+		tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+		if [ -z "${tokenuri}" ]; then
+			echo "Could not get tokenuri!"
+			return 4
+		fi
+
+		# more recent versions of p11tool have --generate-privkey ...
+		msg=$(GNUTLS_PIN=$PIN p11tool \
+			--generate-privkey=rsa --bits 2048 --label mykey --login \
+			"${tokenuri}" 2>&1)
+		if [ $? -ne 0 ]; then
+			# ... older versions have --generate-rsa
+			msg=$(GNUTLS_PIN=$PIN p11tool \
+				--generate-rsa --bits 2048 --label mykey --login \
+				"${tokenuri}" 2>&1)
+			if [ $? -ne 0 ]; then
+				echo "Could not create RSA key!"
+				echo "$msg"
+				return 5
+			fi
+		fi
+	fi
+
+	getkeyuri_softhsm $slot
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		teardown_softhsm
+	fi
+
+	return $rc
+}
+
+_getkeyuri_softhsm() {
+	local msg tokenuri keyuri
+
+	msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}")
+	if [ $? -ne 0 ]; then
+		echo "Could not list existing tokens"
+		echo "$msg"
+		return 5
+	fi
+	tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+	if [ -z "$tokenuri" ]; then
+		echo "Could not get token URL"
+		echo "$msg"
+		return 6
+	fi
+	msg=$(p11tool --list-all ${tokenuri} 2>&1)
+	if [ $? -ne 0 ]; then
+		echo "Could not list object under token $tokenuri"
+		echo "$msg"
+		softhsm2-util --show-slots
+		return 7
+	fi
+
+	keyuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
+	if [ -z "$keyuri" ]; then
+		echo "Could not get key URL"
+		echo "$msg"
+		return 8
+	fi
+	echo "$keyuri"
+	return 0
+}
+
+getkeyuri_softhsm() {
+	local keyuri rc
+
+	keyuri=$(_getkeyuri_softhsm)
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		return $rc
+	fi
+	echo "keyuri: $keyuri?pin-value=${PIN}" #&module-name=softhsm2"
+	return 0
+}
+
+getpubkey_softhsm() {
+	local keyuri rc
+
+	keyuri=$(_getkeyuri_softhsm)
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		return $rc
+	fi
+	GNUTLS_PIN=${PIN} p11tool --export-pubkey "${keyuri}" --login 2>/dev/null
+	return $?
+}
+
+usage() {
+	cat <<_EOF_
+Usage: $0 [command]
+
+Supported commands are:
+
+setup      : Setup the user's account for softhsm and create a
+             token and key with a test configuration
+
+getkeyuri  : Get the key's URI; may only be called after setup
+
+getpubkey  : Get the public key in PEM format; may only be called after setup
+
+teardown   : Remove the temporary softhsm test configuration
+
+_EOF_
+}
+
+main() {
+	local ret
+
+	if [ $# -lt 1 ]; then
+		usage $0
+		echo -e "Missing command.\n\n"
+		return 1
+	fi
+	case "$1" in
+	setup)
+		setup_softhsm
+		ret=$?
+		;;
+	getkeyuri)
+		getkeyuri_softhsm
+		ret=$?
+		;;
+	getpubkey)
+		getpubkey_softhsm
+		ret=$?
+		;;
+	teardown)
+		teardown_softhsm
+		ret=$?
+		;;
+	*)
+		echo -e "Unsupported command: $1\n\n"
+		usage $0
+		ret=1
+	esac
+	return $ret
+}
+
+main "$@"
+exit $?
-- 
2.31.1

