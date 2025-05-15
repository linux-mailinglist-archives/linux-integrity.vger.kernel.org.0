Return-Path: <linux-integrity+bounces-6224-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D967AB7B0F
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 03:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94084C2BCC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41862798FF;
	Thu, 15 May 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWzoy3ol"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1A746E;
	Thu, 15 May 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273312; cv=none; b=Cu02z1ptZvELgcPibhAhLgDzoOktbXW4cFrSqX2AR7ljlOSsg5ZAbGxh5mSSsglDAGgN79ENfLdfyZWQtgrsgcJrPzA8HPnvqQB+bf5sDLBlbsxDyt9yNTWqx6/Vii3/cozSI2NDfFyN5HUTGwRrDkpedHP5LK/S/p9LyGJaY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273312; c=relaxed/simple;
	bh=OTWJVAAiNGFgSoscBaj7v9EEyBMWHAN7S4h7HHzq0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gqziuo7hS/6NhFZzC/ToIQwXv+hl5BWSY8396uzZRtAR1XYx8/WXgOcWQoZbD6y+DszypJzA0MzQ7ddoXRmUnELesXobsJzTAC2lHeTeRUncv7Az47658QTtb4lyRyD4Mf0GlFhxoJxEtseAZ6NMbtkSg9Pcgyly5SZUKSkynUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWzoy3ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268E4C4CEE3;
	Thu, 15 May 2025 01:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747273311;
	bh=OTWJVAAiNGFgSoscBaj7v9EEyBMWHAN7S4h7HHzq0AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWzoy3olVsXjVDZGH/LI5rkCSTD8jlDKpNQlgCTfWjOu6qoTyVaRFKFhTtTpXmFDu
	 6WYXgFKETXVu4s2KCI+LSWZyjfxc/PXKmaFa3TncKgboAsjHg/E+HY3ZHCnotL01Cd
	 Ic2UCzWm8x4d5/pMEXzzj8typPY6wOBNMH6YJtzXwF2clgZdOmtG9SSnqEx1zaUHHO
	 vWBChG+2ebl8tsZk7dDY0AnzaYC4Ip/06Kt4ZPwXwvGXVTlu8Uw24uYUK8JjsMKi0R
	 dFrugkgvTImU3bimQSRRo26es2PSZoH8pHY5szFWtM9p81+VuOQ2om9peyjDK7mgyj
	 03wdkYS9UiQwA==
Date: Thu, 15 May 2025 04:41:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Sasha Levin <sashal@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3] tpm: tis: Double the timeout B to 4s
Message-ID: <aCVGW7T5Gy5zVkJ-@kernel.org>
References: <4e4640bd-0313-4594-9667-82340ed9368a@molgen.mpg.de>
 <20250404082325.13876-1-msuchanek@suse.de>
 <Z--d7Obw2UEk8Pve@kernel.org>
 <aCSIRS1fq_b9sByn@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCSIRS1fq_b9sByn@kitsune.suse.cz>

On Wed, May 14, 2025 at 02:10:45PM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Fri, Apr 04, 2025 at 11:53:00AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Apr 04, 2025 at 10:23:14AM +0200, Michal Suchanek wrote:
> > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
> > > C) can reach up to about 2250 ms.
> > > 
> > > Timeout C is retried since
> > > commit de9e33df7762 ("tpm, tpm_tis: Workaround failed command reception on Infineon devices")
> > > 
> > > Timeout B still needs to be extended.
> > > 
> > > The problem is most commonly encountered with context related operation
> > > such as load context/save context. These are issued directly by the
> > > kernel, and there is no retry logic for them.
> > > 
> > > When a filesystem is set up to use the TPM for unlocking the boot fails,
> > > and restarting the userspace service is ineffective. This is likely
> > > because ignoring a load context/save context result puts the real TPM
> > > state and the TPM state expected by the kernel out of sync.
> > > 
> > > Chips known to be affected:
> > > tpm_tis IFX1522:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> > > Description: SLB9672
> > > Firmware Revision: 15.22
> > > 
> > > tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
> > > Firmware Revision: 7.83
> > > 
> > > tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
> > > Firmware Revision: 5.63
> > > 
> > > Link: https://lore.kernel.org/linux-integrity/Z5pI07m0Muapyu9w@kitsune.suse.cz/
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > v2: Only extend timeout B
> > > v3: Update commit message
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.h | 2 +-
> > >  include/linux/tpm.h             | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > > index 970d02c337c7..6c3aa480396b 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.h
> > > +++ b/drivers/char/tpm/tpm_tis_core.h
> > > @@ -54,7 +54,7 @@ enum tis_int_flags {
> > >  enum tis_defaults {
> > >  	TIS_MEM_LEN = 0x5000,
> > >  	TIS_SHORT_TIMEOUT = 750,	/* ms */
> > > -	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> > > +	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
> > >  	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
> > >  	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
> > >  };
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index 6c3125300c00..3db0b6a87d45 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -224,7 +224,7 @@ enum tpm2_const {
> > >  
> > >  enum tpm2_timeouts {
> > >  	TPM2_TIMEOUT_A          =    750,
> > > -	TPM2_TIMEOUT_B          =   2000,
> > > +	TPM2_TIMEOUT_B          =   4000,
> > >  	TPM2_TIMEOUT_C          =    200,
> > >  	TPM2_TIMEOUT_D          =     30,
> > >  	TPM2_DURATION_SHORT     =     20,
> > > -- 
> > > 2.47.1
> > > 
> > > 
> > 
> > Cc: stable@vger.kernel.org # v6.1+
> > 
> > Probably best that I'll piggyback a patch set for stable with the two
> > fixes, in order to cause least noise. I need to do this *after* an
> > ack'd PR to -rc2.
> 
> While there is talk about stable this does not seem to be applied
> anywhere I could find. Is that expected?

Definitely not. I got shifted away with other work early April and
this was left to my TODO folder, apologies.

Sasha, can you also auto-select this to v6.1+? It is in my next
branch now (should be soon'ish mirrored to linux-next).

BR, Jarkko

