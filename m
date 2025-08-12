Return-Path: <linux-integrity+bounces-6800-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B28B22D8C
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15F73B2C75
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C072F28FB;
	Tue, 12 Aug 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Wmf/fH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F4156CA;
	Tue, 12 Aug 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015819; cv=none; b=vF6xPBtq0WoyN/gdQLI2ykL9n+Qq2fgLzW602FzF8gCUIUQZC9WRQPsigjq7wDg8gOTj5aBEAnduwTNWFe8l9+0lkrXy5uRFacxep9TiLUXo3x05vnxXVuILYO0NMWc94A1WXWSL6R/sNOCUX8i6l66H0wbHG0S7g3RUg7oLZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015819; c=relaxed/simple;
	bh=lmRgp0EyHFj1i0/G+1nfVYlPsnmB8OBbP4bbzk4jrf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRk5LXuoqapm0eQidMRmmyrfS/FmInyVuV+XrwdZDq7/Zv3bImGtOhg8yd3gibM9vb/QiHrV5vjteRYvOr+hJzsjSHrVrF7HaKf/UT4GxOV3/jwVUxs24olwtHCnhkOt0Phr0RClea7SFMKIKi883/cN6Atu6DXJpUF4iN68L7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Wmf/fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB17C4CEF6;
	Tue, 12 Aug 2025 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015819;
	bh=lmRgp0EyHFj1i0/G+1nfVYlPsnmB8OBbP4bbzk4jrf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/Wmf/fHAViTT5UG9sgOdKKl+440g8EzSCGoJRZBoDYYMxpvePPqcRw5b4f6KxPZe
	 wvQa/vrf43V7f7KWGWI8KcE7l1QV0DgEaNLFjjdpMXes9at3k5RQVMGcmieEEqgqCp
	 dAcQwf7V2IhDZXudlPZRxK/lo899nXLWnOtS0lIRgb5W+Xs6uKVDTyxvkv2EHQKGhx
	 ZvGnB6lCu8mB7rlA4trZaIN0IFgTttDdEgw5ncx0SvElFGXymIh9mThP+PS2O5+30P
	 BmehG2Z9wviyH7czVVem/Q0k3SI06o5rl+5dLVzGBfBFtlaRoc50J5m0XhbgJJuIso
	 1TIUv2dBx4Wvg==
Date: Tue, 12 Aug 2025 19:23:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KEYS: trusted_tpm1: Compare HMAC values in
 constant time
Message-ID: <aJtqhyWu83xaj8Kc@kernel.org>
References: <20250809171941.5497-1-ebiggers@kernel.org>
 <20250809171941.5497-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809171941.5497-2-ebiggers@kernel.org>

On Sat, Aug 09, 2025 at 10:19:39AM -0700, Eric Biggers wrote:
> To prevent timing attacks, HMAC value comparison needs to be constant
> time.  Replace the memcmp() with the correct function, crypto_memneq().
> 
> [For the Fixes commit I used the commit that introduced the memcmp().
> It predates the introduction of crypto_memneq(), but it was still a bug
> at the time even though a helper function didn't exist yet.]
> 
> Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 89c9798d18007..e73f2c6c817a0 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -5,10 +5,11 @@
>   *
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
>  
>  #include <crypto/hash_info.h>
> +#include <crypto/utils.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/parser.h>
>  #include <linux/string.h>
>  #include <linux/err.h>
> @@ -239,11 +240,11 @@ int TSS_checkhmac1(unsigned char *buffer,
>  			  TPM_NONCE_SIZE, enonce, TPM_NONCE_SIZE, ononce,
>  			  1, continueflag, 0, 0);
>  	if (ret < 0)
>  		goto out;
>  
> -	if (memcmp(testhmac, authdata, SHA1_DIGEST_SIZE))
> +	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
>  		ret = -EINVAL;
>  out:
>  	kfree_sensitive(sdesc);
>  	return ret;
>  }
> @@ -332,20 +333,20 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  	ret = TSS_rawhmac(testhmac1, key1, keylen1, SHA1_DIGEST_SIZE,
>  			  paramdigest, TPM_NONCE_SIZE, enonce1,
>  			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
>  	if (ret < 0)
>  		goto out;
> -	if (memcmp(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
> +	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  	ret = TSS_rawhmac(testhmac2, key2, keylen2, SHA1_DIGEST_SIZE,
>  			  paramdigest, TPM_NONCE_SIZE, enonce2,
>  			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
>  	if (ret < 0)
>  		goto out;
> -	if (memcmp(testhmac2, authdata2, SHA1_DIGEST_SIZE))
> +	if (crypto_memneq(testhmac2, authdata2, SHA1_DIGEST_SIZE))
>  		ret = -EINVAL;
>  out:
>  	kfree_sensitive(sdesc);
>  	return ret;
>  }
> -- 
> 2.50.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

