Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB558683427
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 18:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjAaRn6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAaRnz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 12:43:55 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE920D14;
        Tue, 31 Jan 2023 09:43:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P5sdc0Bf5z9xFg4;
        Wed,  1 Feb 2023 01:35:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3wVgpU9ljouLfAA--.11198S4;
        Tue, 31 Jan 2023 18:43:25 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2] Add tests for MMAP_CHECK and MMAP_CHECK_REQPROT hooks
Date:   Tue, 31 Jan 2023 18:42:45 +0100
Message-Id: <20230131174245.2343342-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
References: <20230131174245.2343342-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3wVgpU9ljouLfAA--.11198S4
X-Coremail-Antispam: 1UD129KBjvAXoW3tw4kJFWDtF1kZFyDuF13XFb_yoW8JF4xGo
        WxKFWaq3Wftw43A3s5uFs7Ja4UG3Z7Ca15Arya9a15KF1kJryfC3WkAw1ftFW2kr4rurWv
        gF97Ww1rZrWDJw1fn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj4hZ2AACsx
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
Changelog

v1:
- Declare PATCHES and uses new expect_pass_if() and expect_fail_if()
  (suggested by Stefan)
- Replace $FAIL with $HARDFAIL when the error occurs in the setup phase of
  the test (to not make an expect_fail test successful for other reasons
  than the focus of the test)
- Declare local variables in one line (suggested by Stefan)
- Print the test being executed at the beginning, so that the message
  always appears also if an error occurs
- Print the result of the tests in a separate line and separate the output
  of each test

 tests/Makefile.am     |   4 +-
 tests/mmap_check.test | 284 ++++++++++++++++++++++++++++++++++++++++++
 tests/test_mmap.c     |  75 +++++++++++
 3 files changed, 362 insertions(+), 1 deletion(-)
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
index 000000000000..a045ee867437
--- /dev/null
+++ b/tests/mmap_check.test
@@ -0,0 +1,284 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
+#
+# Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
+
+trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
+
+PATCHES=(
+'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
+'ima: Introduce MMAP_CHECK_REQPROT hook'
+)
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
+	local rule_loaded result new_policy
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
+			return "$HARDFAIL"
+		fi
+	fi
+
+	return "$OK"
+}
+
+check_mmap() {
+	local hook="$1"
+	local arg="$2"
+	local test_file fowner rule result test_file_entry
+
+	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
+
+	if ! test_file=$(mktemp -p "$PWD"); then
+		echo "${RED}Cannot write $test_file${NORM}"
+		return "$HARDFAIL"
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
+		return "$HARDFAIL"
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
+		echo -n "Result (expect found): "
+	else
+		echo -n "Result (expect not found): "
+	fi
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
+	local test_file fowner rule result
+
+	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
+
+	if ! test_file=$(mktemp -p "$PWD"); then
+		echo "${RED}Cannot write $test_file${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	echo "test" > "$test_file"
+
+	if ! evmctl ima_sign -a sha256 --key "$key_path" "$test_file" &> /dev/null; then
+		echo "${RED}Cannot sign $test_file${NORM}"
+		return "$HARDFAIL"
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
+		return "$HARDFAIL"
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
+		return "$HARDFAIL"
+	fi
+
+	if [ "$TFAIL" != "yes" ]; then
+		echo -n "Result (expect denied): "
+	else
+		echo -n "Result (expect allowed): "
+	fi
+
+	if test_mmap "$test_file" "$arg"; then
+		echo "allowed"
+		return "$FAIL"
+	fi
+
+	echo "denied"
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
+expect_pass_if '0' check_mmap "MMAP_CHECK" "read_implies_exec"
+
+expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" ""
+expect_pass_if '1' check_mmap "MMAP_CHECK_REQPROT" "exec"
+expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" "read_implies_exec"
+
+expect_pass check_deny "MMAP_CHECK" "mprotect"
+expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "mprotect"
+
+expect_pass check_deny "MMAP_CHECK" "exec_on_writable"
+expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "exec_on_writable"
diff --git a/tests/test_mmap.c b/tests/test_mmap.c
new file mode 100644
index 000000000000..6d1beb3bb6a2
--- /dev/null
+++ b/tests/test_mmap.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Tool to test IMA MMAP_CHECK and MMAP_CHECK_REQPROT hooks.
+ */
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

