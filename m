Return-Path: <linux-integrity+bounces-4048-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926229BFCBD
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 03:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EFC2833C2
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD8BA2D;
	Thu,  7 Nov 2024 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XGFxYET0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675642A97;
	Thu,  7 Nov 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947750; cv=none; b=swAMv0r/t43GHnD53js0TCwxU7VkmTwa9z6ZR/6SZFjWQlNpkVHI6YEaqSOCG9GYEbgXSt0lOESVwcgm17ZD8KevOyHF3oFOf4kOycuHhdntNAVUSEjPSugtlrGSwZ9ijjKRRt/LvNedPIHbN/RHDmTYcmnN3JtIOnPKAC5u/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947750; c=relaxed/simple;
	bh=sbwl0lLtcSccEPzBBpKMcwnEZXTc8jkuwNu3FI/w9QI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=q9qR7nt1VRzd0hx9wojKPjEKzS1SoXc+yPDbgltxFvZVgkAKo4zGsXJRU2ZeH8UKv24SM0CabEq2LkE+NjhwYR2fJC1eAnd7SI7sHw9YL58qdR+iOHlY3ZmB00FRH2OtknniDUPgqONaPzawh2tHPBN4xJNV8U+DnVi3aX6Liek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XGFxYET0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A72ds7W007619;
	Thu, 7 Nov 2024 02:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2FH6G1
	ysYhQjSlm4AIrapWmx3F5oUGsz2vLZKFcRMrU=; b=XGFxYET0ekoJls5fqR1paD
	d52GT81nUAaBgSqLVwvNVtSAOeEe4P8lq72IOc/Ve/O8kVcFF1HAEzCW8ibX9yT6
	1AMqn9F0TZiMB32sr0WVV+Rt0w3Y3ck80/OcN0qx1TA0bK2Y8bYyOFE0Qp7Ft2i1
	BYsrSR3IO6FrhsKHWxKgkkTeGZ9YR2fIYAFV0ISUxXszQDnUyFvdiJ8VeLxy/jcJ
	qHnYmgkg9mourKD690+k0Tp8/GwNLh8LFRKwHV2XOBNWR3n18dvA95dhnF/Le//9
	e3mNlxs8gVOfgBboTtA845uwlA7Ov86dwgV+BD/02z5c94WyOnikfCSpT5WPiFHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rmyag15u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 02:48:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A72msMT025969;
	Thu, 7 Nov 2024 02:48:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rmyag15r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 02:48:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A70d55T031474;
	Thu, 7 Nov 2024 02:48:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmqdvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 02:48:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A72mqqq28443222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 02:48:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B17A158043;
	Thu,  7 Nov 2024 02:48:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2800F5805D;
	Thu,  7 Nov 2024 02:48:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.85.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 02:48:52 +0000 (GMT)
Message-ID: <b510e556621e3826dd6df043fde817192b9f12ea.camel@linux.ibm.com>
Subject: Re: [PATCH] tpm: Opt-in in disable PCR encryption on TPM2 chips
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason
 Gunthorpe <jgg@ziepe.ca>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>
References: <20241107004708.108667-1-jarkko@kernel.org>
	 <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Nov 2024 21:48:16 -0500
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aKauM6ys6MFqsdtxdEYKT_0yTua11nDk
X-Proofpoint-GUID: 6xCTqTk_mXznWa_nYYm6VF769KPYH6GU
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070018

On Thu, 2024-11-07 at 02:51 +0200, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 2:47 AM EET, Jarkko Sakkinen wrote:
> > From: Mimi Zohar <zohar@linux.ibm.com>
> >=20
> > The initial encrypted HMAC session feature added TPM bus encryption to
> > various in-kernel TPM operations. This can cause performance bottlenecks
> > with IMA, as it heavily utilizes PCR extend operations.

The patch Subject line and problem description aren't quite right.  In the =
case
of TPM pcr_extend, the session isn't being encrypted, only HMAC'ed.  Accord=
ing
to James, it's the HMAC itself that is causing the performance degradation.=
 I
would remove the word "encrypted" throughout.

> >=20
> > In order to address this performance issue, introduce disable_encrypt_p=
crs
> > kernel command-line parameter to the TPM driver.
> >=20
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Link: https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zo=
har@linux.ibm.com/
> > Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> > Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v1:
> > - Derived from the earlier RFC patch with a different parameter scope,
> >   cleaner commit message and some other tweaks. I decided to create
> >   something because I did not noticed any progress. Note only compile
> >   tested as I wanted to get something quickly out.

