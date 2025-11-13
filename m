Return-Path: <linux-integrity+bounces-7622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C0C59690
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Nov 2025 19:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 826A84F5D8E
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Nov 2025 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E74345739;
	Thu, 13 Nov 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyi5+fc+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2D2FA0C4;
	Thu, 13 Nov 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055057; cv=none; b=N0F/tByQR3ksarG+RI3OS+Y2rkKvuvFKbJkPXanIith2q4FEsoMwFkXE1/puyEkwkQoen7K/eAalzNDoqRDqnSgTbk2qTlb9GITT8o9RrfN+4TYGKxJ1fJGnZxB5OtbNKBzfrggUm9kzb8hwHQne2+BIcU4+dUXfFyV0nV1YbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055057; c=relaxed/simple;
	bh=PSAcgH99gxR7A5UNlppjaKsWHZKgViekHSz7cswxaJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1bklRNryRIt0npJaiXnEYTKU8bu/vzryCkv5w3B1trLFyVTulvQyWHpV29gL1PmSg27QqhXDrjfqqu7n1t7lj4S+T+l37MmoiFom+pkygdT+HQX5zGlqrdp49fywXIxJTsZrbZcJh+zWOe+3UktGahFUUeZTa5GJw7Zo3XcdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyi5+fc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2846EC4CEF1;
	Thu, 13 Nov 2025 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763055055;
	bh=PSAcgH99gxR7A5UNlppjaKsWHZKgViekHSz7cswxaJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hyi5+fc+cA/1b/U/yU1iLGnaufMCFNBEPCLg3Gnrln2Rf2C83n59Cr8+kWxp9/lwe
	 +oJi7gELENEdzfBk76DMKuN/DkfrLhoKjf2A9NfHQROKAnAfuiSXi5SrgilOjHlIPv
	 KyrBlfHKQN7pFlKU4dBTdbxJD/oTrh80p0FQVY2LP457YA1b0J9Y6i9KjEKfvtR5Lo
	 pV2RGJeqv1NJtCRKztA7LK4/dTQC9Yj1bp34NBue4YUVV2AE+7yOQqULOO92yhofyx
	 SnzfDA6wfv9ugBTtrtdsb4G6JvQ9TyRF+YrZpSFg8U83G1BeWjqgKC0zoDnF6lgj3F
	 qhh+LtSfMQIbA==
Date: Thu, 13 Nov 2025 09:29:13 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Replace deprecated strcpy and improve
 get_derived_key
Message-ID: <20251113172913.GC1792@sol>
References: <20251113135831.98587-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113135831.98587-1-thorsten.blum@linux.dev>

On Thu, Nov 13, 2025 at 02:58:31PM +0100, Thorsten Blum wrote:
> Determine 'key_name' before allocating memory for 'derived_buf' to only
> allocate as many bytes as needed. Currently, we potentially allocate one
> more byte than necessary when 'key_name' is "ENC_KEY".
> 
> strcpy() is deprecated and uses an additional strlen() internally; use
> memcpy() directly to copy 'key_name' since we already know its length
> and that it is guaranteed to be NUL-terminated.
> 
> Also reuse 'key_name_len' when copying 'master_key' instead of calling
> strlen() again.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/keys/encrypted-keys/encrypted.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 15841466b5d4..b16a5b8b935b 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/uaccess.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -330,23 +331,18 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
>  			   const u8 *master_key, size_t master_keylen)
>  {
>  	u8 *derived_buf;
> -	unsigned int derived_buf_len;
> -
> -	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
> -	if (derived_buf_len < HASH_SIZE)
> -		derived_buf_len = HASH_SIZE;
> +	size_t derived_buf_len;
> +	const char *key_name;
> +	size_t key_name_len;
>  
> +	key_name = key_type ? "AUTH_KEY" : "ENC_KEY";
> +	key_name_len = strlen(key_name) + 1;
> +	derived_buf_len = max(key_name_len + master_keylen, HASH_SIZE);
>  	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
>  	if (!derived_buf)
>  		return -ENOMEM;
> -
> -	if (key_type)
> -		strcpy(derived_buf, "AUTH_KEY");
> -	else
> -		strcpy(derived_buf, "ENC_KEY");
> -
> -	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
> -	       master_keylen);
> +	memcpy(derived_buf, key_name, key_name_len);
> +	memcpy(derived_buf + key_name_len, master_key, master_keylen);
>  	sha256(derived_buf, derived_buf_len, derived_key);
>  	kfree_sensitive(derived_buf);
>  	return 0;

This changes the resulting derived key when key_type == 0 &&
master_keylen >= 24, because different bytes are passed to sha256().

- Eric

