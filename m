Return-Path: <linux-integrity+bounces-7319-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCCABACE29
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560807A2323
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586572FC86C;
	Tue, 30 Sep 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K84O9Zhu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC42FB625;
	Tue, 30 Sep 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235984; cv=none; b=gTz27gSLHWPjdOgLPjOk5+4zyUf5e/IjxTY7IeoQ/flNdwG+dwIpH03Bg3W78MpMoymbeh+nyK+eeIkDqV14zTT1cfzCFZc1H7EvBEC3zOOzaaSXQWLaKmT6dStEC3+wDq7nvqXikLfTY9SPEn3CGf1+iUmD94IJn4CRDZoOFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235984; c=relaxed/simple;
	bh=Hf0iUYcbid7zzLDUR6Xrgij1hCWZ488BCe4EgYcOHuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj3qXqrsy2gopploHrcuQAiLvVYygj1Z7CX+qxZm3dQ4Wq5yw4JBKGGRTUAEeQDpihtekGvxIz/bzeOsl0hWVBprsWMlxpbqes+bEaXwa4UmZumvIXWS9keee0aTGrOUQw5We/NB39oNIdkQCPJkqr6vuxU9UbOE1rRJJRqFPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K84O9Zhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39333C4CEF0;
	Tue, 30 Sep 2025 12:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759235983;
	bh=Hf0iUYcbid7zzLDUR6Xrgij1hCWZ488BCe4EgYcOHuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K84O9Zhu5D/STTAB7jwVwCmaw0mOyAerPw2bcoJusHc+kOs0/UdQavU0/klGZnQ9f
	 6VdGaSyMfrtsgPW7piB+Zg48cQy/Y2o1s5WII3V64uDxRVid9j7SvQdS04K2pZyOEy
	 ETjUW3MWLJfY0MJhcY/pp/46Qcs4NATlJwgJCsZU2fnevitORckcTCFAZBboWYQ07R
	 dOrfAm4iXobAzxKI+NfsqsSHNDcjn99FoNNyjmLCkTyJJGxuWgSEV/gSMjyiJKXMAg
	 gHuYly+R3E92FQUUX+jsaFatBR2Iuuw5tGNNJV8PJKrMqT2RkSq8xX8PxAKZSpADIx
	 zEbkrPST5HSAw==
Date: Tue, 30 Sep 2025 15:39:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] tpm2-sessions: Remove 'attributes' from
 tpm_buf_append_auth
Message-ID: <aNvPi9qQGjXDDgDl@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-5-jarkko@kernel.org>
 <aNu6sZc-JTPhFTLV@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNu6sZc-JTPhFTLV@earth.li>

On Tue, Sep 30, 2025 at 12:10:41PM +0100, Jonathan McDowell wrote:
> On Mon, Sep 29, 2025 at 10:48:26PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > In a previous bug fix, 'attributes' was added by mistake to
> > tpm_buf_append_auth(). Remove the parameter.
> > 
> > Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thank you.

> 
> > ---
> > v3:
> > - No changes
> > v2:
> > - Uncorrupt the patch.
> > ---
> >  drivers/char/tpm/tpm2-cmd.c      | 2 +-
> >  drivers/char/tpm/tpm2-sessions.c | 5 ++---
> >  include/linux/tpm.h              | 2 +-
> >  3 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index a7cddd4b5626..86b1a4d859b9 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -191,7 +191,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> >  		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> >  	} else {
> >  		tpm_buf_append_handle(chip, &buf, pcr_idx);
> > -		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
> > +		tpm_buf_append_auth(chip, &buf, NULL, 0);
> >  	}
> >  
> >  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index 6d03c224e6b2..13f019d1312a 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -266,7 +266,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> >  EXPORT_SYMBOL_GPL(tpm_buf_append_name);
> >  
> >  void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > -			 u8 attributes, u8 *passphrase, int passphrase_len)
> > +			 u8 *passphrase, int passphrase_len)
> >  {
> >  	/* offset tells us where the sessions area begins */
> >  	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> > @@ -327,8 +327,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> >  #endif
> >  
> >  	if (!tpm2_chip_auth(chip)) {
> > -		tpm_buf_append_auth(chip, buf, attributes, passphrase,
> > -				    passphrase_len);
> > +		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
> >  		return;
> >  	}
> >  
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 51846317d662..1fa02e18e688 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -531,7 +531,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> >  				 u8 attributes, u8 *passphrase,
> >  				 int passphraselen);
> >  void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> > -			 u8 attributes, u8 *passphrase, int passphraselen);
> > +			 u8 *passphrase, int passphraselen);
> >  static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
> >  						   struct tpm_buf *buf,
> >  						   u8 attributes,
> > -- 
> > 2.39.5
> > 
> > 
> 
> J.
> 
> -- 
>    101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
>        much of : 17 - Money.       | : :' :  Happy to accept PGP signed
>                                    | `. `'   or encrypted mail - RSA
>                                    |   `-    key on the keyservers.

BR, Jarkko

