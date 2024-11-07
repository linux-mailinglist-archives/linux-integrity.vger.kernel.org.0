Return-Path: <linux-integrity+bounces-4059-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748249C07DF
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E311F2253B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CDC210188;
	Thu,  7 Nov 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ODdCOgzP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18A20B1E2;
	Thu,  7 Nov 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987091; cv=none; b=NtUTOT+gtfXVYjM4JP3gkiMaTimr/9LcyS9UZvtvR4uS53O5AFqidrJpchagOCN02oI13qOVEoCwT0M5JrFXP13vRy427N8mpnP91PzpRvdLEK7mxqdYMGBAswwoJ3v6m0rPCAjiLJRryt0fEbcFpMszzF2viBOSV+wnVlvnTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987091; c=relaxed/simple;
	bh=uLkLtRCV5c29uevsVuMBynD0TYcsr2hGxuZC9NOU0oU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvVE6W8x7JVAgk0HDdmLDXAnnPxUEwzs0YvwShT9AFU9dSJYDeucly8+j/iTtAhNENdTiUGDZNF1IFidJvmn8764SyXV9w1F8yK1XtkMPkQzm/StmKoNMZeYCd1wrDpAbziyQfYTGHvXxw77/JqVp4aeP+v3cuVEAI5MVGbHIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ODdCOgzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Cefdj018118;
	Thu, 7 Nov 2024 13:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LCtgK+
	BEQtuucrLZPW6Rn1D6ZQwcBVbseGx+J9rEPxg=; b=ODdCOgzPEsedi3HAS/cY1L
	mvPZGTS9Tk80FajPbvuIprYyIrjDHOflYa3D/uJOhB7jlxed2N1ijMyQAHVpGCa5
	zXtuPgRbEH2AlUpDKVLRigKh2UXDqGQx19rQx/BptAzBXdRIke+sxy0/6AyAWO8O
	WUbYGRBXRHjEGFqlTjqosqUTHCCZa9MAMI4gZdD5D2WRLJPzfLpIraRE7YcrDR/Y
	uHQADOj8emav+GRirx1kbZ+Vb+9yHMeeL0Z/PNuOMX+njniEe+XyB/CwJlQekmYA
	pY6uP5KBiK5QOiHLjFf9HbuYT7qwgCG2luXPxtBqaPc76IUr0SUFxfzYEoiK2VHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rwrk88wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 13:44:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7DiXfX004442;
	Thu, 7 Nov 2024 13:44:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rwrk88wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 13:44:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7C2YTA024230;
	Thu, 7 Nov 2024 13:44:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds8b25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 13:44:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7DiWc253608866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 13:44:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC355805A;
	Thu,  7 Nov 2024 13:44:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B3C05805F;
	Thu,  7 Nov 2024 13:44:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.241])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 13:44:31 +0000 (GMT)
Message-ID: <e015a939893d35efe75e598152725adcc2befdd8.camel@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason
 Gunthorpe <jgg@ziepe.ca>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 08:44:31 -0500
In-Reply-To: <20241107095138.78209-1-jarkko@kernel.org>
References: <20241107095138.78209-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6X0q05HhCvSq2LDT7t_GA02--cIbwB2A
X-Proofpoint-GUID: j3_S6X9udwxRaKerGOJX5u1X2VYCVGS2
Content-Transfer-Encoding: quoted-printable
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
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070106

