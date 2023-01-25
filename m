Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9867ACD6
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 09:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjAYIwU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 03:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYIwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 03:52:19 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6984171F
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 00:52:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1y7H53Hqz9xHvv
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 16:44:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQmG7dBjf2fGAA--.15976S9;
        Wed, 25 Jan 2023 09:52:00 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3 07/11] Add tests for EVM portable signatures
Date:   Wed, 25 Jan 2023 09:50:26 +0100
Message-Id: <20230125085030.1568256-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQmG7dBjf2fGAA--.15976S9
X-Coremail-Antispam: 1UD129KBjvAXoWftF1DuFyDCFy3XFWfCw1Utrb_yoWrXF4xGo
        W8WrWaq3y5Jw43Jr93ur18AFWDCrZ3CF17AFWYgwn0qF13Jryxuw18G345Ar43urW8WrWU
        Kas7AryrZrWDJrn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYD7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4gLNwABsJ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Verify that operations on files with EVM portable signatures succeed and
that the new kernel patch set does not break the existing kernel integrity
expectations. Build and install mount-idmapped for ci/fedora.sh, to
additionally test idmapped mounts.

To run the tests, pass the path of the kernel private key with the
TST_KEY_PATH environment variable. If not provided, search first in the
ima-evm-utils top directory, and then in
/lib/modules/$(uname -r)/source/certs/signing_key.pem and
/lib/modules/$(uname -r)/build/certs/signing_key.pem.

Root privileges are required to mount the image, configure IMA/EVM and set
xattrs.

Set TST_ENV to 'um', to relaunch the script in a new environment after
booting an UML kernel. The UML kernel path must be specified with the
TST_KERNEL environment variable.

Alternatively, set the TST_EVM_CHANGE_MODE variable to 1, to change the
current EVM mode, if a test needs a different one. Otherwise, execute only
the tests compatible with the current EVM mode.

Also set the EVM_ALLOW_METADATA_WRITES flag in the EVM mode, before
launching the script, to run the check_evm_revalidate() test. Execute:

echo 4 > /sys/kernel/security/evm

The last two environment variables above affect which tests will run the
next time the script is executed. Without setting TST_ENV, changes to the
current EVM mode will be irreversibly done in the host. Next time, unless
the host is rebooted, only tests compatible with the last EVM mode set will
run. The others will be skipped.

By setting TST_ENV, this problem does not arise as, every time the
environment is created, it will be clean with no flags set in the EVM mode.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 build.sh                        |    5 +
 ci/fedora.sh                    |    7 +-
 tests/Makefile.am               |    2 +-
 tests/install-mount-idmapped.sh |    6 +
 tests/portable_signatures.test  | 1088 +++++++++++++++++++++++++++++++
 5 files changed, 1106 insertions(+), 2 deletions(-)
 create mode 100755 tests/install-mount-idmapped.sh
 create mode 100755 tests/portable_signatures.test

diff --git a/build.sh b/build.sh
index 4e2f1bb7353b..0920599b2780 100755
--- a/build.sh
+++ b/build.sh
@@ -114,6 +114,11 @@ if [ $ret -eq 0 ]; then
 		grep "skipped" tests/fsverity.log  && \
 		   grep "skipped" tests/fsverity.log | wc -l
 	fi
+	if [ -f tests/portable_signatures.log ]; then
+		[ -n "$CI" ] && cat tests/portable_signatures.log || tail tests/portable_signatures.log
+		grep "skipped" tests/portable_signatures.log  && \
+		   grep "skipped" tests/portable_signatures.log | wc -l
+	fi
 	exit 0
 fi
 
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 198034a34e3c..3f75d2e1ddbd 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -47,7 +47,11 @@ yum -y install \
 	which \
 	zstd \
 	haveged \
-	systemd
+	systemd \
+	keyutils \
+	e2fsprogs \
+	acl \
+	libcap
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
@@ -59,3 +63,4 @@ fi
 yum -y install softhsm || true
 
 ./tests/install-fsverity.sh
