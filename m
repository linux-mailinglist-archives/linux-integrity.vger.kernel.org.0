Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFE6B97D7
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCNOYg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCNOYf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 10:24:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF2A64B22;
        Tue, 14 Mar 2023 07:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0373B81999;
        Tue, 14 Mar 2023 14:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39E8C433EF;
        Tue, 14 Mar 2023 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678803840;
        bh=aQ57cJoWuOqPcdScGMzodxGhUAhK9wHEsdJIH8flygQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+cKkEPNFcexOgXohZaB+iNjkQHzIZL5XPZWPJjXRLPN/ewFERyszb3skfJGCpkP2
         a1UMjJwggYl3JB9yXlVIJZ9sC0jL3u0JnA8TawI1wX/mTcdk7nJhm6Ul+r3w/Q/oev
         FSsWYaEJ9LvekhF+u06AvlJGoDm1evzTuLnq47hx3Unc/Ex2aK96XXwcMHV2m1wNWD
         LAehdJpawro1d2PwDQ8YkY5IYagp3TJbImbtNtAdrhK6+cllEp6x7iskmUF6u2XbKE
         84aqJ0D5hx187U8xi4QdoXQNAmr+NTZY+ZWhoPPkRSV9uSvdymVnQobcQxut8tJl/5
         rwMy9E+LU7aCw==
Date:   Tue, 14 Mar 2023 16:23:54 +0200
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
Message-ID: <ZBCDeleGG/fFlkt+@kernel.org>
References: <c39cc02da9f60412a0f7f7772ef3d89e4a081d38.camel@HansenPartnership.com>
 <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
 <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org>
 <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
 <ZBBxMl5rVjY9FGS9@kernel.org>
 <ZBBxxftnXHVOjm92@kernel.org>
 <ZBB8R9H3CyQnNfCt@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBB8R9H3CyQnNfCt@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 02:53:11PM +0100, Jason A. Donenfeld wrote:
> On Tue, Mar 14, 2023 at 03:08:21PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Mar 14, 2023 at 03:06:47PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Mar 14, 2023 at 01:47:38PM +0100, Jason A. Donenfeld wrote:
> > > > On 3/14/23, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > On Tue, Mar 14, 2023 at 10:35:33AM +0100, Thorsten Leemhuis wrote:
> > > > >> On 09.01.23 17:08, Jason A. Donenfeld wrote:
> > > > >> > On Thu, Jan 05, 2023 at 02:59:15PM +0100, Thorsten Leemhuis wrote:
> > > > >> >> On 29.12.22 05:03, Jason A. Donenfeld wrote:
> > > > >> >>> On Wed, Dec 28, 2022 at 06:07:25PM -0500, James Bottomley wrote:
> > > > >> >>>> On Wed, 2022-12-28 at 21:22 +0100, Vlastimil Babka wrote:
> > > > >> >>>>> Ugh, while the problem [1] was fixed in 6.1, it's now happening
> > > > >> >>>>> again
> > > > >> >>>>> on the T460 with 6.2-rc1. Except I didn't see any oops message or
> > > > >> >>>>> "tpm_try_transmit" error this time. The first indication of a
> > > > >> >>>>> problem
> > > > >> >>>>> is this during a resume from suspend to ram:
> > > > >> >>>>> tpm tpm0: A TPM error (28) occurred continue selftest
> > > > >> >>>>> and then periodically
> > > > >> >>>>> tpm tpm0: A TPM error (28) occurred attempting get random
> > > > >> >>>>
> > > > >> >>>> That's a TPM 1.2 error which means the TPM failed the selftest.  The
> > > > >> >>>> original problem was reported against TPM 2.0  because of a missing
> > > > >> >>>> try_get_ops().
> > > > >> >>>
> > > > >> >>> No, I'm pretty sure the original bug, which was fixed by "char: tpm:
> > > > >> >>> Protect tpm_pm_suspend with locks" regards 1.2 as well, especially
> > > > >> >>> considering it's the same hardware from Vlastimil causing this. I
> > > > >> >>> also
> > > > >> >>> recall seeing this in 1.2 when I ran this with the TPM emulator. So
> > > > >> >>> that's not correct.
> > > > >> > [...]
> > > > >> > So, this is now in rc3:
> > > > >> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1382999aa0548a171a272ca817f6c38e797c458c
> > > > >> >
> > > > >> > That should help avoid the worst of the issue -- laptop not sleeping.
> > > > >> > But the race or whatever it is still does exist. So you might want to
> > > > >> > keep this in your tracker to periodically nudge the TPM folks about it.
> > > > >>
> > > > >> I did, and with -rc2 out now is a good time to remind everybody about
> > > > >> it. Jarkko even looked into it, but no real fix emerged afaics. Or did
> > > > >> it?
> > > > >
> > > > > Jason's workaround was picked. I asked some questions in the thread but
> > > > > have not received any responses.
> > > > 
> > > > As I've written several times now, that patch doesn't fix the issue.
> > > > It makes it less common but it still exists and needs to be addressed.
> > > > Please re-read my various messages describing this. I have nothing new
> > > > at all to add; you just need to review my prior comments. There's a
> > > > bug that probably needs to be fixed here by somebody who understands
> > > > the tpm1 code.
> > > 
> > > I'll try qemu path to see if I can reproduce it with/without the already
> > > merged workaround.
> > 
> > BTW, what sort of environment you had for your qemu run? I'm creating a
> > simple initramfs with buildroot for this.
> 
> Nothing special at all in the userspace.
> 
> I think details of my test bed might be in some other thread from when
> that original patch went in or when the original bug report came, but
> from memory, I believe what I did to reliably reproduce various issues
> was comment out the sleep in random.c so that it keeps asking the TPM
> for more bytes from the kthread, like this:
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index ce3ccd172cc8..708110c780aa 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -934,20 +934,20 @@ EXPORT_SYMBOL(add_device_randomness);
>  void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy, bool sleep_after)
>  {
>  	mix_pool_bytes(buf, len);
>  	credit_init_bits(entropy);
> 
>  	/*
>  	 * Throttle writing to once every reseed interval, unless we're not yet
>  	 * initialized or no entropy is credited.
>  	 */
> -	if (sleep_after && !kthread_should_stop() && (crng_ready() || !entropy))
> -		schedule_timeout_interruptible(crng_reseed_interval());
> +//	if (sleep_after && !kthread_should_stop() && (crng_ready() || !entropy))
> +//		schedule_timeout_interruptible(crng_reseed_interval());
>  }
>  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> 
>  /*
>   * Handle random seed passed by bootloader, and credit it depending
>   * on the command line option 'random.trust_bootloader'.
>   */
>  void __init add_bootloader_randomness(const void *buf, size_t len)
>  {
> 
> Then I hooked the tpm emulator up to qemu and put it in tpm1 mode. I had
> userspace `echo mem > /sys/power/state` every couple of seconds (or
> continuously maybe?), and then I used the qemu monitor interface to wake
> the system from sleep. And kaboom.

Thanks for the tips! I'll try various patch combinations and see what
happens.

BR, Jarkko
