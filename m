Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036A06B93C5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 13:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCNMaK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjCNM3x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 08:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92181A0F23;
        Tue, 14 Mar 2023 05:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0962661763;
        Tue, 14 Mar 2023 12:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022E6C4339B;
        Tue, 14 Mar 2023 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678796378;
        bh=FLpm2E7UClJUtW1FBykKxqNsf/z3ka1CkpWMW1ncwd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4AuwI9ebk46aq0uqpqsqMou8lvYa7CesfmxKehCe5SiqTYnXbQ3GeNR7Asg2fr4I
         g92iIhIfVwdvYWPaeR9npJxx4UB3ubhwXwk/UwSZwoC1uqIKlVNI6zi6XMdLPbEOXt
         LyqS2PIaAFZpC+k8DgHfbQmM2yVaAnf/EGLRhxky6dwyhWKxqX8hsQGUiAG2IEeyaU
         VHiAOYP2D1HDkkewhNaWxWReV8f91VjOvQLvcR6ZIvxU/qeGaC1FUWk+ketzJGoz2K
         D5Jh+SrG/bFoflOTIBJyDT/5o4Nj/ou6xPbF+8AVeLv+kKhyuvoKrgjWH7kZGuxTLf
         /a+p5AhpWObVg==
Date:   Tue, 14 Mar 2023 14:19:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
Message-ID: <ZBBmVhwsTf/URoqs@kernel.org>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
 <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
 <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 10:35:33AM +0100, Thorsten Leemhuis wrote:
> On 09.01.23 17:08, Jason A. Donenfeld wrote:
> > On Thu, Jan 05, 2023 at 02:59:15PM +0100, Thorsten Leemhuis wrote:
> >> On 29.12.22 05:03, Jason A. Donenfeld wrote:
> >>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
> >>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> >>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening again
> >>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
> >>>>> "tpm_try_transmit" error this time. The first indication of a problem
> >>>>> is this during a resume from suspend to ram:
> >>>>> tpm tpm0: A TPM error (28) occurred continue selftest
> >>>>> and then periodically 
> >>>>> tpm tpm0: A TPM error (28) occurred attempting get random
> >>>>
> >>>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
> >>>> original problem was reported against TPM 2.0  because of a missing
> >>>> try_get_ops().
> >>>
> >>> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
> >>> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
> >>> considering it's the same hardware from Vlastimil causing this. I also
> >>> recall seeing this in 1.2 when I ran this with the TPM emulator. So
> >>> that's not correct.
> > [...]
> > So, this is now in rc3:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1382999aa0548a171a272ca817f6c38e797c458c
> > 
> > That should help avoid the worst of the issue -- laptop not sleeping.
> > But the race or whatever it is still does exist. So you might want to
> > keep this in your tracker to periodically nudge the TPM folks about it.
> 
> I did, and with -rc2 out now is a good time to remind everybody about
> it. Jarkko even looked into it, but no real fix emerged afaics. Or did it?

Jason's workaround was picked. I asked some questions in the thread but
have not received any responses.

BR, Jarkko