On Thu, 2024-11-07 at 11:51 +0200, Jarkko Sakkinen wrote:
> The initial HMAC session feature added TPM bus encryption and/or integrity
> protection to various in-kernel TPM operations. This can cause performance
> bottlenecks with IMA, as it heavily utilizes PCR extend operations.
>=20
> In order to mitigate this performance issue, introduce a kernel
> command-line parameter to the TPM driver for disabling the integrity
> protection for PCR extension.
>=20
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Link: https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zoha=
r@linux.ibm.com/
> Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Move tpm_buf_append_handle() to the correct file, remove spurious
>   parameter (name), include error on TPM2B and add documentation.
>   Keep the declaration in linux/tpm.h despite not exported as it
>   is easiest to maintain tpm_buf_* in a single header.
> - Rename kernel command-line option as "disable_pcr_integrity_protection",
>   as Mimi pointed out it does not carry SA_ENCRYPT flag.
> v1:
> - Derived from the earlier RFC patch with a different parameter scope,
>   cleaner commit message and some other tweaks. I decided to create
>   something because I did not noticed any progress. Note only compile
>   tested as I wanted to get something quickly out.
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  drivers/char/tpm/tpm-buf.c                    | 20 ++++++++
>  drivers/char/tpm/tpm2-cmd.c                   | 30 ++++++++---
>  drivers/char/tpm/tpm2-sessions.c              | 51 ++++++++++---------
>  include/linux/tpm.h                           |  3 ++
>  5 files changed, 83 insertions(+), 31 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1518343bbe22..9fc406b20a74 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6727,6 +6727,16 @@
>  	torture.verbose_sleep_duration=3D [KNL]
>  			Duration of each verbose-printk() sleep in jiffies.
> =20
> +	tpm.disable_pcr_integrity_protection=3D [HW,TPM]
> +			Do not protect PCR registers from unintended physical
> +			access, or interposers in the bus by the means of
> +			having an encrypted and integrity protected session

"encrypted" isn't needed here.

> +			wrapped around TPM2_PCR_Extend command. Consider this
> +			in a situation where TPM is heavily utilized by
> +			IMA, thus protection causing a major performance hit,
> +			and the space where machines are deployed is by other
> +			means guarded.
> +
>  	tpm_suspend_pcr=3D[HW,TPM]
>  			Format: integer pcr id
>  			Specify that at suspend time, the tpm driver
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index cad0048bcc3c..e49a19fea3bd 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -146,6 +146,26 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u=
32 value)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> =20
> +/**
> + * tpm_buf_append_handle() - Add a handle
> + * @chip:	&tpm_chip instance
> + * @buf:	&tpm_buf instance
> + * @handle:	a TPM object handle
> + *
> + * Add a handle to the buffer, and increase the count tracking the numbe=
r of
> + * handles in the command buffer. Works only for command buffers.
> + */
> +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u=
32 handle)
> +{
> +	if (buf->flags & TPM_BUF_TPM2B) {
> +		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
> +		return;
> +	}
> +
> +	tpm_buf_append_u32(buf, handle);
> +	buf->handles++;
> +}
> +
>  /**
>   * tpm_buf_read() - Read from a TPM buffer
>   * @buf:	&tpm_buf instance
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 1e856259219e..cc443bcf15e8 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -14,6 +14,10 @@
>  #include "tpm.h"
>  #include <crypto/hash_info.h>
> =20
> +static bool disable_pcr_integrity_protection;
> +module_param(disable_pcr_integrity_protection, bool, 0444);
> +MODULE_PARM_DESC(disable_pcr_integrity_protection, "Disable TPM2_PCR_Ext=
end encryption");

I like the name 'disable_pcr_integrity_protection.  However, the name and
description doesn't match.  Replace 'encryption' with 'integrity protection=
'.

> +
>  static struct tpm2_hash tpm2_hash_map[] =3D {
>  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>  	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> @@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_=
idx,
>  	int rc;
>  	int i;
> =20
> -	rc =3D tpm2_start_auth_session(chip);
> -	if (rc)
> -		return rc;
> +	if (!disable_pcr_integrity_protection) {
> +		rc =3D tpm2_start_auth_session(chip);
> +		if (rc)
> +			return rc;
> +	}
> =20
>  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
>  	if (rc) {
> -		tpm2_end_auth_session(chip);
> +		if (!disable_pcr_integrity_protection)
> +			tpm2_end_auth_session(chip);
>  		return rc;
>  	}
> =20
> -	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> -	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> +	if (!disable_pcr_integrity_protection) {
> +		tpm_buf_append_name(chip, &buf, pcr_idx);

tpm_buf_append_name() parameters didn't change.  Don't remove the 'name' fi=
eld
here.


> +		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> +	} else {
> +		tpm_buf_append_handle(chip, &buf, pcr_idx);

Or here.

> +		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> +	}
> =20
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> =20
>=20

Mimi

