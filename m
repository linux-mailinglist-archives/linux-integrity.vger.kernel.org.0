Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B70628465
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiKNPx6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 10:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiKNPx5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 10:53:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32D2DA96
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 07:53:55 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEFRNgL014885;
        Mon, 14 Nov 2022 15:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=LMXy0uC0akf89psBwyzcJLJ4z8aO71Szopxj99tbqUY=;
 b=nYtdnqdTwOM3Bh2Ic3XcpUjAC2meMf/Vy7UjExcRWKunX5EoXMb12Dukr+JK9dvpLPgJ
 5yku+TyGpBqRBjKHdBUsa3aw0OXK7ZHfKKSmlyPYc2V2VCHTl9GO5dZ0J10EFv9Z9pk5
 R6LcblBxp+XgytP5j+qNzNTmrnxLJEpNK3t8ew1YPOXFjpmvcoGFIM9Po/RsnysmMfWL
 oYAFtmZoZA9ZbMR7jI0VkKK2iMxWUvTVFlEJTRbfmGEtcI18LQP4m8K4NEgRqthGdfFu
 kWkPl1Qa4SQIVOmGbi0AvwNxXtCSkQen7rzMP3JEVva56mFpotiIrhdzfGFRoKblWIKJ ew== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kupw0upkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:53:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AEFp3iI017110;
        Mon, 14 Nov 2022 15:53:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3kt349a1fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 15:53:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AEFrh4Y4981350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:53:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67309AE04D;
        Mon, 14 Nov 2022 15:53:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53C48AE045;
        Mon, 14 Nov 2022 15:53:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.2.116])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 15:53:42 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Vitaly Chikunov Petr Vorel <"vt@altlinux.orgpvorel"@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils] tests: add fsverity measurement test
Date:   Mon, 14 Nov 2022 10:53:19 -0500
Message-Id: <20221114155319.768030-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _XuH_drMfGleC8ee2iRRzKIWpDZ4ozAI
X-Proofpoint-ORIG-GUID: _XuH_drMfGleC8ee2iRRzKIWpDZ4ozAI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Test IMA support for including fs-verity enabled file measurements
in the IMA measurement list based on the ima-ngv2 and ima-sigv2
records.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Comment:
- The fsverity.test executes locally, but fails to loopback mount a file
in ci/travis.
- Limit running the fsverity.test to Altlinux where it is installed 
and Fedora where it is compiled.

 build.sh                  |   1 +
 ci/alpine.sh              |   2 +
 ci/alt.sh                 |   4 +-
 ci/debian.sh              |   2 +
 ci/fedora.sh              |   8 +-
 ci/tumbleweed.sh          |   2 +
 tests/Makefile.am         |   2 +-
 tests/fsverity.test       | 303 ++++++++++++++++++++++++++++++++++++++
 tests/install-fsverity.sh |   7 +
 9 files changed, 328 insertions(+), 3 deletions(-)
 create mode 100755 tests/fsverity.test
 create mode 100755 tests/install-fsverity.sh

diff --git a/build.sh b/build.sh
index 0c2fdd9e995d..02dc15aeb369 100755
--- a/build.sh
+++ b/build.sh
@@ -98,6 +98,7 @@ if [ $ret -eq 0 ]; then
 		   grep "skipped" tests/sign_verify.log | wc -l
 	fi
 	tail -20 tests/boot_aggregate.log
+	tail -10 tests/fsverity.log
 	exit 0
 fi
 
diff --git a/ci/alpine.sh b/ci/alpine.sh
index 0e4ba0da6beb..6b17942a43fd 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -30,6 +30,7 @@ apk add \
 	diffutils \
 	docbook-xml \
 	docbook-xsl \
+	e2fsprogs-extra \
 	keyutils-dev \
 	libtool \
 	libxslt \
@@ -41,6 +42,7 @@ apk add \
 	pkgconfig \
 	procps \
 	sudo \
+	util-linux \
 	wget \
 	which \
 	xxd
diff --git a/ci/alt.sh b/ci/alt.sh
index 65389bef4487..36ff6579267c 100755
--- a/ci/alt.sh
+++ b/ci/alt.sh
@@ -11,7 +11,8 @@ apt-get install -y \
 		$TSS \
 		asciidoc \
 		attr \
-		docbook-style-xsl \
+		e2fsprogs \
+		fsverity-utils-devel \
 		gnutls-utils \
 		libattr-devel \
 		libkeyutils-devel \
@@ -21,6 +22,7 @@ apt-get install -y \
 		openssl-gost-engine \
 		rpm-build \
 		softhsm \
