Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15D403FCC
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbhIHTZA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:25:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350419AbhIHTY4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J3Rfa148867
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=1KJ1U3M+dP8i8vSjcgIpYBpFLpe7t4UEdU5aZ/BQJhM=;
 b=YzXiYlqgyLxT1jqI+kFSOgDfsKjvfDE1hbtUt0TaLbwA1nSNYuxDMPFinav3nAd22MCV
 8PUZ/S133n1Ivf3Ctqb2CzTkwg0lgLEtLeKiVSJFnSJOE4tJXry9k4A2GuBgwZJvOevk
 K7rXfCj9V5GnyUPuDBWBP/keKE79XiDx7NYhg6jFQBS4XVOn+z6FEqoeEbVD4YDl82YX
 +C6oilq18o8dHqVUbYCmuJgqpw1ZuqBAqTNdbixy7oCGZ2Imro6KNUuf5zYaJ4W6aHSu
 0AqTJfjX5kbr+wTf3WcFA19merphtNHOCfT5eYSLtiknClTInInH5feG+TV5WiYVsbCD rA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ay2xwrddm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JHKl8017686
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3axcnnuhff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNkls46858506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54BE11206E;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC558112062;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 8/9] tests: Extend sign_verify test with pkcs11-specific test
Date:   Wed,  8 Sep 2021 15:23:42 -0400
Message-Id: <20210908192343.4147739-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HDOIU4FXR8UmmPhxEUz1r2Sc9VILjv60
X-Proofpoint-ORIG-GUID: HDOIU4FXR8UmmPhxEUz1r2Sc9VILjv60
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Extend the sign_verify test with a pkcs11-specific test.

Since the openssl command line tool now needs to use a key provided by
an engine, extend some command lines with the additional parameters
'--keyform engine'. These parameters are passed using the global variable
OPENSSL_KEYFORM, which is only set when pkcs11 URIs are used.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functions.sh     | 45 ++++++++++++++++++++++++++++++++++++
 tests/sign_verify.test | 52 ++++++++++++++++++++++++++++++------------
 2 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 91cd5d9..dce278b 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -272,3 +272,48 @@ _report_exit() {
   fi
 }
 
+# Cleanups when exiting
+_at_exit() {
+  _report_exit
+  if [ -n "${WORKDIR}" ]; then
+    rm -f "${WORKDIR}"
+  fi
+}
+
+# Setup SoftHSM for local testing by calling the softhsm_setup script.
+# Use the provided workdir as the directory where SoftHSM will store its state
+# into.
+# Upon successfully setting up SoftHSM, this function sets the global variables
+# OPENSSL_ENGINE and OPENSSL_KEYFORM so that the openssl command line tool can
+# use SoftHSM. Also the PKCS11_KEYURI global variable is set to the test key's
+# pkcs11 URI.
+_softhsm_setup() {
+  local workdir="$1"
+
+  local msg
+
+  export SOFTHSM_SETUP_CONFIGDIR="${workdir}/softhsm"
+  export SOFTHSM2_CONF="${workdir}/softhsm/softhsm2.conf"
+
+  mkdir -p "${SOFTHSM_SETUP_CONFIGDIR}"
+
+  msg=$(./softhsm_setup setup 2>&1)
+  if [ $? -eq 0 ]; then
+    echo "softhsm_setup setup succeeded: $msg"
+    PKCS11_KEYURI=$(echo $msg | sed -n 's|^keyuri: \(.*\)|\1|p')
+
+    export EVMCTL_ENGINE="--engine pkcs11"
+    export OPENSSL_ENGINE="-engine pkcs11"
+    export OPENSSL_KEYFORM="-keyform engine"
+  else
+    echo "softhsm_setup setup failed: ${msg}"
+  fi
+}
+
+# Tear down the SoftHSM setup and clean up the environment
+_softhsm_teardown() {
+  ./softhsm_setup teardown &>/dev/null
+  rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
+  unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
+    EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
+}
\ No newline at end of file
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 3b42eec..4741b92 100755
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
@@ -413,3 +425,15 @@ expect_fail \
 expect_fail \
   check_sign TYPE=ima KEY=gost2012_256-B ALG=md_gost12_512 PREFIX=0x0302 OPTS=
 
+# Test signing with key described by pkcs11 URI
+_softhsm_setup "${WORKDIR}"
+if [ -n "${PKCS11_KEYURI}" ]; then
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY=${PKCS11_KEYURI} ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS=--keyid=aabbccdd
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY=${PKCS11_KEYURI} ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS=--keyid=aabbccdd
+else
+  # to have a constant number of tests, skip these two tests
+  __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return $SKIP; }
+  expect_pass __skip
+  expect_pass __skip
+fi
+_softhsm_teardown "${WORKDIR}"
-- 
2.31.1

