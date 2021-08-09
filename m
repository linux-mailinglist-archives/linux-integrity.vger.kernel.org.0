Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661523E4E33
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 22:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHIU7m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 16:59:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhHIU7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 16:59:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179KXwUx128624;
        Mon, 9 Aug 2021 16:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=wmTAJT5xwW0htdyS7OnStJAr6DBUJsiLLQ4npd0S4JQ=;
 b=MeOm7pnV6C9o2LiqnXHUP0rQBxfU3mP1Y/QqJFa3hOOZGE1hVE1gxluDF9gu72XbTKsU
 sj0ipkjEcjW/gFRFOVx2xorKlYdM5xmgJEWU1ZspGhT2/ryYP7pJpytoCLDm7od/QLMG
 qP34m2oRVRU2QeXkAcZg/aqelPa2H1TDq/j79aBzZtmJANYVkyITi0xPyN1AGnv+EP8X
 1JV+Mj1htWLP9MEGTtBan31A2xMmufaAceEHkindLL4W6Ng+xV4ML5ptNKriKB6CarOA
 wyOVA/5eGuiTGIj+hTqIPB5WpPkMjMnh1S6GIPaA2DSuX/Qrs/Qo9bsZYA7K4SrshujE Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j8j0d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 16:59:20 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179KYWPn131103;
        Mon, 9 Aug 2021 16:59:20 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j8j0cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 16:59:20 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179KwjQO006927;
        Mon, 9 Aug 2021 20:59:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3a9ht8m7x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 20:59:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179Ku7D439977254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 20:56:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EAA0A4064;
        Mon,  9 Aug 2021 20:59:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E0C1A4054;
        Mon,  9 Aug 2021 20:59:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 20:59:13 +0000 (GMT)
Message-ID: <6e325a893b94ffda59a9ae1a277858ba438dc9e2.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/5] IMA: remove the dependency on CRYPTO_MD5
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 09 Aug 2021 16:59:13 -0400
In-Reply-To: <20210804092010.350372-2-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
         <20210804092010.350372-2-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yi8bPPxgqy70uK9Bc2UeG_lIdI6IdjCH
X-Proofpoint-ORIG-GUID: XY_DhpUbN8rGMh8SMw4Ywj4cIW5VEIkF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_08:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:
> MD5 is a weak digest algorithm that shouldn't be used for cryptographic
> operation. It hinders the efficiency of a patch set that aims to limit
> the digests allowed for the extended file attribute namely security.ima.
> MD5 is no longer a requirement for IMA, nor should it be used there.
> 
> Remove the CRYPTO_MD5 dependency for IMA.
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>  security/integrity/ima/Kconfig    | 1 -
>  security/integrity/ima/ima_main.c | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index d0ceada99243..f3a9cc201c8c 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -6,7 +6,6 @@ config IMA
>  	select SECURITYFS
>  	select CRYPTO
>  	select CRYPTO_HMAC
> -	select CRYPTO_MD5
>  	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
>  	select TCG_TPM if HAS_IOMEM && !UML
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1cba6beb5a60..b70ee0125168 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -53,7 +53,8 @@ static int __init hash_setup(char *str)
>  	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
>  		if (strncmp(str, "sha1", 4) == 0) {
>  			ima_hash_algo = HASH_ALGO_SHA1;
> -		} else if (strncmp(str, "md5", 3) == 0) {
> +		} else if (IS_ENABLED(CONFIG_CRYPTO_MD5)
> +			   && strncmp(str, "md5", 3) == 0) {
>  			ima_hash_algo = HASH_ALGO_MD5;
>  		} else {
>  			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",

FYI, with the non "ima" template formats and MD5 is not configured, it
fails with the following messages:

ima: Can not allocate md5 (reason: -2)
ima: Allocating md5 failed, going to use default hash algorithm sha256

thanks,

Mimi

