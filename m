Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8A6C848C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Mar 2023 19:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCXSMU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Mar 2023 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCXSMT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Mar 2023 14:12:19 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419171B30D
        for <linux-integrity@vger.kernel.org>; Fri, 24 Mar 2023 11:12:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pjqmk5CC4z9xFn1
        for <linux-integrity@vger.kernel.org>; Sat, 25 Mar 2023 02:02:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHXGPq5x1khGfFAQ--.26365S3;
        Fri, 24 Mar 2023 19:12:04 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 2/2] Add simple test to check EVM HMAC calculation
Date:   Fri, 24 Mar 2023 19:11:49 +0100
Message-Id: <20230324181149.44694-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
References: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHXGPq5x1khGfFAQ--.26365S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw18Jr13uFy8AF4xWFWxWFg_yoWxur1fpF
        48WF95tr4kJFy2q3y3GanrCw1ftayIyFy3WFnxKw1YyF1DJrZ7tryIqry3Gr9Igr1Sgr1v
        va1xAr43Ww1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-pnQUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj4clAQAFsX
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a simple test to ensure that the kernel and evmctl provide the same
result for the HMAC calculation.

This test requires that, unless the UML kernel is used, the
TST_EVM_CHANGE_MODE environment variable is set to 1.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel-configs/base |   4 +-
 tests/Makefile.am   |   2 +-
 tests/evm_hmac.test | 170 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 2 deletions(-)
 create mode 100755 tests/evm_hmac.test

diff --git a/kernel-configs/base b/kernel-configs/base
index 7acbd5b3b2a..0d8714d8f98 100644
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
+CONFIG_LSM="lockdown,yama,loadpin,safesetid,smack,integrity,bpf"
 CONFIG_CRYPTO_AEAD2=y
 CONFIG_CRYPTO_SKCIPHER=y
 CONFIG_CRYPTO_SKCIPHER2=y
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
index 00000000000..de8b6a9a4d9
--- /dev/null
+++ b/tests/evm_hmac.test
@@ -0,0 +1,170 @@
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
+IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26f"
+
+# The purpose of this test is to verify if the kernel and evmctl produce the
+# same HMAC.
+check_evm_hmac() {
+	local evm_xattr evm_xattr_evmctl test_file_digest
+
+	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2)"
+
+	if ! touch test-file; then
+		echo "${RED}Cannot create test-file${NORM}"
+		return "$FAIL"
+	fi
+
+	# Compare HMAC calculated by the kernel with that calculated by evmctl.
+	evm_xattr="$(get_xattr security.evm test-file)"
+	test_file_digest=$("$1"sum test-file | awk '{print $1}')
+	# evm_xattr has an extra byte at the beginning for the xattr type.
+	if [ "${#evm_xattr}" != $(( ${#test_file_digest} + 2 )) ]; then
+		echo "${RED}Unexpected size of security.evm${NORM}"
+		return "$FAIL"
+	fi
+
+	evm_xattr_evmctl="$(evmctl hmac -v -n test-file --uuid=$IMA_UUID -a "$1" --hmackey "$g_hmackey" 2>&1 | awk -F " " '$1 == "hmac:" {print $2}')"
+	if [ "$evm_xattr" != "02$evm_xattr_evmctl" ]; then
+		echo "${RED}security.evm mismatch between the kernel and evmctl${NORM}"
+		return "$FAIL"
+	fi
+
+	return "$OK"
+}
+
+cleanup_evm_hmac() {
+	rm -f test-file
+}
+
+_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
+
+# Exit from the creator of the new environment.
+_exit_env "$TST_KERNEL"
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
+	echo "${CYAN}Either SMACK or SELinux must be active in the system${NORM}"
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
+if ! mount -o i_version "$g_dev" "$g_mountpoint"; then
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
+expect_pass check_evm_hmac sha1 ext4
+cleanup_evm_hmac
-- 
2.25.1

