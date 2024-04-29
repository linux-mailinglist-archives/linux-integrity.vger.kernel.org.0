Return-Path: <linux-integrity+bounces-2283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B058B65D4
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 00:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F861C21204
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650531863C;
	Mon, 29 Apr 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpuiO1iU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AA17C72;
	Mon, 29 Apr 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430263; cv=none; b=uK8uo9U9tYWNS26D5mKgr7sg29WxCNfVHHz5WgkFCHUxxSqMmY5n279AMtZIfpHo/ebc9i63Y4s9sJ50fZRvuHEOCQXFgKrg2tch6ArpBQvT7tIdcM7P2cUBwL4kK911+Nt+6RBK4SBPIJzwzgyMszoAB8HzlkVD+XLnpnLErz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430263; c=relaxed/simple;
	bh=JbAdKqK3bbihD4aLgz0Jgaads3DTgJ2ZZEpZT5rC0Yc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FdPNEcNiVR/Mg6qJ9bycm/4s+nDfQd3mmZcDwx2AL5YHgeuyxfzmljTV1co/5Q8souNJkqbM2uS3D030mDb74hmCQmz10ohkw/Ct5VicR12GLiM2DIrsJaXJpr5eOSgCiN/wC7ldT6JFg+MTOl0MQzICsfSmF35uTls3q011X7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpuiO1iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22641C113CD;
	Mon, 29 Apr 2024 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430263;
	bh=JbAdKqK3bbihD4aLgz0Jgaads3DTgJ2ZZEpZT5rC0Yc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UpuiO1iUZSG4E8ved1aKTzQ92woaoKkPQBjOUy9eWo942nDAWF9xrYgRp0LwOoRiw
	 lp0Nwl7POhRzqUbWXFprKoZ4huAYqDUv5I/Vz+ZarhETFySQH277IPezZBMux4GT5X
	 TR8VL7ymtPSsf2mfayp+CcokxFGLMGTpa/IaqIxNext4tZRfIGpWSl1RInn77IuOSR
	 byrZeJ4Q6ND6JWrVqwkA6GrJsjnaT8zpq8Dwq4dSwotyMYB3nZSShDk7KyaxmgCtwF
	 o+hX7MilGPSdU2ziaRqQIOmcqo08kDRqzWYNaewTsRbJHwlkvVxptJQ9zqm/P2D/5e
	 Rv9ONS4PKXMJA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 01:37:40 +0300
Message-Id: <D0WYT0L5251S.16P50NUSZCITR@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 13/22] tpm: Add TCG mandated Key Derivation Functions
 (KDFs)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-14-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240429202811.13643-14-James.Bottomley@HansenPartnership.com>

