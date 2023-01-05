Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686AA65F020
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jan 2023 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAEPcf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Jan 2023 10:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAEPcJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jan 2023 10:32:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BB1C134;
        Thu,  5 Jan 2023 07:32:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EAA61AFB;
        Thu,  5 Jan 2023 15:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1BFC433F0;
        Thu,  5 Jan 2023 15:32:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jdvT5lkh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672932723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IeZGnYRH9T7WJ2VSE08aDmiWGF7wYWpmACCmuXS+lbE=;
        b=jdvT5lkhYyOjEH5H6szyNkicjxd1HoMWHAeliNoF1ziKS0+rcFb252yCX5/2Dbu/RMLq2k
        nCbLzMu4qBpFim455LpqrqhszI/l8fCdbGEZNctr0QhF01nDvdmVkdlDT7DdxhJ2FANL+k
        +de0l60KLlQfVSu3MSKKTSdceayTuL8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 32ec48c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Jan 2023 15:32:03 +0000 (UTC)
Date:   Thu, 5 Jan 2023 16:32:00 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
Message-ID: <Y7btcIGI0LpiqN68@zx2c4.com>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
 <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <2d07d185384ed444bef46648316354ef5afd481a.camel@HansenPartnership.com>
 <Y7bsRufCECNoPW+T@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7bsRufCECNoPW+T@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 05, 2023 at 04:27:02PM +0100, Jason A. Donenfeld wrote:
> On Thu, Jan 05, 2023 at 10:17:57AM -0500, James Bottomley wrote:
> > On Thu, 2023-01-05 at 14:59 +0100, Thorsten Leemhuis wrote:
> > > On 29.12.22 05:03, Jason A. Donenfeld wrote:
> > > > On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
> > > > > On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> > > > > > Ugh, while the problem [1] was fixed in 6.1, it's now happening
> > > > > > again on the T460 with 6.2-rc1. Except I didn't see any oops
> > > > > > message or "tpm_try_transmit" error this time. The first
> > > > > > indication of a problem is this during a resume from suspend to
> > > > > > ram:
> > > > > > 
> > > > > > tpm tpm0: A TPM error (28) occurred continue selftest
> > > > > > 
> > > > > > and then periodically 
> > > > > > 
> > > > > > tpm tpm0: A TPM error (28) occurred attempting get random
> > > > > 
> > > > > That's a TPM 1.2 error which means the TPM failed the selftest. 
> > > > > The original problem was reported against TPM 2.0  because of a
> > > > > missing try_get_ops().
> > > > 
> > > > No, I'm pretty sure the original bug, which was fixed by "char:
> > > > tpm: Protect tpm_pm_suspend with locks" regards 1.2 as well,
> > > > especially considering it's the same hardware from Vlastimil
> > > > causing this. I also recall seeing this in 1.2 when I ran this with
> > > > the TPM emulator. So that's not correct.
> > > 
> > > James, are you or some other TPM developer looking into this? Or is
> > > this deadlocked now?
> > 
> > Not really: TPM 1.2 way predates my interest in the TPM subsystem, and
> > I've only ever done patches to 2.0.  I can look at the paths
> > theoretically, but I don't have any hardware.  Self Test failures tend
> > to be hardware specific, so even poking around in the emulator is
> > unlikely to give what might be the cause.
> > 
> > >  And if so: how can we get this unstuck to get this regression
> > > solved?
> > 
> > One of the TPM maintainers with hardware (possibly the specific TPM ...
> > what is it, by the way?) needs to get involved.
> 
> I already wrote in my last email [1] that this simply isn't the case.
> The issue reproduces in QEMU + the emulator. It's far more likely to be
> a locking/race situation [2] than some kind of obscure hardware bug.
> 
> Jason
> 
> [1] https://lore.kernel.org/lkml/Y60RoP77HnwaukEA@zx2c4.com/
> [2] https://lore.kernel.org/lkml/Y60Uu8HcGyXasnOO@zx2c4.com/

I should add, though, that I don't fault you for lack of interest in TPM
1.2. Folks work on what they care about. If the rest of the TPM team has
a similar feeling, maybe it's best to just merge [3], rather than let
the bug linger forever? And possibly talk about sunsetting TPM 1 support
entirely if there's nobody to work on it and fix issues that inevitably
will come up? Just trying to look at the big picture here, you know...

[3] https://lore.kernel.org/lkml/20230105144742.3219571-1-Jason@zx2c4.com/
