Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685C7141D6
	for <lists+linux-integrity@lfdr.de>; Mon, 29 May 2023 04:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjE2CEK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 28 May 2023 22:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2CEK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 May 2023 22:04:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518DC6;
        Sun, 28 May 2023 19:04:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d426e63baso3260899b3a.0;
        Sun, 28 May 2023 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685325848; x=1687917848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLBoA+23K3jc86HPrf+FyXyak1JXjRm8IVB/JjKg/LY=;
        b=K+fT8nvfFj5f10qcR4UuYyW15c7V0i0AqIcH4ZjI1+El2ri5JzgbZwlXgLbW/Ll787
         +DosbUEprmLxm9+f39q4jRR1D8xkl3/aNR6K3M9qJgpn8t2RnjOTDX++JqiRIbHyDsDB
         ukGg0SiqbDmsQmD59ZkkO59QZANiYC9HNt/EaDlLtlMUyqy1GsbuYjk+10WTm5U5lTh5
         kY/9HmU3WZIFGPt4XyBOVk4ISJB5hqHYZFFLPvL/sGZ3AAT5/hMgODljcTBMBCc3HL39
         HnvQ+oGaIUEimziiN+POB3xlAFrm05+3YE+cmjPtolRMdGFOXANzb4d12LSqNqjXZfkY
         PPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685325848; x=1687917848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLBoA+23K3jc86HPrf+FyXyak1JXjRm8IVB/JjKg/LY=;
        b=TTnRx+ozJ/F1h3rqM3/mzTdyap/ZazdagEft5fO4emTBoNajmsTM3ntIeIFd12Tjzr
         IhnBlleuB63/wcs/t02GuQVmHP7iycoBFE89pv/xHSH0hCuZZ5YR2FPowp7OhawTFC4K
         C1k0n715GAMlHaXeWt/aMCyM2C3lzPDldjeX6oh+EKhinGdvH7ZxXfj1HDGX0+G+oHqE
         nc2Co6JGgqsEv69qszUUfVu8hrR0dAZP2IrPLj2OzAMzlNqzc/TqN0JfgwzzGxWpT4BO
         W1VzY7/6sWWBHhJNae/v57XONlUGqf9NVRsh0qb646OI+qaF/NOixOTM8tku8eGaSjM2
         b5tw==
X-Gm-Message-State: AC+VfDwuu51BPeURge9s116G/29b6DksQW3kLH76y1EaytXdb/YxHkzH
        mVN1/4M6LtQl3LTCfmSk+nA=
X-Google-Smtp-Source: ACHHUZ7Uci2HCTNGFogEjdlH+G91Mpz9Qa/IPP21M2dVIqZJNCp8Y5WUCg5fVfszsD8uil/5WLGm8g==
X-Received: by 2002:a05:6a00:1744:b0:636:f5f4:5308 with SMTP id j4-20020a056a00174400b00636f5f45308mr14700095pfc.7.1685325848004;
        Sun, 28 May 2023 19:04:08 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id s12-20020a62e70c000000b0063ba9108c5csm5934409pfh.149.2023.05.28.19.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 19:04:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8182F106A0B; Mon, 29 May 2023 09:04:04 +0700 (WIB)
Date:   Mon, 29 May 2023 09:04:04 +0700
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
Message-ID: <ZHQIFLWvrWUNMVxb@debian.me>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybxFYc807lJQs/+9"
Content-Disposition: inline
In-Reply-To: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--ybxFYc807lJQs/+9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 11:42:50PM +0000, Chris Packham wrote:
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
=2Ec:159=20
> __handle_irq_event_percpu+0xf4/0x180
> [=C2=A0=C2=A0=C2=A0 4.765557] Modules linked in:
> [=C2=A0=C2=A0=C2=A0 4.768626] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5=
=2E15.113 #1
> [=C2=A0=C2=A0=C2=A0 4.774747] Hardware name: Allied Telesis x250-18XS (DT)
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
> Initially I dismissed this as a warning that would probably be cleaned=20
> up when we did more work on the TPM support for our product but we also=
=20
> seem to be getting some new i2c issues and possibly a kernel stack=20
> corruption that we've conflated with this TPM warning.

Can you reproduce this issue on mainline? Can you also bisect to find
the culprit?

Anyway, I'm adding it to regzbot:

#regzbot ^introduced: v5.15.110..v5.15.112
#regzbot title: Possible stack corruption and i2c issues due to irq warning=
 on Inifineon SLM9670 TPM

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ybxFYc807lJQs/+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHQIDQAKCRD2uYlJVVFO
o28IAP9l7fkmBaEnd7uOzDrnx7R2T/xBLWnlazaZb2bK81BjkwD9EvBXYgNA8Ikl
z9GdErluz1LCaBlZBBqRshbT/6hKTQY=
=eZ2H
-----END PGP SIGNATURE-----

--ybxFYc807lJQs/+9--
