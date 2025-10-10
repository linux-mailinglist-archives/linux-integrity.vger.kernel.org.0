Return-Path: <linux-integrity+bounces-7403-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40522BCB918
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 05:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB793AB2DD
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9926A1CF;
	Fri, 10 Oct 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn5OGqv1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D93D76;
	Fri, 10 Oct 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067631; cv=none; b=pwphrA1Alq+QBTdb/HlYXznZarMvN45CaeC1eIUlwx6UUPLnPyGBJWbvsWdpWfaeMdb4rHffBYKYedK4Fy+ORxwpNyI4+PoCMbegOUM30o/Y/Ojjfer7U8fYmcho26lY2YeCijLuxVCXuqQSFS8EjyP8ZZIRiTh7hCJdIfH5cz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067631; c=relaxed/simple;
	bh=DGLG8ilbr8Yy86vDLTSHOB1NuH2rRWTQ/kLDD7HnNDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXxO/P/AKmFxzQ04p+M4TiRd2Dr+IHca2xsKccxObwK49Gk3ZLTw1I6TjkfmRXPq0VeGaeeMdGqVWGoQUuBb4aCaHg27edp/a3VKvz4kQ05IyZww4YR5VqUqJKPZAH2nL7n9dDQPJu/zX/aFXWQxCUUaWl5OREG4zIue0VQngbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn5OGqv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BDBC4CEF1;
	Fri, 10 Oct 2025 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760067630;
	bh=DGLG8ilbr8Yy86vDLTSHOB1NuH2rRWTQ/kLDD7HnNDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mn5OGqv1oclS2jPcCTRtHn90eB57biWAwc4PVlfHgjmcr8DsYELczx/8QBTLIxKCq
	 UXIGEErGpn30GGHOFfJ5N8eipHgNeoejih3rpsXSt6MiE1XaXzCKscarvyuI1ujm/M
	 jzRVJ46ZSiMILCl00YSELHsXbDvLDx4o7fE9jUcXCyzFKwnp25szNiQzyXqCZplvwq
	 jW+j4ITdPHzyA47WC34b16PdiaAnFcz+v0sPVtnYrM7AwXBtcQ63vKw18V2L8laXVT
	 zyi+uBCpgijDOAbXwTZbcnVj37CgYQ/SRagVBj2ElNaruoBzrPsel8ntExgNvr3O7V
	 dpPkOin9DN9ew==
Date: Fri, 10 Oct 2025 06:40:26 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
Message-ID: <aOiAKoMiGG4LdoC2@kernel.org>
References: <20251009180316.394708-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009180316.394708-3-thorsten.blum@linux.dev>

On Thu, Oct 09, 2025 at 08:03:17PM +0200, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy_pad() instead.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Deprecated or not but commit message still should have a better
explanation :-) Sure there's also the link too that explains it 
all but still one should get the gist without cross-referencing
into it.

It's a permanent amortized cost as everytime when revisiting this
commit (e.g. over the course of bisecting or whatever), you need
a web browser in order to make anything out of the message.

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

