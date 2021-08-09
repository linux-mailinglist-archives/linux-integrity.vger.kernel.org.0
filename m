Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E785A3E48DA
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhHIP2T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 11:28:19 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:60830 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235541AbhHIP2M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 11:28:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BFF971280751;
        Mon,  9 Aug 2021 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1628522870;
        bh=ZmzB8VQ109VD0LQ68nGkKne9WSfFIoe1Q6/iw4PKY7Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=EehP5GvsAcFNarhBhmq8jsX4arBTLqi7PDrfvY3CgFKGdUUitVoKBJf/1OyS5gXpy
         2Cs+PhJJaU8YbpMGTmor9IQgiuME91uBRDvFtWnxRRPtdJOq8yGLoYPc5MSrw6rs4U
         +ZD2X0OZSG12qxiGt0cw79+nZz0tmrZmWmF2mlLw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GSFE0bJeKwut; Mon,  9 Aug 2021 08:27:50 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 57816128070D;
        Mon,  9 Aug 2021 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1628522870;
        bh=ZmzB8VQ109VD0LQ68nGkKne9WSfFIoe1Q6/iw4PKY7Q=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=EehP5GvsAcFNarhBhmq8jsX4arBTLqi7PDrfvY3CgFKGdUUitVoKBJf/1OyS5gXpy
         2Cs+PhJJaU8YbpMGTmor9IQgiuME91uBRDvFtWnxRRPtdJOq8yGLoYPc5MSrw6rs4U
         +ZD2X0OZSG12qxiGt0cw79+nZz0tmrZmWmF2mlLw=
Message-ID: <e282548fa640013130ba7a51329658d552471110.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/4] libimaevm: Add support for pkcs11 private keys for
 signing a v2 hash
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 09 Aug 2021 08:27:49 -0700
In-Reply-To: <20210809151026.195038-3-stefanb@linux.vnet.ibm.com>
References: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
         <20210809151026.195038-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-08-09 at 11:10 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Add support for pkcs11 private keys for signing a v2 hash.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  README          |  1 +
>  src/evmctl.c    |  1 +
>  src/libimaevm.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
> --
>  3 files changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/README b/README
> index 1cc027f..2bb363c 100644
> --- a/README
> +++ b/README
> @@ -48,6 +48,7 @@ OPTIONS
>        --xattr-user   store xattrs in user namespace (for testing
> purposes)
>        --rsa          use RSA key type and signing scheme v1
>    -k, --key          path to signing key (default:
> /etc/keys/{privkey,pubkey}_evm.pem)
> +                     or a pkcs11 URI
>        --keyid n      overwrite signature keyid with a 32-bit value
> in hex (for signing)
>        --keyid-from-cert file
>                       read keyid value from SKID of a x509 cert file
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 58f8e66..2e85f8b 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2503,6 +2503,7 @@ static void usage(void)
>  		"      --xattr-user   store xattrs in user namespace
> (for testing purposes)\n"
>  		"      --rsa          use RSA key type and signing
> scheme v1\n"
>  		"  -k, --key          path to signing key (default:
> /etc/keys/{privkey,pubkey}_evm.pem)\n"
> +		"                     or a pkcs11 URI\n"
>  		"      --keyid n      overwrite signature keyid with a
> 32-bit value in hex (for signing)\n"
>  		"      --keyid-from-cert file\n"
>  		"                     read keyid value from SKID of a
> x509 cert file\n"
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 8e96157..b84e5b8 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -60,6 +60,7 @@
>  #include <openssl/x509.h>
>  #include <openssl/x509v3.h>
>  #include <openssl/err.h>
> +#include <openssl/engine.h>
>  
>  #include "imaevm.h"
>  #include "hash_info.h"
> @@ -803,21 +804,57 @@ static EVP_PKEY *read_priv_pkey(const char
> *keyfile, const char *keypass)
>  {
>  	FILE *fp;
>  	EVP_PKEY *pkey;
> +	ENGINE *e;
>  
> -	fp = fopen(keyfile, "r");
> -	if (!fp) {
> -		log_err("Failed to open keyfile: %s\n", keyfile);
> -		return NULL;
> -	}
> -	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
> -	if (!pkey) {
> -		log_err("Failed to PEM_read_PrivateKey key file: %s\n",
> -			keyfile);
> -		output_openssl_errors();
> +	if (!strncmp(keyfile, "pkcs11:", 7)) {
> +		if (!imaevm_params.keyid) {
> +			log_err("When using a pkcs11 URI you must
> provide the keyid with an option\n");
> +			return NULL;
> +		}
> +
> +		ENGINE_load_builtin_engines();
> +		e = ENGINE_by_id("pkcs11");
> +		if (!e) {
> +			log_err("Failed to load pkcs11 engine\n");
> +			goto err_pkcs11;
> +		}
> +		if (!ENGINE_init(e)) {
> +			log_err("Failed to initialize the pkcs11
> engine\n");
> +			goto err_pkcs11;
> +		}
> +		if (keypass) {
> +			if (!ENGINE_ctrl_cmd_string(e, "PIN", keypass,
> 0)) {
> +				log_err("Failed to set the PIN for the
> private key\n");
> +				goto err_pkcs11;
> +			}
> +		}
> +		pkey = ENGINE_load_private_key(e, keyfile, NULL, NULL);
> +		if (!pkey) {
> +			log_err("Failed to load private key %s\n",
> keyfile);
> +			goto err_pkcs11;
> +		}
> +	} else {
> +		fp = fopen(keyfile, "r");
> +		if (!fp) {
> +			log_err("Failed to open keyfile: %s\n",
> keyfile);
> +			return NULL;
> +		}
> +		pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void
> *)keypass);
> +		if (!pkey) {
> +			log_err("Failed to PEM_read_PrivateKey key
> file: %s\n",
> +				keyfile);
> +			output_openssl_errors();
> +		}
> +
> +		fclose(fp);

This looks a bit narrow.  Isn't the problem that *any* engine key might
be a specifier not a file?  In which case the generic fix is not to
validate file existence if an engine is present on the command line. 
That way you can specify any engine key and the pkcs11 key simply
becomes a special case of this.

If you insist on not having to specify --engine for pkcs11 keys then
you do the prefix check earlier on and set the engine to pkcs11 (if
it's not already set to something else).

James


