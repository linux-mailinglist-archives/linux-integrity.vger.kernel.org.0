Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF77730C72
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jun 2023 02:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFOA7Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 20:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOA7X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 20:59:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714726A4
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jun 2023 17:59:21 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F0vOjV021728;
        Thu, 15 Jun 2023 00:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VK6nrmwndhM7wHtvQOHbTQ0L4xV7hniAYvmn/FF4WwU=;
 b=CDvLQP0a+d9UMMxc9mxGsSfByYfZnRiJOhooqPUzrWyCP6X5rWecxZLkCwsDfjDWShBS
 dNfADWmcdq+imVm66/Vl32qz05RL6YQTm43fDV/AcPFpWOASx1Zg8sVH9Nwa+p2Rfbgo
 VF9MZkU0BLPZ2xx+Al7PoyPjqQ2HYkgEBLuc8Mtct4EUaNV4oKwPkVjva9sePGQl+OxD
 ffFd1a96SEZTrVrRKuwbVIeEWat4QHl5aoDqEHYq/7vU0G816rMYjA4Ya6RGDb1rs+Vt
 9Demy2M/sNEzxn7Aaqu0B40d32bVq6UnB7Kmx0Tx1A97HV0hTbPDqD13oGMOPRMMYmqP 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7rjc80h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 00:59:04 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F0wkUb027066;
        Thu, 15 Jun 2023 00:59:04 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7rjc80gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 00:59:04 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F0oHwY003274;
        Thu, 15 Jun 2023 00:59:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5gbfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 00:59:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35F0x2rN61079836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:59:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FFFE5805A;
        Thu, 15 Jun 2023 00:59:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 107F058064;
        Thu, 15 Jun 2023 00:59:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.215])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jun 2023 00:59:01 +0000 (GMT)
Message-ID: <f98d67f3b3302d85bd2b59429e75e7a5d3f1283e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 4/4] Add simple test to check EVM HMAC
 calculation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 14 Jun 2023 20:59:01 -0400
In-Reply-To: <20230605165554.1965238-5-roberto.sassu@huaweicloud.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
         <20230605165554.1965238-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aJ9AmuxO4XwNHED2OUKWTDK0qRS5CsNO
