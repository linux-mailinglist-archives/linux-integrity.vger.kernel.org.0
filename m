Return-Path: <linux-integrity+bounces-3900-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B749AD3CF
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC24EB22226
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C761D0946;
	Wed, 23 Oct 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="djQWiULy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044B1E51D;
	Wed, 23 Oct 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707500; cv=none; b=kQb9QLoLb/HZqSHNSYaU0hNaxexK6Uzbb6oZI9es5tPyDzo6awxaGH9BzJxrcAtR2kEAyyAwToMwYV9T/rgp1tSN6ldMYwTm+F0014OIYu6XluZAh5GTDYGlYIYgHRGiVy4EiHKbsfBvgEZRSXAsIjhuKWZbff9mRqO3v5eBL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707500; c=relaxed/simple;
	bh=CJ9igV9HeKi0G/vhHlaOqk/2mCaX5i6wXr2PY1A+qes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOXpF53lnMpn3OuCDSgC6ZVEunInFaIQpzJP1xW5D7oIWelfIKnt2hSVYuNGu44JKFfE3vPAaYl1EoWmmgxy5lHeSGqTIlIOnpk4rRlITqdizMyJocscUqftMUxu8E51XxprfF9gLH8SuacYTtj15/2gTHhiEre546sJ8OkPmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=djQWiULy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NE4icD005256;
	Wed, 23 Oct 2024 18:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JN1aTz
	PY4D4raHVgPji5ji0ri6xTI9xEUitqcMHidDE=; b=djQWiULy6ApX/L5/tMG9wD
	g/nCqJEZk1//dtHBhrDq2ZJdyIJ9pWysncSxynfcuY6A4baAFnx7RjxwuJ1anITF
	rmj33SrK12uPpJLpCiLypXVqtLQEequDVaMKu6z55WeODCfBxcLPIfO6e4rUEfJl
	JBzfuwRmmTPxiSamTFt3qqrKdA4bLZ3YSG+bxYszqHAipBFoozdqhskd3DNeNJze
	zyoEcnF27sPg3WdWCK3p6PVaxfvKAI/Woncql8h7RzwLD5P20GA0YXyNhYmx4DBQ
	HxT5puHbcb344xLMbmZqH2jVC8yOK/ntPCJKOimkjHHJNpsT/B1eaM7y5ZYO9BYA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafve72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:18:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NII5gR020074;
	Wed, 23 Oct 2024 18:18:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafve6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:18:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFZcOl014576;
	Wed, 23 Oct 2024 18:18:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7v7hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:18:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NII3AY52363546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 18:18:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D20658058;
	Wed, 23 Oct 2024 18:18:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04CD058057;
	Wed, 23 Oct 2024 18:18:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 18:18:02 +0000 (GMT)
Message-ID: <531b27a8-6e99-40ca-9d74-f94a3b8c638e@linux.ibm.com>
Date: Wed, 23 Oct 2024 14:18:02 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] tpm: flush the null key only when /dev/tpm0 is
 accessed
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Pengyu Ma <mapengyu@gmail.com>
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-4-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241021053921.33274-4-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _yTRr741vRDyWnp3WduWIuY7GkwqEU5j
X-Proofpoint-ORIG-GUID: nZ3vuV3DjywzZ0j_vFVLD6HSBPlccQ57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230114



