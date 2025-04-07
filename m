Return-Path: <linux-integrity+bounces-5634-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68FA7DC49
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2B1890E40
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90AC23BD02;
	Mon,  7 Apr 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llN8+xbS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826302376E2;
	Mon,  7 Apr 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025410; cv=none; b=PwtV84XX+YHQhVKN2YmuIzhQtf7gf/+EojBPs9EPpjAo8993Jdwh4PcN/OZyqz10BI4fWmTL6UTCkFh8jUSeagYB5cpcNU7qtgmPj4ji+Fi2FsbDk1pdsEXIkD0p9DN1dHwmxcWO6BftA1Pc9Uym9LjsksEnKtnHlroZ3fjbjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025410; c=relaxed/simple;
	bh=u90GVaNUUo76YLN6SKbqib+18pDw2l0zRWHHUjFm3as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubIYfqCmvvfKVC2HuKOqw9ft5OH0rUUZvH5tr/KYtDqAtsGvpxEhRKukUTmiDEvkPcGiHVsC9DIAGGhIBVu+cfV0HkTyqW5BcWvtYoJvE227c6+0hjkSOIDFXuqqaL/2I3T7DroDgBM8OOraH2iKR4VWbPpomQMoZnHIcPdWD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llN8+xbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BEDC4CEDD;
	Mon,  7 Apr 2025 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744025410;
	bh=u90GVaNUUo76YLN6SKbqib+18pDw2l0zRWHHUjFm3as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llN8+xbS7zazGfzUGA1WFZphuPkSIBLxMdii7M0vqEbEp38Ifvz9TfkFMp1BvsZ3d
	 xV/EvfVLdIBjh+Gi7m84ZRajTEngrnXkdwHfcxgI6s9zMOtYFRcNQX4mLhdLnF9goV
	 6S+JUklyeoXGK36lUhD314sgiSKGmSAx5SHu8AAwJE5WEaaBxpB3k+3WG3SFcMb+vI
	 li08zR6BSkj/XAYX/BOh0S7ClxD5q0T4scHihZBvirPJtrSM1Bj9c1OuYyGKV+90jl
	 FgHcYjbLf7VW3kxNTGgpxeCEUR9kr0+qiABOTIvCin6/RNq5zAyHh3NHBzLC+1UZWr
	 YJ0ApstZK5a7A==
Date: Mon, 7 Apr 2025 14:30:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: keyrings@vger.kernel.org, stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Mask TPM RC in tpm2_start_auth_session()
Message-ID: <Z_O3PU5XDbDirlUO@kernel.org>
References: <20250407071731.78915-1-jarkko@kernel.org>
 <20250407072057.81062-1-jarkko@kernel.org>
 <2mjtwprr3dujf4wbu5licb3jtzxujimcz5iahrgqymu6znwbbq@cslxwt7ejva3>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2mjtwprr3dujf4wbu5licb3jtzxujimcz5iahrgqymu6znwbbq@cslxwt7ejva3>

On Mon, Apr 07, 2025 at 10:04:09AM +0200, Stefano Garzarella wrote:
> On Mon, Apr 07, 2025 at 10:20:57AM +0300, Jarkko Sakkinen wrote:
> > tpm2_start_auth_session() does not mask TPM RC correctly from the callers:
> > 
> > [   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session
> > 
> > Process TPM RCs inside tpm2_start_auth_session(), and map them to POSIX
> > error codes.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Closes: https://lore.kernel.org/linux-integrity/Z_NgdRHuTKP6JK--@gondor.apana.org.au/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3:
> > - rc > 0
> > v2:
> > - Investigate TPM rc only after destroying tpm_buf.
> > ---
> > drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++++++++--------------
> > include/linux/tpm.h              |  1 +
> > 2 files changed, 18 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index 3f89635ba5e8..abd54fb0a45a 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -40,11 +40,6 @@
> >  *
> >  * These are the usage functions:
> >  *
> > - * tpm2_start_auth_session() which allocates the opaque auth structure
> > - *	and gets a session from the TPM.  This must be called before
> > - *	any of the following functions.  The session is protected by a
> > - *	session_key which is derived from a random salt value
> > - *	encrypted to the NULL seed.
> >  * tpm2_end_auth_session() kills the session and frees the resources.
> >  *	Under normal operation this function is done by
> >  *	tpm_buf_check_hmac_response(), so this is only to be used on
> > @@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
> > }
> > 
> > /**
> > - * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
> > - * @chip: the TPM chip structure to create the session with
> > + * tpm2_start_auth_session() - Create an a HMAC authentication session
> > + * @chip:	A TPM chip
> >  *
> > - * This function loads the NULL seed from its saved context and starts
> > - * an authentication session on the null seed, fills in the
> > - * @chip->auth structure to contain all the session details necessary
> > - * for performing the HMAC, encrypt and decrypt operations and
> > - * returns.  The NULL seed is flushed before this function returns.
> > + * Loads the ephemeral key (null seed), and starts an HMAC authenticated
> > + * session. The null seed is flushed before the return.
> >  *
> > - * Return: zero on success or actual error encountered.
> > + * Returns zero on success, or a POSIX error code.
> >  */
> > int tpm2_start_auth_session(struct tpm_chip *chip)
> > {
> > @@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
> > 	/* hash algorithm for session */
> > 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> > 
> > -	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> > +	rc = tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession");
> > 	tpm2_flush_context(chip, null_key);
> > 
> > 	if (rc == TPM2_RC_SUCCESS)
> > @@ -1032,6 +1024,17 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
> > 
> > 	tpm_buf_destroy(&buf);
> > 
> > +	if (rc > 0) {
> 
> To avoid the nesting blocks, can we include `TPM2_RC_SUCCESS` case in the
> switch or move the `if (rc == TPM2_RC_SUCCESS)` before it?

What do you mean by "avoiding nesting blocks"?

> 
> Thanks,
> Stefano

BR, Jarkko

