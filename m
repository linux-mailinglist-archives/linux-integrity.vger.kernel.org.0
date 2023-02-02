Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1E6883E6
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 17:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBBQP6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 11:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBQP5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 11:15:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE972B5;
        Thu,  2 Feb 2023 08:15:55 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312GCNIA026183;
        Thu, 2 Feb 2023 16:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=F8KStFZ77r8XZseaFCFuyoDHgAvoMSVHsstwUYTmtXI=;
 b=kceMh4XJfie2t8Ux4p9FJhbZes/rT1f83xz2ZB5BZ4lg5F1TP41+37v7ZN9zImm4KRTY
 x47hHA5+TFAeOvBdkKjT+eq+tEVaGyFbUFMsjrAUzwE6sTE9ZLEpIJVHxxZWeKC9uRRX
 cjN0nNwXANl7eAyA+IACN7JHHYag5fRexlCgyFXgIxOHKawvSsX/kEEdGCyGAZRMw6PU
 4PYUQ9gtLKZgHwatFcfP23C5vzQNVJj8JkKQEGuuO77qlvxYyOD+YNAbFFNzsRGvSM2z
 uRsq47fvmG2HgqZ1g/L6eUX0p7I7sRv0/kHT5Df+6WuFKBU1sLBKfmeEZbWf/IQIHVno IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngdvmvab6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 16:15:23 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312GFNCJ005561;
        Thu, 2 Feb 2023 16:15:23 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngdvmvaak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 16:15:23 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312FgDFL026752;
        Thu, 2 Feb 2023 16:15:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtncarn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 16:15:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312GFLFQ39649762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 16:15:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FCD25805C;
        Thu,  2 Feb 2023 16:15:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9258458058;
        Thu,  2 Feb 2023 16:15:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.99.251])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 16:15:19 +0000 (GMT)
