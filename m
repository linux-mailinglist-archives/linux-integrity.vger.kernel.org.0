Return-Path: <linux-integrity+bounces-6860-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4860B28466
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 18:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C015EB01768
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EB2E5D0C;
	Fri, 15 Aug 2025 16:49:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4722E5D14;
	Fri, 15 Aug 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276560; cv=none; b=rVgqC1zEy5rCAo2Y/p2+Z9IKZBp/Q0n6NTo4gIzL3ynZnlR9tERTaP0YbyEB1GsYgA6RRDmpEO95gcgRJherTWHRWSVuxuTv1UJbHwnZshvCLJqK4J6UPRtLcUjKgPAye4/odx+rMxJ8+eS4eBMc57SeEED6MCKHmKo3hhLxy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276560; c=relaxed/simple;
	bh=ZF16SxSfa865cmn764HY5Fi7MUh9NEnfj34NLhpOIBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0XH065iZV5yA9dVIxBhvj2mUrrbtDjsewE/XNcYcz8BgYm5SCba++kVvEqx7UDn8idok+/5+nnurMYuDxNNxlilMdt/F/B8kimbEEx+LZj1wqNJdJA+XTZkgKkMcnIlp1168dmNC1fhEw/p9WprzCx7fvK4GVbzau0185oCjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [100.72.154.47] (unknown [185.109.152.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4F78060213AC5;
	Fri, 15 Aug 2025 18:48:09 +0200 (CEST)
Message-ID: <46e7ff0c-0014-4b0a-b8dd-17feb05a934e@molgen.mpg.de>
Date: Fri, 15 Aug 2025 18:48:07 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/digsig: Use SHA-1 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-crypto@vger.kernel.org
References: <20250815021733.25689-1-ebiggers@kernel.org>
 <20250815021733.25689-3-ebiggers@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250815021733.25689-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Eric,


Thank you for your patch.

Am 15.08.25 um 04:17 schrieb Eric Biggers:
> Now that a SHA-1 library API is available, use it instead of
> crypto_shash.  This is simpler and faster.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   lib/Kconfig  |  3 +--
>   lib/digsig.c | 46 ++++++----------------------------------------
>   2 files changed, 7 insertions(+), 42 deletions(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c483951b624ff..e629449dd2a36 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -475,12 +475,11 @@ config MPILIB
>   	  which is used by IMA/EVM digital signature extension.
>   
>   config SIGNATURE
>   	tristate
>   	depends on KEYS
> -	select CRYPTO
> -	select CRYPTO_SHA1
> +	select CRYPTO_LIB_SHA1
>   	select MPILIB
>   	help
>   	  Digital signature verification. Currently only RSA is supported.
>   	  Implementation is done using GnuPG MPI library
>   
> diff --git a/lib/digsig.c b/lib/digsig.c
> index 04b5e55ed95f5..5ddcc52f76863 100644
> --- a/lib/digsig.c
> +++ b/lib/digsig.c
> @@ -16,19 +16,15 @@
>   
>   #include <linux/err.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/key.h>
> -#include <linux/crypto.h>
> -#include <crypto/hash.h>
>   #include <crypto/sha1.h>
>   #include <keys/user-type.h>
>   #include <linux/mpi.h>
>   #include <linux/digsig.h>
>   
> -static struct crypto_shash *shash;
> -
>   static const char *pkcs_1_v1_5_decode_emsa(const unsigned char *msg,
>   						unsigned long  msglen,
>   						unsigned long  modulus_bitlen,
>   						unsigned long *outlen)
>   {
> @@ -197,16 +193,16 @@ static int digsig_verify_rsa(struct key *key,
>    *
>    */
>   int digsig_verify(struct key *keyring, const char *sig, int siglen,
>   						const char *data, int datalen)
>   {
> -	int err = -ENOMEM;
>   	struct signature_hdr *sh = (struct signature_hdr *)sig;
> -	struct shash_desc *desc = NULL;
> +	struct sha1_ctx ctx;
>   	unsigned char hash[SHA1_DIGEST_SIZE];
>   	struct key *key;
>   	char name[20];
> +	int err;
>   
>   	if (siglen < sizeof(*sh) + 2)
>   		return -EINVAL;
>   
>   	if (sh->algo != PUBKEY_ALGO_RSA)
> @@ -229,51 +225,21 @@ int digsig_verify(struct key *keyring, const char *sig, int siglen,
>   	if (IS_ERR(key)) {
>   		pr_err("key not found, id: %s\n", name);
>   		return PTR_ERR(key);
>   	}
>   
> -	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
> -		       GFP_KERNEL);
> -	if (!desc)
> -		goto err;
> -
> -	desc->tfm = shash;
> -
> -	crypto_shash_init(desc);
> -	crypto_shash_update(desc, data, datalen);
> -	crypto_shash_update(desc, sig, sizeof(*sh));
> -	crypto_shash_final(desc, hash);
> -
> -	kfree(desc);
> +	sha1_init(&ctx);
> +	sha1_update(&ctx, data, datalen);
> +	sha1_update(&ctx, sig, sizeof(*sh));
> +	sha1_final(&ctx, hash);
>   
>   	/* pass signature mpis address */
>   	err = digsig_verify_rsa(key, sig + sizeof(*sh), siglen - sizeof(*sh),
>   			     hash, sizeof(hash));
>   
> -err:
>   	key_put(key);
>   
>   	return err ? -EINVAL : 0;
>   }
>   EXPORT_SYMBOL_GPL(digsig_verify);
>   
> -static int __init digsig_init(void)
> -{
> -	shash = crypto_alloc_shash("sha1", 0, 0);
> -	if (IS_ERR(shash)) {
> -		pr_err("shash allocation failed\n");
> -		return  PTR_ERR(shash);
> -	}
> -
> -	return 0;
> -
> -}
> -
> -static void __exit digsig_cleanup(void)
> -{
> -	crypto_free_shash(shash);
> -}
> -
> -module_init(digsig_init);
> -module_exit(digsig_cleanup);
> -
>   MODULE_LICENSE("GPL");

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