X-Proofpoint-ORIG-GUID: Ggh6MqIucyKpIxyAxVJA5Fmm8Ggy_u-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150002
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-06-05 at 18:55 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a simple test to ensure that the kernel and evmctl provide the same
> result for the HMAC calculation. Also add another test to evaluate the
> HMAC on a directory for which Smack added the SMACK64TRANSMUTE xattr.
> 
> The second test fails without the kernel patch 'smack: Set the
> SMACK64TRANSMUTE xattr in smack_inode_init_security()', as Smack uses
> __vfs_setxattr() to set SMACK64TRANSMUTE, which does not go through EVM,
> and makes the HMAC invalid.
> 
> Require (unless the UML kernel is used) that the TST_EVM_CHANGE_MODE
> environment variable is set to 1, so that users acknowledge that they are
> initializing EVM with a well-known HMAC key, which can introduce obvious
> security concerns.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.  A few suggestions inline below.
> ---
>  kernel-configs/base      |   4 +-
>  kernel-configs/integrity |   1 +
>  tests/Makefile.am        |   2 +-
>  tests/evm_hmac.test      | 251 +++++++++++++++++++++++++++++++++++++++
>  tests/functions.sh       |   6 +
>  5 files changed, 262 insertions(+), 2 deletions(-)
>  create mode 100755 tests/evm_hmac.test
> 
> diff --git a/kernel-configs/base b/kernel-configs/base
> index 7acbd5b3b2a..6973e71f7bb 100644
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
> +CONFIG_LSM="lockdown,yama,loadpin,safesetid,smack,bpf"
>  CONFIG_CRYPTO_AEAD2=y
>  CONFIG_CRYPTO_SKCIPHER=y
>  CONFIG_CRYPTO_SKCIPHER2=y
> diff --git a/kernel-configs/integrity b/kernel-configs/integrity
> index a7e01e19466..2e104d205ba 100644
> --- a/kernel-configs/integrity
> +++ b/kernel-configs/integrity
> @@ -27,3 +27,4 @@ CONFIG_EVM_ATTR_FSUUID=y
>  CONFIG_EVM_ADD_XATTRS=y
>  CONFIG_EVM_LOAD_X509=y
>  CONFIG_EVM_X509_PATH="/etc/keys/x509_evm.der"
> +CONFIG_EVM_EXTRA_SMACK_XATTRS=y
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
> index 00000000000..e88ff4bf10c
> --- /dev/null
> +++ b/tests/evm_hmac.test
> @@ -0,0 +1,251 @@
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
> +IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26f"
> +
> +PATCHES=(
> +'KEYS: encrypted: fix key instantiation with user-provided data'
> +'KEYS: encrypted: Instantiate key with user-provided decrypted data'
> +'smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()'
> +)
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
> +# Compare HMAC calculated by the kernel with that calculated by evmctl.
> +compare_xattr() {
> +	local algo=$1
> +	local path=$2
> +	local evm_xattr evm_xattr_evmctl true_digest
> +
> +	evm_xattr="$(get_xattr security.evm "$path")"
> +	true_digest=$("$algo"sum /bin/true | awk '{print $1}')
> +	# evm_xattr has an extra byte at the beginning for the xattr type.
> +	if [ "${#evm_xattr}" != $(( ${#true_digest} + 2 )) ]; then
> +		echo "${RED}Unexpected size of security.evm for $path${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	evm_xattr_evmctl="$(evmctl hmac --smack -v -n "$path" --uuid="$IMA_UUID" -a "$algo" --hmackey "$g_hmackey" 2>&1 | awk -F " " '$1 == "hmac:" {print $2}')"
> +	if [ "$evm_xattr" != "02$evm_xattr_evmctl" ]; then
> +		echo "${RED}$path security.evm mismatch between the kernel and evmctl${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	return "$OK"
> +}
> +
> +# The purpose of this test is to verify if the kernel and evmctl produce the
> +# same HMAC.
> +check_evm_hmac() {
> +	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2)"
> +
> +	if ! touch test-file; then
> +		echo "${RED}Cannot create test-file${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	compare_xattr "$1" test-file
> +	return $?
> +}
> +
> +cleanup_evm_hmac() {
> +	rm -f test-file
> +}
> +
> +# The purpose of this test is to verify that SMACK64TRANSMUTE is successfully
> +# set on a newly created directory, and that the HMAC on that directory is valid.
> +check_evm_hmac_transmute() {
> +	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2)"
> +
> +	if ! grep -q smack < /sys/kernel/security/lsm; then
> +		echo "Smack LSM not active"
> +		return "${SKIP}"
> +	fi
> +
> +	# Add a Smack rule for transmuting of test-dir/test-dir2
> +	if ! echo "_ system rwxatl" > /sys/fs/smackfs/load2; then
> +		echo "${RED}Cannot set Smack policy${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	# Smack adds security.SMACK64=_.
> +	if ! mkdir test-dir; then
> +		echo "${RED}Cannot create test-dir${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	# Change the directory label so that transmuting happens.
> +	if ! setfattr -n security.SMACK64 -v system test-dir; then
> +		echo "${RED}Cannot set security.SMACK64 on test-dir${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	# Add the transmute xattr so that transmuting happens.
> +	if ! setfattr -n security.SMACK64TRANSMUTE -v TRUE test-dir; then
> +		echo "${RED}Cannot set security.SMACK64TRANSMUTE on test-dir${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	compare_xattr "$1" test-dir
> +	result=$?
> +
> +	if [ "$result" -ne "$OK" ]; then
> +		return "$result"
> +	fi
> +
> +	# Smack adds security.SMACK64=system and security.SMACK64TRANSMUTE=TRUE.
> +	if ! mkdir test-dir/test-dir2; then
> +		echo "${RED}Cannot create test-dir/test-dir2${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	compare_xattr "$1" test-dir/test-dir2
> +	return $?
> +}
> +
> +cleanup_evm_hmac_transmute() {
> +	rm -Rf test-dir
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

Perhaps also allow in a CI environment or set the TST_EVM_CHANGE_MODE
in the CI environment.

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
> +if ! evmctl -h | grep -q hmackey; then
> +	echo "${CYAN}Missing HMAC support, run: ./configure --enable-debug${NORM}"
> +	exit "$SKIP"
> +fi
> +
> +if [ ! -f /sys/kernel/security/integrity/evm/evm_xattrs ] ||
> +   ! grep -q SMACK64TRANSMUTE < /sys/kernel/security/integrity/evm/evm_xattrs; then
> +	echo "${CYAN}Set CONFIG_EVM_ADD_XATTRS=y and CONFIG_EVM_EXTRA_SMACK_XATTRS=y in the kernel configuration${NORM}"
> +	exit "$SKIP"
> +fi

Only check this when smack is enabled.

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
> +if ! mount "$g_dev" "$g_mountpoint"; then
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
> +expect_pass_if '0 1' check_evm_hmac sha1 ext4
> +cleanup_evm_hmac
> +
> +expect_pass_if '2' check_evm_hmac_transmute sha1 ext4
> +cleanup_evm_hmac_transmute

Skip test if smack is not enabled.

-- 
thanks,

Mimi




