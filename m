Return-Path: <linux-integrity+bounces-7611-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D58C43884
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A4034E16A0
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA88635D;
	Sun,  9 Nov 2025 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv8ij+Ev"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239C63CB;
	Sun,  9 Nov 2025 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762663655; cv=none; b=rmjb6iQ8dZadoWxvMjPRUsxPDIxoleGKq2RA7SKciLeJu2+bkdLQquxN9t986KzrwplrgV6PMJy8WUjNgAifMdNn0BdiKdtEibhbfm83XRK/1rjLexQ+tJgLapSrOqzy+4MhCxnB3OCJgSoXRaDr/OWo0zotlA5rLpUaJzz67qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762663655; c=relaxed/simple;
	bh=B9jlCBHAJ5t3vBoTLKp821/0KC6K0HtxckeyhYi9LoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJU3jfGJjwzzNp5qSw7VcjkS2Gg2iEPvHlPlXfrCdc5RZ+6A0XnMFutNaBTQTi/88kwnIEChD7/uO7ZalacnW6Byr3UW2AfLYdTXZELYWW2wlXx/UvSPBjSISFVcRGt6ptA36v8TcrwHtGbRO1g8gIPCLUFSmWN2Z0n1AL/rKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv8ij+Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1185C4CEF8;
	Sun,  9 Nov 2025 04:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762663655;
	bh=B9jlCBHAJ5t3vBoTLKp821/0KC6K0HtxckeyhYi9LoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pv8ij+EvmsIU6KCyBkWCgnipJMJHRyCIRgiN7geXVCGJEjAF2CT4aQO6ECqq1broz
	 UNwj3V6vJ8/pyBs4yrlKrssPf+WCP8x1xu+Iwz8CtdQTEi9doV4ptoHSfgOoS/Io9q
	 Z4T99BxTMVX44+Jy+w6UquTiAM22n8GqLrJkg2cvWYQy6O5MREJSNHk6cFz2s/xD6p
	 t57RCYChuApeL7hp8Hb8fE34IRG6ICWTseOM2CalQKTRma5RMYZimu8AlBkOJlbYGl
	 slzAjo4b6NvacRAGGk25+p/6hDx70nb/OEf1bm1T7i/F0z7dWVqIndivs7BFGqAvA6
	 keoQIA9XcwkXQ==
Date: Sun, 9 Nov 2025 06:47:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Return early on allocation failure and
 drop goto
Message-ID: <aRAc4_efa2gGcBQE@kernel.org>
References: <20251029163157.119000-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163157.119000-1-thorsten.blum@linux.dev>

On Wed, Oct 29, 2025 at 05:31:56PM +0100, Thorsten Blum wrote:
> Return ERR_PTR(-ENOMEM) immediately if memory allocation fails, instead
> of using goto and returning a NULL pointer, and remove the now-unused
> 'out' label.
> 
> At the call site, check 'ascii_buf' with IS_ERR() and propagate the
> error code returned by datablob_format().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/keys/encrypted-keys/encrypted.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index be1f2118447c..25df00b7dbe9 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -276,7 +276,7 @@ static char *datablob_format(struct encrypted_key_payload *epayload,
>  
>  	ascii_buf = kmalloc(asciiblob_len + 1, GFP_KERNEL);
>  	if (!ascii_buf)
> -		goto out;
> +		return ERR_PTR(-ENOMEM);
>  
>  	ascii_buf[asciiblob_len] = '\0';
>  
> @@ -288,7 +288,6 @@ static char *datablob_format(struct encrypted_key_payload *epayload,
>  	bufp = &ascii_buf[len];
>  	for (i = 0; i < (asciiblob_len - len) / 2; i++)
>  		bufp = hex_byte_pack(bufp, iv[i]);
> -out:
>  	return ascii_buf;
>  }
>  
> @@ -932,8 +931,8 @@ static long encrypted_read(const struct key *key, char *buffer,
>  		goto out;
>  
>  	ascii_buf = datablob_format(epayload, asciiblob_len);
> -	if (!ascii_buf) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(ascii_buf)) {
> +		ret = PTR_ERR(ascii_buf);
>  		goto out;
>  	}
>  
> -- 
> 2.51.0
> 

No thank you as this does not really fix anything.

BR, Jarkko

