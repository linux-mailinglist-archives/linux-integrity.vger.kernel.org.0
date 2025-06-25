Return-Path: <linux-integrity+bounces-6525-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19EAE8B0F
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E243A222A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D542D5417;
	Wed, 25 Jun 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McC4L7i7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20968285C92;
	Wed, 25 Jun 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870794; cv=none; b=mYuMwpXPOt2aOicXsJLV6X86qJARmIRE9bLsnD0VIPf5JRqU0Lkok9ekrjbUPS7M6ewMZV0JV3DOJlY/owjn+b/ZOM2CqK26JQhEJGj3ewtMsM+nzp7TTkOaR5F4606UMMwOeuiIgRNmzVk86yTf0bn11hWeTE5PCrYu3+qRbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870794; c=relaxed/simple;
	bh=xYqSrzoie4XMkPburPrOeUmzOY0bsFg8Tsoegetll/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZHExHwbnmgWxM2JXhfZklvHewddIiF4wBJMt32ub46svdYqT13DXam5t7a8QxsW94p+A+Dyq0m4A0WWz5xJ2po+99Q1tpSCEFq6dN/t7fJrGOgWDoLpm1B56AlVPLy0K74sIZMKORYu0hzRJD3oWOissyuTMPBhR2s/WM1IH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McC4L7i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1025C4CEEA;
	Wed, 25 Jun 2025 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870793;
	bh=xYqSrzoie4XMkPburPrOeUmzOY0bsFg8Tsoegetll/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McC4L7i7HSCu8w701Y5+VBuEKOUQ5wnSlT8RcEaOt+3OrbwoP+OQa/uXw1rv2evSL
	 9qHhUgUPwHzRmcr6wa+vcpCSiWSZte7YAFrC3w0sUKAjBUvK/T0/sYgLCkI0mHFuoC
	 JQmI6KomKHSRFb2Xro4scgotPeDDbEX6Kr88A1hNo80e/ZglUrUlollvFkOaITw7aV
	 5BhRU5zkOyNcUxH0nq8HRgeM08mAvKuzHHQAlLh8YA89oS7zOc1hbIDhL1+STOFodH
	 BCPSdfA45qn3QYin/nEgxlw7Kfj6Vl4Oj529t7aUtGNOvwRls0fDQsAmC6GPJWosQr
	 jRHPKhiMPKEYQ==
Date: Wed, 25 Jun 2025 19:59:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <aFwrBU4H0w9AXyQM@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
 <aFvRI5OwSLLKz300@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvRI5OwSLLKz300@e129823.arm.com>

On Wed, Jun 25, 2025 at 11:36:19AM +0100, Yeoreum Yun wrote:
> Hi Jarkko,
> 
> > On Wed, Jun 18, 2025 at 11:23:00AM +0100, Yeoreum Yun wrote:
> > > To ensure the TPM device operating over the FF-A protocol with
> > > the CRB interface is probed before IMA initialization,
> > > the following conditions must be met:
> > >
> > >    1. The corresponding ffa_device must be registered,
> > >       which is done via ffa_init().
> > >
> > >    2. The tpm_crb_driver must successfully probe this device via
> > >       tpm_crb_ffa_init().
> > >
> > >    3. The tpm_crb driver using CRB over FF-A can then
> > >       be probed successfully. (See crb_acpi_add() and
> > >       tpm_crb_ffa_init() for reference.)
> > >
> > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> >
> > I get the ffa_init() part i.e, moving it earlier. However for
> > tpm_crb_ffa_init() and crb_acpi_driver_init(), modules.dep
> > takes care that they are loaded in order.
> > For IMA you will need the driver as built-in but that should
> > be handled via kernel config, not via code changes.
> 
> In the case of "module" built, it's true.
> However what I tell here is when "tpm_crb" and "tpm_crb_ffa" is built
> as "built-in" in this case, it couldn't make a "dependency" between
> the same initcall level: here is the case of this.
> 
> 0000000000000888 l       .initcall6.init>-------0000000000000000 crb_acpi_driver_init
> 000000000000088c l       .initcall6.init>-------0000000000000000 tpm_crb_ffa_driver_init
> 
> in this case, wihtout code change, the crb_acpi_driver_init()
> is failed since tpm_crb_ffa_driver_init() is called later.
> 
> and this couldn't be solved with kconfig --
> ARM_FFA_TRANSPORT=y && CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y.
> 
> The Patch #2 is to proing the tpm_crb_ffa as part of
> crb_acpi_driver_init() when TPM uses method ARM-FFA.
> 
> If there's another suggestion, let me know please.

Hmm.. I actually got what you mean now. I was looking this from
wrong angle. I think we can pick these patches!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> 
> Thanks
> 
> --
> Sincerely,
> Yeoreum Yun

BR, Jarkko

