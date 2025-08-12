Return-Path: <linux-integrity+bounces-6801-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E4B22DA5
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915FF623E6C
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436512FA0D6;
	Tue, 12 Aug 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPi4BRwp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16079285047;
	Tue, 12 Aug 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015845; cv=none; b=rFDFxL4Ql9FOlB0HNFtD11zUBxeZayTE53622OZ+IOpudwNYkCi0U8NasS6NNXGDiU5seva0UP/NVxz4tDriMOQJf4fxzb1IhgJ5vZvfH+w1auPgyXQ7GeTasBpRlPZkvf5ZsabS2bcQwU6uOozXMKiciwNq4shfew4P8mE7l54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015845; c=relaxed/simple;
	bh=sjWIZaIQirdx+chRXAITR0eGRY3uZYx/zqRf9REyFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3d9GMlkgL6IRDB/h/c4Tu8yAPhLHgLS0RcARLCxaaZS3ELfck0RW6wnSiqQ8MEiPP/UzNt3K+tHInCBzQ3G48pMtYLy0r1kQ1PIJxCbCJRjsD97T5RSF/YOc3sWjpYz8ZpZg020SpDiWPncxH35FGSUk9GcBLhuZfgVcFvtH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPi4BRwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56685C4CEF1;
	Tue, 12 Aug 2025 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015844;
	bh=sjWIZaIQirdx+chRXAITR0eGRY3uZYx/zqRf9REyFa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPi4BRwpgMybItBMbl1mxxMANBxyg+PNo9oFxlpl4qrFFto9BtTIaOT9qC7WUngAX
	 rTZ7FxRpgtzjaHvS6dgfBKyqC9okoHGDyltKDHnWZJ3m/PFHePspZoTd27hB0uPok4
	 2CDimceyOyg7kiPMOoRNR8rjvUlD6HigGgzChiNbP0/Mlcd3f4hHjD4CiznyKMlsw5
	 BAulChug/NrQGoHJBwpX/S1sQD6c5LCaAVfSRpXg5DXv2eBByii4sMXllSwWVI2AH+
	 Q3Y3CzKHICsPCXX8UsoHdEhHh1br3rKo4ALH8/y6UsdwcKIzkPRoCnlHVD3zGtM/6t
	 FqQ2Ep7VuJnCA==
Date: Tue, 12 Aug 2025 19:24:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KEYS: trusted_tpm1: Use SHA-1 library instead of
 crypto_shash
Message-ID: <aJtqoNlQcdEFj1Xy@kernel.org>
References: <20250809171941.5497-1-ebiggers@kernel.org>
 <20250809171941.5497-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809171941.5497-3-ebiggers@kernel.org>

