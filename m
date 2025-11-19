Return-Path: <linux-integrity+bounces-7630-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141CC6C737
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 03:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B40BB2C7CE
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B42C21EB;
	Wed, 19 Nov 2025 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMP3ulAN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C282E40E;
	Wed, 19 Nov 2025 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520665; cv=none; b=Z12NQ+pqq3Hs4oRvjdx1JRgLJxmzsrVe/H/Dcgznhv+BjdtdfoqK4L30GJJSlpD0zDfYcZtsjue0LpzylGPO9eiYNQUF7FfC+KVs6KPcp+QgI3W7C5EJxfKARcRECqACJXWOTvX4JX1EwZJcLDTnv/UpuB7hGQxlMEGjR8yl3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520665; c=relaxed/simple;
	bh=Wy4oL0RSwFP36VLLS31XHtKQYALbzZ85Nsp3k06TuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyVonjFYryoFY4guUAeHcDePxQrLZW5H0j1g91NDAjiOVvaBp3gYaJLFQD/WI4XgGEzzNPcXQ/m4WQlTFmpnqfuEz+bfQOR2BxZMuX/BUO0O/SmF389uz+CAWRSN4tyhP9PvItuYF/GtkYGlhGbPct4oi+cIrEQDCQ1ZkOgVntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMP3ulAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29044C4AF0E;
	Wed, 19 Nov 2025 02:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520662;
	bh=Wy4oL0RSwFP36VLLS31XHtKQYALbzZ85Nsp3k06TuKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMP3ulANd5EHf2LuJSpXoRPIvIEs2HSlbbihagkdj7PU/iJ7GqnBAsAopqhBUqlrk
	 HSzMRnbd1YO/58AUMxAKNC9AJQOZfxHT62iN5uHU0vEGtC7OVHCZ67vUIDyPBF0Pk+
	 lIQWiHIRHiC5YC7Mcx2NyhzdXSXAcg9mcAHwSZKEANPH7G28O84MeKruNUX5GXiOX0
	 b4XyTd7gjT3EHFSJyrUj4BbAeVmmugDYNoAfWTKvfGH/p31PANkJYjm8qtPCjhlVbU
	 8PzYOh2upudLPheQZ49l6vCdfB0TjRzttlO9hJHq+ka2WvpQH4agI8tzmd3/0bNJAw
	 5EWGX+c5y8Yzg==
Date: Wed, 19 Nov 2025 04:50:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Replace deprecated strcpy and improve
 get_derived_key
Message-ID: <aR0wj6U4ywTIuA9C@kernel.org>
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

Who is "we"?

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
> -- 
> 2.51.1
> 

I don't see much value in this other than potentially causing merge
conflicts when backporting bug fixes.

BR, Jarkko

