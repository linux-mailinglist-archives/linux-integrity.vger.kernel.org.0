Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC83F82A2
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKV5V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 16:57:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKV5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 16:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573509440;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nih57YMCMPAseO/UM17Nv4r8QK17FbUpMQnvM1rs4jQ=;
        b=af1i0HAZLVMV7mWx4YhuiODagpylom9EJDyLPp71q9jsEnEnVbyujZwKVdYIIgiabM/+Da
        rwAIJVqi0aTgaCz9ww7soQZJ7tLuLliOHkPm6/URcP54A8hctfazDROZCx7pFDnubtiyvq
        Jagcvx67fafkFGc11VTTaLMRHdgk3/U=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-B_0pdzmtOcCHdp1z9rR9yg-1; Mon, 11 Nov 2019 16:57:19 -0500
Received: by mail-yw1-f72.google.com with SMTP id 202so12623738ywf.8
        for <linux-integrity@vger.kernel.org>; Mon, 11 Nov 2019 13:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=FkWMWyHf1d3bB21ihSPRi49t4hxRt8vlg87KGPgk2dI=;
        b=HTAoH2bhykVhU73c0d5MUwPQ6rt1eHfHZvmMTYoFyjq5+WLqsMEBeD4oH5rb7rz0tT
         Z7I5KojAXQnUvyZbYynhwyLZZmVvfPtHwMD51K15vMBVctBx5QghPXFpeAzekLj6/V/a
         jkEu+q9xmum/uv8VKkD6bxPRPIHCrajbPIYXmfvfZAczcpN9a0Kt4dAR21xl1ML9lqV6
         a0x5e52EiNjYyTB6Pmj1eFt6WTBQdQc/n/wLB+g7ovXMwwSGENFhLgihgWch+HR2qBTB
         PUIzmgr4knepVrI2v9p3MV5U0c0Mk5tlMIdbrDANmOh5GcVPGPNys93JZp2u0EwFb9oS
         GeCA==
X-Gm-Message-State: APjAAAXUJkihPHTwVv73omqK/LYIHqLJYu9vjw3z/hACnuYklOfP4uEA
        UrmD10cPY4apIsvpt2gwVIn/VCB6AD7aTq7vzBk6Mqv2N09lfs9txB+TX2lNE2Y0NPsbeCMqor8
        QhDADrspQl0EhwUYFgXs5ctZw7qwC
X-Received: by 2002:a81:c94b:: with SMTP id c11mr17549169ywl.253.1573509438487;
        Mon, 11 Nov 2019 13:57:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5xqzmXnwz+0CW36y1bmWGtzF+L2IAfN/KgoF5tk+lzM+sF9zsAxBqvDuxuBFWAFoWYeLR9g==
X-Received: by 2002:a81:c94b:: with SMTP id c11mr17549153ywl.253.1573509438172;
        Mon, 11 Nov 2019 13:57:18 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q198sm6056456ywg.18.2019.11.11.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:57:17 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:57:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Christian Bundy <christianbundy@fraction.io>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: PROBLEM: TPM bug causes suspend to turn off device
Message-ID: <20191111215714.kw3doe3qf5ps7imk@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <a60dadce-3650-44ce-8785-2f737ab9b993@www.fastmail.com>
 <20191110072611.2k6tjt4geiq2rqol@cantor>
MIME-Version: 1.0
In-Reply-To: <20191110072611.2k6tjt4geiq2rqol@cantor>
X-MC-Unique: B_0pdzmtOcCHdp1z9rR9yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Nov 10 19, Jerry Snitselaar wrote:
>Jarkko, should there be tpm_chip_start/tpm_chip_stop calls around
>the tpm1_getcap calls in tpm1_get_timeouts?
>

Maybe moving the tpm_chip_start called before the irq probe to before
tpm_get_timeouts:

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_cor=
e.c
index 270f43acbb77..806acc666696 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_=
tis_data *priv, int irq,
                  * to make sure it works. May as well use that command to =
set the
                  * proper timeouts for the driver.
                  */
+               tpm_chip_start(chip);
                 if (tpm_get_timeouts(chip)) {
                         dev_err(dev, "Could not get TPM timeouts and durat=
ions\n");
                         rc =3D -ENODEV;
+                       tpm_chip_stop(chip);
                         goto out_err;
                 }
 =20
-               tpm_chip_start(chip);
                 chip->flags |=3D TPM_CHIP_FLAG_IRQ;
                 if (irq) {
                         tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARE=
D,

