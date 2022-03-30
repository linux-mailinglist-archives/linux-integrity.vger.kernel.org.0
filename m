Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949C4EC800
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Mar 2022 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiC3PTA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Mar 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348229AbiC3PSw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Mar 2022 11:18:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFF15282F;
        Wed, 30 Mar 2022 08:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BA13B81B2F;
        Wed, 30 Mar 2022 15:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5162DC340EE;
        Wed, 30 Mar 2022 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648653423;
        bh=u2jR/AODUADFu7Jvj8F3udIhitEKoWuiVbotMtsdjZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcE7B86EEgq0AXr8xciTdsqSMhDD0atGPgD2K1pgNdDbr04q3R1psgAFvGIoOkYlw
         OMG50Q+MwKVxawsSOWEQwateeCigV6G68saMpMUH+EceUbschdTnfEwg3UojvbLBpe
         0dTMu7CqKNJcAfuri3W0BDjAkp4JLtPBZnMPO7Q6LSkN9OzEo8cjuI7CdCnta++I37
         uhLuBHbEkQaqyGmtg1donjJV/ZLwQHXhERcEAjdEMsdqyjSywPYGYzpGB/0lJQWohP
         he04cmeyoZg1qwd9qLKmbHacX7VW50yXyAQIDwgQAqwPMLu5EH8wPOBAJau2r63Yi+
         ZID4HoM7MdcuA==
Date:   Wed, 30 Mar 2022 18:18:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.vnet.ibm.com, stefanb@linux.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
Message-ID: <YkR0sZq/nwbrFILm@iki.fi>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de>
 <YJAby8mmiJ74qWAh@kernel.org>
 <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
 <YJNKs8bUMGOzFre+@kernel.org>
 <2a1a1cf61732eff1608aeae74054a0c135c1671f.camel@mniewoehner.de>
 <Yj0lhqTP1RoedxSc@iki.fi>
 <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 25, 2022 at 01:32:25PM +0100, Michael Niewöhner wrote:
> On Fri, 2022-03-25 at 04:14 +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 24, 2022 at 06:04:23PM +0100, Michael Niewöhner wrote:
> > > Hi guys,
> > > 
> > > On Thu, 2021-05-06 at 04:47 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, May 05, 2021 at 01:15:29AM +0200, Lino Sanfilippo wrote:
> > > > > Hi,
> > > > > 
> > > > > On 03.05.21 at 17:50, Jarkko Sakkinen wrote:
> > > > > > What the heck is "simplification" and what that has to do with fixing
> > > > > > anything? I don't understand your terminology.
> > > > > 
> > > > > 
> > > > > The intention for this patch is not to fix anything. Please read the
> > > > > cover
> > > > > letter and the commit message.
> > > > > This patch is about making the locality handling easier by not
> > > > > claiming/releasing
> > > > > it multiple times over the driver life time, but claiming it once at
> > > > > driver
> > > > > startup and only releasing it at driver shutdown.
> > > > > 
> > > > > Right now we have locality request/release combos in
> > > > > 
> > > > > - probe_itpm()
> > > > > - tpm_tis_gen_interrupt()
> > > > > - tpm_tis_core_init()
> > > > > - tpm_chip_start()
> > > > > 
> > > > > and there is still one combo missing for
> > > > > 
> > > > > - tpm2_get_timeouts()
> > > > > 
> > > > > which is the reason why we get the "TPM returned invalid status" bug in
> > > > > case
> > > > > of TPM2 (and this is the bug which is _incidentally_ fixed by this
> > > > > patch,
> > > > > see
> > > > > below).
> > > > > 
> > > > > And if we are going to enable interrupts, we have to introduce yet
> > > > > another
> > > > > combo,
> > > > > for accessing the status register in the interrupt handler, since TPM
> > > > > 2.0
> > > > > requires holding the locality for writing to the status register. That
> > > > > makes
> > > > > 6 different code places in which we take and release the locality.
> > > > > 
> > > > > With this patch applied we only take the locality at one place.
> > > > > Furthermore
> > > > > with interrupts enabled we dont have to claim the locality for each
> > > > > handler
> > > > > execution, saving us countless claim/release combinations at runtime.
> > > > > 
> > > > > Hence the term "simplification" which is perfectly justified IMO.
> > > > > 
> > > > > So again, this patch is "only" in preparation for the next patch when
> > > > > interrupts
> > > > > are actually enabled and we would have to take the locality in the
> > > > > interrupt
> > > > > handler without this patch.
> > > > 
> > > > So: what problem this patch does solve?
> > > > 
> > > > /Jarkko
> > > > 
> > > 
> > > first, thank you very much, Lino, for working on this! I've been debugging
> > > issues with the tis driver in the last days and was about to start with the
> > > same
> > > approach as yours when I luckily discovered your patch!
> > > 
> > > Jarkko, while I agree, that the commit message is not optimal, Lino tried
> > > hard
> > > to explain what the problems with the current code are and how they are /
> > > can be
> > > fixed. Further, I too don't see why simplification / optimization is such a
> > > bad
> > > thing. This driver is actually a very good example. I had a hard time, too,
> > > figuring out what's going on there. A clean rewrite is a very valid approach
> > > here IMO. It's not "polishing for nothing", as you described it, but
> > > actually
> > > solving problems.
> > > 
> > > Interrupt detection is broken for years now and finally a volunteer worked
> > > on a
> > > solution. Don't you think this should be valued? Let's get this problem
> > > sorted
> > > out :-)
> > > 
> > > Lino, I'd be happy to test the patches, when you have time and interest to
> > > work
> > > on this again!
> > > 
> > > Thanks, Michael
> > 
> > It's quite easy to test them out. Both fixes are in the mainline GIT tree.
> > E.g. give a shot rc1, and please report if any issues persists to:
> > 
> >   linux-integrity@vger.kernel.org 
> > 
> > BR, Jarkko
> 
> I don't see Linos patches on mainline. Also, the series included four patches:
> [PATCH v3 0/4] Fixes for TPM interrupt handling
> [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> [PATCH v3 2/4] tpm: Simplify locality handling
> [PATCH v3 3/4] tpm: Fix test for interrupts
> [PATCH v3 4/4] tpm: Only enable supported irqs
> 
> Three of them are relevant for the interrupt problem, which is still present in
> mainline, as these patches were refused:
> [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> [PATCH v3 2/4] tpm: Simplify locality handling
> [PATCH v3 3/4] tpm: Fix test for interrupts
> 
> Michael

There was some unaddressed feedback, most of not that hard to address.
I'm waiting for v4.

BR, Jarkko
