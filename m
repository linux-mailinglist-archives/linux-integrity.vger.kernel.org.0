Return-Path: <linux-integrity+bounces-7320-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA9BACE3E
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC751920DA6
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317602FC873;
	Tue, 30 Sep 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX10ODDW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B22561AA;
	Tue, 30 Sep 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236085; cv=none; b=lnd2PjVp9zLa1BSobBbRUiQlna0UbXjnSgLsFHme9q8gdmLh6gOhH/IadlU0jyQQ/VSPZk+XjbzsZiDCUpEl8f3pIel13Yf6KOuq/y+mt/+gkhi3xc6kwWn4SJt5s6/O+lE1gCY5s0dQjhROlMbgWi9J5CGYJmVP6WTl+wXFC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236085; c=relaxed/simple;
	bh=QLtR0UtXye8socRHqw7g76A0i5G9OeXCJ8GL3ZscJKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2/fHmj0Bgtk1c4mADDEbtCt6EdZFDMIeM/V00PbUMUykGVZHRjRmnohl8JMrdBu8KFc01+yNtQmHpSEgp+MTyU6Zi/OKcHB5K0DUztpzZrmaiYQU8x/kgaq8d3gUYwCTDs4XOZD9Zze4rmmlTeBzlISSsatezYFEKgFIbchxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX10ODDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A215C113D0;
	Tue, 30 Sep 2025 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759236084;
	bh=QLtR0UtXye8socRHqw7g76A0i5G9OeXCJ8GL3ZscJKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX10ODDW4aPn5Hyrcyba9wBEa1cEuE+DX+wncG0cG0GfpBdjK/F+9ye66q1QnXt26
	 BQAXPVaO9UrI8qhUXw949tdzdA4xQYdPrso08n10KcjwcQtt0yR/MMlNhvmdJ86wRe
	 F4t5hDX9/4AyOecodON1LGNQ3vttVt+maG+/o3XDelelclhG9jZfKsJH0rUuD8uVbi
	 AZp16isRPc76WH1dbX9iHFoQC0BfBEyPHCz7eYr59H5W0j7UySVIyHjvYFXQbosxMx
	 8gDQVh/+GY9x9JrtxaPf0fAyGpFb1sJl35yRr/i4XtrGuPMkKR0RZY36CR7+2z/pS5
	 SXZLR8Zih8/EA==
Date: Tue, 30 Sep 2025 15:41:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] tpm2-sessions: Umask
 tpm_buf_append_hmac_session()
Message-ID: <aNvP8D7QOX7dHzvG@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-6-jarkko@kernel.org>
 <aNu6834tzirFzKM7@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNu6834tzirFzKM7@earth.li>

On Tue, Sep 30, 2025 at 12:11:47PM +0100, Jonathan McDowell wrote:
> On Mon, Sep 29, 2025 at 10:48:27PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Open code tpm_buf_append_hmac_session_opt() in order to unmask the code
> > paths in the call sites of tpm_buf_append_hmac_session().
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>

Thanks (short summary has a typo tho) 

> 
> > ---
> > v3:
> > - No changes.
> > v2:
> > - Uncorrupt the patch.
> > ---
> >  drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
> >  include/linux/tpm.h                       | 23 -----------------------
> >  security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
> >  3 files changed, 21 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 86b1a4d859b9..c7bfa705ea8f 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -257,9 +257,17 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> >  
> >  	do {
> >  		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
> > -		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
> > -						| TPM2_SA_CONTINUE_SESSION,
> > -						NULL, 0);
> > +		if (tpm2_chip_auth(chip)) {
> > +			tpm_buf_append_hmac_session(chip, &buf,
> > +						    TPM2_SA_ENCRYPT |
> > +						    TPM2_SA_CONTINUE_SESSION,
> > +						    NULL, 0);
> > +		} else  {
> > +			offset = buf.handles * 4 + TPM_HEADER_SIZE;
> > +			head = (struct tpm_header *)buf.data;
> > +			if (tpm_buf_length(&buf) == offset)
> > +				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> > +		}
> >  		tpm_buf_append_u16(&buf, num_bytes);
> >  		tpm_buf_fill_hmac_session(chip, &buf);
> >  		err = tpm_transmit_cmd(chip, &buf,
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 1fa02e18e688..e72e7657faa2 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -532,29 +532,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
> >  				 int passphraselen);
> >  void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
> >  			 u8 *passphrase, int passphraselen);
> > -static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
> > -						   struct tpm_buf *buf,
> > -						   u8 attributes,
> > -						   u8 *passphrase,
> > -						   int passphraselen)
> > -{
> > -	struct tpm_header *head;
> > -	int offset;
> > -
> > -	if (tpm2_chip_auth(chip)) {
> > -		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
> > -	} else  {
> > -		offset = buf->handles * 4 + TPM_HEADER_SIZE;
> > -		head = (struct tpm_header *)buf->data;
> > -
> > -		/*
> > -		 * If the only sessions are optional, the command tag must change to
> > -		 * TPM2_ST_NO_SESSIONS.
> > -		 */
> > -		if (tpm_buf_length(buf) == offset)
> > -			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> > -	}
> > -}
> >  
> >  #ifdef CONFIG_TCG_TPM2_HMAC
> >  
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index e165b117bbca..c414a7006d78 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -482,8 +482,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >  			   struct trusted_key_options *options,
> >  			   u32 blob_handle)
> >  {
> > +	struct tpm_header *head;
> >  	struct tpm_buf buf;
> >  	u16 data_len;
> > +	int offset;
> >  	u8 *data;
> >  	int rc;
> >  
> > @@ -518,8 +520,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> >  		tpm2_buf_append_auth(&buf, options->policyhandle,
> >  				     NULL /* nonce */, 0, 0,
> >  				     options->blobauth, options->blobauth_len);
> > -		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
> > -						NULL, 0);
> > +		if (tpm2_chip_auth(chip)) {
> > +			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
> > +		} else  {
> > +			offset = buf.handles * 4 + TPM_HEADER_SIZE;
> > +			head = (struct tpm_header *)buf.data;
> > +			if (tpm_buf_length(&buf) == offset)
> > +				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> > +		}
> >  	}
> >  
> >  	tpm_buf_fill_hmac_session(chip, &buf);
> > -- 
> > 2.39.5
> > 
> > 
> 
> J.
> 
> -- 
> ... I love you the way a bomb loves a crowd.

BR, Jarkko

