Return-Path: <linux-integrity+bounces-3167-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8593405B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AB9282DBB
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7B181BB5;
	Wed, 17 Jul 2024 16:25:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC99180A67;
	Wed, 17 Jul 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233521; cv=none; b=r7wtl7whIqfqaGCoTqpKzvvgsERqApywkvC4XUhw6FrHLbJTrDcdBNxwx0oJFcZElmGAcKdt1vyINPR0h/JazhV+hInQoGsGwcXma3922op1mRBhp8OgGPUHFx2VxBzjaomcAvz2hmkUnyVBCMhhdfEprTicSzHVqZOmpw/nMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233521; c=relaxed/simple;
	bh=gsTjsJKiSv9mO94ijtFAZFseVqYNxVDnZ1NCnfwYttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omX9BfJ5lScG0VOswBxUfRWZH0yJf3dqgCjpjZ5cVWUuY9ZSkLzBRErdN+pl1bigj41ZMyz5KLAZCI8yB+d6K3pvLA5haTCJXafqrKo1dtRaDr9af51JWmVg1zCJ4onPViiK92A1VsUlbMAdj6eFel0H5/xTz3m2923d87Cv4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 431D92800B3CC;
	Wed, 17 Jul 2024 18:17:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2E3BF21097A; Wed, 17 Jul 2024 18:17:45 +0200 (CEST)
Date: Wed, 17 Jul 2024 18:17:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	patrick@puiterwijk.org
Subject: Re: [PATCH v12 02/10] crypto: Add support for ECDSA signature
 verification
Message-ID: <ZpfuqeSVC47jqme2@wunner.de>
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
 <20210316210740.1592994-3-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316210740.1592994-3-stefanb@linux.ibm.com>

Hi Stefan,

On Tue, Mar 16, 2021 at 05:07:32PM -0400, Stefan Berger wrote:
> +/*
> + * Get the r and s components of a signature from the X509 certificate.
> + */
> +static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
> +				  const void *value, size_t vlen, unsigned int ndigits)
> +{
> +	size_t keylen = ndigits * sizeof(u64);
> +	ssize_t diff = vlen - keylen;
> +	const char *d = value;
> +	u8 rs[ECC_MAX_BYTES];
> +
> +	if (!value || !vlen)
> +		return -EINVAL;
> +
> +	/* diff = 0: 'value' has exacly the right size
> +	 * diff > 0: 'value' has too many bytes; one leading zero is allowed that
> +	 *           makes the value a positive integer; error on more
> +	 * diff < 0: 'value' is missing leading zeros, which we add
> +	 */
> +	if (diff > 0) {
> +		/* skip over leading zeros that make 'value' a positive int */
> +		if (*d == 0) {
> +			vlen -= 1;
> +			diff--;
> +			d++;
> +		}
> +		if (diff)
> +			return -EINVAL;
> +	}
> +	if (-diff >= keylen)
> +		return -EINVAL;

I'm in the process of creating a crypto_template for decoding an x962
signature as requested by Herbert:

https://lore.kernel.org/all/ZoHXyGwRzVvYkcTP@gondor.apana.org.au/

I intend to move the above code to the template and to do so I'm
trying to understand what it's doing.

There's an oddity in the above-quoted function.  The check ...

+	if (-diff >= keylen)
+		return -EINVAL;

... seems superfluous. diff is assigned the following value at the
top of the function:

+	ssize_t diff = vlen - keylen;

This means that:  -diff == keylen - vlen.

Now, if vlen is zero, -diff would equal keylen and then the
"-diff >= keylen" check would be true.  However at the top of
the function, there's already a !vlen check.  No need to check
the same thing again!

Next, I'm asking myself if -diff can ever be greater than keylen.
I don't think it can.  For that to be true, vlen would have to be
negative.  But vlen is of unsigned type size_t!

I just wanted to double-check with you whether ...

+	if (-diff >= keylen)
+		return -EINVAL;

... is indeed superfluous as I suspect or whether I'm missing
something.  I'm guessing that the check might be some kind of
safety net to avoid an out-of-bounds access in the memset()
and memcpy() calls that follow further down in the function,
in case sig->curve->g.ndigits was neglected to be set by the
programmer.  But there doesn't seem to be any real need for
the check, so I'm leaning towards not carrying it over to the
x962 template.

The check was already present in v1 of your ecdsa patch set:

https://lore.kernel.org/all/20210126170359.363969-2-stefanb@linux.vnet.ibm.com/

Thanks,

Lukas

