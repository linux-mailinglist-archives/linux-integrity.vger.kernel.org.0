Return-Path: <linux-integrity+bounces-12-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AFF7E83A9
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EBB1C2093F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A783B7BB;
	Fri, 10 Nov 2023 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M6GB/0rx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4993B7A8
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:50 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7933868
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:48 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJlKLr007762;
	Fri, 10 Nov 2023 20:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=7/1MmB//fb2qL4O8k3fOa//l9+N4msN/Vr9RqwVWFr8=;
 b=M6GB/0rxTdIC1GJ7k1HwoMX0bMRXa+bJS7BfU6YCT0akcsqKzp8HYfVgVUpTVsIizhut
 /EVoWDiEKs0uHqu5NUe2idIZuVjJcs0hrtUm+1eGEkcwcxRTUcVIKq4GzYLeTgtQOdc8
 JJP0g47RSEULF/+3Tm44gRyeIOoTByHAE1QHgc873/B6wmrvGwpv12p2PrWd8HU/h5ov
 oxJfxHAFzK1+OyGlYC6IaOh9MJK7DTL2ueM08THwEjtd3hwErUiGzQN32P54fBDgPy7l
 kYa5j6RXaYMdNhOlJSOiN24OvhspmZlZqb8OwCyiLEAvTr8otNLbFOYLfnlrmkS6dDlm Yg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9tyy8w0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJ1Fr1000726;
	Fri, 10 Nov 2023 20:21:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w23ddr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLexn18416166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1650D58058;
	Fri, 10 Nov 2023 20:21:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBB85805D;
	Fri, 10 Nov 2023 20:21:39 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 01/14] tests: Address issues raised by shellcheck SC2086 & enable shellcheck
Date: Fri, 10 Nov 2023 15:21:24 -0500
Message-ID: <20231110202137.3978820-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110202137.3978820-1-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UcOYqxNxzytXzAoTs8TtEVaPs9QT4eIh
X-Proofpoint-ORIG-GUID: UcOYqxNxzytXzAoTs8TtEVaPs9QT4eIh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100171

Address issues raised by shellcheck SC2086:
  "Double quote to prevent globbing and word splitting."

Add support for the make target 'shellcheck' on scripts in the
test directory.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 Makefile.am               |  5 ++++-
 tests/Makefile.am         | 11 ++++++++++-
 tests/boot_aggregate.test |  4 ++--
 tests/fsverity.test       | 16 ++++++++--------
 tests/functions.sh        | 30 +++++++++++++++---------------
 tests/gen-keys.sh         |  4 ++--
 tests/install-openssl3.sh | 12 ++++++------
 tests/sign_verify.test    | 12 ++++++------
 tests/softhsm_setup       | 28 ++++++++++++++--------------
 9 files changed, 67 insertions(+), 55 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e686d65..a30c800 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -44,4 +44,7 @@ rmman:
 doc: evmctl.1.html rmman evmctl.1
 endif
 
-.PHONY: $(tarname)
+shellcheck:
+	make -C tests shellcheck
+
+.PHONY: $(tarname) shellcheck
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 03aa5b7..e34fd79 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -24,6 +24,15 @@ clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
 
 distclean: distclean-keys
-.PHONY: distclean-keys
+
+shellcheck:
+	shellcheck -i SC2086 \
+		functions.sh gen-keys.sh install-fsverity.sh \
+		install-mount-idmapped.sh install-openssl3.sh \
+		install-swtpm.sh install-tss.sh softhsm_setup \
+		$(check_SCRIPTS)
+
+.PHONY: distclean-keys shellcheck
 distclean-keys:
 	./gen-keys.sh clean
+
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index b0b2db4..ccc45f9 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -129,7 +129,7 @@ check() {
 	local options=$1
 
 	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 9) for multiple banks"
