Return-Path: <linux-integrity+bounces-2649-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA268CF832
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 05:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC101F21B58
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 03:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E9523D;
	Mon, 27 May 2024 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="Cu2OIkr7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AW8T2bvo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED210E5;
	Mon, 27 May 2024 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781522; cv=none; b=ejwn8oZY9huGKQBjMjcYw14rAjeFJ284zpkrWmg4YuSJhOKKIso4BwNtPqa+K31iVdasD0Cz6QnAAPdcjhG2fve3tqDBLLzaumtGqPhkPZYc/FRLpeDahh5MrZF38s+tGSWyrYWlU7al6elrB3XKwoQWI6IkR7Pf+7EsVrCPwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781522; c=relaxed/simple;
	bh=z075EWUF88v5SyNWPsFV4lENbozCrGG+RmSwO2WZ0vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPpTS5e9Kj1YAZl/1KsrxEu/eaY9cu4orIdyCxJN8FoChmCmMf8rJi/8J1gXauOF1CTUZXo8nIT0rv3ptDpln/Eo66aspCJTvhi+QAOgDZC/yHTrg+oHzsZ9q/j5lRViKJMAX4Z+dYpDJtDmMa2nGKc79dpVXpjuzZ1XSrz18sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=Cu2OIkr7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AW8T2bvo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 32FF311400BD;
	Sun, 26 May 2024 23:45:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 26 May 2024 23:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1716781519; x=
	1716867919; bh=IXV7ZFAtIZ8TwK1H4s3yD9qJLEL2rfl6IHh5MwEvTMA=; b=C
	u2OIkr7gErwOnpNx1B8dUtc5dc3KGe5ReLMjc28L+W31ByVybtLtupAvAQeaZnj4
	80/Kql7/GSPZIgnCBdAAXeGDSTFA1e6960ovleRcAPqP+Fe3ZqOjukkyvYMYbfYi
	Gr0CEHanG/+op2JW7QetHzu39UAYjobwWmLdlbyb/gSaEN5RcqyuRpQtikHRYTlL
	J0zGurUsFJXYZSWnvghAb9N2LKctdGOGeoN37BwiiERkYWerFRE/DmMrY/yj5o31
	1C/uZmDxxv93xvL/BG3rdHch1xSrn02GapbeO0FXZM1Gm/TvQ1dYw5Msiojwico/
	zbPs7NvgwKQw+2doM+p5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716781519; x=1716867919; bh=IXV7ZFAtIZ8TwK1H4s3yD9qJLEL2
	rfl6IHh5MwEvTMA=; b=AW8T2bvoLp6P0EqI6pyRvEbP+XyVKDmnAVILh1GvuDrh
	d48TuDNQ/vw/oXOZxUb4yXfIDTLAmEupGnce/J8OFYwGuoEk4CTF5Bmxiz3UmfIZ
	R0DMglVa+mpxJBgNf6l1Srv5LZ2XZixeovsC8r6aW0BN++hM+zUZ8LXC5lT7oDHY
	cL0RqpGCn3oHrfz/gDYCrIEvkVgRdZphezqp7c6ToIFipCfjGKyHCxYlXG3haFwD
	0QXG4tsjaqovmLjLyJGNLNW9Q6jp0kVchdZ65hgc04mwcXyR1xj8hDEtQ5zL70ka
	TzXVXtskBo0AJJ3AaO6bqYXUuNDt3sDKXDebNXbSHA==
X-ME-Sender: <xms:zgFUZv4McxZUdrOEADjtFeGArcQI8QTvbiq14P-2x3FP43qJJFj8aw>
    <xme:zgFUZk7YxnLciHsgBJUK3wYoqMORHkyvroNwBTSbccAt3WTaKnGtuhta_Hh8ngloW
    bySr9Mh-dwsC5RhOWI>
