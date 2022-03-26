Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC234E8025
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Mar 2022 10:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiCZJBo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Mar 2022 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiCZJBn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Mar 2022 05:01:43 -0400
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACEA1A3B8;
        Sat, 26 Mar 2022 02:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648285180; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=U0KH9TtA849ZQpQgkzTQJHBLd+gA6KyKITRo6oId6yDEWJX/6mqwQi8g2N8k5yVs8+BpnR2MN7Pabu+CXap2KPcXYjX1T9sgLA0HCNT/lIDoB+UDhpvLg1ZZeihANwvHbGNhEFCjEneT+9UuFBk4RIdAQu2Cx4C6NF5VSpD/E0s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648285180; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LOOCE7XdBN7XwT4sC/6xpw4M6jD70wZ1Ts5Ft73PBqA=; 
        b=UQ3clG9XqqA9QAZiUAvMSN/i+xkw7yJ4DJAF1W0ItzksMWzFJzBxvNZqSK/bcTbhoIZ7bM1aTPNvjvDMRSKX4JQt73H7r9qi04beZMe4pEKZQunb18IGWsHrXufxFzJML6zPHYyZPHAumunbLG139mqcWgAWfApxjgXozVbsLU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1648285177777877.9724402004048; Sat, 26 Mar 2022 01:59:37 -0700 (PDT)
Message-ID: <7028ffce7164986435e8bb9566f09bb79730c554.camel@mniewoehner.de>
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        stefanb@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org
In-Reply-To: <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
         <20210501135727.17747-3-LinoSanfilippo@gmx.de>
         <YJAby8mmiJ74qWAh@kernel.org> <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
         <YJNKs8bUMGOzFre+@kernel.org>
         <2a1a1cf61732eff1608aeae74054a0c135c1671f.camel@mniewoehner.de>
         <Yj0lhqTP1RoedxSc@iki.fi>
         <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
         <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 26 Mar 2022 09:59:33 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lino,

On Sat, 2022-03-26 at 04:24 +0100, Lino Sanfilippo wrote:
> 
> Hi Michael,
> 
> On 25.03.22 at 13:32, Michael Niewöhner wrote:
> > > > 
> > > > Lino, I'd be happy to test the patches, when you have time and interest
> > > > to
> > > > work
> > > > on this again!
> > > > 
> > > > Thanks, Michael
> > > 
> > > It's quite easy to test them out. Both fixes are in the mainline GIT tree.
> > > E.g. give a shot rc1, and please report if any issues persists to:
> > > 
> > >   linux-integrity@vger.kernel.org 
> > > 
> > > BR, Jarkko
> > 
> > I don't see Linos patches on mainline. Also, the series included four
> > patches:
> > [PATCH v3 0/4] Fixes for TPM interrupt handling
> > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > [PATCH v3 2/4] tpm: Simplify locality handling
> > [PATCH v3 3/4] tpm: Fix test for interrupts
> > [PATCH v3 4/4] tpm: Only enable supported irqs
> > 
> > Three of them are relevant for the interrupt problem, which is still present
> > in
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

IMHO a series is perfectly fine, as it's easier to show *why* single changes are
required (like already done in v3 0/4). One just has to actually *read* what's
written there. Ahem. It's up to you, though.

> 
> A first step could be to have a sleepable context for the interrupt handling,
> since in case of SPI the accesses to the irq status register may sleep.
> 
> I sent a patch for this purpose once, but it seems to have gone lost:
> 
> https://lore.kernel.org/all/20210620023444.14684-1-LinoSanfilippo@gmx.de/
> 

Jarkko, looks like you've already tested that patch on your NUC?

> 
> Best regards,
> Lino
> 


Michael
