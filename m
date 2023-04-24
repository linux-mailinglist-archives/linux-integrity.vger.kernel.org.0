Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2C6ECBF1
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDXMWj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXMWi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 08:22:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD726B7
        for <linux-integrity@vger.kernel.org>; Mon, 24 Apr 2023 05:22:36 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OC4scn018498;
        Mon, 24 Apr 2023 12:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bcnfAW69whwONsbLU6nu5P5tS//n3d4IxjpspdlKeOc=;
 b=jgy4ydqTpGrI/pUfSBxGSo3fBVdeU2+9uAwIOUxjPDrbGgedi4Ij8OY4IgXpB65qs0UJ
 3UuTjq5rTzPOkosqQWGrIKhwy9EiBrTSZH+eJyDSXE16XcEHXyABtNE57Advc/OIP2EZ
 rBec9DJhuO0Fg5VFhKXZgvjweIMcWRHt2UJKA0w8qiyEJXs7I+4I9Wjn7CFebc/Vr0Av
 vYMJBokJfrBP75d6juflWSuR1wgVw3CHzrIMl6+vB2ptV1XDZgwMXKnXnWefD+iIfu7o
 63zT+Gj5QHYwOnblzszum2hpt1PUz7d8WQx+jfPYOqckSjlCh6diprIgigM4zhHwyOc6 WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q48jktfgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 12:22:12 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33OCKqiP009127;
        Mon, 24 Apr 2023 12:22:11 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q48jktfg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 12:22:11 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33O9jXca016566;
        Mon, 24 Apr 2023 12:22:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3q4777wse5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 12:22:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OCM9SS27656878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 12:22:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B2058056;
        Mon, 24 Apr 2023 12:22:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A718058052;
        Mon, 24 Apr 2023 12:22:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.17.10])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 12:22:08 +0000 (GMT)
Message-ID: <037f9c70d402d65813c03b0fe457ec73dabcbea3.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 2/2] Add simple test to check EVM HMAC
 calculation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 24 Apr 2023 08:22:08 -0400
In-Reply-To: <20230324181149.44694-2-roberto.sassu@huaweicloud.com>
References: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
         <20230324181149.44694-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XACwl2swzK2hCZg9VZB1tCCXirxUYy0v
X-Proofpoint-GUID: Zz66vj3o9XaXHjCkdG51TB2SeaybDftT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Fri, 2023-03-24 at 19:11 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a simple test to ensure that the kernel and evmctl provide the same
> result for the HMAC calculation.

Based on the LSM discussions, including a test for a file in a Smack
transmuting directory would be nice.

> This test requires that, unless the UML kernel is used, the
> TST_EVM_CHANGE_MODE environment variable is set to 1.

