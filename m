Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25B1FD652
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 22:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFQUpv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFQUpu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 16:45:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20922C061755
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 13:45:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so3834564wro.1
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CC1FZuN8GKEyqP8tfmN2FxTypseeTWNCAbqO6YR2YeA=;
        b=u99M3iIrJU7oxmpu/qd8O9ZQeW6S1t6xlKSMXqx92AfmhkjLm6PfFGzxYUqykKJ3GP
         TZX/BFwqDik8RgBft4w8F+EHfgcqPpHAlmZ1ZEENit8EmbOHMtGnQcpadzbxR1sgAldL
         ZYQLIy5FiH+UJATDUD285gQpNYN29hZfvUe5uTCBWn9MY0x+uZSDTGiRvxNTqVnhHA2C
         GrjlR+6fccWTcoa/mJXQT79/56EnkWufUB1TeNPEtZzjMzTHOfjenvhoKICE1FTgNTzu
         6CDXic+uAh5NfM83tArePUYC3eRmqgAgtV92KJayPzXFSJQJyNo09iiaAQQVCzyj1Wmg
         lQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CC1FZuN8GKEyqP8tfmN2FxTypseeTWNCAbqO6YR2YeA=;
        b=enKaPCHKYe6ZwzGfJKmV1PI35aiuglq0/eIfwUfmLOCnzcCwfGrjGQZ0GagyJT58tv
         BxQHVbE6XyTiAnczuioz5YsJ65wC7SuXRx+8z/z919icd9usDSwr6etTAFNdysR+VLxD
         l3eSthFRepOdpT2/hRE+jRH9zUqknWEiocPsOVU24W+1Bk9aQYBAPj+Xx7V1Bp2Q2iKa
         ItLkSSgQJLC0D/Ukls6HDfqKCKfycVTgLRU2TTYjwPOeGVvd2uX1Ym/qh+M9QOHTq0ri
         keegSYqS5Lh7s54Ms4xsn1AfYEHTGN1lqmZePfp5dJYivFL5ODNj3DdS9E83gbqR/7Te
         1b4w==
X-Gm-Message-State: AOAM530JDu2M1ubT6WVlmrQgCdJBP4wHgd6NAXpm4yvh4Sf7klV6vH0v
        Jo5etBa+1krqLIE/nrNJeY7BTA==
X-Google-Smtp-Source: ABdhPJyYVCB2oHgjvDH9vsV2KGiO3QfQy2GHTZVzh8TncSECgXpwsfydi+zrr7ZtLHOCDOOjWQj42Q==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr991000wrs.87.1592426748679;
        Wed, 17 Jun 2020 13:45:48 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:85f0:4cd7:3460:1772? ([2a01:e0a:3cb:7bb0:85f0:4cd7:3460:1772])
        by smtp.gmail.com with ESMTPSA id l1sm796154wrb.31.2020.06.17.13.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 13:45:47 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
 <CAD8XO3bSsgeWjB7SxwR9+=h1PiGeNwCo1UM66-poruRu846L2g@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <f3131cf1-d2a5-60df-fa3c-0613fd8f416c@forissier.org>
