Return-Path: <linux-integrity+bounces-5290-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABAA6514F
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9875C1886E27
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F12405E9;
	Mon, 17 Mar 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJzEmRXp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710D156230;
	Mon, 17 Mar 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218454; cv=none; b=fIZA9hxxf1lXkhKBBqXc/uYP7YjqiucX5LrmMC/tEE+dZYSVT+arJPHGrfjK6qZnSJSfNLpY0qRdq9jWh7nrsVQsrHI+/VUWZ7AJQ91LfOoE2bhwBL6nltx6JTmh/mMdDRYLNyKRr4zDBSH3ARmKvke6+qBg/hoDnWjilfiPCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218454; c=relaxed/simple;
	bh=jKAJx1ca2J5NWV89rvPocdT0rc2DE0dwHLxgOYvhlUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/sVLOg3TDQVk5rkjhwM+BrR20GpCJXaV6Zklvh902ArLt0zDQYUXSpuHIRNqeHGy9hD8z1ATcwD1bs+4+eISnQo05F2pwXP116Tgdi/i+7DW96LANgtuye7cRXn2vgzaT1B7fxgngxPm7xTuxGBMWvo2L1jiZBlHBBoX/NhXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJzEmRXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A75C4CEE3;
	Mon, 17 Mar 2025 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742218454;
	bh=jKAJx1ca2J5NWV89rvPocdT0rc2DE0dwHLxgOYvhlUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJzEmRXpJzdO+0VOAAtkHB9n/GFpBL6GnbLZt5ZoBeZ9+EQujjHOTypd2n2NzYRO+
	 09y8qAgg+CdOvTbWsS027tIhNbMit3wRWfqBwXhEOSd2KawEe8+ndd1zyqneNlNtLG
	 V301MgIxoNN7GuIFw/yT/szIm29ZEMrnnRu/XYIitBDRxAXVReEEb9z9+Za3lEDpYY
	 vXmMmwdXCsLMhfoUciV6hQD+GW5/9XT63nYY5IhVD2HzCBSRVZBxtxQnLetZ7/sQvf
	 kLtLTAKkbU3IjgK5o7s/DIKKIjOLOY3roM6tlwaDkHiAcAyXJQ7BDprei+zF30RX30
	 MXqDHYMvIWwng==
Date: Mon, 17 Mar 2025 15:34:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <Z9gk0jg1JLZY4Fk9@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-5-sgarzare@redhat.com>
 <7c35f370-f1f2-7100-3b78-b595e977e964@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c35f370-f1f2-7100-3b78-b595e977e964@amd.com>

On Fri, Mar 14, 2025 at 11:56:31AM -0500, Tom Lendacky wrote:
> On 3/11/25 04:42, Stefano Garzarella wrote:
> > SNP platform can provide a vTPM device emulated by SVSM.
> > 
> > The "tpm-svsm" device can be handled by the platform driver added
> > by the previous commit in drivers/char/tpm/tpm_svsm.c
> > 
> > The driver will call snp_svsm_vtpm_probe() to check if SVSM is
> > present and if it's support the vTPM protocol.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  arch/x86/coco/sev/core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > index 2166bdff88b7..a2383457889e 100644
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
> >  	.id		= -1,
> >  };
> >  
> > +static struct platform_device tpm_svsm_device = {
> > +	.name		= "tpm-svsm",
> > +	.id		= -1,
> > +};
> > +
> >  static int __init snp_init_platform_device(void)
> >  {
> >  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> > @@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
> >  	if (platform_device_register(&sev_guest_device))
> >  		return -ENODEV;
> >  
> > +	if (platform_device_register(&tpm_svsm_device))
> > +		return -ENODEV;
> > +
> 
> You could avoid registering the device if an SVSM isn't present. Not sure
> if that is desirable or not.

Is there any use for the device if an SVSM isn't present? :-)

I'd judge it based on that...

> 
> Thanks,
> Tom
> 
> >  	pr_info("SNP guest platform device initialized.\n");
> >  	return 0;
> >  }
> 

BR, Jarkko

