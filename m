Return-Path: <linux-integrity+bounces-7629-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D95ADC6C6EF
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 03:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD2134E80FD
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 02:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4A2C178E;
	Wed, 19 Nov 2025 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSsEGHwr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871B24A047;
	Wed, 19 Nov 2025 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520508; cv=none; b=IVpBCcFq7aUHmEkeZrv7lf1feIcMZXpIHKAM+01VpXE2nibMb08YryqeYjkRYOqEa+a9J1e1ax+5QQMwZz9k0NIuIkQxmUpBEhcYHBx1UxiJ1AEcmxCuWPH+5mW7tzqhn81yb9PPzLV6FCvmMfRoOjzofVHgUWNwimpMm7OkLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520508; c=relaxed/simple;
	bh=fJbfcDFIZMOAxZ9jmq3uLykowLh10BSvWGdV1bP1D8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri3F9AZE8tFbLVM+eOCQHOdTiYgNjSgnw6J4yhVfeORfbRTrhr2oiHy7tq0aX/+SzxXWq39pQemQZyojfzKSfUF4w+6jaepjExINlDxrijZVWisURvxcn9naH7v59RBVoWEJ/N7d3wS/2842scPYFNkKuBVVu6GhTpOxnBto+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSsEGHwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA4C19421;
	Wed, 19 Nov 2025 02:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520507;
	bh=fJbfcDFIZMOAxZ9jmq3uLykowLh10BSvWGdV1bP1D8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSsEGHwrDwL1WU4ejp3IOwBG3V7DhghdGu5zb3p+EWvnH94ypXDpkMv0b1QBzzQGW
	 pXrrCFup3ak0uiH0BUJ1OFLwAN7kgDJz9ImX2agSPvR8qwjIFqjz+gbU/rdgZiOG1G
	 n0P/ZY2A7mUxZGGdEbWl6GfB88nsQV19ujr0DuPgwZDPG6C+W+CQrRiNkvldmMNaRL
	 pMg6KLk7Al6RWTxbh8m4g0PASarskCOtfD42uiYR/EDWsQo8o6YXcgOzqEZWA2MbzJ
	 6kQEaRU6WRRIcNldWEdqEMggNaM0pQczFUWvaOoPvsvWWelp2SLKW+fxa2fd+ks2xE
	 uE0Z720KDFEAA==
Date: Wed, 19 Nov 2025 04:48:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Use pr_fmt()
Message-ID: <aR0v9mLOKJsr_0Zm@kernel.org>
References: <20251113123544.11287-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113123544.11287-2-thorsten.blum@linux.dev>

On Thu, Nov 13, 2025 at 01:35:44PM +0100, Thorsten Blum wrote:
> Use pr_fmt() to automatically prefix all pr_<level>() log messages with

This fails to describe what "use" means.

> "encrypted_key: " and remove all manually added prefixes.
> 
> Reformat the code accordingly and avoid line breaks in log messages.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/keys/encrypted-keys/encrypted.c | 74 +++++++++++-------------
>  security/keys/encrypted-keys/encrypted.h |  2 +-
>  2 files changed, 35 insertions(+), 41 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 513c09e2b01c..a8e8bf949b4b 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -11,6 +11,8 @@
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
>  

Should have undef prepending.

