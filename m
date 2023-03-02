Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB166A883C
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCBSFi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 13:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCBSFh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 13:05:37 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69425BAB
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 10:05:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PSJhP0kpKz9xFGG
        for <linux-integrity@vger.kernel.org>; Fri,  3 Mar 2023 01:56:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVhY5QBk8KdkAQ--.10486S2;
        Thu, 02 Mar 2023 19:05:19 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v7] Add tests for MMAP_CHECK and MMAP_CHECK_REQPROT hooks
Date:   Thu,  2 Mar 2023 19:05:02 +0100
Message-Id: <20230302180502.618368-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVhY5QBk8KdkAQ--.10486S2
X-Coremail-Antispam: 1UD129KBjvAXoWftw45Xr48tr1DtrW3CF4kWFg_yoW8Zw15Jo
        WIgFZIv3WIyw1fA3s8uF4kCa4UGa4kCan8Ar1a9w45GF1vqryfC3WkAw1ftFWakr4rWrWq
        kF97X3WrZFWDJry3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5p7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6r
        W3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj4ojSQAAsQ
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

v6:
- Make ret_* variables in upper case (suggested by Mimi)
- Initialize variables always with hex values, and with a different style
  var=$((value)) (suggested by Mimi)

v5:
- Use the new awk script ima_policy_check.awk to check for policy overlap
- Replace exit "$FAIL" with exit 1 when changing directory at the beginning
  of the script, as FAIL is not yet defined
- Add fsmagic=0xef53 to the policy rules, to avoid overlap with the default
  ima_tcb policy (there is still overlap with the mmap rule)
- Add colors to the test results
- Replace i_version with iversion in the mount options
- Require EVM disabled or HMAC mode

v4:
- Use separate UIDs for fowner= in measure and appraise policies
- Add error messages for unexpected failed mmap() (reported by Mimi) and
  mprotect()

v3:
- Check if there are IMA policy rules without fowner= and fsuuid=, and
  if yes, skip the tests due to possible interference (suggested by Mimi)
- Fix style issues in tests/mmap_check.test

v2:
- Distinguish setup-related errors from test-related errors in test_mmap
- Rename key_path and key_path_der variables to g_key_path and
  g_key_path_der (suggested by Stefan)
- Write data to the test file in check_mmap()
- Ensure that there are no setup-related errors from test_mmap in
  tests/mmap_check.test
- Print the found entry in the IMA measurement list (suggested by Mimi)
- Check for errors when writing the test file in check_deny()
- Pass TST_KEY_PATH to the new environment
- Add description to each test (suggested by Mimi)

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

 tests/Makefile.am     |   5 +-
 tests/mmap_check.test | 407 ++++++++++++++++++++++++++++++++++++++++++
 tests/test_mmap.c     | 128 +++++++++++++
 3 files changed, 539 insertions(+), 1 deletion(-)
 create mode 100755 tests/mmap_check.test
 create mode 100644 tests/test_mmap.c

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 9a7d8a1f989..03aa5b76088 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -2,7 +2,10 @@ check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
-		 fsverity.test portable_signatures.test ima_policy_check.test
+		 fsverity.test portable_signatures.test ima_policy_check.test \
+		 mmap_check.test
+
+check_PROGRAMS := test_mmap
 
 .PHONY: check_logs
 check_logs:
