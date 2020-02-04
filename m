Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2793A151655
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2020 08:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgBDHPx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Feb 2020 02:15:53 -0500
Received: from smtp11.infineon.com ([217.10.52.105]:32862 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgBDHPw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Feb 2020 02:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1580800551; x=1612336551;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vy6Ddq0vXz9Y5TufB3qaLwzoOVYEkADh/pF7udwUMrc=;
  b=AG37JdEOLC5NJ7mNQlt93tOsKoQHNQ7M5PUlhHrU5KjLBeb9Ly0nWdB0
   G5421JzUORjYvpYiBROXyWUI7s599G7kCItNjM3PsP8oEqwjqLrsPezCf
   uFuEj7Ujn+a/l1oI4HBj7JfN2kDOtx+diq/tbAe0NWF8OdbidLExcFHA6
   I=;
IronPort-SDR: /SGB50JXpvJZ6Nh3h1lC8eJ3ltsJLOcDg5lww6M5CbSR/k0QPZ9NNyZfLehjUho/9WjL5DtkUD
 Gnr4hB45K7dLXBii0GJfx1yeQP9Kf+SE1bcG3JxS5zyCmar/Q9WgO9/PHVcUL5yyBP4hXcdkvy
 kqpfb8cxWjJX95L6O8CqOHGK3FZ0vaSRiVmaHvkrnkP5ICh3mVvcP1Xjx1atzJJv/xYbuyQhv+
 YTx/UPnc82sSGkm65e/Db1WDDZmcgz5ATHEWo/tGCU/HuGanUW5VbWZJq0aDr6UI0VTrZ/5p6Q
 Hb4=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9520"; a="148057991"
X-IronPort-AV: E=Sophos;i="5.70,398,1574118000"; 
   d="scan'208";a="148057991"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 08:15:50 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Tue,  4 Feb 2020 08:15:50 +0100 (CET)
Received: from [10.154.32.73] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Tue, 4 Feb
 2020 08:15:49 +0100
Subject: Re: [PATCH v7 4/6] tpm: tpm_tis_spi: Support cr50 devices
To:     Stephen Boyd <swboyd@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <20190920183240.181420-5-swboyd@chromium.org>
 <007dfd87-5170-684a-26dc-9e7533d42034@infineon.com>
 <5e38bcbd.1c69fb81.a383.c572@mx.google.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <9064d7e2-d0ae-0cf0-294f-a795da336a6f@infineon.com>
Date:   Tue, 4 Feb 2020 08:15:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5e38bcbd.1c69fb81.a383.c572@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE713.infineon.com (172.23.7.71) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 04.02.2020 01:37, Stephen Boyd wrote:
> Quoting Alexander Steffen (2020-02-03 01:13:29)
>> On 20.09.2019 20:32, Stephen Boyd wrote:
>>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>>> index a01c4cab902a..c96439f11c85 100644
>>> --- a/drivers/char/tpm/Makefile
>>> +++ b/drivers/char/tpm/Makefile
>>> @@ -21,7 +21,9 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
>>>    tpm-$(CONFIG_OF) += eventlog/of.o
>>>    obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
>>>    obj-$(CONFIG_TCG_TIS) += tpm_tis.o
>>> -obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
>>> +obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
>>> +tpm_tis_spi_mod-y := tpm_tis_spi.o
>>> +tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>>>    obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>>>    obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>>>    obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
>>
>> This renames the driver module from tpm_tis_spi to tpm_tis_spi_mod, was
>> this done intentionally? When trying to upgrade the kernel, this just
>> broke my test system, since all scripts expect to be able to load
>> tpm_tis_spi, which does not exist anymore with that change.
>>
> 
> I mentioned this during the review of this patch set. I thought nobody
> would care, given that it's just a module name.
> 
> Can your scripts load the module based on something besides the module
> name? Perhaps by using device attributes instead?

The scripts are effectively using modprobe/rmmod/etc. and those need the 
name. modprobe can be fixed by defining an alias, but this does not work 
for rmmod. Many other things also depend on the name, e.g. module 
blacklisting or the output of lsmod, where people might now get confused 
by the difference between "tpm_tis_spi_mod" and "tpm_tis_i2c". Also, 
there are many tutorials out there, that explicitly tell users to run 
something like "modprobe tpm_tis_spi", which won't work anymore now.

So, if there is a good reason to break compatibility, I'm fine with 
that. But in this case, isn't there some way to achieve the desired 
functionality without changing the name? Even if it is a little more 
complex than the three-line change above, that would probably be worth it.

Alexander
