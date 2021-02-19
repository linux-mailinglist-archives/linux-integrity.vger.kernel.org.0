Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4C31FBC4
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBSPOP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 10:14:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229498AbhBSPOO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 10:14:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JF2IGt018704;
        Fri, 19 Feb 2021 10:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SBzqk1eEKNz/Uh1hx50Bwt2K+b97ad15WHdnWcNjOeE=;
 b=MqQpqJ6evAgWzuTQIlYFrl948HTIU5CZiNcpTWnj7ax9iJwKOmth8BDtEJ0/apJZG5SR
 5zYPcWgFOBbqCvk5Avnw5CL0tQb77sk53cT/qqsB+5uE54IiiO0qcL31g6xOD7w1gDl6
 LxVd0YaPtz0mukary9wQREAIsEnTfrDOfAyWj/H1eh8waUnNEZuYVRu4lD42Kr7fFqZV
 GcW/wA9Zmw/BczSqSFIpkso4g7L7fG0Dyzio1uBAWBWP5x49NHONG/Ibv2AsYH+vRP3n
 nPs1/1kSzi54YPfZNO0/Sz8M+xiFPonzgIGVOnuCW6YK6jiwc8rMh49onJHu88ehcOOO lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tdjwwayw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:13:29 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JF2Nj8019283;
        Fri, 19 Feb 2021 10:13:19 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tdjwwa0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:13:18 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JFCkYC005419;
        Fri, 19 Feb 2021 15:12:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 36p6daht53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 15:12:48 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JFClkb18547194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 15:12:47 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D5C7124054;
        Fri, 19 Feb 2021 15:12:47 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3647212405B;
        Fri, 19 Feb 2021 15:12:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 15:12:47 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] keys: cleanup build time module signing keys
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
 <20210218220011.67625-2-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1653f062-9824-c1eb-d147-745971b4884e@linux.ibm.com>
Date:   Fri, 19 Feb 2021 10:12:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218220011.67625-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_07:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/18/21 5:00 PM, Nayna Jain wrote:
> The "mrproper" target is still looking for build time generated keys in
> the old path instead of certs/ directory. Fix the path and remove the
> names of the files which are no longer generated.
>
> Fixes: fb1179499134 ("modsign: Use single PEM file for autogenerated key")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

The actual move of the certs files happened in cfc411e7fff3e15. That may 
be the better commit to mention.

Otherwise:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index de1acaefe87e..004163a4e6b3 100644
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


