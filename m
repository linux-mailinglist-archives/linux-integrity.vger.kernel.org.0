Return-Path: <linux-integrity+bounces-1521-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5E86C1A0
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 08:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50169289DD0
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBE446AD;
	Thu, 29 Feb 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="HkfdzL8i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFC39855
	for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190562; cv=none; b=iaKYwV2jtOLlSEVnK+eQefvKK8Zv/Eag2U5b6NkLq698ELr/ZQgHCyEneV7XvBw0Fwm5LfWm5QWCiDaAznTnsYzztwc/T9onujQyBdZjsDjMM1xQ+An2ZWIhfY6y54x79TyNCBKWPS5Uy/bvf9YPOLYb38ANLz08xu5M3veXxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190562; c=relaxed/simple;
	bh=zxmIwdN8xxVOeu3eobZU/8dNPX7rWwEgZ3Ff8dx5nx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g1m83rmJuul92DjRybjZ10hlKDHvuTMVCVQ6uooUhzMxJRMF73ipvwSs2uHk+W2X0qvPHE0ayWISjiuLpnT4+olIrvw0QBVEvCVhjDm3Wu/pF5UamVwZX7YLfrvV01sgdv9hUSI90mwf4pdLFswJKIv+6h6slJYY6mkWT0iPN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b=HkfdzL8i; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709190535; x=1709795335; i=linosanfilippo@gmx.de;
	bh=zxmIwdN8xxVOeu3eobZU/8dNPX7rWwEgZ3Ff8dx5nx4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=HkfdzL8iUEp5FfPPP14K1kam/P2Fp2i8ZXGNks/Ha/LBv/+ShwT8YUV4NdSoATtN
	 6+LrWDUX3cMy3rjUCjImsAqwNcgYCOf/zDY78t/h4nMCdqP/iWZVV/BQWLgRtgFda
	 ma7QD1H8F12VbS6/upYj9Fka+Y1g1kTK9tvU0xu2aD8xcurxLbTICuUTgsQVzOE0x
	 kbS6x53krKc40k2kycWaBIjTgz19Ai0Siumidh1fgNV86hVo3BqC6i0cDUUOs3pqJ
	 Fu1Q0J5/vCQw3CPA+ICX85f/w1fgsa71b+4jm858bk87Pp6x9PQayjDcfL76SCgjg
	 R0vVsJLJZSJ/rL0WqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.21.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1qrBmA423c-00tEhU; Thu, 29
 Feb 2024 08:08:55 +0100
Message-ID: <6976a0ea-592b-4a04-81ac-9ed50a7f0a8f@gmx.de>
Date: Thu, 29 Feb 2024 08:08:50 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TPM error path on probe
To: Tim Harvey <tharvey@gateworks.com>, linux-integrity@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <CAJ+vNU2irDtEn=VD7N2ySofr5wTeko6OHy-QD_SLLZudOwWj0A@mail.gmail.com>
Content-Language: en-US
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAJ+vNU2irDtEn=VD7N2ySofr5wTeko6OHy-QD_SLLZudOwWj0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0gOo20N9R8QIjKHlBPFURUpHT+KifAb9acKa4B7VEHqlMD35oaO
 Aoi6xKRq8bayHRBKSV7jCoi5FLYqu72UMv/lbhT8fAuxVejnuFfxBPGbUVjWZ0zczC6DCTn
 zUsNJHz7vpTkJTzTmsLBorj+Wp5uNnFoRpFR6Bbq0iC5jLt9Efg/sDQwaNlO3MupwsX6o79
 GsTEroMNVk1o0Tz/wipIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k2gejLmpk0g=;zadhyiAncSumNU087iGzC90JIoy
 996yX59wR4qHkDLEgzmAw7zM9dkfSrC5gbtml4YYBot4njejLBIksCpBEHTCGsyJlGtNTPB83
 oXM+r0R0gaLJGSjwIz2IoEk+AWot/rEGxYXYujCiqdAT6rykSpi8LzMKYr/ey8/bjTxDzMxDP
 PrsVKyGoBidgWHPd5hHBM8udsl82n61OFqRQzoyzMuTS/kqzE42XJ/af1XkmbbU0fzfP5zja2
 KiynVmOtWqPWkL1WCIdiAo95WPZOotKzoUtJ1ai3QmEFySF61jqqlnn5tAtVP1+e/9jywOQxx
 8lhoApYpxvJTsNoX4W7y+RsnheBfD9QIuLA/o9fIcMqap6V7htRcVboIwDAQcISxaKqI4Zs2H
 gD7+14pBNAFUwfSjRAOZsHsp8uNFPI5rc2U3EZ/ciFoJz316py2y73WPj4OLvI8gvfVF/ijc7
 2B3dvzef7WjRoGk7FAWw6OWHIeIesyQrTkgzujbxOPGS4f8AD0H1O6AO0v+dHvTyhxtaFAFVA
 JE5nmCTpzb7IW7G4MRw7jpWjKrtFhh9YLlqn0yNwmdFtL2RFQh5bXRSd0ckIgJXL7iElDBlb+
 MaqK3LbHOpEtt76Jj8y+DNoOOjoTeO/UMtBga+JOpxwwGNOpSfhVhd02z8hoL/sykZwlE1PeO
 3eeMCb+jR4juj4djkWk+uMW8NQmtPKS8n6GBuLfXxKY3L1HEIJe1anaIjRxLoCNByZFyVh8Nu
 2h1+pF7ELeOXqOHnUu8OvJdAaL2jvfU/cDoPhVdTemk+AGuhrTncWIc7AJfsiHIcb66SfxdNV
 ZvM3j+HgKxQHeYLLBGSXhXcN67epUKgnL/2wKRsAO3ecs=

