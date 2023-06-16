Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15060733A1A
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbjFPTlL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbjFPTlK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 15:41:10 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3D119
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 12:41:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QjTNf5mt9z9xFGj
        for <linux-integrity@vger.kernel.org>; Sat, 17 Jun 2023 03:14:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAH2F7TtoxksMlFAw--.17356S6;
        Fri, 16 Jun 2023 20:24:29 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 ima-evm-utils 4/4] Add simple tests to check EVM HMAC calculation
Date:   Fri, 16 Jun 2023 21:23:58 +0200
Message-Id: <20230616192358.314906-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAH2F7TtoxksMlFAw--.17356S6
X-Coremail-Antispam: 1UD129KBjvAXoW3tFy5Aw1rArWrWF1rXw4DCFg_yoW8JFy8Ko
        WxGrW3tw40gr13Arn5Zr4IyFZrCa93uF45ZrW2vw1qq3W3try8C345C34UJr4Yv3yrW3y8
        Ga4kC348ZrWUKrsxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYZ7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUI9mRUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj47EOwAAsP
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a simple test to ensure that the kernel and evmctl provide the same
result for the HMAC calculation. Do it with SELinux or Smack, whichever is
available (if the UML kernel is used, the test is done with both LSMs).

Also add another test to evaluate the HMAC on a directory for which Smack
added the SMACK64TRANSMUTE xattr.

The second test fails without the kernel patch 'smack: Set the
SMACK64TRANSMUTE xattr in smack_inode_init_security()', as Smack uses
__vfs_setxattr() to set SMACK64TRANSMUTE, which does not go through EVM,
and makes the HMAC invalid.

Require (unless the UML kernel is used) that the TST_EVM_CHANGE_MODE
environment variable is set to 1, so that users acknowledge that they are
initializing EVM with a well-known HMAC key, which can introduce obvious
security concerns.

Finally, enable SELinux, the EVM additional xattrs, and encrypted keys with
user-decrypted data in the kernel configuration for CI, and set
TST_EVM_CHANGE_MODE to 1 in the Github Action workflow.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .github/workflows/ci.yml |   1 +
 kernel-configs/base      |   6 +-
 kernel-configs/integrity |   1 +
 tests/Makefile.am        |   2 +-
 tests/evm_hmac.test      | 281 +++++++++++++++++++++++++++++++++++++++
 tests/functions.sh       |   6 +
 6 files changed, 295 insertions(+), 2 deletions(-)
 create mode 100755 tests/evm_hmac.test

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index e3dcf3dbc0a..54dbca5e5d7 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -152,6 +152,7 @@ jobs:
               TSS: ibmtss
               TST_ENV: um
               TST_KERNEL: ../linux
+              TST_EVM_CHANGE_MODE: 1
 
           - container: "centos:7"
             env:
diff --git a/kernel-configs/base b/kernel-configs/base
index 7acbd5b3b2a..a3cec34bc58 100644
--- a/kernel-configs/base
+++ b/kernel-configs/base
@@ -46,11 +46,13 @@ CONFIG_TMPFS_XATTR=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_KEYS=y
 CONFIG_ENCRYPTED_KEYS=y
+CONFIG_USER_DECRYPTED_DATA=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_PATH=y
-CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
+CONFIG_SECURITY_SMACK=y
+CONFIG_LSM="lockdown,yama,loadpin,safesetid,selinux,smack,bpf"
 CONFIG_CRYPTO_AEAD2=y
 CONFIG_CRYPTO_SKCIPHER=y
 CONFIG_CRYPTO_SKCIPHER2=y
