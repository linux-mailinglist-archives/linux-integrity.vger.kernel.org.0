Return-Path: <linux-integrity+bounces-3665-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F997E895
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634B0B20462
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151731946B8;
	Mon, 23 Sep 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="omwoKTT8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F91940B0;
	Mon, 23 Sep 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083592; cv=none; b=jxSHgSVdvC4aTyMIkWndC5c5jYZxYAm9FENJ8YvmK35uRoOVUcAkx1jv5t3GUEZG3/VALcLnLyCYopISYf/8VXJeb/QcSMZn+LLIkdjLe8NevoC2+drDvVIfZqBQze8TbPxi6wfHJPBs/k7ArKX+kRD3oIANfA9ygpMq/A2j7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083592; c=relaxed/simple;
	bh=CRdGZ5sGgcmf/LJvWGU1wTRTQWS1yWvpT0UsRqAtB90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsqSzzTerYRQmV0jbO+soudTsoG+xT4cuXUh8HoSOQyoACaqhb1hZWx8msHflFST+B8h8jZuctiGUgPcsmU9e3DU0CLy7frrb7Z1QM34EinJqKdcpMoeB4BRPdurMNfdn0xfc+DYiiCip5PWjVz2e/A30XYPlIr00kAyriy83yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=omwoKTT8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MyQNaIwuwVveK/EF3pASJW2zkEi7KrMU0/ZkTG4x0nc=; b=omwoKTT8U+z8MIrxhWorPwhbOI
	pNRFdB1zwzXgX7fMhbFS8abEtgzQKcTeRn42tRwjVZE6Kg/xUq62UM8TYoQg2/fA00O25SwYhyI3z
	TJBYEysHGFkgfWO2kEcdnHgCMqbVDQzzLWIP1VrAXo/dwsyQvBaf3h/ot+wrNvX4aNdO6EReLbk5d
	S7AIZDE7FHroutk2FSF3tsNFxtGiB54JJTxrMbuj3KkUW4nNVsGUxVarT3AaXkCZCjxWOBCXCPyO8
	kpDBJJJrmbrp8PziobSx9f9saUCXIU9wBj9rVK/d1vTeDTs1D8C6ixrPldO9g+1/zVDMPcoGATQP7
	dMYCqxGg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ssfAn-0044Hn-0T;
	Mon, 23 Sep 2024 17:26:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 23 Sep 2024 17:26:14 +0800
Date: Mon, 23 Sep 2024 17:26:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
Message-ID: <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>

On Mon, Sep 23, 2024 at 10:52:49AM +0300, Jarkko Sakkinen wrote:
> On Mon Sep 23, 2024 at 9:05 AM EEST, Herbert Xu wrote:
> > Dear TPM maintainers:
> 
> There's really only just me (for past 10 years). Maybe that should be
> updatred.

:)

> >  	BUG_ON(!mutex_is_locked(&reading_mutex));
> > -	if (rng->read)
> > -		return rng->read(rng, (void *)buffer, size, wait);
> > +	if (rng->read) {
> > +		int err;
> > +
> > +		err = rng->read(rng, buffer, size, wait);
> > +		if (WARN_ON_ONCE(err > 0 && err > size))
> 
> Are you sure you want to use WARN_ON_ONCE here instead of
> pr_warn_once()? I.e. is it worth of taking down the whole
> kernel?

Absolutely.  If this triggers it's a serious kernel bug and we
should gather as much information as possible.  pr_warn_once is
not the same thing as WARN_ON_ONCE in terms of what it prints.

If people want to turn WARNs into BUGs, then they've only got
themselves to blame when the kernel goes down.  On the other
hand perhaps they *do* want this to panic and we should hand
it to them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

