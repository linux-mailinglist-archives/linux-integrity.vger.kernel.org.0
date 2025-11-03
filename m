Return-Path: <linux-integrity+bounces-7559-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FDC2DCFA
	for <lists+linux-integrity@lfdr.de>; Mon, 03 Nov 2025 20:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13FE4E4C71
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Nov 2025 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22C280017;
	Mon,  3 Nov 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="or+t/Mk6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E56347C3;
	Mon,  3 Nov 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197186; cv=none; b=WIZXuUAOnMPEth4/OJopQAmeXFuPRIif2AJtoCz9+VB7afARE/ZgVqHJFgMniU2ZQF9dsbetvbAcTqx8mSTxUSew21L0K/mfy2redHmOXJ6b7kzTg+GgNrFT+O2m8JsaATiqxaNtXTgTZ2zzeQBqY2k9is14CCYOfFBIuVLJ+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197186; c=relaxed/simple;
	bh=X28PVM1pHjUBiCIDklQDJk1W4z0EHRhbaDNCwuFLW8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSkzWAWKDK2NtmJfOzr/qLqXyZGh0tT5urWcJZSPNaBEYivGCmHXXuw1L/7OzbXhtBX5CrbSiBlyllOn08FbQ734rjQnkuweQr10vv9N6ivK7lyuh7vSEP9RAzPDOa18vaH5wBVPh+gePSYhStBPtiJO8GtlldJMn+ce8d0Jz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=or+t/Mk6; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AD67qlxIc6SDg/FLv0M1cX7SsFiaMOMP5oXhvhvdN90=; b=or+t/Mk6szqFsgIMcgzUQARmRr
	mc9VLYQZQzapLpKaNTi7BrqsRln/KYFAaCoqqBexxI3h9ShxJqnciS+WkZiKM//ZygdEPJsAPnSD1
	gZIHcpxED0kD87vfRc5GP+tl3oWdf+X+to9FFeK/r8F2MywJ9NSHvbDMCuThl6wwp5du+GsC3s8Xn
	TteEQD4qjomNgk20372MdHTkc8sbIkK6vcjproJC/0n4z9fv8X/9zWFtzfZHETGXM738BCHfEuhKD
	L7JRnqAooyFcP5QJcOP++oQxIM8YbK86b4rsLFiBUcyURjxNuW1VaF9K8TeEia6iJCnqIC+MaxsZQ
	001xgSkw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vFzSD-00Daab-0n;
	Mon, 03 Nov 2025 18:38:57 +0000
