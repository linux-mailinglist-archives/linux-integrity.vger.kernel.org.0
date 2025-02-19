Return-Path: <linux-integrity+bounces-4917-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C378A3CCA1
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 23:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863EC177E82
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 22:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192423C8CC;
	Wed, 19 Feb 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="tr0r+Yga"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FE1DE2DE
	for <linux-integrity@vger.kernel.org>; Wed, 19 Feb 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005375; cv=none; b=XjIftTsol91CeoDkOWMCBXDm1YqY3iVg+L3GoeSiYNEgbWlSlElRh27GGSr/jfxdwu/UGaTxwuh/Dtuk+Rp91JIbjxxttwU8g3AO1cK/lqjnyMk5sM1o08ohzrrmBe32vCS3ZPxfk8FKUDSwSfVbH1KQAPL1KiJe8LL0sDWMdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005375; c=relaxed/simple;
	bh=LBwEWULeWBpVU9/ZwnxQZJvXa8jSRGlpvv8QTlXADdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVcpbJzmRUdGcqVUggRxDBKpHJ1xkh/z5zVcS6TQE0qXziukQyZtE7LbYImPics3O1hMwDOicPaBJ4+3HI5qdOwfEO7sLa1w9v8Bq8UsELQYuVat2FoQayieW8ny8Ie5EJUjUKtKHSaLppP2gBd0x++tbNk/YwboQqbCvZtiF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=tr0r+Yga; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iioXPeQYpBhEasb706WvMD2GHyV3Yiu4q3htpc1OUOQ=; b=tr0r+YgaPyafko0jM3ekBrG3rf
	+KCmpYBBp2N8oK6cUN2m36DNmHKHHdFoluwl8jdbnPL65e8+Yhfq+B+yyDNyHHuZBAHqx+fXkXx2B
	GaVv4FwoDleAz073oGX7mU4vkId5zcIrO1wRb/PUda7mXh2QDrmhhGEpbM3R/faV5X4zbXOTIxVsE
	fypZrRyciKzNhb40k6NzTnqi9hBVPKOCXp72pnGBeaRku5RcGOi/msXXOp6KeCFdRm5L4wuiMMRW7
	OhmI7GkXDtRzwUPpm38Z1BtoeF6b/HqXjCWg67g+fqhyIgqGn9rXc/vKgwlpdndY57feNZm6vhQUQ
	WJtg9WbA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tksZe-00Bsb5-01;
	Wed, 19 Feb 2025 22:29:46 +0000
Date: Wed, 19 Feb 2025 22:29:45 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z7ZbWcLK0Iajd_D9@earth.li>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5pI07m0Muapyu9w@kitsune.suse.cz>

On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> Hello,
> 
> there is a problem report that booting a specific type of system about
> 0.1% of the time encrypted volume (using a PCR to release the key) fails
> to unlock because of TPM operation timeout.
> 
> Minimizing the test case failed so far.
> 
> For example, booting into text mode as opposed to graphical desktop
> makes the problem unreproducible.
> 
> The test is done with a frankenkernel that has TPM drivers about on par
> with Linux 6.4 but using actual Linux 6.4 the problem is not
> reproducible, either.
> 
> However, given the problem takes up to a day to reproduce I do not have
> much confidence in the negative results.

Michal, can you possibly try the below and see if it helps out? There
seems to be a timing bug introduced in 6.4+ that I think might be
related, and matches up with some of our internal metrics that showed an
increase in timeouts in 6.4 onwards.

commit 79041fba797d0fe907e227012767f56dd93fac32
Author: Jonathan McDowell <noodles@meta.com>
Date:   Wed Feb 19 16:20:44 2025 -0600

    tpm, tpm_tis: Fix timeout handling when waiting for TPM status
    
    The change to only use interrupts to handle supported status changes,
    then switch to polling for the rest, inverted the status test and sleep
    such that we can end up sleeping beyond our timeout and not actually
    checking the status. This can result in spurious TPM timeouts,
    especially on a more loaded system. Fix by switching the order back so
    we sleep *then* check. We've done a up front check when we enter the
    function so this won't cause an additional delay when the status is
    already what we're looking for.
    
    Cc: stable@vger.kernel.org # v6.4+
    Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
    Signed-off-by: Jonathan McDowell <noodles@meta.com>

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..167d71747666 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		return 0;
 	/* process status changes without irq support */
 	do {
+		usleep_range(priv->timeout_min,
+			     priv->timeout_max);
 		status = chip->ops->status(chip);
 		if ((status & mask) == mask)
 			return 0;
-		usleep_range(priv->timeout_min,
-			     priv->timeout_max);
 	} while (time_before(jiffies, stop));
 	return -ETIME;
 }

