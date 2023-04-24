Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59F6ED35F
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjDXRR4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDXRRz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 13:17:55 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AAD6A42
        for <linux-integrity@vger.kernel.org>; Mon, 24 Apr 2023 10:17:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q4s5T1YrYz9xFQf
        for <linux-integrity@vger.kernel.org>; Tue, 25 Apr 2023 01:07:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXSkGduUZkS+ZOAg--.3324S2;
        Mon, 24 Apr 2023 18:17:23 +0100 (CET)
Message-ID: <b58add10229b519df6c44e5fd2906b4c540773f7.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils 2/2] Add simple test to check EVM HMAC
 calculation
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 24 Apr 2023 19:17:13 +0200
In-Reply-To: <037f9c70d402d65813c03b0fe457ec73dabcbea3.camel@linux.ibm.com>
References: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
         <20230324181149.44694-2-roberto.sassu@huaweicloud.com>
         <037f9c70d402d65813c03b0fe457ec73dabcbea3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCXSkGduUZkS+ZOAg--.3324S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr13JrW8Zr4xGrW8KFWxZwb_yoW3tr17pa
        yrtFs5tF4ktFy7J343tanrZ3s3ta10yFy5Wrnxtw1YyF98Aw1xtrWxtr13Gr9a9r15Zr10
        va18Xw13Ww1kK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj4xhLwAAsn
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-24 at 08:22 -0400, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Fri, 2023-03-24 at 19:11 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add a simple test to ensure that the kernel and evmctl provide the same
> > result for the HMAC calculation.
> 
> Based on the LSM discussions, including a test for a file in a Smack
> transmuting directory would be nice.

Hi Mimi

ok, will add a test.

> > This test requires that, unless the UML kernel is used, the
> > TST_EVM_CHANGE_MODE environment variable is set to 1.
> 
> Agreed requring permission to enable EVM HMAC with a well known HMAC
> value is 
> a good idea.   Please update the patch description with an explanation.

Ok.

> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  kernel-configs/base |   4 +-
> >  tests/Makefile.am   |   2 +-
> >  tests/evm_hmac.test | 170 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 174 insertions(+), 2 deletions(-)
> >  create mode 100755 tests/evm_hmac.test
> > 
> > diff --git a/kernel-configs/base b/kernel-configs/base
> > index 7acbd5b3b2a..0d8714d8f98 100644
> > --- a/kernel-configs/base
> > +++ b/kernel-configs/base
> > @@ -46,11 +46,13 @@ CONFIG_TMPFS_XATTR=y
> >  CONFIG_CONFIGFS_FS=y
> >  CONFIG_KEYS=y
> >  CONFIG_ENCRYPTED_KEYS=y
> > +CONFIG_USER_DECRYPTED_DATA=y
> >  CONFIG_SECURITY=y
> >  CONFIG_SECURITYFS=y
> >  CONFIG_SECURITY_NETWORK=y
> >  CONFIG_SECURITY_PATH=y
> > -CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> > +CONFIG_SECURITY_SMACK=y
> > +CONFIG_LSM="lockdown,yama,loadpin,safesetid,smack,integrity,bpf"
> >  CONFIG_CRYPTO_AEAD2=y
> >  CONFIG_CRYPTO_SKCIPHER=y
> >  CONFIG_CRYPTO_SKCIPHER2=y
> > diff --git a/tests/Makefile.am b/tests/Makefile.am
> > index 03aa5b76088..a28f671398f 100644
> > --- a/tests/Makefile.am
> > +++ b/tests/Makefile.am
> > @@ -3,7 +3,7 @@ TESTS = $(check_SCRIPTS)
> >  
> >  check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
> >  		 fsverity.test portable_signatures.test ima_policy_check.test \
> > -		 mmap_check.test
> > +		 mmap_check.test evm_hmac.test
> >  
> >  check_PROGRAMS := test_mmap
> >  
> > diff --git a/tests/evm_hmac.test b/tests/evm_hmac.test
> > new file mode 100755
> > index 00000000000..de8b6a9a4d9
> > --- /dev/null
> > +++ b/tests/evm_hmac.test
> > @@ -0,0 +1,170 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > +#
> > +# Check if the kernel and evmctl provide the same result for HMAC calculation.
> > +
> > +trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
> > +
> > +# Base VERBOSE on the environment variable, if set.
> > +VERBOSE="${VERBOSE:-0}"
> > +TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
> > +
> > +# From security/integrity/evm/evm.h in kernel source directory
> > +(( EVM_INIT_HMAC=0x0001 ))
> > +
> > +cd "$(dirname "$0")" || exit 1
> > +export PATH=$PWD/../src:$PATH
> > +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
> > +. ./functions.sh
> > +_require evmctl
> > +
> > +cleanup() {
> > +	if [ "$g_loop_mounted" = "1" ]; then
> > +		popd > /dev/null || exit "$FAIL"
> > +		umount "$g_mountpoint"
> > +	fi
> > +
> > +	if [ -n "$g_dev" ]; then
> > +		losetup -d "$g_dev"
> > +	fi
> > +
> > +	if [ -n "$g_image" ]; then
> > +		rm -f "$g_image"
> > +	fi
> > +
> > +	if [ -n "$g_mountpoint" ]; then
> > +		rm -Rf "$g_mountpoint"
> > +	fi
> > +}
> > +
> > +get_xattr() {
> > +	local format="hex"
> > +
> > +	if [ "$1" = "security.selinux" ]; then
> > +		format="text"
> > +	fi
> > +
> > +	getfattr -n "$1" -e "$format" -d "$2" 2> /dev/null | awk -F "=" '$1 == "'"$1"'" {if ("'"$format"'" == "hex") v=substr($2, 3); else { split($2, temp, "\""); v=temp[2] }; print v}'
> > +}
> > +
> > +IMA_UUID="28b23254-9467-44c0-b6ba-34b12e85a26f"
> > +
> > +# The purpose of this test is to verify if the kernel and evmctl produce the
> > +# same HMAC.
> > +check_evm_hmac() {
> > +	local evm_xattr evm_xattr_evmctl test_file_digest
> > +
> > +	echo "Test: ${FUNCNAME[0]} (evm_hash: $1, evm_value: $g_evm_value, algo: $1, fs: $2)"
> > +
> > +	if ! touch test-file; then
> > +		echo "${RED}Cannot create test-file${NORM}"
> > +		return "$FAIL"
> > +	fi
> > +
> > +	# Compare HMAC calculated by the kernel with that calculated by evmctl.
> > +	evm_xattr="$(get_xattr security.evm test-file)"
> > +	test_file_digest=$("$1"sum test-file | awk '{print $1}')
> > +	# evm_xattr has an extra byte at the beginning for the xattr type.
> > +	if [ "${#evm_xattr}" != $(( ${#test_file_digest} + 2 )) ]; then
> > +		echo "${RED}Unexpected size of security.evm${NORM}"
> > +		return "$FAIL"
> > +	fi
> > +
> > +	evm_xattr_evmctl="$(evmctl hmac -v -n test-file --uuid=$IMA_UUID -a "$1" --hmackey "$g_hmackey" 2>&1 | awk -F " " '$1 == "hmac:" {print $2}')"
> > +	if [ "$evm_xattr" != "02$evm_xattr_evmctl" ]; then
> > +		echo "${RED}security.evm mismatch between the kernel and evmctl${NORM}"
> > +		return "$FAIL"
> > +	fi
> > +
> > +	return "$OK"
> > +}
> > +
> > +cleanup_evm_hmac() {
> > +	rm -f test-file
> > +}
> > +
> > +_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "TST_ENV=$TST_ENV TST_KERNEL=$TST_KERNEL PATH=$PATH LD_LIBRARY_PATH=$LD_LIBRARY_PATH VERBOSE=$VERBOSE"
> > +
> > +# Exit from the creator of the new environment.
> > +_exit_env "$TST_KERNEL"
> > +
> > +# Mount filesystems in the new environment.
> > +_init_env
> > +
> > +# Assume that the EVM mode can be changed in a new environment.
> > +if [ -z "$TST_ENV" ] && [ "$TST_EVM_CHANGE_MODE" -eq 0 ]; then
> > +	echo "${CYAN}TST_EVM_CHANGE_MODE env variable must be set to 1${NORM}"
> > +	exit "$SKIP"
> > +fi
> > +
> > +g_lsm_init_xattr=$(awk '$1 ~ /(smack|selinux)/' < /sys/kernel/security/lsm)
> > +if [ -z "$g_lsm_init_xattr" ]; then
> > +	echo "${CYAN}Either SMACK or SELinux must be active in the system${NORM}"
> > +	exit "$SKIP"
> > +fi
> > +
> > +g_mountpoint="$(mktemp -d)"
> > +g_image="$(mktemp)"
> > +
> > +if [ -z "$g_mountpoint" ]; then
> > +	echo "${RED}Mountpoint directory not created${NORM}"
> > +	exit "$FAIL"
> > +fi
> > +
> > +if [ "$(whoami)" != "root" ]; then
> > +	echo "${CYAN}This script must be executed as root${NORM}"
> > +	exit "$SKIP"
> > +fi
> > +
> > +if ! dd if=/dev/zero of="$g_image" bs=1M count=10 &> /dev/null; then
> > +	echo "${RED}Cannot create test image${NORM}"
> > +	exit "$FAIL"
> > +fi
> > +
> > +g_dev="$(losetup -f "$g_image" --show)"
> > +if [ -z "$g_dev" ]; then
> > +	echo "${RED}Cannot create loop device${NORM}"
> > +	exit "$FAIL"
> > +fi
> > +
> > +if ! mkfs.ext4 -U $IMA_UUID -b 4096 "$g_dev" &> /dev/null; then
> > +	echo "${RED}Cannot format $g_dev${NORM}"
> > +	exit "$FAIL"
> > +fi
> > +
> > +if ! mount -o i_version "$g_dev" "$g_mountpoint"; then
> > +	echo "${RED}Cannot mount loop device${NORM}"
> > +	exit "$FAIL"
> > +fi
> > +
> > +g_loop_mounted=1
> > +chmod 777 "$g_mountpoint"
> > +pushd "$g_mountpoint" > /dev/null || exit "$FAIL"
> > +
> > +if [ -f /sys/kernel/security/evm ]; then
> > +	g_evm_value=$(cat /sys/kernel/security/evm)
> > +fi
> > +
> > +g_hmackey_data="abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa"
> > +
> > +g_hmackey="$(mktemp)"
> > +echo $g_hmackey_data | xxd -r -p > "$g_hmackey"
> > +
> > +if [ -n "$g_evm_value" ] && [ $((g_evm_value & EVM_INIT_HMAC)) -ne $EVM_INIT_HMAC ]; then
> > +	g_evm_id="$(keyctl add encrypted evm-key "new enc32 user:kmk 32 $g_hmackey_data" @u)"
> 
> The above command fails on kernels without encrypted key support for
> user provided decrypted data.
> 
> Required commits:
> 5adedd42245a ("KEYS: encrypted: fix key instantiation with user-
> provided data")
> cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data")

Ok, thanks. Will add those commits as dependency for the tests.

Roberto

> > +	if ! echo "$EVM_INIT_HMAC" | tee /sys/kernel/security/evm &> /dev/null; then
> > +		# Retry with sudo -i, to force search in the root user keyring.
> > +		if ! echo "$EVM_INIT_HMAC" | sudo -i tee /sys/kernel/security/evm &> /dev/null; then
> > +			keyctl unlink "$g_evm_id"
> > +			echo "${RED}Failed to initialize EVM${NORM}"
> > +			exit "$FAIL"
> > +		fi
> > +	fi
> > +
> > +	g_evm_value=$(cat /sys/kernel/security/evm)
> > +fi
> > +
> > +expect_pass check_evm_hmac sha1 ext4
> > +cleanup_evm_hmac

