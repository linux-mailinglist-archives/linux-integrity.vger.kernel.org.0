Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042636B9597
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 14:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCNNKW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjCNNJy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 09:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B39AB8BD;
        Tue, 14 Mar 2023 06:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2A86176D;
        Tue, 14 Mar 2023 13:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A6C433EF;
        Tue, 14 Mar 2023 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678799165;
        bh=0XsjQknlIVLtvJ4Szh+4sUw0e3LItWQ1le/lbVxC4Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+ZDiuqqpf6hPedrL+HcNUHmt8nyxrtZrFc7GB5oQ0n7cPWVgbHJpXq9yUSMlyC2/
         7/PLty15+plMwyV08QX85+9iq1l5DSjdtur/9gn5Li4/oFuqVDXZpPrEjHpAppNac0
         4YLMeYyMzMN9X3c6/Vcw8nVbVvT3VGcIqJ6xdirhCMKZHJM+rRhkbl2Mlb6rS38A5m
         tbtqmnRCSnD8a9XSWmNWhO6RHGjDR8rsIOjQitXXhG/jgKlTRstf6vYWefgtd9kLXi
         uG66uakB49UdwW7dKCi7NU6YOQk2TNJGFo6aGIjZyLRT402f0bRHRr+/+Ayv8zgVjv
         YFuGwHSVBj/nA==
Date:   Tue, 14 Mar 2023 15:05:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
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
Message-ID: <ZBBxMl5rVjY9FGS9@kernel.org>
References: <7cbe96cf-e0b5-ba63-d1b4-f63d2e826efa@suse.cz>
 <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
 <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org>
 <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 01:47:38PM +0100, Jason A. Donenfeld wrote:
> On 3/14/23, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Tue, Mar 14, 2023 at 10:35:33AM +0100, Thorsten Leemhuis wrote:
> >> On 09.01.23 17:08, Jason A. Donenfeld wrote:
> >> > On Thu, Jan 05, 2023 at 02:59:15PM +0100, Thorsten Leemhuis wrote:
> >> >> On 29.12.22 05:03, Jason A. Donenfeld wrote:
> >> >>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
> >> >>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> >> >>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening
> >> >>>>> again
> >> >>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
> >> >>>>> "tpm_try_transmit" error this time. The first indication of a
> >> >>>>> problem
> >> >>>>> is this during a resume from suspend to ram:
> >> >>>>> tpm tpm0: A TPM error (28) occurred continue selftest
> >> >>>>> and then periodically
> >> >>>>> tpm tpm0: A TPM error (28) occurred attempting get random
> >> >>>>
> >> >>>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
> >> >>>> original problem was reported against TPM 2.0  because of a missing
> >> >>>> try_get_ops().
> >> >>>
> >> >>> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
> >> >>> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
> >> >>> considering it's the same hardware from Vlastimil causing this. I
> >> >>> also
> >> >>> recall seeing this in 1.2 when I ran this with the TPM emulator. So
> >> >>> that's not correct.
> >> > [...]
> >> > So, this is now in rc3:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1382999aa0548a171a272ca817f6c38e797c458c
> >> >
> >> > That should help avoid the worst of the issue -- laptop not sleeping.
> >> > But the race or whatever it is still does exist. So you might want to
> >> > keep this in your tracker to periodically nudge the TPM folks about it.
> >>
> >> I did, and with -rc2 out now is a good time to remind everybody about
> >> it. Jarkko even looked into it, but no real fix emerged afaics. Or did
> >> it?
> >
> > Jason's workaround was picked. I asked some questions in the thread but
> > have not received any responses.
> 
> As I've written several times now, that patch doesn't fix the issue.
> It makes it less common but it still exists and needs to be addressed.
> Please re-read my various messages describing this. I have nothing new
> at all to add; you just need to review my prior comments. There's a
> bug that probably needs to be fixed here by somebody who understands
> the tpm1 code.

I'll try qemu path to see if I can reproduce it with/without the already
merged workaround.

BR, Jarkko
