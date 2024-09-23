Return-Path: <linux-integrity+bounces-3669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB197ED58
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C7281A64
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388DD78C67;
	Mon, 23 Sep 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jjLUSKzh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAA77F13;
	Mon, 23 Sep 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102912; cv=none; b=aKV3OsXshSKWkZb/I8lIfu0+cu1Cr7fvHlOfjIAzeFeMs6aAqwFriFgx96z3yvXKUKXTCsp87PRM59OfYruHs95TfHaJYBJ5yloX55yElB7Q1x6zclDgjugAmq+Csc5P7lvcUNX+aebchnhyOatByx/5NhHTULGPCxmny4L1LVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102912; c=relaxed/simple;
	bh=tByN5vh1UH7dCw150VKNLMK7ecfdnpT2N9aRTF3vmC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgcgyFaVhsv6xpAHd7JATxUtqvn4whW4xLKyDKT2kslgx16ausRqQFiqpkcIjqzz+45IsOF8QpjehVhIXwRYhMKLR6tp27del5ThYD3lX6NEPMewpX0gb2CYpqrU8+1rABnEPGWkhzdBm7AcLrhdXQ93ee19e7CGpiTBuENUvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jjLUSKzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4C9C4CEC4;
	Mon, 23 Sep 2024 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727102911;
	bh=tByN5vh1UH7dCw150VKNLMK7ecfdnpT2N9aRTF3vmC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjLUSKzh8tfGsls/q0RaLCS8puPvulGuHwdKQyE4bBhC/WkGxsRGySZGMrUkCvdeq
	 DvAlsfXUU++tLsCgG3DDwDVXmtj7UIVNNWYRmA+hq3VI2TE3WruQA23kRRuj1zf4Bc
	 3sg2mhJ1hE5WwX7Ikwee2tLr4CWLqCl0qaH8z/+k=
Date: Mon, 23 Sep 2024 16:48:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
Message-ID: <2024092340-renovate-cornflake-4b5e@gregkh>
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>

On Mon, Sep 23, 2024 at 05:31:47PM +0300, Jarkko Sakkinen wrote:
> On Mon Sep 23, 2024 at 12:26 PM EEST, Herbert Xu wrote:
>  > > +
> > > > +		err = rng->read(rng, buffer, size, wait);
> > > > +		if (WARN_ON_ONCE(err > 0 && err > size))
> > > 
> > > Are you sure you want to use WARN_ON_ONCE here instead of
> > > pr_warn_once()? I.e. is it worth of taking down the whole
> > > kernel?
> >
> > Absolutely.  If this triggers it's a serious kernel bug and we
> > should gather as much information as possible.  pr_warn_once is
> > not the same thing as WARN_ON_ONCE in terms of what it prints.
> 
> Personally I allow the use of WARN only as the last resort.
> 
> If you need stack printout you can always use dump_stack().
> 
> >
> > If people want to turn WARNs into BUGs, then they've only got
> > themselves to blame when the kernel goes down.  On the other
> > hand perhaps they *do* want this to panic and we should hand
> > it to them.
> 
> Actually when you turn on "panic_on_warn" the user expectation is and
> should be that the sites where WARN is used have been hand picked with
> consideration so that panic happens for a reason.
> 
> This has also been denoted repeatedly by Greg:
> 
> https://lore.kernel.org/linux-cve-announce/2024061828-CVE-2024-36975-6719@gregkh/
> 
> I should check this somewhere but actually these days a wrongly chosen
> WARN() might lead to CVE entry. That fix was by me but I never created
> the CVE.
> 
> Greg, did we have something under Documentation/ that would fully
> address the use of WARN?

Please see:
	https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
which describes that.  We should make it more explicit that any WARN()
or WARN_ON() calls that can be hit by user interactions somehow, will
end up getting a CVE id when we fix it up to not do so.

thanks,

greg k-h