Hi Tim,

On 29.02.24 01:46, Tim Harvey wrote:
> Greetings,
>
> Commit 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000
> unhandled IRQs") introduced a kernel warning for boards that do not
> have a TPM loaded but have one defined in the device-tree (ie a
> subloaded board assembly):
>
> [    2.434431] WARNING: CPU: 3 PID: 55 at kernel/workqueue.c:3397
> __flush_work.isra.0+0x2ac/0x2d8
> [    2.443069] Modules linked in:
> [    2.446133] CPU: 3 PID: 55 Comm: kworker/u8:3 Not tainted
> 6.6.8-00021-g232153790aa6-dirty #434
> [    2.454758] Hardware name: Gateworks Venice GW73xx-2x i.MX8MP
> Development Kit (DT)
> [    2.462337] Workqueue: events_unbound async_run_entry_fn
> [    2.467669] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
> [    2.474647] pc : __flush_work.isra.0+0x2ac/0x2d8
> [    2.479278] lr : flush_work+0x10/0x1c
> [    2.482950] sp : ffff80008270ba40
> [    2.486271] x29: ffff80008270ba40 x28: 00000000ffffffff x27: 00000000=
ffffffff
> [    2.493425] x26: ffff000000293000 x25: ffff80008218aff8 x24: ffff8000=
80a1c6a8
> [    2.500578] x23: 00000000ffffffff x22: ffff80008213ca18 x21: 00000000=
00000001
> [    2.507731] x20: ffff000000e142c0 x19: ffff000000e14280 x18: 00000000=
00000000
> [    2.514884] x17: 0000000000000000 x16: 000000000000001c x15: 00000000=
00000000
> [    2.522038] x14: ffff00003fd94100 x13: 0000000000000002 x12: 00000000=
00000000
> [    2.529191] x11: 0000000000000400 x10: 0000000000000910 x9 : 00000000=
ffffffff
> [    2.536346] x8 : 0000000000000cc1 x7 : ffff8000804c76d8 x6 : 00000000=
090ee8ad
> [    2.543500] x5 : ffff00000026c380 x4 : 0000000000000000 x3 : 00000000=
00000000
> [    2.550655] x2 : 0000000000000000 x1 : ffff00000026c380 x0 : 00000000=
00000000
> [    2.557806] Call trace:
> [    2.560261]  __flush_work.isra.0+0x2ac/0x2d8
> [    2.564544]  flush_work+0x10/0x1c
> [    2.567869]  tpm_tis_remove+0x8c/0xc4
> [    2.571545]  tpm_tis_core_init+0x194/0x7b8
> [    2.575656]  tpm_tis_spi_probe+0xa4/0xd4
> [    2.579593]  tpm_tis_spi_driver_probe+0x34/0x64
> [    2.584136]  spi_probe+0x84/0xe4
> [    2.587377]  really_probe+0x148/0x2c0
> [    2.591052]  __driver_probe_device+0x78/0x12c
> [    2.595417]  driver_probe_device+0xd8/0x15c
> [    2.599609]  __device_attach_driver+0xb8/0x134
> [    2.604064]  bus_for_each_drv+0x84/0xe0
> [    2.607913]  __device_attach_async_helper+0xac/0xd0
> [    2.612808]  async_run_entry_fn+0x34/0xe0
> [    2.616832]  process_one_work+0x138/0x260
> [    2.620851]  worker_thread+0x32c/0x438
> [    2.624609]  kthread+0x118/0x11c
> [    2.627844]  ret_from_fork+0x10/0x20
> [    2.631428] ---[ end trace 0000000000000000 ]---
>
> The issue is caused by tpm_tis_remove() calling flush_work() on the
> work queue that has not yet been initialized. I can move the INIT_WORK
> call added in this commit into the probe to fix this:

I posted a fix for this issue a few weeks ago:
https://lore.kernel.org/all/20240201113646.31734-1-l.sanfilippo@kunbus.com=
/

It is already included in Jarkos tree.

BR,
Lino

> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_=
core.c
> index d5ea22196b5b..e62294b3a437 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1133,6 +1133,8 @@ int tpm_tis_core_init(struct device *dev, struct
> tpm_tis_data *priv, int irq,
>
>         dev_set_drvdata(&chip->dev, priv);
>
> +       INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> +
>         rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
>         if (rc < 0)
>                 return rc;
> @@ -1159,8 +1161,6 @@ int tpm_tis_core_init(struct device *dev, struct
> tpm_tis_data *priv, int irq,
>                 }
>         }
>
> -       INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> -
>         if (chip->ops->clk_enable !=3D NULL)
>                 chip->ops->clk_enable(chip, true);
>
> However I wonder if we should simply have error checking for an
> invalid vendor of 0xffffffff. Is there any reason to not return an
> -ENODEV if vendor =3D=3D 0xffffffff?
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_=
core.c
> index d5ea22196b5b..1bb1b3e1b2d0 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1136,6 +1136,8 @@ int tpm_tis_core_init(struct device *dev, struct
> tpm_tis_data *priv, int irq,
>         rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
>         if (rc < 0)
>                 return rc;
> +       if (rc =3D=3D 0xffffffff)
> +               return -ENODEV;
>
>         priv->manufacturer_id =3D vendor;
>
> I'm not sure if a hard coded 0xffffffff check is best here.
>
> Best regards,
>
> Tim
>

