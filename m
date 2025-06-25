Return-Path: <linux-integrity+bounces-6533-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31592AE8ED3
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 21:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4987A5865
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9671FF7DC;
	Wed, 25 Jun 2025 19:35:43 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADA1FC8;
	Wed, 25 Jun 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880143; cv=none; b=VZ29OX7wmoGMKxDNJI3N3NqqrmX8mjqBVKm8Fkuvu/+Do1D41rgquDcGZcpGxuPT5rSwLnMe95B3QqHEs346kYF0kRC2GxSV4FTrOV/1tOm+WASgLy7PAhc4DLgvPblWHbyHXwtxl1KIa9WGtOZrPq9bFkgeZslQLacE55IPvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880143; c=relaxed/simple;
	bh=NI00kXAs2Sac4BxeyxGRa5cxRTMShWKol967nsdh3lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgSSjrFFFRbvu6Recyv9IpOUdHPMaTjnc0trjoH+kE0FGi7MrKVAatC5b+Mbi0PxkygIy6hiqLrwBer6ZswPgnVWLF2KLkdq4WlGowfNu+I48KmFIAu8P6ADB1TfWsMGVLfNDXscPl0dx0oHti/ZzfR4rQIC7QTq37er3BWSPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6D9B106F;
	Wed, 25 Jun 2025 12:35:22 -0700 (PDT)
Received: from bogus (unknown [10.57.49.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0404C3F58B;
	Wed, 25 Jun 2025 12:35:38 -0700 (PDT)
Date: Wed, 25 Jun 2025 20:35:33 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <20250625-chital-of-infinite-proficiency-fee4dc@sudeepholla>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
 <aFvRI5OwSLLKz300@e129823.arm.com>
 <aFwrBU4H0w9AXyQM@kernel.org>
 <aFwrf1HnsilrASzX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFwrf1HnsilrASzX@kernel.org>

On Wed, Jun 25, 2025 at 08:01:51PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 25, 2025 at 07:59:53PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Jun 25, 2025 at 11:36:19AM +0100, Yeoreum Yun wrote:
> > > Hi Jarkko,
> > > 
> > > > On Wed, Jun 18, 2025 at 11:23:00AM +0100, Yeoreum Yun wrote:
> > > > > To ensure the TPM device operating over the FF-A protocol with
> > > > > the CRB interface is probed before IMA initialization,
> > > > > the following conditions must be met:
> > > > >
> > > > >    1. The corresponding ffa_device must be registered,
> > > > >       which is done via ffa_init().
> > > > >
> > > > >    2. The tpm_crb_driver must successfully probe this device via
> > > > >       tpm_crb_ffa_init().
> > > > >
> > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > >       be probed successfully. (See crb_acpi_add() and
> > > > >       tpm_crb_ffa_init() for reference.)
> > > > >
> > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > >
> > > > I get the ffa_init() part i.e, moving it earlier. However for
> > > > tpm_crb_ffa_init() and crb_acpi_driver_init(), modules.dep
> > > > takes care that they are loaded in order.
> > > > For IMA you will need the driver as built-in but that should
> > > > be handled via kernel config, not via code changes.
> > > 
> > > In the case of "module" built, it's true.
> > > However what I tell here is when "tpm_crb" and "tpm_crb_ffa" is built
> > > as "built-in" in this case, it couldn't make a "dependency" between
> > > the same initcall level: here is the case of this.
> > > 
> > > 0000000000000888 l       .initcall6.init>-------0000000000000000 crb_acpi_driver_init
> > > 000000000000088c l       .initcall6.init>-------0000000000000000 tpm_crb_ffa_driver_init
> > > 
> > > in this case, wihtout code change, the crb_acpi_driver_init()
> > > is failed since tpm_crb_ffa_driver_init() is called later.
> > > 
> > > and this couldn't be solved with kconfig --
> > > ARM_FFA_TRANSPORT=y && CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y.
> > > 
> > > The Patch #2 is to proing the tpm_crb_ffa as part of
> > > crb_acpi_driver_init() when TPM uses method ARM-FFA.
> > > 
> > > If there's another suggestion, let me know please.
> > 
> > Hmm.. I actually got what you mean now. I was looking this from
> > wrong angle. I think we can pick these patches!
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > > 
> > > Thanks
> > > 
> > > --
> > > Sincerely,
> > > Yeoreum Yun
> > 
> > BR, Jarkko
> 
> Applied.

If you are applying 1/2 too, feel free to add

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I was initially thinking of taking it separately as there is no strict
build dependency. But I am fine if you can take them together.

-- 
Regards,
Sudeep

