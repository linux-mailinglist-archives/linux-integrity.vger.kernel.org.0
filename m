Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAD6EF81E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbjDZQHI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZQHH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 12:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E24EF3;
        Wed, 26 Apr 2023 09:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD0B60C58;
        Wed, 26 Apr 2023 16:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E3AC4339B;
        Wed, 26 Apr 2023 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682525226;
        bh=MtdltU0gId4xiQS9pBYRsib3cwgvWJxO+NqnGQqu2vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7r9VsvZreCFlc+MHRmUOvuUsDXVcks2Q/e7B+wnn+0tuHK2O7dPNtfFcFbyB8Msk
         2rib2E5XuVZ0n3ZXHisfJQkJi8nmvPJegXx73MK1ufwAZ6SAN/pHGjfbCsWvpIU0VZ
         rzfHi41OPYzHwp2PmEP1fRLSBx4ep0vb9JNH4q1mNED4vk7zXWxPSFwrq52NZvvK4J
         LeP9O5Ckh+8Zo6Ajhy/B5FetnjHkDCPLeErRXKkeR8Vjsql55S/WEq43MHiBBH8oIU
         M1nhck9oIfacvQfZiY2CNV9PvCZUXMaCFina+WZK7N/NDSDDrNAd2egH5CFvElGdti
         edn8Fqk6KiQvg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 26 Apr 2023 19:07:01 +0300
Message-Id: <CS6TEW6NY7FJ.39VTQYTEN8FBH@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, "Jan Dabros" <jsd@semihalf.com>,
        <regressions@lists.linux.dev>,
        "LKML" <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Johannes Altmanninger" <aclopte@gmail.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
X-Mailer: aerc 0.14.0
References: <Y60RoP77HnwaukEA@zx2c4.com>
 <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com>
 <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org>
 <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
 <ZBBxMl5rVjY9FGS9@kernel.org> <ZBBxxftnXHVOjm92@kernel.org>
 <ZBB8R9H3CyQnNfCt@zx2c4.com> <ZBCDeleGG/fFlkt+@kernel.org>
 <ZEKlzaQhjd8sbE7I@kernel.org>
 <CAHmME9q9DZyYo7G__ks=XSrS4kS8sUUZ+eF3c1VSnGCAvfBR+Q@mail.gmail.com>
 <CS48U6SYIBVB.V05DUEX5I01F@suppilovahvero>
 <CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero>
 <CAHmME9o3HK2ju-HBYpSbB_7-9x5A2rD0ev3gaiLLjB_J8-Ju4Q@mail.gmail.com>
In-Reply-To: <CAHmME9o3HK2ju-HBYpSbB_7-9x5A2rD0ev3gaiLLjB_J8-Ju4Q@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Apr 26, 2023 at 4:32 AM EEST, Jason A. Donenfeld wrote:
> Nice work! Happy that you got it figured out. That trace seems
> consistent with what I was seeing in my traces, so I think you've
> spotted the right bug.
>
> Jason

Unfortunately there might be two bugs. Unless I interpreted logs
incorrectly also hwrng can race with resume (sorry, I forgot to
save it).

Looking at drivers/char/hw_random/core.c there seems to be no
binding to the PM so I guess that this it supports what I'm
observing [*].

So there's two ways to fix the issue:

1. Unregister hwrng for the course of suspend
2. Add something like TPM_CHIP_SUSPENDED, which is set by suspend and
   cleared by the resume.

I try the 2nd option first because I see it less complicated.
Probably would make sense to turn chip flags as atomic while
at it.

[*] https://elixir.bootlin.com/linux/latest/source/drivers/char/hw_random/c=
ore.c

BR, Jarkko