> +#define pr_fmt(fmt) "encrypted_key: " fmt
> +
>  #include <linux/uaccess.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -84,8 +86,7 @@ static int aes_get_sizes(void)
>  
>  	tfm = crypto_alloc_skcipher(blkcipher_alg, 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(tfm)) {
> -		pr_err("encrypted_key: failed to alloc_cipher (%ld)\n",
> -		       PTR_ERR(tfm));
> +		pr_err("failed to alloc_cipher (%ld)\n", PTR_ERR(tfm));
>  		return PTR_ERR(tfm);
>  	}
>  	ivsize = crypto_skcipher_ivsize(tfm);
> @@ -106,15 +107,14 @@ static int valid_ecryptfs_desc(const char *ecryptfs_desc)
>  	int i;
>  
>  	if (strlen(ecryptfs_desc) != KEY_ECRYPTFS_DESC_LEN) {
> -		pr_err("encrypted_key: key description must be %d hexadecimal "
> -		       "characters long\n", KEY_ECRYPTFS_DESC_LEN);
> +		pr_err("key description must be %d hexadecimal characters long\n",
> +		       KEY_ECRYPTFS_DESC_LEN);
>  		return -EINVAL;
>  	}
>  
>  	for (i = 0; i < KEY_ECRYPTFS_DESC_LEN; i++) {
>  		if (!isxdigit(ecryptfs_desc[i])) {
> -			pr_err("encrypted_key: key description must contain "
> -			       "only hexadecimal characters\n");
> +			pr_err("key description must contain only hexadecimal characters\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -180,7 +180,7 @@ static int datablob_parse(char *datablob, const char **format,
>  
>  	keyword = strsep(&datablob, " \t");
>  	if (!keyword) {
> -		pr_info("encrypted_key: insufficient parameters specified\n");
> +		pr_info("insufficient parameters specified\n");
>  		return ret;
>  	}
>  	key_cmd = match_token(keyword, key_tokens, args);
> @@ -188,7 +188,7 @@ static int datablob_parse(char *datablob, const char **format,
>  	/* Get optional format: default | ecryptfs */
>  	p = strsep(&datablob, " \t");
>  	if (!p) {
> -		pr_err("encrypted_key: insufficient parameters specified\n");
> +		pr_err("insufficient parameters specified\n");
>  		return ret;
>  	}
>  
> @@ -206,20 +206,20 @@ static int datablob_parse(char *datablob, const char **format,
>  	}
>  
>  	if (!*master_desc) {
> -		pr_info("encrypted_key: master key parameter is missing\n");
> +		pr_info("master key parameter is missing\n");
>  		goto out;
>  	}
>  
>  	if (valid_master_desc(*master_desc, NULL) < 0) {
> -		pr_info("encrypted_key: master key parameter \'%s\' "
> -			"is invalid\n", *master_desc);
> +		pr_info("master key parameter \'%s\' is invalid\n",
> +			*master_desc);
>  		goto out;
>  	}
>  
>  	if (decrypted_datalen) {
>  		*decrypted_datalen = strsep(&datablob, " \t");
>  		if (!*decrypted_datalen) {
> -			pr_info("encrypted_key: keylen parameter is missing\n");
> +			pr_info("keylen parameter is missing\n");
>  			goto out;
>  		}
>  	}
> @@ -227,8 +227,8 @@ static int datablob_parse(char *datablob, const char **format,
>  	switch (key_cmd) {
>  	case Opt_new:
>  		if (!decrypted_datalen) {
> -			pr_info("encrypted_key: keyword \'%s\' not allowed "
> -				"when called from .update method\n", keyword);
> +			pr_info("keyword \'%s\' not allowed when called from .update method\n",
> +				keyword);
>  			break;
>  		}
>  		*decrypted_data = strsep(&datablob, " \t");
> @@ -236,29 +236,27 @@ static int datablob_parse(char *datablob, const char **format,
>  		break;
>  	case Opt_load:
>  		if (!decrypted_datalen) {
> -			pr_info("encrypted_key: keyword \'%s\' not allowed "
> -				"when called from .update method\n", keyword);
> +			pr_info("keyword \'%s\' not allowed when called from .update method\n",
> +				keyword);
>  			break;
>  		}
>  		*hex_encoded_iv = strsep(&datablob, " \t");
>  		if (!*hex_encoded_iv) {
> -			pr_info("encrypted_key: hex blob is missing\n");
> +			pr_info("hex blob is missing\n");
>  			break;
>  		}
>  		ret = 0;
>  		break;
>  	case Opt_update:
>  		if (decrypted_datalen) {
> -			pr_info("encrypted_key: keyword \'%s\' not allowed "
> -				"when called from .instantiate method\n",
> +			pr_info("keyword \'%s\' not allowed when called from .instantiate method\n",
>  				keyword);
>  			break;
>  		}
>  		ret = 0;
>  		break;
>  	case Opt_err:
> -		pr_info("encrypted_key: keyword \'%s\' not recognized\n",
> -			keyword);
> +		pr_info("keyword \'%s\' not recognized\n", keyword);
>  		break;
>  	}
>  out:
> @@ -362,22 +360,21 @@ static struct skcipher_request *init_skcipher_req(const u8 *key,
>  
>  	tfm = crypto_alloc_skcipher(blkcipher_alg, 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(tfm)) {
> -		pr_err("encrypted_key: failed to load %s transform (%ld)\n",
> -		       blkcipher_alg, PTR_ERR(tfm));
> +		pr_err("failed to load %s transform (%ld)\n", blkcipher_alg,
> +		       PTR_ERR(tfm));
>  		return ERR_CAST(tfm);
>  	}
>  
>  	ret = crypto_skcipher_setkey(tfm, key, key_len);
>  	if (ret < 0) {
> -		pr_err("encrypted_key: failed to setkey (%d)\n", ret);
> +		pr_err("failed to setkey (%d)\n", ret);
>  		crypto_free_skcipher(tfm);
>  		return ERR_PTR(ret);
>  	}
>  
>  	req = skcipher_request_alloc(tfm, GFP_KERNEL);
>  	if (!req) {
> -		pr_err("encrypted_key: failed to allocate request for %s\n",
> -		       blkcipher_alg);
> +		pr_err("failed to allocate request for %s\n", blkcipher_alg);
>  		crypto_free_skcipher(tfm);
>  		return ERR_PTR(-ENOMEM);
>  	}
> @@ -406,13 +403,10 @@ static struct key *request_master_key(struct encrypted_key_payload *epayload,
>  
>  	if (IS_ERR(mkey)) {
>  		int ret = PTR_ERR(mkey);
> -
>  		if (ret == -ENOTSUPP)
> -			pr_info("encrypted_key: key %s not supported",
> -				epayload->master_desc);
> +			pr_info("key %s not supported", epayload->master_desc);
>  		else
> -			pr_info("encrypted_key: key %s not found",
> -				epayload->master_desc);
> +			pr_info("key %s not found", epayload->master_desc);
>  		goto out;
>  	}
>  
> @@ -457,7 +451,7 @@ static int derived_key_encrypt(struct encrypted_key_payload *epayload,
>  	skcipher_request_free(req);
>  	crypto_free_skcipher(tfm);
>  	if (ret < 0)
> -		pr_err("encrypted_key: failed to encrypt (%d)\n", ret);
> +		pr_err("failed to encrypt (%d)\n", ret);
>  	else
>  		dump_encrypted_data(epayload, encrypted_datalen);
>  out:
> @@ -596,16 +590,16 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  
>  	if (decrypted_data) {
>  		if (!user_decrypted_data) {
> -			pr_err("encrypted key: instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
> +			pr_err("instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
>  			return ERR_PTR(-EINVAL);
>  		}
>  		if (strlen(decrypted_data) != decrypted_datalen * 2) {
> -			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
> +			pr_err("decrypted data provided does not match decrypted data length provided\n");
>  			return ERR_PTR(-EINVAL);
>  		}
>  		for (i = 0; i < strlen(decrypted_data); i++) {
>  			if (!isxdigit(decrypted_data[i])) {
> -				pr_err("encrypted key: decrypted data provided must contain only hexadecimal characters\n");
> +				pr_err("decrypted data provided must contain only hexadecimal characters\n");
>  				return ERR_PTR(-EINVAL);
>  			}
>  		}
> @@ -614,7 +608,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  	if (format) {
>  		if (!strcmp(format, key_format_ecryptfs)) {
>  			if (dlen != ECRYPTFS_MAX_KEY_BYTES) {
> -				pr_err("encrypted_key: keylen for the ecryptfs format must be equal to %d bytes\n",
> +				pr_err("keylen for the ecryptfs format must be equal to %d bytes\n",
>  					ECRYPTFS_MAX_KEY_BYTES);
>  				return ERR_PTR(-EINVAL);
>  			}
> @@ -622,8 +616,8 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  			payload_datalen = sizeof(struct ecryptfs_auth_tok);
>  		} else if (!strcmp(format, key_format_enc32)) {
>  			if (decrypted_datalen != KEY_ENC32_PAYLOAD_LEN) {
> -				pr_err("encrypted_key: enc32 key payload incorrect length: %d\n",
> -						decrypted_datalen);
> +				pr_err("enc32 key payload incorrect length: %d\n",
> +					decrypted_datalen);
>  				return ERR_PTR(-EINVAL);
>  			}
>  		}
> @@ -689,7 +683,7 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
>  
>  	ret = datablob_hmac_verify(epayload, format, master_key, master_keylen);
>  	if (ret < 0) {
> -		pr_err("encrypted_key: bad hmac (%d)\n", ret);
> +		pr_err("bad hmac (%d)\n", ret);
>  		goto out;
>  	}
>  
> @@ -699,7 +693,7 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
>  
>  	ret = derived_key_decrypt(epayload, derived_key, sizeof derived_key);
>  	if (ret < 0)
> -		pr_err("encrypted_key: failed to decrypt key (%d)\n", ret);
> +		pr_err("failed to decrypt key (%d)\n", ret);
>  out:
>  	up_read(&mkey->sem);
>  	key_put(mkey);
> diff --git a/security/keys/encrypted-keys/encrypted.h b/security/keys/encrypted-keys/encrypted.h
> index 1809995db452..7b05c66bafa6 100644
> --- a/security/keys/encrypted-keys/encrypted.h
> +++ b/security/keys/encrypted-keys/encrypted.h
> @@ -41,7 +41,7 @@ static inline void dump_hmac(const char *str, const u8 *digest,
>  			     unsigned int hmac_size)
>  {
>  	if (str)
> -		pr_info("encrypted_key: %s", str);
> +		pr_info("%s", str);
>  	print_hex_dump(KERN_ERR, "hmac: ", DUMP_PREFIX_NONE, 32, 1, digest,
>  		       hmac_size, 0);
>  }
> -- 
> 2.51.1
> 

BR, Jarkko

