Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C598A376EF2
	for <lists+linux-integrity@lfdr.de>; Sat,  8 May 2021 04:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhEHCsi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 22:48:38 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54334 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhEHCsi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 22:48:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UY6R0Rz_1620442055;
Received: from 30.225.35.234(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UY6R0Rz_1620442055)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 10:47:36 +0800
Subject: Re: [PATCH] tpm_tis_spi: set default probe function if device id not
 match
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210507145255.44033-1-zhangliguang@linux.alibaba.com>
 <YJXxDzougt3ZC01q@kernel.org>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <e74fd54f-1700-4b06-a320-c0e257666565@linux.alibaba.com>
Date:   Sat, 8 May 2021 10:46:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJXxDzougt3ZC01q@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

在 2021/5/8 10:01, Jarkko Sakkinen 写道:
> On Fri, May 07, 2021 at 10:52:55PM +0800, Liguang Zhang wrote:
>> In DSDT table, TPM _CID was SMO0768, and no _HID definition. After a
>> kernel upgrade from 4.19 to 5.10, TPM probe function was changed which
>> causes device probe fails. In order to make newer kernel to be
>> compatible with the older acpi definition, it would be best set default
>> probe function.
>>
>> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
>> ---
>>   drivers/char/tpm/tpm_tis_spi_main.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>> index 3856f6ebcb34..da632a582621 100644
>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>> @@ -240,10 +240,14 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
>>   	tpm_tis_spi_probe_func probe_func;
>>   
>>   	probe_func = of_device_get_match_data(&spi->dev);
>> -	if (!probe_func && spi_dev_id)
>> -		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
>> -	if (!probe_func)
>> -		return -ENODEV;
>> +	if (!probe_func) {
>> +		if (spi_dev_id) {
>> +			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
>> +			if (!probe_func)
>> +				return -ENODEV;
> Perhaps also hear fallback to tpm_tis_spi_probe?


Yes, I do not think of a good way. Do you have any suggestions?


The arm platform is  kunpeng-920, detail dsdt information here:

         Device (SPI0)
         {
             Name (_HID, "HISI0173")  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, Zero)  // _UID: Unique ID
             Name (RBUF, ResourceTemplate ()
             {
                 GpioIo (Exclusive, PullUp, 0x0000, 0x0000, 
IoRestrictionNone,
                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                     )
                     {   // Pin list
                         0x0006
                     }
                 QWordMemory (ResourceConsumer, PosDecode, MinFixed, 
MaxFixed, NonCacheable, ReadWrite,
                     0x0000000000000000, // Granularity
                     0x00000002011A0000, // Range Minimum
                     0x00000002011AFFFF, // Range Maximum
                     0x0000000000000000, // Translation Offset
                     0x0000000000010000, // Length
                     ,, , AddressRangeMemory, TypeStatic)
                 Interrupt (ResourceConsumer, Level, ActiveHigh, 
Exclusive, ,, )
                 {
                     0x000001EB,
                 }
             })
             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
             {
                 Return (RBUF) /* \_SB_.SPI0.RBUF */
             }

             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
             {
                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* 
Device Properties for _DSD */,
                 Package (0x03)
                 {
                     Package (0x02)
                     {
                         "reg-io-width",
                         0x04
                     },

                     Package (0x02)
                     {
                         "num-cs",
                         One
                     },

                     Package (0x02)
                     {
                         "cs-gpios",
                         Package (0x04)
                         {
                             SPI0,
                             Zero,
                             Zero,
                             Zero
                         }
                     }
                 }
             })
         }

         Scope (SPI0)
         {
             Device (TPM)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_CID, Package (0x01)  // _CID: Compatible ID
                 {
                     "SMO0768"
                 })
                 Name (_UID, Zero)  // _UID: Unique ID
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* 
Device Properties for _DSD */,
                     Package (0x00){}
                 })
                 Method (_CRS, 0, NotSerialized)  // _CRS: Current 
Resource Settings
                 {
                     Name (RBUF, ResourceTemplate ()
                     {
                         SpiSerialBusV2 (0x0000, PolarityLow, 
FourWireMode, 0x08,
                             ControllerInitiated, 0x000F4240, 
ClockPolarityLow,
                             ClockPhaseFirst, "\\_SB.SPI0",
                             0x00, ResourceConsumer, , Exclusive,
                             )
                     })
                     Return (RBUF) /* \_SB_.SPI0.TPM_._CRS.RBUF */
                 }

                 Method (_STA, 0, NotSerialized)  // _STA: Status
                 {
                     If ((TPEN == One))
                     {
                         Return (0x0F)
                     }
                     Else
                     {
                         Return (Zero)
                     }
                 }
             }
         }
     }


Regards

Liguang

>
>> +		} else
>> +			probe_func = tpm_tis_spi_probe;
>> +	}
>>   
>>   	return probe_func(spi);
>>   }
>> -- 
>> 2.19.1.6.gb485710b
>>
>>
> /Jarkko
