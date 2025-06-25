Return-Path: <linux-integrity+bounces-6536-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F90DAE906D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 23:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02993BE958
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516B21FF5B;
	Wed, 25 Jun 2025 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvtLsJPc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73C211A15;
	Wed, 25 Jun 2025 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888041; cv=none; b=iZIgV4sj6jQXMOoFKSpYBqN0BHdJpcrLIEXMfb7t/MQXCfTDaciz8W/ZtOdAwiUrIhjJLAybewrb7FGH3aviz8lHXmQmzcTmAKRMiHkdEi+SoTLMl3NbCAu6C4fLWq7gRWelKKu0r9esBLn9dugP9C8rjF6hTPPFpOvv10jNZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888041; c=relaxed/simple;
	bh=BmOzlOcWjjWYXOhk7oZaBIG/2AcVuM+tgXECnt/pDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts3lTGYis54AyfuSVzMBFliflAZ2zvW6YKglTedV+8wYG4G9Mn+fluJpwa3h/0P6H5/gc2mvrv8pQTc79wtRu7EiwW0ADSqR3Wj+3jH2K82P1YDsyR5bGK41/RzHZCRLbju+4iv2bdbkAeIDwGBXoAcsVTlmzTa+ssNt5mE0YnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvtLsJPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83176C4CEEA;
	Wed, 25 Jun 2025 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888040;
	bh=BmOzlOcWjjWYXOhk7oZaBIG/2AcVuM+tgXECnt/pDwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvtLsJPczkfTvI+ONrxnTt4krdlCwteKTmKK5QiCfn194xPML/Pmhl745tnqu4+7S
	 F5uBeZS+yBYhwIUfuB37Bt2Sbt44zh0fW41stK6LHLSG8/cyKZndigRP+L/iKuVzkx
	 7qvTfwhRWAwbFhHJIt4h38ZZ+ttARPymubS36qwgjEpBd5ZnypJt+NzsZ+Y3p+KHAW
	 jFWV2VPM0VthGTWSLrc/P3Z1nT+l02gzedl82jfg793epTw/JfsYdGmmAbj2KTB7tg
	 BP1Vpmmz8owtG/CPrhcymH3x9pnik+p79AiL/EDd9xIkOCQY71Jx2JdY+FyNaLBAqc
	 cNMImaOreT4kA==
Date: Thu, 26 Jun 2025 00:47:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <aFxuZV3lwd2Uc90g@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
 <aFvRI5OwSLLKz300@e129823.arm.com>
 <aFwrBU4H0w9AXyQM@kernel.org>
 <aFwrf1HnsilrASzX@kernel.org>
 <20250625-chital-of-infinite-proficiency-fee4dc@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-chital-of-infinite-proficiency-fee4dc@sudeepholla>

On Wed, Jun 25, 2025 at 08:35:33PM +0100, Sudeep Holla wrote:
> On Wed, Jun 25, 2025 at 08:01:51PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Jun 25, 2025 at 07:59:53PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Jun 25, 2025 at 11:36:19AM +0100, Yeoreum Yun wrote:
> > > > Hi Jarkko,
> > > > 
> > > > > On Wed, Jun 18, 2025 at 11:23:00AM +0100, Yeoreum Yun wrote:
> > > > > > To ensure the TPM device operating over the FF-A protocol with
> > > > > > the CRB interface is probed before IMA initialization,
> > > > > > the following conditions must be met:
> > > > > >
> > > > > >    1. The corresponding ffa_device must be registered,
> > > > > >       which is done via ffa_init().
> > > > > >
> > > > > >    2. The tpm_crb_driver must successfully probe this device via
> > > > > >       tpm_crb_ffa_init().
> > > > > >
> > > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > > >       be probed successfully. (See crb_acpi_add() and
> > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > >
> > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > > >
> > > > > I get the ffa_init() part i.e, moving it earlier. However for
> > > > > tpm_crb_ffa_init() and crb_acpi_driver_init(), modules.dep
> > > > > takes care that they are loaded in order.
> > > > > For IMA you will need the driver as built-in but that should
> > > > > be handled via kernel config, not via code changes.
> > > > 
> > > > In the case of "module" built, it's true.
> > > > However what I tell here is when "tpm_crb" and "tpm_crb_ffa" is built
> > > > as "built-in" in this case, it couldn't make a "dependency" between
> > > > the same initcall level: here is the case of this.
> > > > 
> > > > 0000000000000888 l       .initcall6.init>-------0000000000000000 crb_acpi_driver_init
> > > > 000000000000088c l       .initcall6.init>-------0000000000000000 tpm_crb_ffa_driver_init
> > > > 
> > > > in this case, wihtout code change, the crb_acpi_driver_init()
> > > > is failed since tpm_crb_ffa_driver_init() is called later.
> > > > 
> > > > and this couldn't be solved with kconfig --
> > > > ARM_FFA_TRANSPORT=y && CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y.
> > > > 
> > > > The Patch #2 is to proing the tpm_crb_ffa as part of
> > > > crb_acpi_driver_init() when TPM uses method ARM-FFA.
> > > > 
> > > > If there's another suggestion, let me know please.
> > > 
> > > Hmm.. I actually got what you mean now. I was looking this from
> > > wrong angle. I think we can pick these patches!
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > > 
> > > > Thanks
> > > > 
> > > > --
> > > > Sincerely,
> > > > Yeoreum Yun
> > > 
> > > BR, Jarkko
> > 
> > Applied.
> 
> If you are applying 1/2 too, feel free to add
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> I was initially thinking of taking it separately as there is no strict
> build dependency. But I am fine if you can take them together.

Hmm.. Yeah, if you insist to take them, that's fine for me too.

That said, I'm also happy to take care of them :-)

I'll append your review.

> 
> -- 
> Regards,
> Sudeep

BR, Jarkko