Agreed requring permission to enable EVM HMAC with a well known HMAC
value is 
a good idea.   Please update the patch description with an explanation.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  kernel-configs/base |   4 +-
>  tests/Makefile.am   |   2 +-
>  tests/evm_hmac.test | 170 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+), 2 deletions(-)
>  create mode 100755 tests/evm_hmac.test
> 
> diff --git a/kernel-configs/base b/kernel-configs/base
> index 7acbd5b3b2a..0d8714d8f98 100644
> --- a/kernel-configs/base
> +++ b/kernel-configs/base
> @@ -46,11 +46,13 @@ CONFIG_TMPFS_XATTR=y
>  CONFIG_CONFIGFS_FS=y
>  CONFIG_KEYS=y
>  CONFIG_ENCRYPTED_KEYS=y
> +CONFIG_USER_DECRYPTED_DATA=y
>  CONFIG_SECURITY=y
>  CONFIG_SECURITYFS=y
>  CONFIG_SECURITY_NETWORK=y
>  CONFIG_SECURITY_PATH=y
> -CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> +CONFIG_SECURITY_SMACK=y
> +CONFIG_LSM="lockdown,yama,loadpin,safesetid,smack,integrity,bpf"
>  CONFIG_CRYPTO_AEAD2=y
>  CONFIG_CRYPTO_SKCIPHER=y
>  CONFIG_CRYPTO_SKCIPHER2=y
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 03aa5b76088..a28f671398f 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -3,7 +3,7 @@ TESTS = $(check_SCRIPTS)
>  
>  check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
>  		 fsverity.test portable_signatures.test ima_policy_check.test \
> -		 mmap_check.test
> +		 mmap_check.test evm_hmac.test
>  
>  check_PROGRAMS := test_mmap
>  
> diff --git a/tests/evm_hmac.test b/tests/evm_hmac.test
> new file mode 100755
> index 00000000000..de8b6a9a4d9
> --- /dev/null
> +++ b/tests/evm_hmac.test
> @@ -0,0 +1,170 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> +#
> +# Check if the kernel and evmctl provide the same result for HMAC calculation.
> +
> +trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
> +
> +# Base VERBOSE on the environment variable, if set.
> +VERBOSE="${VERBOSE:-0}"
> +TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
> +
> +# From security/integrity/evm/evm.h in kernel source directory
> +(( EVM_INIT_HMAC=0x0001 ))
> +
> +cd "$(dirname "$0")" || exit 1
> +export PATH=$PWD/../src:$PATH
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
> +}
> +
> +get_xattr() {
> +	local format="hex"
> +
> +	if [ "$1" = "security.selinux" ]; then
> +		format="text"
> +	fi
> +
> +	getfattr -n "$1" -e "$format" -d "$2" 2> /dev/null | awk -F "=" '$1 == "'"$1"'" {if ("'"$format"'" == "hex") v=substr($2, 3); else { split($2, temp, "\""); v=temp[2] }; print v}'
> +}
> +
> +IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26f"
> +
> +# The purpose of this test is to verify if the kernel and evmctl produce the
> +# same HMAC.
> +check_evm_hmac() {
> +	local evm_xattr evm_xattr_evmctl test_file_digest
> +
> +	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2)"
> +
> +	if ! touch test-file; then
> +		echo "${RED}Cannot create test-file${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	# Compare HMAC calculated by the kernel with that calculated by evmctl.
> +	evm_xattr="$(get_xattr security.evm test-file)"
> +	test_file_digest=$("$1"sum test-file | awk '{print $1}')
> +	# evm_xattr has an extra byte at the beginning for the xattr type.
> +	if [ "${#evm_xattr}" != $(( ${#test_file_digest} + 2 )) ]; then
> +		echo "${RED}Unexpected size of security.evm${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	evm_xattr_evmctl="$(evmctl hmac -v -n test-file --uuid=$IMA_UUID -a "$1" --hmackey "$g_hmackey" 2>&1 | awk -F " " '$1 == "hmac:" {print $2}')"
> +	if [ "$evm_xattr" != "02$evm_xattr_evmctl" ]; then
> +		echo "${RED}security.evm mismatch between the kernel and evmctl${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	return "$OK"
> +}
> +
> +cleanup_evm_hmac() {
> +	rm -f test-file
> +}
> +
> +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
> +
> +# Exit from the creator of the new environment.
> +_exit_env "$TST_KERNEL"
> +
> +# Mount filesystems in the new environment.
> +_init_env
> +
> +# Assume that the EVM mode can be changed in a new environment.
> +if [ -z "$TST_ENV" ] && [ "$TST_EVM_CHANGE_MODE" -eq 0 ]; then
> +	echo "${CYAN}TST_EVM_CHANGE_MODE env variable must be set to 1${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +g_lsm_init_xattr=$(awk '$1 ~ /(smack|selinux)/' < /sys/kernel/security/lsm)
> +if [ -z "$g_lsm_init_xattr" ]; then
> +	echo "${CYAN}Either SMACK or SELinux must be active in the system${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +g_mountpoint="$(mktemp -d)"
> +g_image="$(mktemp)"
> +
> +if [ -z "$g_mountpoint" ]; then
> +	echo "${RED}Mountpoint directory not created${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +if [ "$(whoami)" != "root" ]; then
> +	echo "${CYAN}This script must be executed as root${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if ! dd if=/dev/zero of="$g_image" bs=1M count=10 &> /dev/null; then
> +	echo "${RED}Cannot create test image${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +g_dev="$(losetup -f "$g_image" --show)"
> +if [ -z "$g_dev" ]; then
> +	echo "${RED}Cannot create loop device${NORM}"
> +	exit "$FAIL"
> +fi
> +
> +if ! mkfs.ext4 -U $IMA_UUID -b 4096 "$g_dev" &> /dev/null; then
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
> +chmod 777 "$g_mountpoint"
> +pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
> +
> +if [ -f /sys/kernel/security/evm ]; then
> +	g_evm_value=$(cat /sys/kernel/security/evm)
> +fi
> +
> +g_hmackey_data="abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa"
> +
> +g_hmackey="$(mktemp)"
> +echo $g_hmackey_data | xxd -r -p > "$g_hmackey"
> +
> +if [ -n "$g_evm_value" ] && [ $((g_evm_value & EVM_INIT_HMAC)) -ne $EVM_INIT_HMAC ]; then
> +	g_evm_id="$(keyctl add encrypted evm-key "new enc32 user:kmk 32 $g_hmackey_data" @u)"

The above command fails on kernels without encrypted key support for
user provided decrypted data.

Required commits:
5adedd42245a ("KEYS: encrypted: fix key instantiation with user-
provided data")
cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
decrypted data")

> +	if ! echo "$EVM_INIT_HMAC" | tee /sys/kernel/security/evm &> /dev/null; then
> +		# Retry with sudo -i, to force search in the root user keyring.
> +		if ! echo "$EVM_INIT_HMAC" | sudo -i tee /sys/kernel/security/evm &> /dev/null; then
> +			keyctl unlink "$g_evm_id"
> +			echo "${RED}Failed to initialize EVM${NORM}"
> +			exit "$FAIL"
> +		fi
> +	fi
> +
> +	g_evm_value=$(cat /sys/kernel/security/evm)
> +fi
> +
> +expect_pass check_evm_hmac sha1 ext4
> +cleanup_evm_hmac

-- 
thanks,

Mimi


