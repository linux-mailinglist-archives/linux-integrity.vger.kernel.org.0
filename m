Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840151FD0AA
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQPQ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQPQ0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 11:16:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD47C06174E
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 08:16:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so2774316wru.0
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2mz7VhPi60QWMA4Yhp954J2CHppq6HBliwPLxF6q0ko=;
        b=f8VMnorBNEQmOob70UHQhLW70WnwJGMe84NSTBnYjRhuXJSEE7xkJ0+J/QB95FkgvL
         wwPCBaIyUTeYCo5DIBHj+pE+yeGIX3yYhaNUHdupPXMr576tvN4kLfPSwhjFDV7OHq17
         ZroNWuxap8RQLqmwuZYrVXj/EOIuID58iRJMwzCrbUfiL16FO8UBV+mQ6XKZJArS/g0A
         aV4BBoppo+wjE4ffk0NEkEaiMlDiGWgyg3/Is9DTCpk/QTKjOqhDdb3DOmDwdeXewTIk
         61HwIGwDmhS2IaC1jvIFO9zWiA4p7LdJaVOA1J63NJc9IKEqztDlFBU0JOngFsIpneu1
         eTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mz7VhPi60QWMA4Yhp954J2CHppq6HBliwPLxF6q0ko=;
        b=WDZuAse+SjQK8dD98vZjDVwaWhfVuV1t42bNphZu5GzGmwJ8wJOqf2zmLMsIErdZhV
         WmdtEodETeziE0LixYkCjMIk5SrswOaTLd2Kl3PBSKNonJUPqJv8KxP0wd5KUJsVhu0T
         JnF3Ax5iZ79jA54+SZw3Wo2DNip8ZSc61IZAl/sGkCZsLdzxB77bRhuaWCyj/ALMrTJd
         aRGHqG4I7x68lUydXwWf/POo7q2w/KrKlHlf7XxoZBXAOobInMemJnXmkuljG/foSQaH
         iJuVTT0BfU/8aXKCbmanpBu+jAy2ys00uVcq/RaG99VZe+j4bv0kipEpY3z9BrvqGr6m
         fyXw==
X-Gm-Message-State: AOAM532b3uR/XMuiOHkjlYYRvRuwnA83zZNUC/0upO28Y+HIIzryMlZu
        J55dWw4qFminGjp1ceKN1KSQDw==
X-Google-Smtp-Source: ABdhPJybfyFSYK4bHnTGtR15Kc1uJiSCujgvo1+8jqc04NhkSV7n0xb/55m1eefCm0fS6T6nTNQgjw==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr9183781wrt.350.1592406983819;
        Wed, 17 Jun 2020 08:16:23 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:85f0:4cd7:3460:1772? ([2a01:e0a:3cb:7bb0:85f0:4cd7:3460:1772])
        by smtp.gmail.com with ESMTPSA id g3sm38262100wrb.46.2020.06.17.08.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 08:16:22 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Sumit Garg <sumit.garg@linaro.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
Date:   Wed, 17 Jun 2020 17:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/17/20 3:58 PM, Sumit Garg wrote:
> Hi Maxim,
> 
> On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>>
>> With the evolving use-cases for TEE bus, now it's required to support
>> multi-stage enumeration process. But using a simple index doesn't
>> suffice this requirement and instead leads to duplicate sysfs entries.
>> So instead switch to use more informative device UUID for sysfs entry
>> like:
>> /sys/bus/tee/devices/optee-ta-<uuid>
>>
>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>>  MAINTAINERS                                       | 1 +
>>  drivers/tee/optee/device.c                        | 9 ++++++---
>>  3 files changed, 15 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
>> new file mode 100644
>> index 000000000000..0ae04ae5374a
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
>> @@ -0,0 +1,8 @@
>> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
>> +Date:           May 2020
>> +KernelVersion   5.7
>> +Contact:        tee-dev@lists.linaro.org
>> +Description:
>> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
>> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
>> +               are free to create needed API under optee-ta-<uuid> directory.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ecc0749810b0..6717afef2de3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
>>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>>  L:     tee-dev@lists.linaro.org
>>  S:     Maintained
>> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>>  F:     drivers/tee/optee/
>>
>>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
>> index e3a148521ec1..23d264c8146e 100644
>> --- a/drivers/tee/optee/device.c
>> +++ b/drivers/tee/optee/device.c
>> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>>         return 0;
>>  }
>>
>> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>> +static int optee_register_device(const uuid_t *device_uuid)
>>  {
>>         struct tee_client_device *optee_device = NULL;
>>         int rc;
>> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>>                 return -ENOMEM;
>>
>>         optee_device->dev.bus = &tee_bus_type;
>> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
>> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
> 
> You should be using format specifier as: "%pUb" instead of "%pUl" as
> UUID representation for TAs is in big endian format. See below:

Where does device_uuid come from? If it comes directly from OP-TEE, then
it should be a pointer to the following struct:

typedef struct
{
	uint32_t timeLow;
	uint16_t timeMid;
	uint16_t timeHiAndVersion;
	uint8_t clockSeqAndNode[8];
} TEE_UUID;

(GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)

- The spec does not mandate any particular endianness and simply warns
about possible issues if secure and non-secure worlds differ in endianness.
- OP-TEE uses %pUl assuming that host order is little endian (that is
true for the Arm platforms that run OP-TEE currently). By the same logic
%pUl should be fine in the kernel.
- On the other hand, the UUID in a Trusted App header is always encoded
big endian by the Python script that signs and optionally encrypts the
TA. This should not have any visible impact on UUIDs exchanged between
the secure and non-secure world though.

So I am wondering why you had to use %pUb. There must be some
inconsistency somewhere :-/

-- 
Jerome

> 
> # ls /sys/bus/tee/devices/
> optee-ta-405b6ad9-e5c3-e321-8794-1002a5d5c61b
> optee-ta-71d950bc-c9d4-c442-82cb-343fb7f37896
> optee-ta-e70f4af0-5d1f-9b4b-abf7-619b85b4ce8c
> 
> While UUID for fTPM TA is in big endian format:
> bc50d971-d4c9-42c4-82cb-343fb7f37896
> 
> Sorry that I missed it during review and noticed this while testing.
> 
> With the above fix included, I tested this series using fTPM early TA
> on Qemu for aarch64 and used basic random number generation test using
> tpm2-tools. So feel free to add:
> 
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> 
> -Sumit
> 
>> +               kfree(optee_device);
>> +               return -ENOMEM;
>> +       }
>>         uuid_copy(&optee_device->id.uuid, device_uuid);
>>
>>         rc = device_register(&optee_device->dev);
>> @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
>>         num_devices = shm_size / sizeof(uuid_t);
>>
>>         for (idx = 0; idx < num_devices; idx++) {
>> -               rc = optee_register_device(&device_uuid[idx], idx);
>> +               rc = optee_register_device(&device_uuid[idx]);
>>                 if (rc)
>>                         goto out_shm;
>>         }
>> --
>> 2.17.1
>>
> _______________________________________________
> Tee-dev mailing list
> Tee-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/tee-dev
> 
