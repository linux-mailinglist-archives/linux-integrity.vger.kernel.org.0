Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6643D15D5
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhGURWL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 13:22:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237413AbhGURWF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 13:22:05 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LHWoLI145886;
        Wed, 21 Jul 2021 14:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=X6ql2K3N1D+tZxNSP3FO1N6yQCDy3oNL0FBU5TQ3mSY=;
 b=jqVZTU+laKzARqud7tlKSFCeG7b0ylpu8HKqjpbHnpFnXkRrAFuWdTc2xzjL8KjMB/fs
 7gNtnU14pQu9MZyYuDULjXFAM8rYGDSyOA5bdmz64qxd1dqDjW6SXHrwOhF0EZXo2HuZ
 v5nhHFg7ry3RO1j5v5IYZ/ZfllicGcn7pKT82tGzZNOhYOJ/9cUw/Lv46eTSKtEDGJa9
 WUSLVfX0uoCGmwMo/quW6LpquH1JIbzpVqlV9gW2+RIEOJB9wOAxXWR+mXpKTEo1gGSu
 XkJMwWp5+5PygY16gOHMna8nGdz7TXdd1J/dsFGstBmdmN4tX7Ud10TXHMhmm/OtiJVm Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xr298qpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 14:02:34 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16LHYIQn149028;
        Wed, 21 Jul 2021 14:02:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xr298qn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 14:02:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16LHvYPa023517;
        Wed, 21 Jul 2021 18:02:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu8a1db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 18:02:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16LI02Sa25821618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 18:00:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B48305205A;
        Wed, 21 Jul 2021 18:02:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.57.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 38A5C52051;
        Wed, 21 Jul 2021 18:02:27 +0000 (GMT)
Message-ID: <090dad3a30d709e6fbc9d20a4d283d68e27e1620.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v7] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Wed, 21 Jul 2021 14:02:26 -0400
In-Reply-To: <20210721031659.107568-1-tianjia.zhang@linux.alibaba.com>
References: <20210721031659.107568-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DJHQEPxAEpVjGueE-C0a_3bLnilzZFZQ
X-Proofpoint-ORIG-GUID: yNgNcsc5t4HfCvITKy716UubRr3egQZb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_10:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Wed, 2021-07-21 at 11:16 +0800, Tianjia Zhang wrote:
> Keep in sync with the kernel IMA, IMA signature tool supports SM2/3
> algorithm combination. Because in the current version of OpenSSL 1.1.1,
> the SM2 algorithm and the public key using the EC algorithm share the
> same ID 'EVP_PKEY_EC', and the specific algorithm can only be
> distinguished by the curve name used. This patch supports this feature.
> 
> Secondly, the openssl 1.1.1 tool does not fully support the signature
> of SM2/3 algorithm combination, so the openssl3 tool is used in the
> test case, and there is no this problem with directly calling the
> openssl 1.1.1 API in evmctl.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Other than the change noted below in .travis.yml, it's fine.  It's now
queued in next-testing.

> ---

> diff --git a/.travis.yml b/.travis.yml
> index 7a76273..ab030e5 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -9,7 +9,7 @@ matrix:
>      include:
>          # 32 bit build
>          - os: linux
> -          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss
> +          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL: openssl-3.0.0-beta1


"COMPILE_SSL: openssl-3.0.0-beta1"  -> "COMPILE_SSL=openssl-3.0.0-
beta1"

thanks,

Mimi

>            compiler: gcc
>  
>          # cross compilation builds
> @@ -32,7 +32,7 @@ matrix:
>  
>          # glibc (gcc/clang)
>          - os: linux
> -          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
> +          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host" COMPILE_SSL: openssl-3.0.0-beta1
>            compiler: clang
>  
>          - os: linux
> @@ -40,7 +40,7 @@ matrix:
>            compiler: gcc
>  
>          - os: linux
> -          env: DISTRO=ubuntu:groovy TSS=ibmtss
> +          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL: openssl-3.0.0-beta1
>            compiler: gcc
>  
>          - os: linux
> 


