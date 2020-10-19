Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFD292F4E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgJSUX0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 16:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgJSUX0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 16:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603139005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nquXptd7mUtTmMVWb6gzomDEH4xtQLFBy4M311moZs=;
        b=fJWYjskgo8NZPWbHEwnG7p5VSV+8RmGtQUTCPE4ty4gkHxMDHpbtSgejhJ0x3nskJbhhVN
        90J5x/s+mXgqc8FcvS5v+X3ebcIX9PKci8b2g5gr+nGTxDWwoN9GXAFdHMdvRHtmTlAQH6
        dzA4m8H8JfX7ceduuZA3hbvGaLsVKPM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-wn5z864LNleNSzdmi0rKUQ-1; Mon, 19 Oct 2020 16:23:23 -0400
X-MC-Unique: wn5z864LNleNSzdmi0rKUQ-1
Received: by mail-qk1-f197.google.com with SMTP id g184so634115qke.3
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 13:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2nquXptd7mUtTmMVWb6gzomDEH4xtQLFBy4M311moZs=;
        b=jACdjfEgW6Dv2TMky+0YGdEaLbXLrssgaHGTxOATyIfjptHDgCPZD5lguTjEz8uSgb
         UbsMaIFCIwHtGrkS5LC6fjKnpnjaLFQ15VM6t5m95Gx1YdapOFvHtM0Rr+H+59J4sL0U
         EkA4wy8Gf9/mz8q09HjkcUzihF8Cvjqed63PNLFwYFCz/OiIvubaMgB4OqC60XITPS0Z
         Rtp07yJAD3+LUgoEPRR65I+GC83YhW9xm8JMzTyW37tq9tAed2FbxZ+2hVchBTzKUOhM
         7CUKu7AU1ohjWNXBkCyhIQTITmWXy4V1noIKV90hI0ugAD9wcak2bVU4ggkNCiyDwiaH
         LUuw==
X-Gm-Message-State: AOAM530eAliHXzkTxu5WnyBZz3uSbf3V4bAjFt+MxCP8o8H8VSVAERh2
        F4LY2p+8WmxV01Fok2g+QIt9DT4jrlo5hxaFexS9Gyo6k3Kxmfsqk/Wb90y69YWuw6o00sfohSG
        CgbYIKqYscZHhWryy32Io0wbkTW/z
X-Received: by 2002:a05:620a:844:: with SMTP id u4mr1472943qku.32.1603139003067;
        Mon, 19 Oct 2020 13:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwgrXIYaOVtpjZhEFvnyb5aWbbK14Y2qjiGJN03M3NxXsOmQldgKsHMV+es63KprOiK1Ix3Q==
X-Received: by 2002:a05:620a:844:: with SMTP id u4mr1472929qku.32.1603139002870;
        Mon, 19 Oct 2020 13:23:22 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v5sm469824qkv.89.2020.10.19.13.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:23:22 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-6-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 5/5] Revert "tpm: Revert "tpm_tis_core: Turn on the
 TPM before probing IRQ's""
In-reply-to: <20201001180925.13808-6-James.Bottomley@HansenPartnership.com>
Date:   Mon, 19 Oct 2020 13:23:18 -0700
Message-ID: <87blgyge2x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-01 11:09 MST:

> Revert the patch aa4a63dd9816 which stops interrupt probing from
> working, now that it should be safe to allow interrupt probing on all
> systems without incurring interrupt storms.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 12b657ed3a39..23b60583928b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1117,6 +1117,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  			goto out_err;
>  		}
>  
> +		tpm_chip_start(chip);
>  		if (irq) {
>  			tpm_tis_probe_irq_single(chip, IRQF_SHARED, irq);
>  			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> @@ -1128,6 +1129,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		} else {
>  			tpm_tis_probe_irq(chip);
>  		}
> +		tpm_chip_stop(chip);
>  	}
>  
>  	rc = tpm_chip_register(chip);

I know this is a revert, but should there be a commit on top of this to
move the tpm_chip_start above the tpm_get_timeouts right before this?

Regards,
Jerry

