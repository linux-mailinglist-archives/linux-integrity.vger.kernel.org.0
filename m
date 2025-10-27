Return-Path: <linux-integrity+bounces-7530-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49706C11414
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 20:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91D4547FAB
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149C3148C1;
	Mon, 27 Oct 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu0NuXtl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A544302CB9;
	Mon, 27 Oct 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594066; cv=none; b=AvsREHt4sWviT23sIa5zXCgE9dvIqpUICjnvA4tOxz2p/mXbtPwII/V8Ve2mbPVbaxZI2HvipAZf34QxLETZeO7E5e+eFeA9lW7cxlhMiepwgsXbELzZXYdVNbCX2sgR+0r7n5vIOHdC94/m2ozr6aY0gmGUg1Vft2YfOGjjpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594066; c=relaxed/simple;
	bh=TKSDAfKOKm2YDmGWIYXR8qtfSeiualYoO13eweUbLZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IflS2874eHV91ilxVke22TWX6mJqtiaIry+j6Ssaii7VO+Wg8N/Zjc4oCknfLwqgR1zM5j2ovLvUg2nd+2z3KMlD5TyKYHkwbW3OydSimsK97ox+asMwbG4W1h1I6eQboQOt5lHrkyhoHNmUChiBFe1aqhhfNgckV1JZjvPKESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu0NuXtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DE5C116B1;
	Mon, 27 Oct 2025 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761594065;
	bh=TKSDAfKOKm2YDmGWIYXR8qtfSeiualYoO13eweUbLZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xu0NuXtlHPaDOa1jpDcq2QGX8LB/1THbJMF1bv9EAiaiUl4P7yYq6yDjuBmb9g8nu
	 8U5VRzKcr/eMYPkTVJmpB8igdYdAiwmDHdmp0T3PphWpn0o+W2dsxJOSGJVioZPifK
	 bHIk3wsD6LUInLh6lOwIwmzPiNBO3Bo9HspIKf/nTQLdYaF00Jr7eexLqL4xhVV+JI
	 2y60O7eDZMXd84HDLCZMhbQCGb2GUrGRaMSuyGKaoa8aRkIfzRHOZellw4WZ/VyLra
	 o5ueOlx3JHHjlHiKIRyhAGv4iq4xH0ZS18PrwmNAEuK43ntbrASYnorAjWvlFJ9qbd
	 zOUyjPB7p/oEQ==
Date: Mon, 27 Oct 2025 21:41:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jonathan McDowell <noodles@earth.li>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] pm: Ensure exclusive userspace access when using
 /dev/tpm<n>
Message-ID: <aP_KzjRwZQBXPcXB@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
 <cover.1760958898.git.noodles@meta.com>
 <aPvLtt7a7X0Y1LBI@kernel.org>
 <6fe4fb1126f2d45b77637c34bf274bef4205a427.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe4fb1126f2d45b77637c34bf274bef4205a427.camel@linux.ibm.com>

On Mon, Oct 27, 2025 at 07:50:46AM -0400, Mimi Zohar wrote:
> On Fri, 2025-10-24 at 21:55 +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 20, 2025 at 12:30:32PM +0100, Jonathan McDowell wrote:
> > > I hit a problem where ~ 1% of TPM firmware upgrades were failing.
> > > Investigating revealed the issue was that although the upgrade tool uses
> > > /dev/tpm0 this does not actually prevent access via /dev/tpmrm0, nor
> > > internal kernel users. It *does* prevent access to others via /dev/tpm0
> > > 
> > > So the upgrade process started, the HW RNG came in to get some
> > > randomness in the middle, did the HMAC context dance, and confused
> > > everything to the point the TPM was no longer visible to the OS even
> > > after a reboot.
> > > 
> > > Thankfully I've been able to recover those devices, but really what I'd
> > > like is the ability for a userspace tool to exclusively access the TPM
> > > without something coming in behind it. Given the lightweight attempt at
> > > locking that already exists I think this was the original intention.
> > > 
> > > I've reworked this series based on feedback received.
> > > 
> > > Firstly, it's been reordered TPM sharing functionality doesn't break
> > > during bisection.
> > > 
> > > Secondly, the O_EXCL check has been tightend up to ensure the caller is
> > > also opening the device O_RDWR. Callers shouldn't really be opening the
> > > TPM except for reading + writing, but this should help guard against
> > > unexpected flags usage a bit more.
> > > 
> > > Finally, this revision keeps the prohibition on more than one user of
> > > /dev/tpm#, to avoid unexpected breakages for clients that expect this to
> > > guard against multiple invocations. A client only then needs to use
> > > O_EXCL if it wants to prevent *all* other access, even with
> > > ContextSaves, such as the firmware upgrade case.
> > > 
> > > (I've sent a separate standalone patch that allows the TPM HW RNG to be
> > > disabled at run time, and it's now in -next, but even with that I think
> > > something like this is a good idea as well.)
> > > 
> > > Jonathan McDowell (4):
> > >   tpm: Remove tpm_find_get_ops
> > >   tpm: Add O_EXCL for exclusive /dev/tpm access
> > >   tpm: Include /dev/tpmrm<n> when checking exclusive userspace TPM
> > >     access
> > >   tpm: Allow for exclusive TPM access when using /dev/tpm<n>
> > > 
> > >  drivers/char/tpm/tpm-chip.c       | 90 +++++++++++++++----------------
> > >  drivers/char/tpm/tpm-dev-common.c |  8 +--
> > >  drivers/char/tpm/tpm-dev.c        | 35 ++++++++++--
> > >  drivers/char/tpm/tpm-dev.h        |  1 +
> > >  drivers/char/tpm/tpm-interface.c  | 20 +++++--
> > >  drivers/char/tpm/tpm.h            |  3 +-
> > >  drivers/char/tpm/tpm2-space.c     |  5 +-
> > >  drivers/char/tpm/tpm_tis_core.c   |  3 +-
> > >  drivers/char/tpm/tpmrm-dev.c      | 20 ++++++-
> > >  include/linux/tpm.h               |  4 +-
> > >  10 files changed, 124 insertions(+), 65 deletions(-)
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > 
> > I will put to queue with my tags but I just want to make first sure that we do not
> > break anything.
> > 
> > I'll upgrade my test suite first to have TPM 1.2 tests (which is also
> > needed for my own series) and run it in bunch of configurations.  And on
> > TPM2 I check the behavior with TSS2 daemon on / off.
> > 
> > I have no doubts on the code changes, and it is most importantly a
> > security improvement, given that "who has the access and how long" 
> > can be deduced for a system configuration. I just feel that with
> > this code change it is better to check and verify everything :-)
> 
> Roberto has already commented on this patch set, saying it would affect IMA[1].
> I still need to look at the patch set, but please don't break IMA.

See my response in that thread.

> 
> [1]https://lore.kernel.org/linux-integrity/cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com/
> 
> -- 
> thanks,
> 
> Mimi

BR, Jarkko

