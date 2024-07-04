Return-Path: <linux-integrity+bounces-2992-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4096A926D43
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 03:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69081F21E98
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 01:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA03DDA9;
	Thu,  4 Jul 2024 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zq9qmCvH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1139C2FD;
	Thu,  4 Jul 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058234; cv=none; b=W5AlwrP+U8f5pT4MfXwV3yrz7aVfq9YTqA+A6pfEcsLUYZUHt2hk93THbzbUF+kgQIFDz+MeTGbpnJbAxRxN+KriSsp/E1aRhD+gcpQ0SMEBUZ+QX5pQb4zfB/uV52fkbMYUKbgkXZ5Q8MflCIMUVof1nsBhLNBO37sZnhJbFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058234; c=relaxed/simple;
	bh=+qJzjsjpEmB0TOaGq27B1GJ0YyPKAntm3RKk01+BVEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cYOpMtjzIsjajqd5SCGD/JneFP/0/OyDny4We/Wcw1PrOue8OJt/BUR7FIW/636myczGDoG4bt045/CmaBrHllG+wxfy84RGB2xDReK0jkVNbbQus37FPkpn/CS55zUdfb+oDpsQsCXP1bwEBOjan+YcfzmXHtFXMcY3oDH3LX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zq9qmCvH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4641T3Hq031621;
	Thu, 4 Jul 2024 01:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	KuCqcH8eagQt1rGzasRwmWS9IuI/nEYZLHuvhUT+HPA=; b=Zq9qmCvHgJ3Mic10
	az+ROM5onZ6e8cqWCR9uBtGC2y4r4yslASW7I2DaNjWKpylzQAH4OhwTaJrko8XL
	MiQlsuWMENmtENi8l0c56NtS64RvRQloTJntthF3WmYBGsBa7SUr/wXbo646riwo
	LPFwFgWFwGrJetGR+WWtdP8Nqg6duJEZ0HJuRtVlzAIIwfodnC9mQr/tVNv3fagM
	xy0epNh7uAI3ElnopP66ygG+jeK1+iHoKBqTxE7NPvsmWYCJ6AtcWnj3yGnymjxG
	31LQEyMtTM+xqHpxPUWUCK6E/lV2zlVOxnDBq0u35b6XaoCqbsraZBZ3bhRvFKqv
	4eHB4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405j3sr1ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 01:56:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4641ulH2005280;
	Thu, 4 Jul 2024 01:56:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 405j3sr1er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 01:56:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 463N0RUD009121;
	Thu, 4 Jul 2024 01:56:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00wvkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 01:56:46 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4641uhcY20513306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jul 2024 01:56:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87ACE58054;
	Thu,  4 Jul 2024 01:56:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1594F58064;
	Thu,  4 Jul 2024 01:56:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jul 2024 01:56:38 +0000 (GMT)
Message-ID: <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>
Date: Wed, 3 Jul 2024 21:56:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-4-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240703182453.1580888-4-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KsI29KRKQKOHTrltRfKLug15hglzPOmr
X-Proofpoint-ORIG-GUID: sgSqyabQnkAj5IxzK3XTaytM4qWE9xgi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040014



On 7/3/24 14:24, Jarkko Sakkinen wrote:
> Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can

Doesn't tpm_chip_register() need to be called by all drivers? This 
function then calls tpm_chip_bootstrap().

> cause a null derefence in tpm_buf_hmac_session*().  Thus, address
> !chip->auth in tpm_buf_hmac_session*() and remove the fallback
> implementation for !TCG_TPM2_HMAC.
> 
> Cc: stable@vger.kernel.org # v6.9+
> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
> Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I applied this series now but it doesn't solve the reported problem. The 
error message is gone but the feature can still be enabled 
(CONFIG_TCG_TPM2_HMAC=y) but is unlikely actually doing what it is 
promising to do with this config option. So you either still have to 
apply my patch, James's patch, or your intended "depends on 
!TCG_IBMVTPM" patch.

[    1.449673] tpm_ibmvtpm 5000: CRQ initialized
[    1.449726] tpm_ibmvtpm 5000: CRQ initialization completed
[    2.483218] tpm tpm0: auth session is not active


    Stefan
