Return-Path: <linux-integrity+bounces-5235-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87131A5D1A9
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECE67A3CAE
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5936229B17;
	Tue, 11 Mar 2025 21:17:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BC226545;
	Tue, 11 Mar 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727828; cv=none; b=c8y0f+yFUY0KgPpMPgUPZZvkQk1b4DZFr1c0lfhAPfAz4bHIG2Sr3fg9MjOLS7i+BUoeQ34EDAQ3RtY+VsQEHOmbIXDX250qIhcQ1Rk4yT11RB+mvNFqu7y8xGDsUsn1SIc+CMPCGrClVgxfZHmMgZtrW/4jaZGmbqCxYMAbpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727828; c=relaxed/simple;
	bh=mZDR/Pcsay1EeTp2DTUelSVI1Nq0MB+aAtVqD7intt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl4/+iYR3aPeszd9Gq/R4FhMFf3Tgjr4N84GopA0DXa8mOfREYzRMOAj91na7JSfcqI8/E3mIvb7QJVPashQ2P7Ll487JN7W1kpVnuG/9+jnGFeJqOckYbR4Dvwtv2gE2GE47xLpbPhhEN6G+byw7E90eybPC34oPc2D92J9xCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27CBB152B;
	Tue, 11 Mar 2025 14:17:17 -0700 (PDT)
Received: from bogus (unknown [10.57.39.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4F3D3F673;
	Tue, 11 Mar 2025 14:17:03 -0700 (PDT)
Date: Tue, 11 Mar 2025 21:17:00 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, jarkko@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, rafael@kernel.org, jgg@ziepe.ca, peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: Build error on -next due to tpm_crb.c changes?
Message-ID: <20250311211700.bwizwecxyxorrwql@bogus>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
 <92bc0a65-608f-4307-bb1c-16d8836d42e5@arm.com>
 <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
 <23c77291-7c6e-45ea-b1ad-952c01882579@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c77291-7c6e-45ea-b1ad-952c01882579@arm.com>

On Tue, Mar 11, 2025 at 01:25:50PM -0500, Stuart Yoder wrote:
> 
> 
> On 3/11/25 11:51 AM, Thorsten Leemhuis wrote:
> > On 11.03.25 16:53, Stuart Yoder wrote:
> > > On 3/11/25 10:21 AM, Thorsten Leemhuis wrote:
> > > > On 05.03.25 18:36, Stuart Yoder wrote:
> > > [...]
> > > So, it should not be possible on one had have
> > > CONFIG_TCG_ARM_CRB_FFA being true when building tpm_crb.c
> > > and false resulting in the tpm_crb_ffa.o not being
> > > picked up in the build.
> > 
> > Many thx for the answer. Maybe Fedora's way to prepare the .config files
> > (which my package builds use to be close to Fedora's official packages)
> > is doing something odd/wrong. Will take a closer look and report back.
> 
> I've been experimenting with some different build config combinations
> and have reproduced what must be the issue.
> 
> This works fine:
> <*>   TPM 2.0 CRB Interface                                         < >
> TPM CRB over Arm FF-A Transport
> 
> This works fine:
> < >   TPM 2.0 CRB Interface                                         <*>
> TPM CRB over Arm FF-A Transport
> 
> This works fine:
> <*>   TPM 2.0 CRB Interface                                         <*>
> TPM CRB over Arm FF-A Transport
> 
> This works fine:
> <M>   TPM 2.0 CRB Interface                                         <M>
> TPM CRB over Arm FF-A Transport
> 
> This fails:
> <*>   TPM 2.0 CRB Interface                                         <M>
> TPM CRB over Arm FF-A Transport
> 
> The 2 drivers are coupled, so we can't have one built as a module
> and the other built-in.
> 
> I'm not a Kconfig expert, and need to do some fiddling to see
> if I can find a Kconfig syntax that prevents that failure scenario.
> 

	default y if (TCG_CRB && ARM_FFA_TRANSPORT)

is the issue here. You can select it as built-in if either or one of the
TCG_CRB and ARM_FFA_TRANSPORT is a module, but that is exactly what happens.
Not sure if default value is a must for you. But just depends on each of
these should be good enough and enable it in defconfig if needed. Or
you can have multiple default at least 4 combinations I can see. Both
are =y and either and both are =m

--
Regards,
Sudeep

