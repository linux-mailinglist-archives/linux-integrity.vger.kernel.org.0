Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9499DE46CA
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407276AbfJYJN1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 05:13:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407267AbfJYJN1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 05:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571994805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8kTKOAL5Zf1cb0HHGCjRwTQepKyx2gB/Um98RUXNYE=;
        b=W0gadjJW4WleF+WdVZRJpnvMtGdc60kSmMnJEta2Oy+KyQHwYLCIb6OAgVA+MQrhF5Sip5
        GEWO83X0BI2o/2mhcC1C++D6Td7wfYnWxLq7dGJtqeRUI5XKFnVXmN2sDepSEH+4A5vGZB
        2ab6Nb5QGCaaCOIHdnvJ1DNGxeYk87s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-aUftO9AtOAeDFofAZ9_BRA-1; Fri, 25 Oct 2019 05:13:24 -0400
Received: by mail-wr1-f70.google.com with SMTP id f4so699429wrj.12
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 02:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cIFLRDg4RTpJtwwpTET/w12otAP54G/Khjjpdq6rDXk=;
        b=YOtanRnSNISfVHbyjgpd0bFSLcIdAQtMlJwEx/hGw8hSUg/G9raHW7s9xQFKMyPLGz
         ZaytfspBKpRe6f4unSMpJ2j9EDWt7b4stluMySjBKbYuA04RJPjhZzTdGsfnWifH8xss
         36KxCMm3QgiYn0R7X+c9yR+vMzXS/DW36VcmR13RdalfEWTu6bHZqli0AaypJtrWTEos
         FNKU3ELHc6FNJPVW5NHflccMiwAc2gIf514VpUGSZ1UV3zfbKB+iOArUMR8tEoAcnMPm
         12X1zehX58c9ONlOhrwtRjSkN6EQjaGKUaArFApFRE25uxg9LT/FVr/qLs/9ft9UUUS7
         UHOw==
X-Gm-Message-State: APjAAAVnPWNS1jkdHNtLBIPFtTU9UjEA//EPI1xNT9mOTW0KVw3OBbXP
        QwlVNnnFqv7ew9hBI38TRX3xp0QFcW/1QuLr7cJ2N9RdA/TB9JWwzkk06ZjOH9cwv4JiPdFmt+2
        Iv8Oc/jTLAgBzxrWo95D7X6DSOByt
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr2606388wmc.177.1571994803121;
        Fri, 25 Oct 2019 02:13:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfa+TMnJooGBD4ydGJ1OSiKJeuDw5HpDJ5gEbgIffpwvVQINlCXkKxRR+QDMxHHY8Rlr0xMA==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr2606366wmc.177.1571994802862;
        Fri, 25 Oct 2019 02:13:22 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id f204sm1909871wmf.32.2019.10.25.02.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:13:22 -0700 (PDT)
Subject: Re: [PATCH] tpm: Switch to platform_get_irq_optional()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org
References: <20191019094528.27850-1-hdegoede@redhat.com>
 <20191021154942.GB4525@linux.intel.com>
 <80409d36-53fa-d159-d864-51b8495dc306@redhat.com>
 <20191023113733.GB21973@linux.intel.com>
 <d6adeb21-f7b3-5c64-fa32-03a8ee21cc53@redhat.com>
 <20191024142519.GA3881@linux.intel.com>
 <c6a0c3e3-c5c8-80d9-b6b6-bf45d66f4b32@redhat.com>
 <20191024190942.GA12038@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e381d14-0258-5804-59f0-43a299570942@redhat.com>
Date:   Fri, 25 Oct 2019 11:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024190942.GA12038@linux.intel.com>
Content-Language: en-US
X-MC-Unique: aUftO9AtOAeDFofAZ9_BRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 24-10-2019 21:09, Jarkko Sakkinen wrote:
> On Thu, Oct 24, 2019 at 04:27:24PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 24-10-2019 16:25, Jarkko Sakkinen wrote:
>>> On Wed, Oct 23, 2019 at 04:32:57PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 23-10-2019 13:37, Jarkko Sakkinen wrote:
>>>>> On Mon, Oct 21, 2019 at 05:56:56PM +0200, Hans de Goede wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 21-10-2019 17:49, Jarkko Sakkinen wrote:
>>>>>>> On Sat, Oct 19, 2019 at 11:45:28AM +0200, Hans de Goede wrote:
>>>>>>>> Since commit 7723f4c5ecdb ("driver core: platform: Add an error me=
ssage to
>>>>>>>> platform_get_irq*()"), platform_get_irq() will call dev_err() on a=
n error,
>>>>>>>> as the IRQ usage in the tpm_tis driver is optional, this is undesi=
rable.
>>>>>>>>
>>>>>>>> Specifically this leads to this new false-positive error being log=
ged:
>>>>>>>> [    5.135413] tpm_tis MSFT0101:00: IRQ index 0 not found
>>>>>>>>
>>>>>>>> This commit switches to platform_get_irq_optional(), which does no=
t log
>>>>>>>> an error, fixing this.
>>>>>>>>
>>>>>>>> Cc: <stable@vger.kernel.org> # 5.4.x
>>>>>>>
>>>>>>> Incorrect format (should be wo '<' and '>').
>>>>>>
>>>>>> According to:
>>>>>>
>>>>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.h=
tml
>>>>>>
>>>>>> the '<' and '>' should be added when adding a # <kerner>
>>>>>
>>>>> OK, right so it was. This first patch that I'm reviewing with such
>>>>> commit.
>>>>>
>>>>>>> Also, not sure why this should be backported to stable kernel anywa=
y.
>>>>>>
>>>>>> Because false-positive error messages are bad and cause users to
>>>>>> file false-positive bug-reports.
>>>>>
>>>>> Neither categorizes into a regression albeit being unfortunate
>>>>> glitches.
>>>>
>>>> The stable series also does other small fixes, such as adding new
>>>> pci/usb-ids, etc. This clearly falls within this. IMHO ideally this
>>>> should go to a 5.4-rc# making the whole discussion moot, but since
>>>> I was afraid it would not make 5.4, I added the Cc: stable.
>>>
>>> I get adding PCI/USB id as it extends the hardware support for the
>>> stable kernel without risking its stability. This patch is factors
>>> less useful.
>>
>> It also has about 0% chance of causing regressions and it does
>> help to avoid false--positive bug reports.
>>
>> TBH I'm quite surprised we are even having this discussion...
>>
>> Regards,
>>
>> Hans
>=20
> Why do you think that way?
>=20
> I mean the commit does not even have a fixes line. It already obviously
> implies that this kind of discussion is mandatory. Your reasoning in
> this discussion does make sense. The problem is really the commit
> message supplied.
>=20
> I'd guess something like this would be more appropriate:
>=20
> "
> platform_get_irq() calls dev_err() on an error. As the IRQ usage in the
> tpm_tis driver is optional, this is undesirable.
>=20
> Specifically this leads to this new false-positive error being logged:
> [    5.135413] tpm_tis MSFT0101:00: IRQ index 0 not found
>=20
> This commit switches to platform_get_irq_optional(), which does not log
> an error, fixing this.
>=20
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to plat=
form_get_irq*()"
> Cc: <stable@vger.kernel.org> # 5.4.x
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> "
>=20
> You should confirm this by sending v2 either what I proposed unmodified
> or with the changes that you see appropriate.

Ok, this is fine with me, I will send v2 with the updated commit msg right =
away.

Regards,

Hans