+		util-linux \
 		wget \
 		xsltproc \
 		xxd \
diff --git a/ci/debian.sh b/ci/debian.sh
index 005b1f647ed8..431203aabb48 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -40,6 +40,7 @@ $apt \
 	debianutils \
 	docbook-xml \
 	docbook-xsl \
+	e2fsprogs \
 	gzip \
 	libattr1-dev$ARCH \
 	libkeyutils-dev$ARCH \
@@ -50,6 +51,7 @@ $apt \
 	pkg-config \
 	procps \
 	sudo \
+	util-linux \
 	wget \
 	xsltproc
 
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 09936070ea93..2272bbc57fae 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -25,9 +25,12 @@ yum -y install \
 	automake \
 	diffutils \
 	docbook-xsl \
+	e2fsprogs \
+	git-core \
 	gnutls-utils \
 	gzip \
 	keyutils-libs-devel \
+	kmod \
 	libattr-devel \
 	libtool \
 	libxslt \
@@ -38,6 +41,7 @@ yum -y install \
 	pkg-config \
 	procps \
 	sudo \
+	util-linux \
 	vim-common \
 	wget \
 	which
@@ -49,4 +53,6 @@ yum -y install swtpm || true
 if [ -f /etc/centos-release ]; then
 	yum -y install epel-release
 fi
-yum -y install softhsm || true
\ No newline at end of file
+yum -y install softhsm || true
+
+./tests/install-fsverity.sh
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 4e3da0c6bb75..6f70b0fcc768 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -26,6 +26,7 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	diffutils \
 	docbook_5 \
 	docbook5-xsl-stylesheets \
+	e2fsprogs \
 	gzip \
 	ibmswtpm2 \
 	keyutils-devel \
@@ -37,6 +38,7 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	pkg-config \
 	procps \
 	sudo \
+	util-linux \
 	vim \
 	wget \
 	which \
diff --git a/tests/Makefile.am b/tests/Makefile.am
index ff928e177406..feea235da873 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,7 +1,7 @@
 check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
