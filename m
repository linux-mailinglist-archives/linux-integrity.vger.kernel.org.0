Return-Path: <linux-integrity+bounces-3728-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E798E36A
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF21C22E1C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876ED2141A9;
	Wed,  2 Oct 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="vOK8DXVy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485511D0DCE;
	Wed,  2 Oct 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897211; cv=none; b=EVXGO3YeEoAPd97ybRDjAHth48s54JiBNRqmQhwl4JElyidwWrc/BfgC1RLeYEcYTHMpB8AFudqBwQdJP8CUfvxByDoYYIqApaxF8F2nDHaURkH3qpUAG0LfE9+LpOhR980gN81gdvCrgPmG0xljPUWgybvYCbDDa9MRs5TGCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897211; c=relaxed/simple;
	bh=FAi/yaWlzEaGZY94Cy0xf1w9t3bJECdggONxw7jhmLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlDr21wn/x29RTCr43vRxq59XmdA6TCerj+OM7DkyMG6KePQicevFD+sO0AO+IEHfGwnJzfMyy1IdH5AHHzAgLRMo13dudd9k4GSsNgHexhy2nm3C9CIRIdB6bq46Gu2a9PAjiv3MJQdyWC53ch9N+hYNv9iAEm9taOQeoiy6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=vOK8DXVy; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3CUqPSRPJx6WKMwitN1e//58gfK5Iq+dhEFVNJ9G8Fg=; b=vOK8DXVyukL1SLX2p/PNGNasUS
	oIzkk3ttq09LQIj4S46N2RnfzETclar6N6pqMKkw1WLoiqzCpd3nG3HPB9qzQN4KWufm10TzrGPUS
	AHZArfO7Qx4c2EvVXu65uWFoa9OVt0MfhKjith61tC6gvzIJkwowm6Pd1cGPH2i5UUTB7ZC53Xz/C
	NiBuctz5YnSbUg9M3s84pc6kGGReHRnIWFaSoroeaAm1hRuDiUmxWsJeZ25I0tuHxvjGQHtWFBV4w
	ikW2HgrdXuwI5xfRvogYZVnzHjv3dSGQm+KCMgsfz9kO5QMvM1EJRrNyvk7vhoLcJxRyoX7RaLbW6
	dFBLn8uw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sw4zk-00DLm2-0H;
	Wed, 02 Oct 2024 20:26:44 +0100
Date: Wed, 2 Oct 2024 20:26:44 +0100
From: Jonathan McDowell <noodles@earth.li>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: Problems with TPM timeouts
Message-ID: <Zv2edMT2TyGsIiFJ@earth.li>
References: <Zv1810ZfEBEhybmg@earth.li>
 <a9b94fad8f0d8023ce2459fa11494ff8e83d0b65.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b94fad8f0d8023ce2459fa11494ff8e83d0b65.camel@HansenPartnership.com>

On Wed, Oct 02, 2024 at 10:31:34AM -0700, James Bottomley wrote:
> On Wed, 2024-10-02 at 18:03 +0100, Jonathan McDowell wrote:
> [...]
> > First, I've seen James' post extending the TPM timeouts back in 2018
> > (
> > https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@Hansen
> > Partnership.com/), which doesn't seem to have been picked up. Was an
> > alternative resolution found, or are you still using this, James?
> 
> No, because I've got a newer laptop.  The problem was seen on a 2015
> XPS-13 with a Nuvoton TPM that was software upgraded to 2.0 (and had
> several other problems because of this).  I assumed, based on the lack
> of reports from others, that this was a problem specific to my TPM and
> so didn't push it.

Yes, there's somewhat a lack of reports of TPM issues but I can't tell
if that's because people aren't using them in anger, or if they're just
not having any issues.

This is seen across thousands of machines, so it's not a specific TPM
issue.

> The annoying thing for me was that the TPM didn't seem to recover. 
> Once it started giving timeouts it carried on timing out until machine
> reset, which really caused problems because all my keys are TPM
> resident.
> 
> Is yours a permanent problem like mine, or is it transient (TPM
> recovers and comes back)?

Ah. So the problem I've described is transient; we get a timeout, that
sometimes causes problems (e.g. the transient space leakage I've
previously sent a patch for), but ultimately the TPM responds just fine
next time.

We _do_ have a separate issue where the TPM returns 0xFFFF for STS, the
kernel does the "invalid TPM_STS.x" with stack thing, then the TPM never
responds to a command again until a machine reboot. However in that
instance it _does_ still respond to reading the TPM_DID_VID register,
and allowing entering/leaving locality, so that looks like it's firmly a
TPM problem of some sort.

J.

-- 
/-\                             | No thanks, I'm already having one.
|@/  Debian GNU/Linux Developer |
\-                              |