-	bootaggr=$(evmctl ima_boot_aggregate ${options})
+	bootaggr=$(evmctl ima_boot_aggregate "${options}")
 	if [ $? -ne 0 ]; then
 		echo "${CYAN}SKIP: evmctl ima_boot_aggregate: $bootaggr${NORM}"
 		exit "$SKIP"
@@ -197,4 +197,4 @@ if [ "$(id -u)" != 0 ] || [ ! -c "/dev/tpm0" ]; then
 	fi
 fi
 
-expect_pass check $BOOTAGGR_OPTIONS
+expect_pass check "$BOOTAGGR_OPTIONS"
diff --git a/tests/fsverity.test b/tests/fsverity.test
index 01d5c35..11925cb 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -50,9 +50,9 @@ _require dd mkfs blkid e2fsck tune2fs evmctl setfattr
 trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM EXIT
 
 cleanup() {
-        if [ -e $TST_MNT ]; then
-		if [ $LOOPBACK_MOUNTED -eq 1 ]; then
-			umount $TST_MNT
+        if [ -e "$TST_MNT" ]; then
+		if [ "$LOOPBACK_MOUNTED" -eq 1 ]; then
+			umount "$TST_MNT"
 		fi
 		if [ -f "$TST_IMG" ]; then
 			rm "$TST_IMG"
@@ -199,7 +199,7 @@ create_file() {
 	local test=$1
 	local type=$2
 
-	TST_FILE=$(mktemp -p $TST_MNT -t "${type}".XXXXXX)
+	TST_FILE=$(mktemp -p "$TST_MNT" -t "${type}".XXXXXX)
 	[ "$VERBOSE" -ge 1 ] && echo "INFO: creating $TST_FILE"
 
 	# heredoc to create a script
@@ -248,13 +248,13 @@ measure-verity() {
 	digest_filename=$("$FSVERITY" digest "$TST_FILE")
 	[ "$VERBOSE" -ge 2 ] && echo "INFO: verity:$digest_filename"
 
-	grep "verity:$digest_filename" $IMA_MEASUREMENT_LIST &> /dev/null
+	grep "verity:$digest_filename" "$IMA_MEASUREMENT_LIST" &> /dev/null
 	ret=$?
 
 	# Not finding the "fsverity digest" result in the IMA measurement
 	# list is expected for non fs-verity enabled files.  The measurement
 	# list will contain zeros for the file hash.
-	if [ $ret -eq 1 ]; then
+	if [ "$ret" -eq 1 ]; then
 		error="$FAIL"
 		if [ "$verity" = "enabled" ]; then
 			echo "${RED}FAILURE: ${msg} ${NORM}"
@@ -282,7 +282,7 @@ measure-ima() {
 	create_file "$test" ima-hash
 	"$TST_FILE"
 
-	hashalg=$(grep "${TST_FILE}" $IMA_MEASUREMENT_LIST | cut -d':' -f2)
+	hashalg=$(grep "${TST_FILE}" "$IMA_MEASUREMENT_LIST" | cut -d':' -f2)
 	if [ -z "${hashalg}" ]; then
 		echo "${CYAN}SKIP: Measurement record with algorithm not found${NORM}"
 		return "$SKIP"
@@ -298,7 +298,7 @@ measure-ima() {
 	# Remove the extra space before the filename
 	digest_filename=$(${digestsum} "$TST_FILE" | sed "s/\ \ /\ /")
 	[ "$VERBOSE" -ge 2 ] && echo "$test: $digest_filename"
-	if grep "$digest_filename" $IMA_MEASUREMENT_LIST &> /dev/null; then
+	if grep "$digest_filename" "$IMA_MEASUREMENT_LIST" &> /dev/null; then
 		echo "${GREEN}SUCCESS: Measuring $TST_FILE ${NORM}"
 	else
 		error="$FAIL"
diff --git a/tests/functions.sh b/tests/functions.sh
index ed06040..15bcec4 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -42,7 +42,7 @@ exit_early() {
 _require() {
   ret=
   for i; do
-    if ! type $i; then
+    if ! type "$i"; then
       echo "$i is required for test"
       ret=1
     fi
@@ -79,7 +79,7 @@ expect_pass() {
   fi
 
   if [ $TNESTED -gt 0 ]; then
-    echo $RED"expect_pass should not be run nested"$NORM
+    echo "${RED}expect_pass should not be run nested${NORM}"
     testsfail+=1
     exit "$HARDFAIL"
   fi
@@ -110,9 +110,9 @@ expect_pass_if() {
   ret=$?
 
   if [ $ret -ne 0 ] && [ $ret -ne 77 ] && [ -n "$PATCHES" ]; then
-    echo $YELLOW"Possibly missing patches:"$NORM
+    echo "${YELLOW}Possibly missing patches:${NORM}"
     for idx in $indexes; do
-      echo $YELLOW" - ${PATCHES[$((idx))]}"$NORM
+      echo "${YELLOW} - ${PATCHES[$((idx))]}${NORM}"
     done
   fi
 
@@ -130,7 +130,7 @@ expect_fail() {
   fi
 
   if [ $TNESTED -gt 0 ]; then
-    echo $RED"expect_fail should not be run nested"$NORM
+    echo "${RED}expect_fail should not be run nested${NORM}"
     testsfail+=1
     exit "$HARDFAIL"
   fi
@@ -166,9 +166,9 @@ expect_fail_if() {
   ret=$?
 
   if { [ $ret -eq 0 ] || [ $ret -eq 99 ]; } && [ -n "$PATCHES" ]; then
-    echo $YELLOW"Possibly missing patches:"$NORM
+    echo "${YELLOW}Possibly missing patches:${NORM}"
     for idx in $indexes; do
-      echo $YELLOW" - ${PATCHES[$((idx))]}"$NORM
+      echo "${YELLOW} - ${PATCHES[$((idx))]}${NORM}"
     done
   fi
 
@@ -177,12 +177,12 @@ expect_fail_if() {
 
 # return true if current test is positive
 _test_expected_to_pass() {
-  [ ! $TFAIL ]
+  [ ! "$TFAIL" ]
 }
 
 # return true if current test is negative
 _test_expected_to_fail() {
-  [ $TFAIL ]
+  [ "$TFAIL" ]
 }
 
 # Show blank line and color following text to red
@@ -201,7 +201,7 @@ color_red() {
 }
 
 color_restore() {
-  [ $COLOR_RESTORE ] && echo "$NORM"
+  [ "$COLOR_RESTORE" ] && echo "$NORM"
   COLOR_RESTORE=
 }
 
@@ -216,7 +216,7 @@ _evmctl_run() {
   # ADD_TEXT_FOR: append to text as 'for $ADD_TEXT_FOR'
 
   cmd="evmctl $V $EVMCTL_ENGINE $*"
-  echo $YELLOW$TMODE "$cmd"$NORM
+  echo "${YELLOW}$TMODE $cmd${NORM}"
   $cmd >"$out" 2>&1
   ret=$?
 
@@ -226,7 +226,7 @@ _evmctl_run() {
     echo "evmctl $op failed hard with ($ret) $text_for"
     sed 's/^/  /' "$out"
     color_restore
-    rm "$out" $ADD_DEL
+    rm "$out" "$ADD_DEL"
     ADD_DEL=
     ADD_TEXT_FOR=
     return "$HARDFAIL"
@@ -238,7 +238,7 @@ _evmctl_run() {
       sed 's/^/  /' "$out"
     fi
     color_restore
-    rm "$out" $ADD_DEL
+    rm "$out" "$ADD_DEL"
     ADD_DEL=
     ADD_TEXT_FOR=
     return "$FAIL"
@@ -371,7 +371,7 @@ _softhsm_setup() {
   msg=$(./softhsm_setup setup 2>&1)
   if [ $? -eq 0 ]; then
     echo "softhsm_setup setup succeeded: $msg"
-    PKCS11_KEYURI=$(echo $msg | sed -n 's|^keyuri: \(.*\)|\1|p')
+    PKCS11_KEYURI=$(echo "$msg" | sed -n 's|^keyuri: \(.*\)|\1|p')
 
     export EVMCTL_ENGINE="--engine pkcs11"
     export OPENSSL_ENGINE="-engine pkcs11"
@@ -402,7 +402,7 @@ _run_env() {
   if [ "$TST_ENV" = "um" ]; then
     expect_pass "$1" rootfstype=hostfs rw init="$2" quiet mem=2048M "$3"
   else
-    echo $RED"Testing environment $TST_ENV not supported"$NORM
+    echo "${RED}Testing environment $TST_ENV not supported${NORM}"
     exit "$FAIL"
   fi
 }
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 8905cdf..0b03ba4 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -71,9 +71,9 @@ for m in 1024 1024_skid 2048; do
     ext=
   fi
   if [ ! -e test-rsa$m.key ]; then
-    log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 $ext \
+    log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 "$ext" \
       -config test-ca.conf \
-      -newkey rsa:$bits \
+      -newkey "rsa:$bits" \
       -out test-rsa$m.cer -outform DER \
       -keyout test-rsa$m.key
     # for v1 signatures
diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
index 911c32b..29457f3 100755
--- a/tests/install-openssl3.sh
+++ b/tests/install-openssl3.sh
@@ -9,16 +9,16 @@ fi
 
 version=${COMPILE_SSL}
 
-wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/${version}.tar.gz
-tar --no-same-owner -xzf ${version}.tar.gz
-cd openssl-${version}
+wget --no-check-certificate "https://github.com/openssl/openssl/archive/refs/tags/${version}.tar.gz"
+tar --no-same-owner -xzf "${version}.tar.gz"
+cd "openssl-${version}"
 
 if [ "$VARIANT" = "i386" ]; then
 	echo "32-bit compilation"
 	FLAGS="-m32 linux-generic32"
 fi
 
-./Configure $FLAGS no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3
+./Configure "$FLAGS" no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3
 # Uncomment for debugging
 # perl configdata.pm --dump | grep engine
 make -j$(nproc)
@@ -26,5 +26,5 @@ make -j$(nproc)
 sudo make install_sw
 
 cd ..
-rm -rf ${version}.tar.gz
-rm -rf openssl-${version}
+rm -rf "${version}.tar.gz"
+rm -rf "openssl-${version}"
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 2bc365a..5cc0393 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -141,7 +141,7 @@ check_sign() {
   local FILE=${FILE:-$ALG.txt}
 
   # Normalize key filename if it's not a pkcs11 URI
-  if [ ${KEY:0:7} != pkcs11: ]; then
+  if [ "${KEY:0:7}" != pkcs11: ]; then
     key=${KEY%.*}.key
     key=test-${key#test-}
   else
@@ -152,8 +152,8 @@ check_sign() {
   # leave only good files for verify tests.
   _test_expected_to_fail && FILE+='~'
 
-  rm -f $FILE
-  if ! touch $FILE; then
+  rm -f "$FILE"
+  if ! touch "$FILE"; then
     color_red
     echo "Can't create test file: $FILE"
     color_restore
@@ -372,7 +372,7 @@ try_different_sigs() {
 
 ## Test v1 signatures
 # Signature v1 only supports sha1 and sha256 so any other should fail
-if [ $SIGV1 -eq 0 ]; then
+if [ "$SIGV1" -eq 0 ]; then
   __skip() { echo "IMA signature v1 tests are skipped: not supported"; return $SKIP; }
   expect_pass __skip
 else
@@ -440,8 +440,8 @@ expect_fail \
 # Test signing with key described by pkcs11 URI
 _softhsm_setup "${WORKDIR}"
 if [ -n "${PKCS11_KEYURI}" ]; then
-  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY=${PKCS11_KEYURI} ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS=--keyid=aabbccdd
-  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY=${PKCS11_KEYURI} ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS=--keyid=aabbccdd
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS=--keyid=aabbccdd
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS=--keyid=aabbccdd
 else
   # to have a constant number of tests, skip these two tests
   __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return $SKIP; }
diff --git a/tests/softhsm_setup b/tests/softhsm_setup
index 35b1754..10e4013 100755
--- a/tests/softhsm_setup
+++ b/tests/softhsm_setup
@@ -15,7 +15,7 @@ fi
 
 MAJOR=$(softhsm2-util -v | cut -d '.' -f1)
 MINOR=$(softhsm2-util -v | cut -d '.' -f2)
-if [ ${MAJOR} -lt 2 ] || [ ${MAJOR} -eq 2 -a ${MINOR} -lt 2 ]; then
+if [ "${MAJOR}" -lt 2 ] || [ "${MAJOR}" -eq 2 -a "${MINOR}" -lt 2 ]; then
 	echo "Need softhsm v2.2.0 or later"
 	exit 77
 fi
@@ -91,21 +91,21 @@ setup_softhsm() {
 				  grep -E "\.so$")"
 		fi
 		sudo mkdir -p /etc/gnutls &>/dev/null
-		sudo bash -c "echo "load=${SONAME}" > /etc/gnutls/pkcs11.conf"
+		sudo bash -c "echo 'load=${SONAME}' > /etc/gnutls/pkcs11.conf"
 		;;
 	esac
 
-	if ! [ -d $configdir ]; then
-		mkdir -p $configdir
+	if ! [ -d "$configdir" ]; then
+		mkdir -p "$configdir"
 	fi
-	mkdir -p ${tokendir}
+	mkdir -p "${tokendir}"
 
-	if [ -f $configfile ]; then
+	if [ -f "$configfile" ]; then
 		mv "$configfile" "$bakconfigfile"
 	fi
 
-	if ! [ -f $configfile ]; then
-		cat <<_EOF_ > $configfile
+	if ! [ -f "$configfile" ]; then
+		cat <<_EOF_ > "$configfile"
 directories.tokendir = ${tokendir}
 objectstore.backend = file
 log.level = DEBUG
@@ -122,8 +122,8 @@ _EOF_
 
 	if [ -z "$tokenuri" ]; then
 		msg=$(softhsm2-util \
-			--init-token --pin ${PIN} --so-pin ${SO_PIN} \
-			--free --label ${NAME} 2>&1)
+			--init-token --pin "${PIN}" --so-pin "${SO_PIN}" \
+			--free --label "${NAME}" 2>&1)
 		if [ $? -ne 0 ]; then
 			echo "Could not initialize token"
 			echo "$msg"
@@ -172,7 +172,7 @@ _EOF_
 		fi
 	fi
 
-	getkeyuri_softhsm $slot
+	getkeyuri_softhsm "$slot"
 	rc=$?
 	if [ $rc -ne 0 ]; then
 		teardown_softhsm
@@ -196,7 +196,7 @@ _getkeyuri_softhsm() {
 		echo "$msg"
 		return 6
 	fi
-	msg=$(p11tool --list-all ${tokenuri} 2>&1)
+	msg=$(p11tool --list-all "${tokenuri}" 2>&1)
 	if [ $? -ne 0 ]; then
 		echo "Could not list object under token $tokenuri"
 		echo "$msg"
@@ -260,7 +260,7 @@ main() {
 	local ret
 
 	if [ $# -lt 1 ]; then
-		usage $0
+		usage "$0"
 		echo -e "Missing command.\n\n"
 		return 1
 	fi
@@ -283,7 +283,7 @@ main() {
 		;;
 	*)
 		echo -e "Unsupported command: $1\n\n"
-		usage $0
+		usage "$0"
 		ret=1
 	esac
 	return $ret
-- 
2.41.0


