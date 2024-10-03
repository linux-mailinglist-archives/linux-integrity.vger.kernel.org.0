Return-Path: <linux-integrity+bounces-3733-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0D98F284
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A75B20B18
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA11A2557;
	Thu,  3 Oct 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QM8mfQ9R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81885DDA8;
	Thu,  3 Oct 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969265; cv=none; b=a1px9HXl5B/d60yT/hcoMo13rNzUOrE1QFH3pUqfvKuX8jsRqx60WPb0C3/uWqRGCQbH+PpXgLGf0GKizxnMSiHsePZxTEQsqzvDGFBf2FAH07pkGbACKju5thE12MRJKxiLWJPwzGH3FyDC6VTkd7BKxhWiorF8agAKTNyWbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969265; c=relaxed/simple;
	bh=ljRzg7BA3WIQXXWJ7SLsJGKyKBaz/hMwnHxwcHl9MRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZDlmD632aVxIL3s0Xr8qASFoc+7adpWv4Wp3asiuhdGV5Pi8YdHbQFwTYWoZHbTLhp8Utaqut5MkjHFeJscyaA/uWXwrUE9IXqEtaQ8wVcLkqXQlolPRES6bwS1AH4ZPp2oH/8kYieloIC3B/v7y0lTUucPROsLlsnx6uW6ULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QM8mfQ9R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493FOYpw004237;
	Thu, 3 Oct 2024 15:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=2
	ELewwyxSoWoMQHTTzZy+MuRuf83ZiTTwrHrMIVW0WE=; b=QM8mfQ9RJ5Nc8qgt0
	BJw3b6eNOSPEDOCgty+nBEQW4RxVK6HJv/TgGfmfyW3pmC2g0hOQpS2X5yjyhBu1
	KFtoTW37rJ4SBp8+BSSPBjDOL8q0yUitLDZvTv4lsQbPPxEZ0d6TY3O5fs8GQsAs
	0Y+I8kRScgKGqPKiSc4rgLG64Rs3wZAYzzBLzmsacUvsfUNkg0UyonyPq+CsxH//
	cZZvLKMpo1/sUpDhkp0GkGJBA+62ia9j1ISEC1CfRRQ4tBC10NiWmV4wE2Rqf2HH
	akXGyVG/THlWgW9tIWHYavnwtz0KaFv2yRxhfBQDf/vJbZ9S4SukLBNh26NygDU2
	mZQZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421wvsr0fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 15:27:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493FOqpf004690;
	Thu, 3 Oct 2024 15:27:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421wvsr0fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 15:27:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493DBxAF014609;
	Thu, 3 Oct 2024 15:27:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmkgba1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 15:27:27 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493FRRpU27525726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 15:27:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12D4B58051;
	Thu,  3 Oct 2024 15:27:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FC5958062;
	Thu,  3 Oct 2024 15:27:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 15:27:26 +0000 (GMT)
Message-ID: <def4ec2d-584b-405f-9d5e-99267013c3c0@linux.ibm.com>
Date: Thu, 3 Oct 2024 11:27:25 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] tpm: Implement tpm2_load_null() rollback
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com,
        mapengyu@gmail.com, stable@vger.kernel.org,
        Mimi Zohar
 <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-3-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240921120811.1264985-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DnUEf0_E9NVqc2ko0jHXh3i7J1oP_COR
X-Proofpoint-ORIG-GUID: eAjAmEvf55TLBkcgn_569FOvdxxojJ-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030110



On 9/21/24 8:08 AM, Jarkko Sakkinen wrote:
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
> ---
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
> index 0f09ac33ae99..a856adef18d3 100644
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
> -	 * userspace programmes can't be compromised by it. > -	 */
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

s/failedh/failed

> +	tpm2_flush_context(chip, tmp_null_key);
>   	chip->flags |= TPM_CHIP_FLAG_DISABLE;
>   
> -	return rc;
> +err:
> +	return rc ? -ENODEV : rc;

return rc ? -ENODEV : 0;

>   }
>   
>   /**

