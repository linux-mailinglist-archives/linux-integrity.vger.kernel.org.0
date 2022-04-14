Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3097F501812
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Apr 2022 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiDNQBA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Apr 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354099AbiDNPSM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 11:18:12 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251CFE7F68;
        Thu, 14 Apr 2022 08:06:28 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 40FCE61EA1928;
        Thu, 14 Apr 2022 17:06:25 +0200 (CEST)
Message-ID: <068becdf-2d88-65a1-5977-1fedd34a8f0b@molgen.mpg.de>
Date:   Thu, 14 Apr 2022 17:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] tpm: cr50: Add new device/vendor ID 0x504a6666
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "Jes B. Klinke" <jbk@chromium.org>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
References: <20220405173741.4023216-1-jbk@chromium.org>
 <6528eec1-0ab1-a5ff-3e30-2e06256dfd04@molgen.mpg.de>
 <YlgOqpe85pe3P/JP@kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YlgOqpe85pe3P/JP@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Jarkko,


Am 14.04.22 um 14:08 schrieb Jarkko Sakkinen:
> On Thu, Apr 07, 2022 at 12:21:44PM +0200, Paul Menzel wrote:

>> Thank you for your patch.
>>
>> Am 05.04.22 um 19:37 schrieb Jes B. Klinke:
>>> Accept one additional numerical value of DID:VID for next generation
>>> Google TPM, to be used in future Chromebooks.
>>
>> Maybe extend:
>>
>> … Google TPM with new firmware …
>>
>> The TPM with the new firmware has the code name TI50, and going to use the
>> same interfaces.
>>
>>> This patch touches more lines than may seem necessary, as a result of
>>> the need to move the error case to sit after the two recognized cases.
>>>
>>> Signed-off-by: Jes B. Klinke <jbk@chromium.org>
>>> ---
>>>
>>>    drivers/char/tpm/tpm_tis_i2c_cr50.c | 21 +++++++++++++--------
>>>    1 file changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>>> index f6c0affbb4567..bf54ebd6724b0 100644
>>> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
>>> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>>> @@ -31,6 +31,7 @@
>>>    #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
>>>    #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
>>>    #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
>>> +#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
>>>    #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
>>>    #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
>>>    #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
>>> @@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>>>    	}
>>>    	vendor = le32_to_cpup((__le32 *)buf);
>>> -	if (vendor != TPM_CR50_I2C_DID_VID) {
>>> -		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
>>> -		tpm_cr50_release_locality(chip, true);
>>> -		return -ENODEV;
>>> +	if (vendor == TPM_CR50_I2C_DID_VID) {
>>> +		dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
>>> +			 client->addr, client->irq, vendor >> 16);
>>> +		return tpm_chip_register(chip);
>>> +	}
>>> +	if (vendor == TPM_TI50_I2C_DID_VID) {
>>> +		dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
>>> +			 client->addr, client->irq, vendor >> 16);
>>> +		return tpm_chip_register(chip);
>>>    	}
>>
>> Both branches are quite similar. Can a ternary operator be used?
>>
>>      dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
>>      	 (vendor == TPM_CR50_I2C_DID_VID) ? "cr50" : "ti50", client->addr,
>> client->irq, vendor >> 16);
>>      return tpm_chip_register(chip);
>>
>> and the original flow be left? (A separate variable can also be added.)
>>
>>> -	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
>>> -		 client->addr, client->irq, vendor >> 16);
>>> -
>>> -	return tpm_chip_register(chip);
>>> +	dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
>>> +	tpm_cr50_release_locality(chip, true);
>>> +	return -ENODEV;
>>>    }
>>>    /**

> OK, these are legit suggestions. Paul, can you do these changes and add my
> reviewed-by for the +1 version?

I guess you mean Jes?


Kind regards,

Paul
