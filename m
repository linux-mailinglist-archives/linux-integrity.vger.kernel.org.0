Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7AC728FCA
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 08:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjFIGUL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 02:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbjFIGUJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 02:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8101F30D7;
        Thu,  8 Jun 2023 23:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D434B652FC;
        Fri,  9 Jun 2023 06:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF383C433D2;
        Fri,  9 Jun 2023 06:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686291606;
        bh=OyHEyL0l02vl6b3PdzfyNfv96SWGjIxdDxN1JhqYKMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=js4DiRFHSuOLfoYopN7jltodknsqQOVpGVonhJ/MzQS4UP2h3ltg4YtWHTVZDjLVo
         +vNgdHNVgQO0LsKwvbD0B+IOWX1T1hgtY6ptCBSyX8tnJ8lgKR+qqyPl8B7Qfc8y+W
         sslAkHph568fPQZX+HJXicHLBP2FuQTx4SpN5wAubFtIaJunlBckMEjkmlh5Mguc1F
         MRY2/I3m4iK7wfYPVfxQiQvrnqTCHJNup7+Z75Rif2/KoqUkQXy6YBeHn/8M89doW7
         5YBh1xq5bbuihpZKjDADxtCx7I5ljTIK9c9m5y2XkP+Ms8Ej7IU5/s0XzpN/3MSSlz
         fP/yjYizHC5ow==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 09:20:01 +0300
Message-Id: <CT7WHF8KFNTD.22QJUBTRFIVLS@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Chris Packham" <Chris.Packham@alliedtelesis.co.nz>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        "Sasha Levin" <sashal@kernel.org>,
        "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
X-Mailer: aerc 0.14.0
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <7bb470fa70ff5944b7b9b82ac17d759819bccdf2.camel@kernel.org>
 <0bdf509f-f71a-e3b2-b9fb-4a726021219b@alliedtelesis.co.nz>
 <CT6JW4528UBU.1K3QJTVUN25OR@suppilovahvero>
 <CT7DAF9JJ4KD.37K8GDWP7GKG1@suppilovahvero>
 <1a168fef-8d9f-a700-2472-a60da508aeac@alliedtelesis.co.nz>