X-ME-Received: <xmr:zgFUZmeFSIj7LsIOb-syueSjzQETzX49qFLuLFVvCUEQgtgy5Y9QjL4EYlod-7rIiqKkCoZwJ3Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepffelgeffveelkeffkeehiefgtdeluedvtdfghfdtvdefgfejheffudeuveek
    vddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:zgFUZgLDksCJwmKxQkcTZIY-mV_bKbHBIU5uWVAFQgrCF2ysreRpzQ>
    <xmx:zgFUZjKYzJdHn1r_kHTVaYwt3HkK1OVltKB3NCUuAlqsfVuU-MfSfA>
    <xmx:zgFUZpxV2J05P9GDp7zdXQjM6FeSyriF4J9TBTEaSQN79vkMbtdWMg>
    <xmx:zgFUZvIsdDjBZJ4BLS3RtgJnrn-9qyVRiUJ2s-UpUqJx7if97Yw-2A>
    <xmx:zwFUZgGoz5BNcdDqu3KYEydv2QaLli3Dcdxqem3l0PugyisdQp4lArab>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 May 2024 23:45:18 -0400 (EDT)
Date: Sun, 26 May 2024 23:45:17 -0400
From: Ben Boeckel <me@benboeckel.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 1/6] tpm: consolidate TPM to crypto hash algorithm
 conversion
Message-ID: <ZlQBzdfyg1rSF_9a@farprobe>
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524130459.21510-2-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, May 24, 2024 at 09:04:54 -0400, James Bottomley wrote:
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index c17e4efbb2e5..07f532456a0c 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -418,11 +418,61 @@ enum tpm2_session_attributes {
>  	TPM2_SA_AUDIT			= BIT(7),
>  };
>  
> -struct tpm2_hash {
> +static const struct {
>  	unsigned int crypto_id;
>  	unsigned int tpm_id;
> +} tpm2_hash_map[] = {
> +	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> +	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> +	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> +	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> +	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
>  };
>  
> +/**
> + * tpm2_crypto_to_alg() - convert a crypto hash to a TPM alg id

Should "alg id" be "algorithm id" everwhere in the docs?

> + *
> + * @hash: the crypto subsystem view of the hash
> + *
> + * Return: TPM algorithm id or -1 if no mapping was found.
> + */
> +static inline int tpm2_crypto_to_alg(int hash)

How about naming this `crypto_id`?

> +{
> +	int i;
> +	int tpm_alg = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		if (hash == tpm2_hash_map[i].crypto_id) {
> +			tpm_alg = tpm2_hash_map[i].tpm_id;
> +			break;
> +		}
> +	}
> +
> +	return tpm_alg;
> +}
> +
> +/**
> + * tpm2_alg_to_crypto() - convert a TPM alg id to a crypto hash
> + *
> + * @hash: the TPM alg id view of the hash
> + *
> + * Return: TPM algorithm id or -1 if no mapping was found.

Copy pasta? Should be "crypto hash" I think.

> + */
> +static inline int tpm2_alg_to_crypto(int hash)

Maybe name this `alg_id`?

> +{
> +	int i;
> +	int crypto_hash = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		if (hash == tpm2_hash_map[i].tpm_id) {
> +			crypto_hash = tpm2_hash_map[i].crypto_id;
> +			break;
> +		}
> +	}
> +
> +	return crypto_hash;
> +}

There seems to be some level of confusion with variable naming here. Are
these "hashes" or "ids" being passed around? The structure calls them
ids, the docs call them both, the variables call one a hash and the
other unadorned.

--Ben

> +
>  int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
>  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
>  int tpm_buf_init_sized(struct tpm_buf *buf);
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index dfeec06301ce..94ff9ccae66e 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -18,14 +18,6 @@
>  
>  #include "tpm2key.asn1.h"
>  
> -static struct tpm2_hash tpm2_hash_map[] = {
> -	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> -	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> -	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> -	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> -	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> -};
> -
>  static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
>  
>  static int tpm2_key_encode(struct trusted_key_payload *payload,
> @@ -231,19 +223,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	off_t offset = TPM_HEADER_SIZE;
>  	struct tpm_buf buf, sized;
>  	int blob_len = 0;
> -	u32 hash;
> +	int hash = tpm2_crypto_to_alg(options->hash);
>  	u32 flags;
> -	int i;
>  	int rc;
>  
> -	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> -		if (options->hash == tpm2_hash_map[i].crypto_id) {
> -			hash = tpm2_hash_map[i].tpm_id;
> -			break;
> -		}
> -	}
> -
> -	if (i == ARRAY_SIZE(tpm2_hash_map))
> +	if (hash < 0)
>  		return -EINVAL;
>  
>  	if (!options->keyhandle)
> -- 
> 2.35.3
> 
> 

