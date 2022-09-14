Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8985B8B0B
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiINOvl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINOvk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:51:40 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80AA61A83D
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:51:38 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3926872C90B;
        Wed, 14 Sep 2022 17:51:37 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 263EA4A46F0;
        Wed, 14 Sep 2022 17:51:37 +0300 (MSK)
Date:   Wed, 14 Sep 2022 17:51:36 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 06/15] Add missing EVP_MD_CTX_free()
 call in calc_evm_hash()
Message-ID: <20220914145136.7xiziuvcsqtiyex3@altlinux.org>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
 <20220914022956.1359218-7-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220914022956.1359218-7-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Sep 13, 2022 at 10:29:47PM -0400, Mimi Zohar wrote:
> When EVP_MD_CTX_new() call was added, the corresponding EVP_MD_CTX_free()
> was never called.  Properly free it.
> 
> Fixes: 81010f0d87ef ("ima-evm-utils: Add backward compatible support for openssl 1.1")
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/evmctl.c | 57 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 27d2061f23be..b8c92aad6b84 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -332,11 +332,17 @@ err:
>  	return -1;
>  }
>  
> +/*
> + * calc_evm_hash - calculate the file metadata hash
> + *
> + * Returns 0 for EVP_ function failures. Return -1 for other failures.
> + * Return hash algorithm size on success.
> + */
>  static int calc_evm_hash(const char *file, unsigned char *hash)
>  {
>          const EVP_MD *md;
>  	struct stat st;
> -	int err;
> +	int err = -1;
>  	uint32_t generation = 0;
>  	EVP_MD_CTX *pctx;
>  	unsigned int mdlen;
> @@ -350,12 +356,11 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  #if OPENSSL_VERSION_NUMBER < 0x10100000
>  	EVP_MD_CTX ctx;
>  	pctx = &ctx;
> -#else
> -	pctx = EVP_MD_CTX_new();
>  #endif
>  
>  	if (lstat(file, &st)) {
>  		log_err("Failed to stat: %s\n", file);
> +		errno = 0;

Why it clears errno (here and below)?

errno(3) says "The value of errno is never set to zero by any system
call or library function."

Thanks,

>  		return -1;
>  	}
>  
> @@ -392,20 +397,30 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  	list_size = llistxattr(file, list, sizeof(list));
>  	if (list_size < 0) {
>  		log_err("llistxattr() failed\n");
> +		errno = 0;
>  		return -1;
>  	}
>  
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	pctx = EVP_MD_CTX_new();
> +	if (!pctx) {
> +		log_err("EVP_MD_CTX_new() failed\n");
> +		return 0;
> +	}
> +#endif
> +
>  	md = EVP_get_digestbyname(imaevm_params.hash_algo);
>  	if (!md) {
>  		log_err("EVP_get_digestbyname(%s) failed\n",
>  			imaevm_params.hash_algo);
> -		return 1;
> +		err = 0;
> +		goto out;
>  	}
>  
>  	err = EVP_DigestInit(pctx, md);
>  	if (!err) {
>  		log_err("EVP_DigestInit() failed\n");
> -		return 1;
> +		goto out;
>  	}
>  
>  	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
> @@ -416,7 +431,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  			if (err > sizeof(xattr_value)) {
>  				log_err("selinux[%u] value is too long to fit into xattr[%zu]\n",
>  					err, sizeof(xattr_value));
> -				return -1;
> +				err = -1;
> +				goto out;
>  			}
>  			strcpy(xattr_value, selinux_str);
>  		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && ima_str) {
> @@ -424,7 +440,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  			if (err > sizeof(xattr_value)) {
>  				log_err("ima[%u] value is too long to fit into xattr[%zu]\n",
>  					err, sizeof(xattr_value));
> -				return -1;
> +				err = -1;
> +				goto out;
>  			}
>  			hex2bin(xattr_value, ima_str, err);
>  		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && evm_portable){
> @@ -433,7 +450,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  			if (err < 0) {
>  				log_err("EVM portable sig: %s required\n",
>  					xattr_ima);
> -				return -1;
> +				goto out;
>  			}
>  			use_xattr_ima = 1;
>  		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
> @@ -443,7 +460,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  			if (err >= sizeof(xattr_value)) {
>  				log_err("caps[%u] value is too long to fit into xattr[%zu]\n",
>  					err + 1, sizeof(xattr_value));
> -				return -1;
> +				err = -1;
> +				goto out;
>  			}
>  			strcpy(xattr_value, caps_str);
>  		} else {
> @@ -464,7 +482,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		err = EVP_DigestUpdate(pctx, xattr_value, err);
>  		if (!err) {
>  			log_err("EVP_DigestUpdate() failed\n");
> -			return 1;
> +			goto out;
>  		}
>  	}
>  
> @@ -518,29 +536,33 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  	err = EVP_DigestUpdate(pctx, &hmac_misc, hmac_size);
>  	if (!err) {
>  		log_err("EVP_DigestUpdate() failed\n");
> -		return 1;
> +		goto out;
>  	}
>  
>  	if (!evm_immutable && !evm_portable &&
>  	    !(hmac_flags & HMAC_FLAG_NO_UUID)) {
>  		err = get_uuid(&st, uuid);
>  		if (err)
> -			return -1;
> +			goto out;
>  
>  		err = EVP_DigestUpdate(pctx, (const unsigned char *)uuid, sizeof(uuid));
>  		if (!err) {
>  			log_err("EVP_DigestUpdate() failed\n");
> -			return 1;
> +			goto out;
>  		}
>  	}
>  
>  	err = EVP_DigestFinal(pctx, hash, &mdlen);
> -	if (!err) {
> +	if (!err)
>  		log_err("EVP_DigestFinal() failed\n");
> -		return 1;
> -	}
>  
> -	return mdlen;
> +out:
> +#if OPENSSL_VERSION_NUMBER >= 0x10100000
> +	EVP_MD_CTX_free(pctx);
> +#endif
> +	if (err == 1)
> +		return mdlen;
> +	return err;
>  }
>  
>  static int sign_evm(const char *file, const char *key)
> @@ -576,6 +598,7 @@ static int sign_evm(const char *file, const char *key)
>  		err = lsetxattr(file, xattr_evm, sig, len, 0);
>  		if (err < 0) {
>  			log_err("setxattr failed: %s\n", file);
> +			errno = 0;
>  			return err;
>  		}
>  	}
> -- 
> 2.31.1
