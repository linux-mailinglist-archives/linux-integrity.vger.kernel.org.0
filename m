Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BE52AAA9
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiEQSYz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiEQSYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 14:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B82496BB;
        Tue, 17 May 2022 11:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7866153B;
        Tue, 17 May 2022 18:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B5AC34117;
        Tue, 17 May 2022 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652811893;
        bh=5s7DT1idOs5YfZG4Es2EkVEczNIwYfYftJleVW6Ca24=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xz9rbHYUNn/Y1NPprhcdNc8fApOvghVXTjGOTYQIhrtyY5slzvzdIM+XkFKLhHFmk
         gbsksDQqMehKHTzifihHnwInOy7/E/C3JwFYAxf2EIz3QGMaFFLBdRoeo3iN3Vj74c
         3WgYBJy+g8ZCPQnAtoJ3dDfKU2xHlvRrli8Qb2McwRo5WHaNM7kB4ADZ3+ScZ35oua
         FdktsMiV9LMxDoHQDeeWQxZYbsto+V6/m/DlgEQ0akRbHwjmNBj5FIy/qsGuRlyQbe
         D4V98E0oDS3+xhKjAKTqka1he/xS5jP8Yia3SKlaNOuhPE5NteehW6+Bx8Ek4rowSq
         0jJSD0W3fNMgg==
Message-ID: <2d7e011ae604b3d6d952bed5f7ba08a090930fbe.camel@kernel.org>
Subject: Re: [PATCH v4 1/6] tpm, tpm_tis_spi: Request threaded irq
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date:   Tue, 17 May 2022 21:23:18 +0300
In-Reply-To: <1b306d56-c6b3-e51f-1d63-2f6725fa7557@gmx.de>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
         <20220509080559.4381-2-LinoSanfilippo@gmx.de> <YnucgDH3I87RI8PN@kernel.org>
         <486cec01-ec02-3f11-0b81-037e0700c503@gmx.de> <Yn6esMyUl+QhECq+@kernel.org>
         <1b306d56-c6b3-e51f-1d63-2f6725fa7557@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-05-16 at 21:52 +0200, Lino Sanfilippo wrote:
> Hi,
>=20
> On 13.05.22 at 20:08, Jarkko Sakkinen wrote:
> > On Wed, May 11, 2022 at 09:18:39PM +0200, Lino Sanfilippo wrote:
> > > Hi,
> > >=20
> > > On 11.05.22 at 13:22, Jarkko Sakkinen wrote:
> > > > On Mon, May 09, 2022 at 10:05:54AM +0200, Lino Sanfilippo wrote:
> > > > > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > > > >=20
> > > > > Interrupt handling at least includes reading and writing the inte=
rrupt
> > > > > status register within the interrupt routine. Since accesses over=
 the SPI
> > > > > bus are synchronized by a mutex, request a threaded interrupt han=
dler to
> > > > > ensure a sleepable context during interrupt processing.
> > > > >=20
> > > > > Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the d=
river")
> > > > > Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > > >=20
> > > > When you state that it needs a sleepable context, you should bring =
a
> > > > context why it needs it. This not to disregard the code change over=
ally but
> > > > you cannot make even the most obvious claim without backing data.
> > > >=20
> > >=20
> > > so what kind of backing data do you have in mind? Would it help to em=
phasize more
> > > that the irq handler is running in hard irq context in the current co=
de and thus
> > > must not access registers over SPI since SPI uses a mutex (I consider=
 it as basic
> > > knowledge that a mutex must not be taken in hard irq context)?
> >=20
> > There's zero mention about specific lock you are talking about. Providi=
ng
> > the basic knowledge what you are trying to do is the whole point of the
> > commit message in the first place. I'd presume this patch is related to=
 the
> > use bus_lock_mutex but it is fully ingored here.
> >=20
>=20
> Ok, understood. I will amend the commit message to make more clear that
> reading and writing registers from the interrupt handler results in
> a call to tpm_tis_spi_transfer() which uses the bus_lock_mutex of the
> spi device and thus requires a sleepable context.

Yeah, please be always as explicit as possible, so that it is impossible
to get it wrong. Then a reader of your patch saves time from seeking e.g.
the current name of the data structure. Just dumb things down as far as
you can.

Commit messages have a dual function:

1. They *lower* the barrier to look into a code change, which helps
the patches get any attention.
2. Proper commit messages save tons of time from the maintainer, when
you have revisit years old commits, e.g. when bisecting a bug.

Comparing to e.g. Github the key difference is this: in Github you have
commits and issues. In kernel commit is both issue and the commit bundled
together. Therefore, every commit also needs to have a "bug report"
included.

BR, Jarkko