Thanks, Jarkko.  Does "parameter scope" refer to using module_param instead=
 of
__setup?

> > ---
>=20
> Noticed a couple of things I missed after sending this (see below).
>=20
> >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> >  drivers/char/tpm/tpm2-cmd.c                   | 33 ++++++++---
> >  drivers/char/tpm/tpm2-sessions.c              | 59 +++++++++++--------
> >  include/linux/tpm.h                           |  4 ++
> >  4 files changed, 74 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 1518343bbe22..e27517e1a26f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6727,6 +6727,16 @@
> >  	torture.verbose_sleep_duration=3D [KNL]
> >  			Duration of each verbose-printk() sleep in jiffies.
> > =20
> > +	tpm.disable_encrypt_pcrs=3D [HW,TPM]
> > +			Do not protect PCR registers from unintended physical
> > +			access, or interposers in the bus by the means of
> > +			having an encrypted and integrity protected session
> > +			wrapped around TPM2_PCR_Extend command. Consider this
> > +			in a situation where TPM is heavily utilized by
> > +			IMA, thus protection causing a major performance hit,
> > +			and the space where machines are deployed is by other
> > +			means guarded.

Remove the word "encrypted".

> > +
> >  	tpm_suspend_pcr=3D[HW,TPM]
> >  			Format: integer pcr id
> >  			Specify that at suspend time, the tpm driver
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 1e856259219e..6ec307b1cb99 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -14,6 +14,10 @@
> >  #include "tpm.h"
> >  #include <crypto/hash_info.h>
> > =20
> > +static bool disable_encrypt_pcrs;
> > +module_param(disable_encrypt_pcrs, bool, 0444);

The variable should probably be named something like disable_pcr_hmac_sessi=
on.

> > +MODULE_PARM_DESC(disable_encrypt_pcrs, "Disable TPM2_PCR_Extend encryp=
tion");
> > +
> >  static struct tpm2_hash tpm2_hash_map[] =3D {
> >  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> >  	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> > @@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pc=
r_idx,
> >  	int rc;
> >  	int i;
> > =20
> > -	rc =3D tpm2_start_auth_session(chip);
> > -	if (rc)
> > -		return rc;
> > +	if (!disable_encrypt_pcrs) {
> > +		rc =3D tpm2_start_auth_session(chip);
> > +		if (rc)
> > +			return rc;
> > +	}
> > =20
> >  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> >  	if (rc) {
> > -		tpm2_end_auth_session(chip);
> > +		if (!disable_encrypt_pcrs)
> > +			tpm2_end_auth_session(chip);
> >  		return rc;
> >  	}
> > =20
> > -	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> > -	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > +	if (!disable_encrypt_pcrs) {
> > +		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> > +		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > +	} else {
> > +		tpm_buf_append_handle(chip, &buf, pcr_idx, NULL);
> > +		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> > +	}
> > =20
> >  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> > =20
> > @@ -253,9 +265,12 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr=
_idx,
> >  			       chip->allocated_banks[i].digest_size);
> >  	}
> > =20
> > -	tpm_buf_fill_hmac_session(chip, &buf);
> > -	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value=
");
> > -	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> > +	if (!disable_encrypt_pcrs)
> > +		tpm_buf_fill_hmac_session(chip, &buf);
> > +	rc =3D tpm_transmit_cmd(chip, &buf, 0,
> > +			      "attempting extend a PCR value");
>=20
> Should be in a single line in order to minimize the diff.
>=20
> > +	if (!disable_encrypt_pcrs)
> > +		rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> > =20
> >  	tpm_buf_destroy(&buf);
> > =20
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-s=
essions.c
> > index 42df980168b6..02897debc3fa 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -205,6 +205,14 @@ static int tpm2_read_public(struct tpm_chip *chip,=
 u32 handle, char *name)
