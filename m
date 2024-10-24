Return-Path: <linux-integrity+bounces-3907-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 457519AE3C9
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 13:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FD6B21706
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C501CBEBA;
	Thu, 24 Oct 2024 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCxWXQhV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFB148838;
	Thu, 24 Oct 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769140; cv=none; b=chbLGgjEA1e+ArNTtLFz0Gk69lw931JvgxP96irKTDry6c2I+BYMvzrjB9U8MCJNsM5LZvLKeTlsm38VYxLO8Uouk5fsZfi3IcxB/FgdsSQks7oLZet4YRv8r39sZzaiy9kPoS6kwKeB8fNbw+hUZUbs+JukDqNa7O2ZLox/Qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769140; c=relaxed/simple;
	bh=aniAk/uo+DHhMidSJrOrrMW/7/+J1b6IF2Jcmz4YOIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lUWzNGyJmeZgxBLOi7yXBIhsEgguEjrLADwIKxKX+Wq8utMVdn8K9aID119e/hlXJ5YoAZe0IB7c01sqjmHZf1D6m+Gnbd5XmkeCwdSZYsQsBjXmawsIBiCevwG2puQCkpb91cl0ea5c712PYFATYmZo7g+U2Qeg3jq2ZuRzPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCxWXQhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7717C4CEC7;
	Thu, 24 Oct 2024 11:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729769140;
	bh=aniAk/uo+DHhMidSJrOrrMW/7/+J1b6IF2Jcmz4YOIc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KCxWXQhVoxwEbL2ycEbuqfgGTz3lkfMcrDSFrz20Hll1Y2YEaM0bZLsU1CwX7AFPM
	 G+izVv+tCuAD92jeEo4LPPQ7/hIGp6ACRfIJGPd1phU4U2qtSbqW+7hZP5jFMlYF/f
	 Ai2LUr2/CQJdjzhOEOB+Dz/P8VZOmcONZrV5Ul7wPAisEo4RXaY5YEAZWExJgcrC3S
	 hzuqfxOZkbiAPm+VuryYL+7wXMvh3aKX36M1zMd4XE10ixOUvN2O244VlzF0SYotBp
	 x4PsxXLuZrMOzUJRbH0hs6p52c7PilzWc97TCLIILecaBdyRbYpFAk0qUr4BaQIw8m
	 23Iu9YGN31FPA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 14:25:35 +0300
Message-Id: <D53ZZEUWMSY9.2Y3DY0CA1MWZC@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Pengyu Ma"
 <mapengyu@gmail.com>
Subject: Re: [PATCH v7 3/5] tpm: flush the null key only when /dev/tpm0 is
 accessed
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.18.2
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-4-jarkko@kernel.org>
 <531b27a8-6e99-40ca-9d74-f94a3b8c638e@linux.ibm.com>
In-Reply-To: <531b27a8-6e99-40ca-9d74-f94a3b8c638e@linux.ibm.com>