Message-ID: <fbac5d34fee2c3d4bbf036c06252fd0671577558.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Feb 2023 11:15:18 -0500
In-Reply-To: <20230202135131.2445816-1-roberto.sassu@huaweicloud.com>
References: <20230202135131.2445816-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pm5EeGlUKfL_Reo4Fg2kZyKCgeIodtOm
X-Proofpoint-GUID: 9e-Q0b2r-PtvW1tSRcw1ia1XX_gNOGOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-02 at 14:51 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add tests to ensure that, after applying the kernel patch 'ima: Align
> ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> checks the protections applied by the kernel and not those requested by the
> application.
> 
> Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> the MMAP_CHECK_REQPROT hook checks the protections requested by the
> application.
> 
> Test both with the test_mmap application that by default requests the
> PROT_READ protection flag. Its syntax is:
> 
> test_mmap <file> <mode>
> 
> where mode can be:
> - exec: adds the PROT_EXEC protection flag to mmap()
> - read_implies_exec: calls the personality() system call with
>                      READ_IMPLIES_EXEC as the first argument before mmap()
> - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
>             to PROT_READ
> - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
>                     writable mapping
> 
> Check the different combinations of hooks/modes and ensure that a
> measurement entry is found in the IMA measurement list only when it is
> expected. No measurement entry should be found when only the PROT_READ
> protection flag is requested or the matching policy rule has the
> MMAP_CHECK_REQPROT hook and the personality() system call was called with
> READ_IMPLIES_EXEC.
> 
> mprotect() with PROT_EXEC on an existing memory area protected with
> PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> a file with a writable mapping.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> Changelog
> 
> v3:
> - Check if there are IMA policy rules without fowner= and fsuuid=, and
>   if yes, skip the tests due to possible interference (suggested by Mimi)
> - Fix style issues in tests/mmap_check.test
> 
> v2:
> - Distinguish setup-related errors from test-related errors in test_mmap
> - Rename key_path and key_path_der variables to g_key_path and
>   g_key_path_der (suggested by Stefan)
> - Write data to the test file in check_mmap()
> - Ensure that there are no setup-related errors from test_mmap in
>   tests/mmap_check.test
> - Print the found entry in the IMA measurement list (suggested by Mimi)
> - Check for errors when writing the test file in check_deny()
> - Pass TST_KEY_PATH to the new environment
> - Add description to each test (suggested by Mimi)
> 
> v1:
> - Declare PATCHES and uses new expect_pass_if() and expect_fail_if()
>   (suggested by Stefan)
> - Replace $FAIL with $HARDFAIL when the error occurs in the setup phase of
>   the test (to not make an expect_fail test successful for other reasons
>   than the focus of the test)
> - Declare local variables in one line (suggested by Stefan)
> - Print the test being executed at the beginning, so that the message
>   always appears also if an error occurs
> - Print the result of the tests in a separate line and separate the output
>   of each test
> 
>  tests/Makefile.am     |   4 +-
>  tests/mmap_check.test | 357 ++++++++++++++++++++++++++++++++++++++++++
>  tests/test_mmap.c     | 121 ++++++++++++++
>  3 files changed, 481 insertions(+), 1 deletion(-)
>  create mode 100755 tests/mmap_check.test
>  create mode 100644 tests/test_mmap.c
> 
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index a0463b7b5b5d..ca9c4ca18380 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -2,7 +2,9 @@ check_SCRIPTS =
>  TESTS = $(check_SCRIPTS)
>  
>  check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
> -		 fsverity.test portable_signatures.test
> +		 fsverity.test portable_signatures.test mmap_check.test
> +
> +check_PROGRAMS := test_mmap
>  
>  .PHONY: check_logs
>  check_logs:
> diff --git a/tests/mmap_check.test b/tests/mmap_check.test
> new file mode 100755
> index 000000000000..228c417a7f46
> --- /dev/null
> +++ b/tests/mmap_check.test
> @@ -0,0 +1,357 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
> +#
> +# Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
> +
> +trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
> +
> +PATCHES=(
> +'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
> +'ima: Introduce MMAP_CHECK_REQPROT hook'
> +)
> +
> +# Base VERBOSE on the environment variable, if set.
> +VERBOSE="${VERBOSE:-0}"
> +
> +# Errors defined in test_mmap
> +ERR_SETUP=1
> +ERR_TEST=2
> +
> +cd "$(dirname "$0")" || exit "$FAIL"
> +export PATH=$PWD/../src:$PWD:$PATH
> +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
> +. ./functions.sh
> +_require evmctl
> +
> +cleanup() {
> +	if [ "$g_loop_mounted" = "1" ]; then
> +		popd > /dev/null || exit "$FAIL"
> +		umount "$g_mountpoint"
> +	fi
> +
> +	if [ -n "$g_dev" ]; then
> +		losetup -d "$g_dev"
> +	fi
> +
> +	if [ -n "$g_image" ]; then
> +		rm -f "$g_image"
> +	fi
> +
> +	if [ -n "$g_mountpoint" ]; then
> +		rm -Rf "$g_mountpoint"
> +	fi
> +
> +	if [ -n "$g_key_path_der" ]; then
> +		rm -f "$g_key_path_der"
> +	fi
> +}
> +
> +# Use the fsuuid= IMA policy keyword to select only files created/used by the
> +# tests below. Also use fowner= to differentiate between files created/used by
> +# individual tests.
> +IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26e"
> +MMAP_CHECK_FOWNER=2000
> +MMAP_CHECK_REQPROT_FOWNER=2001
> +MEASURE_MMAP_CHECK_RULE="measure func=MMAP_CHECK fsuuid=$IMA_UUID fowner=$MMAP_CHECK_FOWNER"
> +MEASURE_MMAP_CHECK_REQPROT_RULE="measure func=MMAP_CHECK_REQPROT fsuuid=$IMA_UUID fowner=$MMAP_CHECK_REQPROT_FOWNER"
> +APPRAISE_MMAP_CHECK_RULE="appraise func=MMAP_CHECK fsuuid=$IMA_UUID fowner=$MMAP_CHECK_FOWNER"
> +APPRAISE_MMAP_CHECK_REQPROT_RULE="appraise func=MMAP_CHECK_REQPROT fsuuid=$IMA_UUID fowner=$MMAP_CHECK_REQPROT_FOWNER"
> +
> +check_load_ima_rule() {
> +	local rule_loaded result new_policy
> +
> +	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
> +	if [ -z "$rule_loaded" ]; then
> +		new_policy=$(mktemp -p "$g_mountpoint")
> +		echo "$1" > "$new_policy"
> +		echo "$new_policy" > /sys/kernel/security/ima/policy
> +		result=$?
> +		rm -f "$new_policy"
> +
> +		if [ "$result" -ne 0 ]; then
> +			echo "${RED}Failed to set IMA policy${NORM}"
> +			return "$HARDFAIL"
> +		fi
> +	fi
> +
> +	return "$OK"
> +}
> +
> +check_mmap() {
> +	local hook="$1"
> +	local arg="$2"
> +	local test_file fowner rule result test_file_entry
> +
> +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> +
> +	if ! test_file=$(mktemp -p "$PWD"); then
> +		echo "${RED}Cannot create $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	if ! echo "test" > "$test_file"; then
> +		echo "${RED}Cannot write $test_file${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	fowner="$MMAP_CHECK_FOWNER"
> +	rule="$MEASURE_MMAP_CHECK_RULE"
> +
> +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> +		rule="$MEASURE_MMAP_CHECK_REQPROT_RULE"
> +	fi
> +
> +	if ! chown "$fowner" "$test_file"; then
> +		echo "${RED}Cannot change owner of $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	check_load_ima_rule "$rule"
> +	result=$?
> +	if [ $result -ne "$OK" ]; then
> +		return $result
> +	fi
> +
> +	test_mmap "$test_file" "$arg"
> +	result=$?
> +
> +	if [ $result -ne 0 ] && [ $result -ne "$ERR_TEST" ]; then
> +		echo "${RED}Unexpected exit status $result from test_mmap${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	if [ "$TFAIL" != "yes" ]; then
> +		echo -n "Result (expect found): "
> +	else
> +		echo -n "Result (expect not found): "
> +	fi
> +
> +	test_file_entry=$(awk '$5 == "'"$test_file"'"' < /sys/kernel/security/ima/ascii_runtime_measurements)
> +	if [ -z "$test_file_entry" ]; then
> +		echo "not found"
> +		return "$FAIL"
> +	fi
> +
> +	echo "found"
> +
> +	if [ "$VERBOSE" -gt 0 ]; then
> +		echo "$test_file_entry"
> +	fi
> +
> +	return "$OK"
> +}
> +
> +check_deny() {
> +	local hook="$1"
> +	local arg="$2"
> +	local test_file fowner rule result
> +
> +	echo -e "\nTest: ${FUNCNAME[0]} (hook=\"$hook\", test_mmap arg: \"$arg\")"
> +
> +	if ! test_file=$(mktemp -p "$PWD"); then
> +		echo "${RED}Cannot create $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	if ! echo "test" > "$test_file"; then
> +		echo "${RED}Cannot write $test_file${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	if ! evmctl ima_sign -a sha256 --key "$g_key_path" "$test_file" &> /dev/null; then
> +		echo "${RED}Cannot sign $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	fowner="$MMAP_CHECK_FOWNER"
> +	rule="$APPRAISE_MMAP_CHECK_RULE"
> +
> +	if [ "$hook" = "MMAP_CHECK_REQPROT" ]; then
> +		fowner="$MMAP_CHECK_REQPROT_FOWNER"
> +		rule="$APPRAISE_MMAP_CHECK_REQPROT_RULE"
> +	fi
> +
> +	if ! chown "$fowner" "$test_file"; then
> +		echo "${RED}Cannot change owner of $test_file${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	check_load_ima_rule "$rule"
> +	result=$?
> +	if [ $result -ne "$OK" ]; then
> +		return $result
> +	fi
> +
> +	test_mmap "$test_file" exec
> +	result=$?
> +
> +	if [ $result -ne 0 ] && [ $result -ne "$ERR_TEST" ]; then
> +		echo "${RED}Unexpected exit status $result from test_mmap${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	test_mmap "$test_file" "$arg"
> +	result=$?
> +
> +	if [ $result -ne 0 ] && [ $result -ne "$ERR_TEST" ]; then
> +		echo "${RED}Unexpected exit status $result from test_mmap${NORM}"
> +		return "$HARDFAIL"
> +	fi
> +
> +	if [ "$TFAIL" != "yes" ]; then
> +		echo -n "Result (expect denied): "
> +	else
> +		echo -n "Result (expect allowed): "
> +	fi
> +
> +	if [ $result -eq 0 ]; then
> +		echo "allowed"
> +		return "$FAIL"
> +	fi
> +
> +	echo "denied"
> +	return "$OK"
> +}
> +
> +# Run in the new environment if TST_ENV is set.
> +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE TST_KEY_PATH=$TST_KEY_PATH"
> +
> +# Exit from the creator of the new environment.
> +_exit_env "$TST_KERNEL"
> +
> +# Mount filesystems in the new environment.
> +_init_env
> +
> +if [ "$(whoami)" != "root" ]; then
> +	echo "${CYAN}This script must be executed as root${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if [ ! -f /sys/kernel/security/ima/policy ]; then
> +	echo "${CYAN}IMA policy file not found${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if ! cat /sys/kernel/security/ima/policy &> /dev/null; then
> +	echo "${CYAN}IMA policy file is not readable${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if ! awk '$0 ~ /^(measure|appraise)/ && $0 !~ /fsuuid=/ && $0 !~ /fowner=/ { exit 1 }' < /sys/kernel/security/ima/policy; then
> +	echo "${CYAN}IMA policy rules without fsuuid= and fowner=, cannot continue due to possible interference with the tests${NORM}"
> +	exit "$SKIP

