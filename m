Return-Path: <linux-integrity+bounces-2849-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0D90015B
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717D72845AE
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AD186E56;
	Fri,  7 Jun 2024 10:58:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE8186E26;
	Fri,  7 Jun 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757928; cv=none; b=k5MFWZFiDgf51ezNUTPW5TwTUfCgjZL6w16YARQQGY16XUkfMwFOJIKuZWYojopxi+09q/hZ1x8jyKwLlN7C+Vq41CZx4tqF+Y72oVBABy3TO7dxBPBS9bCgwwFea9CHP057oj9QAooLWvF1HCRSqTZWBDxsHy+8ajvep0bjBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757928; c=relaxed/simple;
	bh=gj9rHGiqEtVhgMyKf1T0aWkSra6juadP60PhESLNEog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Coovq8uTJOM+wj5yb3A8P1kfRzSEjOtt96yRcOYOqWnnVVQoDpN40w0WTwely4/x8w63epX9cUkcvuADOSU9dya656r/R94Irs0xN4SMDVHYDOv9kByfiGUGNeNxMK8gpdjaAjgq7m838VnOOdgU5/y/ShHb6lbJGGFf2IWEIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sFXIW-006npX-0e;
	Fri, 07 Jun 2024 18:58:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jun 2024 18:58:18 +0800
Date: Fri, 7 Jun 2024 18:58:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
	Lennart Poettering <lennart@poettering.net>,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v7 4/5] keys: asymmetric: Add tpm2_key_rsa
Message-ID: <ZmLnyp9j_QoPgj7W@gondor.apana.org.au>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528210823.28798-5-jarkko@kernel.org>

On Wed, May 29, 2024 at 12:08:09AM +0300, Jarkko Sakkinen wrote:
>
> +/*
> + * Sign operation is an encryption using the TPM's private key. With RSA the
> + * only difference between encryption and decryption is where the padding goes.
> + * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to do
> + * encryption.
> + */
> +static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
> +			     struct kernel_pkey_params *params,
> +			     const void *in, void *out)
> +{
> +	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
> +	const struct tpm2_rsa_parms *p =
> +		(const struct tpm2_rsa_parms *)&key->data[o];
> +	const u16 mod_size = be16_to_cpu(p->modulus_size);
> +	const struct rsa_asn1_template *asn1;
> +	u32 in_len = params->in_len;
> +	void *asn1_wrapped = NULL;
> +	u8 *padded;
> +	int ret;
> +
> +	if (strcmp(params->encoding, "pkcs1") != 0) {
> +		ret = -ENOPKG;
> +		goto err;
> +	}
> +
> +	if (params->hash_algo) {
> +		asn1 = rsa_lookup_asn1(params->hash_algo);

Could you please explain why this can't be done through pkcs1pad
instead of going to raw RSA?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