On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> Instead of flushing and reloading the null key for every single auth
> session, flush it only when:
> 
> 1. User space needs to access /dev/tpm{rm}0.
> 2. When going to sleep.
> 3. When unregistering the chip.
> 
> This removes the need to load and swap the null key between TPM and
> regular memory per transaction, when the user space is not using the
> chip.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - No changes.
> v4:
> - Changed to bug fix as not having the patch there is a major hit
>    to bootup times.
> v3:
> - Unchanged.
> v2:
> - Refined the commit message.
> - Added tested-by from Pengyu Ma <mapengyu@gmail.com>.
> - Removed spurious pr_info() statement.
> ---
>   drivers/char/tpm/tpm-chip.c       | 13 +++++++++++++
>   drivers/char/tpm/tpm-dev-common.c |  7 +++++++
>   drivers/char/tpm/tpm-interface.c  |  9 +++++++--
>   drivers/char/tpm/tpm2-cmd.c       |  3 +++
>   drivers/char/tpm/tpm2-sessions.c  | 17 ++++++++++++++---
>   include/linux/tpm.h               |  2 ++
>   6 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 854546000c92..0ea00e32f575 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -674,6 +674,19 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>    */
>   void tpm_chip_unregister(struct tpm_chip *chip)
>   {
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	int rc;
> +
> +	rc = tpm_try_get_ops(chip);
> +	if (!rc) {
> +		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +			tpm2_flush_context(chip, chip->null_key);

If chip->null_key is already 0, the above function will not do anything 
good, but you could avoid this whole block then by checking for 0 before 
tpm_try_get_ops().

> +			chip->null_key = 0;
> +		}
> +		tpm_put_ops(chip);
> +	}
> +#endif
> +
>   	tpm_del_legacy_sysfs(chip);
>   	if (tpm_is_hwrng_enabled(chip))
>   		hwrng_unregister(&chip->hwrng);
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 30b4c288c1bb..4eaa8e05c291 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -27,6 +27,13 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   	struct tpm_header *header = (void *)buf;
>   	ssize_t ret, len;
>   
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		tpm2_flush_context(chip, chip->null_key);
> +		chip->null_key = 0;
> +	}
> +#endif
> +
>   	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
>   	/* If the command is not implemented by the TPM, synthesize a
>   	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 5da134f12c9a..bfa47d48b0f2 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -379,10 +379,15 @@ int tpm_pm_suspend(struct device *dev)
>   
>   	rc = tpm_try_get_ops(chip);
>   	if (!rc) {
> -		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +			tpm2_flush_context(chip, chip->null_key);
> +			chip->null_key = 0;
> +#endif

Worth using an inline on this repeating pattern? Up to you.

static inline void tpm2_flush_null_key(struct tpm_chip *chip)
{
#ifdef CONFIG_TCG_TPM2_HMAC
     if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->null_key) {
         tpm2_flush_context(chip, chip->null_key);
         chip->null_key = 0;
     }
#endif
}

>   			tpm2_shutdown(chip, TPM2_SU_STATE);
> -		else
> +		} else {
>   			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> +		}
>   
>   		tpm_put_ops(chip);
>   	}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 1e856259219e..aba024cbe7c5 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -364,6 +364,9 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
>   	struct tpm_buf buf;
>   	int rc;
>   
> +	if (!handle)
> +		return;
> +

wouldn't be necessary with inline.

>   	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
>   	if (rc) {
>   		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index bdac11964b55..78c650ce4c9f 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -920,11 +920,19 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>   	u32 tmp_null_key;
>   	int rc;
>   
> +	/* fast path */
> +	if (chip->null_key) {
> +		*null_key = chip->null_key;
> +		return 0;
> +	}
> +
>   	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
>   			       &tmp_null_key);
>   	if (rc != -EINVAL) {
> -		if (!rc)
> +		if (!rc) {
> +			chip->null_key = tmp_null_key;
>   			*null_key = tmp_null_key;
> +		}
>   		goto err;
>   	}
>   
> @@ -934,6 +942,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>   
>   	/* Return the null key if the name has not been changed: */
>   	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
> +		chip->null_key = tmp_null_key;
>   		*null_key = tmp_null_key;
>   		return 0;
>   	}
> @@ -1006,7 +1015,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>   	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
>   
>   	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> -	tpm2_flush_context(chip, null_key);
>   
>   	if (rc == TPM2_RC_SUCCESS)
>   		rc = tpm2_parse_start_auth_session(auth, &buf);
> @@ -1338,7 +1346,10 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
>   
>   		rc = tpm2_save_context(chip, null_key, chip->null_key_context,
>   				       sizeof(chip->null_key_context), &offset);
> -		tpm2_flush_context(chip, null_key);
> +		if (rc)
> +			tpm2_flush_context(chip, null_key);
> +		else
> +			chip->null_key = null_key;
>   	}
>   
>   	return rc;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e93ee8d936a9..4eb39db80e05 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -205,6 +205,8 @@ struct tpm_chip {
>   #ifdef CONFIG_TCG_TPM2_HMAC
>   	/* details for communication security via sessions */
>   
> +	/* loaded null key */

nit: handle of loaded null key

> +	u32 null_key;
>   	/* saved context for NULL seed */
>   	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
>   	 /* name of NULL seed */

