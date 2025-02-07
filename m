Return-Path: <linux-integrity+bounces-4740-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A0A2BF3A
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D747F18897F1
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBFA16C684;
	Fri,  7 Feb 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="cufXFLBn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CE192D77
	for <linux-integrity@vger.kernel.org>; Fri,  7 Feb 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920387; cv=none; b=TY7q4bydgImNzRAJAo35lGsiLvKMMArdULXLxWrmhQ0b5FuCsj9umJVLsUdE7kkwDOUFDiSds/Tqso5G3hXd995FdVLjF6mZZLrYQuq57D41gB1mxOMPL36BsdE1HRt0FHsgPqE8mCtQtH7zddtjuRY7zb85eayWRysbrcb2TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920387; c=relaxed/simple;
	bh=L+5z8sa+zYvvhywOH/pWlb8+eOQ3lFUVDDC1+XKJ5wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWvh8OCHMasCqM5XAufTqzj8KrgoyQQvA7+2UXpdoYb69KvufdqXdyNnoPB+U2ujxAM6rZlcAwMZT1khCxW/wtjS7EVywKcfDjuDbb3h1nHCcBMvkHnzS5eF04/V+eTQIgFk0BpcGR6KE2tjZykJy8nFsRO+RQnZaMw1X3IAWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=cufXFLBn; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ygOGKXVM3Potsp8Iak+ffhPChR6EPsEdfXbvCMYRtXw=; b=cufXFLBnrUIFe+f/nhteizYIei
	C95GxZdkyu/lIcuMWTgn/ZptScjh+i7lodcgKkIw07lp07Gq5tWDLvWBIwG+FV8dMC2LyUOyvt6pc
	E/OhJOTD2nuCQ80zjUSpWusQ4AzStnEBy5lxfyFr8TmTvOBv2CB+/RllQkmYSUXlqKfByM5If3FnL
	/gvmnG8cqyJvTwBTW/DJF8R6NdVhS97lqTm+ntOm+av3IZjktGaQsPHqZos3Rhtj4n2BbhGe/exx9
	0ZZOFkeJ9zTE+nSPVCQIUnDAqfjGCYgir+OOYx1DYnIUQx3XOj1QdHvq7fIEaipj8nBH6AEGrvN3C
	B9nGHOYQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tgKcq-004DId-0A;
	Fri, 07 Feb 2025 09:26:16 +0000
Date: Fri, 7 Feb 2025 09:26:16 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6XRuFnEXeQI_rEZ@earth.li>
References: <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6UdFCdqCNZ8VGOL@kernel.org>

On Thu, Feb 06, 2025 at 10:35:32PM +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 05, 2025 at 02:29:36PM +0000, Jonathan McDowell wrote:
> > Interesting. TPM2_CC_CONTEXT_LOAD (353) / TPM2_CC_FLUSH_CONTEXT (357) /
> > TPM2_CC_CONTEXT_SAVE (354) I kinda expect to maybe take a bit longer,
> > but TPM2_CC_GET_RANDOM (379) is a little surprising.
> 
> The whole arithmetic with timeout_a/b/c is mostly gibberish and could
> be replaced with a single "max" constant without issues (just set it
> large enough).
> 
> They could be all be replaced with let's say 3s timeout in a constant.

This appears to have come up before:

https://lore.kernel.org/linux-integrity/358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com/

That patch was deemed overly complex and it was suggested to split it
up; I can't find any indication that was ever done which I guess is why
the discussion died off.

> > > Failure is observed with another chip type as well:
> > > 
> > > localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
> > > 22)
> > > 
> > > TPM Device
> > >         Vendor ID: IFX
> > >         Specification Version: 2.0
> > >         Firmware Revision: 7.83
> > >         Description: TPM 2.0, ManufacturerID: IFX , Firmware Version: 7.83.3358.0
> > >         Characteristics:
> > >                 Family configurable via firmware update
> > >                 Family configurable via OEM proprietary mechanism
> > >         OEM-specific Information: 0x00000000
> > 
> > That looks like an SLB9670, not running the latest firmware (7.85). I
> > think that might have the errata I've been trying to work around; my
> > current patch in testing (with logging to see how effective it is):
> > 
> > commit d8c680ec34e7f42f731e7d64605a670fb7b3b4d1
> > Author: Jonathan McDowell <noodles@meta.com>
> > Date:   Mon Aug 19 09:22:46 2024 -0700
> > 
> >     tpm: Workaround failed command reception on Infineon devices
> >     
> >     Some Infineon devices have a issue where the status register will get
> >     stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
> >     is to retry the command submission. Add appropriate logic to do this in
> >     the send path.
> >     
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index fdef214b9f6b..561d6801e299 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -464,7 +464,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >  
> >  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> >  					&priv->int_queue, false) < 0) {
> > -			rc = -ETIME;
> > +			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
> > +				dev_err(&chip->dev, "Timed out waiting for status valid in send, retrying\n");
> > +				rc = -EAGAIN;
> 
> 
> I'm not sure why wait_for_tpm_stat() return value is ignored but it
> should not be like that. E.g. it can return -ERESTARTSYS. Probably
> would be better to check all the call sites for it that they do
> same thing.
> 
> I.e. rc = wait_for_tpm_stat(...);
> 
> /* ... */

So just to clarify, this more recent patch is working around a situation
where the status register gets stuck and needs a complete retry of the
command send - it's an Infineon errata, not something that would be
fixed with a longer timeout.

We see what looks like Michal's issue with timeouts as well, I just
haven't made the step of instrumenting it all the way he has.

J.

-- 
  I have found the monster - the   |  .''`.  Debian GNU/Linux Developer
          monster is us.           | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