On Mon Apr 29, 2024 at 11:28 PM EEST, James Bottomley wrote:
> The TCG mandates two Key derivation functions called KDFa and KDFe
> used to derive keys from seeds and elliptic curve points respectively.
> The definitions for these functions are found in the TPM 2.0 Library
> Specification Part 1 - Architecture Guide
>
> https://trustedcomputinggroup.org/resource/tpm-library-specification/
>
> Implement a cut down version of each of these functions sufficient to
> support the key derivation needs of HMAC sessions.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v8: Add new patch containing KDFs
> ---
>  drivers/char/tpm/Kconfig         |   1 +
>  drivers/char/tpm/tpm2-sessions.c | 105 +++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index ab16d347579f..4873e6eae255 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -30,6 +30,7 @@ if TCG_TPM
>  config TCG_TPM2_HMAC
>  	bool "Use HMAC and encrypted transactions on the TPM bus"
>  	default y
> +	select CRYPTO_LIB_SHA256
>  	help
>  	  Setting this causes us to deploy a scheme which uses request
>  	  and response HMACs in addition to encryption for
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index fc3f032df467..8429e596f1eb 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -7,6 +7,111 @@
> =20
>  #include "tpm.h"
>  #include <asm/unaligned.h>
> +#include <crypto/hash.h>
> +#include <crypto/hmac.h>
> +
> +/*
> + * It turns out the crypto hmac(sha256) is hard for us to consume
> + * because it assumes a fixed key and the TPM seems to change the key
> + * on every operation, so we weld the hmac init and final functions in
> + * here to give it the same usage characteristics as a regular hash
> + */
> +static void tpm2_hmac_init(struct sha256_state *sctx, u8 *key, u32 key_l=
en)
> +{
> +	u8 pad[SHA256_BLOCK_SIZE];
> +	int i;
> +
> +	sha256_init(sctx);
> +	for (i =3D 0; i < sizeof(pad); i++) {
> +		if (i < key_len)
> +			pad[i] =3D key[i];
> +		else
> +			pad[i] =3D 0;
> +		pad[i] ^=3D HMAC_IPAD_VALUE;
> +	}
> +	sha256_update(sctx, pad, sizeof(pad));
> +}
> +
> +static void tpm2_hmac_final(struct sha256_state *sctx, u8 *key, u32 key_=
len,
> +			    u8 *out)
> +{
> +	u8 pad[SHA256_BLOCK_SIZE];
> +	int i;
> +
> +	for (i =3D 0; i < sizeof(pad); i++) {
> +		if (i < key_len)
> +			pad[i] =3D key[i];
> +		else
> +			pad[i] =3D 0;
> +		pad[i] ^=3D HMAC_OPAD_VALUE;
> +	}
> +
> +	/* collect the final hash;  use out as temporary storage */
> +	sha256_final(sctx, out);
> +
> +	sha256_init(sctx);
> +	sha256_update(sctx, pad, sizeof(pad));
> +	sha256_update(sctx, out, SHA256_DIGEST_SIZE);
> +	sha256_final(sctx, out);
> +}
> +
> +/*
> + * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
> + * otherwise standard tpm2_KDFa.  Note output is in bytes not bits.
> + */
> +static void tpm2_KDFa(u8 *key, u32 key_len, const char *label, u8 *u,
> +		      u8 *v, u32 bytes, u8 *out)
> +{
> +	u32 counter =3D 1;
> +	const __be32 bits =3D cpu_to_be32(bytes * 8);
> +
> +	while (bytes > 0) {
> +		struct sha256_state sctx;
> +		__be32 c =3D cpu_to_be32(counter);
> +
> +		tpm2_hmac_init(&sctx, key, key_len);
> +		sha256_update(&sctx, (u8 *)&c, sizeof(c));
> +		sha256_update(&sctx, label, strlen(label)+1);
> +		sha256_update(&sctx, u, SHA256_DIGEST_SIZE);
> +		sha256_update(&sctx, v, SHA256_DIGEST_SIZE);
> +		sha256_update(&sctx, (u8 *)&bits, sizeof(bits));
> +		tpm2_hmac_final(&sctx, key, key_len, out);
> +
> +		bytes -=3D SHA256_DIGEST_SIZE;
> +		counter++;
> +		out +=3D SHA256_DIGEST_SIZE;
> +	}
> +}
> +
> +/*
> + * Somewhat of a bastardization of the real KDFe.  We're assuming
> + * we're working with known point sizes for the input parameters and
> + * the hash algorithm is fixed at sha256.  Because we know that the
> + * point size is 32 bytes like the hash size, there's no need to loop
> + * in this KDF.
> + */
> +static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_=
v,
> +		      u8 *out)
> +{
> +	struct sha256_state sctx;
> +	/*
> +	 * this should be an iterative counter, but because we know
> +	 *  we're only taking 32 bytes for the point using a sha256
> +	 *  hash which is also 32 bytes, there's only one loop
> +	 */
> +	__be32 c =3D cpu_to_be32(1);
> +
> +	sha256_init(&sctx);
> +	/* counter (BE) */
> +	sha256_update(&sctx, (u8 *)&c, sizeof(c));
> +	/* secret value */
> +	sha256_update(&sctx, z, EC_PT_SZ);
> +	/* string including trailing zero */
> +	sha256_update(&sctx, str, strlen(str)+1);
> +	sha256_update(&sctx, pt_u, EC_PT_SZ);
> +	sha256_update(&sctx, pt_v, EC_PT_SZ);
> +	sha256_final(&sctx, out);
> +}
> =20
>  /**
>   * tpm2_parse_create_primary() - parse the data returned from TPM_CC_CRE=
ATE_PRIMARY

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

