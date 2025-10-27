Return-Path: <linux-integrity+bounces-7529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1473C113FF
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 20:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF475506BB3
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFE2D8372;
	Mon, 27 Oct 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVHcVRrd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382242D739D;
	Mon, 27 Oct 2025 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593941; cv=none; b=LmbTcDXodnjO+eDkmWyQT6cMX7mVYpv9cCXAeMY/epq1Wsk/s1OZs6JbQDGDYwhNaSq+io0AF8IziVts4sp92kReShz22ByOcaahqiwCV8PTu/HKdLjq5AldcdbRty3VXH7x5qjYkI6Xg0kAgpGAIM1fK4g9iOaTgSEnSoNFKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593941; c=relaxed/simple;
	bh=XpKJZFvABRCT9MjotWwYDutM+cmHTbQ0wxZGDqeMi1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeSyG6FaEgVoGMLofFsH3x6vH133tJYr4HcNixneXPIdGvCqhh6k3GVNgmMsVoKXpqsrpHmgBsvEpOf05QCoqslViqEtdEvOrR5NuK73ETrX4W4b60A2hzENjqI4MDGI+3RH7Vo+v7qyT1duuLQWDkK6GbDN2K7hQ/gH3ukYSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVHcVRrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C98C4CEF1;
	Mon, 27 Oct 2025 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593939;
	bh=XpKJZFvABRCT9MjotWwYDutM+cmHTbQ0wxZGDqeMi1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVHcVRrdlI/I7EF3gBQhHJnsM0sYHenmAbdejJq23so+CmfgpH3FoSpdm4f0e/XPA
	 lCamBJk4y5QkRJJ5Y/a/+3ErgoHSt2YdyKQqQF3haQa3k/gnVDgnLsPNoiudBiaR0E
	 Uu/dVhUdKO/unaSVPCPjdgwhojK9bVXCB28pZPCH4Jc123XUDgORKmXxZmpqo5e0ul
	 PpOXwyaAzEFShPnvRzF2H5qjN22R/uQxfjTh3t5O/zi2TKOrDiMjW+3K7JyHTwY7Wn
	 iJJONLa2vXlIxZt3OTo22t7rU6cXjI2B5W0RPN7Gs1uiX9PH6OwxzLdssPsuh0qYzk
	 D02ibIw0XCiXg==
Date: Mon, 27 Oct 2025 21:38:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Jonathan McDowell <noodles@earth.li>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v3 4/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <aP_KT0GiQSzt1ClO@kernel.org>
References: <cover.1760958898.git.noodles@meta.com>
 <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
 <cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com>

On Mon, Oct 20, 2025 at 01:53:30PM +0200, Roberto Sassu wrote:
> On Mon, 2025-10-20 at 12:31 +0100, Jonathan McDowell wrote:
> > From: Jonathan McDowell <noodles@meta.com>
> > 
> > There are situations where userspace might reasonably desire exclusive
> > access to the TPM, or the kernel's internal context saving + flushing
> > may cause issues, for example when performing firmware upgrades. Extend
> > the locking already used for avoiding concurrent userspace access to
> > prevent internal users of the TPM when /dev/tpm<n> is in use.
> > 
> > The few internal users who already hold the open_lock are changed to use
> > tpm_internal_(try_get|put)_ops, with the old tpm_(try_get|put)_ops
> > functions changing to obtain read access to the open_lock.  We return
> > -EBUSY when another user has exclusive access, rather than adding waits.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > ---
> > v2: Switch to _locked instead of _internal_ for function names.
> > v3: Move to end of patch series.
> > 
> >  drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
> >  drivers/char/tpm/tpm-dev-common.c |  8 ++---
> >  drivers/char/tpm/tpm.h            |  2 ++
> >  drivers/char/tpm/tpm2-space.c     |  5 ++-
> >  4 files changed, 52 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index ba906966721a..687f6d8cd601 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
> >  EXPORT_SYMBOL_GPL(tpm_chip_stop);
> >  
> >  /**
> > - * tpm_try_get_ops() - Get a ref to the tpm_chip
> > + * tpm_try_get_ops_locked() - Get a ref to the tpm_chip
> >   * @chip: Chip to ref
> >   *
> >   * The caller must already have some kind of locking to ensure that chip is
> > @@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
> >   *
> >   * Returns -ERRNO if the chip could not be got.
> >   */
> > -int tpm_try_get_ops(struct tpm_chip *chip)
> > +int tpm_try_get_ops_locked(struct tpm_chip *chip)
> >  {
> >  	int rc = -EIO;
> >  
> > @@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
> >  	put_device(&chip->dev);
> >  	return rc;
> >  }
> > -EXPORT_SYMBOL_GPL(tpm_try_get_ops);
> >  
> >  /**
> > - * tpm_put_ops() - Release a ref to the tpm_chip
> > + * tpm_put_ops_locked() - Release a ref to the tpm_chip
> >   * @chip: Chip to put
> >   *
> > - * This is the opposite pair to tpm_try_get_ops(). After this returns chip may
> > - * be kfree'd.
> > + * This is the opposite pair to tpm_try_get_ops_locked(). After this returns
> > + * chip may be kfree'd.
> >   */
> > -void tpm_put_ops(struct tpm_chip *chip)
> > +void tpm_put_ops_locked(struct tpm_chip *chip)
> >  {
> >  	tpm_chip_stop(chip);
> >  	mutex_unlock(&chip->tpm_mutex);
> >  	up_read(&chip->ops_sem);
> >  	put_device(&chip->dev);
> >  }
> > +
> > +/**
> > + * tpm_try_get_ops() - Get a ref to the tpm_chip
> > + * @chip: Chip to ref
> > + *
> > + * The caller must already have some kind of locking to ensure that chip is
> > + * valid. This function will attempt to get the open_lock for the chip,
> > + * ensuring no other user is expecting exclusive access, before locking the
> > + * chip so that the ops member can be accessed safely. The locking prevents
> > + * tpm_chip_unregister from completing, so it should not be held for long
> > + * periods.
> > + *
> > + * Returns -ERRNO if the chip could not be got.
> > + */
> > +int tpm_try_get_ops(struct tpm_chip *chip)
> > +{
> > +	if (!down_read_trylock(&chip->open_lock))
> > +		return -EBUSY;
> 
> Hi Jonathan
> 
> do I understand it correctly, that a process might open the TPM with
> O_EXCL, and this will prevent IMA from extending a PCR until that
> process closes the file descriptor?
> 
> If yes, this might be a concern, and I think an additional API to
> prevent such behavior would be needed (for example when IMA is active,
> i.e. there is a measurement policy loaded).

Also this would be a problem with hwrng.

This probably needs to be refined somehow. I don't have a solution at
hand but "invariant" is that in-kernel caller should override user space
exclusion, even when O_EXCL is used.


> 
> Thanks
> 
> Roberto

BR, Jarkko

