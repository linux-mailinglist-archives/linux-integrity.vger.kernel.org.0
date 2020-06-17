Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13C31FC420
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 04:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFQC0i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 22:26:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58170 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbgFQC0i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 22:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592360797;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=zCOHE7OG5gr41+QXbJtrcX3nlRIvbAhqRWeAG5sX4T8=;
        b=Pl1Nind1IzP8918Sp5OPwDEATgvHWi8hpamZa1CaGbP2H+SVHp6Z9dUWDqs+mMfvucOGQI
        asoYiSOrEE1M3kytj87iwW4FXJ6Kr+DiDtOPDzG4reLlfyj58IeK0SGU0k9r6bWove0nvU
        IGF75X9w8fUS7XmcEX8IZaJpajUXQsI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-PU4htwloOAWf6WLPTQW0EQ-1; Tue, 16 Jun 2020 22:26:36 -0400
X-MC-Unique: PU4htwloOAWf6WLPTQW0EQ-1
Received: by mail-qv1-f69.google.com with SMTP id y2so576949qvp.1
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 19:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=zCOHE7OG5gr41+QXbJtrcX3nlRIvbAhqRWeAG5sX4T8=;
        b=IrvYDrT6K0EQHQOLippD53LEYODuAJeIh6rtlgk03L9vk+LzsXzZ8OkPL0p1yZ2cDb
         bV8rH2CP56/pUPiUN6CKFLUjtEoUVC1CgNWgBMdzHLvHGQtH61b16V+Sw/dZ1OnHjFEI
         V3T3wNPuyTss22KmIsktVarcmlC6Rcepo3fTSLLnpHoLCQOd5JHA+WHhWleuNS19HmAj
         eWPycUoc11LFltIIzqH51fjBHOLGOuHg7j6ccJoNiPUKmwHjbsZGQz5v5Cscknu/wQ2R
         2QjvFJhRulNXsTfotE1DTZmKazXfyLNokAJZ2+TXJxvQInW7Lu/N6Sz54wFL/nn1Ifbr
         Xmaw==
X-Gm-Message-State: AOAM532/ho5sC/rznphsrTlGzSUghXGNo0m8VgmfdNWi0kro4RBz8txl
        9yU3FqpUZChGm6+oSQge9CKyeCWr4lqGtDMjRdbrRwbQUtX8pKcsIzzwEF+fc2768tB28iGiG/h
        7j9FqTwgD9B82kWiTShIysBuXAScl
X-Received: by 2002:ac8:688a:: with SMTP id m10mr24505811qtq.254.1592360795573;
        Tue, 16 Jun 2020 19:26:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0gUkZcPmkrRQdscdt6tHYobw3VJMTpR30a5rEfXTm6Ge9ZQ+iBL8xmTke9P+2uHS2WHzkJQ==
X-Received: by 2002:ac8:688a:: with SMTP id m10mr24505801qtq.254.1592360795327;
        Tue, 16 Jun 2020 19:26:35 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h19sm14727590qkl.49.2020.06.16.19.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 19:26:34 -0700 (PDT)
Date:   Tue, 16 Jun 2020 19:26:32 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: extra chip->ops check on error path in
 tpm_tis_core_init
Message-ID: <20200617022632.c6mhqg7jwolebxvx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <8d6e3656-1662-dc71-8876-c7f0f11a11b1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <8d6e3656-1662-dc71-8876-c7f0f11a11b1@virtuozzo.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Jun 13 20, Vasily Averin wrote:
>Found by smatch:
>drivers/char/tpm/tpm_tis_core.c:1088 tpm_tis_core_init() warn:
> variable dereferenced before check 'chip->ops' (see line 979)
>
>'chip->ops' is assigned in the beginning of function
>in tpmm_chip_alloc->tpm_chip_alloc
>and is used before first possible goto to error path.
>
>Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
> drivers/char/tpm/tpm_tis_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>index 2435216..65ab1b0 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -1085,7 +1085,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>
> 	return 0;
> out_err:
>-	if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
>+	if (chip->ops->clk_enable != NULL)
> 		chip->ops->clk_enable(chip, false);
>
> 	tpm_tis_remove(chip);
>-- 
>1.8.3.1
>

