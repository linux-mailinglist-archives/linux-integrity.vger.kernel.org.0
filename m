Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688834EC809
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Mar 2022 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiC3PUS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Mar 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiC3PUS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Mar 2022 11:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4515AAE2;
        Wed, 30 Mar 2022 08:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD9EB81B2F;
        Wed, 30 Mar 2022 15:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6FAC340EE;
        Wed, 30 Mar 2022 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648653510;
        bh=NZtLh5n6uJudC6+M/fqWrHQmUDG8lg9LYqRK+f4nvX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruhvSz9i814m2acImZ8wezw8pt9oMQE/BYobaaOwb3vLi5z/HHeh0CSkeEWv6lyWd
         UCQfXZqZPLYKcO7Eojt4wRAl95VVc6azBSSLCJR72NGHcX31LL1YjpnOPrn7VeQpoR
         obdm0UJ7Er6CAc26SzKAWCb2K+FLNalfJPQkjU0JBC/whtTQa+pNzLfHHYc0IAHO3P
         AQehrXVERFc+FBwjA92LGaZaZDU74jMpzsllrBOpZ8lCwTC8v1dj8rzQcyVr7XWS5T
         MLvw3enPVAM94v0FcVgklslr83imDChpCVniRyWcEDl0/KvSPKeow6GaNicu86zm3X
         BW3xZbivVEYfg==
Date:   Wed, 30 Mar 2022 18:19:37 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        stefanb@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
Message-ID: <YkR1Cf/5ZvHK2I2j@iki.fi>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de>
 <YJAby8mmiJ74qWAh@kernel.org>
 <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
 <YJNKs8bUMGOzFre+@kernel.org>
 <2a1a1cf61732eff1608aeae74054a0c135c1671f.camel@mniewoehner.de>
 <Yj0lhqTP1RoedxSc@iki.fi>
 <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
 <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 26, 2022 at 04:24:55AM +0100, Lino Sanfilippo wrote:
> 
> Hi Michael,
> 
> On 25.03.22 at 13:32, Michael Niewöhner wrote:
> >>>
> >>> Lino, I'd be happy to test the patches, when you have time and interest to
> >>> work
> >>> on this again!
> >>>
> >>> Thanks, Michael
> >>
> >> It's quite easy to test them out. Both fixes are in the mainline GIT tree.
> >> E.g. give a shot rc1, and please report if any issues persists to:
> >>
> >>   linux-integrity@vger.kernel.org 
> >>
> >> BR, Jarkko
> >
> > I don't see Linos patches on mainline. Also, the series included four patches:
> > [PATCH v3 0/4] Fixes for TPM interrupt handling
> > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > [PATCH v3 2/4] tpm: Simplify locality handling
> > [PATCH v3 3/4] tpm: Fix test for interrupts
> > [PATCH v3 4/4] tpm: Only enable supported irqs
> >
> > Three of them are relevant for the interrupt problem, which is still present in
> > mainline, as these patches were refused:
> > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > [PATCH v3 2/4] tpm: Simplify locality handling
> > [PATCH v3 3/4] tpm: Fix test for interrupts
> >
> > Michael
> >
> 
> You are right, the interrupts are still not working in the mainline kernel.
> I would gladly make another attempt to fix this but rather step by step
> than in a series that tries to fix (different) things at once.
> 
> A first step could be to have a sleepable context for the interrupt handling,
> since in case of SPI the accesses to the irq status register may sleep.
> 
> I sent a patch for this purpose once, but it seems to have gone lost:
> 
> https://lore.kernel.org/all/20210620023444.14684-1-LinoSanfilippo@gmx.de/
> 
> 
> Best regards,
> Lino

This is clearly my bad I'll test this ASAP.

BR, Jarkko
