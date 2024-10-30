Return-Path: <linux-integrity+bounces-3939-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E49B70A4
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 00:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44561C20A96
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDC2141CA;
	Wed, 30 Oct 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdYTq8yF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5C1C4612;
	Wed, 30 Oct 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331850; cv=none; b=JuZNbv76loHoO4TepiQ+e2b8nUmmuoNXYUP7zIOONCoVPHKK+r1+CwBy/br85fklOdioW5cPNZb3pVNbPYTIDvadhK7nWspJ2X61p25bEdNjeE5dSUUtTrxkXCeG6Q5CNRXl1BVKk9HypSOklSeP5yoME6Q47XGejw/7b27eAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331850; c=relaxed/simple;
	bh=GVsIwO4FcNuJYtDU9JsLinVVsbRz+7+H7RJ1eishf7c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rv0wo5UEHkI4Pw4ay6D09F8OHjxrkYnSRNvSKnVadHSO7ofD5Msbng8FAXVmFuK5n9+gZSnG9nMWHyHFqYZgaSvx4RYS3vDACENzvToyRwNnp4JHwFlrbAD6j8p/5TBGrUfWVTBspcOydqXzVmXg1b1oj3X7ClRBKIzvWahvMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdYTq8yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D0EC4CEEB;
	Wed, 30 Oct 2024 23:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730331850;
	bh=GVsIwO4FcNuJYtDU9JsLinVVsbRz+7+H7RJ1eishf7c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NdYTq8yFFS+niTI/Ztrg9qLd6vLogYBaYo2WIJcidbIOFsfXxo1x66zP1SZ975Av/
	 veyvACW1mU8o99WiB6FADplUmplA4DvdBy3Vyd+GiyeoH7DtXz60mgJnnZqFpXtNT6
	 uZ4aTBA08aaitH/K6MAH7UOsruQs6zQuhQe95cI8thGVH90Zq2+MHQ2wUc8ubnrw3i
	 TJ166JeugxubkeBfSNMbTxXB7vGjYjZNLgcMFbIaoFoK+3OAOvGh7cC/mSG0hiP6Ri
	 VyhQnRZagz3wLxUfUsUGG6HyaVHyQabSwh7nRC7SfWHveONDtpYdI7vLQEvE4ZiKwj
	 elT9Hy4M8lJUw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 01:44:05 +0200
Message-Id: <D59JG45GJC5V.1HT5KJQ0K4CKI@kernel.org>
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
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20241028055007.1708971-1-jarkko@kernel.org>
 <20241028055007.1708971-3-jarkko@kernel.org>
 <27e3ac1678bde5e107691e12c09fa470ab47a5b2.camel@HansenPartnership.com>
In-Reply-To: <27e3ac1678bde5e107691e12c09fa470ab47a5b2.camel@HansenPartnership.com>

On Wed Oct 30, 2024 at 5:47 PM EET, James Bottomley wrote:
> On Mon, 2024-10-28 at 07:50 +0200, Jarkko Sakkinen wrote:
> [...]
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -915,33 +915,37 @@ static int tpm2_parse_start_auth_session(struct
> > tpm2_auth *auth,
> > =C2=A0
> > =C2=A0static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int offset =3D=
 0; /* dummy offset for null seed
> > context */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name[SHA256_DIGEST_S=
IZE + 2];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 tmp_null_key;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_load_contex=
t(chip, chip->null_key_context, &offset,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 null_key);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc !=3D -EINVAL)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return rc;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &tmp_null_key);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc !=3D -EINVAL) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!rc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*null_=
key =3D tmp_null_key;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* an integrity failure may =
mean the TPM has been reset */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&chip->dev, "NULL ke=
y integrity failure!\n");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* check the null name again=
st what we know */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_create_primary(chip, TP=
M2_RH_NULL, NULL, name);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (memcmp(name, chip->null_=
key_name, sizeof(name)) =3D=3D 0)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* name unchanged, assume transient integrity failure
> > */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return rc;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Fatal TPM failure: the NU=
LL seed has actually changed, so
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the TPM must have been il=
legally reset.=C2=A0 All in-kernel TPM
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * operations will fail beca=
use the NULL primary can't be
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * loaded to salt the sessio=
ns, but disable the TPM anyway so
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * userspace programmes can'=
t be compromised by it.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&chip->dev, "NULL na=
me has changed, disabling TPM due
> > to interference\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Try to re-create null key=
, given the integrity failure: */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_create_primary(c=
hip, TPM2_RH_NULL, &tmp_null_key,
> > name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
>
> From a security point of view, this probably isn't such a good idea:
> the reason the context load failed above is likely the security
> condition we're checking for: the null seed changed because an
> interposer did a reset.  That means that if the interposer knows about
> this error leg, it would simply error out the create primary here and
> the TPM wouldn't be disabled.

If you think there is something that should be still addressed, or there
is overlooked issue please do send a patch, and we will review that.
There's been plenty of time to comment on patches.

Neither in previous TPM_CHIP_FLAG_DISABLED was set tpm2_load_context()
failed. It went like this:

	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
			       null_key);
	if (rc !=3D -EINVAL)
		return rc;

If you think that this should be addressed, do send a patch but point
out the fixes-tag to your original patch then.

BR, Jarkko

