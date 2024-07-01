Return-Path: <linux-integrity+bounces-2962-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9BB91E87C
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0751A1C21BE7
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153416F824;
	Mon,  1 Jul 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UqjDwCGD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028715F3E0;
	Mon,  1 Jul 2024 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861692; cv=none; b=q7K3KUYjhYQu6V47HKzJ2tvEUhtRbh+F2H+D/wL5zVRlynNc8KyVhJn+0sNDi1QfImXKTeLJ/8rPqtyMSTBEtVejGJV0ZgSB/PlGLnUHjLH6namXs8PwNRd+WddcIiSBiGeELb4kwZzzXSiSavU7mZLHg+GTX4FEScyjcGG5t1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861692; c=relaxed/simple;
	bh=xA4gT5jgdk/OTxA5+HmO+icyiiNsnLJsHJKqiT48Ou0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HD2Qa2DZGkBWOyjlqj7h07VGjHDLX8lR1+jHBbYfjGGnpumy6QywWJ5zvyJTOHzQuJ4FUgARLOZzRSirEYr/uyrk1wWHizUeHwn/nrKJY0ncrS9zFVfXiN5eEoJokOxOinXqhitxBlxTv3EE+YncfvaobS4Hux+IQ5/pvZDQIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UqjDwCGD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461Iv0HE013388;
	Mon, 1 Jul 2024 19:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	vwPSGgNyfB7PV/gU5mKuyglcYgFurNIMZQ4OJRpNuIs=; b=UqjDwCGD7ZPhhPfJ
	2T6PY4BrgQHagrXZIf+zZGGzZGUfoAAodzuyCsNY0bxSrOZToKePlOHrxjrIz/Uc
	pF54TtoFwemRyaydw+3mzwZchISj0Xq60tA8dwJY9Z8wSSaPLiodu8NrjWB/FAmk
	nA17VDTWM4JdDXqrH+hsEENndoD/bIza/7p70dmsTF5ZdfXcYzeSMIFBtFkQmVu7
	YxTRGSTwhtAZsXOVnUe4Ujt+iA1eQ8hnWzMN4N829hYvBXaorK5VZMYC7gmQA5jA
	9qZOM7J2vaJGjmPzzZrvPEgOd6TvEY0Mi31+kExoiKKVK2USaLTDGULpdsEVr7nS
	mZ3nEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4041rw03s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 19:21:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 461JLFUw025280;
	Mon, 1 Jul 2024 19:21:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4041rw03s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 19:21:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461I0B4R009561;
	Mon, 1 Jul 2024 19:21:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00h39e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 19:21:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461JLBA256230172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 19:21:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DFFC58055;
	Mon,  1 Jul 2024 19:21:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D36B58060;
	Mon,  1 Jul 2024 19:21:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 19:21:07 +0000 (GMT)
Message-ID: <596c3997-6a9d-4ac4-895f-512058a2648c@linux.ibm.com>
Date: Mon, 1 Jul 2024 15:21:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Check non-nullity of chip->auth
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20240701170735.109583-1-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240701170735.109583-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZiMnc2k-AjdCMwIntE57sE603DRvScCp
X-Proofpoint-ORIG-GUID: 1rPc_D_JYeAanSUH0ce6VrL5Yf1X5woA
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
 definitions=2024-07-01_19,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010141



On 7/1/24 13:07, Jarkko Sakkinen wrote:
> All exported functions lack the check for non-nullity of chip->auth. Add
> the guard for each.
> 
> Link: https://lore.kernel.org/linux-integrity/9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org/
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   drivers/char/tpm/tpm2-sessions.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 907ac9956a78..d833db20531a 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -377,6 +377,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>   	u32 len;
>   	struct tpm2_auth *auth = chip->auth;
>   
> +	if (!auth)
> +		return;
> +
>   	/*
>   	 * The Architecture Guide requires us to strip trailing zeros
>   	 * before computing the HMAC
> @@ -449,6 +452,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>   	u8 cphash[SHA256_DIGEST_SIZE];
>   	struct sha256_state sctx;
>   
> +	if (!auth)
> +		return;
> +
>   	/* save the command code in BE format */
>   	auth->ordinal = head->ordinal;
>   
> @@ -639,6 +645,9 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>   	struct tpm2_auth *auth = chip->auth;
>   	int slot;
>   
> +	if (!auth)
> +		return;
> +
>   	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
>   	if (slot >= AUTH_MAX_NAMES) {
>   		dev_err(&chip->dev, "TPM: too many handles\n");
> @@ -705,6 +714,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>   	u32 cc = be32_to_cpu(auth->ordinal);
>   	int parm_len, len, i, handles;
>   
> +	if (!auth)
> +		return rc;
> +
>   	if (auth->session >= TPM_HEADER_SIZE) {
>   		WARN(1, "tpm session not filled correctly\n");
>   		goto out;
> @@ -824,8 +836,13 @@ EXPORT_SYMBOL(tpm_buf_check_hmac_response);
>    */
>   void tpm2_end_auth_session(struct tpm_chip *chip)
>   {
> -	tpm2_flush_context(chip, chip->auth->handle);
> -	memzero_explicit(chip->auth, sizeof(*chip->auth));
> +	struct tpm2_auth *auth = chip->auth;
> +
> +	if (!auth)
> +		return;
> +
> +	tpm2_flush_context(chip, auth->handle);
> +	memzero_explicit(auth, sizeof(*auth));
>   }
>   EXPORT_SYMBOL(tpm2_end_auth_session);
>   
> @@ -907,6 +924,11 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>   	int rc;
>   	u32 null_key;
>   
> +	if (!auth) {
> +		pr_warn_once("%s: encryption is not active\n", __func__);
> +		return 0;
> +	}
> +
>   	rc = tpm2_load_null(chip, &null_key);
>   	if (rc)
>   		goto out;
It looks like you got all of the chip->auth tested:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

As I mentioned in the other email (1), it does not solve the problem on 
ppc64.

1: 
https://lore.kernel.org/linux-integrity/656b319fc58683e399323b880722434467cf20f2.camel@kernel.org/T/#m88892cb6f9cf8fdef875dcdd0ed3eccac1d28190

