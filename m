Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA73B67D1E0
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjAZQjm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 11:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAZQjh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 11:39:37 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2E4ED20;
        Thu, 26 Jan 2023 08:39:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P2mRx6Jjdz9v7Z2;
        Fri, 27 Jan 2023 00:31:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHXGOnrNJjEzvKAA--.36334S4;
        Thu, 26 Jan 2023 17:39:21 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils] Add tests for MMAP_CHECK and MMAP_CHECK_REQPROT hooks
Date:   Thu, 26 Jan 2023 17:38:12 +0100
Message-Id: <20230126163812.1870942-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
References: <20230126163812.1870942-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHXGOnrNJjEzvKAA--.36334S4
X-Coremail-Antispam: 1UD129KBjvJXoW3tw4kJFW7Xw4fJr1rAr45Awb_yoWkuF4fpF
        4kuF90yFWDKFy2q3yfCa1jvr10ya1Ikry7XF93Kr95Aw4DZFWIyw47tFWDWF97GrWrWw4k
        Zan5trW3Ww1UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        xeHqDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4Ql7QAAsy
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add tests to ensure that, after applying the kernel patch 'ima: Align
ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
checks the protections applied by the kernel and not those requested by the
application.

Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
the MMAP_CHECK_REQPROT hook checks the protections requested by the
application.

Test both with the test_mmap application that by default requests the
PROT_READ protection flag. Its syntax is:

test_mmap <file> <mode>

where mode can be:
- exec: adds the PROT_EXEC protection flag to mmap()
- read_implies_exec: calls the personality() system call with
                     READ_IMPLIES_EXEC as the first argument before mmap()
- mprotect: adds the PROT_EXEC protection flag to a memory area in addition
            to PROT_READ
- exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
                    writable mapping

Check the different combinations of hooks/modes and ensure that a
measurement entry is found in the IMA measurement list only when it is
expected. No measurement entry should be found when only the PROT_READ
protection flag is requested or the matching policy rule has the
MMAP_CHECK_REQPROT hook and the personality() system call was called with
READ_IMPLIES_EXEC.

mprotect() with PROT_EXEC on an existing memory area protected with
PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
hook specified in the policy. The same applies for mmap() with PROT_EXEC on
a file with a writable mapping.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/Makefile.am     |   4 +-
 tests/mmap_check.test | 282 ++++++++++++++++++++++++++++++++++++++++++
 tests/test_mmap.c     |  69 +++++++++++
 3 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100755 tests/mmap_check.test
 create mode 100644 tests/test_mmap.c

diff --git a/tests/Makefile.am b/tests/Makefile.am
index a0463b7b5b5d..ca9c4ca18380 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -2,7 +2,9 @@ check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
-		 fsverity.test portable_signatures.test
+		 fsverity.test portable_signatures.test mmap_check.test
+
+check_PROGRAMS := test_mmap
 
 .PHONY: check_logs
 check_logs:
