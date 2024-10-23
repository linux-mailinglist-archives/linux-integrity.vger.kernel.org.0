Return-Path: <linux-integrity+bounces-3899-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6B9AD333
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23AF28589B
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28A1BD038;
	Wed, 23 Oct 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AmLqDPxn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5001C9B71;
	Wed, 23 Oct 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705644; cv=none; b=D2DfQv7Z4Ozxxh1dcnpcN5Gx3yhqAVr98Gx2hRbnyQdPl2iqBVwmBcAkFgg6CW2eYOHyywKzKV3j97lja9brwQehyMwkEuXAyFKb2xbTMulEXwYgD+Oywzw034tqUqIW66d7H/4krhwUf/h66oO+opKr8/IuehTJJlB/43Pmugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705644; c=relaxed/simple;
	bh=JkMWtsKPkcn8Q35r4l5vu4otD8v5lGv3wYkbXuVyuWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L38GT/8iCCqebrPpd1R3j4w8VKx0PwvyFUIjw7Jqi8Kc8RtcDGLddh8rAJR08oLBv17tvtAPrahfJT9xo1/SShit6XScfunRxZGe+TA713wWvNqVCc2deN8FN32C8dnBoQU0SrZxM1Aq+TWZvPRJQug27cSmcdrejocTuGr51r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AmLqDPxn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEB1q4016813;
	Wed, 23 Oct 2024 17:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EYlc2a
	DxOMg0VYQXj2PjiZwwPje/lDWe3EoigoX8qwU=; b=AmLqDPxnfJOrmPKd0OKzNn
	GSZQXXxZEjOOuiSdoQHMPXytw122fg8NiuNkRLFgp71goVeYqv78wz+d9ezQvk4Y
	GSZ1P7fMsOrqPKCVNMoM86HPdvVT3Pa0gusvkV/wnCHH3MP8I0GsT/ykmFoGdPNA
	nNAHe+1t9gRcll4bHU/Y2OrZzKrayl2tYc5+ekE+Fzw6mRF56pil32H1AwjpTTZG
	tRNy7MpvvuBzTx4o/WHnokRty9cu+i9FI+Iy7/WbXj+7lwwfuUa0GFTfnWBHMxxC
	6ghoOHzpuCElE9eh2rUVnaF3E+7l1jfUnqWWG/TjVE5NpB7SuJWq8JWP3wt+kYFQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajma41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:46:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NHk2CU012757;
	Wed, 23 Oct 2024 17:46:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajma3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:46:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFToNE014161;
	Wed, 23 Oct 2024 17:46:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfm35d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:46:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NHk1JK50921964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:46:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C20C58057;
	Wed, 23 Oct 2024 17:46:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8888B58058;
	Wed, 23 Oct 2024 17:46:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 17:46:00 +0000 (GMT)
Message-ID: <bb9ef4af-4a35-40e2-85cc-bcacae4f2dbc@linux.ibm.com>
Date: Wed, 23 Oct 2024 13:46:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] tpm: Return on tpm2_create_null_primary() failure
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-2-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241021053921.33274-2-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dimnzvkszrk6ZI83KPGYV1srgGaWkGEm
X-Proofpoint-GUID: eREedX-1O8ob-9sc9PSF9jgTQ1jaCYry
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230111



On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> tpm2_sessions_init() does not ignore the result of
> tpm2_create_null_primary(). Address this by returning -ENODEV to the
> caller. Given that upper layers cannot help healing the situation

It looks like returning -ENODEV applied to a previous version of the patch.

> further, deal with the TPM error here by

This sounds like an incomplete sentence...

> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v7:
> - Add the error message back but fix it up a bit:
>    1. Remove 'TPM:' given dev_err().
>    2. s/NULL/null/ as this has nothing to do with the macro in libc.
>    3. Fix the reasoning: null key creation failed
> v6:
> - Address:
>    https://lore.kernel.org/linux-integrity/69c893e7-6b87-4daa-80db-44d1120e80fe@linux.ibm.com/
>    as TPM RC is taken care of at the call site. Add also the missing
>    documentation for the return values.
> v5:
> - Do not print klog messages on error, as tpm2_save_context() already
>    takes care of this.
> v4:
> - Fixed up stable version.
> v3:
> - Handle TPM and POSIX error separately and return -ENODEV always back
>    to the caller.
> v2:
> - Refined the commit message.
> ---
>   drivers/char/tpm/tpm2-sessions.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index d3521aadd43e..1e12e0b2492e 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1347,14 +1347,21 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
>    *
>    * Derive and context save the null primary and allocate memory in the
>    * struct tpm_chip for the authorizations.
> + *
> + * Return:
> + * * 0		- OK
> + * * -errno	- A system error
> + * * TPM_RC	- A TPM error
>    */
>   int tpm2_sessions_init(struct tpm_chip *chip)
>   {
>   	int rc;
>   
>   	rc = tpm2_create_null_primary(chip);
> -	if (rc)
> -		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
> +	if (rc) {
> +		dev_err(&chip->dev, "null primary key creation failed with %d\n", rc);
> +		return rc;
> +	}
>   
>   	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
>   	if (!chip->auth)

