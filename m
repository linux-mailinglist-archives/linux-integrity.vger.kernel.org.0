Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6431FBCD
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhBSPPy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 10:15:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34560 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBSPPw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 10:15:52 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JFDdot160620;
        Fri, 19 Feb 2021 10:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HG916JzUvCGd0XA3MA7GITjOyeISHK/xPUBZjbxGqBY=;
 b=TxOCv+HW9AGztSYA2EO/ZmoJZ/jbeSB+1iI+1WlAUb73dK0xVHQLGYyA1xJr3RrxGbxp
 64cCFQyAAbKgnk1cIbqO2GExhYL7Q0H5xYfdWzwVNfxfCii4o5tBFJlKK/vWT1RF7r6A
 XIU+dDvFSbM/Plw9uTx15quxTyj05/aXmvjaAnB2AnPrnLerm2IFpBTEFpWfp0/VxM4r
 sSaaSYC+O92OxkZBC9QypVopRyiUbov+e9rtKggz6IiICMc2euHAwGQU80uKNosGA8Ck
 gt1Fm+Puya4DYoSW70DBI1/2u/CvRnx+irrv2rGtdWHD4GvEMiFcBTCRcPsKrv1ze43K Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tfshr2ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:15:09 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JFDjP5161481;
        Fri, 19 Feb 2021 10:15:08 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tfshr2a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:15:08 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JFBkpq001586;
        Fri, 19 Feb 2021 15:15:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 36p6d9x845-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 15:15:08 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JFF7WK15532358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 15:15:07 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B1B12405B;
        Fri, 19 Feb 2021 15:15:06 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 761D7124058;
        Fri, 19 Feb 2021 15:15:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 15:15:06 +0000 (GMT)
Subject: Re: [PATCH v2 2/5] keys: generate self-signed module signing key
 using CSR
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
 <20210218220011.67625-3-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1f0d786f-44c1-f247-be18-323e4eea2441@linux.ibm.com>
Date:   Fri, 19 Feb 2021 10:15:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218220011.67625-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_07:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/18/21 5:00 PM, Nayna Jain wrote:
> Loading a key on the IMA trusted keyring requires the key be signed
> by an existing key on the builtin or secondary trusted keyring.
> Creating a Certificate Signing Request (CSR) allows the certificate
> to be self-signed or signed by a CA.
>
> Generate a self-signed module signing key using CSR.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Tested this also as part of a patch I am going to post.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   Makefile       |  3 ++-
>   certs/Makefile | 15 +++++++++++----
>   2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 004163a4e6b3..a971d4ae40bd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1473,7 +1473,8 @@ MRPROPER_FILES += include/config include/generated          \
>   		  .config .config.old .version \
>   		  Module.symvers \
>   		  certs/signing_key.pem certs/signing_key.x509 \
> -		  certs/x509.genkey \
> +		  certs/x509.genkey certs/signing_key.key \
> +		  certs/signing_key.crt certs/signing_key.csr \
>   		  vmlinux-gdb.py \
>   		  *.spec
>   
> diff --git a/certs/Makefile b/certs/Makefile
> index f4c25b67aad9..b2be7eb413d3 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -60,11 +60,18 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
>   	@$(kecho) "### needs to be run as root, and uses a hardware random"
>   	@$(kecho) "### number generator if one is available."
>   	@$(kecho) "###"
> -	$(Q)openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
> -		-batch -x509 -config $(obj)/x509.genkey \
> -		-outform PEM -out $(obj)/signing_key.pem \
> -		-keyout $(obj)/signing_key.pem \
> +	$(Q)openssl req -new -nodes -utf8 \
> +		-batch -config $(obj)/x509.genkey \
> +		-outform PEM -out $(obj)/signing_key.csr \
> +		-keyout $(obj)/signing_key.key -extensions myexts \
>   		$($(quiet)redirect_openssl)
> +	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
> +		-outform PEM -out $(obj)/signing_key.crt \
> +		-signkey $(obj)/signing_key.key \
> +		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
> +		-extfile $(obj)/x509.genkey \
> +		$($(quiet)redirect_openssl)
> +	@cat $(obj)/signing_key.key $(obj)/signing_key.crt >> $(obj)/signing_key.pem
>   	@$(kecho) "###"
>   	@$(kecho) "### Key pair generated."
>   	@$(kecho) "###"