On Wed Oct 23, 2024 at 9:18 PM EEST, Stefan Berger wrote:
>
>
> On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> > Instead of flushing and reloading the null key for every single auth
> > session, flush it only when:
> >=20
> > 1. User space needs to access /dev/tpm{rm}0.
> > 2. When going to sleep.
> > 3. When unregistering the chip.
> >=20
> > This removes the need to load and swap the null key between TPM and
> > regular memory per transaction, when the user space is not using the
> > chip.
> >=20
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> > Tested-by: Pengyu Ma <mapengyu@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - No changes.
> > v4:
> > - Changed to bug fix as not having the patch there is a major hit
> >    to bootup times.
> > v3:
> > - Unchanged.
> > v2:
> > - Refined the commit message.
> > - Added tested-by from Pengyu Ma <mapengyu@gmail.com>.
> > - Removed spurious pr_info() statement.
> > ---
> >   drivers/char/tpm/tpm-chip.c       | 13 +++++++++++++
> >   drivers/char/tpm/tpm-dev-common.c |  7 +++++++
> >   drivers/char/tpm/tpm-interface.c  |  9 +++++++--
> >   drivers/char/tpm/tpm2-cmd.c       |  3 +++
> >   drivers/char/tpm/tpm2-sessions.c  | 17 ++++++++++++++---
> >   include/linux/tpm.h               |  2 ++
> >   6 files changed, 46 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 854546000c92..0ea00e32f575 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -674,6 +674,19 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
> >    */
> >   void tpm_chip_unregister(struct tpm_chip *chip)
> >   {
> > +#ifdef CONFIG_TCG_TPM2_HMAC
> > +	int rc;
> > +
> > +	rc =3D tpm_try_get_ops(chip);
> > +	if (!rc) {
> > +		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +			tpm2_flush_context(chip, chip->null_key);
>
> If chip->null_key is already 0, the above function will not do anything=
=20
> good, but you could avoid this whole block then by checking for 0 before=
=20
> tpm_try_get_ops().
>
> > +			chip->null_key =3D 0;
> > +		}
> > +		tpm_put_ops(chip);
> > +	}
> > +#endif
> > +
> >   	tpm_del_legacy_sysfs(chip);
> >   	if (tpm_is_hwrng_enabled(chip))
> >   		hwrng_unregister(&chip->hwrng);
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-d=
ev-common.c
> > index 30b4c288c1bb..4eaa8e05c291 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -27,6 +27,13 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chi=
p, struct tpm_space *space,
> >   	struct tpm_header *header =3D (void *)buf;
> >   	ssize_t ret, len;
> >  =20
> > +#ifdef CONFIG_TCG_TPM2_HMAC
> > +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +		tpm2_flush_context(chip, chip->null_key);
> > +		chip->null_key =3D 0;
> > +	}
> > +#endif
> > +
> >   	ret =3D tpm2_prepare_space(chip, space, buf, bufsiz);
> >   	/* If the command is not implemented by the TPM, synthesize a
> >   	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-in=
terface.c
> > index 5da134f12c9a..bfa47d48b0f2 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -379,10 +379,15 @@ int tpm_pm_suspend(struct device *dev)
> >  =20
> >   	rc =3D tpm_try_get_ops(chip);
> >   	if (!rc) {
> > -		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > +		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +#ifdef CONFIG_TCG_TPM2_HMAC
> > +			tpm2_flush_context(chip, chip->null_key);
> > +			chip->null_key =3D 0;
> > +#endif
>
> Worth using an inline on this repeating pattern? Up to you.
>
> static inline void tpm2_flush_null_key(struct tpm_chip *chip)
> {
> #ifdef CONFIG_TCG_TPM2_HMAC
>      if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->null_key) {
>          tpm2_flush_context(chip, chip->null_key);
>          chip->null_key =3D 0;
>      }
> #endif
> }
>
> >   			tpm2_shutdown(chip, TPM2_SU_STATE);
> > -		else
> > +		} else {
> >   			rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > +		}
> >  =20
> >   		tpm_put_ops(chip);
> >   	}
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 1e856259219e..aba024cbe7c5 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -364,6 +364,9 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 =
handle)
> >   	struct tpm_buf buf;
> >   	int rc;
> >  =20
> > +	if (!handle)
> > +		return;
> > +
>
> wouldn't be necessary with inline.

True!

>
> >   	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT=
);
> >   	if (rc) {
> >   		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-s=
essions.c
> > index bdac11964b55..78c650ce4c9f 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -920,11 +920,19 @@ static int tpm2_load_null(struct tpm_chip *chip, =
u32 *null_key)
> >   	u32 tmp_null_key;
> >   	int rc;
> >  =20
> > +	/* fast path */
> > +	if (chip->null_key) {
> > +		*null_key =3D chip->null_key;
> > +		return 0;
> > +	}
> > +
> >   	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> >   			       &tmp_null_key);
> >   	if (rc !=3D -EINVAL) {
> > -		if (!rc)
> > +		if (!rc) {
> > +			chip->null_key =3D tmp_null_key;
> >   			*null_key =3D tmp_null_key;
> > +		}
> >   		goto err;
> >   	}
> >  =20
> > @@ -934,6 +942,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u3=
2 *null_key)
> >  =20
> >   	/* Return the null key if the name has not been changed: */
> >   	if (memcmp(name, chip->null_key_name, sizeof(name)) =3D=3D 0) {
> > +		chip->null_key =3D tmp_null_key;
> >   		*null_key =3D tmp_null_key;
> >   		return 0;
> >   	}
> > @@ -1006,7 +1015,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip=
)
> >   	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> >  =20
> >   	rc =3D tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> > -	tpm2_flush_context(chip, null_key);
> >  =20
> >   	if (rc =3D=3D TPM2_RC_SUCCESS)
> >   		rc =3D tpm2_parse_start_auth_session(auth, &buf);
> > @@ -1338,7 +1346,10 @@ static int tpm2_create_null_primary(struct tpm_c=
hip *chip)
> >  =20
> >   		rc =3D tpm2_save_context(chip, null_key, chip->null_key_context,
> >   				       sizeof(chip->null_key_context), &offset);
> > -		tpm2_flush_context(chip, null_key);
> > +		if (rc)
> > +			tpm2_flush_context(chip, null_key);
> > +		else
> > +			chip->null_key =3D null_key;
> >   	}
> >  =20
> >   	return rc;
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index e93ee8d936a9..4eb39db80e05 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -205,6 +205,8 @@ struct tpm_chip {
> >   #ifdef CONFIG_TCG_TPM2_HMAC
> >   	/* details for communication security via sessions */
> >  =20
> > +	/* loaded null key */
>
> nit: handle of loaded null key
>
> > +	u32 null_key;
> >   	/* saved context for NULL seed */
> >   	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
> >   	 /* name of NULL seed */

I agree with all of your remarks. I'll send one more round because there
is enough changes. Thank you.

BR, Jarkko

