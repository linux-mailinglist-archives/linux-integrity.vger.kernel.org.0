Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12933723DEC
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 11:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFFJjv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFFJju (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 05:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8496E69;
        Tue,  6 Jun 2023 02:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D71362AAE;
        Tue,  6 Jun 2023 09:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48475C433EF;
        Tue,  6 Jun 2023 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686044387;
        bh=oiJVYfGoEpymuu4TrgDsflDLYDu8vRIKcXKj/GoJx1w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rW+9mI+onnugkSZ5uZhCBWB6Ei2A3ED3zAaav5F6vaNcHeFw0htVGJiF0uosBnqpy
         b78rKm3awtifh5eHcT7vdN85sHD4mF+kEJjw8nSksn6nmnetwZJf07Y+C+EyJ5y+1S
         nouagocmpg53GMuR0GZAuGymlSOSSUw+/L8j7UPDMGENA7nQrcK7V+1qTGRYpyQ9eU
         Vuz0oxpLMhPiER1jv8l4MO2GzLyKLW+QJbdY98Ob/MDAZkRoIkYDNAETwJhE12OgnK
         9hYJiIvVK7XrveC7guVRzGI9OUswSR1wwrjjiQr/J9h2kboJfmw+f24LyMP29MpMuI
         mcZk/czFA8dNA==
Message-ID: <7bb470fa70ff5944b7b9b82ac17d759819bccdf2.camel@kernel.org>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 06 Jun 2023 12:39:44 +0300
In-Reply-To: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2023-05-28 at 23:42 +0000, Chris Packham wrote:
> Hi,
>=20
> We have an embedded product with an Infineon SLM9670 TPM. After updating=
=20
> to a newer LTS kernel version we started seeing the following warning at=
=20
> boot.
>=20
> [=C2=A0=C2=A0=C2=A0 4.741025] ------------[ cut here ]------------
> [=C2=A0=C2=A0=C2=A0 4.749894] irq 38 handler tis_int_handler+0x0/0x154 en=
abled interrupts
> [=C2=A0=C2=A0=C2=A0 4.756555] WARNING: CPU: 0 PID: 0 at kernel/irq/handle=
.c:159=20
> __handle_irq_event_percpu+0xf4/0x180
> [=C2=A0=C2=A0=C2=A0 4.765557] Modules linked in:
> [=C2=A0=C2=A0=C2=A0 4.768626] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5=
.15.113 #1
> [=C2=A0=C2=A0=C2=A0 4.774747] Hardware name: Allied Telesis x250-18XS (DT=
)
> [=C2=A0=C2=A0=C2=A0 4.780080] pstate: 60000005 (nZCv daif -PAN -UAO -TCO =
-DIT -SSBS=20
> BTYPE=3D--)
> [=C2=A0=C2=A0=C2=A0 4.787072] pc : __handle_irq_event_percpu+0xf4/0x180
> [=C2=A0=C2=A0=C2=A0 4.792146] lr : __handle_irq_event_percpu+0xf4/0x180
> [=C2=A0=C2=A0=C2=A0 4.797220] sp : ffff800008003e40
> [=C2=A0=C2=A0=C2=A0 4.800547] x29: ffff800008003e40 x28: ffff8000093951c0=
 x27:=20
> ffff80000902a9b8
> [=C2=A0=C2=A0=C2=A0 4.807716] x26: ffff800008fe8d28 x25: ffff8000094a62bd=
 x24:=20
> ffff000001b92400
> [=C2=A0=C2=A0=C2=A0 4.814885] x23: 0000000000000026 x22: ffff800008003ec4=
 x21:=20
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 4.822053] x20: 0000000000000001 x19: ffff000002381200=
 x18:=20
> ffffffffffffffff
> [=C2=A0=C2=A0=C2=A0 4.829222] x17: ffff800076962000 x16: ffff800008000000=
 x15:=20
> ffff800088003b57
> [=C2=A0=C2=A0=C2=A0 4.836390] x14: 0000000000000000 x13: ffff8000093a5078=
 x12:=20
