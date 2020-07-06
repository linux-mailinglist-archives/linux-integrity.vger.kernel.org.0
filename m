Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37621610B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2020 23:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGFVrO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 17:47:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60189 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbgGFVrN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 17:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594072032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRWR21MnKfXBkh6ZR/sB0rfgRbUwkmqSxMK2L6dCLXk=;
        b=HEC4NrgfEVo5pEcRmBFWxB2N+2iH8daGo2BOzuq5FSTFW5ykA6b5xJ3QGOtWL8EsTnyVpO
        S+ch0FAscVm4PWCSgbUt5+PKwPIi2JvUkibFt2am3/PXClvuA19xdj2ZF8hgZWQLZgZ7We
        QK6ymOfSSYvjjUPMCrmVjd3D0KS7FRY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-f0spqqveNmCW26VuU-bYDQ-1; Mon, 06 Jul 2020 17:47:10 -0400
X-MC-Unique: f0spqqveNmCW26VuU-bYDQ-1
Received: by mail-qt1-f197.google.com with SMTP id c26so29214449qtq.6
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jul 2020 14:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=qRWR21MnKfXBkh6ZR/sB0rfgRbUwkmqSxMK2L6dCLXk=;
        b=K080TBNFH92FHAlAOZOT7Dj5D1lGErFk6nh6G575f/aIoQrYUloEcCwwrY3clHlSCV
         y+00tIamy8hG11d9/Z6nuOvf64pLvzpLR1LKI8lPBoziGBb07YY/8/gpIFqrKIgLimCt
         nAW1yp55IL8TntrCEHOolfzBjnaAfC+n/qREWQ9srAtxiDLT9ULS2VHo3JsAJ/y7XyWZ
         Ej+NoWBBKJFc/Bc1cBMzKz2+Rs39kiJcuecTSqsOrak6qDFq0/RyUkQxIbs+ah2UrUQ0
         9IHq3YsNSiNwe+G1Yj3S4bnHWxLxDRgsirm6UkFYOy+xiT8cv6xT2Rg7W033b6rPyKbP
         5xcw==
X-Gm-Message-State: AOAM530B3ncpOWUbJQ7M35kgQ/ADG8yTvqeiOKyqKueJbC/CZFYg5K90
        BUYAzj0rYYTfMy6iV4OdF87jFtyhONTfgiCgI9D7xKmXcigZ3Kl75shZApiwkR5EVczwUz7Bv/2
        ceS24pfu85N2uWZ2UKn5NWb1u0zW4
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr33810385qvu.97.1594072029904;
        Mon, 06 Jul 2020 14:47:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCy6hty4Qry42W/2htbonA/KYvIh/mbX1sjmZEooPJokA8Od5Q4VUxAYtSb+CbGv7opx5QCg==
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr33810377qvu.97.1594072029656;
        Mon, 06 Jul 2020 14:47:09 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x34sm15083272qtd.44.2020.07.06.14.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:47:08 -0700 (PDT)
References: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")
In-reply-to: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
Date:   Mon, 06 Jul 2020 14:47:07 -0700
Message-ID: <87k0zgwc2s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-07-06 13:53 MST:

> Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
> and tpm_infineon use the same device ID. Revert the commit and add a
> remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
> module parameter").
>
> Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
> Reported-by: Peter Huewe <peterhuewe@gmx.de>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index c58ea10fc92f..0b214963539d 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -235,9 +235,17 @@ static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
>  	return tpm_tis_init(&pnp_dev->dev, &tpm_info);
>  }
>  
> +/*
> + * There is a known bug caused by 93e1b7d42e1e ("[PATCH] tpm: add HID module
> + * parameter"). This commit added IFX0102 device ID, which is also used by
> + * tpm_infineon but ignored to add quirks to probe which driver ought to be
> + * used.
> + */
> +
>  static struct pnp_device_id tpm_pnp_tbl[] = {
>  	{"PNP0C31", 0},		/* TPM */
>  	{"ATM1200", 0},		/* Atmel */
> +	{"IFX0102", 0},		/* Infineon */
>  	{"BCM0101", 0},		/* Broadcom */
>  	{"BCM0102", 0},		/* Broadcom */
>  	{"NSC1200", 0},		/* National */

