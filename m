Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED6E1E3A
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbfJWOdG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 10:33:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52253 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389995AbfJWOdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 10:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571841185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9FDFoHcmgbf/rB6O0Qmk/JMn+xRjY/O6Q1p5vtdLWM=;
        b=Y5x04JPmJPj+fGqQo/XZ1vVxFO1fe7ygNOiWQ57LxtCXatiKm3uRRCBqSetubQGBJOKrcK
        ZC2Zc+OBKX3cLqhh02pOOxKutpAOO8QwdvtlFbeft8+KfuMp1/bSgj2vLLHmFliICnkJxN
        xIfgF+AOVSzdud0Vko7oXgAb8Q+KLuM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-XTzVT9qOMomZYyWvOcq2sA-1; Wed, 23 Oct 2019 10:33:00 -0400
Received: by mail-wr1-f71.google.com with SMTP id s9so11029158wrw.23
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 07:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPvbzDgItD/bWiYqRGisyJX9TAo/xg2jsbmqa+lT5LM=;
        b=k7oHCtQsYQHDwsQFS0dZmK4Kr+ilfLY/y5ZP3GwiaFiygihyS3UchiUxeVE9Jpb7yp
         xb9On5I/8rv5f7OF7Kn7GBMjTgGoTeaIxP/6DBGeaXAOy6kLPbLLklNlOAcEG8K6Wv6a
         P3igIWr4UMDyuVIzX+JfZm5MZ61Q5LHe0w2QzlWVO2MhMoHDxPRn0M6KyIT1he8tMBgm
         bahC1nd21L2O8ykFzTHpP4MvWHur0KAoyqKJSwZdSm0OkOEAcrJA9HjCgYtA+kb7De01
         zv3njsqLqVHSmjKBinGDU/meymbiU9mWnVxmZ1V3jqDwsAfh5omKvx8Vqrpb/XCgcHsL
         sxcA==
X-Gm-Message-State: APjAAAV3nR4ToUfVm9i0kxM/sXTO+BH7jEfj4Tn+7OTiaDtGCVe2oX1P
        06kZpHThvrDk5Auc9Ci5a9bx3+2ordyCqlDOCSIWXBnjL9VJG9fxvAn9poDdPHWnW8mvNOutdja
        fqBHqT7y3fvCtqAMbaPUbkXFZR9UC
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr183500wmc.35.1571841179349;
        Wed, 23 Oct 2019 07:32:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyX8MnNcDcpNCRYNfu2+e6XVpRe7VhTgXdRCq+1JhMu0WmB6JvqAnshI5/zuFMWI5Ijby48+A==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr183489wmc.35.1571841179158;
        Wed, 23 Oct 2019 07:32:59 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id o1sm18477324wmc.38.2019.10.23.07.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:32:58 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6adeb21-f7b3-5c64-fa32-03a8ee21cc53@redhat.com>
Date:   Wed, 23 Oct 2019 16:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023113733.GB21973@linux.intel.com>
Content-Language: en-US
X-MC-Unique: XTzVT9qOMomZYyWvOcq2sA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 23-10-2019 13:37, Jarkko Sakkinen wrote:
> On Mon, Oct 21, 2019 at 05:56:56PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 21-10-2019 17:49, Jarkko Sakkinen wrote:
>>> On Sat, Oct 19, 2019 at 11:45:28AM +0200, Hans de Goede wrote:
>>>> Since commit 7723f4c5ecdb ("driver core: platform: Add an error messag=
e to
>>>> platform_get_irq*()"), platform_get_irq() will call dev_err() on an er=
ror,
>>>> as the IRQ usage in the tpm_tis driver is optional, this is undesirabl=
e.
>>>>
>>>> Specifically this leads to this new false-positive error being logged:
>>>> [    5.135413] tpm_tis MSFT0101:00: IRQ index 0 not found
>>>>
>>>> This commit switches to platform_get_irq_optional(), which does not lo=
g
>>>> an error, fixing this.
>>>>
>>>> Cc: <stable@vger.kernel.org> # 5.4.x
>>>
>>> Incorrect format (should be wo '<' and '>').
>>
>> According to:
>>
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>
>> the '<' and '>' should be added when adding a # <kerner>
>=20
> OK, right so it was. This first patch that I'm reviewing with such
> commit.
>=20
>>> Also, not sure why this should be backported to stable kernel anyway.
>>
>> Because false-positive error messages are bad and cause users to
>> file false-positive bug-reports.
>=20
> Neither categorizes into a regression albeit being unfortunate
> glitches.

The stable series also does other small fixes, such as adding new
pci/usb-ids, etc. This clearly falls within this. IMHO ideally this
should go to a 5.4-rc# making the whole discussion moot, but since
I was afraid it would not make 5.4, I added the Cc: stable.

Regards,

Hans

