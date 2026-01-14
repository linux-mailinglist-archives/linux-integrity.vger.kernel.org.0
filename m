Return-Path: <linux-integrity+bounces-8235-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9AD2004F
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 17:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F2C4308634D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B8399A60;
	Wed, 14 Jan 2026 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLqgfKlE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4536C593;
	Wed, 14 Jan 2026 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406148; cv=none; b=rlKWPyucxLn927PzrTDMLGoOyxc/8GJFonNMOehwyEw8OgRoWo6/UayW+0MEDgbIJHPn6FNpW08UVQjGIuKUVou0YD2x7SFE9HkDfHfu8v2/X7rZNQOUz/1YZDuJgZavs3EgqXcuz+PTleGRVYg9d5CrfDDH/UIoAmAjnoSXxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406148; c=relaxed/simple;
	bh=3XHv7ZEnMk+PyC7RV409KSNNeltVgoxSRxarob/cQNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDpy6yq7SiH+R4+glwpdwFC0dnm6RmfZuVJGARa/W2D6Nco4jH2gPB3+JSylm+P0ne+nNztlWgTStHuPkemhQ8yzS/Y48AGBoJ0AiJ/s2RnIS5HXc7yiBLEKo4dxRrqqBYqxClZk7c16jNyVxreGQZZs/iWJsNKqmvOCyuNUX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLqgfKlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB976C4CEF7;
	Wed, 14 Jan 2026 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406148;
	bh=3XHv7ZEnMk+PyC7RV409KSNNeltVgoxSRxarob/cQNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLqgfKlEDbzqIf/8H0X/wrSEG4vMA2wXGr4XWz/oZPCgJjovqqUU53w8oHfnRLdRD
	 6D8aNoqQ7QLdWMTkgbvWsdmHfFAJ9BPwqtqQXHCmGj6YlTusW5ZvBuBIYx0j4IPiK1
	 bfGzK635MiFv86/aIZnGvJIVhUiYGftGvtszJp3MNcG4VBmWRYrUTE3ocd10ShYNCZ
	 JefYPoTJMyw8dF/OvpWx+C+MyY7vcc1gPPJgg/A8MY/94YPtvPJUys9wGCdDoOV34v
	 lWwDVU+lRU8KiSmDnybPZCt+/djVEFCrMge/CJFXYOMF82eRFqSnXKFUFgEKxlt4mt
	 qv2c86d4kJcEQ==
Date: Wed, 14 Jan 2026 17:55:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] tpm2-sessions: Remove AUTH_MAX_NAMES
Message-ID: <aWe8fwkw3tN9mFO9@kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
 <20251214153808.73831-6-jarkko@kernel.org>
 <b19c064b-9dfe-45d6-b23d-1bfaca6afb02@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19c064b-9dfe-45d6-b23d-1bfaca6afb02@oracle.com>

On Mon, Jan 12, 2026 at 04:22:24PM -0800, ross.philipson@oracle.com wrote:
> On 12/14/25 7:38 AM, Jarkko Sakkinen wrote:
> > In all of the call sites only one session is ever append. Thus, reduce
> > AUTH_MAX_NAMES, which leads into removing constant completely.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++--------------------
> >   1 file changed, 11 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index 3bc3c31cf512..37570dc088cf 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -72,9 +72,6 @@
> >   #include <crypto/sha2.h>
> >   #include <crypto/utils.h>
> > -/* maximum number of names the TPM must remember for authorization */
> > -#define AUTH_MAX_NAMES	3
> > -
> >   #define AES_KEY_BYTES	AES_KEYSIZE_128
> >   #define AES_KEY_BITS	(AES_KEY_BYTES*8)
> > @@ -136,8 +133,8 @@ struct tpm2_auth {
> >   	 * handle, but they are part of the session by name, which
> >   	 * we must compute and remember
> >   	 */
> > -	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
> > -	u16 name_size_tbl[AUTH_MAX_NAMES];
> > +	u8 name[TPM2_MAX_NAME_SIZE];
> > +	u16 name_size;
> >   };
> >   #ifdef CONFIG_TCG_TPM2_HMAC
> > @@ -261,11 +258,14 @@ EXPORT_SYMBOL_GPL(tpm2_read_public);
> >   int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> >   			u32 handle, u8 *name, u16 name_size)
> >   {
> > -#ifdef CONFIG_TCG_TPM2_HMAC
> 
> Removing CONFIG_TCG_TPM2_HMAC here causes a warning during compile since the
> auth variable is only used in the CONFIG_TCG_TPM2_HMAC block below.

Thanks for the remark, I'll look into this.

I should have next week bandwidth to look into your patch set too (still
rebooting from the holidays)

> 
> Ross
> 
> >   	struct tpm2_auth *auth;
> > -	int slot;
> >   	int ret;
> > -#endif
> > +
> > +	if (tpm_buf_length(buf) != TPM_HEADER_SIZE) {
> > +		dev_err(&chip->dev, "too many handles\n");
> > +		ret = -EIO;
> > +		goto err;
> > +	}
> >   	if (!tpm2_chip_auth(chip)) {
> >   		tpm_buf_append_handle(chip, buf, handle);
> > @@ -273,12 +273,6 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> >   	}
> >   #ifdef CONFIG_TCG_TPM2_HMAC
> > -	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
> > -	if (slot >= AUTH_MAX_NAMES) {
> > -		dev_err(&chip->dev, "too many handles\n");
> > -		ret = -EIO;
> > -		goto err;
> > -	}
> >   	auth = chip->auth;
> >   	if (auth->session != tpm_buf_length(buf)) {
> >   		dev_err(&chip->dev, "session state malformed");
> > @@ -287,16 +281,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> >   	}
> >   	tpm_buf_append_u32(buf, handle);
> >   	auth->session += 4;
> > -	memcpy(auth->name[slot], name, name_size);
> > -	auth->name_size_tbl[slot] = name_size;
> > +	memcpy(auth->name, name, name_size);
> > +	auth->name_size = name_size;
> >   #endif
> >   	return 0;
> > -#ifdef CONFIG_TCG_TPM2_HMAC
> >   err:
> >   	tpm2_end_auth_session(chip);
> >   	return ret;
> > -#endif
> >   }
> >   EXPORT_SYMBOL_GPL(tpm_buf_append_name);
> > @@ -665,8 +657,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
> >   	/* ordinal is already BE */
> >   	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
> >   	/* add the handle names */
> > -	for (i = 0; i < handles; i++)
> > -		sha256_update(&sctx, auth->name[i], auth->name_size_tbl[i]);
> > +	sha256_update(&sctx, auth->name, auth->name_size);
> >   	if (offset_s != tpm_buf_length(buf))
> >   		sha256_update(&sctx, &buf->data[offset_s],
> >   			      tpm_buf_length(buf) - offset_s);
> 

BR, Jarkko