diff --git a/tests/mmap_check.test b/tests/mmap_check.test
new file mode 100755
index 00000000000..2dd34335dfc
--- /dev/null
+++ b/tests/mmap_check.test
@@ -0,0 +1,407 @@
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
+RET_INVALID_RULE=$((0x0001))
+RET_RULE_OVERLAP=$((0x0002))
+RET_SAME_RULE_EXISTS=$((0x0004))
+
+EVM_INIT_HMAC=$((0x0001))
+EVM_INIT_X509=$((0x0002))
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+
+# Errors defined in test_mmap
+ERR_SETUP=1
+ERR_TEST=2
+
+cd "$(dirname "$0")" || exit 1
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
+	if [ -n "$g_key_path_der" ]; then
+		rm -f "$g_key_path_der"
+	fi
+}
+
+# Use the fsuuid= IMA policy keyword to select only files created/used by the
+# tests below. Also use fowner= to differentiate between files created/used by
+# individual tests.
+IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26e"
+MEASURE_MMAP_CHECK_FOWNER=2000
+MEASURE_MMAP_CHECK_REQPROT_FOWNER=2001
+MEASURE_MMAP_CHECK_RULE="measure func=MMAP_CHECK fsmagic=0xef53 fsuuid=$IMA_UUID fowner=$MEASURE_MMAP_CHECK_FOWNER"
+MEASURE_MMAP_CHECK_REQPROT_RULE="measure func=MMAP_CHECK_REQPROT fsmagic=0xef53 fsuuid=$IMA_UUID fowner=$MEASURE_MMAP_CHECK_REQPROT_FOWNER"
+APPRAISE_MMAP_CHECK_FOWNER=2002
+APPRAISE_MMAP_CHECK_REQPROT_FOWNER=2003
+APPRAISE_MMAP_CHECK_RULE="appraise func=MMAP_CHECK fsmagic=0xef53 fsuuid=$IMA_UUID fowner=$APPRAISE_MMAP_CHECK_FOWNER"
+APPRAISE_MMAP_CHECK_REQPROT_RULE="appraise func=MMAP_CHECK_REQPROT fsmagic=0xef53 fsuuid=$IMA_UUID fowner=$APPRAISE_MMAP_CHECK_REQPROT_FOWNER"
+
+check_load_ima_rule() {
+	local result new_policy color
+
+	echo -e "$1\n$(cat /sys/kernel/security/ima/policy)" | ima_policy_check.awk
+	result=$?
+
+	if [ $((result & RET_INVALID_RULE)) -eq $RET_INVALID_RULE ]; then
+		echo "${RED}Invalid rule${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	if [ $((result & RET_RULE_OVERLAP)) -eq $RET_RULE_OVERLAP ]; then
+		color=${YELLOW}
+		if [ -n "$TST_ENV" ]; then
+			color=${RED}
+		fi
+
+		echo "${color}Possible interference with existing IMA policy rule${NORM}"
+		if [ -n "$TST_ENV" ]; then
+			return "$HARDFAIL"
+		fi
+	fi
+
+	if [ $((result & RET_SAME_RULE_EXISTS)) -eq $RET_SAME_RULE_EXISTS ]; then
+		return "$OK"
+	fi
+
+	new_policy=$(mktemp -p "$g_mountpoint")
+	echo "$1" > "$new_policy"
+	echo "$new_policy" > /sys/kernel/security/ima/policy
+	result=$?
+	rm -f "$new_policy"
+
+	if [ "$result" -ne 0 ]; then
+		echo "${RED}Failed to set IMA policy${NORM}"
+		return "$HARDFAIL"
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
+		echo "${RED}Cannot create $test_file${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	if ! echo "test" > "$test_file"; then
+		echo "${RED}Cannot write $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	fowner="$MEASURE_MMAP_CHECK_FOWNER"
+	rule="$MEASURE_MMAP_CHECK_RULE"
+
+	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
+		fowner="$MEASURE_MMAP_CHECK_REQPROT_FOWNER"
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
+	result=$?
+
+	if [ $result -ne 0 ] && [ $result -ne "$ERR_TEST" ]; then
+		echo "${RED}Unexpected exit status $result from test_mmap${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	if [ "$TFAIL" != "yes" ]; then
+		echo -n "Result (expect found): "
+	else
+		echo -n "Result (expect not found): "
+	fi
+
+	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
+	if [ -z "$test_file_entry" ]; then
+		if [ "$TFAIL" != "yes" ]; then
+			echo "${RED}not found${NORM}"
+		else
+			echo "${GREEN}not found${NORM}"
+		fi
+		return "$FAIL"
+	fi
+
+	if [ "$TFAIL" != "yes" ]; then
+		echo "${GREEN}found${NORM}"
+	else
+		echo "${RED}found${NORM}"
+	fi
+
+	if [ "$VERBOSE" -gt 0 ]; then
+		echo "$test_file_entry"
+	fi
+
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
+		echo "${RED}Cannot create $test_file${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	if ! echo "test" > "$test_file"; then
+		echo "${RED}Cannot write $test_file${NORM}"
+		return "$FAIL"
+	fi
+
+	if ! evmctl ima_sign -a sha256 --key "$g_key_path" "$test_file" &> /dev/null; then
+		echo "${RED}Cannot sign $test_file${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	fowner="$APPRAISE_MMAP_CHECK_FOWNER"
+	rule="$APPRAISE_MMAP_CHECK_RULE"
+
+	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
+		fowner="$APPRAISE_MMAP_CHECK_REQPROT_FOWNER"
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
+	test_mmap "$test_file" exec
+	result=$?
+
+	if [ $result -ne 0 ] && [ $result -ne "$ERR_TEST" ]; then
+		echo "${RED}Unexpected exit status $result from test_mmap${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	test_mmap "$test_file" "$arg"
+	result=$?
+
+	if [ $result -ne 0 ] && [ $result -ne "$ERR_TEST" ]; then
+		echo "${RED}Unexpected exit status $result from test_mmap${NORM}"
+		return "$HARDFAIL"
+	fi
+
+	if [ "$TFAIL" != "yes" ]; then
+		echo -n "Result (expect denied): "
+	else
+		echo -n "Result (expect allowed): "
+	fi
+
+	if [ $result -eq 0 ]; then
+		if [ "$TFAIL" != "yes" ]; then
+			echo "${RED}allowed${NORM}"
+		else
+			echo "${GREEN}allowed${NORM}"
+		fi
+		return "$FAIL"
+	fi
+
+	if [ "$TFAIL" != "yes" ]; then
+		echo "${GREEN}denied${NORM}"
+	else
+		echo "${RED}denied${NORM}"
+	fi
+
+	return "$OK"
+}
+
+# Run in the new environment if TST_ENV is set.
+_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_KEY_PATH=$TST_KEY_PATH"
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
+	g_key_path="$TST_KEY_PATH"
+elif [ -f "$PWD/../signing_key.pem" ]; then
+	g_key_path="$PWD/../signing_key.pem"
+elif [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
+	g_key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
+elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
+	g_key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
+else
+	echo "${CYAN}Kernel signing key not found${NORM}"
+	exit "$SKIP"
+fi
+
+evm_value=$(cat /sys/kernel/security/evm)
+if [ $((evm_value & EVM_INIT_X509)) -eq "$EVM_INIT_X509" ]; then
+	if [ $((evm_value & EVM_INIT_HMAC)) -ne "$EVM_INIT_HMAC" ]; then
+		echo "${CYAN}Incompatible EVM mode $evm_value${NORM}"
+		exit "$SKIP"
+	fi
+fi
+
+g_key_path_der=$(mktemp)
+
+openssl x509 -in "$g_key_path" -out "$g_key_path_der" -outform der
+if ! keyctl padd asymmetric pubkey %keyring:.ima < "$g_key_path_der" &> /dev/null; then
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
+if ! mount -o iversion "$g_dev" "$g_mountpoint"; then
+	echo "${RED}Cannot mount loop device${NORM}"
+	exit "$FAIL"
+fi
+
+g_loop_mounted=1
+pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
+
+# Ensure that IMA does not add a new measurement entry if an application calls
+# mmap() with PROT_READ, and a policy rule contains the MMAP_CHECK hook.
+# In this case, both the protections requested by the application and the final
+# protections applied by the kernel contain only PROT_READ, so there is no
+# match with the IMA rule, which expects PROT_EXEC to be set.
+expect_fail check_mmap "MMAP_CHECK" ""
+
+# Ensure that IMA adds a new measurement entry if an application calls mmap()
+# with PROT_READ | PROT_EXEC, and a policy rule contains the MMAP_CHECK hook.
+expect_pass check_mmap "MMAP_CHECK" "exec"
+
+# Same as in the first test, but in this case the application calls the
+# personality() system call with READ_IMPLIES_EXEC, which causes the kernel to
+# add PROT_EXEC in the final protections passed to the MMAP_CHECK hook.
+#
+# Ensure that the bug introduced by 98de59bfe4b2 ("take calculation of final
+# protections in security_mmap_file() into a helper") is fixed, by passing the
+# final protections again to the MMAP_CHECK hook. Due to the bug, the hook
+# received the protections requested by the application. Since those protections
+# don't have PROT_EXEC, IMA was not creating a measurement entry.
+expect_pass_if '0' check_mmap "MMAP_CHECK" "read_implies_exec"
+
+# Repeat the previous three tests, but with the new MMAP_CHECK_REQPROT hook,
+# which behaves like the buggy MMAP_CHECK hook. In the third test, expect that
+# no new measurement entry is created, since the MMAP_CHECK_REQPROT hook sees
+# the protections requested by the application (PROT_READ).
+expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" ""
+expect_pass_if '1' check_mmap "MMAP_CHECK_REQPROT" "exec"
+expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" "read_implies_exec"
+
+# Ensure that IMA refuses an mprotect() with PROT_EXEC on a memory area
+# obtained with an mmap() with PROT_READ. This is due to the inability of IMA
+# to measure/appraise the file for which mmap() was called (locking issue).
+expect_pass check_deny "MMAP_CHECK" "mprotect"
+
+# Ensure that MMAP_CHECK_REQPROT has the same behavior of MMAP_CHECK for the
+# previous test.
+expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "mprotect"
+
+# Ensure that there cannot be an mmap() with PROT_EXEC on a file with writable
+# mappings, due to the inability of IMA to make a reliable measurement of that
+# file.
+expect_pass check_deny "MMAP_CHECK" "exec_on_writable"
+
+# Ensure that MMAP_CHECK_REQPROT has the same behavior of MMAP_CHECK for the
+# previous test.
+expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "exec_on_writable"
diff --git a/tests/test_mmap.c b/tests/test_mmap.c
new file mode 100644
index 00000000000..63e7597f29a
--- /dev/null
+++ b/tests/test_mmap.c
@@ -0,0 +1,128 @@
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
+/*
+ * Convention: return 1 for errors that should not occur, as they are
+ * setup-related, return 2 for errors that might occur due to testing
+ * conditions.
+ */
+#define ERR_SETUP 1
+#define ERR_TEST 2
+
+int main(int argc, char *argv[])
+{
+	struct stat st;
+	void *ptr, *ptr_write = NULL;
+	int ret, fd, fd_write, prot = PROT_READ;
+
+	if (!argv[1]) {
+		printf("Missing file parameter\n");
+		return ERR_SETUP;
+	}
+
+	if (argv[2] && !strcmp(argv[2], "read_implies_exec")) {
+		ret = personality(READ_IMPLIES_EXEC);
+		if (ret == -1) {
+			printf("Failed to set personality, err: %d (%s)\n",
+			       -errno, strerror(errno));
+			return ERR_SETUP;
+		}
+	}
+
+	if (stat(argv[1], &st) == -1) {
+		printf("Failed to access %s, err: %d (%s)\n", argv[1], -errno,
+		       strerror(errno));
+		return ERR_SETUP;
+	}
+
+	if (argv[2] && !strcmp(argv[2], "exec_on_writable")) {
+		fd_write = open(argv[1], O_RDWR);
+		if (fd_write == -1) {
+			printf("Failed to open %s in r/w, err: %d (%s)\n",
+			       argv[1], -errno, strerror(errno));
+			return ERR_SETUP;
+		}
+
+		ptr_write = mmap(0, st.st_size, PROT_WRITE, MAP_SHARED,
+				 fd_write, 0);
+		close(fd_write);
+
+		if (ptr_write == MAP_FAILED) {
+			printf("Failed mmap() with PROT_WRITE on %s, err: %d (%s)\n",
+			       argv[1], -errno, strerror(errno));
+			return ERR_SETUP;
+		}
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd == -1) {
+		printf("Failed to open %s in ro, err: %d (%s)\n", argv[1],
+		       -errno, strerror(errno));
+
+		if (ptr_write && munmap(ptr_write, st.st_size) == -1)
+			printf("Failed munmap() of writable mapping on %s, err: %d (%s)\n",
+			       argv[1], -errno, strerror(errno));
+
+		return ERR_SETUP;
+	}
+
+	if (argv[2] && !strncmp(argv[2], "exec", 4))
+		prot |= PROT_EXEC;
+
+	ptr = mmap(0, st.st_size, prot, MAP_PRIVATE, fd, 0);
+
+	close(fd);
+
+	if (ptr_write && munmap(ptr_write, st.st_size) == -1) {
+		printf("Failed munmap() of writable mapping on %s, err: %d (%s)\n",
+		       argv[1], -errno, strerror(errno));
+		return ERR_SETUP;
+	}
+
+	if (ptr == MAP_FAILED) {
+		ret = ERR_SETUP;
+		if (argv[2] && !strcmp(argv[2], "exec_on_writable") &&
+		    errno == EACCES)
+			ret = ERR_TEST;
+		else
+			printf("Failed mmap() with PROT_READ%s on %s, err: %d (%s)\n",
+			       (prot & PROT_EXEC) ? " | PROT_EXEC" : "",
+			       argv[1], -errno, strerror(errno));
+
+		return ret;
+	}
+
+	ret = 0;
+
+	if (argv[2] && !strcmp(argv[2], "mprotect")) {
+		ret = mprotect(ptr, st.st_size, PROT_EXEC);
+		if (ret == -1) {
+			ret = ERR_SETUP;
+			if (errno == EPERM)
+				ret = ERR_TEST;
+			else
+				printf("Unexpected mprotect() error on %s, err: %d (%s)\n",
+				       argv[1], -errno, strerror(errno));
+		}
+	}
+
+	if (munmap(ptr, st.st_size) == -1) {
+		printf("Failed munmap() of mapping on %s, err: %d (%s)\n",
+		       argv[1], -errno, strerror(errno));
+		return ERR_SETUP;
+	}
+
+	return ret;
+}
-- 
2.25.1

