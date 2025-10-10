Return-Path: <linux-integrity+bounces-7414-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC094BCDC15
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DAC500A23
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5B2F8BC0;
	Fri, 10 Oct 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BybgFjSK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97112EF673;
	Fri, 10 Oct 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109149; cv=none; b=jBgBHg1Et7UgtSGP+kqIiS0OCCD0RIBZhrSr2aMCzsfKA7GvjB11NupARWnRH93vmFKLL9lP1Np90OmRJBY6pCcO+tqSRIWLIcENfXCR0Ky9d0VfXSQJ7uQZ/Nq9luC/2PECKlAp93GK/4Zpk56nKJVvriBQFI0UnZA9+ATAl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109149; c=relaxed/simple;
	bh=yshfDsTOOWK6gqSvXr7KOoCHt5sbdAxuEqM16sfOhz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9a+zcXkcAN+XyD9p13pGx2MWj/GXTlsu2yNQxftMGId8DxljPJlGm1vxkKmxVfx+oVdTk6NIZ7dBeu2S7HTChWRCUVBvvMpUkrEm6x3HnI4ijZDKVE0nyFNffqhjbgBoXXYcrOgS9QPw0ZSoFlCfS615OmemVVL2vljjRh7SjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BybgFjSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D2BC4CEF1;
	Fri, 10 Oct 2025 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760109148;
	bh=yshfDsTOOWK6gqSvXr7KOoCHt5sbdAxuEqM16sfOhz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BybgFjSK9i2YumvD5/RNEp3khQ03alvRBzSCVbrUtEV4j/CqANuE382VIvazr/lOI
	 ad+sK3RK8Sk16oDu4VfPbTI338ejwx3JuR7U/dor2EP5+iIPxcboDxbpwirjUtLyy8
	 CwvdNBo7pk58CXG3fYve9+buYvQsfROYyIC1buxDBxzXlPdC7Y8F6bviKM/GWiGc8H
	 G9aE3urx2neadGQ9szCxNuvZ6ajdJcr9f3gnt4YQmwOpju7wzvMYWLP2+fKNwDpRlN
	 LBYveurSldBOIQFRFywYLchHnUc7KGenEM1lJr8YbTxrrfynFbMt149/XC2FtOzrid
	 zd7aneQXB5KQw==
Date: Fri, 10 Oct 2025 08:12:28 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
Message-ID: <202510100808.E634CF9@keescook>
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

Remember for strncpy->strscpy conversions, the commit message needs
to include:

- how did you determine this was a NUL-terminated destination?
- how did you determine the need for padding or not?
- how do you know that final byte truncation is not a problem?

-Kees

> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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
> 

-- 
Kees Cook

