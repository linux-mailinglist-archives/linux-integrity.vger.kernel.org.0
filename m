Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A1667957
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 16:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjALPce (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 10:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjALPai (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 10:30:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F0DE0D7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 07:23:23 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEoiF2025042;
        Thu, 12 Jan 2023 15:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PGaQo37jLpAMSAG/dTaVWP2bnVsnQgCseFDVEyMA4QU=;
 b=XpbLQwF2zHThrwPTkrzlr1yKPdbq281Y3E2qf1gZZkoVPCSvHNDQVwq1qo8idYAxLlvY
 tdTCpWantLUW0477wyalJjbaR/8AsuOIyDcIWKtNhq8gXyhVYlVgXFtLF0LEwtM7IFvT
 CTOmkiHQisFT8nVFv+FZWYbe2iu9k0hP4zhKFj5gW8NXYbW1us9H0kkTK7UgM7ZJugL3
 NbMa9n50tqWnRr6qYeyaPWMKZnl1gcawX1ka2T1yZyus4neDtIm0wZBJKsJBB0jfbSLZ
 IRwJtn5m6/V9aPoaCi/Aza2JUYi2TYnn0ApWitKmAGSwr0G6Xve+ihi9TJY2pXMR+37R MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2mb0h2bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:22:59 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CFJwFJ036116;
        Thu, 12 Jan 2023 15:22:59 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2mb0h2ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:22:59 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEmBgu012721;
        Thu, 12 Jan 2023 15:22:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n1ka14hs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:22:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CFMvJt12583462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 15:22:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25FB358058;
        Thu, 12 Jan 2023 15:22:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B1D65805D;
        Thu, 12 Jan 2023 15:22:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 15:22:22 +0000 (GMT)
Message-ID: <bc08eaf9-1282-f6b3-3c7a-1242aacfe9e1@linux.ibm.com>
Date:   Thu, 12 Jan 2023 10:22:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 6/9] Add tests for EVM portable
 signatures
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U3SNmG_gtYMSeaik4KazCttVE2_MybEl
X-Proofpoint-ORIG-GUID: AuYs60pytS6jJEPzV1Dn-EPs3k_TxvyB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 07:24, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Verify that operations on files with EVM portable signatures succeed and
> that the new kernel patch set does not break the existing kernel integrity
> expectations. Build and install mount-idmapped for ci/fedora.sh, to
> additionally test idmapped mounts.
> 
> To run the tests, pass the path of the kernel private key with the
> TST_KEY_PATH environment variable. If not provided, the script searches the
> key in /lib/modules/$(uname -r)/source/certs/signing_key.pem and in the
> current directory. Root privileges are required to mount the image,
> configure IMA/EVM and set xattrs.
> 
> Set UML_MODE to 1, to relaunch the script in a new environment after
> booting an UML kernel. The UML kernel must be named 'linux' and placed in
> the ima-evm-utils directory.
> 
> Alternatively, set the TST_EVM_CHANGE_MODE variable to 1, to change the
> current EVM mode, if a test needs a different one. Otherwise, execute only
> the tests compatible with the current EVM mode.
> 
> Also set the EVM_ALLOW_METADATA_WRITES flag in the EVM mode, before
> launching the script, to run the check_evm_revalidate() test. Execute:
> 
> echo 4 > /sys/kernel/security/evm
> 
> The last two environment variables above affect which tests will run the
> next time the script is executed. Without setting UML_MODE to 1, changes to
> the current EVM mode will be irreversibly done in the host. Next time,
> unless the host is rebooted, only tests compatible with the last EVM mode
> set will run. The others will be skipped.
> 
> With the UML kernel, this problem does not arise as, every time the UML
> kernel is executed, it will create a clean environment with no flags set in
> the EVM mode.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   build.sh                        |    5 +
>   ci/fedora.sh                    |    7 +-
>   tests/Makefile.am               |    2 +-
>   tests/install-mount-idmapped.sh |    7 +
>   tests/portable_signatures.test  | 1173 +++++++++++++++++++++++++++++++
>   5 files changed, 1192 insertions(+), 2 deletions(-)
>   create mode 100755 tests/install-mount-idmapped.sh
>   create mode 100755 tests/portable_signatures.test
> 
> diff --git a/build.sh b/build.sh
> index 4e2f1bb7353b..0920599b2780 100755
> --- a/build.sh
> +++ b/build.sh
> @@ -114,6 +114,11 @@ if [ $ret -eq 0 ]; then
>   		grep "skipped" tests/fsverity.log  && \
>   		   grep "skipped" tests/fsverity.log | wc -l
>   	fi
> +	if [ -f tests/portable_signatures.log ]; then
> +		[ -n "$CI" ] && cat tests/portable_signatures.log || tail tests/portable_signatures.log
> +		grep "skipped" tests/portable_signatures.log  && \
> +		   grep "skipped" tests/portable_signatures.log | wc -l
> +	fi
>   	exit 0
>   fi
>   
> diff --git a/ci/fedora.sh b/ci/fedora.sh
> index 198034a34e3c..3f75d2e1ddbd 100755
> --- a/ci/fedora.sh
> +++ b/ci/fedora.sh
> @@ -47,7 +47,11 @@ yum -y install \
>   	which \
>   	zstd \
>   	haveged \
> -	systemd
> +	systemd \
> +	keyutils \
> +	e2fsprogs \
> +	acl \
> +	libcap
>   
>   yum -y install docbook5-style-xsl || true
>   yum -y install swtpm || true
> @@ -59,3 +63,4 @@ fi
>   yum -y install softhsm || true
>   
>   ./tests/install-fsverity.sh
> +./tests/install-mount-idmapped.sh
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 305082483f36..421fac577b55 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -2,7 +2,7 @@ check_SCRIPTS =
>   TESTS = $(check_SCRIPTS)
>   
>   check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
> -		 fsverity.test
> +		 fsverity.test portable_signatures.test
>   
>   clean-local:
>   	-rm -f *.txt *.out *.sig *.sig2
> diff --git a/tests/install-mount-idmapped.sh b/tests/install-mount-idmapped.sh
> new file mode 100755
> index 000000000000..e9768e2fbf7a
> --- /dev/null
> +++ b/tests/install-mount-idmapped.sh
> @@ -0,0 +1,7 @@
> +#!/bin/sh
> +
> +git clone https://github.com/brauner/mount-idmapped.git
> +cd mount-idmapped
> +gcc -o mount-idmapped mount-idmapped.c
> +cd ..
> +rm -rf mount-idmapped

Where did you just install the executable to? It looks to me like it was removed.

> diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
> new file mode 100755
> index 000000000000..a6d79c929281
> --- /dev/null
> +++ b/tests/portable_signatures.test
> @@ -0,0 +1,1173 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
> +#
> +# Check if operations on files with EVM portable signatures succeed.
> +
> +trap cleanup SIGINT SIGTERM SIGSEGV EXIT
> +
> +# Base VERBOSE on the environment variable, if set.
> +VERBOSE="${VERBOSE:-0}"
> +TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
> +UML_MODE="${UML_MODE:-0}"
> +
> +# From security/integrity/evm/evm.h in kernel source directory.
> +let "EVM_INIT_HMAC=0x0001"
> +let "EVM_INIT_X509=0x0002"
> +let "EVM_ALLOW_METADATA_WRITES=0x0004"
> +let "EVM_SETUP_COMPLETE=0x80000000"
> +
> +cd "$(dirname "$0")"
> +export PATH=$PWD/../src:$PWD/../mount-idmapped:$PATH
> +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
> +. ./functions.sh
> +_require evmctl
> +
> +_cleanup() {> +	if [ "$loop_mounted" = "1" ]; then

These global variables make it quite a bit tricky even though it's 'just a test case'. They
could clash with variables elsewhere. Maybe prefix them with 'g_' if you don't want to
pass them as parameters into the function, which I would think is yet more preferable.


> +		popd > /dev/null
> +
> +		if [ -n "$mountpoint_idmapped" ]; then
> +			umount $mountpoint_idmapped
> +		fi
> +
> +		umount $mountpoint
> +	fi
> +
> +	if [ -n "$dev" ]; then
> +		losetup -d $dev
> +	fi
> +
> +	if [ -n "$image" ]; then
> +		rm -f $image
> +	fi
> +
> +	if [ -n "$key_path_der" ]; then
> +		rm -f $key_path_der
> +	fi
> +
> +	if [ -n "$mountpoint" ]; then
> +		rm -Rf $mountpoint
> +	fi
> +
> +	if [ -n "$mountpoint_idmapped" ]; then
> +		rm -Rf $mountpoint_idmapped
> +	fi
> +}
> +
> +cleanup() {
> +	_cleanup_user_mode _cleanup
> +	_report_exit_and_cleanup
> +}
> +
> +get_xattr() {
> +	format="hex"

Don't want to use 'local format=....' to avoid clashes with possibly global variables of same name?

I would also urge to consider using shellcheck on shell script files. It helps a bit.

For now I leave it at these comment.

    Stefan
