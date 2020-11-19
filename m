Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D032B8FB6
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Nov 2020 11:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKSKAp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Nov 2020 05:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgKSKAo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Nov 2020 05:00:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5072C0613CF
        for <linux-integrity@vger.kernel.org>; Thu, 19 Nov 2020 02:00:44 -0800 (PST)
Received: from [IPv6:2003:c7:cf41:a700:4100:38e3:ac80:b823] (p200300c7cf41a700410038e3ac80b823.dip0.t-ipconnect.de [IPv6:2003:c7:cf41:a700:4100:38e3:ac80:b823])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3E6831F4566F;
        Thu, 19 Nov 2020 10:00:43 +0000 (GMT)
Subject: Re: Re: [PATCH v3 1/2] tpm_tis_core: add optional max xfer size check
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        apronin@chromium.org, dtor@chromium.org
References: <1468546745-14646-1-git-send-email-apronin@chromium.org>
 <1469677797-74304-2-git-send-email-apronin@chromium.org>
 <20160809081402.GA10537@intel.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e601b69a-50a9-187b-1fba-0a344952ed25@collabora.com>
Date:   Thu, 19 Nov 2020 11:00:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20160809081402.GA10537@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,
I am Dafna Hirschfeld. I work for Collabora on upstreaming patches
found on the chromeos kernel.
This patch is in chromeos and is not merged in mainline.



Am 09.08.16 um 10:14 schrieb Jarkko Sakkinen:
> On Wed, Jul 27, 2016 at 08:49:56PM -0700, Andrey Pronin wrote:
>> If tpm reports a bigger burstcnt than allowed by the physical protocol,
>> set burstcnt to the max allowed value.
>>
>> In practice, seen in case of xfer issues (e.g. in spi interface case,
>> lost header causing flow control issues and wrong values returned on read
>> from TPM_STS). Without catching, causes the physical layer to reject xfer.
>>
>> Signed-off-by: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> I don't have hardware to test this. Someone should validate that it
> does not break anything. Christophe, are you able to do this?
> 
> /Jarkko
> 
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 9 ++++++++-
>>   drivers/char/tpm/tpm_tis_core.h | 1 +
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index f22caf8..7c4fa0c 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -168,8 +168,15 @@ static int get_burstcount(struct tpm_chip *chip)
>>   			return rc;
>>   
>>   		burstcnt = (value >> 8) & 0xFFFF;
>> -		if (burstcnt)
>> +		if (burstcnt) {
>> +			if (priv->phy_ops->max_xfer_size &&
>> +			    (burstcnt > priv->phy_ops->max_xfer_size)) {
>> +				dev_warn(&chip->dev,
>> +					 "Bad burstcnt read: %d\n", burstcnt);
>> +				burstcnt = priv->phy_ops->max_xfer_size;
>> +			}
>>   			return burstcnt;

I see there is patch in mainline "tpm_tis_spi: Remove limitation of transfers to MAX_SPI_FRAMESIZE bytes"
That already limits the transfer length to MAX_SPI_FRAMESIZE. So it seems that this patch is not needed anymore.
Can someone confirm that?

Thank you,
Dafna



[1] https://lore.kernel.org/tpmdd-devel/1488459879-24349-5-git-send-email-peter.huewe@infineon.com/

>> +		}
>>   		msleep(TPM_TIMEOUT);
>>   	} while (time_before(jiffies, stop));
>>   	return -EBUSY;
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> index 9191aab..58e8b14 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -102,6 +102,7 @@ struct tpm_tis_phy_ops {
>>   	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
>>   	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
>>   	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
>> +	u16 max_xfer_size;
>>   };
>>   
>>   static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
>> -- 
>> 2.6.6
>>
> 
> ------------------------------------------------------------------------------
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> patterns at an interface-level. Reveals which users, apps, and protocols are
> consuming the most bandwidth. Provides multi-vendor support for NetFlow,
> J-Flow, sFlow and other flows. Make informed decisions using capacity
> planning reports. http://sdm.link/zohodev2dev
> 
