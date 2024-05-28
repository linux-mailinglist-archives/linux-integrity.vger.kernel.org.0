Return-Path: <linux-integrity+bounces-2690-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3CC8D28AA
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9F61C2440D
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C013EFEC;
	Tue, 28 May 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SPxm7FC4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4E13E032;
	Tue, 28 May 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938481; cv=none; b=BUnKG8RQqJJSU1MNUVlaZWgwMhx5eNkAJ5GJUqDg1PmLy+V+cwKFcDNqKGDiUbyA2rxUFL76HvUNNI52GS/o+2ARkYQKOJzKy+d2SQw8UlvkJ/aMZV+bKKHnpvNLm1K/nT7iv3FpJ67qNDwmEoTR3ifAd0fuwq9ziZyKJj8BQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938481; c=relaxed/simple;
	bh=pavINxNQb0wpTkr0z/OU1wApUVEUvATkfET9/xJlDHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZ1enGM6LoUQDLbZuRYZ1v866nOx2o4iG4LJjlWxSjyU0/5Eyjnd1SWqeQg5J1fMdNWNaQb8Pm+3nKpzpj6OEl8INvwiTqm+d1vgs2JQ+N53jaY8+YfWvMmy8HvWPDq+wwaPFrmfo3/6kF+IoKZ625u6n903uZYt9LnjcjMmmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SPxm7FC4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SN6IkP025924;
	Tue, 28 May 2024 23:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=UECEOXZUODNQWxGmp7QlJ9QXvMbeAl1iWJQXorr2fdg=;
 b=SPxm7FC4PyGTaxQrodBSblks07quArUTtu56sF2DDe4rACBPIgTVJWx6r+LQkFqFNglR
 ABQGiIotKMUy/m01ZYkpI0rak+QVdbmavfv6JHCk29u9Wi5pot0o/Ua7OifgRiGIC0Tp
 NqIZgyKNRMn8jtGuKTZTRy6M064H0okYL9Xn1v1wWfT5QIMGmZQOyXbEor3S6vIDa56F
 QopZwBwqrMbvONCZvVvDANjDTavOX8+oiHpmXMBQVsTzvX8BBn02dKj75C2nLH+dTgTH
 nzraYzTkfug5ZXP65HkI5MrDyYsXroiL6vv+Ao5dsfX6CRD6LY3ZFBUkUPQ1Yv9j8V4e mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydra601sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 23:21:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SNL2q7015042;
	Tue, 28 May 2024 23:21:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydra601se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 23:21:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44SKWI8Y026795;
	Tue, 28 May 2024 23:21:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpd2gn8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 23:21:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44SNKwYV46399838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 23:21:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26775804B;
	Tue, 28 May 2024 23:20:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 681E958055;
	Tue, 28 May 2024 23:20:57 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 May 2024 23:20:57 +0000 (GMT)
Message-ID: <12cc5fd9-6537-4a0b-b7d9-1221da3bf9f7@linux.ibm.com>
Date: Tue, 28 May 2024 19:20:56 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-2-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240528210823.28798-2-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1vI7w9ooeitD5nv9F-JsXpWJtJsmzusW
X-Proofpoint-GUID: n_x_kn-cLPZDHQ4nzJ8O-lyNP5E27KxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280172



On 5/28/24 17:08, Jarkko Sakkinen wrote:
> ASN.1 template is required for TPM2 asymmetric keys, as it needs to be
> piggy-packed with the input data before applying TPM2_RSA_Decrypt. This

piggy-backed

> patch prepares crypto subsystem for the addition of those keys.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   crypto/rsa-pkcs1pad.c         | 16 ++++++++++------
>   include/crypto/rsa-pkcs1pad.h | 20 ++++++++++++++++++++
>   2 files changed, 30 insertions(+), 6 deletions(-)
>   create mode 100644 include/crypto/rsa-pkcs1pad.h
> 
> diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
> index cd501195f34a..00b6c14f861c 100644
> --- a/crypto/rsa-pkcs1pad.c
> +++ b/crypto/rsa-pkcs1pad.c
> @@ -7,6 +7,7 @@
>   
>   #include <crypto/algapi.h>
>   #include <crypto/akcipher.h>
> +#include <crypto/rsa-pkcs1pad.h>
>   #include <crypto/internal/akcipher.h>
>   #include <crypto/internal/rsa.h>
>   #include <linux/err.h>
> @@ -79,11 +80,7 @@ static const u8 rsa_digest_info_sha3_512[] = {
>   	0x05, 0x00, 0x04, 0x40
>   };
>   
> -static const struct rsa_asn1_template {
> -	const char	*name;
> -	const u8	*data;
> -	size_t		size;
> -} rsa_asn1_templates[] = {
> +static const struct rsa_asn1_template rsa_asn1_templates[] = {
>   #define _(X) { #X, rsa_digest_info_##X, sizeof(rsa_digest_info_##X) }
>   	_(md5),
>   	_(sha1),
> @@ -101,7 +98,13 @@ static const struct rsa_asn1_template {
>   	{ NULL }
>   };
>   
> -static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
> +/**
> + * rsa_lookup_asn1() - Lookup the ASN.1 digest info given the hash
> + * name:	hash algorithm name
> + *
> + * Returns the ASN.1 digest info on success, and NULL on failure.
> + */
> +const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
>   {
>   	const struct rsa_asn1_template *p;
>   
> @@ -110,6 +113,7 @@ static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
>   			return p;
>   	return NULL;
>   }
> +EXPORT_SYMBOL_GPL(rsa_lookup_asn1);
>   
>   struct pkcs1pad_ctx {
>   	struct crypto_akcipher *child;
> diff --git a/include/crypto/rsa-pkcs1pad.h b/include/crypto/rsa-pkcs1pad.h
> new file mode 100644
> index 000000000000..32c7453ff644
> --- /dev/null
> +++ b/include/crypto/rsa-pkcs1pad.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RSA padding templates.
> + */
> +
> +#ifndef _CRYPTO_RSA_PKCS1PAD_H
> +#define _CRYPTO_RSA_PKCS1PAD_H
> +
> +/*
> + * Hash algorithm name to ASN.1 template mapping.
> + */
> +struct rsa_asn1_template {
> +	const char *name;
> +	const u8 *data;
> +	size_t size;
> +};
> +
> +const struct rsa_asn1_template *rsa_lookup_asn1(const char *name);
> +
> +#endif /* _CRYPTO_RSA_PKCS1PAD_H */

