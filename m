Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5456EADAE
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjDUPDs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjDUPDr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 11:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C5810DD;
        Fri, 21 Apr 2023 08:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4603760D33;
        Fri, 21 Apr 2023 15:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E3C433EF;
        Fri, 21 Apr 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682089424;
        bh=Ssl54N08hcIsL4K1OwVsyYR15G7wERqkfvdOZ49GqUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nqtg1DtSN9c2qm79I5pki/emr651+SWVvPrDxYxCLyXT3myuhVo6dj9IGaox7IIYO
         KIsEtGywhpS4Yb6Ka18RqepA4tWxJeUgQS17X5rgqqqAzAvykRPrXTIQGiDWDS4iCz
         0F5ncMvRIGwDJsybytKhX1YGkzWB36N1V5yziETw+/OjEym9YQGYrogh7wMoRJ97Ei
         3/nyVkAtSdHZXd1iWefNCUGOb6yMfdXtsYjKiGZH1yy2Q17B49x8TS+ie2VnJ4ciWY
         iaGdFZA3+KXL0ENohLFqvj2SdSVb5VvW7g6BR0UbUAHgAmwZGxyVgADJk2yvgs2fhu
         5i2CtSUlrZ3Pw==
Date:   Fri, 21 Apr 2023 18:03:41 +0300
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
Message-ID: <ZEKlzaQhjd8sbE7I@kernel.org>
References: <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
 <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org>
 <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
 <ZBBxMl5rVjY9FGS9@kernel.org>
 <ZBBxxftnXHVOjm92@kernel.org>
 <ZBB8R9H3CyQnNfCt@zx2c4.com>
 <ZBCDeleGG/fFlkt+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBCDeleGG/fFlkt+@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 04:23:54PM +0200, Jarkko Sakkinen wrote:
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index ce3ccd172cc8..708110c780aa 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -934,20 +934,20 @@ EXPORT_SYMBOL(add_device_randomness);
> >  void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy, bool sleep_after)
> >  {
> >  	mix_pool_bytes(buf, len);
> >  	credit_init_bits(entropy);
> > 
> >  	/*
> >  	 * Throttle writing to once every reseed interval, unless we're not yet
> >  	 * initialized or no entropy is credited.
> >  	 */
> > -	if (sleep_after && !kthread_should_stop() && (crng_ready() || !entropy))
> > -		schedule_timeout_interruptible(crng_reseed_interval());
> > +//	if (sleep_after && !kthread_should_stop() && (crng_ready() || !entropy))
> > +//		schedule_timeout_interruptible(crng_reseed_interval());
> >  }
> >  EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> > 
> >  /*
> >   * Handle random seed passed by bootloader, and credit it depending
> >   * on the command line option 'random.trust_bootloader'.
> >   */
> >  void __init add_bootloader_randomness(const void *buf, size_t len)
> >  {
> > 
> > Then I hooked the tpm emulator up to qemu and put it in tpm1 mode. I had
> > userspace `echo mem > /sys/power/state` every couple of seconds (or
> > continuously maybe?), and then I used the qemu monitor interface to wake
> > the system from sleep. And kaboom.
> 
> Thanks for the tips! I'll try various patch combinations and see what
> happens.

I created a VM using libvirt with the following configuration [*]

<tpm model='tpm-tis'>
  <backend type='emulator' version='1.2'/>
  <alias name='tpm0'/>
</tpm>

I do not have issues with suspend so far with unmodified v6.3-rc7.

It would be nice to have a script that gives a guaranteed crash with
unmodified kernel even if run for some hours.

Instead of using QEMU monitor interface and /sys/power/state, I wonder
if a stress test could be based on looping rtcwake for easier comparison
of results?

[*] full description: https://gist.github.com/jarkkojs/66ea0d8d6a927311e8abb8b35e1ddbcd

BR, Jarkko
