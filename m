Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555B71A64E7
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2020 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDMKEn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Apr 2020 06:04:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgDMKEl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586772279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvtpikoyRBKdoFcJ8GEU4zwmH9E/dKn5BixvwyCzFc4=;
        b=HEIfQa6HuUhQS1xHYX/Jb0FkZ/VJdeMee08X2EkEopbNJfh2TMFsNLTdg8bilmWk/QhJEz
        x4N1yMPbgAGG5HKIVeNcg66cmCTTgRN0SseX9C/H+32RwtJiEGQErJydOEC5xhRVkPK/PA
        aA+4BhMcxnq6ZIobkGNOCkG9NlonYpc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-fNEBniPSNFGQTEfVa5cKyg-1; Mon, 13 Apr 2020 06:04:38 -0400
X-MC-Unique: fNEBniPSNFGQTEfVa5cKyg-1
Received: by mail-wr1-f69.google.com with SMTP id s11so1587578wru.6
        for <linux-integrity@vger.kernel.org>; Mon, 13 Apr 2020 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvtpikoyRBKdoFcJ8GEU4zwmH9E/dKn5BixvwyCzFc4=;
        b=QzKzJg7V3I2ZONBncYDVL+zT9g5vVXxRc0qZ+nadfk0SZ6LjWM4ZvmYIRhiWolZF0t
         7cY7A6MFQkVNPt3QTJEgJmk38xWZoyiW3rBrFrLQEP+uaWNSx+U0cTT/jClPEHRzlml0
         04JvZrcStsQqru+gUl6sckSritS4A1tlnDQ8SjLw58kRF0wJarAthsK9t5VAXVi8dK8Q
         BeyuD8I7ZXuNEVLhQKnvBueMGsiAaovx4ZIU4yEA0goscGoU7iehUPibahqsPHE0P6Ep
         jg9xLJgQ9ftYQ+S/bxzOMdmvfHGsxNRJuQ5D+fGGSE9T/mLERfK3Qqvo/B8awQqMcZBP
         OdoA==
X-Gm-Message-State: AGi0PuZRhxVpLbDM42e1UjaPCEGCTAdLTXC2Lm+acikIZW0VcArJcZRT
        stPIhl7E1c6biX3e30J/rcBiH9rdy9h/kJX7OJaazIh8CnTTQvz4i7R8Ey6QOBbd08KndIYXsmL
        XGeVdM9JzA3Rgf+6NqT1xeiG/TqN3
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr17506954wrg.305.1586772277043;
        Mon, 13 Apr 2020 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypKLf/U31JZjFRkBRGJHsrPosoMp6/myT/NeT+ZxS/TXQH3VpqNomwC6Nks6u5GBINnLmnW9Sg==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr17506398wrg.305.1586772268328;
        Mon, 13 Apr 2020 03:04:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v131sm14332473wmb.19.2020.04.13.03.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 03:04:27 -0700 (PDT)
Subject: Re: [PATCH] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b909aaee-3fff-4dca-40f4-4c5348474426@redhat.com>
Date:   Mon, 13 Apr 2020 12:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 4/12/20 7:04 PM, Jarkko Sakkinen wrote:
> Call devm_free_irq() if we have to revert to polling in order not to
> unnecessarily reserve the IRQ for the life-cycle of the driver.
> 
> Cc: stable@vger.kernel.org # 4.5.x
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca031e23..ae6868e7b696 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1062,9 +1062,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>   		if (irq) {
>   			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>   						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>   				dev_err(&chip->dev, FW_BUG
>   					"TPM interrupt not working, polling instead\n");
> +				devm_free_irq(chip->dev.parent, priv->irq,
> +					      chip);
> +			}

My initial plan was actually to do something similar, but if the probe code
is actually ever fixed to work as intended again then this will lead to a
double free as then the IRQ-test path of tpm_tis_send() will have called
disable_interrupts() which already calls devm_free_irq().

You could check for chip->irq != 0 here to avoid that.

But it all is rather messy, which is why I went with the "#if 0" approach
in my patch.

Also we will currently ALWAYS hit the "TPM interrupt not working, polling instead"
error because the TPM_CHIP_FLAG_IRQ never gets set. So if we are going to do an
interim fix (and we should) we should really also silence that error.

Regards,

Hans

p.s.

I'm currently in contact with Lenovo trying to figure out what is going on
here with the always firing IRQ on the X1 8th gen, I guess the fix for that
might also help with the T490 issue.



