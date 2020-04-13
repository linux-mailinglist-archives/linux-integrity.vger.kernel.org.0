Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C11A6BF0
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2020 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgDMSLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Apr 2020 14:11:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387657AbgDMSLV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Apr 2020 14:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586801480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNPtJ8c/6eKA9KomFbmLXvT7+P5Oxb4zf/a4YOxSAA0=;
        b=H1PM/6A46s2nFYLpcEwWMBv4UrzcZwM9wXqojZRHlqOFmYfzs87J52kWB3+0A10s9mBnyS
        7sIqH6PzWFWkkoxBZGdqZTy2yrx87z8L+CIgOQj7VBXZvxyEYOaQqzlDaFEE+76flMqVw+
        H/LIEqpYcdv3XiSTmlqjJxQtrYEw7T8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-029MtEJjOgmrrAUWQHrdvA-1; Mon, 13 Apr 2020 14:11:18 -0400
X-MC-Unique: 029MtEJjOgmrrAUWQHrdvA-1
Received: by mail-wr1-f72.google.com with SMTP id j16so6446305wrw.20
        for <linux-integrity@vger.kernel.org>; Mon, 13 Apr 2020 11:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JNPtJ8c/6eKA9KomFbmLXvT7+P5Oxb4zf/a4YOxSAA0=;
        b=ITgRrR7hZjWSd/a6BcewL+zaS0FqvwOQqUBynzqLQ5A0c4cLDWzL4AbJm6szhbbIaq
         SARWWnJLZmjlRgBReggikyFmxNpXqvuGqzOXKeyO6KNJUADUEi9KWm9kl5rqlNjUltHZ
         lE6VMbVCvsa85P2ZOV9Tm6jHX1c/QfS+WAf1yEYlUD1oGnyDFal6ati6/S+HMKavA2y9
         b4iJ4bY6m5zPpWkGSZaZl3RZ+cahi+BozLwjKJhKWx0sM2zhXhV39xPWeMnqcB4xKUHI
         lJ8Yrge4ouoC/2XiiGrtmSA168VRVYr95iehSkrc0YqDGG14olLUwAplPifLR2fwOryK
         IWJw==
X-Gm-Message-State: AGi0PuZ2PY8i72NAvkkYYxEe5uxwxqVYwMFS5ZhE+VQwXx04hnkByMXT
        UglK2+KTQPnCQ5x/GO1B44BtSUX7Ii5sBwD0/2DngdhwAlYHaPZhBuxv3jtiV48DJNn5aa+VxV8
        BzN1Q5u9RaNOGPOEnYl+fjmeBH4Ac
X-Received: by 2002:a5d:400f:: with SMTP id n15mr19758043wrp.344.1586801476918;
        Mon, 13 Apr 2020 11:11:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEWIf8yN5ITV/kXEWxKi8eoPvVfgHAhrsr1nqOLbuFlRfLczNT6LewjXD8xCJdaxf1ANDKoQ==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr19758023wrp.344.1586801476691;
        Mon, 13 Apr 2020 11:11:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 74sm2584923wrk.30.2020.04.13.11.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 11:11:15 -0700 (PDT)
Subject: Re: [PATCH] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
 <b909aaee-3fff-4dca-40f4-4c5348474426@redhat.com>
 <20200413180732.GA11147@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7df7f8bd-c65e-1435-7e82-b9f4ecd729de@redhat.com>
Date:   Mon, 13 Apr 2020 20:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200413180732.GA11147@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 4/13/20 8:07 PM, Jarkko Sakkinen wrote:
> On Mon, Apr 13, 2020 at 12:04:25PM +0200, Hans de Goede wrote:
>> Hi Jarkko,
>>
>> On 4/12/20 7:04 PM, Jarkko Sakkinen wrote:
>>> Call devm_free_irq() if we have to revert to polling in order not to
>>> unnecessarily reserve the IRQ for the life-cycle of the driver.
>>>
>>> Cc: stable@vger.kernel.org # 4.5.x
>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>> ---
>>>    drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>>> index 27c6ca031e23..ae6868e7b696 100644
>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -1062,9 +1062,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>>    		if (irq) {
>>>    			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>>>    						 irq);
>>> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>>> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>>>    				dev_err(&chip->dev, FW_BUG
>>>    					"TPM interrupt not working, polling instead\n");
>>> +				devm_free_irq(chip->dev.parent, priv->irq,
>>> +					      chip);
>>> +			}
>>
>> My initial plan was actually to do something similar, but if the probe code
>> is actually ever fixed to work as intended again then this will lead to a
>> double free as then the IRQ-test path of tpm_tis_send() will have called
>> disable_interrupts() which already calls devm_free_irq().
>>
>> You could check for chip->irq != 0 here to avoid that.
>>
>> But it all is rather messy, which is why I went with the "#if 0" approach
>> in my patch.
> 
> I think it is right way to fix it. It is a bug independent of the issue
> we are experiencing.
> 
> However, what you are suggesting should be done in addition. Do you have
> a patch in place or do you want me to refine mine?

I do not have a patch ready for this, if you can refine yours that would
be great.

Regards,

Hans

