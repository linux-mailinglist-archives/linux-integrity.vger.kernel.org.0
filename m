Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF270E526
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 21:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEWTNI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjEWTNH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 15:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA1119;
        Tue, 23 May 2023 12:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148E161D46;
        Tue, 23 May 2023 19:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734AFC433D2;
        Tue, 23 May 2023 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684869174;
        bh=e2+88Fpdes7sDNr1lFo4AJXADvwOPDkDtwtQu+Fn7KI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=b2QDMZT75fspvpIHJtMwx9QUeWemKM9oXLhFLuLu1clAf4QyCX3qnBEKSPNynYSkm
         Qr1B67ra1/wIb7+VxQpSPCHwkBD36PQ0cohLrYjUKdI/4CMh7W7RHnJh/egaFhJd8Z
         4RHyIsIzuLStIRJC4yK/26NewusGaRaIO+ZTR9LoU24VEoiKhfW5PMjg6DqklUls49
         5GK1fDtWjST3rRfTPbI13po7WIPuncvE/I5dy0oNVhqe89gwRITeNtt5aCHJMfUVDJ
         0qyoXbed7BFafxuZk5FARJ2xN8wZIMiiK5lylPCpdTcorusPpk7Bq8pY/7g+txatVb
         3TAc3gJrnO9PQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 May 2023 22:12:49 +0300
Message-Id: <CSTW9UX4ERDZ.VBD1QIWLBM75@suppilovahvero>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
>
> > Detect an interrupt storm by counting the number of unhandled interrupt=
s
> > within a 10 ms time interval. In case that more than 1000 were unhandle=
d
> > deactivate interrupts, deregister the handler and fall back to polling.
>
> I know it can be sometimes hard to evaluate but can you try to explain
> how you came up to the 10 ms sampling period and 1000 interrupt
> threshold? I just don't like abritrary numbers.

Also here I wonder how you came up with this computational model. This
is not same as saying it is wrong. There's just whole stack of options.

Out of top of my head you could e.g. window average the duration between
IRQs. When the average goes beyond threshold, then you shutdown
interrupts.

The pro I would see in this that it is much easier intuitively discuss
how much there should be time in-between interrupts that the kernel
handles it, than how many IRQs you can stack into time interval, which
blows my head tbh.

BR, Jarkko