In-Reply-To: <1a168fef-8d9f-a700-2472-a60da508aeac@alliedtelesis.co.nz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 8, 2023 at 11:39 PM EEST, Chris Packham wrote:
> Hi Jarkko,
>
> On 9/06/23 03:17, Jarkko Sakkinen wrote:
> > On Wed Jun 7, 2023 at 7:15 PM EEST, Jarkko Sakkinen wrote:
> >> On Wed Jun 7, 2023 at 12:04 AM EEST, Chris Packham wrote:
> >>> Hi Jarkko,
> >>>
> >>> On 6/06/23 21:39, Jarkko Sakkinen wrote:
> >>>> On Sun, 2023-05-28 at 23:42 +0000, Chris Packham wrote:
> >>>>> Hi,
> >>>>>
> >>>>> We have an embedded product with an Infineon SLM9670 TPM. After upd=
ating
> >>>>> to a newer LTS kernel version we started seeing the following warni=
ng at
> >>>>> boot.
> >>>>>
> >>>>> [=C2=A0=C2=A0=C2=A0 4.741025] ------------[ cut here ]------------
> >>>>> [=C2=A0=C2=A0=C2=A0 4.749894] irq 38 handler tis_int_handler+0x0/0x=
154 enabled interrupts
> >>>>> [=C2=A0=C2=A0=C2=A0 4.756555] WARNING: CPU: 0 PID: 0 at kernel/irq/=
handle.c:159
> >>>>> __handle_irq_event_percpu+0xf4/0x180
> >>>>> [=C2=A0=C2=A0=C2=A0 4.765557] Modules linked in:
> >>>>> [=C2=A0=C2=A0=C2=A0 4.768626] CPU: 0 PID: 0 Comm: swapper/0 Not tai=
nted 5.15.113 #1
> >>>>> [=C2=A0=C2=A0=C2=A0 4.774747] Hardware name: Allied Telesis x250-18=
XS (DT)
> >>>>> [=C2=A0=C2=A0=C2=A0 4.780080] pstate: 60000005 (nZCv daif -PAN -UAO=
 -TCO -DIT -SSBS
> >>>>> BTYPE=3D--)
> >>>>> [=C2=A0=C2=A0=C2=A0 4.787072] pc : __handle_irq_event_percpu+0xf4/0=
x180
> >>>>> [=C2=A0=C2=A0=C2=A0 4.792146] lr : __handle_irq_event_percpu+0xf4/0=
x180
> >>>>> [=C2=A0=C2=A0=C2=A0 4.797220] sp : ffff800008003e40
> >>>>> [=C2=A0=C2=A0=C2=A0 4.800547] x29: ffff800008003e40 x28: ffff800009=
3951c0 x27:
> >>>>> ffff80000902a9b8
> >>>>> [=C2=A0=C2=A0=C2=A0 4.807716] x26: ffff800008fe8d28 x25: ffff800009=
4a62bd x24:
> >>>>> ffff000001b92400
> >>>>> [=C2=A0=C2=A0=C2=A0 4.814885] x23: 0000000000000026 x22: ffff800008=
003ec4 x21:
> >>>>> 0000000000000000
> >>>>> [=C2=A0=C2=A0=C2=A0 4.822053] x20: 0000000000000001 x19: ffff000002=
381200 x18:
> >>>>> ffffffffffffffff
> >>>>> [=C2=A0=C2=A0=C2=A0 4.829222] x17: ffff800076962000 x16: ffff800008=
000000 x15:
> >>>>> ffff800088003b57
> >>>>> [=C2=A0=C2=A0=C2=A0 4.836390] x14: 0000000000000000 x13: ffff800009=
3a5078 x12:
> >>>>> 000000000000035d
> >>>>> [=C2=A0=C2=A0=C2=A0 4.843558] x11: 000000000000011f x10: ffff800009=
3a5078 x9 :
> >>>>> ffff8000093a5078
> >>>>> [=C2=A0=C2=A0=C2=A0 4.850727] x8 : 00000000ffffefff x7 : ffff800009=
3fd078 x6 :
> >>>>> ffff8000093fd078
> >>>>> [=C2=A0=C2=A0=C2=A0 4.857895] x5 : 000000000000bff4 x4 : 0000000000=
000000 x3 :
> >>>>> 0000000000000000
> >>>>> [=C2=A0=C2=A0=C2=A0 4.865062] x2 : 0000000000000000 x1 : 0000000000=
000000 x0 :
> >>>>> ffff8000093951c0
> >>>>> [=C2=A0=C2=A0=C2=A0 4.872230] Call trace:
> >>>>> [=C2=A0=C2=A0=C2=A0 4.874686]=C2=A0 __handle_irq_event_percpu+0xf4/=
0x180
> >>>>> [=C2=A0=C2=A0=C2=A0 4.879411]=C2=A0 handle_irq_event+0x64/0xec
> >>>>> [=C2=A0=C2=A0=C2=A0 4.883264]=C2=A0 handle_level_irq+0xc0/0x1b0
> >>>>> [=C2=A0=C2=A0=C2=A0 4.887202]=C2=A0 generic_handle_irq+0x30/0x50
> >>>>> [=C2=A0=C2=A0=C2=A0 4.891229]=C2=A0 mvebu_gpio_irq_handler+0x11c/0x=
2a0
> >>>>> [=C2=A0=C2=A0=C2=A0 4.895780]=C2=A0 handle_domain_irq+0x60/0x90
> >>>>> [=C2=A0=C2=A0=C2=A0 4.899720]=C2=A0 gic_handle_irq+0x4c/0xd0
> >>>>> [=C2=A0=C2=A0=C2=A0 4.903398]=C2=A0 call_on_irq_stack+0x20/0x4c
> >>>>> [=C2=A0=C2=A0=C2=A0 4.907338]=C2=A0 do_interrupt_handler+0x54/0x60
> >>>>> [=C2=A0=C2=A0=C2=A0 4.911538]=C2=A0 el1_interrupt+0x30/0x80
> >>>>> [=C2=A0=C2=A0=C2=A0 4.915130]=C2=A0 el1h_64_irq_handler+0x18/0x24
> >>>>> [=C2=A0=C2=A0=C2=A0 4.919244]=C2=A0 el1h_64_irq+0x78/0x7c
> >>>>> [=C2=A0=C2=A0=C2=A0 4.922659]=C2=A0 arch_cpu_idle+0x18/0x2c
> >>>>> [=C2=A0=C2=A0=C2=A0 4.926249]=C2=A0 do_idle+0xc4/0x150
> >>>>> [=C2=A0=C2=A0=C2=A0 4.929404]=C2=A0 cpu_startup_entry+0x28/0x60
> >>>>> [=C2=A0=C2=A0=C2=A0 4.933343]=C2=A0 rest_init+0xe4/0xf4
> >>>>> [=C2=A0=C2=A0=C2=A0 4.936584]=C2=A0 arch_call_rest_init+0x10/0x1c
> >>>>> [=C2=A0=C2=A0=C2=A0 4.940699]=C2=A0 start_kernel+0x600/0x640
> >>>>> [=C2=A0=C2=A0=C2=A0 4.944375]=C2=A0 __primary_switched+0xbc/0xc4
> >>>>> [=C2=A0=C2=A0=C2=A0 4.948402] ---[ end trace 940193047b35b311 ]---
> >>>>>
> >>>>> Initially I dismissed this as a warning that would probably be clea=
ned
> >>>>> up when we did more work on the TPM support for our product but we =
also
> >>>>> seem to be getting some new i2c issues and possibly a kernel stack
> >>>>> corruption that we've conflated with this TPM warning.
> >>>> Hi, sorry for late response. I've been moving my (home) office to
> >>>> a different location during last couple of weeks, and email has been
> >>>> piling up.
> >>>>
> >>>> What does dmidecode give you?
> >>>>
> >>>> More specific, I'm interested on DMI type 43:
> >>>>
> >>>> $ sudo dmidecode -t 43
> >>>> # dmidecode 3.4
> >>>> Getting SMBIOS data from sysfs.
> >>>> SMBIOS 3.4.0 present.
> >>>>
> >>>> Handle 0x004D, DMI type 43, 31 bytes
> >>>> TPM Device
> >>>> 	Vendor ID: INTC
> >>>> 	Specification Version: 2.0
> >>>> 	Firmware Revision: 600.18
> >>>> 	Description: INTEL
> >>>> 	Characteristics:
> >>>> 		Family configurable via platform software support
> >>>> 	OEM-specific Information: 0x00000000
> >>>>
> >>>> BR, Jarkko
> >>> This is an embedded ARM64 (Marvell CN9130 SoC) device so no BIOS. The
> >>> relevant snippet from the device tree is
> >>>
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm@1 {
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "infineon,slb9670";
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <1>; /* Chip select 1 */
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&cp0_gpio2>;
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <30 IRQ_TYPE_LEVEL_LOW>;
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 spi-max-frequency =3D <31250000>;
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>
> >>> and I can tell you that the specific TPM chip is an Infinieon
> >>> SLM9670AQ20FW1311XTMA1
> >> OK, you know what I own that chip in the form of LetsTrustTPM
> >> product.
> >>
> >> I have not used it a lot because of lack of time but I could try
> >> to reproduce the bug with that and RPi 3B, or at least see what
> >> happens with different hardware platform with the same TPM chip.
> > I'm not device tree expert but with my limited knowledge, I guess kwe
> > could add a quirk that uses of_machine_is_compatible(), to disable
> > IRQ's, i.e. base the policy on specific boards rather than specific
> > chips: [*]
> >
> > 	if (of_machine_is_compatible("marvell,cn9130")) {
> > 		dev_notice(dev, "disable interrupts");
> > 		interrupts =3D 0;=09
> > 	}
> >
> > [*] I looked up arch/arm64/boot/dts/marvell/cn9130.dtsi. I hope I picke=
d
> > the correct file.
>
> The warning itself was resolved by bringing in a further change for the=
=20
> LTS branch[1]. There does still seem to be an issue with the interrupts=
=20
> actually working (same behaviour on mainline) but at least now there is=
=20
> no warning and no adverse downstream effects.
>
> In terms of device tree stuff to disable the interrupt I could simply=20
> remove the interrupt properties from the board DTS (I was doing this as=
=20
> a workaround before the correct fix was identified).

I think it would be a good call because if a product creator *wants*
interrupts they will know it. Thus, it is perfectly fine IMHO to
disable them in the  board DTS. I.e. very different case from
PC/workstation computing.

BR, Jarkko
