Return-Path: <linux-integrity+bounces-7607-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC5C43857
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B436188ADAB
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA451CDFCA;
	Sun,  9 Nov 2025 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdSjJse/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0614A8B;
	Sun,  9 Nov 2025 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762662863; cv=none; b=RGSQtL0iZz4UXhIyC1LFM/HkQMdDbqIJI/rA6/e6xcpn9WdlE+k3lEM2VULkOTxmcg776WxSjjW4grrwSDF5DXiF561vMCBCoiwNhN8d9StX2DByPq/BOnltObxjG+9Zg+SIf+vWu1gfROAVBs9X8Y5q1RD1yTwRaHWr0K+Or3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762662863; c=relaxed/simple;
	bh=FXXxgoummDwhyYR58k65rGbJTrBhBAdvr0rMHBjFdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhtR8BFwf2lucQEiRiQyspl1yW587WAafBoK8wahjGJtWufQPEb4B7udnlUBh4u3bCWi03FpH0qa9MdyP+3b7MQezWi3fcYUGhv8QTXynPqAH3sh7UYWhnvwN+rqK9+q+jmR5rhi3QouZjei3EitKXTq1l09rg/IHKbDDLY8Hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdSjJse/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF23C19422;
	Sun,  9 Nov 2025 04:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762662862;
	bh=FXXxgoummDwhyYR58k65rGbJTrBhBAdvr0rMHBjFdA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdSjJse/gh+OHFVmd0OtDxp7gR+qslgJ7/qPNukQWsL3eV40V5i1XSbsFT3A2L+g7
	 8SfGkuybqM/UFxW75PwMudpBpGIfy5hdbLG0MlmJnaOlef2jQP8/QEdwC9JsLl2ChS
	 bR7InYMYKfahu9z4E/kkYi94cjqCh90gLGTruUkjrO7UxymsdkCqSo/zIwjRwcdfhD
	 nmot8Ofypw7RyDbp7MZjHO/sF/U3HjiyGGdKa8rhz7o0izHkd+dgAqzWHJZQ/38Ljk
	 m8yW9RmpGrKJCqmQyX5NVCGYDdRR+SlLbHE8ea5eQJbRUFD+HyEFmnXHbw46vXU0Qm
	 ghBg2GaEO8Ing==
Date: Sun, 9 Nov 2025 06:34:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v3 4/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <aRAZyrug_ZxZ2idK@kernel.org>
References: <cover.1760958898.git.noodles@meta.com>
 <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
 <cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com>
 <aP_KT0GiQSzt1ClO@kernel.org>
 <aQj2wZrnV7vgoAcq@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQj2wZrnV7vgoAcq@earth.li>

