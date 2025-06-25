Return-Path: <linux-integrity+bounces-6526-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF68AE8B27
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A70E4C0FF6
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD421ADC69;
	Wed, 25 Jun 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHYkKZdj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5915ADB4;
	Wed, 25 Jun 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870915; cv=none; b=iYqNDf4HcrgT0U9b4FrVLNJ3X2TZEXUMUhhxP1F9nI9U5UcxOI17JdIC1Gzh/QB1yq4HhZnSPRCM4EGu/CTHuIa6UcWNIaH1fcOB+IMyUFGoDmp+g8YBzvoszIa+aqxmBHbfb8J2BnZ9YwXBcvvAaoP9DBkz+8jTKdHHoZWOx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870915; c=relaxed/simple;
	bh=eALn9anayFEUy5QoMrVPaobWyJA2W/W/5mmJqhg2eeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RArOVNVs1RWrk9h1ca5Lhh4oHvXsDRh9zciOHSkCKILU5RkPpXvGuwMbE4P2OcwRXGgrcBZFl8+g5ufVRTcaxNnaf1ahzdkxRQFsC6NXYpAfof5QXKlgE6hKtT8U/YpUAXmAab4u7ie94D4QPR7zueEQ6g3wTtl+e9caFo9BS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHYkKZdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9E0C4CEEA;
	Wed, 25 Jun 2025 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870915;
	bh=eALn9anayFEUy5QoMrVPaobWyJA2W/W/5mmJqhg2eeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHYkKZdjYC4HV3b95BXhVaBQ9s+cmAywC5izCrtUMIZf1ZosFbgoewL5l91JXINjg
	 kcTtTEengp7ZpcB2mvHxoxfnoFydbYlTyyqTZLw/5s6S4ubK6LzxE3iYXMO+NTHNG+
	 /YGOlzi/g08ShWET1btNYKDuYi9ebTXY6JK/xv50U1gniwk8CJyf1oygZqsZT16Wzn
	 IaIiT0lbJ3N++5bn1j0w2X0tm/jD1/ot8BF7sfzvKrxbXyQJYjI4S9IO+cj1AXB8Qm
	 gA44VwxNEKcUDsnRheIO9FL06KloUdflmdcIo7SI+VVvg5M97UcycFzKKmjNqAr4aK
	 BRu3t/NkbfREg==
Date: Wed, 25 Jun 2025 20:01:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <aFwrf1HnsilrASzX@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
 <aFvRI5OwSLLKz300@e129823.arm.com>
 <aFwrBU4H0w9AXyQM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFwrBU4H0w9AXyQM@kernel.org>

On Wed, Jun 25, 2025 at 07:59:53PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 25, 2025 at 11:36:19AM +0100, Yeoreum Yun wrote:
> > Hi Jarkko,
> > 
> > > On Wed, Jun 18, 2025 at 11:23:00AM +0100, Yeoreum Yun wrote:
> > > > To ensure the TPM device operating over the FF-A protocol with
> > > > the CRB interface is probed before IMA initialization,
> > > > the following conditions must be met:
> > > >
> > > >    1. The corresponding ffa_device must be registered,
> > > >       which is done via ffa_init().
> > > >
> > > >    2. The tpm_crb_driver must successfully probe this device via
> > > >       tpm_crb_ffa_init().
> > > >
> > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > >       be probed successfully. (See crb_acpi_add() and
> > > >       tpm_crb_ffa_init() for reference.)
> > > >
> > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > >
> > > I get the ffa_init() part i.e, moving it earlier. However for
> > > tpm_crb_ffa_init() and crb_acpi_driver_init(), modules.dep
> > > takes care that they are loaded in order.
> > > For IMA you will need the driver as built-in but that should
> > > be handled via kernel config, not via code changes.
> > 
> > In the case of "module" built, it's true.
> > However what I tell here is when "tpm_crb" and "tpm_crb_ffa" is built
> > as "built-in" in this case, it couldn't make a "dependency" between
> > the same initcall level: here is the case of this.
> > 
> > 0000000000000888 l       .initcall6.init>-------0000000000000000 crb_acpi_driver_init
> > 000000000000088c l       .initcall6.init>-------0000000000000000 tpm_crb_ffa_driver_init
> > 
> > in this case, wihtout code change, the crb_acpi_driver_init()
> > is failed since tpm_crb_ffa_driver_init() is called later.
> > 
> > and this couldn't be solved with kconfig --
> > ARM_FFA_TRANSPORT=y && CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y.
> > 
> > The Patch #2 is to proing the tpm_crb_ffa as part of
> > crb_acpi_driver_init() when TPM uses method ARM-FFA.
> > 
> > If there's another suggestion, let me know please.
> 
> Hmm.. I actually got what you mean now. I was looking this from
> wrong angle. I think we can pick these patches!
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> > 
> > Thanks
> > 
> > --
> > Sincerely,
> > Yeoreum Yun
> 
> BR, Jarkko

Applied.

BR, Jarkko