-check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test
+check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test fsverity.test
 
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
diff --git a/tests/fsverity.test b/tests/fsverity.test
new file mode 100755
index 000000000000..ad7762a479b7
--- /dev/null
+++ b/tests/fsverity.test
@@ -0,0 +1,303 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test IMA support for including fs-verity enabled files measurements
+# in the IMA measurement list.
+#
+# Define policy rules showing the different types of IMA and fs-verity
+# records in the IMA measurement list.  Include examples of files that
+# are suppose to be fs-verity enabled, but aren't.
+#
+# test 1: IMA policy rule using the new ima-ngv2 template
+# - Hash prefixed with "ima:"
+#
+# test 2: fs-verity IMA policy rule using the new ima-ngv2 template
+# - fs-verity hash prefixed with "verity:"
+# - Non fs-verity enabled file, zeros prefixed with "verity:"
+#
+# test 3: IMA policy rule using the new ima-sigv2 template
+# - Hash prefixed with "ima:"
+# - Appended signature, when available.
+#
+# test 4: fs-verity IMA policy rule using the new ima-sigv2 template
+# - fs-verity hash prefixed with "verity:"
+# - Non fs-verity enabled file, zeros prefixed with "verity:"
+# - Appended IMA signature of fs-verity file hash, when available.
+
+# To avoid affecting the system's IMA custom policy or requiring a
+# reboot between tests, define policy rules based on UUID.  However,
+# since the policy rules are walked sequentially, the system's IMA
+# custom policy rules might take precedence.
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+
+IMA_POLICY_FILE="/sys/kernel/security/integrity/ima/policy"
+IMA_MEASUREMENT_LIST="/sys/kernel/security/integrity/ima/ascii_runtime_measurements"
+TST_MNT="/tmp/fsverity-test"
+TST_IMG="/tmp/test.img"
+
+LOOPBACK_MOUNTED=0
+FSVERITY="$(which fsverity)"
+
+source ./functions.sh
+_require dd mkfs blkid e2fsck tune2fs evmctl setfattr
+./gen-keys.sh >/dev/null 2>&1
+
+trap cleanup SIGINT SIGTERM EXIT
+
+cleanup() {
+        if [ -e $TST_MNT ]; then
+		if [ $LOOPBACK_MOUNTED -eq 1 ]; then
+			umount $TST_MNT
+		fi
+		if [ -f "$TST_IMG" ]; then
+			rm "$TST_IMG"
+		fi
+	fi
+	_report_exit_and_cleanup
+}
+
+# Loopback mount a file
+mount_loopback_file() {
+	local ret
+
+	if [ ! -d $TST_MNT ]; then
+		mkdir $TST_MNT
+	fi
+
+	if modprobe loop; then
+		echo "${CYAN}INFO: modprobe loop failed${NORM}"
+	fi
+
+	if ! losetup -f; then
+		echo "${RED}FAILURE: losetup${NORM}"
+		exit "$FAIL"
+	fi
+
+	mount -o loop ${TST_IMG} $TST_MNT
+	ret=$?
+
+	if [ "${ret}" -eq 0 ]; then
+		LOOPBACK_MOUNTED=1
+	fi
+
+	return "$ret"
+}
+
+# Change the loopback mounted filesystem's UUID in between tests
+change_loopback_file_uuid() {
+	echo " "
+	[ "$VERBOSE" -ge 1 ] && echo "Changing loopback file uuid"
+
+	umount $TST_MNT
+	if ! e2fsck -y -f ${TST_IMG} > /dev/null; then
+		echo "${RED}FAILURE: e2fsck${NORM}"
+		exit "$FAIL"
+	fi
+
+	if ! tune2fs -f ${TST_IMG} -U random &> /dev/null; then
+		echo "${RED}FAILURE: change UUID${NORM}"
+		exit "$FAIL"
+	fi
+
+	[ "$VERBOSE" -ge 1 ] && echo "Remounting loopback filesystem"
+	if ! mount_loopback_file; then
+		echo "${RED}FAILURE: re-mounting loopback filesystem${NORM}"
+		exit "$FAIL"
+	fi
+	return 0
+}
+
+# Create a file to be loopback mounted
+create_loopback_file() {
+	local fs_type=$1
+	local options=""
+
+	echo "Creating loopback filesystem"
+	case $fs_type in
+	ext4|f2fs)
+		options="-O verity"
+		;;
+	btrfs)
+		;;
+	*)
+		echo "${RED}FAILURE: unsupported fs-verity filesystem${NORM}"
+		exit "${FAIL}"
+		;;
+	esac
+
+	[ "$VERBOSE" -ge 2 ] && echo "Creating a file to be loopback mounted with options: $options"
+	if ! dd if=/dev/zero of="${TST_IMG}" bs=100M count=6 &> /dev/null; then
+		echo "${RED}FAILURE: creating ${TST_IMG}${NORM}"
+		exit "$FAIL"
+	fi
+
+	echo "Building an $fs_type filesystem"
+	if ! mkfs -t "$fs_type" -q "${TST_IMG}" "$options"; then
+		echo "${RED}FAILURE: creating $fs_type filesystem${NORM}"
+		exit "$FAIL"
+	fi
+
+	echo "Mounting loopback filesystem"
+	if ! mount_loopback_file; then
+		echo "${RED}FAILURE: mounting loopback filesystem${NORM}"
+		exit "$FAIL"
+	fi
+	return 0
+}
+
+get_current_uuid() {
+	[ "$VERBOSE" -ge 2 ] && echo "Getting loopback file uuid"
+	if ! UUID=$(blkid -s UUID -o value ${TST_IMG}); then
+		echo "${RED}FAILURE: to get UUID${NORM}"
+		return "$FAIL"
+	fi
+	return 0
+}
+
+load_policy_rule() {
+	local test=$1
+	local rule=$2
+
+	if ! get_current_uuid; then
+		echo "${RED}FAILURE:FAILED getting uuid${NORM}"
+		exit "$FAIL"
+	fi
+
+	echo "$test: rule: $rule fsuuid=$UUID"
+	echo "$rule fsuuid=$UUID" > $IMA_POLICY_FILE
+}
+
+create_file() {
+	local test=$1
+	local type=$2
+
+	TST_FILE=$(mktemp -p $TST_MNT -t "${type}".XXXXXX)
+	[ "$VERBOSE" -ge 1 ] && echo "creating $TST_FILE"
+
+	# heredoc to create a script
+	cat <<-EOF > "$TST_FILE"
+	#!/bin/bash
+	echo "Hello" &> /dev/null
+	EOF
+
+	chmod a+x "$TST_FILE"
+}
+
+measure-verity() {
+	local test=$1
+	local verity="${2:-disabled}"
+	local digest_filename
+	local error="$OK"
+	local KEY=$PWD/test-rsa2048.key
+
+	create_file "$test" verity-hash
+	if [ "$verity" = "enabled" ]; then
+		msg="measuring fs-verity enabled file $TST_FILE"
+		if ! "$FSVERITY" enable "$TST_FILE"; then
+			echo "${RED}FAILURE: enabling fs-verity${NORM}"
+			exit "$FAIL"
+		fi
+	else
+		msg="measuring non fs-verity enabled file properly does not include digest $TST_FILE"
+	fi
+
+	# Sign the fsverity digest and write it as security.ima xattr.
+	# "evmctl sign_hash" input: <digest> <filename>
+	# "evmctl sign_hash" output: <digest> <filename> <signature>
+	[ "$VERBOSE" -ge 2 ] && echo "Signing the fsverity digest"
+	xattr=$("$FSVERITY" digest "$TST_FILE" | evmctl sign_hash --veritysig --key "$KEY" 2> /dev/null)
+	sig=$(echo "$xattr" | cut -d' ' -f3)
+
+	# On failure to write security.ima xattr, the signature will simply
+	# not be appended to the measurement list record.
+	if ! setfattr -n security.ima -v "0x$sig" "$TST_FILE"; then
+		echo "${CYAN}INFO: failed to write security.ima xattr${NORM}"
+	fi
+	"$TST_FILE"
+
+	# "fsverity digest" calculates the fsverity hash, even for
+	# non fs-verity enabled files.
+	digest_filename=$("$FSVERITY" digest "$TST_FILE")
+
+	grep "verity:$digest_filename" $IMA_MEASUREMENT_LIST &> /dev/null
+	ret=$?
+
+	# Not finding the "fsverity digest" result in the IMA measurement
+	# list is expected for non fs-verity enabled files.  The measurement
+	# list will contain zeros for the file hash.
+	if [ $ret -eq 1 ]; then
+		error="$FAIL"
+		if [ "$verity" = "enabled" ]; then
+			echo "${RED}FAILURE: ${msg} ${NORM}"
+		else
+			echo "${GREEN}SUCCESS: ${msg} ${NORM}"
+		fi
+	else
+		if [ "$verity" = "enabled" ]; then
+			echo "${GREEN}SUCCESS: ${msg} ${NORM}"
+		else
+			error="$FAIL"
+			echo "${RED}FAILURE: ${msg} ${NORM}"
+		fi
+	fi
+	return "$error"
+}
+
+measure-ima() {
+	local test=$1
+	local digest_filename
+	local error="$OK"
+
+	create_file "$test" ima-hash
+	"$TST_FILE"
+
+	# sha256sum returns: <digest> <2 spaces> <filename>
+	# Remove the extra space before the filename
+	digest_filename=$(sha256sum "$TST_FILE" | sed "s/\ \ /\ /")
+	if grep "$digest_filename" $IMA_MEASUREMENT_LIST &> /dev/null; then
+		echo "${GREEN}SUCCESS: measuring $TST_FILE ${NORM}"
+	else
+		error="$FAIL"
+		echo "${RED}FAILURE: measuring $TST_FILE ${NORM}"
+	fi
+
+	return "$error"
+}
+
+# Skip the test if fsverity is not found; using _require fails the test.
+if [ -z "$FSVERITY" ]; then
+	echo "${CYAN}fsverity is not installed${NORM}"
+	exit "$SKIP"
+fi
+
+if [ "x$(id -u)" != "x0" ]; then
+	echo "${CYAN}Must be root to execute this test${NORM}"
+	exit "$SKIP"
+fi
+
+create_loopback_file ext4
+
+# IMA policy rule using the ima-ngv2 template
+load_policy_rule test1 "measure func=BPRM_CHECK template=ima-ngv2"
+expect_pass measure-ima test1
+
+# fsverity IMA policy rule using the ima-ngv2 template
+change_loopback_file_uuid
+load_policy_rule test2 "measure func=BPRM_CHECK template=ima-ngv2 digest_type=verity"
+expect_fail measure-verity test2
+expect_pass measure-verity test2 enabled
+
+# IMA policy rule using the ima-sigv2 template
+change_loopback_file_uuid
+load_policy_rule test3 "measure func=BPRM_CHECK template=ima-sigv2"
+expect_pass measure-ima test3
+
+# fsverity IMA policy rule using the ima-sigv2 template
+change_loopback_file_uuid
+load_policy_rule test4 "measure func=BPRM_CHECK template=ima-sigv2 digest_type=verity"
+
+expect_fail measure-verity test4
+expect_pass measure-verity test4 enabled
+exit
diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
new file mode 100755
index 000000000000..418fc42f472b
--- /dev/null
+++ b/tests/install-fsverity.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
+cd fsverity-utils
+CC=gcc make -j$(nproc) && sudo make install
+cd ..
+rm -rf fsverity-utils
-- 
2.31.1