On Mon, Nov 03, 2025 at 06:38:57PM +0000, Jonathan McDowell wrote:
> On Mon, Oct 27, 2025 at 09:38:55PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Oct 20, 2025 at 01:53:30PM +0200, Roberto Sassu wrote:
> > > On Mon, 2025-10-20 at 12:31 +0100, Jonathan McDowell wrote:
> > > > From: Jonathan McDowell <noodles@meta.com>
> > > >
> > > > There are situations where userspace might reasonably desire exclusive
> > > > access to the TPM, or the kernel's internal context saving + flushing
> > > > may cause issues, for example when performing firmware upgrades. Extend
> > > > the locking already used for avoiding concurrent userspace access to
> > > > prevent internal users of the TPM when /dev/tpm<n> is in use.
> > > >
> > > > The few internal users who already hold the open_lock are changed to use
> > > > tpm_internal_(try_get|put)_ops, with the old tpm_(try_get|put)_ops
> > > > functions changing to obtain read access to the open_lock.  We return
> > > > -EBUSY when another user has exclusive access, rather than adding waits.
> > > >
> > > > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > > > ---
> > > > v2: Switch to _locked instead of _internal_ for function names.
> > > > v3: Move to end of patch series.
> > > >
> > > >  drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
> > > >  drivers/char/tpm/tpm-dev-common.c |  8 ++---
> > > >  drivers/char/tpm/tpm.h            |  2 ++
> > > >  drivers/char/tpm/tpm2-space.c     |  5 ++-
> > > >  4 files changed, 52 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > > index ba906966721a..687f6d8cd601 100644
> > > > --- a/drivers/char/tpm/tpm-chip.c
> > > > +++ b/drivers/char/tpm/tpm-chip.c
> > > > @@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
> > > >  EXPORT_SYMBOL_GPL(tpm_chip_stop);
> > > >
> > > >  /**
> > > > - * tpm_try_get_ops() - Get a ref to the tpm_chip
> > > > + * tpm_try_get_ops_locked() - Get a ref to the tpm_chip
> > > >   * @chip: Chip to ref
> > > >   *
> > > >   * The caller must already have some kind of locking to ensure that chip is
> > > > @@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
> > > >   *
> > > >   * Returns -ERRNO if the chip could not be got.
> > > >   */
> > > > -int tpm_try_get_ops(struct tpm_chip *chip)
> > > > +int tpm_try_get_ops_locked(struct tpm_chip *chip)
> > > >  {
> > > >  	int rc = -EIO;
> > > >
> > > > @@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
> > > >  	put_device(&chip->dev);
> > > >  	return rc;
> > > >  }
> > > > -EXPORT_SYMBOL_GPL(tpm_try_get_ops);
> > > >
> > > >  /**
> > > > - * tpm_put_ops() - Release a ref to the tpm_chip
> > > > + * tpm_put_ops_locked() - Release a ref to the tpm_chip
> > > >   * @chip: Chip to put
> > > >   *
> > > > - * This is the opposite pair to tpm_try_get_ops(). After this returns chip may
> > > > - * be kfree'd.
> > > > + * This is the opposite pair to tpm_try_get_ops_locked(). After this returns
> > > > + * chip may be kfree'd.
> > > >   */
> > > > -void tpm_put_ops(struct tpm_chip *chip)
> > > > +void tpm_put_ops_locked(struct tpm_chip *chip)
> > > >  {
> > > >  	tpm_chip_stop(chip);
> > > >  	mutex_unlock(&chip->tpm_mutex);
> > > >  	up_read(&chip->ops_sem);
> > > >  	put_device(&chip->dev);
> > > >  }
> > > > +
> > > > +/**
> > > > + * tpm_try_get_ops() - Get a ref to the tpm_chip
> > > > + * @chip: Chip to ref
> > > > + *
> > > > + * The caller must already have some kind of locking to ensure that chip is
> > > > + * valid. This function will attempt to get the open_lock for the chip,
> > > > + * ensuring no other user is expecting exclusive access, before locking the
> > > > + * chip so that the ops member can be accessed safely. The locking prevents
> > > > + * tpm_chip_unregister from completing, so it should not be held for long
> > > > + * periods.
> > > > + *
> > > > + * Returns -ERRNO if the chip could not be got.
> > > > + */
> > > > +int tpm_try_get_ops(struct tpm_chip *chip)
> > > > +{
> > > > +	if (!down_read_trylock(&chip->open_lock))
> > > > +		return -EBUSY;
> > > 
> > > Hi Jonathan
> > > 
> > > do I understand it correctly, that a process might open the TPM with
> > > O_EXCL, and this will prevent IMA from extending a PCR until that
> > > process closes the file descriptor?
> > > 
> > > If yes, this might be a concern, and I think an additional API to
> > > prevent such behavior would be needed (for example when IMA is active,
> > > i.e. there is a measurement policy loaded).
> > 
> > Also this would be a problem with hwrng.
> > 
> > This probably needs to be refined somehow. I don't have a solution at
> > hand but "invariant" is that in-kernel caller should override user space
> > exclusion, even when O_EXCL is used.
> 
> Kernel access is exactly what caused the issue for me, in particular the HW
> RNG access during a firmware upgrade. My patch to be able to disable the HW
> RNG at runtime has landed in -next, which helps a lot, but it really would
> be nice to be able to say "Hands off, I'm busy with this", which is what led
> to this patch set.

If there is a situation when kernel needs to be excluded from itself,
then there should really be a kernel uapi to implement that use case.

I'd rather have e.g. ioctl (perhaps just picking one possible tool for
the job) for firmware upgrade than allow user space to arbitarily lock
TPM access.

> 
> To James' query about the fact the upgrade process should be properly
> handled, I think the issue is probably that the HMAC context saving around
> HW RNG access hit errors that were not gracefully handled, and we marked the
> TPM as disabled in tpm2_load_null, causing failure mid-upgrade.
> 
> J.
> 
> -- 
> What have you got in your pocket?

BR, Jarkko