On Sat, Aug 09, 2025 at 10:19:40AM -0700, Eric Biggers wrote:
> Use the SHA-1 and HMAC-SHA1 library functions instead of crypto_shash.
> This is simpler and faster.
> 
> Replace the selection of CRYPTO, CRYPTO_HMAC, and CRYPTO_SHA1 with
> CRYPTO_LIB_SHA1 and CRYPTO_LIB_UTILS.  The latter is needed for
> crypto_memneq() which was previously being pulled in via CRYPTO.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  security/keys/trusted-keys/Kconfig        |   5 +-
>  security/keys/trusted-keys/trusted_tpm1.c | 221 ++++------------------
>  2 files changed, 36 insertions(+), 190 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
> index 1fb8aa0019953..204a68c1429df 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -3,14 +3,13 @@ config HAVE_TRUSTED_KEYS
>  
>  config TRUSTED_KEYS_TPM
>  	bool "TPM-based trusted keys"
>  	depends on TCG_TPM >= TRUSTED_KEYS
>  	default y
> -	select CRYPTO
> -	select CRYPTO_HMAC
> -	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
> +	select CRYPTO_LIB_SHA1
> +	select CRYPTO_LIB_UTILS
>  	select ASN1_ENCODER
>  	select OID_REGISTRY
>  	select ASN1
>  	select HAVE_TRUSTED_KEYS
>  	help
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index e73f2c6c817a0..126437459a74d 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -5,90 +5,37 @@
>   *
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
>  
>  #include <crypto/hash_info.h>
> +#include <crypto/sha1.h>
>  #include <crypto/utils.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/parser.h>
>  #include <linux/string.h>
>  #include <linux/err.h>
>  #include <keys/trusted-type.h>
>  #include <linux/key-type.h>
> -#include <linux/crypto.h>
> -#include <crypto/hash.h>
> -#include <crypto/sha1.h>
>  #include <linux/tpm.h>
>  #include <linux/tpm_command.h>
>  
>  #include <keys/trusted_tpm.h>
>  
> -static const char hmac_alg[] = "hmac(sha1)";
> -static const char hash_alg[] = "sha1";
>  static struct tpm_chip *chip;
>  static struct tpm_digest *digests;
>  
> -struct sdesc {
> -	struct shash_desc shash;
> -	char ctx[];
> -};
> -
> -static struct crypto_shash *hashalg;
> -static struct crypto_shash *hmacalg;
> -
> -static struct sdesc *init_sdesc(struct crypto_shash *alg)
> -{
> -	struct sdesc *sdesc;
> -	int size;
> -
> -	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
> -	sdesc = kmalloc(size, GFP_KERNEL);
> -	if (!sdesc)
> -		return ERR_PTR(-ENOMEM);
> -	sdesc->shash.tfm = alg;
> -	return sdesc;
> -}
> -
> -static int TSS_sha1(const unsigned char *data, unsigned int datalen,
> -		    unsigned char *digest)
> -{
> -	struct sdesc *sdesc;
> -	int ret;
> -
> -	sdesc = init_sdesc(hashalg);
> -	if (IS_ERR(sdesc)) {
> -		pr_info("can't alloc %s\n", hash_alg);
> -		return PTR_ERR(sdesc);
> -	}
> -
> -	ret = crypto_shash_digest(&sdesc->shash, data, datalen, digest);
> -	kfree_sensitive(sdesc);
> -	return ret;
> -}
> -
>  static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>  		       unsigned int keylen, ...)
>  {
> -	struct sdesc *sdesc;
> +	struct hmac_sha1_ctx hmac_ctx;
>  	va_list argp;
>  	unsigned int dlen;
>  	unsigned char *data;
> -	int ret;
> -
> -	sdesc = init_sdesc(hmacalg);
> -	if (IS_ERR(sdesc)) {
> -		pr_info("can't alloc %s\n", hmac_alg);
> -		return PTR_ERR(sdesc);
> -	}
> +	int ret = 0;
>  
> -	ret = crypto_shash_setkey(hmacalg, key, keylen);
> -	if (ret < 0)
> -		goto out;
> -	ret = crypto_shash_init(&sdesc->shash);
> -	if (ret < 0)
> -		goto out;
> +	hmac_sha1_init_usingrawkey(&hmac_ctx, key, keylen);
>  
>  	va_start(argp, keylen);
>  	for (;;) {
>  		dlen = va_arg(argp, unsigned int);
>  		if (dlen == 0)
> @@ -96,19 +43,15 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>  		data = va_arg(argp, unsigned char *);
>  		if (data == NULL) {
>  			ret = -EINVAL;
>  			break;
>  		}
> -		ret = crypto_shash_update(&sdesc->shash, data, dlen);
> -		if (ret < 0)
> -			break;
> +		hmac_sha1_update(&hmac_ctx, data, dlen);
>  	}
>  	va_end(argp);
>  	if (!ret)
> -		ret = crypto_shash_final(&sdesc->shash, digest);
> -out:
> -	kfree_sensitive(sdesc);
> +		hmac_sha1_final(&hmac_ctx, digest);
>  	return ret;
>  }
>  
>  /*
>   * calculate authorization info fields to send to TPM
> @@ -116,53 +59,41 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>  int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  			unsigned int keylen, unsigned char *h1,
>  			unsigned char *h2, unsigned int h3, ...)
>  {
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
> -	struct sdesc *sdesc;
> +	struct sha1_ctx sha_ctx;
>  	unsigned int dlen;
>  	unsigned char *data;
>  	unsigned char c;
> -	int ret;
> +	int ret = 0;
>  	va_list argp;
>  
>  	if (!chip)
>  		return -ENODEV;
>  
> -	sdesc = init_sdesc(hashalg);
> -	if (IS_ERR(sdesc)) {
> -		pr_info("can't alloc %s\n", hash_alg);
> -		return PTR_ERR(sdesc);
> -	}
> -
>  	c = !!h3;
> -	ret = crypto_shash_init(&sdesc->shash);
> -	if (ret < 0)
> -		goto out;
> +	sha1_init(&sha_ctx);
>  	va_start(argp, h3);
>  	for (;;) {
>  		dlen = va_arg(argp, unsigned int);
>  		if (dlen == 0)
>  			break;
>  		data = va_arg(argp, unsigned char *);
>  		if (!data) {
>  			ret = -EINVAL;
>  			break;
>  		}
> -		ret = crypto_shash_update(&sdesc->shash, data, dlen);
> -		if (ret < 0)
> -			break;
> +		sha1_update(&sha_ctx, data, dlen);
>  	}
>  	va_end(argp);
>  	if (!ret)
> -		ret = crypto_shash_final(&sdesc->shash, paramdigest);
> +		sha1_final(&sha_ctx, paramdigest);
>  	if (!ret)
>  		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
>  				  paramdigest, TPM_NONCE_SIZE, h1,
>  				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
> -out:
> -	kfree_sensitive(sdesc);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(TSS_authhmac);
>  
>  /*
> @@ -181,11 +112,11 @@ int TSS_checkhmac1(unsigned char *buffer,
>  	unsigned char *enonce;
>  	unsigned char *continueflag;
>  	unsigned char *authdata;
>  	unsigned char testhmac[SHA1_DIGEST_SIZE];
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
> -	struct sdesc *sdesc;
> +	struct sha1_ctx sha_ctx;
>  	unsigned int dlen;
>  	unsigned int dpos;
>  	va_list argp;
>  	int ret;
>  
> @@ -202,53 +133,33 @@ int TSS_checkhmac1(unsigned char *buffer,
>  		return -EINVAL;
>  	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
>  	continueflag = authdata - 1;
>  	enonce = continueflag - TPM_NONCE_SIZE;
>  
> -	sdesc = init_sdesc(hashalg);
> -	if (IS_ERR(sdesc)) {
> -		pr_info("can't alloc %s\n", hash_alg);
> -		return PTR_ERR(sdesc);
> -	}
> -	ret = crypto_shash_init(&sdesc->shash);
> -	if (ret < 0)
> -		goto out;
> -	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&result,
> -				  sizeof result);
> -	if (ret < 0)
> -		goto out;
> -	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&ordinal,
> -				  sizeof ordinal);
> -	if (ret < 0)
> -		goto out;
> +	sha1_init(&sha_ctx);
> +	sha1_update(&sha_ctx, (const u8 *)&result, sizeof(result));
> +	sha1_update(&sha_ctx, (const u8 *)&ordinal, sizeof(ordinal));
>  	va_start(argp, keylen);
>  	for (;;) {
>  		dlen = va_arg(argp, unsigned int);
>  		if (dlen == 0)
>  			break;
>  		dpos = va_arg(argp, unsigned int);
> -		ret = crypto_shash_update(&sdesc->shash, buffer + dpos, dlen);
> -		if (ret < 0)
> -			break;
> +		sha1_update(&sha_ctx, buffer + dpos, dlen);
>  	}
>  	va_end(argp);
> -	if (!ret)
> -		ret = crypto_shash_final(&sdesc->shash, paramdigest);
> -	if (ret < 0)
> -		goto out;
> +	sha1_final(&sha_ctx, paramdigest);
>  
>  	ret = TSS_rawhmac(testhmac, key, keylen, SHA1_DIGEST_SIZE, paramdigest,
>  			  TPM_NONCE_SIZE, enonce, TPM_NONCE_SIZE, ononce,
>  			  1, continueflag, 0, 0);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  
>  	if (crypto_memneq(testhmac, authdata, SHA1_DIGEST_SIZE))
> -		ret = -EINVAL;
> -out:
> -	kfree_sensitive(sdesc);
> -	return ret;
> +		return -EINVAL;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(TSS_checkhmac1);
>  
>  /*
>   * verify the AUTH2_COMMAND (unseal) result from TPM
> @@ -272,11 +183,11 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  	unsigned char *continueflag2;
>  	unsigned char *authdata2;
>  	unsigned char testhmac1[SHA1_DIGEST_SIZE];
>  	unsigned char testhmac2[SHA1_DIGEST_SIZE];
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
> -	struct sdesc *sdesc;
> +	struct sha1_ctx sha_ctx;
>  	unsigned int dlen;
>  	unsigned int dpos;
>  	va_list argp;
>  	int ret;
>  
> @@ -295,62 +206,40 @@ static int TSS_checkhmac2(unsigned char *buffer,
>  	continueflag1 = authdata1 - 1;
>  	continueflag2 = authdata2 - 1;
>  	enonce1 = continueflag1 - TPM_NONCE_SIZE;
>  	enonce2 = continueflag2 - TPM_NONCE_SIZE;
>  
> -	sdesc = init_sdesc(hashalg);
> -	if (IS_ERR(sdesc)) {
> -		pr_info("can't alloc %s\n", hash_alg);
> -		return PTR_ERR(sdesc);
> -	}
> -	ret = crypto_shash_init(&sdesc->shash);
> -	if (ret < 0)
> -		goto out;
> -	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&result,
> -				  sizeof result);
> -	if (ret < 0)
> -		goto out;
> -	ret = crypto_shash_update(&sdesc->shash, (const u8 *)&ordinal,
> -				  sizeof ordinal);
> -	if (ret < 0)
> -		goto out;
> +	sha1_init(&sha_ctx);
> +	sha1_update(&sha_ctx, (const u8 *)&result, sizeof(result));
> +	sha1_update(&sha_ctx, (const u8 *)&ordinal, sizeof(ordinal));
>  
>  	va_start(argp, keylen2);
>  	for (;;) {
>  		dlen = va_arg(argp, unsigned int);
>  		if (dlen == 0)
>  			break;
>  		dpos = va_arg(argp, unsigned int);
> -		ret = crypto_shash_update(&sdesc->shash, buffer + dpos, dlen);
> -		if (ret < 0)
> -			break;
> +		sha1_update(&sha_ctx, buffer + dpos, dlen);
>  	}
>  	va_end(argp);
> -	if (!ret)
> -		ret = crypto_shash_final(&sdesc->shash, paramdigest);
> -	if (ret < 0)
> -		goto out;
> +	sha1_final(&sha_ctx, paramdigest);
>  
>  	ret = TSS_rawhmac(testhmac1, key1, keylen1, SHA1_DIGEST_SIZE,
>  			  paramdigest, TPM_NONCE_SIZE, enonce1,
>  			  TPM_NONCE_SIZE, ononce, 1, continueflag1, 0, 0);
>  	if (ret < 0)
> -		goto out;
> -	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +		return ret;
> +	if (crypto_memneq(testhmac1, authdata1, SHA1_DIGEST_SIZE))
> +		return -EINVAL;
>  	ret = TSS_rawhmac(testhmac2, key2, keylen2, SHA1_DIGEST_SIZE,
>  			  paramdigest, TPM_NONCE_SIZE, enonce2,
>  			  TPM_NONCE_SIZE, ononce, 1, continueflag2, 0, 0);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  	if (crypto_memneq(testhmac2, authdata2, SHA1_DIGEST_SIZE))
> -		ret = -EINVAL;
> -out:
> -	kfree_sensitive(sdesc);
> -	return ret;
> +		return -EINVAL;
> +	return 0;
>  }
>  
>  /*
>   * For key specific tpm requests, we will generate and send our
>   * own TPM command packets using the drivers send function.
> @@ -497,13 +386,11 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	dump_sess(&sess);
>  
>  	/* calculate encrypted authorization value */
>  	memcpy(td->xorwork, sess.secret, SHA1_DIGEST_SIZE);
>  	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
> -	ret = TSS_sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
> -	if (ret < 0)
> -		goto out;
> +	sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
>  
>  	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -988,44 +875,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
>  {
>  	return tpm_get_random(chip, key, key_len);
>  }
>  
> -static void trusted_shash_release(void)
> -{
> -	if (hashalg)
> -		crypto_free_shash(hashalg);
> -	if (hmacalg)
> -		crypto_free_shash(hmacalg);
> -}
> -
> -static int __init trusted_shash_alloc(void)
> -{
> -	int ret;
> -
> -	hmacalg = crypto_alloc_shash(hmac_alg, 0, 0);
> -	if (IS_ERR(hmacalg)) {
> -		pr_info("could not allocate crypto %s\n",
> -			hmac_alg);
> -		return PTR_ERR(hmacalg);
> -	}
> -
> -	hashalg = crypto_alloc_shash(hash_alg, 0, 0);
> -	if (IS_ERR(hashalg)) {
> -		pr_info("could not allocate crypto %s\n",
> -			hash_alg);
> -		ret = PTR_ERR(hashalg);
> -		goto hashalg_fail;
> -	}
> -
> -	return 0;
> -
> -hashalg_fail:
> -	crypto_free_shash(hmacalg);
> -	return ret;
> -}
> -
>  static int __init init_digests(void)
>  {
>  	int i;
>  
>  	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
> @@ -1048,19 +901,14 @@ static int __init trusted_tpm_init(void)
>  		return -ENODEV;
>  
>  	ret = init_digests();
>  	if (ret < 0)
>  		goto err_put;
> -	ret = trusted_shash_alloc();
> -	if (ret < 0)
> -		goto err_free;
>  	ret = register_key_type(&key_type_trusted);
>  	if (ret < 0)
> -		goto err_release;
> +		goto err_free;
>  	return 0;
> -err_release:
> -	trusted_shash_release();
>  err_free:
>  	kfree(digests);
>  err_put:
>  	put_device(&chip->dev);
>  	return ret;
> @@ -1069,11 +917,10 @@ static int __init trusted_tpm_init(void)
>  static void trusted_tpm_exit(void)
>  {
>  	if (chip) {
>  		put_device(&chip->dev);
>  		kfree(digests);
> -		trusted_shash_release();
>  		unregister_key_type(&key_type_trusted);
>  	}
>  }
>  
>  struct trusted_key_ops trusted_key_tpm_ops = {
> -- 
> 2.50.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