+./tests/install-mount-idmapped.sh
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 305082483f36..421fac577b55 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -2,7 +2,7 @@ check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
-		 fsverity.test
+		 fsverity.test portable_signatures.test
 
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
diff --git a/tests/install-mount-idmapped.sh b/tests/install-mount-idmapped.sh
new file mode 100755
index 000000000000..c954006dfedc
--- /dev/null
+++ b/tests/install-mount-idmapped.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+git clone https://github.com/brauner/mount-idmapped.git
+cd mount-idmapped
+gcc -o mount-idmapped mount-idmapped.c
+cd ..
diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
new file mode 100755
index 000000000000..a864e0aef4d4
--- /dev/null
+++ b/tests/portable_signatures.test
@@ -0,0 +1,1088 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
+#
+# Check if operations on files with EVM portable signatures succeed.
+
+trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
+
+# From security/integrity/evm/evm.h in kernel source directory.
+(( EVM_INIT_HMAC=0x0001 ))
+(( EVM_INIT_X509=0x0002 ))
+(( EVM_ALLOW_METADATA_WRITES=0x0004 ))
+(( EVM_SETUP_COMPLETE=0x80000000 ))
+
+cd "$(dirname "$0")" || exit "$FAIL"
+export PATH=$PWD/../src:$PWD/../mount-idmapped:$PATH
+export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
+. ./functions.sh
+_require evmctl
+
+cleanup() {
+	if [ "$g_loop_mounted" = "1" ]; then
+		popd > /dev/null || exit "$FAIL"
+
+		if [ -n "$g_mountpoint_idmapped" ]; then
+			umount "$g_mountpoint_idmapped"
+		fi
+
+		umount "$g_mountpoint"
+	fi
+
+	if [ -n "$g_dev" ]; then
+		losetup -d "$g_dev"
+	fi
+
+	if [ -n "$g_image" ]; then
+		rm -f "$g_image"
+	fi
+
+	if [ -n "$key_path_der" ]; then
+		rm -f "$key_path_der"
+	fi
+
+	if [ -n "$g_mountpoint" ]; then
+		rm -Rf "$g_mountpoint"
+	fi
+
+	if [ -n "$g_mountpoint_idmapped" ]; then
+		rm -Rf "$g_mountpoint_idmapped"
+	fi
+}
+
+get_xattr() {
+	local format="hex"
+
+	if [ "$1" = "security.selinux" ]; then
+		format="text"
+	fi
+
+	getfattr -n "$1" -e $format -d "$2" 2> /dev/null | awk -F "=" '$1 == "'"$1"'" {if ("'$format'" == "hex") v=substr($2, 3); else { split($2, temp, "\""); v=temp[2] }; print v}'
+}
+
+# Use the fsuuid= IMA policy keyword to select only files created/used by the
+# tests below. Also use fowner= to differentiate between files created/used by
+# individual tests.
+IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26d"
+APPRAISE_DIGSIG_FOWNER=2000
+APPRAISE_DIGSIG_RULE="appraise fsuuid=$IMA_UUID fowner=$APPRAISE_DIGSIG_FOWNER appraise_type=imasig"
+MEASURE_FOWNER=2001
+MEASURE_RULE="measure fsuuid=$IMA_UUID fowner=$MEASURE_FOWNER template=ima-sig"
+APPRAISE_FOWNER=2002
+APPRAISE_RULE="appraise fsuuid=$IMA_UUID fowner=$APPRAISE_FOWNER"
+METADATA_CHANGE_FOWNER=3001
+METADATA_CHANGE_FOWNER_2=3002
+
+check_load_ima_rule() {
+	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
+	if [ -z "$rule_loaded" ]; then
+		new_policy=$(mktemp -p "$g_mountpoint")
+		echo "$1" > "$new_policy"
+		evmctl sign -o -a sha256 --imasig --key "$key_path" "$new_policy" &> /dev/null
+		echo "$new_policy" > /sys/kernel/security/ima/policy
+		result=$?
+		rm -f "$new_policy"
+
+		if [ "$result" -ne 0 ]; then
+			echo "${RED}Failed to set IMA policy${NORM}"
+			return "$FAIL"
+		fi
+	fi
+
+	return "$OK"
+}
+
+# The purpose of this test is to verify that the patch 'ima: Allow imasig
+# requirement to be satisfied by EVM portable signatures' didn't break the
+# current behavior (IMA signatures still satisfy the imasig requirement).
+check_ima_sig_appraisal() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $((evm_value & (EVM_INIT_X509 | EVM_INIT_HMAC))) -ne 0 ]; then
+		echo "${CYAN}EVM mode 0 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl ima_sign -a sha256 --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown "$APPRAISE_DIGSIG_FOWNER" test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$APPRAISE_DIGSIG_RULE"
+	result=$?
+	if [ $result -ne "$OK" ]; then
+		return $result
+	fi
+
+	# Check if appraisal works.
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Ensure that files with IMA signature cannot be updated (immutable).
+	if echo "test" 2> /dev/null >> test-file; then
+		echo "${RED}Write to test-file should not succeed (immutable file)${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_ima_sig_appraisal() {
+	rm -f test-file
+}
+
+# Requires:
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is to verify that the patch 'ima: Introduce template
+# field evmsig and write to field sig as fallback' still allows IMA signatures
+# to be displayed in the measurement list.
+check_ima_sig_ima_measurement_list() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl ima_sign -a sha256 --imasig --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown "$MEASURE_FOWNER" test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$MEASURE_RULE"
+	result=$?
+	if [ $result -ne "$OK" ]; then
+		return $result
+	fi
+
+	# Read the file to add it to the measurement list.
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	ima_sig_fs=$(get_xattr security.ima test-file)
+	if [ -z "$ima_sig_fs" ]; then
+		echo "${RED}security.ima not found${NORM}"
+		return "$FAIL"
+	fi
+
+	# Search security.ima in the measurement list.
+	ima_sig_list=$(awk '$6 == "'"$ima_sig_fs"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
+	if [ -z "$ima_sig_list" ]; then
+		echo "${RED}security.ima mismatch (xattr != measurement list)${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_ima_sig_ima_measurement_list() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to verify that new files can be created when EVM
+# is initialized only with a public key.
+check_create_file() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	# To trigger the bug we need to enable public key verification without HMAC key loaded.
+	if [ $((evm_value & EVM_INIT_X509)) -ne "$EVM_INIT_X509" ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if [ $((evm_value & EVM_INIT_HMAC)) -eq "$EVM_INIT_HMAC" ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_HMAC must be disabled${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_create_file() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to verify that EVM with the patches above allows
+# metadata to copied one by one, even if the portable signature verification
+# temporarily fails until the copy is completed.
+check_cp_preserve_xattrs() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ "$evm_value" -ne "$EVM_INIT_X509" ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl sign -o -a sha256 --imahash --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Check if cp is allowed to set metadata for the new file.
+	if ! cp -a test-file test-file.copy; then
+		echo "${RED}Cannot copy test-file with attrs/xattrs preserved${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_cp_preserve_xattrs() {
+	rm -f test-file test-file.copy
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is similar to that of the previous test, with the
+# difference that tar is used instead of cp. One remark is that the owner is
+# intentionally different (or it should be) from the current owner, to
+# incrementally test the patches without 'evm: Allow setxattr() and setattr()
+# for unmodified metadata'.
+check_tar_extract_xattrs_different_owner() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ "$evm_value" -ne "$EVM_INIT_X509" ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! mkdir in out; then
+		echo "${RED}Cannot create directories${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! echo "test" > in/test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown 3000 in/test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chmod 600 in/test-file; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl sign -o -a sha256 --imahash --key "$key_path" in/test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! tar --xattrs-include=* -cf test-archive.tar in/test-file; then
+		echo "${RED}Cannot create archive with xattrs${NORM}"
+		return "$FAIL"
+	fi
+
+	# Check if tar is allowed to set metadata for the extracted file.
+	# Ensure that the owner from the archive is different from the
+	# owner of the extracted file to avoid that portable signature
+	# verification succeeds before restoring original metadata
+	# (a patch allows modification of immutable metadata if portable
+	# signature verification fails).
+	if ! tar --xattrs-include=* -xf test-archive.tar -C out; then
+		echo "${RED}Cannot extract archive with xattrs${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_tar_extract_xattrs_different_owner() {
+	rm -Rf in out test-archive.tar
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Pass user namespace to set/remove xattr hooks
+# - evm: Allow setxattr() and setattr() for unmodified metadata
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is similar to that of the previous two tests. The
+# difference is that tar is used instead of cp, and the extracted files have
+# the same owner as the current one. Thus, this test requires 'evm: Allow
+# setxattr() and setattr() for unmodified metadata'.
+check_tar_extract_xattrs_same_owner() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ "$evm_value" -ne "$EVM_INIT_X509" ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! mkdir in out; then
+		echo "${RED}Cannot create directories${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! echo "test" > in/test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl sign -o -a sha256 --imahash --key "$key_path" in/test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! tar --xattrs-include=* -cf test-archive.tar in/test-file; then
+		echo "${RED}Cannot create archive with xattrs${NORM}"
+		return "$FAIL"
+	fi
+
+	# Check if tar is allowed to set metadata for the extracted file.
+	# This test is different from the previous one, as the owner
+	# from the archive is the same of the owner of the extracted
+	# file. tar will attempt anyway to restore the original owner but
+	# unlike the previous test, portable signature verification already
+	# succeeds at the time the owner is set (another patch allows
+	# metadata operations if those operations don't modify current
+	# values).
+	if ! tar --xattrs-include=* -xf test-archive.tar -C out; then
+		echo "${RED}Cannot extract archive with xattrs${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_tar_extract_xattrs_same_owner() {
+	rm -Rf in out test-archive.tar
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Allow xattr/attr operations for portable signatures
+# - evm: Pass user namespace to set/remove xattr hooks
+# - evm: Allow setxattr() and setattr() for unmodified metadata
+# - ima: Don't remove security.ima if file must not be appraised
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to further verify the patches above, by executing
+# commands to set the same or different metadata. Setting the same metadata
+# should be allowed, setting different metadata should be denied.
+check_metadata_change() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ "$evm_value" -ne "$EVM_INIT_X509" ]; then
+		echo "${CYAN}EVM mode $EVM_INIT_X509 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown "$METADATA_CHANGE_FOWNER" test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chgrp "$METADATA_CHANGE_FOWNER" test-file; then
+		echo "${RED}Cannot change group of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chmod 2644 test-file; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl sign -o -a sha256 --imahash --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# If metadata modification is not allowed, EVM should deny any
+	# operation that modifies metadata. Check if setting the same
+	# value is allowed.
+	if ! chown "$METADATA_CHANGE_FOWNER" test-file; then
+		echo "${RED}Cannot set same owner for test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Setting a different value should not be allowed.
+	if chown "$METADATA_CHANGE_FOWNER_2" test-file 2> /dev/null; then
+		echo "${RED}Owner change for test-file should not be allowed (immutable metadata)${NORM}"
+		return "$FAIL"
+	fi
+
+	# Repeat the test for the file mode.
+	if ! chmod 2644 test-file; then
+		echo "${RED}Cannot set same mode for test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if chmod 2666 test-file 2> /dev/null; then
+		echo "${RED}Mode change for test-file should not be allowed (immutable metadata)${NORM}"
+		return "$FAIL"
+	fi
+
+	if [ -n "$(command -v chcon 2> /dev/null)" ] && [ -n "$(command -v getenforce 2> /dev/null)" ] && [ "$(getenforce 2> /dev/null)" != "Disabled" ]; then
+		# Repeat the test for the SELinux label.
+		label=$(get_xattr security.selinux test-file)
+
+		if [ -n "$label" ]; then
+			if ! chcon "$label" test-file; then
+				echo "${RED}Cannot set same security.selinux for test-file${NORM}"
+				return "$FAIL"
+			fi
+		fi
+
+		if chcon unconfined_u:object_r:null_device_t:s0 test-file 2> /dev/null; then
+			echo "${RED}security.selinux change for test file should not be allowed (immutable metadata)${NORM}"
+			return "$FAIL"
+		fi
+	fi
+
+	# Repeat the test for the IMA signature.
+	ima_xattr=$(get_xattr security.ima test-file)
+	if [ -z "$ima_xattr" ]; then
+		echo "${RED}security.ima not found${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! setfattr -n security.ima -v 0x"$ima_xattr" test-file; then
+		echo "${RED}Cannot set same security.ima for test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	last_char=${ima_xattr: -1}
+	((last_char += 1))
+	((last_char %= 10))
+	ima_xattr=${ima_xattr:0:-1}$last_char
+
+	if setfattr -n security.ima -v 0x"$ima_xattr" test-file 2> /dev/null; then
+		echo "${RED}Change of security.ima for test-file should not be allowed (immutable metadata)${NORM}"
+		return "$FAIL"
+	fi
+
+	# Repeat the test for ACLs.
+	if ! msg=$(exec 2>&1 && setfacl --set u::rw,g::r,o::r,m:r test-file); then
+		if [ "${msg%not supported}" != "$msg" ]; then
+			return "$OK"
+		fi
+
+		echo "${RED}Cannot preserve system.posix_acl_access for test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if setfacl --set u::rw,g::r,o::r,m:rw test-file 2> /dev/null; then
+		echo "${RED}Change of system.posix_acl_access for test-file should not be allowed (immutable metadata)${NORM}"
+		return "$FAIL"
+	fi
+
+	if [ -n "$g_mountpoint_idmapped" ]; then
+		pushd "$g_mountpoint_idmapped" > /dev/null || exit "$FAIL"
+
+		# Repeat the test for ACLs on an idmapped mount.
+		#
+		# This test relies on the fact that the caller of this script (root) is in
+		# the same owning group of test-file (in the idmapped mount the group is
+		# root, not $METADATA_CHANGE_FOWNER and, for this reason, the S_ISGID bit
+		# is not cleared. If EVM was not aware of the mapping, it would have
+		# determined that root is not in the owning group of test-file and given
+		# that also CAP_FSETID is cleared, the S_ISGID bit would have been cleared
+		# and thus the operation would fail (file metadata changed).
+		if ! capsh --drop='cap_fsetid' -- -c 'setfacl --set u::rw,g::r,o::r test-file'; then
+			echo "${RED}Cannot preserve system.posix_acl_access for test-file${NORM}"
+			popd || exit "$FAIL"
+			return "$FAIL"
+		fi
+
+		popd > /dev/null || exit "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_metadata_change() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Introduce evm_revalidate_status()
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# Note:
+# This test can be run if EVM_ALLOW_METADATA_WRITES is set in advance
+# before running this script. If it is not set before, this script sets
+# EVM_SETUP_COMPLETE, disabling further EVM mode modifications until reboot.
+#
+# Without EVM_ALLOW_METADATA_WRITES, EVM_SETUP_COMPLETE is necessary to ignore
+# the INTEGRITY_NOLABEL and INTEGRITY_NOXATTRS errors.
+#
+# The purpose of this test is to verify that IMA detected a metadata change
+# when EVM_ALLOW_METADATA_WRITES is set (metadata operations are always
+# allowed). After the first successful appraisal, the test intentionally changes
+# metadata and verifies that IMA revoked access to the file. The test also
+# verifies that IMA grants access again to the file after restoring the correct
+# metadata.
+check_evm_revalidate() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ "$evm_value" -ne $((EVM_INIT_X509 | EVM_ALLOW_METADATA_WRITES)) ]; then
+		echo "${CYAN}EVM mode $((EVM_INIT_X509 | EVM_ALLOW_METADATA_WRITES)) required, execute echo 4 > /sys/kernel/security/evm before running this test${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chmod 600 test-file; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# We need to defer setting the correct owner, as there could be
+	# already an IMA policy rule preventing evmctl from reading the
+	# file to calculate the digest.
+	if ! evmctl sign -o -a sha256 --imahash --uid "$APPRAISE_FOWNER" --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown "$APPRAISE_FOWNER" test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$APPRAISE_RULE"
+	result=$?
+	if [ $result -ne "$OK" ]; then
+		return $result
+	fi
+
+	# Read the file so that IMA would not re-appraise it next time.
+	if ! cat test-file &> /dev/null; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# After enabling metadata modification, operations should succeed even
+	# if the file has a portable signature. However, the previously cached
+	# appraisal status should be invalidated.
+	if ! chmod 644 test-file; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Here check if IMA re-appraised the file. The read should fail
+	# since now file metadata is invalid.
+	if cat test-file &> /dev/null; then
+		echo "${RED}Read of test-file should not succeed (invalid mode)${NORM}"
+		return "$FAIL"
+	fi
+
+	# Restore metadata back to the original value.
+	if ! chmod 600 test-file; then
+		echo "${RED}Cannot restore original mode of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Ensure that now IMA appraisal succeeds.
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file after restoring correct mode${NORM}"
+		return "$FAIL"
+	fi
+
+	if [ -n "$(command -v chcon 2> /dev/null)" ] && [ -n "$(command -v getenforce 2> /dev/null)" ] && [ "$(getenforce 2> /dev/null)" != "Disabled" ]; then
+		# Repeat the test for the SELinux label.
+		label=$(get_xattr security.selinux test-file)
+
+		if ! chcon unconfined_u:object_r:null_device_t:s0 test-file; then
+			echo "${RED}Cannot change security.selinux of test-file${NORM}"
+			return "$FAIL"
+		fi
+
+		if cat test-file &> /dev/null; then
+			echo "${RED}Read of test-file should not succeed (invalid security.selinux)${NORM}"
+			return "$FAIL"
+		fi
+
+		if [ -n "$label" ]; then
+			if ! chcon "$label" test-file; then
+				echo "${RED}Cannot restore original security.selinux of test-file${NORM}"
+				return "$FAIL"
+			fi
+		else
+			attr -S -r selinux test-file
+		fi
+
+		if ! cat test-file > /dev/null; then
+			echo "${RED}Cannot read test-file after restoring correct security.selinux${NORM}"
+			return "$FAIL"
+		fi
+	fi
+
+	# Repeat the test for the IMA signature.
+	ima_xattr=$(get_xattr security.ima test-file)
+	if [ -z "$ima_xattr" ]; then
+		echo "${RED}security.ima not found${NORM}"
+		return "$FAIL"
+	fi
+
+	last_char=${ima_xattr: -1}
+	((last_char += 1))
+	((last_char %= 10))
+	ima_xattr_new=${ima_xattr:0:-1}$last_char
+
+	if ! setfattr -n security.ima -v 0x"$ima_xattr_new" test-file; then
+		echo "${RED}Cannot set security.ima of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if cat test-file &> /dev/null; then
+		echo "${RED}Read of test-file should not succeed (invalid security.ima)${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! setfattr -n security.ima -v 0x"$ima_xattr" test-file; then
+		echo "${RED}Cannot restore original security.ima of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file after restoring correct security.ima${NORM}"
+		return "$FAIL"
+	fi
+
+	# Repeat the test for the EVM signature.
+	evm_xattr=$(get_xattr security.evm test-file)
+	if [ -z "$evm_xattr" ]; then
+		echo "${RED}security.evm not found${NORM}"
+		return "$FAIL"
+	fi
+
+	last_char=${evm_xattr: -1}
+	((last_char += 1))
+	((last_char %= 10))
+	evm_xattr_new=${evm_xattr:0:-1}$last_char
+
+	if ! setfattr -n security.evm -v 0x"$evm_xattr_new" test-file; then
+		echo "${RED}Cannot set security.evm of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if cat test-file &> /dev/null; then
+		echo "${RED}Read of test-file should not succeed (invalid security.evm)${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! setfattr -n security.evm -v 0x"$evm_xattr" test-file; then
+		echo "${RED}Cannot restore original security.evm of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file after restoring correct security.evm${NORM}"
+		return "$FAIL"
+	fi
+
+	# Repeat the test for ACLs.
+	if ! setfacl -m u::rwx test-file 2> /dev/null; then
+		echo "${RED}Cannot change system.posix_acl_access${NORM}"
+		return "$FAIL"
+	fi
+
+	if cat test-file &> /dev/null; then
+		echo "${RED}Read of test-file should not succeed (invalid system.posix_acl_access)${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! setfacl -m u::rw test-file; then
+		echo "${RED}Cannot restore original system.posix_acl_access for test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file after restoring correct system.posix_acl_access${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_evm_revalidate() {
+	rm -f test-file
+}
+
+# Requires:
+# - evm: Introduce evm_hmac_disabled() to safely ignore verification errors
+# - evm: Introduce evm_revalidate_status()
+# - ima: Allow imasig requirement to be satisfied by EVM portable signatures
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+#
+# The purpose of this test is to verify that IMA manages files with an EVM
+# portable signature similarly to those with an IMA signature: content can be
+# written to new files after adding the signature and files can be accessed
+# when the imasig requirement is specified in the IMA policy.
+check_evm_portable_sig_ima_appraisal() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if [ $((evm_value & EVM_INIT_X509)) -ne "$EVM_INIT_X509" ]; then
+		echo "${CYAN}EVM flag $EVM_INIT_X509 required${NORM}"
+		return "$SKIP"
+	fi
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chmod 600 test-file; then
+		echo "${RED}Cannot change mode of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# We need to defer setting the correct owner, as there could be
+	# already an IMA policy rule preventing evmctl from reading the
+	# file to calculate the digest.
+	if ! evmctl sign -o -a sha256 --imahash --uid "$APPRAISE_DIGSIG_FOWNER" --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown "$APPRAISE_DIGSIG_FOWNER" test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$APPRAISE_DIGSIG_RULE"
+	result=$?
+	if [ "$result" -ne "$OK" ]; then
+		return "$result"
+	fi
+
+	# Ensure that a file with a portable signature satisfies the
+	# appraise_type=imasig requirement specified in the IMA policy.
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Even files with a portable signature should be considered as
+	# immutable by IMA. Write should fail.
+	if echo "test" 2> /dev/null >> test-file; then
+		echo "${RED}Write to test-file should not succeed (immutable metadata)${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! tar --xattrs-include=* -cf test-archive.tar test-file; then
+		echo "${RED}Cannot create archive with xattrs${NORM}"
+		return "$FAIL"
+	fi
+
+	mkdir out
+
+	# Appraisal of the new file, extracted by tar, should succeed
+	# not only if the new file has an IMA signature but also if
+	# it has a portable signature.
+	if ! tar --xattrs-include=* -xf test-archive.tar -C out; then
+		echo "${RED}Cannot extract archive with xattrs${NORM}"
+		return "$FAIL"
+	fi
+
+	# Check if xattrs have been correctly set.
+	xattr_orig=$(get_xattr security.selinux test-file)
+	xattr=$(get_xattr security.selinux out/test-file)
+	if [ "$xattr" != "$xattr_orig" ]; then
+		echo "${RED}security.selinux mismatch between original and extracted file${NORM}"
+		return "$FAIL"
+	fi
+
+	xattr_orig=$(get_xattr security.ima test-file)
+	xattr=$(get_xattr security.ima out/test-file)
+	if [ "$xattr" != "$xattr_orig" ]; then
+		echo "${RED}security.ima mismatch between original and extracted file${NORM}"
+		return "$FAIL"
+	fi
+
+	xattr_orig=$(get_xattr security.evm test-file)
+	xattr=$(get_xattr security.evm out/test-file)
+	if [ "$xattr" != "$xattr_orig" ]; then
+		echo "${RED}security.evm mismatch between original and extracted file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Check if attrs have been correctly set.
+	owner=$(stat -c "%u" out/test-file)
+	if [ "$owner" != "$APPRAISE_DIGSIG_FOWNER" ]; then
+		echo "${RED}owner mismatch between original and extracted file${NORM}"
+		return "$FAIL"
+	fi
+
+	mode=$(stat -c "%a" out/test-file)
+	if [ "$mode" != "600" ]; then
+		echo "${RED}mode mismatch between original and extracted file${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_evm_portable_sig_ima_appraisal() {
+	rm -f test-file test-archive.tar
+	rm -Rf out
+}
+
+# Requires:
+# - ima: Introduce template field evmsig and write to field sig as fallback
+# - evm: Execute evm_inode_init_security() only when an HMAC key is loaded
+# - ima: Don't remove security.ima if file must not be appraised
+#
+# The purpose of this test is to verify that the EVM portable signature is
+# displayed in the measurement list.
+check_evm_portable_sig_ima_measurement_list() {
+	echo "Test: ${FUNCNAME[0]} (evm_value: $evm_value)"
+
+	if ! echo "test" > test-file; then
+		echo "${RED}Cannot write test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! chown "$MEASURE_FOWNER" test-file; then
+		echo "${RED}Cannot change owner of test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl sign -o -a sha256 --imahash --key "$key_path" test-file &> /dev/null; then
+		echo "${RED}Cannot sign test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$MEASURE_RULE"
+	result=$?
+	if [ "$result" -ne "$OK" ]; then
+		return "$result"
+	fi
+
+	# Invalidate previous measurement to add new entry
+	touch test-file
+
+	# Read the file to add it to the measurement list.
+	if ! cat test-file > /dev/null; then
+		echo "${RED}Cannot read test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	evm_sig_fs=$(get_xattr security.evm test-file)
+	if [ -z "$evm_sig_fs" ]; then
+		echo "${RED}security.evm not found${NORM}"
+		return "$FAIL"
+	fi
+
+	# Search security.evm in the measurement list.
+	evm_sig_list=$(awk '$6 == "'"$evm_sig_fs"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
+	if [ -z "$evm_sig_list" ]; then
+		echo "${RED}security.evm mismatch (xattr != measurement list)${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_evm_portable_sig_ima_measurement_list() {
+	rm -f test-file
+}
+
+# Run in the new environment if TST_ENV is set.
+_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_EVM_CHANGE_MODE=$TST_EVM_CHANGE_MODE TST_KEY_PATH=$TST_KEY_PATH"
+
+# Run in the new environment if TST_ENV is set (skipped test).
+_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_EVM_CHANGE_MODE=$TST_EVM_CHANGE_MODE TST_KEY_PATH=$TST_KEY_PATH TST_LIST=check_evm_revalidate"
+
+# Exit from the creator of the new environment.
+_exit_env "$TST_KERNEL"
+
+# Mount filesystems in the new environment.
+_init_env
+
+g_mountpoint=$(mktemp -d)
+g_image=$(mktemp)
+
+if [ -z "$g_mountpoint" ]; then
+	echo "${RED}Mountpoint directory not created${NORM}"
+	exit "$FAIL"
+fi
+
+if [ "$(whoami)" != "root" ]; then
+	echo "${CYAN}This script must be executed as root${NORM}"
+	exit "$SKIP"
+fi
+
+if [ -n "$TST_KEY_PATH" ]; then
+	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
+		echo "${RED}Absolute path required for the signing key${NORM}"
+		exit "$FAIL"
+	fi
+
+	if [ ! -f "$TST_KEY_PATH" ]; then
+		echo "${RED}Kernel signing key not found in $TST_KEY_PATH${NORM}"
+		exit "$FAIL"
+	fi
+
+	key_path="$TST_KEY_PATH"
+elif [ -f "$PWD/../signing_key.pem" ]; then
+	key_path="$PWD/../signing_key.pem"
+elif [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
+	key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
+elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
+	key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
+else
+	echo "${CYAN}Kernel signing key not found${NORM}"
+	exit "$SKIP"
+fi
+
+key_path_der=$(mktemp)
+
+if [ ! -f "/sys/kernel/security/evm" ]; then
+	echo "${CYAN}EVM support in the kernel disabled${NORM}"
+	exit "$SKIP"
+fi
+
+# Assume that the EVM mode can be changed in a new environment.
+if [ -n "$TST_ENV" ]; then
+	TST_EVM_CHANGE_MODE=1
+fi
+
+evm_value=$(cat /sys/kernel/security/evm)
+
+openssl x509 -in "$key_path" -out "$key_path_der" -outform der
+if ! keyctl padd asymmetric pubkey %keyring:.ima < "$key_path_der" &> /dev/null; then
+	echo "${RED}Public key cannot be added to the IMA keyring${NORM}"
+	exit "$FAIL"
+fi
+
+if ! dd if=/dev/zero of="$g_image" bs=1M count=20 &> /dev/null; then
+	echo "${RED}Cannot create test image${NORM}"
+	exit "$FAIL"
+fi
+
+g_dev=$(losetup -f "$g_image" --show)
+if [ -z "$g_dev" ]; then
+	echo "${RED}Cannot create loop device${NORM}"
+	exit "$FAIL"
+fi
+
+if ! mkfs.ext4 -U "$IMA_UUID" -b 4096 "$g_dev" &> /dev/null; then
+	echo "${RED}Cannot format $g_dev${NORM}"
+	exit "$FAIL"
+fi
+
+if ! mount -o i_version "$g_dev" "$g_mountpoint"; then
+	echo "${RED}Cannot mount loop device${NORM}"
+	exit "$FAIL"
+fi
+
+if [ -n "$(command -v mount-idmapped 2> /dev/null)" ]; then
+	echo "Found mount-idmapped at $(command -v mount-idmapped), testing idmapped mounts"
+	g_mountpoint_idmapped=$(mktemp -d)
+	if ! mount-idmapped --map-mount b:"$METADATA_CHANGE_FOWNER":0:1 "$g_mountpoint" "$g_mountpoint_idmapped"; then
+		echo "${RED}mount-idmapped failed${NORM}"
+		exit "$FAIL"
+	fi
+fi
+
+g_loop_mounted=1
+pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
+
+expect_pass check_ima_sig_appraisal
+cleanup_ima_sig_appraisal
+expect_pass check_ima_sig_ima_measurement_list
+cleanup_ima_sig_ima_measurement_list
+
+if [ "$(echo -e "$(uname -r)\n5.12" | sort -V | head -n 1)" != "5.12" ]; then
+	exit "$OK"
+fi
+
+if [ $((evm_value & EVM_INIT_X509)) -ne "$EVM_INIT_X509" ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+	if ! keyctl padd asymmetric pubkey %keyring:.evm < "$key_path_der" &> /dev/null; then
+		echo "${RED}Public key cannot be added to the EVM keyring${NORM}"
+		exit "$FAIL"
+	fi
+
+	echo "$EVM_INIT_X509" > /sys/kernel/security/evm 2> /dev/null
+fi
+
+if [ "$(expr index "$TST_LIST" "check_evm_revalidate")" -gt 0 ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+	echo "$EVM_ALLOW_METADATA_WRITES" > /sys/kernel/security/evm 2> /dev/null
+fi
+
+# We cannot determine from securityfs if EVM_SETUP_COMPLETE is set, so we set it unless EVM_ALLOW_METADATA_WRITES is set.
+if [ $((evm_value & EVM_ALLOW_METADATA_WRITES)) -ne "$EVM_ALLOW_METADATA_WRITES" ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+	echo "$EVM_SETUP_COMPLETE" > /sys/kernel/security/evm 2> /dev/null
+fi
+
+evm_value=$(cat /sys/kernel/security/evm)
+
+expect_pass check_create_file
+cleanup_create_file
+expect_pass check_cp_preserve_xattrs
+cleanup_cp_preserve_xattrs
+expect_pass check_tar_extract_xattrs_different_owner
+cleanup_tar_extract_xattrs_different_owner
+expect_pass check_tar_extract_xattrs_same_owner
+cleanup_tar_extract_xattrs_same_owner
+expect_pass check_metadata_change
+cleanup_metadata_change
+expect_pass check_evm_revalidate
+cleanup_evm_revalidate
+expect_pass check_evm_portable_sig_ima_appraisal
+cleanup_evm_portable_sig_ima_appraisal
+expect_pass check_evm_portable_sig_ima_measurement_list
+cleanup_evm_portable_sig_ima_measurement_list
-- 
2.25.1

