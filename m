Return-Path: <linux-integrity+bounces-5341-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00215A6A94A
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B833B7D10
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F491DE8B4;
	Thu, 20 Mar 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCF7UO8O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406B8F6E;
	Thu, 20 Mar 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482934; cv=none; b=C9yfLnqVW9/maKUGg6Lt9kBQ08H9a3zG2GvDMwJeVs7ToWK7Es3PneN19xD1urq24X2Y/RzZcwPLECvYp4PdUK2+TZMi38pbIWRlaZ4DEMPKznwveHyKD6Xpl1T5qUBmMcFGgvZJaX8bcYD1ImvBHjBCHPVkR1EP5Rq3tNHYGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482934; c=relaxed/simple;
	bh=GScx7v1DB+peoikwJcbCBTD5+TH21YH6ulY+itNoyaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GanXOOmLCi5vp11Aft0w7dic5myaK0K6zPXXLzN8b2EcktIAUZM+0GQFUIaLNTLcuLO+GO5WYR+ywH5wXTxRauCTbJNbwc3svMdCWlkXY6QHOiZqcHL2HwiBgoq77h7OSmFGeF937w+gZwCDo6furj4sq2IVR/epwwyIAxmToo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCF7UO8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7BEC4CEDD;
	Thu, 20 Mar 2025 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482933;
	bh=GScx7v1DB+peoikwJcbCBTD5+TH21YH6ulY+itNoyaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCF7UO8OTLEpYla8Np1Nni4VhxyluqH2ma0n80LLMr0TO8qHJQexViPiSm+FWRcMk
	 LeggL64kHd88RyBEwsigeRwu8LIVvbCQjAG7ZaeSnQ187oDJtfqZLsh9zdUBWft+EO
	 hiTicb4BUjZekXj8kM6QUvmhteW0ICUWj4zcGQsvGdxYYbNd2b9R1GgpHkIPMdGTB3
	 1sqYb4NjqhFp4oUBdCyPVsCTb9VzBdLJoxl1c/6E89RPc4/2LZd46Bn01qFgjvIKod
	 a4JzqJMu2gVe+7MotBqBmSEQx0xH9CWgTGWug7ANS38VaPOUV92fDmBDhoLbVwJGvN
	 +E4mbs+OAw5AQ==
Date: Thu, 20 Mar 2025 17:02:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <Z9wt8EXI5wL1OaSK@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-5-sgarzare@redhat.com>
 <7c35f370-f1f2-7100-3b78-b595e977e964@amd.com>
 <Z9gk0jg1JLZY4Fk9@kernel.org>
 <nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u>

On Tue, Mar 18, 2025 at 11:44:05AM +0100, Stefano Garzarella wrote:
> On Mon, Mar 17, 2025 at 03:34:10PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Mar 14, 2025 at 11:56:31AM -0500, Tom Lendacky wrote:
> > > On 3/11/25 04:42, Stefano Garzarella wrote:
> > > > SNP platform can provide a vTPM device emulated by SVSM.
> > > >
> > > > The "tpm-svsm" device can be handled by the platform driver added
> > > > by the previous commit in drivers/char/tpm/tpm_svsm.c
> > > >
> > > > The driver will call snp_svsm_vtpm_probe() to check if SVSM is
> > > > present and if it's support the vTPM protocol.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > >  arch/x86/coco/sev/core.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > > > index 2166bdff88b7..a2383457889e 100644
> > > > --- a/arch/x86/coco/sev/core.c
> > > > +++ b/arch/x86/coco/sev/core.c
> > > > @@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
> > > >  	.id		= -1,
> > > >  };
> > > >
> > > > +static struct platform_device tpm_svsm_device = {
> > > > +	.name		= "tpm-svsm",
> > > > +	.id		= -1,
> > > > +};
> > > > +
> > > >  static int __init snp_init_platform_device(void)
> > > >  {
> > > >  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > > > @@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
> > > >  	if (platform_device_register(&sev_guest_device))
> > > >  		return -ENODEV;
> > > >
> > > > +	if (platform_device_register(&tpm_svsm_device))
> > > > +		return -ENODEV;
> > > > +
> > > 
> > > You could avoid registering the device if an SVSM isn't present. Not sure
> > > if that is desirable or not.
> > 
> > Is there any use for the device if an SVSM isn't present? :-)
> > 
> > I'd judge it based on that...
> 
> I tried to keep the logic of whether or not the driver is needed all in the
> tpm_svsm_probe()/snp_svsm_vtpm_probe() (where I check for SVSM).
> If you prefer to move some pieces here, though, I'm open.

OK good point, thanks! Let's look the update as a whole and not touch
on this. There's already quite a few pieces moving. Ignore this for
the moment :-)

> 
> Thanks,
> Stefano
> 

BR, Jarkko

