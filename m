Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B51319574
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBKV6L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 16:58:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229469AbhBKV6K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 16:58:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BLfeBK149447;
        Thu, 11 Feb 2021 16:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GHmnZBmtTMO3LbdqMxRJQAgY++xS/Lj5eWKrx9gOHYQ=;
 b=WkIw/32W08VOIkjGgyrH4ubh5yUpYyp6c3nNL3uhoRrnm6bweCwXyjX7ENUWMMqDQlyW
 1BTAL4x6gRjumQ3f6EA6+Epx48Mu/xmVFG3pVU9Sb8y3njgsDTBZR9HGrS4L6Ck62oPz
 pvaqozjZHseLUv+OR6zNMxcPaWZkQxvqXLSldbVchkGuMiPB6jqNY0M1C66XHOuYOKiC
 FqnQf5oh+daARLyKfSKDOg0u2c3bVt496Dolsg6JyNPl/JW32KsNPwCLihOix8Lp5O7C
 vu/VWVyANHIuvJwqFEGZ0g7ZdK4r0saVZgbOpOmDFWzaUOjIlKKBXmWvnWumVa5I2uc3 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nc7r8uku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 16:57:27 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BLggL1152423;
        Thu, 11 Feb 2021 16:57:26 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36nc7r8ukk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 16:57:26 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BLqNWe024702;
        Thu, 11 Feb 2021 21:57:26 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 36hjrajw90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 21:57:25 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BLvPU512190172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 21:57:25 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3B0124058;
        Thu, 11 Feb 2021 21:57:25 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18511124054;
        Thu, 11 Feb 2021 21:57:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 21:57:25 +0000 (GMT)
Subject: Re: [PATCH 1/5] keys: cleanup build time module signing keys
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-2-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <0f5c8c18-2a53-d3c4-e252-44aaee76a9e6@linux.ibm.com>
Date:   Thu, 11 Feb 2021 16:57:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210211195435.135582-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110166
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/21 2:54 PM, Nayna Jain wrote:
> The "mrproper" target is still looking for build time generated keys
> in the old path instead of certs/ directory.
> This patch fixes the path as well removes the names of the files which
> are no longer generated.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Fixes: 28a68f828266 ("modsign: Use single PEM file for autogenerated key")
I was curious about some of the files and how they were created in the
past but couldn't see it in the hostory of the Makefile. The above
Fixes tag seems to give the wrong commit id:


commit 28a68f828266754c2bd64b87873e8099e3f8fe0c

Author: Dave Airlie <airlied@redhat.com>
Date:   Thu Oct 29 13:59:45 2020 +1000

     drm/radeon/ttm: use multihop


> ---
>   Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index ade44ac4cc2f..af18aab6bbee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1472,9 +1472,9 @@ MRPROPER_FILES += include/config include/generated          \
>   		  debian snap tar-install \
>   		  .config .config.old .version \
>   		  Module.symvers \
> -		  signing_key.pem signing_key.priv signing_key.x509	\
> -		  x509.genkey extra_certificates signing_key.x509.keyid	\
> -		  signing_key.x509.signer vmlinux-gdb.py \
> +		  certs/signing_key.pem certs/signing_key.x509 \
> +		  certs/x509.genkey \
> +		  vmlinux-gdb.py \
>   		  *.spec
>   
>   # Directories & files removed with 'make distclean'


