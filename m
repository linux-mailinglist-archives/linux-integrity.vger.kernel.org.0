Return-Path: <linux-integrity+bounces-6781-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6481B1B548
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1133817ACD8
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AB1C84CB;
	Tue,  5 Aug 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U80kyvFs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3EA18E02A;
	Tue,  5 Aug 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401890; cv=none; b=jNWDire9yCZYg6RIt0HqZoefMyfs27xnSyfdWqC67hzUn2jTKQ8IXvU3wDoGX4fCBv1rQpsOsWsIlrkxEYJm5XnOvdtyZ1Iw5rvi7yXXDfzSCvkR5VH5zRUym7R5ICsYojbF9BXjJd0A4pTvbXiBv0saZy9qgNCKhR/sMz2CdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401890; c=relaxed/simple;
	bh=ObYyjCJvaTDg5NdoNfFdyCZHB+kWAoLfUs7bltSWmw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4E3gsOrQVal6ksY8aT+Mjsavfq6U1cdN2HWqPcxCheN1FSfcq5fdLzngPyxw8nmwypU7CxHCfFohJ1GCMQO/hszWfS3BHFlpHaHwAUpoyIaIwFA4JLSHDNN6sLD9yLJL7Rn2YaX9ooMycLwnOBIdp+AXazLaE30k6Cmjld25YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U80kyvFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF5C4CEF0;
	Tue,  5 Aug 2025 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754401889;
	bh=ObYyjCJvaTDg5NdoNfFdyCZHB+kWAoLfUs7bltSWmw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U80kyvFsXS4+TQpGgA9UDmYSvgBTjFgqSh4hvkUDxI4/1pW+5wyYmXMUQQ5u3yiPr
	 lnRBWwTpZrn5yNID7VwqTwwoqSYqEPRQZGdncT6cn1tAtk7BhDs4Km7jw/RsUd/wqf
	 l5W1zkJQyDEczx0CuiEXuSJCO0n+PGPfViV9uXZs6Njl40PErWDhyjFEBpHB45af8q
	 GvIYrioydxFVestMtfFpt+xEhC2mHS3kIE+v9Mmzm0qKV+uEvs8IaPIgIa9yfMxPtn
	 s6RvcGmB/Gt0C3RfMEjJnCFC3bhg8r/NYAELlmci9AnSpQettZ/Eduzhza43hsmbxU
	 mmHLZO4BhhGsw==
Date: Tue, 5 Aug 2025 16:51:26 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tpm: Use HMAC-SHA256 library instead of
 open-coded HMAC
Message-ID: <aJIMVq2FNPpH0KUL@kernel.org>
References: <20250801212422.9590-1-ebiggers@kernel.org>
 <20250801212422.9590-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801212422.9590-3-ebiggers@kernel.org>