Date:   Wed, 17 Jun 2020 22:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAD8XO3bSsgeWjB7SxwR9+=h1PiGeNwCo1UM66-poruRu846L2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/17/20 9:52 PM, Maxim Uvarov wrote:
> On Wed, 17 Jun 2020 at 18:16, Jerome Forissier <jerome@forissier.org> wrote:
>>
>> On 6/17/20 3:58 PM, Sumit Garg wrote:
>>> Hi Maxim,
>>>
>>> On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>>>>
>>>> With the evolving use-cases for TEE bus, now it's required to support
>>>> multi-stage enumeration process. But using a simple index doesn't
>>>> suffice this requirement and instead leads to duplicate sysfs entries.
>>>> So instead switch to use more informative device UUID for sysfs entry
>>>> like:
>>>> /sys/bus/tee/devices/optee-ta-<uuid>
>>>>
>>>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>>>>  MAINTAINERS                                       | 1 +
>>>>  drivers/tee/optee/device.c                        | 9 ++++++---
>>>>  3 files changed, 15 insertions(+), 3 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
>>>> new file mode 100644
>>>> index 000000000000..0ae04ae5374a
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
>>>> @@ -0,0 +1,8 @@
>>>> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
>>>> +Date:           May 2020
>>>> +KernelVersion   5.7
>>>> +Contact:        tee-dev@lists.linaro.org
>>>> +Description:
>>>> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
>>>> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
>>>> +               are free to create needed API under optee-ta-<uuid> directory.
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index ecc0749810b0..6717afef2de3 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
>>>>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>>>>  L:     tee-dev@lists.linaro.org
>>>>  S:     Maintained
>>>> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>>>>  F:     drivers/tee/optee/
>>>>
>>>>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
>>>> index e3a148521ec1..23d264c8146e 100644
>>>> --- a/drivers/tee/optee/device.c
>>>> +++ b/drivers/tee/optee/device.c
>>>> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>>>>         return 0;
>>>>  }
>>>>
>>>> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>>>> +static int optee_register_device(const uuid_t *device_uuid)
>>>>  {
>>>>         struct tee_client_device *optee_device = NULL;
>>>>         int rc;
>>>> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>>>>                 return -ENOMEM;
>>>>
>>>>         optee_device->dev.bus = &tee_bus_type;
>>>> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
>>>> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
>>>
>>> You should be using format specifier as: "%pUb" instead of "%pUl" as
>>> UUID representation for TAs is in big endian format. See below:
>>
>> Where does device_uuid come from? If it comes directly from OP-TEE, then
>> it should be a pointer to the following struct:
>>
>> typedef struct
>> {
>>         uint32_t timeLow;
>>         uint16_t timeMid;
>>         uint16_t timeHiAndVersion;
>>         uint8_t clockSeqAndNode[8];
>> } TEE_UUID;
>>
>> (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
>>
>> - The spec does not mandate any particular endianness and simply warns
>> about possible issues if secure and non-secure worlds differ in endianness.
>> - OP-TEE uses %pUl assuming that host order is little endian (that is
>> true for the Arm platforms that run OP-TEE currently). By the same logic
>> %pUl should be fine in the kernel.
>> - On the other hand, the UUID in a Trusted App header is always encoded
>> big endian by the Python script that signs and optionally encrypts the
>> TA. This should not have any visible impact on UUIDs exchanged between
>> the secure and non-secure world though.
>>
>> So I am wondering why you had to use %pUb. There must be some
>> inconsistency somewhere :-/
>>
>> --
>> Jerome
> 
> From  linux side it is for example:
> 
> static const struct tee_client_device_id optee_ftpm_id_table[] = {
>         {UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
>                    0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
>         {}
> };
> 
> static struct tee_client_driver ftpm_tee_driver = {
>         .id_table       = optee_ftpm_id_table,
>         .driver         = {
> 
> So sysfs name has to be the same as the driver has. And  UUD is simple
> 16 bytes:#define UUID_SIZE 16
> typedef struct {
>         __u8 b[UUID_SIZE];
> } uuid_t;
> 
> From TA it also:
> #define TA_UUID  { 0xBC50D971, 0xD4C9, 0x42C4, \
>         {0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96}}
> 
> Compare uuid from optee and kernel driver version is simple:
> static inline bool uuid_equal(const uuid_t *u1, const uuid_t *u2)
> {
>         return memcmp(u1, u2, sizeof(uuid_t)) == 0;
> }
> 
> So to support better code navigation. For example grep sources for
> 0xBC50D971, or find in sysfs  "*bc50d971-*" I would say we need to use
> BE format.
> optee might also need to switch to BE prints for the same reason.


Sorry but this does not make much sense to me :-/

All I want to say is, if you ever need to use %pUb for things to work as
expected then it is *very* suspect and you should try to understand why,
because as I said and as far as I can tell OP-TEE stores all it's UUIDs
in memory in little endian format (more precisely, host endian with all
platforms being little endian currently), and %pUb is not even
implemented in OP-TEE.

-- 
Jerome