> ---
> v2:
> - Use auth in place of chip->auth.
> ---
>   drivers/char/tpm/tpm2-sessions.c | 181 ++++++++++++++++++-------------
>   include/linux/tpm.h              |  67 ++++--------
>   2 files changed, 124 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 06d0f10a2301..304247090b56 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -268,6 +268,105 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append_name);
>   
> +/**
> + * tpm_buf_append_hmac_session() - Append a TPM session element
> + * @chip: the TPM chip structure
> + * @buf: The buffer to be appended
> + * @attributes: The session attributes
> + * @passphrase: The session authority (NULL if none)
> + * @passphrase_len: The length of the session authority (0 if none)
> + *
> + * This fills in a session structure in the TPM command buffer, except
> + * for the HMAC which cannot be computed until the command buffer is
> + * complete.  The type of session is controlled by the @attributes,
> + * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
> + * session won't terminate after tpm_buf_check_hmac_response(),
> + * TPM2_SA_DECRYPT which means this buffers first parameter should be
> + * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
> + * response buffer's first parameter needs to be decrypted (confusing,
> + * but the defines are written from the point of view of the TPM).
> + *
> + * Any session appended by this command must be finalized by calling
> + * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
> + * and the TPM will reject the command.
> + *
> + * As with most tpm_buf operations, success is assumed because failure
> + * will be caused by an incorrect programming model and indicated by a
> + * kernel message.
> + */
> +void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> +				 u8 attributes, u8 *passphrase,
> +				 int passphrase_len)
> +{
> +	struct tpm2_auth *auth = chip->auth;
> +	u8 nonce[SHA256_DIGEST_SIZE];
> +	u32 len;
> +
> +	if (!auth) {
> +		/* offset tells us where the sessions area begins */
> +		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> +		u32 len = 9 + passphrase_len;
> +
> +		if (tpm_buf_length(buf) != offset) {
> +			/* not the first session so update the existing length */
> +			len += get_unaligned_be32(&buf->data[offset]);
> +			put_unaligned_be32(len, &buf->data[offset]);
> +		} else {
> +			tpm_buf_append_u32(buf, len);
> +		}
> +		/* auth handle */
> +		tpm_buf_append_u32(buf, TPM2_RS_PW);
> +		/* nonce */
> +		tpm_buf_append_u16(buf, 0);
> +		/* attributes */
> +		tpm_buf_append_u8(buf, 0);
> +		/* passphrase */
> +		tpm_buf_append_u16(buf, passphrase_len);
> +		tpm_buf_append(buf, passphrase, passphrase_len);
> +		return;
> +	}
> +
> +	/*
> +	 * The Architecture Guide requires us to strip trailing zeros
> +	 * before computing the HMAC
> +	 */
> +	while (passphrase && passphrase_len > 0 && passphrase[passphrase_len - 1] == '\0')
> +		passphrase_len--;
> +
> +	auth->attrs = attributes;
> +	auth->passphrase_len = passphrase_len;
> +	if (passphrase_len)
> +		memcpy(auth->passphrase, passphrase, passphrase_len);
> +
> +	if (auth->session != tpm_buf_length(buf)) {
> +		/* we're not the first session */
> +		len = get_unaligned_be32(&buf->data[auth->session]);
> +		if (4 + len + auth->session != tpm_buf_length(buf)) {
> +			WARN(1, "session length mismatch, cannot append");
> +			return;
> +		}
> +
> +		/* add our new session */
> +		len += 9 + 2 * SHA256_DIGEST_SIZE;
> +		put_unaligned_be32(len, &buf->data[auth->session]);
> +	} else {
> +		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
> +	}
> +
> +	/* random number for our nonce */
> +	get_random_bytes(nonce, sizeof(nonce));
> +	memcpy(auth->our_nonce, nonce, sizeof(nonce));
> +	tpm_buf_append_u32(buf, auth->handle);
> +	/* our new nonce */
> +	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
> +	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
> +	tpm_buf_append_u8(buf, auth->attrs);
> +	/* and put a placeholder for the hmac */
> +	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
> +	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_hmac_session);
> +
>   #ifdef CONFIG_TCG_TPM2_HMAC
>   /*
>    * It turns out the crypto hmac(sha256) is hard for us to consume
> @@ -449,82 +548,6 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
>   	crypto_free_kpp(kpp);
>   }
>   
> -/**
> - * tpm_buf_append_hmac_session() - Append a TPM session element
> - * @chip: the TPM chip structure
> - * @buf: The buffer to be appended
> - * @attributes: The session attributes
> - * @passphrase: The session authority (NULL if none)
> - * @passphrase_len: The length of the session authority (0 if none)
> - *
> - * This fills in a session structure in the TPM command buffer, except
> - * for the HMAC which cannot be computed until the command buffer is
> - * complete.  The type of session is controlled by the @attributes,
> - * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
> - * session won't terminate after tpm_buf_check_hmac_response(),
> - * TPM2_SA_DECRYPT which means this buffers first parameter should be
> - * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
> - * response buffer's first parameter needs to be decrypted (confusing,
> - * but the defines are written from the point of view of the TPM).
> - *
> - * Any session appended by this command must be finalized by calling
> - * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
> - * and the TPM will reject the command.
> - *
> - * As with most tpm_buf operations, success is assumed because failure
> - * will be caused by an incorrect programming model and indicated by a
> - * kernel message.
> - */
> -void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> -				 u8 attributes, u8 *passphrase,
> -				 int passphrase_len)
> -{
> -	u8 nonce[SHA256_DIGEST_SIZE];
> -	u32 len;
> -	struct tpm2_auth *auth = chip->auth;
> -
> -	/*
> -	 * The Architecture Guide requires us to strip trailing zeros
> -	 * before computing the HMAC
> -	 */
> -	while (passphrase && passphrase_len > 0
> -	       && passphrase[passphrase_len - 1] == '\0')
> -		passphrase_len--;
> -
> -	auth->attrs = attributes;
> -	auth->passphrase_len = passphrase_len;
> -	if (passphrase_len)
> -		memcpy(auth->passphrase, passphrase, passphrase_len);
> -
> -	if (auth->session != tpm_buf_length(buf)) {
> -		/* we're not the first session */
> -		len = get_unaligned_be32(&buf->data[auth->session]);
> -		if (4 + len + auth->session != tpm_buf_length(buf)) {
> -			WARN(1, "session length mismatch, cannot append");
> -			return;
> -		}
> -
> -		/* add our new session */
> -		len += 9 + 2 * SHA256_DIGEST_SIZE;
> -		put_unaligned_be32(len, &buf->data[auth->session]);
> -	} else {
> -		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
> -	}
> -
> -	/* random number for our nonce */
> -	get_random_bytes(nonce, sizeof(nonce));
> -	memcpy(auth->our_nonce, nonce, sizeof(nonce));
> -	tpm_buf_append_u32(buf, auth->handle);
> -	/* our new nonce */
> -	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
> -	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
> -	tpm_buf_append_u8(buf, auth->attrs);
> -	/* and put a placeholder for the hmac */
> -	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
> -	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
> -}
> -EXPORT_SYMBOL(tpm_buf_append_hmac_session);
> -
>   /**
>    * tpm_buf_fill_hmac_session() - finalize the session HMAC
>    * @chip: the TPM chip structure
> @@ -555,6 +578,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>   	u8 cphash[SHA256_DIGEST_SIZE];
>   	struct sha256_state sctx;
>   
> +	if (!auth)
> +		return;
> +
>   	/* save the command code in BE format */
>   	auth->ordinal = head->ordinal;
>   
> @@ -713,6 +739,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>   	u32 cc = be32_to_cpu(auth->ordinal);
>   	int parm_len, len, i, handles;
>   
> +	if (!auth)
> +		return rc;
> +
>   	if (auth->session >= TPM_HEADER_SIZE) {
>   		WARN(1, "tpm session not filled correctly\n");
>   		goto out;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 2844fea4a12a..912fd0d2646d 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -493,22 +493,35 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
>   
>   void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>   			 u32 handle, u8 *name);
> -
> -#ifdef CONFIG_TCG_TPM2_HMAC
> -
> -int tpm2_start_auth_session(struct tpm_chip *chip);
>   void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>   				 u8 attributes, u8 *passphrase,
>   				 int passphraselen);
> +
>   static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
>   						   struct tpm_buf *buf,
>   						   u8 attributes,
>   						   u8 *passphrase,
>   						   int passphraselen)
>   {
> -	tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
> -				    passphraselen);
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> +
> +	if (chip->auth) {
> +		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
> +					    passphraselen);
> +	} else  {
> +		/*
> +		 * If the only sessions are optional, the command tag must change to
> +		 * TPM2_ST_NO_SESSIONS.
> +		 */
> +		if (tpm_buf_length(buf) == offset)
> +			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +	}
>   }
> +
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +
> +int tpm2_start_auth_session(struct tpm_chip *chip);
>   void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
>   int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>   				int rc);
> @@ -523,48 +536,6 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
>   static inline void tpm2_end_auth_session(struct tpm_chip *chip)
>   {
>   }
> -static inline void tpm_buf_append_hmac_session(struct tpm_chip *chip,
> -					       struct tpm_buf *buf,
> -					       u8 attributes, u8 *passphrase,
> -					       int passphraselen)
> -{
> -	/* offset tells us where the sessions area begins */
> -	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> -	u32 len = 9 + passphraselen;
> -
> -	if (tpm_buf_length(buf) != offset) {
> -		/* not the first session so update the existing length */
> -		len += get_unaligned_be32(&buf->data[offset]);
> -		put_unaligned_be32(len, &buf->data[offset]);
> -	} else {
> -		tpm_buf_append_u32(buf, len);
> -	}
> -	/* auth handle */
> -	tpm_buf_append_u32(buf, TPM2_RS_PW);
> -	/* nonce */
> -	tpm_buf_append_u16(buf, 0);
> -	/* attributes */
> -	tpm_buf_append_u8(buf, 0);
> -	/* passphrase */
> -	tpm_buf_append_u16(buf, passphraselen);
> -	tpm_buf_append(buf, passphrase, passphraselen);
> -}
> -static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
> -						   struct tpm_buf *buf,
> -						   u8 attributes,
> -						   u8 *passphrase,
> -						   int passphraselen)
> -{
> -	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> -	struct tpm_header *head = (struct tpm_header *) buf->data;
> -
> -	/*
> -	 * if the only sessions are optional, the command tag
> -	 * must change to TPM2_ST_NO_SESSIONS
> -	 */
> -	if (tpm_buf_length(buf) == offset)
> -		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> -}
>   static inline void tpm_buf_fill_hmac_session(struct tpm_chip *chip,
>   					     struct tpm_buf *buf)
>   {

