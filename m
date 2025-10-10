Return-Path: <linux-integrity+bounces-7420-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE89BCE20C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 19:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D5B3AEFE3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DB22652D;
	Fri, 10 Oct 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+LfjjeS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F94A02;
	Fri, 10 Oct 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118268; cv=none; b=EC+3l0KO+CyxNRxxs71ZaMdH5B4CqBn1pnpqIa+SYXGCJGRZRDx3WEbysAVcIohdxA01MIU7mppFby0zzHXzDmz+nL+AGBSxCplJ22HXjSbEM88Lcm3h6bCutlYMqqKSfdqz0s4Vw9SQIOiIlwEfhSq/Spf9k+UBeh/guj23KQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118268; c=relaxed/simple;
	bh=3PeR2izhMa19wiqx88PVC2lv0vrPdYQcJNh0la8Hf1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjpXBf2hUeWoGs7JwY5uvFfee8N2NGcSqz1oKepCWKX9qVDxm7A9GsNHs6Zp0c/gqj3cr20YPSa3EKOP6oVp1c+QY1Yp+vgmbdcu6u7c7PTaDOv6LFNYEwWEBmew8ELZxbAKk7wpr1xcIF0nH+MpUht7U08gFRgip1MAakIiDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+LfjjeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C661C4CEF5;
	Fri, 10 Oct 2025 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760118267;
	bh=3PeR2izhMa19wiqx88PVC2lv0vrPdYQcJNh0la8Hf1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+LfjjeSXdzVsa69Sw4hWqSZ3L2zHz2QTYvUcjz3hdzudl7yyvUGYLlnqQ0vklJsR
	 fkuNrkfvhZcUJj5qKasiRKZ0v8TNA3bkDGqNM3i7FvzoVpERfUbSW2Db6BzuG0FoXi
	 QLdY9KI8Yt27jeVKfH2LYOfSrzLtOKsgjfpqYG7Syh/qDhEcv1zRpu/oMMtK/LBE4j
	 kbijnuQXLQSzJCRByowVYdLepQkbQgX90QDWTiAeB8Wb5XxRmORmB0hcCpHSESl+zl
	 QpyAIdHFeyfkiuVds66D6A81XQ3L+QJP85QpkZn02GnFV4IfPSwRJ0jJ9jVT/QZRhH
	 t+DdcuXCos/cQ==
Date: Fri, 10 Oct 2025 20:44:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
Message-ID: <aOlF-FPoLVqmo1qS@kernel.org>
References: <20251010161340.458707-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010161340.458707-2-thorsten.blum@linux.dev>

On Fri, Oct 10, 2025 at 06:13:41PM +0200, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy_pad() instead to retain the zero-padding behavior of strncpy().
> 
> strscpy_pad() automatically determines the size of the fixed-length
> destination buffer via sizeof() when the optional size argument is
> omitted, making an explicit size unnecessary.
> 
> In encrypted_init(), the source string 'key_desc' is validated by
> valid_ecryptfs_desc() before calling ecryptfs_fill_auth_tok(), and is
> therefore NUL-terminated and satisfies the __must_be_cstr() requirement
> of strscpy_pad().
> 
> No functional changes.

It's a functional change (for better!) because it transforms to safer
semantics ;-) And yeah as years pass by commit messages like these
have more value than code changes themselves (as far backtracking
and bisecting is concerned).

So if you don't mind, I'll delete the very last one sentence paragraph,
and with that

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Improve commit message as suggested by Jarkko and Kees
> - Link to v1: https://lore.kernel.org/lkml/20251009180316.394708-3-thorsten.blum@linux.dev/
> ---
>  security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
> index 8fdd76105ce3..2fc6f3a66135 100644
> --- a/security/keys/encrypted-keys/ecryptfs_format.c
> +++ b/security/keys/encrypted-keys/ecryptfs_format.c
> @@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
>  	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
>  			     | ((uint16_t)minor & 0x00FF));
>  	auth_tok->token_type = ECRYPTFS_PASSWORD;
> -	strncpy((char *)auth_tok->token.password.signature, key_desc,
> -		ECRYPTFS_PASSWORD_SIG_SIZE);
> +	strscpy_pad(auth_tok->token.password.signature, key_desc);
>  	auth_tok->token.password.session_key_encryption_key_bytes =
>  		ECRYPTFS_MAX_KEY_BYTES;
>  	/*
> -- 
> 2.51.0
> 

BR, Jarkko

