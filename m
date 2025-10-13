Return-Path: <linux-integrity+bounces-7428-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD2BD5260
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Oct 2025 18:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1713ACF59
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Oct 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8F2EC540;
	Mon, 13 Oct 2025 16:12:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3A2E7F1C;
	Mon, 13 Oct 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371961; cv=none; b=EDrRvuXiARTMkNY+EX9WOZYQoYDaUSEGn/yRzSM8kif3wIgfKGOD7PGCzYqvgcL2kKvA1x0vT4O7JC3fjVdTXkM1k8lBD6U2+HHwK3y3ow7JAk+LOgf262dYBo9XEVhGAcROZA/FZwsqsLaYHQCypL+VGI+h87x019os26ZAsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371961; c=relaxed/simple;
	bh=PseHAGZYK1WKtHbtTtVXAxSraQA4gMJcLWscQyyUYJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyuH6BoMEd5/a+bGVzkRk1p/KHwTkoFGhRT7/1xiEmxcezh8wpeVey+aIhqy352c3/IIvovzId77BQK/7iOZz/MMiaYdjn5htgR1JyWO3RECVZObtpJWKbTrgDeey9M2N7fLzIi5B22YaueNuoNkOyzrP451qws+++Ei4Ivan6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.27.27.12] (unknown [195.37.142.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7E49C60288272;
	Mon, 13 Oct 2025 18:11:39 +0200 (CEST)
Message-ID: <b9246396-c9d9-4452-a16c-f2c8166a32ee@molgen.mpg.de>
Date: Mon, 13 Oct 2025 18:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251013152627.98231-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251013152627.98231-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Thorsten,


Thank you for the patch.

Am 13.10.25 um 17:26 schrieb Thorsten Blum:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy_pad() instead to retain the NUL-padding behavior of strncpy().
> 
> The destination buffer is initialized using kzalloc() with a 'signature'
> size of ECRYPTFS_PASSWORD_SIG_SIZE + 1. strncpy() then copies up to
> ECRYPTFS_PASSWORD_SIG_SIZE bytes from 'key_desc', NUL-padding any
> remaining bytes if needed, but expects the last byte to be zero.
> 
> strscpy_pad() also copies the source string to 'signature', and NUL-pads
> the destination buffer if needed, but ensures it's always NUL-terminated
> without relying on it being zero-initialized.
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
> Link: https://github.com/KSPP/linux/issues/90
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v3:
> - Improve commit message
> - Link to v2: https://lore.kernel.org/lkml/20251010161340.458707-2-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Improve commit message as suggested by Jarkko and Kees
> - Link to v1: https://lore.kernel.org/lkml/20251009180316.394708-3-thorsten.blum@linux.dev/
> ---
>   security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/ecryptfs_format.c b/security/keys/encrypted-keys/ecryptfs_format.c
> index 8fdd76105ce3..2fc6f3a66135 100644
> --- a/security/keys/encrypted-keys/ecryptfs_format.c
> +++ b/security/keys/encrypted-keys/ecryptfs_format.c
> @@ -54,8 +54,7 @@ int ecryptfs_fill_auth_tok(struct ecryptfs_auth_tok *auth_tok,
>   	auth_tok->version = (((uint16_t)(major << 8) & 0xFF00)
>   			     | ((uint16_t)minor & 0x00FF));
>   	auth_tok->token_type = ECRYPTFS_PASSWORD;
> -	strncpy((char *)auth_tok->token.password.signature, key_desc,
> -		ECRYPTFS_PASSWORD_SIG_SIZE);
> +	strscpy_pad(auth_tok->token.password.signature, key_desc);
>   	auth_tok->token.password.session_key_encryption_key_bytes =
>   		ECRYPTFS_MAX_KEY_BYTES;
>   	/*

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

