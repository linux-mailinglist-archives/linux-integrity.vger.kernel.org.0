Return-Path: <linux-integrity+bounces-6777-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598DB1B52B
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531EE18324B
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBE274FEB;
	Tue,  5 Aug 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5qLHjIA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A319AD5C;
	Tue,  5 Aug 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401471; cv=none; b=Y7oQgalhQVq50PinfzGDcDL5ltPVkhxAe4bHkf8O3bwhx4TbaunqsahSJAqV+lGtQn72LVlV7oYEeMJOD72CxKys0mhgw1zTAXtu7e3Ej1BwyFMQdQjJ/C3v1Omfx/NkS9fE9G5lcqLzctyBSLC7UQJxcXtwKV8QWZMUk5nYZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401471; c=relaxed/simple;
	bh=Tgfc5N5x4IALIXfPpF8RYrr8YlZcr/jNVW7vUdrC7KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfj5DgFkVjXQwSvV2Lf3adqgyC+h3jIAxBsLWkxi3SWWhrR8s+L/d5LuSUv+qaHiX3DStFR5LZzF1PrfUumjNufTq9efGyhhj4hXbRvb0eCUsJQAy13n0To9nF1HgR2cDUI6foZP+uGigd7Gt7auRqpFLFRIBxydT20QaH3PH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5qLHjIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC59C4CEF0;
	Tue,  5 Aug 2025 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754401471;
	bh=Tgfc5N5x4IALIXfPpF8RYrr8YlZcr/jNVW7vUdrC7KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5qLHjIAWWYNh0blUwbyxBS2VUwWqYi59h0nIJiaKbPOOLclO7BlnsmB/ZLZf+NK8
	 jG8+8YJPlDSzkMeH3yqMeBEUxZErDPsvP0G1eJ8p1pNkSWnzJOg/3P5WNgC0lWhOW8
	 6b2yHS75fF00hkmD19DxOa4D9UshuPOEdpGQVfqQgam9p7Ep6QWRxUCSJO4NcycgBX
	 sgaZc1T33ePPiudQmFI096c1givrQnBxRYLkXrVjM6nm8Jt5Tg1xdGjbE+4LJCIoPB
	 Do3LIXP/lSj72gW8OX85xG6ty0WomfJz/H1sJg8CUQ9Nne4wPBF/dUZAFM8Tdpr3/Z
	 r1BkMfuE2Cf9g==
Date: Tue, 5 Aug 2025 16:44:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KEYS: trusted_tpm1: Compare HMAC values in constant
 time
Message-ID: <aJIKu7uD-nYQERKW@kernel.org>
References: <20250731212354.105044-1-ebiggers@kernel.org>
 <20250731212354.105044-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731212354.105044-2-ebiggers@kernel.org>

On Thu, Jul 31, 2025 at 02:23:52PM -0700, Eric Biggers wrote:
> To prevent timing attacks, HMAC value comparison needs to be constant
> time.  Replace the memcmp() with the correct function, crypto_memneq().
> 
> Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Was crypto_memneq() available at the time?

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
> 
> base-commit: d6084bb815c453de27af8071a23163a711586a6c
> -- 
> 2.50.1
> 

BR, Jarkko