@@ -211,3 +213,5 @@ CONFIG_9P_FS_POSIX_ACL=y
 CONFIG_9P_FS_SECURITY=y
 CONFIG_ETHERNET=n
 CONFIG_WLAN=n
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_SELINUX_DEVELOP=y
diff --git a/kernel-configs/integrity b/kernel-configs/integrity
index a7e01e19466..2e104d205ba 100644
--- a/kernel-configs/integrity
+++ b/kernel-configs/integrity
@@ -27,3 +27,4 @@ CONFIG_EVM_ATTR_FSUUID=y
 CONFIG_EVM_ADD_XATTRS=y
 CONFIG_EVM_LOAD_X509=y
 CONFIG_EVM_X509_PATH="/etc/keys/x509_evm.der"
+CONFIG_EVM_EXTRA_SMACK_XATTRS=y
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 03aa5b76088..a28f671398f 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -3,7 +3,7 @@ TESTS = $(check_SCRIPTS)
 
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
 		 fsverity.test portable_signatures.test ima_policy_check.test \
-		 mmap_check.test
+		 mmap_check.test evm_hmac.test
 
 check_PROGRAMS := test_mmap
 
diff --git a/tests/evm_hmac.test b/tests/evm_hmac.test
new file mode 100755
index 00000000000..fe0ee218dd0
--- /dev/null
+++ b/tests/evm_hmac.test
@@ -0,0 +1,281 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
+#
+# Check if the kernel and evmctl provide the same result for HMAC calculation.
+
+trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
+IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26f"
+
+PATCHES=(
+'KEYS: encrypted: fix key instantiation with user-provided data'
+'KEYS: encrypted: Instantiate key with user-provided decrypted data'
+'smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()'
+)
+
+# From security/integrity/evm/evm.h in kernel source directory
+(( EVM_INIT_HMAC=0x0001 ))
+
+cd "$(dirname "$0")" || exit 1
+export PATH=$PWD/../src:$PATH
+export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
+. ./functions.sh
+_require evmctl
+
+cleanup() {
+	if [ "$g_loop_mounted" = "1" ]; then
+		popd > /dev/null || exit "$FAIL"
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
+	if [ -n "$g_mountpoint" ]; then
+		rm -Rf "$g_mountpoint"
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
+	getfattr -n "$1" -e "$format" -d "$2" 2> /dev/null | awk -F "=" '$1 == "'"$1"'" {if ("'"$format"'" == "hex") v=substr($2, 3); else { split($2, temp, "\""); v=temp[2] }; print v}'
+}
+
+# Compare HMAC calculated by the kernel with that calculated by evmctl.
+compare_xattr() {
+	local algo=$1
+	local path=$2
+	local evm_xattr evm_xattr_evmctl true_digest
+
+	evm_xattr="$(get_xattr security.evm "$path")"
+	true_digest=$("$algo"sum /bin/true | awk '{print $1}')
+	# evm_xattr has an extra byte at the beginning for the xattr type.
+	if [ "${#evm_xattr}" != $(( ${#true_digest} + 2 )) ]; then
+		echo "${RED}Unexpected size of security.evm for $path${NORM}"
+		return "$FAIL"
+	fi
+
+	evm_xattr_evmctl="$(evmctl hmac --smack -v -n "$path" --uuid="$IMA_UUID" -a "$algo" --hmackey "$g_hmackey" 2>&1 | awk -F " " '$1 == "hmac:" {print $2}')"
+	if [ "$evm_xattr" != "02$evm_xattr_evmctl" ]; then
+		echo "${RED}$path security.evm mismatch between the kernel and evmctl${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+# The purpose of this test is to verify if the kernel and evmctl produce the
+# same HMAC.
+check_evm_hmac() {
+	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2, lsm: $3)"
+
+	if ! grep -q "$3" < /sys/kernel/security/lsm; then
+		echo "${CYAN}$3 LSM not active${NORM}"
+		return "$SKIP"
+	fi
+
+	if [ "$3" = "selinux" ] && [ -n "$TST_ENV" ]; then
+		if [ -z "$(command -v load_policy 2> /dev/null)" ]; then
+			echo "${CYAN}Cannot find load_policy${NORM}"
+			return "$SKIP"
+		fi
+
+		if ! load_policy -i; then
+			echo "${RED}SELinux policy loading failed${NORM}"
+			return "$FAIL"
+		else
+			# Undo selinuxfs mount done by load_policy (sysfs cannot be mounted twice, procfs works but causes umount warning)
+			umount /sys/fs/selinux
+		fi
+	fi
+
+	if ! touch test-file; then
+		echo "${RED}Cannot create test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	compare_xattr "$1" test-file
+	return $?
+}
+
+cleanup_evm_hmac() {
+	rm -f test-file
+}
+
+# The purpose of this test is to verify that SMACK64TRANSMUTE is successfully
+# set on a newly created directory, and that the HMAC on that directory is valid.
+check_evm_hmac_transmute() {
+	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2, lsm: $3)"
+
+	if ! grep -q "$3" < /sys/kernel/security/lsm; then
+		echo "${CYAN}$3 LSM not active${NORM}"
+		return "$SKIP"
+	fi
+
+	if [ ! -f /sys/kernel/security/integrity/evm/evm_xattrs ] ||
+	   ! grep -q SMACK64TRANSMUTE < /sys/kernel/security/integrity/evm/evm_xattrs; then
+		echo "${CYAN}Set CONFIG_EVM_ADD_XATTRS=y and CONFIG_EVM_EXTRA_SMACK_XATTRS=y in the kernel configuration${NORM}"
+		exit "$SKIP"
+	fi
+
+	# Add a Smack rule for transmuting of test-dir/test-dir2
+	if ! echo "_ system rwxatl" > /sys/fs/smackfs/load2; then
+		echo "${RED}Cannot set Smack policy${NORM}"
+		return "$FAIL"
+	fi
+
+	# Smack adds security.SMACK64=_.
+	if ! mkdir test-dir; then
+		echo "${RED}Cannot create test-dir${NORM}"
+		return "$FAIL"
+	fi
+
+	# Change the directory label so that transmuting happens.
+	if ! setfattr -n security.SMACK64 -v system test-dir; then
+		echo "${RED}Cannot set security.SMACK64 on test-dir${NORM}"
+		return "$FAIL"
+	fi
+
+	# Add the transmute xattr so that transmuting happens.
+	if ! setfattr -n security.SMACK64TRANSMUTE -v TRUE test-dir; then
+		echo "${RED}Cannot set security.SMACK64TRANSMUTE on test-dir${NORM}"
+		return "$FAIL"
+	fi
+
+	compare_xattr "$1" test-dir
+	result=$?
+
+	if [ "$result" -ne "$OK" ]; then
+		return "$result"
+	fi
+
+	# Smack adds security.SMACK64=system and security.SMACK64TRANSMUTE=TRUE.
+	if ! mkdir test-dir/test-dir2; then
+		echo "${RED}Cannot create test-dir/test-dir2${NORM}"
+		return "$FAIL"
+	fi
+
+	compare_xattr "$1" test-dir/test-dir2
+	return $?
+}
+
+cleanup_evm_hmac_transmute() {
+	rm -Rf test-dir
+}
+
+if [ $$ -ne 1 ]; then
+	# Run in the new environment if TST_ENV is set.
+
+	# SElinux enabled
+	_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_LIST=check_evm_hmac security=selinux enforcing=0"
+
+	# Smack enabled
+	_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE security=smack"
+
+	# Exit from the creator of the new environment.
+	_exit_env "$TST_KERNEL"
+fi
+
+# Mount filesystems in the new environment.
+_init_env
+
+# Assume that the EVM mode can be changed in a new environment.
+if [ -z "$TST_ENV" ] && [ "$TST_EVM_CHANGE_MODE" -eq 0 ]; then
+	echo "${CYAN}TST_EVM_CHANGE_MODE env variable must be set to 1${NORM}"
+	exit "$SKIP"
+fi
+
+g_lsm_init_xattr=$(awk '$1 ~ /(smack|selinux)/' < /sys/kernel/security/lsm)
+if [ -z "$g_lsm_init_xattr" ]; then
+	echo "${CYAN}Either Smack or SELinux must be active in the system for security.evm to be set${NORM}"
+	exit "$SKIP"
+fi
+
+g_mountpoint="$(mktemp -d)"
+g_image="$(mktemp)"
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
+if ! evmctl -h | grep -q hmackey; then
+	echo "${CYAN}Missing HMAC support, run: ./configure --enable-debug${NORM}"
+	exit "$SKIP"
+fi
+
+if ! dd if=/dev/zero of="$g_image" bs=1M count=10 &> /dev/null; then
+	echo "${RED}Cannot create test image${NORM}"
+	exit "$FAIL"
+fi
+
+g_dev="$(losetup -f "$g_image" --show)"
+if [ -z "$g_dev" ]; then
+	echo "${RED}Cannot create loop device${NORM}"
+	exit "$FAIL"
+fi
+
+if ! mkfs.ext4 -U $IMA_UUID -b 4096 "$g_dev" &> /dev/null; then
+	echo "${RED}Cannot format $g_dev${NORM}"
+	exit "$FAIL"
+fi
+
+if ! mount "$g_dev" "$g_mountpoint"; then
+	echo "${RED}Cannot mount loop device${NORM}"
+	exit "$FAIL"
+fi
+
+g_loop_mounted=1
+chmod 777 "$g_mountpoint"
+pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
+
+if [ -f /sys/kernel/security/evm ]; then
+	g_evm_value=$(cat /sys/kernel/security/evm)
+fi
+
+g_hmackey_data="abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa"
+
+g_hmackey="$(mktemp)"
+echo $g_hmackey_data | xxd -r -p > "$g_hmackey"
+
+if [ -n "$g_evm_value" ] && [ $((g_evm_value & EVM_INIT_HMAC)) -ne $EVM_INIT_HMAC ]; then
+	g_evm_id="$(keyctl add encrypted evm-key "new enc32 user:kmk 32 $g_hmackey_data" @u)"
+	if ! echo "$EVM_INIT_HMAC" | tee /sys/kernel/security/evm &> /dev/null; then
+		# Retry with sudo -i, to force search in the root user keyring.
+		if ! echo "$EVM_INIT_HMAC" | sudo -i tee /sys/kernel/security/evm &> /dev/null; then
+			keyctl unlink "$g_evm_id"
+			echo "${RED}Failed to initialize EVM${NORM}"
+			exit "$FAIL"
+		fi
+	fi
+
+	g_evm_value=$(cat /sys/kernel/security/evm)
+fi
+
+expect_pass_if '0 1' check_evm_hmac sha1 ext4 selinux
+cleanup_evm_hmac
+expect_pass_if '0 1' check_evm_hmac sha1 ext4 smack
+cleanup_evm_hmac
+
+expect_pass_if '2' check_evm_hmac_transmute sha1 ext4 smack
+cleanup_evm_hmac_transmute
diff --git a/tests/functions.sh b/tests/functions.sh
index ed06040b394..35e925cc963 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -434,6 +434,9 @@ _init_env() {
   mount -t proc proc /proc
   mount -t sysfs sysfs /sys
   mount -t securityfs securityfs /sys/kernel/security
+  if grep -q smack < /sys/kernel/security/lsm; then
+    mount -t smackfs smackfs /sys/fs/smackfs
+  fi
 
   if [ -n "$(command -v haveged 2> /dev/null)" ]; then
     $(command -v haveged) -w 1024 &> /dev/null
@@ -455,6 +458,9 @@ _cleanup_env() {
 
   $1
 
+  if grep -q smack < /sys/kernel/security/lsm; then
+    umount /sys/fs/smackfs
+  fi
   umount /sys/kernel/security
   umount /sys
   umount /proc
-- 
2.25.1

