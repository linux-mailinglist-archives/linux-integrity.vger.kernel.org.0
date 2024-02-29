Return-Path: <linux-integrity+bounces-1497-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E194B86BCF9
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 01:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1428510E
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Feb 2024 00:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B6C17554;
	Thu, 29 Feb 2024 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="XR+Cr1uP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483F13D2E5
	for <linux-integrity@vger.kernel.org>; Thu, 29 Feb 2024 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167634; cv=none; b=oqbSCaVAn4Sro91zczk6OYM4M09Om53Emo8ViPnlgZ/ZmKUVZ1L5P7THs2O6NKeuYUoYPme/FnNJkfe224aFeM26Q6VXjC6Z86aDD5vbcMwHTpaQaWuqrP0j33QYybmpgiOjNvuYnhRPTlG1JHHnFT0/G8C1nlRJ42P6nUR7HL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167634; c=relaxed/simple;
	bh=EtzrGr662xCU1sNLieoGEl4ta1zjFTgk8ZydSq/pjlQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Oe7a53mBBt6PyGDRm/GQyCYqTuX62LTPm43RhSwOXmnGfpKwzxBqHRn1EO5VV8RLT25jDMDnjNJLLRxdqxXfRM3OsMpUhps7fOmS1dv/hQrXm+69bTOQZ+bg+jqXszdaz25Q6SPJdJKDXRZyu9GF/lQ6w6Vo95l+EZ47a9MX9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b=XR+Cr1uP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso53459166b.2
        for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2024 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709167630; x=1709772430; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eObertsJakPpi13M9q57oeVvcenpnPh+pTJAq0BssCY=;
        b=XR+Cr1uPnMtZvtusTFXQdyYmGtavnB3pmkk6IRAJ95fEi6Puk+02sLusQJN+V28Lmq
         f1cBRnNSTfp6iHucfkCafGJxUjj93NrJUE3bGO56ESZYZblOjC9J7WldgbxNMqS/jvI/
         42x8jvVL68OGuA58PJnrejnpjFFY8VRJUL3mnhczHJJ9ZqE8RlYQyCw2wFf2Wgwm5JdE
         tnNrvQ+o0X9meNMBrgvEux4s3FUxd5XHbUCOz+Uh8mMgGsSiRuVL3k1cm0f5fjjJjIAt
         90lVuxUnwrRH6DjqMQZW38kIGI2dMa16sXEHeKOFC9QeRM+Jbvh3a77kden3UKWaLQhb
         K8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167630; x=1709772430;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eObertsJakPpi13M9q57oeVvcenpnPh+pTJAq0BssCY=;
        b=fGqu3mH0mJ4iWCiteX3czO1yYQwGoWFUdlCoxoqZXA5Lk1j3z9ZrJ92viuevaI7V79
         apyHfvWYiQL0CTPCK5u9N3YT/kbc74QZEo6nBn/tH/1+jNy9t/y4eNcmKMKaY29AqfVN
         xnfmb0bMlWxAl6k3bB7LJLkky8UnbT+0GuY/wrDlWzFF9QZ7vhC9IDKs027h6pb7JzwB
         p9xs8M/3unCHNAM0uvIlJMPTPu5GrW4IPLKPjMLz7RvM0uL/sIMu+V7TAlmCZzNXOY7m
         Nz/U0yyS6UJatgC49bxwAd1DD9iv/kuB+RZHinZGpd/AYVxHLk9RpU3tXN0oCyQMWWNQ
         Uapw==
X-Gm-Message-State: AOJu0Yx/eJWk71MQ54u01oEdV0TVWKeJn9QirDFIE1I6Z897ovgnkQgy
	cV3+isQ1jvTcxYwHn9FXcyvVpwm3H4IRLuYhZ07X7hbOpDw/7dGENoScZBR4AkuReJfwvUl80SU
	Ikm4+pKjuN79W4pygIbXCkniae/KdZ+gx4GqfRtcpTSq7z3xMTic=
X-Google-Smtp-Source: AGHT+IHKCqfPq48qiYDzf2tAiPSexhtl+EPdKvyt7gADI6g62Gv1JEhXHOgRLKUAKImlFKM4Dck8XEay1QLsGfeGZXc=
X-Received: by 2002:a17:906:a40e:b0:a44:4317:d65c with SMTP id
 l14-20020a170906a40e00b00a444317d65cmr59979ejz.44.1709167629942; Wed, 28 Feb
 2024 16:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 Feb 2024 16:46:58 -0800
Message-ID: <CAJ+vNU2irDtEn=VD7N2ySofr5wTeko6OHy-QD_SLLZudOwWj0A@mail.gmail.com>
Subject: TPM error path on probe
To: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
	Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Greetings,

