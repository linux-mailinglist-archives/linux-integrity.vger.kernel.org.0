Return-Path: <linux-integrity+bounces-3667-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548A97ED2E
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465311C2132D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD077107;
	Mon, 23 Sep 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4wiu+Zz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9711392;
	Mon, 23 Sep 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101915; cv=none; b=VIun78crl3/0UpHxbGS9cbgrTUwDnTSC0O1YjE4GvzHOxCSYiOGvjBUUSM4h5zeiUhIXe+NvF5gW4khyxrEVJXpR5ha3JnEwiEApwoDH2yKCNkyR9OO65LVi1KeMYLFaThELK7+ds07gAXo/gK/9K9csNmddFNFUGxQvfWb7Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101915; c=relaxed/simple;
	bh=xZki1M+TR4AnYlnzOAj3r14noOi3RDkyifpFBDf0A78=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IRVLD/MHTMWwez51fD19b6xqekhMgATVfHDdEIQTuASuz3Is8/CBhdHCmOzMOYes3mRLmsdG6pK4OJN4xI1KoeUBhVOz5xBGfyBzZ3aymsDhR+GJWm5V+Y+LlWRGbYHRd3QzGVzTsOz7XyvKyOh3fp5HxidBXCJhsUigM1li/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4wiu+Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FB6C4CEC4;
	Mon, 23 Sep 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727101915;
	bh=xZki1M+TR4AnYlnzOAj3r14noOi3RDkyifpFBDf0A78=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=l4wiu+Zzw+vW5S0QjaIUDbuTV1JH2FDjOAaB5hSW3XJwZFX9VjySWuH4R/e1XdF2I
	 eIhT1opdmSeY1y/Yn/a54p7do9iWDtj1SVm3zzH1b9+if/JSiUkC+e5+CWVU0MxhO2
	 4baMt3ZHT4u1TaWumU91l9ks9W9zsS6b4M4LVOP6htnC1o6Fm3/sJj73NcRKHKnzD9
	 e1gktwHFfneK4MzkwgfJdM3nO47d49gYK3cUznV9rgL8PYJ8NgcATrykh0ACo6BBUp
	 HOjlvAgLsMz8e1EWvlLllKRdsAyIv6r4yHt28vkOTVyVP9pZf6F+zRr+5kB2C1WfdE
	 Y5dNsfzwhaVOw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 17:31:47 +0300
Message-Id: <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
Cc: "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>, "Guangwu
 Zhang" <guazhang@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Greg KH"
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
In-Reply-To: <ZvE0NrOC00ojRe3t@gondor.apana.org.au>

On Mon Sep 23, 2024 at 12:26 PM EEST, Herbert Xu wrote:
 > > +
> > > +		err =3D rng->read(rng, buffer, size, wait);
> > > +		if (WARN_ON_ONCE(err > 0 && err > size))
> >=20
> > Are you sure you want to use WARN_ON_ONCE here instead of
> > pr_warn_once()? I.e. is it worth of taking down the whole
> > kernel?
>
> Absolutely.  If this triggers it's a serious kernel bug and we
> should gather as much information as possible.  pr_warn_once is
> not the same thing as WARN_ON_ONCE in terms of what it prints.

Personally I allow the use of WARN only as the last resort.

If you need stack printout you can always use dump_stack().

>
> If people want to turn WARNs into BUGs, then they've only got
> themselves to blame when the kernel goes down.  On the other
> hand perhaps they *do* want this to panic and we should hand
> it to them.

Actually when you turn on "panic_on_warn" the user expectation is and
should be that the sites where WARN is used have been hand picked with
consideration so that panic happens for a reason.

This has also been denoted repeatedly by Greg:

https://lore.kernel.org/linux-cve-announce/2024061828-CVE-2024-36975-6719@g=
regkh/

I should check this somewhere but actually these days a wrongly chosen
WARN() might lead to CVE entry. That fix was by me but I never created
the CVE.

Greg, did we have something under Documentation/ that would fully
address the use of WARN?

BR, Jarkko

