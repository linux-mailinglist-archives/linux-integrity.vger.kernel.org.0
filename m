Return-Path: <linux-integrity+bounces-3941-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB339B70BD
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 00:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0911F21A2B
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6E21501F;
	Wed, 30 Oct 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODBeBf6V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881822144D3;
	Wed, 30 Oct 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730332262; cv=none; b=Nnj/50/bbBwwpTYLn3sVmfd+YwK1fr58RyuC9NL6MresA2rBCLopy+6Gd8eP0u08INDuFznj74Ca9asNJ5+uwXfZzN5mGAY3i8m70DsOU0yHAdCT+ntuxOZUtI3w3Bi9Q7Fqc13RvFC5WAjTrruOut2mm5D+89KuS83zVGA+ebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730332262; c=relaxed/simple;
	bh=MOLCf3aBNQw/Ib0eAl9t92b97pZC42tHEgHRlmV73Xw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M8sBYhgxwHGXMJkxtQ9zdqepEy1+3YGuDmIz59+zGht48BTDg7V04K/MEsg7GDo0PzkHhgRkVgXyMCDc7uMQstJTB4ly2FMCwLZBiHFZHmqyD3XsJ8JUCtinStLSqYRn1CtUMp8OvRX6XsvX/CSl43reOpCy2xT3Rlv6YQkjoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODBeBf6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75675C4E698;
	Wed, 30 Oct 2024 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730332262;
	bh=MOLCf3aBNQw/Ib0eAl9t92b97pZC42tHEgHRlmV73Xw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ODBeBf6VZ/lOw7HcjB5DZwd9N8g/KAgcREpXPmZA/spBI52kMhu0ovLns+TDuH/OJ
	 WHS0zwNQdBPrrlH+qiLReX+DxzBOublsSYNTu7Nq1QEZQAc471tSpvjC6JWrzCTSyq
	 XDFT2A2i6DRxTToDIAfeAxyJrJAFxxPsCSaboJ6SHNHK1h704TIL0y2muersOVATOG
	 o12KbaUN2FGI6a+UIzPti1UF1a3JGY3k/zJG3L70tQmAcFhZrtz+ZVRMxBc6mZlbHa
	 rmowNRA3iEPgxj1GKGMYr067inhCldZERlX8gs9PmDVTyJgvFYRTzI9jIq4fp45EAB
	 +zrUUyLJP4nhg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 01:50:57 +0200
Message-Id: <D59JLDCHCZPD.3CA4121HVVJXL@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "David Howells" <dhowells@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Stefan Berger" <stefanb@linux.ibm.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "open list:KEYS-TRUSTED"
 <keyrings@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v8 2/3] tpm: Rollback tpm2_load_null()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-3-jarkko@kernel.org>
 <27e3ac1678bde5e107691e12c09fa470ab47a5b2.camel@HansenPartnership.com>
 <D59JG45GJC5V.1HT5KJQ0K4CKI@kernel.org>
In-Reply-To: <D59JG45GJC5V.1HT5KJQ0K4CKI@kernel.org>

On Thu Oct 31, 2024 at 1:44 AM EET, Jarkko Sakkinen wrote:
> On Wed Oct 30, 2024 at 5:47 PM EET, James Bottomley wrote:
> > On Mon, 2024-10-28 at 07:50 +0200, Jarkko Sakkinen wrote:
> > [...]
> > > --- a/drivers/char/tpm/tpm2-sessions.c
> > > +++ b/drivers/char/tpm/tpm2-sessions.c
> > > @@ -915,33 +915,37 @@ static int tpm2_parse_start_auth_session(struct
> > > tpm2_auth *auth,
> > > =C2=A0
> > > =C2=A0static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int offset =
=3D 0; /* dummy offset for null seed
> > > context */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name[SHA256_DIGEST=
_SIZE + 2];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 tmp_null_key;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_load_cont=
ext(chip, chip->null_key_context, &offset,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 null_key);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc !=3D -EINVAL)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &tmp_null_key);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc !=3D -EINVAL) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (!rc)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*nu=
ll_key =3D tmp_null_key;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* an integrity failure ma=
y mean the TPM has been reset */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&chip->dev, "NULL =
key integrity failure!\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* check the null name aga=
inst what we know */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_create_primary(chip, =
TPM2_RH_NULL, NULL, name);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (memcmp(name, chip->nul=
l_key_name, sizeof(name)) =3D=3D 0)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* name unchanged, assume transient integrity failu=
re
> > > */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Fatal TPM failure: the =
NULL seed has actually changed, so
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the TPM must have been =
illegally reset.=C2=A0 All in-kernel TPM
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * operations will fail be=
cause the NULL primary can't be
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * loaded to salt the sess=
ions, but disable the TPM anyway so
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * userspace programmes ca=
n't be compromised by it.
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&chip->dev, "NULL =
name has changed, disabling TPM due
> > > to interference\n");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Try to re-create null k=
ey, given the integrity failure: */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_create_primary=
(chip, TPM2_RH_NULL, &tmp_null_key,
> > > name);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err;
> >
> > From a security point of view, this probably isn't such a good idea:
> > the reason the context load failed above is likely the security
> > condition we're checking for: the null seed changed because an
> > interposer did a reset.  That means that if the interposer knows about
> > this error leg, it would simply error out the create primary here and
> > the TPM wouldn't be disabled.
>
> If you think there is something that should be still addressed, or there
> is overlooked issue please do send a patch, and we will review that.
> There's been plenty of time to comment on patches.
>
> Neither in previous TPM_CHIP_FLAG_DISABLED was set tpm2_load_context()
> failed. It went like this:
>
> 	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> 			       null_key);
> 	if (rc !=3D -EINVAL)
> 		return rc;
>
> If you think that this should be addressed, do send a patch but point
> out the fixes-tag to your original patch then.

Also want to denotat that I specifically did not set flag because I
thought you had good reasons not to disable TPM. So it was left like
that knowingly, definitely not by ignorance. Good that it became now
apparent and I'm happy to take a fix in (with correct fixes tag).

BR, Jarkko

