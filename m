Return-Path: <linux-integrity+bounces-3926-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E89B3137
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 14:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EBE2822A7
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155DF1D8E12;
	Mon, 28 Oct 2024 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZ425BEn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07A1E519;
	Mon, 28 Oct 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120463; cv=none; b=lknVHaQ/lNZE/6Mi3GXMLJs2lHMdyARNrOgZVYzNbgJFUlSfqgmjgGpcamxvbht3F3nd5+Mpnp5l3+2ap8b8iOV3pmoxWv4CJLcGcD7H/ON+iRkxuEok8rvn2kAYswqDizIXsPfmllJUG6W8ZPIy+e2VY3Q8cQlxWLlrpO4IAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120463; c=relaxed/simple;
	bh=l9v3vKArLjj24VREBGBj/ErZeIFdYN2suaGECGgbByE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hNVNif3L2Hnr5by+cowOkEMj4lX3mVED0HNB+kosExwzduyz3AiqeEYNGlkaRS2KFHMF8fqKq1bpbPM3x+06b+GJGUHb8r3+ZewZEulDmoQ/UWMqEd5nxL0d5KcW2HlNEOMWFmD5X0aSjRkQYWY6xgiRrq8p7SSanjP8GglXzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZ425BEn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCarnq024817;
	Mon, 28 Oct 2024 13:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oBmDpw
	YNe84I09VKwn/ofeAOrg0jpJFVYeqd3MTN4WE=; b=gZ425BEn4oql0Xzz69kBF7
	PUoWGFRa/UHLGEVtqVgwAU17d3cZL6k5raOKCaBNzOo5yKE3MkY1o8tuM7zX6Szh
	95NEAQXER8NheVVsIOeuJP3sE6gVhJbG00Ju53/bT3gt3P0qKLjW4GZ6lfN8erDu
	PEnYn+Voir4cArTtNaUO5lirZT7RmjwjDxpPu4DnGu+r6inlqGaxBfPqNB835feY
	IyvcWN7OgJ+dbw356aw7ieRjAohB9b3VeD8LfyRvOoibrw9b+Cno4EUspm+SrwN4
	FluZzF3yOcodcNY36V2yWrLLa4kq9zWv1D1gn3PN7bMKL3XpiHuCwtcCgEyuQnLw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43fthqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 13:00:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49SCrYOA005507;
	Mon, 28 Oct 2024 13:00:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43fthq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 13:00:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCZSZu018383;
	Mon, 28 Oct 2024 13:00:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8jx648-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 13:00:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49SD0VSQ30343528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 13:00:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2B1058056;
	Mon, 28 Oct 2024 13:00:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE60C58063;
	Mon, 28 Oct 2024 13:00:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Oct 2024 13:00:30 +0000 (GMT)
Message-ID: <04887ab4-3e30-467a-973c-4c004283476e@linux.ibm.com>
Date: Mon, 28 Oct 2024 09:00:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] tpm: Return tpm2_sessions_init() when null key
 creation fails
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        stable@vger.kernel.org
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-2-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241028055007.1708971-2-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wrV6d_5Hf2d-impEjk1QDiYe4EVOmJqo
X-Proofpoint-ORIG-GUID: QVsqHa21LWF-oSSjeQDdvmmUq_PCechQ
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280103



On 10/28/24 1:49 AM, Jarkko Sakkinen wrote:
> Do not continue tpm2_sessions_init() further if the null key pair creation
> fails.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
> v8:
> - Refine commit message.
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
> index d3521aadd43e..a0306126e86c 100644
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
> +		dev_err(&chip->dev, "null key creation failed with %d\n", rc);
> +		return rc;
> +	}
>   
>   	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
>   	if (!chip->auth)


