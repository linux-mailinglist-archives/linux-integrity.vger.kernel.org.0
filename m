Return-Path: <linux-integrity+bounces-1523-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB29086CEB1
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 17:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798911F26577
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34964AEC3;
	Thu, 29 Feb 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="MnsG8mkA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FB13C9D9
	for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222562; cv=none; b=UikPV2nufCorDLybThOwEkHba7FXmQr9rNzSqsvaR/NWV3TlEy2lInbZXUa6g4H1mGXpRYb/YEs9pSnyHdpGmQL6JVMBpkG87b5/umoDMn57nWu1AcUeME71dgytuIVA2dd/2bChyY9EDLeGVQt10anecdTFsTM++5Jp6r8W9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222562; c=relaxed/simple;
	bh=FaPM2KcFY09BAqMNbso/pmEkEwrO4vBN1BH0/m1zl5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8DYNuEpnOhcx6xaoTdjlwE3Wk7Ma7hXOZZDhgOjJXsG0a/lnzjB4l3JIDIdRZ63jZtGTynfgyC893b4JJq8OnsfielGJusJbARiM8vvC9WBaBzhxWC3/67efyjKNiSjy/lTCdjSkJUikrX9yECmfADwEbovkbYPK2ab2nFw7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b=MnsG8mkA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a446478b04bso54647166b.3
        for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709222559; x=1709827359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1X84lQ7LUeiL/C+3p2uzJ3StT71rKevN7XkIBZEMh4=;
        b=MnsG8mkAs9unwIy0mS6TtUv8+6xmp/Ee2O/ieH+MtsidZWdzJGTZ8zpalJ1vRoWylQ
         WKHFgYqC0Xvi3pJThdDMy7ttl6zKXn8U6JGjzzfZ7PLixmXP2lcheWjnMhPo9WNJv1zX
         x3BWxk5wdJNkSnUiRAyH+fyVb8nLZP1LU2v980LYrqg0DWFG/X9qDjeFL2TTnyJQ43Em
         vxPgsMRF9s1liVMuxFUyEnpaQjbXl6hHoSL1eYJdbODvsDNoACozI2g8i4wwoSBK5qzM
         p+VnT+rtq2TykM+rXBT2F6kTITn4HqFzhpQ29mYd0XYsGMsQvsV1zvtdkyJ/BsPiYK0d
         SyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222559; x=1709827359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1X84lQ7LUeiL/C+3p2uzJ3StT71rKevN7XkIBZEMh4=;
        b=IYWECnnHISqsoKKnFt44VychzdPy05/3N8naAJvSBpEuRRPoJXm5Nogh4gOY8bCgq3
         pW87l4vsf1Hhf0jlkUjbgEQfQIqqYQkmCuUBR9Y0Jl9+zmB5XKLy0bs376iDdmvzvpIv
         uUj+0Z7irDUP2ZKUF89StXG66lPXayEklmUPfUypnYsRL/gwIW/CKvcytrMPqI2Tjnjd
         GxBkw+ampWiB3KSrkNwy0N6ezUjyBlN1oDzSiDmhJ1RiYr9L8IFJt4757/nu8mhH3zTx
         5743UyLxI6yTu5rWIUuM/WnUBSZYR+i3x2DKc7+3DYjI+fN5NdBEG/0gwSBp+cF+Qdhi
         d48A==
X-Gm-Message-State: AOJu0YxDzCNsp9qkzS3JkEIlFfWnjG3+is987yD5P5grkctsttLFv8ak
	V+YRQXGripkrxARi1k57uNMoA73uc+V7H4xajMDwT9t4J6LgSYDpAR2nXxLK/n9jgBq2ap97yL8
	GtWff+tNBGlITdL4i28buz4Cy3Itic8Cs20KLDQ==
X-Google-Smtp-Source: AGHT+IElap248V1JqnP+PslkT98ArAqN+mqJVzsbFXTJ0jVqIonSDN77wJET0ASun4RW7/VmoVY+Uh6fGR0AsKVrTr4=
X-Received: by 2002:a17:906:5fd5:b0:a43:d473:685 with SMTP id
 k21-20020a1709065fd500b00a43d4730685mr1855363ejv.38.1709222558713; Thu, 29
 Feb 2024 08:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU2irDtEn=VD7N2ySofr5wTeko6OHy-QD_SLLZudOwWj0A@mail.gmail.com>
 <6976a0ea-592b-4a04-81ac-9ed50a7f0a8f@gmx.de>
