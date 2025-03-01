Return-Path: <linux-integrity+bounces-5032-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74934A4A7D0
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 03:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344F73BC097
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 02:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BE22087;
	Sat,  1 Mar 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn9qXIP4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201725760
	for <linux-integrity@vger.kernel.org>; Sat,  1 Mar 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794624; cv=none; b=Dr/FvJ91iLRav6xRligW+yG8WY2HBo7qMJEwqXAtLbCEtFhS0zQiRVKOSf9l0hOCMYpiWRZTnv4nwFxu2sqzgchXg5oKJCFn3gPPsPSNGnWegaNpUamePs4v71rOWjLSRTDCx+nS8uQnKGEGzyIsnxGcI2TLRl529CehJb4tRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794624; c=relaxed/simple;
	bh=OCQxjdGyRkpbrRbO8Q9Z8FtAPAkOmM0kZ0fnO4Jv8Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+ciJLaF69OSDwDcZYxLbcWj/In5cjESCg/0fW6wAJar/4IERFTVky75b/WyyY/WWKCDN4tdKy93IpFWjak0qTBXmMEP3NzdCTeuoDxAmtHDxT2jWcM7DRiYogYzo5+8MCwtIO6gW8JEB4MDOMlHDjFxeIFgO5eismBLnQCcYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn9qXIP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466D3C4CED6;
	Sat,  1 Mar 2025 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740794623;
	bh=OCQxjdGyRkpbrRbO8Q9Z8FtAPAkOmM0kZ0fnO4Jv8Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn9qXIP4lYFmyA0ZzafkA9zzt3/yBFqDLiSMLXwUMjBuZjTpSxSGZnb8oeQjalW5x
	 RH+QrAvHDUqYlLGIdRgqylzczqyJcwqYj2g83Xekz9XbJOtkVQG28szyA1QhrJ/A3A
	 wQmGbCA4d/3Th3vh0HmlehClb5f9WlzCzuNAD52adIHOAS5hXBtK/ieFj5EdTON/sW
	 jPUbyiq4x9PJidV2Hc0LnDyTVj1W2WK842Sy8btBkQ3FNVsFj8NiBV79c30/KtQFaT
	 NNRgUDpqWr/5VLT8RZULNd5WFLehbihykNAZ0i0SkVNvbq72FNl6TF7c1BXXVkQc1u
	 zgmvE1bhN7nnQ==
Date: Sat, 1 Mar 2025 04:03:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z8Jq-wyFm9Ye8B_j@kernel.org>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z7ZbWcLK0Iajd_D9@earth.li>
 <Z7xsmNq0kEj0cHco@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7xsmNq0kEj0cHco@kitsune.suse.cz>

On Mon, Feb 24, 2025 at 01:56:56PM +0100, Michal Suchánek wrote:
> On Wed, Feb 19, 2025 at 10:29:45PM +0000, Jonathan McDowell wrote:
> > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > there is a problem report that booting a specific type of system about
> > > 0.1% of the time encrypted volume (using a PCR to release the key) fails
> > > to unlock because of TPM operation timeout.
> > > 
> > > Minimizing the test case failed so far.
> > > 
> > > For example, booting into text mode as opposed to graphical desktop
> > > makes the problem unreproducible.
> > > 
> > > The test is done with a frankenkernel that has TPM drivers about on par
> > > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > > reproducible, either.
> > > 
> > > However, given the problem takes up to a day to reproduce I do not have
> > > much confidence in the negative results.
> > 
> > Michal, can you possibly try the below and see if it helps out? There
> > seems to be a timing bug introduced in 6.4+ that I think might be
> > related, and matches up with some of our internal metrics that showed an
> > increase in timeouts in 6.4 onwards.
> > 
> > commit 79041fba797d0fe907e227012767f56dd93fac32
> > Author: Jonathan McDowell <noodles@meta.com>
> > Date:   Wed Feb 19 16:20:44 2025 -0600
> > 
> >     tpm, tpm_tis: Fix timeout handling when waiting for TPM status
> >     
> >     The change to only use interrupts to handle supported status changes,
> >     then switch to polling for the rest, inverted the status test and sleep
> >     such that we can end up sleeping beyond our timeout and not actually
> >     checking the status. This can result in spurious TPM timeouts,
> >     especially on a more loaded system. Fix by switching the order back so
> >     we sleep *then* check. We've done a up front check when we enter the
> >     function so this won't cause an additional delay when the status is
> >     already what we're looking for.
> >     
> >     Cc: stable@vger.kernel.org # v6.4+
> >     Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
> >     Signed-off-by: Jonathan McDowell <noodles@meta.com>
> 
> Reviewed-by: Michal Suchánek <msuchanek@suse.de>

Send as a proper patch. I've this month mostly on holiday but will be
back at work on Monday.

BR, Jarkko