On Fri, Aug 01, 2025 at 02:24:22PM -0700, Eric Biggers wrote:
> Now that there are easy-to-use HMAC-SHA256 library functions, use these
> in tpm2-sessions.c instead of open-coding the HMAC algorithm.
> 
> Note that the new implementation correctly handles keys longer than 64
> bytes (SHA256_BLOCK_SIZE), whereas the old implementation handled such
> keys incorrectly.  But it doesn't appear that such keys were being used.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 98 +++++++++-----------------------
>  1 file changed, 27 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 5fbd62ee50903..6d03c224e6b21 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -67,12 +67,11 @@
>  #include <linux/random.h>
>  #include <linux/scatterlist.h>
>  #include <linux/unaligned.h>
>  #include <crypto/kpp.h>
>  #include <crypto/ecdh.h>
> -#include <crypto/hash.h>
> -#include <crypto/hmac.h>
> +#include <crypto/sha2.h>
>  #include <crypto/utils.h>
>  
>  /* maximum number of names the TPM must remember for authorization */
>  #define AUTH_MAX_NAMES	3
>  
> @@ -383,55 +382,10 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_hmac_session);
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  
>  static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
>  			       u32 *handle, u8 *name);
>  
> -/*
> - * It turns out the crypto hmac(sha256) is hard for us to consume
> - * because it assumes a fixed key and the TPM seems to change the key
> - * on every operation, so we weld the hmac init and final functions in
> - * here to give it the same usage characteristics as a regular hash
> - */
> -static void tpm2_hmac_init(struct sha256_ctx *sctx, u8 *key, u32 key_len)
> -{
> -	u8 pad[SHA256_BLOCK_SIZE];
> -	int i;
> -
> -	sha256_init(sctx);
> -	for (i = 0; i < sizeof(pad); i++) {
> -		if (i < key_len)
> -			pad[i] = key[i];
> -		else
> -			pad[i] = 0;
> -		pad[i] ^= HMAC_IPAD_VALUE;
> -	}
> -	sha256_update(sctx, pad, sizeof(pad));
> -}
> -
> -static void tpm2_hmac_final(struct sha256_ctx *sctx, u8 *key, u32 key_len,
> -			    u8 *out)
> -{
> -	u8 pad[SHA256_BLOCK_SIZE];
> -	int i;
> -
> -	for (i = 0; i < sizeof(pad); i++) {
> -		if (i < key_len)
> -			pad[i] = key[i];
> -		else
> -			pad[i] = 0;
> -		pad[i] ^= HMAC_OPAD_VALUE;
> -	}
> -
> -	/* collect the final hash;  use out as temporary storage */
> -	sha256_final(sctx, out);
> -
> -	sha256_init(sctx);
> -	sha256_update(sctx, pad, sizeof(pad));
> -	sha256_update(sctx, out, SHA256_DIGEST_SIZE);
> -	sha256_final(sctx, out);
> -}
> -
>  /*
>   * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
>   * otherwise standard tpm2_KDFa.  Note output is in bytes not bits.
>   */
>  static void tpm2_KDFa(u8 *key, u32 key_len, const char *label, u8 *u,
> @@ -439,20 +393,20 @@ static void tpm2_KDFa(u8 *key, u32 key_len, const char *label, u8 *u,
>  {
>  	u32 counter = 1;
>  	const __be32 bits = cpu_to_be32(bytes * 8);
>  
>  	while (bytes > 0) {
> -		struct sha256_ctx sctx;
> +		struct hmac_sha256_ctx hctx;
>  		__be32 c = cpu_to_be32(counter);
>  
> -		tpm2_hmac_init(&sctx, key, key_len);
> -		sha256_update(&sctx, (u8 *)&c, sizeof(c));
> -		sha256_update(&sctx, label, strlen(label)+1);
> -		sha256_update(&sctx, u, SHA256_DIGEST_SIZE);
> -		sha256_update(&sctx, v, SHA256_DIGEST_SIZE);
> -		sha256_update(&sctx, (u8 *)&bits, sizeof(bits));
> -		tpm2_hmac_final(&sctx, key, key_len, out);
> +		hmac_sha256_init_usingrawkey(&hctx, key, key_len);
> +		hmac_sha256_update(&hctx, (u8 *)&c, sizeof(c));
> +		hmac_sha256_update(&hctx, label, strlen(label) + 1);
> +		hmac_sha256_update(&hctx, u, SHA256_DIGEST_SIZE);
> +		hmac_sha256_update(&hctx, v, SHA256_DIGEST_SIZE);
> +		hmac_sha256_update(&hctx, (u8 *)&bits, sizeof(bits));
> +		hmac_sha256_final(&hctx, out);
>  
>  		bytes -= SHA256_DIGEST_SIZE;
>  		counter++;
>  		out += SHA256_DIGEST_SIZE;
>  	}
> @@ -592,10 +546,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>  	off_t offset_s = TPM_HEADER_SIZE, offset_p;
>  	u8 *hmac = NULL;
>  	u32 attrs;
>  	u8 cphash[SHA256_DIGEST_SIZE];
>  	struct sha256_ctx sctx;
> +	struct hmac_sha256_ctx hctx;
>  
>  	if (!auth)
>  		return;
>  
>  	/* save the command code in BE format */
> @@ -703,18 +658,18 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>  		sha256_update(&sctx, &buf->data[offset_s],
>  			      tpm_buf_length(buf) - offset_s);
>  	sha256_final(&sctx, cphash);
>  
>  	/* now calculate the hmac */
> -	tpm2_hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
> -		       + auth->passphrase_len);
> -	sha256_update(&sctx, cphash, sizeof(cphash));
> -	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
> -	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> -	sha256_update(&sctx, &auth->attrs, 1);
> -	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
> -			+ auth->passphrase_len, hmac);
> +	hmac_sha256_init_usingrawkey(&hctx, auth->session_key,
> +				     sizeof(auth->session_key) +
> +					     auth->passphrase_len);
> +	hmac_sha256_update(&hctx, cphash, sizeof(cphash));
> +	hmac_sha256_update(&hctx, auth->our_nonce, sizeof(auth->our_nonce));
> +	hmac_sha256_update(&hctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> +	hmac_sha256_update(&hctx, &auth->attrs, 1);
> +	hmac_sha256_final(&hctx, hmac);
>  }
>  EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
>  
>  /**
>   * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
> @@ -750,10 +705,11 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>  	struct tpm2_auth *auth = chip->auth;
>  	off_t offset_s, offset_p;
>  	u8 rphash[SHA256_DIGEST_SIZE];
>  	u32 attrs, cc;
>  	struct sha256_ctx sctx;
> +	struct hmac_sha256_ctx hctx;
>  	u16 tag = be16_to_cpu(head->tag);
>  	int parm_len, len, i, handles;
>  
>  	if (!auth)
>  		return rc;
> @@ -819,19 +775,19 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>  	sha256_update(&sctx, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
>  	sha256_update(&sctx, &buf->data[offset_p], parm_len);
>  	sha256_final(&sctx, rphash);
>  
>  	/* now calculate the hmac */
> -	tpm2_hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
> -		       + auth->passphrase_len);
> -	sha256_update(&sctx, rphash, sizeof(rphash));
> -	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> -	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
> -	sha256_update(&sctx, &auth->attrs, 1);
> +	hmac_sha256_init_usingrawkey(&hctx, auth->session_key,
> +				     sizeof(auth->session_key) +
> +					     auth->passphrase_len);
> +	hmac_sha256_update(&hctx, rphash, sizeof(rphash));
> +	hmac_sha256_update(&hctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> +	hmac_sha256_update(&hctx, auth->our_nonce, sizeof(auth->our_nonce));
> +	hmac_sha256_update(&hctx, &auth->attrs, 1);
>  	/* we're done with the rphash, so put our idea of the hmac there */
> -	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
> -			+ auth->passphrase_len, rphash);
> +	hmac_sha256_final(&hctx, rphash);
>  	if (crypto_memneq(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE)) {
>  		dev_err(&chip->dev, "TPM: HMAC check failed\n");
>  		goto out;
>  	}
>  	rc = 0;
> -- 
> 2.50.1
> 

This good stuff, thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

