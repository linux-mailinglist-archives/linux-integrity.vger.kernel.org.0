Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C437A50809A
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 07:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359407AbiDTFeO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiDTFeL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 01:34:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005736B6A;
        Tue, 19 Apr 2022 22:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 651ABB81D04;
        Wed, 20 Apr 2022 05:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2778C385A0;
        Wed, 20 Apr 2022 05:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650432683;
        bh=0tICag3wjBLWnC1CErQHOddo7JavOzZDqZo5vBzXRBk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LmJJaYzWw54mjurtZaBe3quCZMs1vYxJT0gXxwltWSk70Opmas18De47WEYSGr6MP
         ii2iXsg2MqMG8K7r42pPtA7w+4nKYhaTdOyLDpY8gjXqQgZMe+xNY+NuTnF5ZiFAmL
         VNRY7cbOz6PN52SHnTC7s5HCTS/cB++rxoTJ6qpX3cFHR9zyAYUqCrTaYgZnidlIU7
         HPSb7vVA4hkFJN65/Lyjc7Ka40LFyj3aDD/oU07GMvd4dTzhZvGbr//DjqzEgXieyC
         t4UsxI7/nd+gf8dBWi9/4Pd9EYzVTiP7JNMLR7pZnmsVsKzj4wxKkXYd1RBDtWXN8K
         5rkuOmHoxzTqA==
Message-ID: <c8c0c5fb614d8b2de2a5faee2ef5ff3214281064.camel@kernel.org>
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        stefanb@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org
Date:   Wed, 20 Apr 2022 08:30:09 +0300
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
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

n Sat, 2022-03-26 at 04:24 +0100, Lino Sanfilippo wrote:
>=20
> Hi Michael,
>=20
> On 25.03.22 at 13:32, Michael Niew=C3=B6hner wrote:
> > > >=20
> > > > Lino, I'd be happy to test the patches, when you have time and inte=
rest to
> > > > work
> > > > on this again!
> > > >=20
> > > > Thanks, Michael
> > >=20
> > > It's quite easy to test them out. Both fixes are in the mainline GIT =
tree.
> > > E.g. give a shot rc1, and please report if any issues persists to:
> > >=20
> > > =C2=A0 linux-integrity@vger.kernel.org=C2=A0
> > >=20
> > > BR, Jarkko
> >=20
> > I don't see Linos patches on mainline. Also, the series included four p=
atches:
> > [PATCH v3 0/4] Fixes for TPM interrupt handling
> > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > [PATCH v3 2/4] tpm: Simplify locality handling
> > [PATCH v3 3/4] tpm: Fix test for interrupts
> > [PATCH v3 4/4] tpm: Only enable supported irqs
> >=20
> > Three of them are relevant for the interrupt problem, which is still pr=
esent in
> > mainline, as these patches were refused:
> > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > [PATCH v3 2/4] tpm: Simplify locality handling
> > [PATCH v3 3/4] tpm: Fix test for interrupts
> >=20
> > Michael
> >=20
>=20
> You are right, the interrupts are still not working in the mainline kerne=
l.
> I would gladly make another attempt to fix this but rather step by step
> than in a series that tries to fix (different) things at once.
>=20
> A first step could be to have a sleepable context for the interrupt handl=
ing,
> since in case of SPI the accesses to the irq status register may sleep.
>=20
> I sent a patch for this purpose once, but it seems to have gone lost:
>=20
> https://lore.kernel.org/all/20210620023444.14684-1-LinoSanfilippo@gmx.de/
>=20
>=20
> Best regards,
> Lino

I went these through one by one.

# Above linked patch=20

Boolean parameters are considered bad. I.e. use named flags
instead. This is for above linked patch.

# [PATCH v3 3/4] tpm: Fix test for interrupts

1. Please remove "unnecessarily complicated" sentence because
   it cannot be evaluated. It's your opinion, which might perhaps
   be correct, but it is irrelevant for any possible patch
   description.
2. There's no such thing as "fix by re-implementation". Please
   explain instead code change is relevant for the bug fix.
3. If set_bit() et al necessarily to fix a possible race condition
   you need to have a separate patch for that.

To move forward, start with a better summary such as

"tpm: move interrupt test to tpm_tis_probe_irq_single()"

I'd also either revert the change for flags, or alternatively
move it to separate patch explaining race condition. Otherwise,
there's no argument of saying that using set_bit() is more=20
proper. This will make the change more localized.


# [PATCH v3 2/4] tpm: Simplify locality handling

"As a side-effect these modifications fix a bug which results in the
following warning when using TPM 2:"

Generally speaking, the simplifications should be done on top of code
that does not have known bugs, even if the simplification renders out
the bug. This is because then we have code that have potentially unknown
unknown bugs.

I hope you see my point. The problem with these patches were then
and is still that they intermix bug fixes and other modifications and
thus cannot be taken in.

BR, Jarkko