In-Reply-To: <6976a0ea-592b-4a04-81ac-9ed50a7f0a8f@gmx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 29 Feb 2024 08:02:27 -0800
Message-ID: <CAJ+vNU2xjAm=QkUG3Q1XGs-cOrusZYSCNKn1hgud2-HdNZwcuQ@mail.gmail.com>
Subject: Re: TPM error path on probe
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
	Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:09=E2=80=AFPM Lino Sanfilippo <LinoSanfilippo@gm=
x.de> wrote:
>
> Hi Tim,
>
> On 29.02.24 01:46, Tim Harvey wrote:
> > Greetings,
> >
> > Commit 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000
> > unhandled IRQs") introduced a kernel warning for boards that do not
> > have a TPM loaded but have one defined in the device-tree (ie a
> > subloaded board assembly):
> >
> > [    2.434431] WARNING: CPU: 3 PID: 55 at kernel/workqueue.c:3397
> > __flush_work.isra.0+0x2ac/0x2d8
> > [    2.443069] Modules linked in:
> > [    2.446133] CPU: 3 PID: 55 Comm: kworker/u8:3 Not tainted
> > 6.6.8-00021-g232153790aa6-dirty #434
> > [    2.454758] Hardware name: Gateworks Venice GW73xx-2x i.MX8MP
> > Development Kit (DT)
> > [    2.462337] Workqueue: events_unbound async_run_entry_fn
> > [    2.467669] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    2.474647] pc : __flush_work.isra.0+0x2ac/0x2d8
> > [    2.479278] lr : flush_work+0x10/0x1c
> > [    2.482950] sp : ffff80008270ba40
> > [    2.486271] x29: ffff80008270ba40 x28: 00000000ffffffff x27: 0000000=
0ffffffff
> > [    2.493425] x26: ffff000000293000 x25: ffff80008218aff8 x24: ffff800=
080a1c6a8
> > [    2.500578] x23: 00000000ffffffff x22: ffff80008213ca18 x21: 0000000=
000000001
> > [    2.507731] x20: ffff000000e142c0 x19: ffff000000e14280 x18: 0000000=
000000000
> > [    2.514884] x17: 0000000000000000 x16: 000000000000001c x15: 0000000=
000000000
> > [    2.522038] x14: ffff00003fd94100 x13: 0000000000000002 x12: 0000000=
000000000
> > [    2.529191] x11: 0000000000000400 x10: 0000000000000910 x9 : 0000000=
0ffffffff
> > [    2.536346] x8 : 0000000000000cc1 x7 : ffff8000804c76d8 x6 : 0000000=
0090ee8ad
> > [    2.543500] x5 : ffff00000026c380 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [    2.550655] x2 : 0000000000000000 x1 : ffff00000026c380 x0 : 0000000=
000000000
> > [    2.557806] Call trace:
> > [    2.560261]  __flush_work.isra.0+0x2ac/0x2d8
> > [    2.564544]  flush_work+0x10/0x1c
> > [    2.567869]  tpm_tis_remove+0x8c/0xc4
> > [    2.571545]  tpm_tis_core_init+0x194/0x7b8
> > [    2.575656]  tpm_tis_spi_probe+0xa4/0xd4
> > [    2.579593]  tpm_tis_spi_driver_probe+0x34/0x64
> > [    2.584136]  spi_probe+0x84/0xe4
> > [    2.587377]  really_probe+0x148/0x2c0
> > [    2.591052]  __driver_probe_device+0x78/0x12c
> > [    2.595417]  driver_probe_device+0xd8/0x15c
> > [    2.599609]  __device_attach_driver+0xb8/0x134
> > [    2.604064]  bus_for_each_drv+0x84/0xe0
> > [    2.607913]  __device_attach_async_helper+0xac/0xd0
> > [    2.612808]  async_run_entry_fn+0x34/0xe0
> > [    2.616832]  process_one_work+0x138/0x260
> > [    2.620851]  worker_thread+0x32c/0x438
> > [    2.624609]  kthread+0x118/0x11c
> > [    2.627844]  ret_from_fork+0x10/0x20
> > [    2.631428] ---[ end trace 0000000000000000 ]---
> >
> > The issue is caused by tpm_tis_remove() calling flush_work() on the
> > work queue that has not yet been initialized. I can move the INIT_WORK
> > call added in this commit into the probe to fix this:
>
> I posted a fix for this issue a few weeks ago:
> https://lore.kernel.org/all/20240201113646.31734-1-l.sanfilippo@kunbus.co=
m/
>
> It is already included in Jarkos tree.
>

Hi Lino,

Thank you!

Tim