> 000000000000035d
> [=C2=A0=C2=A0=C2=A0 4.843558] x11: 000000000000011f x10: ffff8000093a5078=
 x9 :=20
> ffff8000093a5078
> [=C2=A0=C2=A0=C2=A0 4.850727] x8 : 00000000ffffefff x7 : ffff8000093fd078=
 x6 :=20
> ffff8000093fd078
> [=C2=A0=C2=A0=C2=A0 4.857895] x5 : 000000000000bff4 x4 : 0000000000000000=
 x3 :=20
> 0000000000000000
> [=C2=A0=C2=A0=C2=A0 4.865062] x2 : 0000000000000000 x1 : 0000000000000000=
 x0 :=20
> ffff8000093951c0
> [=C2=A0=C2=A0=C2=A0 4.872230] Call trace:
> [=C2=A0=C2=A0=C2=A0 4.874686]=C2=A0 __handle_irq_event_percpu+0xf4/0x180
> [=C2=A0=C2=A0=C2=A0 4.879411]=C2=A0 handle_irq_event+0x64/0xec
> [=C2=A0=C2=A0=C2=A0 4.883264]=C2=A0 handle_level_irq+0xc0/0x1b0
> [=C2=A0=C2=A0=C2=A0 4.887202]=C2=A0 generic_handle_irq+0x30/0x50
> [=C2=A0=C2=A0=C2=A0 4.891229]=C2=A0 mvebu_gpio_irq_handler+0x11c/0x2a0
> [=C2=A0=C2=A0=C2=A0 4.895780]=C2=A0 handle_domain_irq+0x60/0x90
> [=C2=A0=C2=A0=C2=A0 4.899720]=C2=A0 gic_handle_irq+0x4c/0xd0
> [=C2=A0=C2=A0=C2=A0 4.903398]=C2=A0 call_on_irq_stack+0x20/0x4c
> [=C2=A0=C2=A0=C2=A0 4.907338]=C2=A0 do_interrupt_handler+0x54/0x60
> [=C2=A0=C2=A0=C2=A0 4.911538]=C2=A0 el1_interrupt+0x30/0x80
> [=C2=A0=C2=A0=C2=A0 4.915130]=C2=A0 el1h_64_irq_handler+0x18/0x24
> [=C2=A0=C2=A0=C2=A0 4.919244]=C2=A0 el1h_64_irq+0x78/0x7c
> [=C2=A0=C2=A0=C2=A0 4.922659]=C2=A0 arch_cpu_idle+0x18/0x2c
> [=C2=A0=C2=A0=C2=A0 4.926249]=C2=A0 do_idle+0xc4/0x150
> [=C2=A0=C2=A0=C2=A0 4.929404]=C2=A0 cpu_startup_entry+0x28/0x60
> [=C2=A0=C2=A0=C2=A0 4.933343]=C2=A0 rest_init+0xe4/0xf4
> [=C2=A0=C2=A0=C2=A0 4.936584]=C2=A0 arch_call_rest_init+0x10/0x1c
> [=C2=A0=C2=A0=C2=A0 4.940699]=C2=A0 start_kernel+0x600/0x640
> [=C2=A0=C2=A0=C2=A0 4.944375]=C2=A0 __primary_switched+0xbc/0xc4
> [=C2=A0=C2=A0=C2=A0 4.948402] ---[ end trace 940193047b35b311 ]---
>=20
> Initially I dismissed this as a warning that would probably be cleaned=
=20
> up when we did more work on the TPM support for our product but we also=
=20
> seem to be getting some new i2c issues and possibly a kernel stack=20
> corruption that we've conflated with this TPM warning.

Hi, sorry for late response. I've been moving my (home) office to
a different location during last couple of weeks, and email has been
piling up.

What does dmidecode give you?

More specific, I'm interested on DMI type 43:

$ sudo dmidecode -t 43
# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.4.0 present.

Handle 0x004D, DMI type 43, 31 bytes
TPM Device
	Vendor ID: INTC
	Specification Version: 2.0
	Firmware Revision: 600.18
	Description: INTEL
	Characteristics:
		Family configurable via platform software support
	OEM-specific Information: 0x00000000

BR, Jarkko
