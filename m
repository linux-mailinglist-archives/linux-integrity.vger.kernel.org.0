Return-Path: <linux-integrity+bounces-6246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB47ABB481
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 07:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AE171460
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 05:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033731F30CC;
	Mon, 19 May 2025 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="msxgBqP+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6712A2D;
	Mon, 19 May 2025 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634240; cv=none; b=hVvHytOWbmuAMGhhpUCTJ1XnGcChPymebndbAq9xQMXm3uCM3EyFG/rbqpJiqH+/O0YPAAl5zPT0mTtHvuxdj1dyIlAmLIJZaraLsU8xyC18xXzZ6OmnjmduWZeoTIVWoXdFIPH0RjJJf64AUKvsJwyIaqP8b6IL3cvPtdkj+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634240; c=relaxed/simple;
	bh=mZBKw0wJmnWieD8RvOZ90E/QZ8DajgvOAWCuVqPbx2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEE4s+Dqdu+bilABmXhFzG56V2aHonrwuezqnCXR52sWqihAWn5p1ygC7NGLWzQGW4SAxVCUIXgXvCV+wL7Mdvm1TbNMN3VEqqSlybYf+ZuOotHHMLNorJlwwdwWORz4waZklkCbSlcQT/FbKke4wYU8gIzr4CJma4vNt+90qJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=msxgBqP+; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0zbSZULwMpBsF35qyqNlWF7Y18GG1Lj98fZQ/4Oi5ek=; b=msxgBqP+mlc27kvWTMpX+7lLkG
	FhOl3sHQMXsS7oZlHmgJ1OFuwBBVVYPNVHNX3TMIdMqzzYc5HgVu8vdbDF6VvRGRCsPSJker9IyGo
	95uClxLl2t+tWdQN2harV7L0oG/Xoo+J5Wzd2eo/Q420D9qHClavW0aHcz7ztbZVtbQCRcC4sZZ+N
	2l2yG8qzY4AqBdFYYYRyry2O1XaCSBP7lG9WGmZFRPCnR+vb7b1mvl1lXTN8yf+akDd3LYO+Rvs0N
	xZogCW0da3J43CBa5OhsK/ZXwiGe0fKLDNiiuT240Rd9u7PYZYSWieBcatDcYajVrsQh8JDmB/HRW
	1+4VKTeg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uGtUl-00781A-0x;
	Mon, 19 May 2025 13:57:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 19 May 2025 13:57:03 +0800
Date: Mon, 19 May 2025 13:57:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 2/5] crypto: loongson - add Loongson RNG driver support
Message-ID: <aCrIL_ZXL-UtaLdJ@gondor.apana.org.au>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506031947.11130-3-zhaoqunqin@loongson.cn>

On Tue, May 06, 2025 at 11:19:44AM +0800, Qunqin Zhao wrote:
>
> +static int loongson_rng_init(struct crypto_tfm *tfm)
> +{
> +	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct loongson_rng *rng;
> +	int ret = -EBUSY;
> +
> +	mutex_lock(&rng_devices.lock);
> +	list_for_each_entry(rng, &rng_devices.list, list) {
> +		if (!rng->is_used) {
> +			rng->is_used = true;
> +			ctx->rng = rng;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&rng_devices.lock);
> +
> +	return ret;
> +}

This isn't right.  The number of TFMs in the system is unlimited.
You should not pair each tfm with an individual hardwre device.

If you want to do load-balancing you could certainly pick a device
per tfm, but each device must be able to support an unlimited number
of tfms.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

