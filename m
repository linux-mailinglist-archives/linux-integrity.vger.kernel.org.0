Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618321A7602
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 10:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436779AbgDNI0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 04:26:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58693 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436778AbgDNI0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 04:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586852797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b37d0Kofi4/XRxv8UfpXOdTiWurzTmejZQ30rVyez0k=;
        b=TUkQnnDjgOmJnazrTSIQT0xQRnTvanGMePu5abIBTADazEtgbWV0j+6h3j9Rza46vrFdL+
        Nh0cCkqO9T/bMikMsB78lTy0PnhGZ1AdCppfpZhz6W3My70R0WEmy8V7ZqpgRnW96+WUhj
        V3h600e8n0mqYYX55Ok62F4EJmy62xk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-pYXW25kqMeyW-WHez_mE-g-1; Tue, 14 Apr 2020 04:26:36 -0400
X-MC-Unique: pYXW25kqMeyW-WHez_mE-g-1
Received: by mail-wm1-f70.google.com with SMTP id b203so3473410wmd.6
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 01:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b37d0Kofi4/XRxv8UfpXOdTiWurzTmejZQ30rVyez0k=;
        b=sSDKQQJSoWhJYDokdWptsKMUJGi9OoWpkQMBu3FUibXqenQ8DcUgIQXlrgP5tjdbzL
         kqWKFyBiHL1XH+K2GYNClu+09d0VzjVEW2XD16C8J7ilyTrC0K7YPkH7QhWoPLPthiKH
         TvlhY7OnFxtBHwfUYsEfSHyI5KUVxQrKOaYUEi//ubodQvnJ3wkPl5vRf8O5zytTqDxx
         u40/Z7byIQNrwz1hreUH4b+cEzIWoZyeqghNVIug8rfGVClmikaRsebLaYSRWZpUjvKu
         bwB2aG9miNX6RKzNPmuhOOlmDvNsdTl3lOTjTT8/UTTTrpOYymh/ctWKm6j8athxqjg4
         ZYSw==
X-Gm-Message-State: AGi0PuakarYKIQvl5ZhWoS5UIHQAUlpStDMiJOWJynCKJHD8CYuWbY0Y
        z+e2SqepmKEBOglSIe53QKXzFmGqqy0BHcDYokOiwUFju2EGrZvuiMdd7ogOH2K//bKeiS1K51e
        xGzIwzoU3FpjUDmPILRqI43CXa+x0
X-Received: by 2002:a7b:c401:: with SMTP id k1mr21977049wmi.152.1586852795048;
        Tue, 14 Apr 2020 01:26:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLloBOUIuHphP4FqubsTTF9OSa00IedmMyDWrhWDWdhrct7ws2/aUFRcsoLOb+NPUJGjePVw==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr21976977wmi.152.1586852793854;
        Tue, 14 Apr 2020 01:26:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y7sm18913048wmb.43.2020.04.14.01.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 01:26:33 -0700 (PDT)
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
 <7df7f8bd-c65e-1435-7e82-b9f4ecd729de@redhat.com>
 <20200414071349.GA8403@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6684575-ce91-fe72-6035-11834a05cd54@redhat.com>
Date:   Tue, 14 Apr 2020 10:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414071349.GA8403@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 4/14/20 9:13 AM, Jarkko Sakkinen wrote:
> On Mon, Apr 13, 2020 at 08:11:15PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/13/20 8:07 PM, Jarkko Sakkinen wrote:
>>> On Mon, Apr 13, 2020 at 12:04:25PM +0200, Hans de Goede wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 4/12/20 7:04 PM, Jarkko Sakkinen wrote:
>>>>> Call devm_free_irq() if we have to revert to polling in order not to
>>>>> unnecessarily reserve the IRQ for the life-cycle of the driver.
>>>>>
>>>>> Cc: stable@vger.kernel.org # 4.5.x
>>>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>>>> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>>>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>> ---
>>>>>     drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>>>>> index 27c6ca031e23..ae6868e7b696 100644
>>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>>> @@ -1062,9 +1062,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>>>>     		if (irq) {
>>>>>     			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>>>>>     						 irq);
>>>>> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>>>>> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>>>>>     				dev_err(&chip->dev, FW_BUG
>>>>>     					"TPM interrupt not working, polling instead\n");
>>>>> +				devm_free_irq(chip->dev.parent, priv->irq,
>>>>> +					      chip);
>>>>> +			}
>>>>
>>>> My initial plan was actually to do something similar, but if the probe code
>>>> is actually ever fixed to work as intended again then this will lead to a
>>>> double free as then the IRQ-test path of tpm_tis_send() will have called
>>>> disable_interrupts() which already calls devm_free_irq().
>>>>
>>>> You could check for chip->irq != 0 here to avoid that.

Erm in case you haven't figured it out yet this should be priv->irq != 0, sorry.

>>>>
>>>> But it all is rather messy, which is why I went with the "#if 0" approach
>>>> in my patch.
>>>
>>> I think it is right way to fix it. It is a bug independent of the issue
>>> we are experiencing.
>>>
>>> However, what you are suggesting should be done in addition. Do you have
>>> a patch in place or do you want me to refine mine?
>>
>> I do not have a patch ready for this, if you can refine yours that would
>> be great.
> 
> Thanks! Just wanted to confirm.

And thank you for working on a (temporary?) fix for this.

Regards,

Hans

