Return-Path: <linux-integrity+bounces-3670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2B97F1C0
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 22:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915C62826D8
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D7433D6;
	Mon, 23 Sep 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khxs0hy4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E92E419;
	Mon, 23 Sep 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727124396; cv=none; b=TdzFOpY8T8BQ/jrusZhCkDPFgDaOCLrqbz8Nb0J7bN/WTGzW35nuor0LKiSO3MGwe76OlCH18CO+hMgE6DDyPa/kUxdKIXqN6euUl7VgaW77EvndlicfeKGz7PNfhBOVY2Q3qwlm0Ue97FrPpQxkvJsLUMCoYVkm5uwPc5cxSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727124396; c=relaxed/simple;
	bh=SgNoyKboi5V2VpCNRr61ECz+JfNJbVozSE+noXFP2PU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TDYyEs/0DTjVvvBvnSNUIdycmx0eqGfLd8rxflOuvxlX1GHv2bShDmhmfsjlbx2euCAWfjld+mxHWXlju2c4D8kvyLvpy+in0trLTtfASXA/js9xBtsqta22sUUvZSPBDtf9hRz6ptUq7/Tl8GJmjGpgOGQeScCHvLPbZUZhfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khxs0hy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5864AC4CEC4;
	Mon, 23 Sep 2024 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727124395;
	bh=SgNoyKboi5V2VpCNRr61ECz+JfNJbVozSE+noXFP2PU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Khxs0hy40z4owyoWRmbJQ01N+HDL2AmzJ0DmiVlVuNxVqce+aW39WraoGOXp5W0Mf
	 AO09iHKQagKI//au1K5WHnnG1mnIuLqRkstXDQp5QaLAkC1lmcj6mTnZgXAtlGpvcT
	 ikMcbYunPhN5KvlPFh2BUZR557RKmJMWJz2M8l4KMCGAIUvSD+47C7P1sjuwFeE8bw
	 9D9CUUU4UoTKJzPURfFOPJK/EQIJcuoh0e2RV3vPl37Cufoh4LPBKVswH4nLOHCniA
	 iEGKJJ2N9c32QWoaJA6dCmeMmfwzV/qH6+T2z6jyjrxviUad9UxCRcEelYXK/A3Aij
	 tiQIsPvg+Gz1g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 23:46:31 +0300
Message-Id: <D4DYI04PH9Z2.2K3P7ZZAQX3U3@kernel.org>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Guangwu Zhang" <guazhang@redhat.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
 <2024092340-renovate-cornflake-4b5e@gregkh>
In-Reply-To: <2024092340-renovate-cornflake-4b5e@gregkh>

On Mon Sep 23, 2024 at 5:48 PM EEST, Greg KH wrote:
> On Mon, Sep 23, 2024 at 05:31:47PM +0300, Jarkko Sakkinen wrote:
> > On Mon Sep 23, 2024 at 12:26 PM EEST, Herbert Xu wrote:
> >  > > +
> > > > > +		err =3D rng->read(rng, buffer, size, wait);
> > > > > +		if (WARN_ON_ONCE(err > 0 && err > size))
> > > >=20
> > > > Are you sure you want to use WARN_ON_ONCE here instead of
> > > > pr_warn_once()? I.e. is it worth of taking down the whole
> > > > kernel?
> > >
> > > Absolutely.  If this triggers it's a serious kernel bug and we
> > > should gather as much information as possible.  pr_warn_once is
> > > not the same thing as WARN_ON_ONCE in terms of what it prints.
> >=20
> > Personally I allow the use of WARN only as the last resort.
> >=20
> > If you need stack printout you can always use dump_stack().
> >=20
> > >
> > > If people want to turn WARNs into BUGs, then they've only got
> > > themselves to blame when the kernel goes down.  On the other
> > > hand perhaps they *do* want this to panic and we should hand
> > > it to them.
> >=20
> > Actually when you turn on "panic_on_warn" the user expectation is and
> > should be that the sites where WARN is used have been hand picked with
> > consideration so that panic happens for a reason.
> >=20
> > This has also been denoted repeatedly by Greg:
> >=20
> > https://lore.kernel.org/linux-cve-announce/2024061828-CVE-2024-36975-67=
19@gregkh/
> >=20
> > I should check this somewhere but actually these days a wrongly chosen
> > WARN() might lead to CVE entry. That fix was by me but I never created
> > the CVE.
> >=20
> > Greg, did we have something under Documentation/ that would fully
> > address the use of WARN?
>
> Please see:
> 	https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-b=
ug-on
> which describes that.  We should make it more explicit that any WARN()
> or WARN_ON() calls that can be hit by user interactions somehow, will
> end up getting a CVE id when we fix it up to not do so.

I bookmarked this thanks :-)

Herbert, I'll do comprehensive testing tmrw by adding some invariants to
tpm2_get_random(). I'd really love to reimplement it because the current
implementation frankly sucks (and it's by me) but yep, we nee to fix it
first and foremost.

>
> thanks,
>
> greg k-h


BR, Jarkko