Date: Mon, 3 Nov 2025 18:38:57 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com
Subject: Re: [PATCH v3 4/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <aQj2wZrnV7vgoAcq@earth.li>
References: <cover.1760958898.git.noodles@meta.com>
 <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
 <cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com>
 <aP_KT0GiQSzt1ClO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aP_KT0GiQSzt1ClO@kernel.org>

On Mon, Oct 27, 2025 at 09:38:55PM +0200, Jarkko Sakkinen wrote:
>On Mon, Oct 20, 2025 at 01:53:30PM +0200, Roberto Sassu wrote:
>> On Mon, 2025-10-20 at 12:31 +0100, Jonathan McDowell wrote:
>> > From: Jonathan McDowell <noodles@meta.com>
>> >
>> > There are situations where userspace might reasonably desire exclusive
>> > access to the TPM, or the kernel's internal context saving + flushing
>> > may cause issues, for example when performing firmware upgrades. Extend
>> > the locking already used for avoiding concurrent userspace access to
>> > prevent internal users of the TPM when /dev/tpm<n> is in use.
>> >
>> > The few internal users who already hold the open_lock are changed to use
>> > tpm_internal_(try_get|put)_ops, with the old tpm_(try_get|put)_ops
>> > functions changing to obtain read access to the open_lock.  We return
>> > -EBUSY when another user has exclusive access, rather than adding waits.
>> >
>> > Signed-off-by: Jonathan McDowell <noodles@meta.com>
>> > ---
>> > v2: Switch to _locked instead of _internal_ for function names.
>> > v3: Move to end of patch series.
>> >
>> >  drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
>> >  drivers/char/tpm/tpm-dev-common.c |  8 ++---
>> >  drivers/char/tpm/tpm.h            |  2 ++
>> >  drivers/char/tpm/tpm2-space.c     |  5 ++-
>> >  4 files changed, 52 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> > index ba906966721a..687f6d8cd601 100644
>> > --- a/drivers/char/tpm/tpm-chip.c
>> > +++ b/drivers/char/tpm/tpm-chip.c
>> > @@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
>> >  EXPORT_SYMBOL_GPL(tpm_chip_stop);
>> >
>> >  /**
>> > - * tpm_try_get_ops() - Get a ref to the tpm_chip
>> > + * tpm_try_get_ops_locked() - Get a ref to the tpm_chip
>> >   * @chip: Chip to ref
>> >   *
>> >   * The caller must already have some kind of locking to ensure that chip is
>> > @@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
>> >   *
>> >   * Returns -ERRNO if the chip could not be got.
>> >   */
>> > -int tpm_try_get_ops(struct tpm_chip *chip)
>> > +int tpm_try_get_ops_locked(struct tpm_chip *chip)
>> >  {
>> >  	int rc = -EIO;
>> >
>> > @@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>> >  	put_device(&chip->dev);
>> >  	return rc;
>> >  }
>> > -EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>> >
>> >  /**
>> > - * tpm_put_ops() - Release a ref to the tpm_chip
>> > + * tpm_put_ops_locked() - Release a ref to the tpm_chip
>> >   * @chip: Chip to put
>> >   *
>> > - * This is the opposite pair to tpm_try_get_ops(). After this returns chip may
>> > - * be kfree'd.
>> > + * This is the opposite pair to tpm_try_get_ops_locked(). After this returns
>> > + * chip may be kfree'd.
>> >   */
>> > -void tpm_put_ops(struct tpm_chip *chip)
>> > +void tpm_put_ops_locked(struct tpm_chip *chip)
>> >  {
>> >  	tpm_chip_stop(chip);
>> >  	mutex_unlock(&chip->tpm_mutex);
>> >  	up_read(&chip->ops_sem);
>> >  	put_device(&chip->dev);
>> >  }
>> > +
>> > +/**
>> > + * tpm_try_get_ops() - Get a ref to the tpm_chip
>> > + * @chip: Chip to ref
>> > + *
>> > + * The caller must already have some kind of locking to ensure that chip is
>> > + * valid. This function will attempt to get the open_lock for the chip,
>> > + * ensuring no other user is expecting exclusive access, before locking the
>> > + * chip so that the ops member can be accessed safely. The locking prevents
>> > + * tpm_chip_unregister from completing, so it should not be held for long
>> > + * periods.
>> > + *
>> > + * Returns -ERRNO if the chip could not be got.
>> > + */
>> > +int tpm_try_get_ops(struct tpm_chip *chip)
>> > +{
>> > +	if (!down_read_trylock(&chip->open_lock))
>> > +		return -EBUSY;
>>
>> Hi Jonathan
>>
>> do I understand it correctly, that a process might open the TPM with
>> O_EXCL, and this will prevent IMA from extending a PCR until that
>> process closes the file descriptor?
>>
>> If yes, this might be a concern, and I think an additional API to
>> prevent such behavior would be needed (for example when IMA is active,
>> i.e. there is a measurement policy loaded).
>
>Also this would be a problem with hwrng.
>
>This probably needs to be refined somehow. I don't have a solution at
>hand but "invariant" is that in-kernel caller should override user space
>exclusion, even when O_EXCL is used.

Kernel access is exactly what caused the issue for me, in particular the 
HW RNG access during a firmware upgrade. My patch to be able to disable 
the HW RNG at runtime has landed in -next, which helps a lot, but it 
really would be nice to be able to say "Hands off, I'm busy with this", 
which is what led to this patch set.

To James' query about the fact the upgrade process should be properly 
handled, I think the issue is probably that the HMAC context saving 
around HW RNG access hit errors that were not gracefully handled, and we 
marked the TPM as disabled in tpm2_load_null, causing failure 
mid-upgrade.

J.

-- 
What have you got in your pocket?

