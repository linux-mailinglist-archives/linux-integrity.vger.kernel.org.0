Return-Path: <linux-integrity+bounces-4061-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66F9C07FB
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235C82880A9
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495821219D;
	Thu,  7 Nov 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIdpGPRT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D520FAB1;
	Thu,  7 Nov 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987273; cv=none; b=uxwJA2k+6r8wWTmIjA29apkhqgW2gabY89uaN3Eb61w2oaJcZ2GLe/UmD8H9o6TBi3pZSC8iNcZ8Ux6YqiJZXGFP6NwSj/ItSq70uvnwV+u3zHe+n2bWfLpdHMkOXugL2U6tBPo8/tjwZ6pHsZMyLI7VdBQgXOBTtuUqcQAI7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987273; c=relaxed/simple;
	bh=R5/Rh95XUs1vezOrkVQPHF6VtUG3vorTYjXYS0Tb0eM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QbI1qQDNUK7FGhSjQct2j6BUYtdM8T4G++/BPPrjOm8k5YyP0FXDHh4e/eoxaOprepNMwxycxw/1rUGZCbE8JJyiyFmbES73h4dMgDNA8EiqJS8VmhVcGedt4GrQwQsc0SGo3O9JpU8IxUdC/hjBuLix1Yt3zJswQktLdGXliXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIdpGPRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A86EC4CECC;
	Thu,  7 Nov 2024 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987272;
	bh=R5/Rh95XUs1vezOrkVQPHF6VtUG3vorTYjXYS0Tb0eM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lIdpGPRTHsIejI8tgvoVEouYXethfkHjZFfSttCWTo0dogXlNqKzV/I1giZwgAX66
	 eTLD1UDJCBSxdEIZ1t2Ci7gB+lrXw7kIAJym+08cwoidF1yZMjwmbefgBvHvBQu1oC
	 l536MeNAdKeKUfAR7iYDRjPcBmaQu0h8zFhYPY1UMDKJqTwWwcpnHai8gRabCru98O
	 87X8f7FLlmPMvySKTsGZl9yRLPzRnnjTRz6nwggQXHH1XGWa7o1gBgGLf1buLzh9U3
	 JtPRMx+IPPNCU1EBw3DP6m2a5hF9H5ovSIYyy9sVs7CnZM/eQ5OCuveF3FSUGWcdf2
	 npSHA+l71SIQw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 15:47:48 +0200
Message-Id: <D5FZRXBCH2B4.1GQIIVQHVB2XI@kernel.org>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241107095138.78209-1-jarkko@kernel.org>
 <e015a939893d35efe75e598152725adcc2befdd8.camel@linux.ibm.com>
In-Reply-To: <e015a939893d35efe75e598152725adcc2befdd8.camel@linux.ibm.com>

On Thu Nov 7, 2024 at 3:44 PM EET, Mimi Zohar wrote:
> > +	tpm.disable_pcr_integrity_protection=3D [HW,TPM]
> > +			Do not protect PCR registers from unintended physical
> > +			access, or interposers in the bus by the means of
> > +			having an encrypted and integrity protected session
>
> "encrypted" isn't needed here.

fixing

>
> > +			wrapped around TPM2_PCR_Extend command. Consider this
> > +			in a situation where TPM is heavily utilized by
> > +			IMA, thus protection causing a major performance hit,
> > +			and the space where machines are deployed is by other
> > +			means guarded.
> > +
> >  	tpm_suspend_pcr=3D[HW,TPM]
> >  			Format: integer pcr id
> >  			Specify that at suspend time, the tpm driver
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index cad0048bcc3c..e49a19fea3bd 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -146,6 +146,26 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const=
 u32 value)
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> > =20
> > +/**
> > + * tpm_buf_append_handle() - Add a handle
> > + * @chip:	&tpm_chip instance
> > + * @buf:	&tpm_buf instance
> > + * @handle:	a TPM object handle
> > + *
> > + * Add a handle to the buffer, and increase the count tracking the num=
ber of
> > + * handles in the command buffer. Works only for command buffers.
> > + */
> > +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf,=
 u32 handle)
> > +{
> > +	if (buf->flags & TPM_BUF_TPM2B) {
> > +		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
> > +		return;
> > +	}
> > +
> > +	tpm_buf_append_u32(buf, handle);
> > +	buf->handles++;
> > +}
> > +
> >  /**
> >   * tpm_buf_read() - Read from a TPM buffer
> >   * @buf:	&tpm_buf instance
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 1e856259219e..cc443bcf15e8 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -14,6 +14,10 @@
> >  #include "tpm.h"
> >  #include <crypto/hash_info.h>
> > =20
> > +static bool disable_pcr_integrity_protection;
> > +module_param(disable_pcr_integrity_protection, bool, 0444);
> > +MODULE_PARM_DESC(disable_pcr_integrity_protection, "Disable TPM2_PCR_E=
xtend encryption");
>
> I like the name 'disable_pcr_integrity_protection.  However, the name and
> description doesn't match.  Replace 'encryption' with 'integrity protecti=
on'.

Weird, I changed that. I don't know  how it ended up being like that.

>
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
> > +	if (!disable_pcr_integrity_protection) {
> > +		rc =3D tpm2_start_auth_session(chip);
> > +		if (rc)
> > +			return rc;
> > +	}
> > =20
> >  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> >  	if (rc) {
> > -		tpm2_end_auth_session(chip);
> > +		if (!disable_pcr_integrity_protection)
> > +			tpm2_end_auth_session(chip);
> >  		return rc;
> >  	}
> > =20
> > -	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> > -	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > +	if (!disable_pcr_integrity_protection) {
> > +		tpm_buf_append_name(chip, &buf, pcr_idx);
>
> tpm_buf_append_name() parameters didn't change.  Don't remove the 'name' =
field
> here.

Hmm... weird I'll check this. Maybe I had something left to staging...

>
>
> > +		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> > +	} else {
> > +		tpm_buf_append_handle(chip, &buf, pcr_idx);
>

> Or here.

Here I think it is appropriate

>
> > +		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> > +	}
> > =20
> >  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> > =20
> >=20
>
> Mimi


BR, Jarkko

