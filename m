Return-Path: <linux-integrity+bounces-3898-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B689AD301
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1531F2248D
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 17:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6F1CEEA2;
	Wed, 23 Oct 2024 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FSo8kxU+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2921B652C;
	Wed, 23 Oct 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705126; cv=none; b=VEIIxty4tJnnR7TGg9BiEGysRTkwQ3TtvUilEcvOLI3Jeb4A+8wl7k344CEwJYsQLorE7GZWP5LwxQGfbmTxtGGNocvEMoAyeeCi+YREOD48xoJQEdlBgKAStvD3fkVgkK51LpkbIRj1msCeWgSsxj2oN4zaA4XRRZp+pHJDVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705126; c=relaxed/simple;
	bh=C46wo35IQBpuAuDNlOO+oOD+w3+fAYim9ZZPCw+UG4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=knMbTaFOiFlqZtHKBrXXCG2FKYeoowOJlxBgwwiQpJ6yfxDXHUYv+Pf2l5Vju8VNawGB4vVRj3j/pPSMBLiRDHw+Cc8O/I4qwPrueJPu+o76e+n64BkpifFF4ZS4FusQolmItdyrbC6aySYwbekui4RgH7vvoEcAvOxbIFVl5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FSo8kxU+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDsjMu014739;
	Wed, 23 Oct 2024 17:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Aa+YyA
	v7FaQTJVTzQP9ljneyqJ7JE3h+NBtCTTvLhDo=; b=FSo8kxU+WR+STvixkkOI3c
	iREKSw84Eryb5ZCY5Iuh1YHC8qCWpR60OfHqSr9XXX2cMTYkOEkM1haBs+DpEWOS
	XX5RqH1a8qedg1s7faVX++kut+R721kREkrtWRUiRa6WSS9RnpFucyjtF3nCPXnY
	E95jTesuejxFp0ag9UAUAQzYCgRgUw7oBC9vVrRjlP8uXLlt6CDFO2ZLt1kO9D60
	yP84Y8AtMNWyBdN0aRbSoBcP1Mwi0W5CFI03BbkvaJq7kdWyHpZJLUMuLC9b82dm
	ecxhlax4+N5HZ6gGkQ5cXKAU1+o+GGk30q3vae1S1DygUfOMqfy/nro6qqKvU4KA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadvbdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:38:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NHcVMg002373;
	Wed, 23 Oct 2024 17:38:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadvbdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:38:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFWZrb006862;
	Wed, 23 Oct 2024 17:38:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjcv1sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:38:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NHcTdm23003732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:38:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ECBA5805D;
	Wed, 23 Oct 2024 17:38:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B76158057;
	Wed, 23 Oct 2024 17:38:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 17:38:28 +0000 (GMT)
Message-ID: <5ba23b66-d5e7-49f4-a0ba-705b52184f96@linux.ibm.com>
Date: Wed, 23 Oct 2024 13:38:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] tpm: Implement tpm2_load_null() rollback
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-3-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241021053921.33274-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ieOeGiglLsYRpaQgOXo4ZXtXmBuLOg8E
X-Proofpoint-GUID: 4d34dB0iMEKO8NPEy9TOa_mqMMDUte8i
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230111



On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> tpm2_load_null() has weak and broken error handling:
> 
> - The return value of tpm2_create_primary() is ignored.
> - Leaks TPM return codes from tpm2_load_context() to the caller.
> - If the key name comparison succeeds returns previous error
>    instead of zero to the caller.
> 
> Implement a proper error rollback.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> --
> v6:
> - Address Stefan's remark:
>    https://lore.kernel.org/linux-integrity/def4ec2d-584b-405f-9d5e-99267013c3c0@linux.ibm.com/
> v5:
> - Fix the TPM error code leak from tpm2_load_context().
> v4:
> - No changes.
> v3:
> - Update log messages. Previously the log message incorrectly stated
>    on load failure that integrity check had been failed, even tho the
>    check is done *after* the load operation.
> v2:
> - Refined the commit message.
> - Reverted tpm2_create_primary() changes. They are not required if
>    tmp_null_key is used as the parameter.
> ---
>   drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 1e12e0b2492e..bdac11964b55 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -915,33 +915,36 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
>   
>   static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>   {
> -	int rc;
>   	unsigned int offset = 0; /* dummy offset for null seed context */
>   	u8 name[SHA256_DIGEST_SIZE + 2];
> +	u32 tmp_null_key;
> +	int rc;
>   
>   	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
> -			       null_key);
> -	if (rc != -EINVAL)
> -		return rc;
> +			       &tmp_null_key);
> +	if (rc != -EINVAL) {
> +		if (!rc)
> +			*null_key = tmp_null_key;
> +		goto err;
> +	}
>   
> -	/* an integrity failure may mean the TPM has been reset */
> -	dev_err(&chip->dev, "NULL key integrity failure!\n");
> -	/* check the null name against what we know */
> -	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
> -	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
> -		/* name unchanged, assume transient integrity failure */
> -		return rc;
> -	/*
> -	 * Fatal TPM failure: the NULL seed has actually changed, so
> -	 * the TPM must have been illegally reset.  All in-kernel TPM
> -	 * operations will fail because the NULL primary can't be
> -	 * loaded to salt the sessions, but disable the TPM anyway so
> -	 * userspace programmes can't be compromised by it.
> -	 */
> -	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
> +	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
> +	if (rc)
> +		goto err;
> +
> +	/* Return the null key if the name has not been changed: */
> +	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
> +		*null_key = tmp_null_key;
> +		return 0;
> +	}
> +
> +	/* Deduce from the name change TPM interference: */
> +	dev_err(&chip->dev, "the null key integrity check failedh\n");

stray 'h': s/failedh/failed

> +	tpm2_flush_context(chip, tmp_null_key);
>   	chip->flags |= TPM_CHIP_FLAG_DISABLE;
>   
> -	return rc;
> +err:
> +	return rc ? -ENODEV : 0;
>   }
>   
>   /**

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

