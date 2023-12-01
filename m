Return-Path: <linux-integrity+bounces-312-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6B800C2E
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B12281B56
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0B3B78F;
	Fri,  1 Dec 2023 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XN/Ynwqt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8999810E2
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:54 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DVIoT012682
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8VsLwEGaRPa6VBr/WCKPdVu4DNL4dEdY8/54dPItS2A=;
 b=XN/YnwqtaG/WiEtfWqZZeSuXjwAwkUfvUHRgJd+cUwISsXGeaNT8MGGoOklrrIOZAvml
 M7sTrgvQyVxdHxe3F1KcoqrIgmFZfHYvibf6xxgBSwzye49rUrYU/yHarRNfGAP2Latz
 ZIgZbM0atpsposLIhcGRmBKQORbZ4QS1YBNU0W34Z1paN8/7bqIPQtRv0zrQMsg/3ta+
 BCE2EOvA6xrzQkPeYHDgx0UiFGtnSm+Nz0VbX+Xknhj1tbEIplm0czIT3HCgdLrQxg9N
 RYLzpjvkWZ+uUpUJRYz0tBdru19O/PmfyV/mhCbzZnYIwUkVLQDjpcIr4EXbe/8e/3IR hg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqfsusenk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXst6031709
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukun05e9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVpRL24117824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A0F58052;
	Fri,  1 Dec 2023 13:31:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 029535805A;
	Fri,  1 Dec 2023 13:31:51 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:50 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 02/14] tests: Address issues raised by shellcheck SC2181
Date: Fri,  1 Dec 2023 08:31:24 -0500
Message-ID: <20231201133136.2124147-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201133136.2124147-1-stefanb@linux.ibm.com>
References: <20231201133136.2124147-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mdl4b-e8HVrC3sGOf2L81yo1cmuafDfq
X-Proofpoint-ORIG-GUID: mdl4b-e8HVrC3sGOf2L81yo1cmuafDfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010092

Address issues raised by shellcheck SC2181:
  "Check exit code directly with e.g. if mycmd;, not indirectly with $?."

The general replacement patterns to fix this issue are:

Old:
   <cmd>
   if [ $? -eq 0 ]; then ...

New:
   if <cmd>; then ...

Old:
   <cmd>
   if [ $? -ne 0 ]; then ...

New:
   if ! <cmd>; then ...

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am         |  2 +-
 tests/boot_aggregate.test | 22 ++++++++--------------
 tests/functions.sh        |  3 +--
 tests/ima_hash.test       |  4 ++--
 tests/sign_verify.test    |  3 +--
 tests/softhsm_setup       | 32 ++++++++++++--------------------
 6 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6bf7eef..86796c3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086 \
