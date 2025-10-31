Return-Path: <linux-integrity+bounces-7553-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE3C26E5A
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 21:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D91A21790
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F532143A;
	Fri, 31 Oct 2025 20:32:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F85217705;
	Fri, 31 Oct 2025 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942774; cv=none; b=r0g47GlWgcZzU1J07Y2vmZGlP9/OWLltNMjLyXPjmxooUDi4o8ZWHibmYPfoHkuWf+PH2YM5qcvnrH9qV0yGn9P4g2ljoxJXYjmhFFUt/z0fDC3Q6ilmLWkI2PDLMlCQeQxFfn4DxISy2YV+hIofbMiIOhQSpr0AtRMhN7qFrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942774; c=relaxed/simple;
	bh=5LMqHgFEj48Y8DAhiLwwyeUDoOrPGL1b1qdwSp3Rx4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cugRWdtccYa/313e3U0nTNO+qwFzSZfk6PqE+VZwQfUoXjEe74P9LwhbiNn3VA8fjNynA80mPY+NtjlCpdPl1DKbjeQDgb8T6j44/D1skWOcrY+/l8L6nZ4U9De47KHL9lzAb1EMuF5cr9AoWjxRADDX2+L8wRVJtZWul3GbPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 743D93F4; Fri, 31 Oct 2025 15:32:48 -0500 (CDT)
Date: Fri, 31 Oct 2025 15:32:48 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Return early on allocation failure and
 drop goto
Message-ID: <aQUc8ALBiOhX5twQ@mail.hallyn.com>
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

It seems like purely personal preference, but I don't see any
error in it, so in that sense

Reviewed-by: Serge Hallyn <serge@hallyn.com>


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