Commit 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000
unhandled IRQs") introduced a kernel warning for boards that do not
have a TPM loaded but have one defined in the device-tree (ie a
subloaded board assembly):

[    2.434431] WARNING: CPU: 3 PID: 55 at kernel/workqueue.c:3397
__flush_work.isra.0+0x2ac/0x2d8
[    2.443069] Modules linked in:
[    2.446133] CPU: 3 PID: 55 Comm: kworker/u8:3 Not tainted
6.6.8-00021-g232153790aa6-dirty #434
[    2.454758] Hardware name: Gateworks Venice GW73xx-2x i.MX8MP
Development Kit (DT)
[    2.462337] Workqueue: events_unbound async_run_entry_fn
[    2.467669] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.474647] pc : __flush_work.isra.0+0x2ac/0x2d8
[    2.479278] lr : flush_work+0x10/0x1c
[    2.482950] sp : ffff80008270ba40
[    2.486271] x29: ffff80008270ba40 x28: 00000000ffffffff x27: 00000000ffffffff
[    2.493425] x26: ffff000000293000 x25: ffff80008218aff8 x24: ffff800080a1c6a8
[    2.500578] x23: 00000000ffffffff x22: ffff80008213ca18 x21: 0000000000000001
[    2.507731] x20: ffff000000e142c0 x19: ffff000000e14280 x18: 0000000000000000
[    2.514884] x17: 0000000000000000 x16: 000000000000001c x15: 0000000000000000
[    2.522038] x14: ffff00003fd94100 x13: 0000000000000002 x12: 0000000000000000
[    2.529191] x11: 0000000000000400 x10: 0000000000000910 x9 : 00000000ffffffff
[    2.536346] x8 : 0000000000000cc1 x7 : ffff8000804c76d8 x6 : 00000000090ee8ad
[    2.543500] x5 : ffff00000026c380 x4 : 0000000000000000 x3 : 0000000000000000
[    2.550655] x2 : 0000000000000000 x1 : ffff00000026c380 x0 : 0000000000000000
[    2.557806] Call trace:
[    2.560261]  __flush_work.isra.0+0x2ac/0x2d8
[    2.564544]  flush_work+0x10/0x1c
[    2.567869]  tpm_tis_remove+0x8c/0xc4
[    2.571545]  tpm_tis_core_init+0x194/0x7b8
[    2.575656]  tpm_tis_spi_probe+0xa4/0xd4
[    2.579593]  tpm_tis_spi_driver_probe+0x34/0x64
[    2.584136]  spi_probe+0x84/0xe4
[    2.587377]  really_probe+0x148/0x2c0
[    2.591052]  __driver_probe_device+0x78/0x12c
[    2.595417]  driver_probe_device+0xd8/0x15c
[    2.599609]  __device_attach_driver+0xb8/0x134
[    2.604064]  bus_for_each_drv+0x84/0xe0
[    2.607913]  __device_attach_async_helper+0xac/0xd0
[    2.612808]  async_run_entry_fn+0x34/0xe0
[    2.616832]  process_one_work+0x138/0x260
[    2.620851]  worker_thread+0x32c/0x438
[    2.624609]  kthread+0x118/0x11c
[    2.627844]  ret_from_fork+0x10/0x20
[    2.631428] ---[ end trace 0000000000000000 ]---

The issue is caused by tpm_tis_remove() calling flush_work() on the
work queue that has not yet been initialized. I can move the INIT_WORK
call added in this commit into the probe to fix this:
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d5ea22196b5b..e62294b3a437 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1133,6 +1133,8 @@ int tpm_tis_core_init(struct device *dev, struct
tpm_tis_data *priv, int irq,

        dev_set_drvdata(&chip->dev, priv);

+       INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
+
        rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
        if (rc < 0)
                return rc;
@@ -1159,8 +1161,6 @@ int tpm_tis_core_init(struct device *dev, struct
tpm_tis_data *priv, int irq,
                }
        }

-       INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
-
        if (chip->ops->clk_enable != NULL)
                chip->ops->clk_enable(chip, true);

However I wonder if we should simply have error checking for an
invalid vendor of 0xffffffff. Is there any reason to not return an
-ENODEV if vendor == 0xffffffff?

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d5ea22196b5b..1bb1b3e1b2d0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1136,6 +1136,8 @@ int tpm_tis_core_init(struct device *dev, struct
tpm_tis_data *priv, int irq,
        rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
        if (rc < 0)
                return rc;
+       if (rc == 0xffffffff)
+               return -ENODEV;

        priv->manufacturer_id = vendor;

I'm not sure if a hard coded 0xffffffff check is best here.

Best regards,

Tim