+	shellcheck -i SC2086,SC2181 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index ccc45f9..04aef9b 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -47,8 +47,7 @@ swtpm_start() {
 	fi
 
 	if [ -n "${swtpm}" ]; then
-		pgrep swtpm
-		if [ $? -eq 0 ]; then
+		if pgrep swtpm; then
 			echo "INFO: Software TPM (swtpm) already running"
 			return 114
 		else
@@ -60,8 +59,7 @@ swtpm_start() {
 	elif [ -n "${tpm_server}" ]; then
 		# tpm_server uses the Microsoft simulator encapsulated packet format
 		export TPM_SERVER_TYPE="mssim"
-		pgrep tpm_server
-		if [ $? -eq 0 ]; then
+		if pgrep tpm_server; then
 			echo "INFO: Software TPM (tpm_server) already running"
 			return 114
 		else
@@ -81,16 +79,13 @@ swtpm_init() {
 	fi
 
 	echo "INFO: Sending software TPM startup"
-	"${TSSDIR}/tssstartup"
-	if [ $? -ne 0 ]; then
+	if ! "${TSSDIR}/tssstartup"; then
 		echo "INFO: Retry sending software TPM startup"
 		sleep 1
-		"${TSSDIR}/tssstartup"
-	fi
-
-	if [ $? -ne 0 ]; then
-		echo "INFO: Software TPM startup failed"
-		return "$SKIP"
+		if ! "${TSSDIR}/tssstartup"; then
+			echo "INFO: Software TPM startup failed"
+			return "$SKIP"
+		fi
 	fi
 
 	echo "INFO: Walking ${BINARY_BIOS_MEASUREMENTS} initializing the software TPM"
@@ -129,8 +124,7 @@ check() {
 	local options=$1
 
 	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 9) for multiple banks"
-	bootaggr=$(evmctl ima_boot_aggregate "${options}")
-	if [ $? -ne 0 ]; then
+	if ! bootaggr=$(evmctl ima_boot_aggregate "${options}"); then
 		echo "${CYAN}SKIP: evmctl ima_boot_aggregate: $bootaggr${NORM}"
 		exit "$SKIP"
 	fi
diff --git a/tests/functions.sh b/tests/functions.sh
index 2105f21..9670b3a 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -368,8 +368,7 @@ _softhsm_setup() {
 
   mkdir -p "${SOFTHSM_SETUP_CONFIGDIR}"
 
-  msg=$(./softhsm_setup setup 2>&1)
-  if [ $? -eq 0 ]; then
+  if msg=$(./softhsm_setup setup 2>&1); then
     echo "softhsm_setup setup succeeded: $msg"
     PKCS11_KEYURI=$(echo "$msg" | sed -n 's|^keyuri: \(.*\)|\1|p')
 
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
index e88fd59..9a8d7b6 100755
--- a/tests/ima_hash.test
+++ b/tests/ima_hash.test
@@ -33,8 +33,8 @@ check() {
   # unless it's negative test, then pass to evmctl
   cmd="openssl dgst $OPENSSL_ENGINE -$alg $file"
   echo - "$cmd"
-  hash=$(set -o pipefail; $cmd 2>/dev/null | cut -d' ' -f2)
-  if [ $? -ne 0 ] && _test_expected_to_pass; then
+  if ! hash=$(set -o pipefail; $cmd 2>/dev/null | cut -d' ' -f2) \
+    && _test_expected_to_pass; then
     echo "${CYAN}$alg test is skipped$NORM"
     rm "$file"
     return "$SKIP"
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 5cc0393..1b6cf2a 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -185,8 +185,7 @@ check_sign() {
 
   # Insert keyid from cert into PREFIX in-place of marker `:K:'
   if [[ $PREFIX =~ :K: ]]; then
-    keyid=$(_keyid_from_cert "$key")
-    if [ $? -ne 0 ]; then
+    if ! keyid=$(_keyid_from_cert "$key"); then
       color_red
       echo "Unable to determine keyid for $key"
       color_restore
diff --git a/tests/softhsm_setup b/tests/softhsm_setup
index 10e4013..95bf0b1 100755
--- a/tests/softhsm_setup
+++ b/tests/softhsm_setup
@@ -30,8 +30,7 @@ UNAME_S="$(uname -s)"
 
 case "${UNAME_S}" in
 Darwin)
-	msg=$(sudo -v -n)
-	if [ $? -ne 0 ]; then
+	if ! msg=$(sudo -v -n); then
 		echo "Need password-less sudo rights on OS X to change /etc/gnutls/pkcs11.conf"
 		exit 1
 	fi
@@ -113,18 +112,16 @@ slots.removable = false
 _EOF_
 	fi
 
-	msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}" | tail -n1)
-	if [ $? -ne 0 ]; then
+	if ! msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}" | tail -n1); then
 		echo "Could not list existing tokens"
 		echo "$msg"
 	fi
 	tokenuri=$(echo "$msg" | sed -n 's/.*URL: \([[:print:]*]\)/\1/p')
 
 	if [ -z "$tokenuri" ]; then
-		msg=$(softhsm2-util \
+		if ! msg=$(softhsm2-util \
 			--init-token --pin "${PIN}" --so-pin "${SO_PIN}" \
-			--free --label "${NAME}" 2>&1)
-		if [ $? -ne 0 ]; then
+			--free --label "${NAME}" 2>&1); then
 			echo "Could not initialize token"
 			echo "$msg"
 			return 2
@@ -143,9 +140,8 @@ _EOF_
 			fi
 		fi
 
-		msg=$(p11tool --list-tokens 2>&1 | \
-			grep "token=${NAME}" | tail -n1)
-		if [ $? -ne 0 ]; then
+		if ! msg=$(p11tool --list-tokens 2>&1 | \
+			grep "token=${NAME}" | tail -n1); then
 			echo "Could not list existing tokens"
 			echo "$msg"
 		fi
@@ -156,15 +152,13 @@ _EOF_
 		fi
 
 		# more recent versions of p11tool have --generate-privkey ...
-		msg=$(GNUTLS_PIN=$PIN p11tool \
+		if ! msg=$(GNUTLS_PIN=$PIN p11tool \
 			--generate-privkey=rsa --bits 2048 --label mykey --login \
-			"${tokenuri}" 2>&1)
-		if [ $? -ne 0 ]; then
+			"${tokenuri}" 2>&1); then
 			# ... older versions have --generate-rsa
-			msg=$(GNUTLS_PIN=$PIN p11tool \
+			if ! msg=$(GNUTLS_PIN=$PIN p11tool \
 				--generate-rsa --bits 2048 --label mykey --login \
-				"${tokenuri}" 2>&1)
-			if [ $? -ne 0 ]; then
+				"${tokenuri}" 2>&1); then
 				echo "Could not create RSA key!"
 				echo "$msg"
 				return 5
@@ -184,8 +178,7 @@ _EOF_
 _getkeyuri_softhsm() {
 	local msg tokenuri keyuri
 
-	msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}")
-	if [ $? -ne 0 ]; then
+	if ! msg=$(p11tool --list-tokens 2>&1 | grep "token=${NAME}"); then
 		echo "Could not list existing tokens"
 		echo "$msg"
 		return 5
@@ -196,8 +189,7 @@ _getkeyuri_softhsm() {
 		echo "$msg"
 		return 6
 	fi
-	msg=$(p11tool --list-all "${tokenuri}" 2>&1)
-	if [ $? -ne 0 ]; then
+	if ! msg=$(p11tool --list-all "${tokenuri}" 2>&1); then
 		echo "Could not list object under token $tokenuri"
 		echo "$msg"
 		softhsm2-util --show-slots
-- 
2.43.0


