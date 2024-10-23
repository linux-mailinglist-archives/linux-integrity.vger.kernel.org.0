Return-Path: <linux-integrity+bounces-3903-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE999AD4DB
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBF61C225A3
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2024 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4551D90AE;
	Wed, 23 Oct 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jA1SmLyw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271E1AD3F6;
	Wed, 23 Oct 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711765; cv=none; b=UeStjJdejJ9IiHeIMAP1CqONasdP47d/y5R3ovEfw8ShO/qDWI3/poPbyz4Mc8iq5RRy0ISwTTRd2Zc8gd2NKy0CJpCJc6wd5xxjh+eXwDVvX9fmnF/IRFBvFpWOeiDew3onMuxcvDtfti03/QUvm78Z9Tq7//dQdCtQSvuu+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711765; c=relaxed/simple;
	bh=JnEleY8aUcPFS8jN2amW51RwXJJVy5/sSIaxuFZH5gk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paQDQg5mw/OHzLkY59NaGOzJbJMeUUlhUu7XxXykYf98EOaYesQcho9y5sOJvfsp29pOdrxMLaLFG1vdK9H7WuC4KYoPK/gsEA6Ll1xhbzUsXytHtdiNFLl5SVPiC2aIDEnf3cACThhHdjQtlO6Og182lZBV7gBdp4MM/n3Jsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jA1SmLyw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDocPa016825;
	Wed, 23 Oct 2024 19:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lds2M+
	mJIjlHarm0ivfUHy+Yj/BtnlunMn4LC0b2Luk=; b=jA1SmLywIsj3vjvgeBn9W3
	Ksz7Zq8bP4gvReXrSYF+pEy15Fe8M449bvwKST/1gDUmY9EfmbMcEx4Tr8pTmNpo
	pdKLd0uCJ5TOmH6N2ToGqt5vOrKLe7AFwdkgOL89cB2+7ZQqwJ8PmSH90bBV38iI
	h31lNLroOo8ujYKpvAsbWvLFrHI8BeYyOGpQmtNA6s5K/qxEquXQNwx54QYn+v7D
	HPlmC95vbShBQKaF1R9qVkhkHZkfxPB3WLTF4eDu7y2+rQv9p2LsV0i4E86EWU6W
	WxzcYw+EhEvRB2FoYWGF2Bg83foFDin+VmxO2m3sQ9KBITBVlny3X5ixV1OGhJ5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajmr36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 19:28:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NJS886001342;
	Wed, 23 Oct 2024 19:28:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajmr35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 19:28:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJ2OVo006835;
	Wed, 23 Oct 2024 19:28:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emjcvh6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 19:28:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NJS7XP4719268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 19:28:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D5958059;
	Wed, 23 Oct 2024 19:28:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED87A58057;
	Wed, 23 Oct 2024 19:28:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 19:28:06 +0000 (GMT)
Message-ID: <c0e0d549-a41f-4803-b4c2-b31ed877f4cf@linux.ibm.com>
Date: Wed, 23 Oct 2024 15:28:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] tpm: flush the auth session only when /dev/tpm0 is
 open
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org,
        Pengyu Ma <mapengyu@gmail.com>, stable@vger.kernel.org
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-6-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241021053921.33274-6-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p4xhQSzUhTz1yQY_q0z7p-zgm6nt-NcO
X-Proofpoint-GUID: k6tj_LZ2lLNYyy0E_xzxdhY5uxIyDIuc
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
 lowpriorityscore=0 spamscore=0 mlxlogscore=582 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230124



On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> Instead of flushing and reloading the auth session for every single
> transaction, keep the session open unless /dev/tpm0 is used. In practice
> this means applying TPM2_SA_CONTINUE_SESSION to the session attributes.
> Flush the session always when /dev/tpm0 is written.
> 
> Reported-by: Pengyu Ma <mapengyu@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - No changes.
> v4:
> - Changed as bug.
> v3:
> - Refined the commit message.
> - Removed the conditional for applying TPM2_SA_CONTINUE_SESSION only when
>    /dev/tpm0 is open. It is not required as the auth session is flushed,
>    not saved.
> v2:
> - A new patch.
> ---
>   drivers/char/tpm/tpm-chip.c       | 1 +
>   drivers/char/tpm/tpm-dev-common.c | 1 +
>   drivers/char/tpm/tpm-interface.c  | 1 +
>   drivers/char/tpm/tpm2-sessions.c  | 3 +++
>   4 files changed, 6 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0ea00e32f575..7a6bb30d1f32 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -680,6 +680,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>   	rc = tpm_try_get_ops(chip);
>   	if (!rc) {
>   		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +			tpm2_end_auth_session(chip);

That could also go into the inline. Looks good otherwise.

>   			tpm2_flush_context(chip, chip->null_key);
>   			chip->null_key = 0;
>   		}
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 4eaa8e05c291..a3ed7a99a394 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -29,6 +29,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   
>   #ifdef CONFIG_TCG_TPM2_HMAC
>   	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		tpm2_end_auth_session(chip);
>   		tpm2_flush_context(chip, chip->null_key);
>   		chip->null_key = 0;
>   	}
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index bfa47d48b0f2..2363018fa8fb 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -381,6 +381,7 @@ int tpm_pm_suspend(struct device *dev)
>   	if (!rc) {
>   		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>   #ifdef CONFIG_TCG_TPM2_HMAC
> +			tpm2_end_auth_session(chip);
>   			tpm2_flush_context(chip, chip->null_key);
>   			chip->null_key = 0;
>   #endif
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 6e52785de9fd..a7079c7ec6d1 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -333,6 +333,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>   	}
>   
>   #ifdef CONFIG_TCG_TPM2_HMAC
> +	/* The first write to /dev/tpm{rm0} will flush the session. */
> +	attributes |= TPM2_SA_CONTINUE_SESSION;
> +
>   	/*
>   	 * The Architecture Guide requires us to strip trailing zeros
>   	 * before computing the HMAC