diff --git a/tests/mmap_check.test b/tests/mmap_check.test
new file mode 100755
index 000000000000..2efdd8e01785
--- /dev/null
+++ b/tests/mmap_check.test
@@ -0,0 +1,282 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
+#
+# Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
+
+trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+
+cd "$(dirname "$0")" || exit "$FAIL"
+export PATH=$PWD/../src:$PWD:$PATH
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
+
+	if [ -n "$key_path_der" ]; then
+		rm -f "$key_path_der"
+	fi
+}
+
+# Use the fsuuid= IMA policy keyword to select only files created/used by the
+# tests below. Also use fowner= to differentiate between files created/used by
+# individual tests.
+IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26e"
+MMAP_CHECK_FOWNER=2000
+MMAP_CHECK_REQPROT_FOWNER=2001
+MEASURE_MMAP_CHECK_RULE="measure func=MMAP_CHECK fsuuid=$IMA_UUID fowner=$MMAP_CHECK_FOWNER"
+MEASURE_MMAP_CHECK_REQPROT_RULE="measure func=MMAP_CHECK_REQPROT fsuuid=$IMA_UUID fowner=$MMAP_CHECK_REQPROT_FOWNER"
+APPRAISE_MMAP_CHECK_RULE="appraise func=MMAP_CHECK fsuuid=$IMA_UUID fowner=$MMAP_CHECK_FOWNER"
+APPRAISE_MMAP_CHECK_REQPROT_RULE="appraise func=MMAP_CHECK_REQPROT fsuuid=$IMA_UUID fowner=$MMAP_CHECK_REQPROT_FOWNER"
+
+check_load_ima_rule() {
+	local rule_loaded
+	local result
+	local new_policy
+
+	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
+	if [ -z "$rule_loaded" ]; then
+		new_policy=$(mktemp -p "$g_mountpoint")
+		echo "$1" > "$new_policy"
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
+check_mmap() {
+	local hook="$1"
+	local arg="$2"
+	local test_file
+	local fowner
+	local rule
+	local result
+	local test_file_entry
+
+	if ! test_file=$(mktemp -p "$PWD"); then
+		echo "${RED}Cannot write $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	fowner="$MMAP_CHECK_FOWNER"
+	rule="$MEASURE_MMAP_CHECK_RULE"
+
+	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
+		fowner="$MMAP_CHECK_REQPROT_FOWNER"
+		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
+	fi
+
+	if ! chown "$fowner" "$test_file"; then
+		echo "${RED}Cannot change owner of $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$rule"
+	result=$?
+	if [ $result -ne "$OK" ]; then
+		return $result
+	fi
+
+	test_mmap "$test_file" "$arg"
+
+	if [ "$TFAIL" != "yes" ]; then
+		echo -n "Test (expect: found): "
+	else
+		echo -n "Test (expect: not found): "
+	fi
+
+	echo -n "${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\") - "
+
+	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
+	if [ -z "$test_file_entry" ]; then
+		echo "not found"
+		return "$FAIL"
+	fi
+
+	echo "found"
+	return "$OK"
+}
+
+check_deny() {
+	local hook="$1"
+	local arg="$2"
+	local test_file
+	local fowner
+	local rule
+	local result
+
+	if ! test_file=$(mktemp -p "$PWD"); then
+		echo "${RED}Cannot write $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	echo "test" > "$test_file"
+
+	if ! evmctl ima_sign -a sha256 --key "$key_path" "$test_file" &> /dev/null; then
+		echo "${RED}Cannot sign $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	fowner="$MMAP_CHECK_FOWNER"
+	rule="$APPRAISE_MMAP_CHECK_RULE"
+
+	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
+		fowner="$MMAP_CHECK_REQPROT_FOWNER"
+		rule="$APPRAISE_MMAP_CHECK_REQPROT_RULE"
+	fi
+
+	if ! chown "$fowner" "$test_file"; then
+		echo "${RED}Cannot change owner of $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	check_load_ima_rule "$rule"
+	result=$?
+	if [ $result -ne "$OK" ]; then
+		return $result
+	fi
+
+	if ! test_mmap "$test_file" exec > /dev/null; then
+		echo "${RED}Cannot read $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	echo -n "Test (expect: denied): ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\") - "
+	if test_mmap "$test_file" "$arg"; then
+		echo "allowed"
+		return "$FAIL"
+	fi
+
+	echo "denied"
+
+	return "$OK"
+}
+
+# Run in the new environment if TST_ENV is set.
+_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
+
+# Exit from the creator of the new environment.
+_exit_env "$TST_KERNEL"
+
+# Mount filesystems in the new environment.
+_init_env
+
+if [ "$(whoami)" != "root" ]; then
+	echo "${CYAN}This script must be executed as root${NORM}"
+	exit "$SKIP"
+fi
+
+if [ ! -f /sys/kernel/security/ima/policy ]; then
+	echo "${CYAN}IMA policy file not found${NORM}"
+	exit "$SKIP"
+fi
+
+if ! cat /sys/kernel/security/ima/policy &> /dev/null; then
+	echo "${CYAN}IMA policy file is not readable${NORM}"
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
+openssl x509 -in "$key_path" -out "$key_path_der" -outform der
+if ! keyctl padd asymmetric pubkey %keyring:.ima < "$key_path_der" &> /dev/null; then
+	echo "${RED}Public key cannot be added to the IMA keyring${NORM}"
+	exit "$FAIL"
+fi
+
+g_mountpoint=$(mktemp -d)
+g_image=$(mktemp)
+
+if [ -z "$g_mountpoint" ]; then
+	echo "${RED}Mountpoint directory not created${NORM}"
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
+g_loop_mounted=1
+pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
+
+expect_fail check_mmap "MMAP_CHECK" ""
+expect_pass check_mmap "MMAP_CHECK" "exec"
+expect_pass check_mmap "MMAP_CHECK" "read_implies_exec"
+
+expect_fail check_mmap "MMAP_CHECK_REQPROT" ""
+expect_pass check_mmap "MMAP_CHECK_REQPROT" "exec"
+expect_fail check_mmap "MMAP_CHECK_REQPROT" "read_implies_exec"
+
+expect_pass check_deny "MMAP_CHECK" "mprotect"
+expect_pass check_deny "MMAP_CHECK_REQPROT" "mprotect"
+
+expect_pass check_deny "MMAP_CHECK" "exec_on_writable"
+expect_pass check_deny "MMAP_CHECK_REQPROT" "exec_on_writable"
diff --git a/tests/test_mmap.c b/tests/test_mmap.c
new file mode 100644
index 000000000000..c9396f66b3a9
--- /dev/null
+++ b/tests/test_mmap.c
@@ -0,0 +1,69 @@
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/personality.h>
+
+int main(int argc, char *argv[])
+{
+	struct stat st;
+	void *ptr, *ptr_write = NULL;
+	int ret, fd, fd_write, prot = PROT_READ;
+
+	if (!argv[1])
+		return -ENOENT;
+
+	if (argv[2] && !strcmp(argv[2], "read_implies_exec")) {
+		ret = personality(READ_IMPLIES_EXEC);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (stat(argv[1], &st) == -1)
+		return -errno;
+
+	if (argv[2] && !strcmp(argv[2], "exec_on_writable")) {
+		fd_write = open(argv[1], O_RDWR);
+		if (fd_write == -1)
+			return -errno;
+
+		ptr_write = mmap(0, st.st_size, PROT_WRITE, MAP_SHARED,
+				 fd_write, 0);
+		close(fd_write);
+
+		if (ptr_write == (void *)-1)
+			return -errno;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd == -1) {
+		if (ptr_write)
+			munmap(ptr_write, st.st_size);
+
+		return -errno;
+	}
+
+	if (argv[2] && !strncmp(argv[2], "exec", 4))
+		prot |= PROT_EXEC;
+
+	ptr = mmap(0, st.st_size, prot, MAP_PRIVATE, fd, 0);
+
+	close(fd);
+
+	if (ptr_write)
+		munmap(ptr_write, st.st_size);
+
+	if (ptr == (void *)-1)
+		return -errno;
+
+	ret = 0;
+
+	if (argv[2] && !strcmp(argv[2], "mprotect"))
+		ret = mprotect(ptr, st.st_size, PROT_EXEC);
+
+	munmap(ptr, st.st_size);
+	return ret;
+}
-- 
2.25.1

