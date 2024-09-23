Return-Path: <linux-integrity+bounces-3671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D28983A0F
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 01:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60AD282BFD
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2B12E1C2;
	Mon, 23 Sep 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="kqCtkUTx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE6132121;
	Mon, 23 Sep 2024 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130781; cv=none; b=BWG91ljZo0NOQzxWZxwFHXPTBb2VbN+2GUEi2aMm6viwn6E+FrOfEyNgGKu/1dw2qxNCOJfFsGxXWtsfvDDksEFL67p5gnEloXcWiAZEDtqQJrU+CCAj+5conInlMyY2HduIW38mzZomF9rhZTO4xMGWwXrN01KPVKdu/XOPYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130781; c=relaxed/simple;
	bh=DW6RzF0mCdF7+lRyFM/66mfnhezvNr6OXAwp+dwKO8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY8WlTldDiujZCZseTgmwcSQRMT1rE5OG4sYIL8WmbgqZW1+eQIKOl7hbvwQ1Cn0TYonQK4cg59C1x2t4hntcCeX+RPoYbh/eVnBE9rdmIeODcAzITNMMeD1TRmy+4vfnL/rzL7iMpdSqzFrxFv3mdjoUmjsva3a2Z45VpphQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=kqCtkUTx; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p9wfK6mAPEKDw21ZN4cbnbmS0ohf8UfeuQAQgG/ovb0=; b=kqCtkUTxn1TJZinMLEQhht+A8x
	CkvEmdhRuGnT3hMo2cAOiHSto4SfyIQHd1yZbajy4lG1HU4ApXVV8s+x3wIWm4AwKyGUrbqmsJLO8
	DqHhgQg6J4AyVu30AuBa3n3cXzTLO081MA6av9GnPP7gp9vaCgUQuk5Ux/KcU8qbe/q9m67f11tDr
	louUmnZutqrzkRu/tB/NFBa0bQwRctYiyYg9rG2sSaopA4YmLqgImHmfoQHymHqlch67F2oE4EKoj
	AUZ2UZHd7K+oUiJ1OMk5CIlZvxoCakCvdcb0+2SGIb9UIc0037wuC+sxL4LO3nvYx74choNjEKkCI
	Pj0GeOfw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ssrRp-004CHb-2D;
	Tue, 24 Sep 2024 06:32:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 24 Sep 2024 06:32:39 +0800
Date: Tue, 24 Sep 2024 06:32:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
Message-ID: <ZvHsh6by3omeYj9d@gondor.apana.org.au>
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
 <2024092340-renovate-cornflake-4b5e@gregkh>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024092340-renovate-cornflake-4b5e@gregkh>

On Mon, Sep 23, 2024 at 04:48:27PM +0200, Greg KH wrote:
>
> Please see:
> 	https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
> which describes that.  We should make it more explicit that any WARN()
> or WARN_ON() calls that can be hit by user interactions somehow, will
> end up getting a CVE id when we fix it up to not do so.

If the aformentioned WARN_ON hits, then the driver has probabaly
already done a buffer overrun so it's a CVE anyway.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