Since you're only adding mmap tests, I'd prefer the above test was
limited to "func=MMAP_CHECK".


> +fi
> +
> +if [ -n "$TST_KEY_PATH" ]; then
> +	if [ "${TST_KEY_PATH:0:1}" != "/" ]; then
> +		echo "${RED}Absolute path required for the signing key${NORM}"
> +		exit "$FAIL"
> +	fi
> +
> +	if [ ! -f "$TST_KEY_PATH" ]; then
> +		echo "${RED}Kernel signing key not found in $TST_KEY_PATH${NORM}"
> +		exit "$FAIL"
> +	fi
> +
> +	g_key_path="$TST_KEY_PATH"
> +elif [ -f "$PWD/../signing_key.pem" ]; then
> +	g_key_path="$PWD/../signing_key.pem"
> +elif [ -f "/lib/modules/$(uname -r)/source/certs/signing_key.pem" ]; then
> +	g_key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> +elif [ -f "/lib/modules/$(uname -r)/build/certs/signing_key.pem" ]; then
> +	g_key_path="/lib/modules/$(uname -r)/build/certs/signing_key.pem"
> +else
> +	echo "${CYAN}Kernel signing key not found${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +g_key_path_der=$(mktemp)
> +
> +openssl x509 -in "$g_key_path" -out "$g_key_path_der" -outform der
> +if ! keyctl padd asymmetric pubkey %keyring:.ima < "$g_key_path_der" &> /dev/null; then
> +	echo "${RED}Public key cannot be added to the IMA keyring${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +g_mountpoint=$(mktemp -d)
> +g_image=$(mktemp)
> +
> +if [ -z "$g_mountpoint" ]; then
> +	echo "${RED}Mountpoint directory not created${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +if ! dd if=/dev/zero of="$g_image" bs=1M count=20 &> /dev/null; then
> +	echo "${RED}Cannot create test image${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +g_dev=$(losetup -f "$g_image" --show)
> +if [ -z "$g_dev" ]; then
> +	echo "${RED}Cannot create loop device${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +if ! mkfs.ext4 -U "$IMA_UUID" -b 4096 "$g_dev" &> /dev/null; then
> +	echo "${RED}Cannot format $g_dev${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +if ! mount -o i_version "$g_dev" "$g_mountpoint"; then
> +	echo "${RED}Cannot mount loop device${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +g_loop_mounted=1
> +pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
> +
> +# Ensure that IMA does not add a new measurement entry if an application calls
> +# mmap() with PROT_READ, and a policy rule contains the MMAP_CHECK hook.
> +# In this case, both the protections requested by the application and the final
> +# protections applied by the kernel contain only PROT_READ, so there is no
> +# match with the IMA rule, which expects PROT_EXEC to be set.
> +expect_fail check_mmap "MMAP_CHECK" ""
> +
> +# Ensure that IMA adds a new measurement entry if an application calls mmap()
> +# with PROT_READ | PROT_EXEC, and a policy rule contains the MMAP_CHECK hook.
> +expect_pass check_mmap "MMAP_CHECK" "exec"
> +
> +# Same as in the first test, but in this case the application calls the
> +# personality() system call with READ_IMPLIES_EXEC, which causes the kernel to
> +# add PROT_EXEC in the final protections passed to the MMAP_CHECK hook.
> +#
> +# Ensure that the bug introduced by 98de59bfe4b2 ("take calculation of final
> +# protections in security_mmap_file() into a helper") is fixed, by passing the
> +# final protections again to the MMAP_CHECK hook. Due to the bug, the hook
> +# received the protections requested by the application. Since those protections
> +# don't have PROT_EXEC, IMA was not creating a measurement entry.
> +expect_pass_if '0' check_mmap "MMAP_CHECK" "read_implies_exec"
> +
> +# Repeat the previous three tests, but with the new MMAP_CHECK_REQPROT hook,
> +# which behaves like the buggy MMAP_CHECK hook. In the third test, expect that
> +# no new measurement entry is created, since the MMAP_CHECK_REQPROT hook sees
> +# the protections requested by the application (PROT_READ).
> +expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" ""
> +expect_pass_if '1' check_mmap "MMAP_CHECK_REQPROT" "exec"
> +expect_fail_if '1' check_mmap "MMAP_CHECK_REQPROT" "read_implies_exec"
> +
> +# Ensure that IMA refuses an mprotect() with PROT_EXEC on a memory area
> +# obtained with an mmap() with PROT_READ. This is due to the inability of IMA
> +# to measure/appraise the file for which mmap() was called (locking issue).
> +expect_pass check_deny "MMAP_CHECK" "mprotect"
> +
> +# Ensure that MMAP_CHECK_REQPROT has the same behavior of MMAP_CHECK for the
> +# previous test.
> +expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "mprotect"
> +
> +# Ensure that there cannot be an mmap() with PROT_EXEC on a file with writable
> +# mappings, due to the inability of IMA to make a reliable measurement of that
> +# file.
> +expect_pass check_deny "MMAP_CHECK" "exec_on_writable"
> +
> +# Ensure that MMAP_CHECK_REQPROT has the same behavior of MMAP_CHECK for the
> +# previous test.
> +expect_pass_if '1' check_deny "MMAP_CHECK_REQPROT" "exec_on_writable"
> diff --git a/tests/test_mmap.c b/tests/test_mmap.c
> new file mode 100644
> index 000000000000..7106ba70fc53
> --- /dev/null
> +++ b/tests/test_mmap.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
> + *
> + * Tool to test IMA MMAP_CHECK and MMAP_CHECK_REQPROT hooks.
> + */
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/personality.h>
> +
> +/*
> + * Convention: return 1 for errors that should not occur, as they are
> + * setup-related, return 2 for errors that might occur due to testing
> + * conditions.
> + */
> +#define ERR_SETUP 1
> +#define ERR_TEST 2
> +
> +int main(int argc, char *argv[])
> +{
> +	struct stat st;
> +	void *ptr, *ptr_write = NULL;
> +	int ret, fd, fd_write, prot = PROT_READ;
> +
> +	if (!argv[1]) {
> +		printf("Missing file parameter\n");
> +		return ERR_SETUP;
> +	}
> +
> +	if (argv[2] && !strcmp(argv[2], "read_implies_exec")) {
> +		ret = personality(READ_IMPLIES_EXEC);
> +		if (ret == -1) {
> +			printf("Failed to set personality, err: %d (%s)\n",
> +			       -errno, strerror(errno));
> +			return ERR_SETUP;
> +		}
> +	}
> +
> +	if (stat(argv[1], &st) == -1) {
> +		printf("Failed to access %s, err: %d (%s)\n", argv[1], -errno,
> +		       strerror(errno));
> +		return ERR_SETUP;
> +	}
> +
> +	if (argv[2] && !strcmp(argv[2], "exec_on_writable")) {
> +		fd_write = open(argv[1], O_RDWR);
> +		if (fd_write == -1) {
> +			printf("Failed to open %s in r/w, err: %d (%s)\n",
> +			       argv[1], -errno, strerror(errno));
> +			return ERR_SETUP;
> +		}
> +
> +		ptr_write = mmap(0, st.st_size, PROT_WRITE, MAP_SHARED,
> +				 fd_write, 0);
> +		close(fd_write);
> +
> +		if (ptr_write == MAP_FAILED) {
> +			printf("Failed mmap() with PROT_WRITE on %s, err: %d (%s)\n",
> +			       argv[1], -errno, strerror(errno));
> +			return ERR_SETUP;
> +		}
> +	}
> +
> +	fd = open(argv[1], O_RDONLY);
> +	if (fd == -1) {
> +		printf("Failed to open %s in ro, err: %d (%s)\n", argv[1],
> +		       -errno, strerror(errno));
> +
> +		if (ptr_write && munmap(ptr_write, st.st_size) == -1)
> +			printf("Failed munmap() of writable mapping on %s, err: %d (%s)\n",
> +			       argv[1], -errno, strerror(errno));
> +
> +		return ERR_SETUP;
> +	}
> +
> +	if (argv[2] && !strncmp(argv[2], "exec", 4))
> +		prot |= PROT_EXEC;
> +
> +	ptr = mmap(0, st.st_size, prot, MAP_PRIVATE, fd, 0);
> +
> +	close(fd);
> +
> +	if (ptr_write && munmap(ptr_write, st.st_size) == -1) {
> +		printf("Failed munmap() of writable mapping on %s, err: %d (%s)\n",
> +		       argv[1], -errno, strerror(errno));
> +		return ERR_SETUP;
> +	}
> +
> +	if (ptr == MAP_FAILED) {
> +		ret = ERR_SETUP;
> +		if (argv[2] && !strcmp(argv[2], "exec_on_writable") &&
> +		    errno == EACCES)
> +			ret = ERR_TEST;
> +

FYI, on an older distro kernel, the mmap fails and results in following
without any explanation.

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "exec")
Unexpected exit status 1 from test_mmap

With some additional debugging, I'm seeing:
Failed mmap() /tmp/tmp.4gD2UjSvC4/tmp.PlzUEm09hO, err: -13 (Permission
denied)b

Mimi

> +		return ret;
> +	}
> +
> +	ret = 0;
> +
> +	if (argv[2] && !strcmp(argv[2], "mprotect")) {
> +		ret = mprotect(ptr, st.st_size, PROT_EXEC);
> +		if (ret == -1) {
> +			ret = ERR_SETUP;
> +			if (errno == EPERM)
> +				ret = ERR_TEST;
> +		}
> +	}
> +
> +	if (munmap(ptr, st.st_size) == -1) {
> +		printf("Failed munmap() of mapping on %s, err: %d (%s)\n",
> +		       argv[1], -errno, strerror(errno));
> +		return ERR_SETUP;
> +	}
> +
> +	return ret;
> +}


