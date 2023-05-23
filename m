Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED570E507
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjEWTAW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjEWTAR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 15:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A25121;
        Tue, 23 May 2023 12:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE40363243;
        Tue, 23 May 2023 19:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D572C433EF;
        Tue, 23 May 2023 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684868415;
        bh=EboveRVZily0LxvjRPAAzYI93aJyTa8q8HaJCBCiKDc=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Crf2tafz+IBRlBpshr/Z0V0PT+b0TAbU022bxe6bXKy65m+838zlM7LLeUqJaVge0
         UN1jD82cLj/KLK7fHNZRaWdh/KoBb2as3gUKEi7hot0CnvGy1OVWzuSl6vfkUC6xcO
         4QbI44psw0OY/0LyAnWKHyz5+4Aszl779Q871sxtOC8p4N+FB28PYMM3dyUtBidUwa
         TqmEj43Upw9A2A2NgrOrRcRPFWL/KBiwf4wvGJRmCcX35cZ3jHWyJ1gUfLVpfXctwO
         4feKvLIVVvyCgt+YsQb9uBqh7XDPfwbDFqFSM8mR2COSfR9CtsqjYQMFPBwzXO68GV
         AA82u8N1Eh/cQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 May 2023 22:00:10 +0300
Message-Id: <CSTW066CTZ5M.2JR61D32CFSZL@suppilovahvero>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
In-Reply-To: <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 23, 2023 at 9:53 PM EEST, Jarkko Sakkinen wrote:
> On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
> > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >
> > Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
> > interrupts instead of polling on all capable TPMs. Unfortunately, on so=
me
> > products the interrupt line is either never asserted or never deasserte=
d.
> >
> > The former causes interrupt timeouts and is detected by
> > tpm_tis_core_init(). The latter results in interrupt storms.
> >
> > Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkP=
ad
> > L490 and Inspur NF5180M6:
> >
> > https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel=
@redhat.com/
> > https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa=
3a78af5a6.camel@kernel.org/
> >
> > The current approach to avoid those storms is to disable interrupts by
> > adding a DMI quirk for the concerned device.
> >
> > However this is a maintenance burden in the long run, so use a generic
> > approach:
>
> I'm trying to comprehend how you evaluate, how big maintenance burden
> this would be. Adding even a few dozen table entries is not a
> maintenance burden.
>
> On the other hand any new functionality is objectively a maintanance
> burden of some measure (applies to any functionality). So how do we know
> that taking this change is less of a maintenance burden than just add
> new table entries, as they come up?

I feel also a bit resistant because leaf driver framework is really
a wrong location in the kernel tree for IRQ storm detection.

It would be better to have it signaled above the TPM driver, and the
driver would then just act on it.

BR, Jarkko
