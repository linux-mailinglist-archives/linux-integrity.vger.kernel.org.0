Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A327234E8
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFFCAJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 22:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjFFCAJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 22:00:09 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E028ED;
        Mon,  5 Jun 2023 19:00:07 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33b3fa03738so26709575ab.1;
        Mon, 05 Jun 2023 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686016807; x=1688608807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buSjiCTAYMu1VMj/taG1SQiIiNFmwa/mLZSh9IabKTI=;
        b=nZYeYOXbSndNmToj71NLbEkueeLvBTg+cxhX1LrbYWy7CI+k3mZ0DIK3GJCn6+RXMT
         hrttjwRNVQG2+Xp75ydUzGrhc8unJ3vgmhKaANP0buce8i3LFV1wJVeIfVfsIXDPeqs/
         7RKRpPWiWJYqn3+rWGfORNk0TJlBlg6HIW+ZgH5Rf3bUe5bwV0InfHcuyR1IjV8on1H9
         oWAb7iIuzZskORs4ozoVBR0QyNAUvmdctAazG48EmpLdZvltZMZ8JZ4yLYdZyJlRU2+B
         XZZ8ZFQ7MA9/+a7Xma660N9ScUMQcX4PbTWXeCsEnWX3LN2+jZTqeXtjXo6BaiW/eUsX
         UxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686016807; x=1688608807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buSjiCTAYMu1VMj/taG1SQiIiNFmwa/mLZSh9IabKTI=;
        b=UaP/WP0Hwz8KVq0J660uImA0YM30ZyLB3HpxuDFF03XL6A2HEEOeJ/53ntbQ89nvh1
         YKXgGYyqS4/asgtU5GEb69IpbYKphLvsd/9jIYltFBf1WBH86b9OMiSAFowL+ExO7BAR
         TCydEEo6S+LgFm/107XoH3PrW0z67BMmfeIxPGd2TDjp8lUKATR0fzyaqa4qofTjfieW
         Xd98RHKolT0L9GwRY0Ho58UKw803BonuDSjM8VxuTbty3+BOUG/QXAi49Tp4L5GKdzI/
         9yecL2ZMVaNb/oFj8/iVb/azhW22q4iDqPezPZ8ANx9wEkrJR+gM8sfBdnwuqgMe7gHz
         jWHA==
X-Gm-Message-State: AC+VfDyTyV/OlWhUAKEoDNpTwXGEKd9b3Sja5rRdQZkrY2oQLGm9R/Ru
        hgOWA6jvF7kt25mY/Ddua0g=
X-Google-Smtp-Source: ACHHUZ6HpjBXN77Wl2V0CL0HXxBJE6gN8QW0/beR1dgCj3Q6GilLf8tVmlWavSvbQ/Gc2+SReQMirQ==
X-Received: by 2002:a92:d350:0:b0:328:8770:b9c2 with SMTP id a16-20020a92d350000000b003288770b9c2mr1051226ilh.14.1686016806863;
        Mon, 05 Jun 2023 19:00:06 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-36.three.co.id. [116.206.28.36])
        by smtp.gmail.com with ESMTPSA id a10-20020a62bd0a000000b0063b86aff031sm5749842pff.108.2023.06.05.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:00:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ADE5A1069AF; Tue,  6 Jun 2023 09:00:02 +0700 (WIB)
Date:   Tue, 6 Jun 2023 09:00:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Message-ID: <ZH6TIjXeXJVMvSKa@debian.me>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1I+UJ79Ezq1Yhtal"
Content-Disposition: inline
In-Reply-To: <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--1I+UJ79Ezq1Yhtal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 01:41:01AM +0000, Chris Packham wrote:
>=20
> On 2/06/23 16:19, Chris Packham wrote:
> >
> > On 2/06/23 16:10, Bagas Sanjaya wrote:
> >> On 5/29/23 09:37, Chris Packham wrote:
> >>> On 29/05/23 14:04, Bagas Sanjaya wrote:
> >>>> On Sun, May 28, 2023 at 11:42:50PM +0000, Chris Packham wrote:
> >>>>> Hi,
> >>>>>
> >>>>> We have an embedded product with an Infineon SLM9670 TPM. After=20
> >>>>> updating
> >>>>> to a newer LTS kernel version we started seeing the following=20
> >>>>> warning at
> >>>>> boot.
> >>>>>
> >>>>> [=C2=A0=C2=A0=C2=A0 4.741025] ------------[ cut here ]------------
> >>>>> [=C2=A0=C2=A0=C2=A0 4.749894] irq 38 handler tis_int_handler+0x0/0x=
154 enabled=20
> >>>>> interrupts
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
> >>>>> Initially I dismissed this as a warning that would probably be=20
> >>>>> cleaned
> >>>>> up when we did more work on the TPM support for our product but we=
=20
> >>>>> also
> >>>>> seem to be getting some new i2c issues and possibly a kernel stack
> >>>>> corruption that we've conflated with this TPM warning.
> >>>> Can you reproduce this issue on mainline? Can you also bisect to find
> >>>> the culprit?
> >>> No the error doesn't appear on a recent mainline kernel. I do still g=
et
> >>>
> >>> tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> >>> tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
> >>> tpm tpm0: A TPM error (256) occurred attempting the self test
> >>>
> >>> but I think I was getting that on v5.15.110
> >>>
> >> I repeat: Can you bisect between v5.15 and v5.15.112?
> >
> > It's definitely between v5.15.110 and v5.15.112.
> >
> > I'll do a proper bisect next week but I'm pretty sure it's related to=
=20
> > the "tpm, tpm_tis:" series. The problem can be worked around by=20
> > removing the TPM interrupt from the device tree for the board.
>=20
> Bisecting between v5.15.110 and v5.15.112 points to
>=20
> 51162b05a44cb5d98fb0ae2519a860910a47fd4b is the first bad commit

Thanks for the bisection.

Lino, it looks like this regression is caused by (backported) commit of you=
rs.
Would you like to take a look on it?

Anyway, telling regzbot:

#regzbot introduced: 51162b05a44cb5

--=20
An old man doll... just what I always wanted! - Clara

--1I+UJ79Ezq1Yhtal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH6THgAKCRD2uYlJVVFO
o6M8AQC/AQl5Qg8MqMLvvmXd1ofCPvdrOv/MKTCm6CYi82fT0gD/fzETeBUkqb7c
0tWduZktxuZReEFeucMiOOR4CsyBqAc=
=GEY/
-----END PGP SIGNATURE-----

--1I+UJ79Ezq1Yhtal--
