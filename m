Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C6250E27E
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Apr 2022 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiDYN7t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbiDYN7c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 09:59:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43E2558D;
        Mon, 25 Apr 2022 06:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0B90B817FE;
        Mon, 25 Apr 2022 13:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CB5C385A4;
        Mon, 25 Apr 2022 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650894984;
        bh=FcggaBLYFmXfUnvykIxa7coqHlNFLqYXIU23AZ10GS0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i2urg+wuXKOIDbr6jA8I/Vc6yvbVb9q+0K7i2IxvGvotnr6GXDLM3KVy01DEja/M/
         ht0o/qSQgGj9BnhIEL9CkJIsD1TKUV7x9PEjO+yof3utdL6HOTadKkVK01vK5mLPDg
         F+sikVp5E7APi7P2LZu66ACq4Oz8+5ohHaRlfVmfEsr7vjbqy9ezxKS87lQbuXyUy8
         r5IjxAoXNSAds7J4k6RBnDeKi96wvGNA8NQI4GA3aspp3bwas8UNGTWEME/TuyURZa
         uN24tmOSiU1e3kxGw463gjrANev4rTI/AK0eWyTxHSl2iFVwlG+VHVWUdP1i9Okqo+
         7CD+MwapbZkwA==
Message-ID: <8ed6cf56ddd8e75a26cc8ea56be36dc54356f02d.camel@kernel.org>
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        stefanb@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org, Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Date:   Mon, 25 Apr 2022 16:57:51 +0300
In-Reply-To: <77374443-dc9b-5d1d-c652-0d093b6029f4@gmx.de>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
         <20210501135727.17747-3-LinoSanfilippo@gmx.de>
         <YJAby8mmiJ74qWAh@kernel.org> <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de>
         <YJNKs8bUMGOzFre+@kernel.org>
         <2a1a1cf61732eff1608aeae74054a0c135c1671f.camel@mniewoehner.de>
         <Yj0lhqTP1RoedxSc@iki.fi>
         <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
         <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
         <c8c0c5fb614d8b2de2a5faee2ef5ff3214281064.camel@kernel.org>
         <77374443-dc9b-5d1d-c652-0d093b6029f4@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2022-04-24 at 04:22 +0200, Lino Sanfilippo wrote:
>=20
> Hi,
>=20
> On 20.04.22 at 07:30, Jarkko Sakkinen wrote:
> > n Sat, 2022-03-26 at 04:24 +0100, Lino Sanfilippo wrote:
> > >=20
> > > Hi Michael,
> > >=20
> > > On 25.03.22 at 13:32, Michael Niew=C3=B6hner wrote:
> > > > > >=20
> > > > > > Lino, I'd be happy to test the patches, when you have time and =
interest to
> > > > > > work
> > > > > > on this again!
> > > > > >=20
> > > > > > Thanks, Michael
> > > > >=20
> > > > > It's quite easy to test them out. Both fixes are in the mainline =
GIT tree.
> > > > > E.g. give a shot rc1, and please report if any issues persists to=
:
> > > > >=20
> > > > > =C2=A0 linux-integrity@vger.kernel.org=C2=A0
> > > > >=20
> > > > > BR, Jarkko
> > > >=20
> > > > I don't see Linos patches on mainline. Also, the series included fo=
ur patches:
> > > > [PATCH v3 0/4] Fixes for TPM interrupt handling
> > > > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > > > [PATCH v3 2/4] tpm: Simplify locality handling
> > > > [PATCH v3 3/4] tpm: Fix test for interrupts
> > > > [PATCH v3 4/4] tpm: Only enable supported irqs
> > > >=20
> > > > Three of them are relevant for the interrupt problem, which is stil=
l present in
> > > > mainline, as these patches were refused:
> > > > [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> > > > [PATCH v3 2/4] tpm: Simplify locality handling
> > > > [PATCH v3 3/4] tpm: Fix test for interrupts
> > > >=20
> > > > Michael
> > > >=20
> > >=20
> > > You are right, the interrupts are still not working in the mainline k=
ernel.
> > > I would gladly make another attempt to fix this but rather step by st=
ep
> > > than in a series that tries to fix (different) things at once.
> > >=20
> > > A first step could be to have a sleepable context for the interrupt h=
andling,
> > > since in case of SPI the accesses to the irq status register may slee=
p.
> > >=20
> > > I sent a patch for this purpose once, but it seems to have gone lost:
> > >=20
> > > https://lore.kernel.org/all/20210620023444.14684-1-LinoSanfilippo@gmx=
.de/
> > >=20
> > >=20
> > > Best regards,
> > > Lino
> >=20
> > I went these through one by one>
> > # Above linked patch
> >=20
> > Boolean parameters are considered bad. I.e. use named flags
> > instead. This is for above linked patch.
>=20
> Ok, we could extend tpm_tis_flags by a flag "TPM_TIS_USE_THREADED_IRQ"
> for this.
>=20
> >=20
> > # [PATCH v3 3/4] tpm: Fix test for interrupts
> >=20
> > 1. Please remove "unnecessarily complicated" sentence because
> > =C2=A0=C2=A0 it cannot be evaluated. It's your opinion, which might per=
haps
> > =C2=A0=C2=A0 be correct, but it is irrelevant for any possible patch
> > =C2=A0=C2=A0 description.
> > 2. There's no such thing as "fix by re-implementation". Please
> > =C2=A0=C2=A0 explain instead code change is relevant for the bug fix.
> > 3. If set_bit() et al necessarily to fix a possible race condition
> > =C2=A0=C2=A0 you need to have a separate patch for that.
> >=20
> > To move forward, start with a better summary such as
> >=20
> > "tpm: move interrupt test to tpm_tis_probe_irq_single()"
> >=20
> > I'd also either revert the change for flags, or alternatively
> > move it to separate patch explaining race condition. Otherwise,
> > there's no argument of saying that using set_bit() is more
> > proper. This will make the change more localized.
> >=20
>=20
> Ok, I will split the fix for the irq test into two patches then.
>=20
> >=20
> > # [PATCH v3 2/4] tpm: Simplify locality handling
> >=20
> > "As a side-effect these modifications fix a bug which results in the
> > following warning when using TPM 2:"
> >=20
> > Generally speaking, the simplifications should be done on top of code
> > that does not have known bugs, even if the simplification renders out
> > the bug. This is because then we have code that have potentially unknow=
n
> > unknown bugs.
> >=20
> > I hope you see my point. The problem with these patches were then
> > and is still that they intermix bug fixes and other modifications and
> > thus cannot be taken in.
> >=20
>=20
> Yes, I can see that point.
>=20
> > BR, Jarkko
> >=20
>=20
> Thanks a lot for the review. I will prepare new patches with the suggeste=
d
> changes.

Yeah, I mean the point being: it's OK to suggest clean ups but with bug fix=
es
you should aim for the lowest common denominator as far as you possibly can=
.

BR, Jarkko

