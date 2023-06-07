Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBFA7266EA
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 19:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFGRPZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jun 2023 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFGRPY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jun 2023 13:15:24 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C908E62;
        Wed,  7 Jun 2023 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1686158124; x=1717694124;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qIJQotBV1fJeHqOAObo+Aa8Gxe1l8U/eIwWaj5IBIwk=;
  b=hLSqH+cAdodIRBonB3sBRavWcrkfi5vJpRXZYU+9Mw3Nbi4Qb3yRlUQ4
   izBoHVTC+w7WmPxdi7diJ6zFVRQUtn9Cj3u4jpIBjeW451IawBLc++KY9
   BhOLwL//xDv5aOUDwEl+m3P/4LU7qQLZN94WpCJHsrkKGPV0y0oxl4mUu
   o=;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="16226291"
X-IronPort-AV: E=Sophos;i="6.00,224,1681164000"; 
   d="scan'208";a="16226291"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 19:15:22 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 19:15:20 +0200
Received: from [10.165.68.85] (10.165.68.85) by KLUSE818.infineon.com
 (172.28.156.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 7 Jun 2023
 19:15:20 +0200
Message-ID: <34f01f17-3091-0ce2-f0c3-b0cd25ea61ce@infineon.com>
Date:   Wed, 7 Jun 2023 19:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] tpm_tis: Use responseRetry to recover from data
 transfer errors
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-4-Alexander.Steffen@infineon.com>
 <CT5VOWDNIK5S.1549VUD23JWWB@suppilovahvero>
Content-Language: en-US
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <CT5VOWDNIK5S.1549VUD23JWWB@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.165.68.85]
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 KLUSE818.infineon.com (172.28.156.171)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06.06.23 23:17, Jarkko Sakkinen wrote:
> On Mon Jun 5, 2023 at 8:59 PM EEST, Alexander Steffen wrote:
>> TPM responses may become damaged during transmission, for example due to
>> bit flips on the wire. Instead of aborting when detecting such issues, the
>> responseRetry functionality can be used to make the TPM retransmit its
>> response and receive it again without errors.
>>
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 40 ++++++++++++++++++++++++++-------
>>   drivers/char/tpm/tpm_tis_core.h |  1 +
>>   2 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 5ddaf24518be..a08768e55803 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -345,11 +345,6 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>        u32 expected;
>>        int rc;
>>
>> -     if (count < TPM_HEADER_SIZE) {
>> -             size = -EIO;
>> -             goto out;
>> -     }
>> -
>>        size = recv_data(chip, buf, TPM_HEADER_SIZE);
>>        /* read first 10 bytes, including tag, paramsize, and result */
>>        if (size < TPM_HEADER_SIZE) {
>> @@ -382,7 +377,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>                goto out;
>>        }
>>        status = tpm_tis_status(chip);
>> -     if (status & TPM_STS_DATA_AVAIL) {      /* retry? */
>> +     if (status & TPM_STS_DATA_AVAIL) {
> 
> Please remove (no-op).

You mean I shouldn't change the line and leave the comment in? To me it 
looked like a very brief TODO comment "should we retry here?", and since 
with this change it now actually does retry, I removed it.

>>                dev_err(&chip->dev, "Error left over data\n");
>>                size = -EIO;
>>                goto out;
>> @@ -396,10 +391,39 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>        }
>>
>>   out:
>> -     tpm_tis_ready(chip);
>>        return size;
>>   }
>>
>> +static int tpm_tis_recv_with_retries(struct tpm_chip *chip, u8 *buf, size_t count)
> 
> This *substitutes* the curent tpm_tis_recv(), right?
> 
> So it *is* tpm_tis_recv(), i.e. no renames thank you :-)
> 
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     unsigned int try;
>> +     int rc = 0;
>> +
>> +     if (count < TPM_HEADER_SIZE) {
>> +             rc = -EIO;
>> +             goto out;
>> +     }
>> +
>> +     for (try = 0; try < TPM_RETRY; try++) {
>> +             rc = tpm_tis_recv(chip, buf, count);
> 
> I would rename single shot tpm_tis_recv() as tpm_tis_try_recv().
> 
>> +
>> +             if (rc == -EIO) {
>> +                     /* Data transfer errors, indicated by EIO, can be
>> +                      * recovered by rereading the response.
>> +                      */
>> +                     tpm_tis_write8(priv, TPM_STS(priv->locality),
>> +                                    TPM_STS_RESPONSE_RETRY);
>> +             } else {
>> +                     break;
>> +             }
> 
> And if this should really be managed inside tpm_tis_try_recv(), and
> then return zero (as the code block consumes the return value).

What exactly should be done in tpm_tis_try_recv()? It could set 
TPM_STS_RESPONSE_RETRY, but then it would still need to return an error 
code, so that this loop knows whether to call it again or not.

>> +     }
>> +
>> +out:
>> +     tpm_tis_ready(chip);
> 
> Empty line here (nit).
> 
>> +     return rc;
>> +}
>> +
>>   /*
>>    * If interrupts are used (signaled by an irq set in the vendor structure)
>>    * tpm.c can skip polling for the data to be available as the interrupt is
>> @@ -986,7 +1010,7 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>>   static const struct tpm_class_ops tpm_tis = {
>>        .flags = TPM_OPS_AUTO_STARTUP,
>>        .status = tpm_tis_status,
>> -     .recv = tpm_tis_recv,
>> +     .recv = tpm_tis_recv_with_retries,
>>        .send = tpm_tis_send,
>>        .cancel = tpm_tis_ready,
>>        .update_timeouts = tpm_tis_update_timeouts,
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> index e978f457fd4d..8458cd4a84ec 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -34,6 +34,7 @@ enum tis_status {
>>        TPM_STS_GO = 0x20,
>>        TPM_STS_DATA_AVAIL = 0x10,
>>        TPM_STS_DATA_EXPECT = 0x08,
>> +     TPM_STS_RESPONSE_RETRY = 0x02,
>>        TPM_STS_READ_ZERO = 0x23, /* bits that must be zero on read */
>>   };
>>
>> --
>> 2.34.1
> 
> BR, Jarkko
