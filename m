Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28436724945
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjFFQgC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjFFQgC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 12:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4816010F0;
        Tue,  6 Jun 2023 09:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C7962EBA;
        Tue,  6 Jun 2023 16:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE57AC433D2;
        Tue,  6 Jun 2023 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686069357;
        bh=UiUeBltjJqUnA4y3M9itPA6HsvIdpRts5NmmQokGATE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=dCY05hHixhZdAExvh1G0YsHT3PMeEKX6gJtslAafeBH1A3ZfzH80+hevDsIQeWQ1A
         hZX6zdDoQ/3Qr+eN5Mmh7OceoMrzuWR/tPcUv0BotAh8cPhvifts9rmRsyGbucAfn9
         UrnKHewcSb8kMbc4jbIDnpshao29dnxTVkcMv/cbNc3hy5S6ke0UFxq6RBiJxtDlvv
         +BLfoi8WWIrUQ8p4VtqwW4I5OdROAiGuRVHPSicfaDVVSh6dJhzGbBqsQpqpXSpbVO
         zuLCVZ/621xCZMmmmRkv5LyWaLdzB/rm9RaNRy14xh6txoiZPhIRtdSWoBIDJFMF1/
         GkmYm3KSuOy8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:35:51 +0300
Message-Id: <CT5PPAX7Z73M.14969LB3CRYXC@suppilovahvero>
Cc:     "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <hdegoede@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <peterz@infradead.org>, <linux@mniewoehner.de>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
 <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
 <xkp3zaclvqx6pv4qh4wv7jttqby4lp2atsrareb63ofi7sy2qp@hfugy3pyac4o>
In-Reply-To: <xkp3zaclvqx6pv4qh4wv7jttqby4lp2atsrareb63ofi7sy2qp@hfugy3pyac4o>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 30, 2023 at 8:56 PM EEST, Jerry Snitselaar wrote:
> On Mon, May 29, 2023 at 09:46:08AM +0300, P=C3=A9ter Ujfalusi wrote:
> > Hi Lino,
> >=20
> > On 23/05/2023 23:46, Lino Sanfilippo wrote:
> > >> On the other hand any new functionality is objectively a maintanance
> > >> burden of some measure (applies to any functionality). So how do we =
know
> > >> that taking this change is less of a maintenance burden than just ad=
d
> > >> new table entries, as they come up?
> > >>
> > >=20
> > > Initially this set was created as a response to this 0-day bug report=
 which you asked me
> > > to have a look at:
> > >=20
> > > https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062c=
fa3a78af5a6.camel@kernel.org/
> > >=20
> > > My hope was that it could also avoid some of (existing or future) DMI=
 entries. But even if it does not
> > > (e.g. the problem P=C3=A9ter Ujfalusi reported with the UPX-i11 canno=
t be fixed by this patch set and thus
> > > needs the DMI quirk) we may at least avoid more bug reports due to in=
terrupt storms once
> > > 6.4 is released.=20
> >=20
> > I'm surprised that there is a need for a storm detection in the first
> > place... Do we have something else on the same IRQ line on the affected
> > devices which might have a bug or no driver at all?
> > It is hard to believe that a TPM (Trusted Platform Module) is integrate=
d
> > so poorly ;)
> >=20
> > But put that aside: I think the storm detection is good given that ther=
e
> > is no other way to know which machine have sloppy TPM integration.
> > There are machines where this happens, so it is a know integration
> > issue, right?
> >=20
> > My only 'nitpick' is with the printk level to be used.
> > The ERR level is not correct as we know the issue and we handle it, so
> > all is under control.
> > If we want to add these machines to the quirk list then WARN is a good
> > level to gain attention but I'm not sure if a user will know how to get
> > the machine in the quirk (where to file a bug).
> > If we only want the quirk to be used for machines like UPX-i11 which
> > simply just have broken (likely floating) IRQ line then the WARN is too
> > high level, INFO or even DBG would be appropriate as you are not going
> > to update the quirk, it is just handled under the hood (which is a grea=
t
> > thing, but on the other hand you will have the storm never the less and
> > that is not a nice thing).
> >=20
> > It is a matter on how this is going to be handled in a long term. Add
> > quirk for all the known machines with either stormy or plain broken IRQ
> > line or handle the stormy ones and quirk the broken ones only.
> >=20
> > >>> Detect an interrupt storm by counting the number of unhandled inter=
rupts
> > >>> within a 10 ms time interval. In case that more than 1000 were unha=
ndled
> > >>> deactivate interrupts, deregister the handler and fall back to poll=
ing.
> > >>
> > >> I know it can be sometimes hard to evaluate but can you try to expla=
in
> > >> how you came up to the 10 ms sampling period and 1000 interrupt
> > >> threshold? I just don't like abritrary numbers.
> > >=20
> > > At least the 100 ms is not plucked out of thin air but its the same t=
ime period
> > > that the generic code in note_interrupt() uses - I assume for a good =
reason.
> > > Not only this number but the whole irq storm detection logic is taken=
 from=20
> > > there:=20
> > >=20
> > >>
> > >>> This equals the implementation that handles interrupt storms in
> > >>> note_interrupt() by means of timestamps and counters in struct irq_=
desc.
> > >> The number of 1000 unhandled interrupts is still far below the 99900
> > used in
> > > note_interrupt() but IMHO enough to indicate that there is something =
seriously
> > > wrong with interrupt processing and it is probably saver to fall back=
 to polling.
> >=20
> > Except that if the line got the spurious designation in core, the
> > interrupt line will be disabled while the TPM driver will think that it
> > is still using IRQ mode and will not switch to polling.
> >=20
> > A storm of 1000 is better than a storm of 99900 for sure but quirking
> > these would be the desired final solution. imho
>
> If that is the case, then output could probably be sent to the console
> detailing the dmi info needed to update the table.

+1

Good idea.

BR, Jarkko
