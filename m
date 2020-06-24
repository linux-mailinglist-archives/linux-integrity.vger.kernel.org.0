Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7288C2077D2
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 17:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404415AbgFXPot (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404409AbgFXPot (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 11:44:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83E8C0613ED
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 08:44:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so2980340wmt.4
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2020 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RdI5M2Ilrl2+vmVMHIIBNrAs2nh4Sr2me7AQbdHn46E=;
        b=xd3x1HFCw2Tw5G4YgrI4TEYRwKzSJNBM6wmdSVA59txdEtkxfpSh5Ae8sTkuZv4W29
         S0A2N+Or30SSf0tpzHGNDqoHW9UdEiI2cTJN+lJUH+s4joj1eMlVveNe2kM5G62ZUJFa
         lyb33MpXtlCg3IO5J280SNnMcWaTuVokSgsxZ2KDfdWMHhT0sbpTdMV2MQGhQIKZJ2K7
         rKgfM9909WBaJESSWPDW3XGocUYN2QZPW6legItJmQvjK9f/rqDrUdI4uOEYRHsFmpCE
         FtfAVUBj3Qpn9SiLDy3nDKQkaaZ92bVzSRyfanSydG8rjZbp5EeTZEklrcrzGVNgqFdp
         swFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RdI5M2Ilrl2+vmVMHIIBNrAs2nh4Sr2me7AQbdHn46E=;
        b=uas/e86BTcXTb1HPb5CquP7CnxXwD2S9hXkV7TzrzCkcXKfm3jer8Y0+b/w9uDvTma
         qo/RaQaaRR1gJRiNX8aYE3RPXgjuB9iqnal2SouU//6Elgrkm3FiiLklhy5lD1ZfjnPV
         Uat0PI13ldDZ1LvMXGazKVvBYmA61scyS4+ouKG9SmyW/C8bkA6GQYh5L5U+/3occLcZ
         4Rg9AbbPme3GE6l5Dmm9e7khkvVGqRXZMhlUNouO7YjfyAZj6aSPfPbN00JoXR5oniVh
         m4YFAXOOstOsfOykCqUgjmsyc6hHnpxTjwioOgRBmAs/7JPPYFyNsUpFnvR3AIyKnx4w
         vl3Q==
X-Gm-Message-State: AOAM532KeuSa555zvKKVIXmRYnqOY6HKEYkBs8MERq6OTcYp3y/z8sLj
        UQQK60F9EhIjiyba1fRdhT3ZOQ==
X-Google-Smtp-Source: ABdhPJxXnUB7GBcjHzRLLlk+/5eb2yu9/Ebs/uXxHVrBfcmv8vemV/0WlbECWnp7rV+861ObPrN0hw==
X-Received: by 2002:a1c:9d56:: with SMTP id g83mr15935541wme.130.1593013487525;
        Wed, 24 Jun 2020 08:44:47 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:bd12:acc9:5374:bd9b? ([2a01:e0a:3cb:7bb0:bd12:acc9:5374:bd9b])
        by smtp.gmail.com with ESMTPSA id n189sm8495216wmb.43.2020.06.24.08.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:44:46 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
 <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com>
 <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com>
 <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <3aa8705a-0342-25ea-00c4-d5370d91ddb4@forissier.org>
Date:   Wed, 24 Jun 2020 17:44:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593012069.28403.11.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/24/20 5:21 PM, James Bottomley wrote:
> On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
>> Apologies for delay in my reply as I was busy with some other stuff.
>>
>> On Fri, 19 Jun 2020 at 20:30, James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
> [...]
>>> it's about consistency with what the kernel types mean.  When some
>>> checker detects your using little endian operations on a big endian
>>> structure (like in the prink for instance) they're going to keep
>>> emailing you about it.
>>
>> As mentioned above, using different terminology is meant to cause
>> more confusion than just difference in endianness which is manageable
>> inside TEE.
>>
>> And I think it's safe to say that the kernel implements UUID in big
>> endian format and thus uses %pUb whereas OP-TEE implements UUID in
>> little endian format and thus uses %pUl.
> 
> So what I think you're saying is that if we still had uuid_be and
> uuid_le you'd use uuid_le, because that's exactly the structure
> described in the docs.  But because we renamed
> 
> uuid_be -> uuid_t
> uuid_le -> guid_t
> 
> You can't use guid_t as a kernel type because it has the wrong name?

Let me try to clear the confusion that I introduce myself I believe :-/
IMO:

- optee_register_device(const uuid_t *device_uuid) *is* the correct
prototype.
- device_uuid is *guaranteed* to be BE because OP-TEE makes this
guarantee (it converts from its internal LE representation to BE when
enumerating the devices, but it doesn't matter to the kernel).
- Therefore %pUb is the correct format.

I'm sorry for doubting the BE order initially. I am so used to OP-TEE
using LE internally, that I missed the fact that we have an explicit
conversion...

Does this sound good?

Thanks,
-- 
Jerome