> >  }
> >  #endif /* CONFIG_TCG_TPM2_HMAC */
> > =20
> > +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
> > +			   u32 handle, u8 *name)
> > +{
> > +	tpm_buf_append_u32(buf, handle);
> > +	/* count the number of handles in the upper bits of flags */
> > +	buf->handles++;
> > +}
> > +
> >  /**
> >   * tpm_buf_append_name() - add a handle area to the buffer
> >   * @chip: the TPM chip structure
> > @@ -237,9 +245,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, str=
uct tpm_buf *buf,
> >  #endif
> > =20
> >  	if (!tpm2_chip_auth(chip)) {
> > -		tpm_buf_append_u32(buf, handle);
> > -		/* count the number of handles in the upper bits of flags */
> > -		buf->handles++;
> > +		tpm_buf_append_handle(chip, buf, handle, name);
> >  		return;
> >  	}
> > =20
> > @@ -272,6 +278,31 @@ void tpm_buf_append_name(struct tpm_chip *chip, st=
ruct tpm_buf *buf,
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_buf_append_name);
> > =20
> > +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > +			 u8 attributes, u8 *passphrase, int passphrase_len)
> > +{
> > +	/* offset tells us where the sessions area begins */
> > +	int offset =3D buf->handles * 4 + TPM_HEADER_SIZE;
> > +	u32 len =3D 9 + passphrase_len;
> > +
> > +	if (tpm_buf_length(buf) !=3D offset) {
> > +		/* not the first session so update the existing length */
> > +		len +=3D get_unaligned_be32(&buf->data[offset]);
> > +		put_unaligned_be32(len, &buf->data[offset]);
> > +	} else {
> > +		tpm_buf_append_u32(buf, len);
> > +	}
> > +	/* auth handle */
> > +	tpm_buf_append_u32(buf, TPM2_RS_PW);
> > +	/* nonce */
> > +	tpm_buf_append_u16(buf, 0);
> > +	/* attributes */
> > +	tpm_buf_append_u8(buf, 0);
> > +	/* passphrase */
> > +	tpm_buf_append_u16(buf, passphrase_len);
> > +	tpm_buf_append(buf, passphrase, passphrase_len);
> > +}
> > +
> >  /**
> >   * tpm_buf_append_hmac_session() - Append a TPM session element
> >   * @chip: the TPM chip structure
> > @@ -309,26 +340,8 @@ void tpm_buf_append_hmac_session(struct tpm_chip *=
chip, struct tpm_buf *buf,
> >  #endif
> > =20
> >  	if (!tpm2_chip_auth(chip)) {
> > -		/* offset tells us where the sessions area begins */
> > -		int offset =3D buf->handles * 4 + TPM_HEADER_SIZE;
> > -		u32 len =3D 9 + passphrase_len;
> > -
> > -		if (tpm_buf_length(buf) !=3D offset) {
> > -			/* not the first session so update the existing length */
> > -			len +=3D get_unaligned_be32(&buf->data[offset]);
> > -			put_unaligned_be32(len, &buf->data[offset]);
> > -		} else {
> > -			tpm_buf_append_u32(buf, len);
> > -		}
> > -		/* auth handle */
> > -		tpm_buf_append_u32(buf, TPM2_RS_PW);
> > -		/* nonce */
> > -		tpm_buf_append_u16(buf, 0);
> > -		/* attributes */
> > -		tpm_buf_append_u8(buf, 0);
> > -		/* passphrase */
> > -		tpm_buf_append_u16(buf, passphrase_len);
> > -		tpm_buf_append(buf, passphrase, passphrase_len);
> > +		tpm_buf_append_auth(chip, buf, attributes, passphrase,
> > +				    passphrase_len);
> >  		return;
> >  	}
> > =20
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 587b96b4418e..4892cd004530 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -502,9 +502,13 @@ static inline struct tpm2_auth *tpm2_chip_auth(str=
uct tpm_chip *chip)
> > =20
> >  void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> >  			 u32 handle, u8 *name);
> > +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,
> > +			   u32 handle, u8 *name);
> >  void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf=
 *buf,
> >  				 u8 attributes, u8 *passphrase,
> >  				 int passphraselen);
> > +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > +			 u8 attributes, u8 *passphrase, int passphraselen);
>=20
> This is declared in wrong place as it has no outside callers. So I will
> move it to drivers/char/tpm/tpm.h instead. Please correct if I'm
> overlooking something.

Sure
>=20
> >  static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *ch=
ip,
> >  						   struct tpm_buf *buf,
> >  						   u8 attributes,
>=20
>=20
> BR, Jarkko
>=20


