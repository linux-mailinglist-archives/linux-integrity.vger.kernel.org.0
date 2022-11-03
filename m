Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA63618AF4
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKCWAE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 18:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKCWAC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 18:00:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC721E36
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 15:00:01 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3LbKQM012417;
        Thu, 3 Nov 2022 21:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fvipPZws6QhU4MJUeC4qiyPx14flFpjUL7UNJHq9o/4=;
 b=mc4jL/P4ikEgICShyXAY2Hmya38gFwJkytaWoKtfsArl7uSVAQAt8dWWEBpdW8tX0N67
 yurAzpoMhpSJfN1Qpx82gTnA00nfc3PXE7JdY53QQ1stl1lm0zELRho0zdDnB265v0gK
 TCcUxmLZs5fLf9RgBfci5zQgQRtNJCTck3/qImwLdFwHdri4Wv0JA5nRoPnveY7zfDce
 MixHuJ8s6ieIxq0KcBXEbAXJ3x28nCyb0bxl24nnmQNPwSLw/9Fy+Xx/Lvl7o4qwqJKh
 WUSFmDwGX8sKJiAmU97bwv/feL4oHW6qnbt++ruiscGsgcNNbMptl44yaHqVPqjJw4ur Yw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmf9rfqye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 21:59:56 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3LoKEP020762;
        Thu, 3 Nov 2022 21:59:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 3kguta4b0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 21:59:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3LxtJw7930526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 21:59:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B4A95806D;
        Thu,  3 Nov 2022 21:59:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 152855805F;
        Thu,  3 Nov 2022 21:59:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 21:59:52 +0000 (GMT)
Message-ID: <b9408c83-fb51-e7c3-4375-4e8d11cc4587@linux.ibm.com>
Date:   Thu, 3 Nov 2022 17:59:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v5 15/17] Compile a newer version of OpenSSL
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-16-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221103183904.103562-16-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PnNzkdzunMKdve7VxWNl34Fm3V9R8c_C
X-Proofpoint-ORIG-GUID: PnNzkdzunMKdve7VxWNl34Fm3V9R8c_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/3/22 14:39, Mimi Zohar wrote:
> With the distros shipping OpenSSL 3 with engine support, the original
> purpose for compiling OpenSSL 3 to test sm2/sm3 is no longer necessary
> and could be removed.  Or, it could be re-purposed for building OpenSSL
> without engine support, which is needed for testing.
> 
> For both travis and github actions, update openssl-3.0.0-beta1 with
> openssl-3.0.5.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   .github/workflows/ci.yml | 6 +++---
>   .travis.yml              | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> index dc06fce64ba5..5595855512e4 100644
> --- a/.github/workflows/ci.yml
> +++ b/.github/workflows/ci.yml
> @@ -17,7 +17,7 @@ jobs:
>                 ARCH: i386
>                 TSS: tpm2-tss
>                 VARIANT: i386
> -              COMPILE_SSL: openssl-3.0.0-beta1
> +              COMPILE_SSL: openssl-3.0.5
>   
>             # cross compilation builds
>             - container: "debian:stable"
> @@ -52,7 +52,7 @@ jobs:
>               env:
>                 CC: clang
>                 TSS: ibmtss
> -              COMPILE_SSL: openssl-3.0.0-beta1
> +              COMPILE_SSL: openssl-3.0.5
>   
>             - container: "opensuse/leap"
>               env:
> @@ -63,7 +63,7 @@ jobs:
>               env:
>                 CC: gcc
>                 TSS: ibmtss
> -              COMPILE_SSL: openssl-3.0.0-beta1
> +              COMPILE_SSL: openssl-3.0.5
>   
>             - container: "ubuntu:xenial"
>               env:
> diff --git a/.travis.yml b/.travis.yml
> index edd2a21b83d3..09db401928f6 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -9,7 +9,7 @@ matrix:
>       include:
>           # 32 bit build
>           - os: linux
> -          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL=openssl-3.0.0-beta1
> +          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL=openssl-3.0.5
>             compiler: gcc
>   
>           # cross compilation builds
> @@ -32,7 +32,7 @@ matrix:
>   
>           # glibc (gcc/clang)
>           - os: linux
> -          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host" COMPILE_SSL=openssl-3.0.0-beta1
> +          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host" COMPILE_SSL=openssl-3.0.5
>             compiler: clang
>   
>           - os: linux
> @@ -40,7 +40,7 @@ matrix:
>             compiler: gcc
>   
>           - os: linux
> -          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
> +          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.5
>             compiler: gcc
>   
>           - os: linux

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
