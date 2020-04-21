Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD111B27FD
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgDUNex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 09:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728626AbgDUNew (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 09:34:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD84C061A10;
        Tue, 21 Apr 2020 06:34:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so3600554wmj.1;
        Tue, 21 Apr 2020 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5Q7u58F6l2JZ0p4YchFIOElg4tS0GMZkcm6JNAdwZZI=;
        b=QDZcdswIp+68Yz7Ywiw7/gnRTKtUbva3CMYpFGowfLiD0OzofqIuDZQ7L5XevD9/Lq
         9vjr9EzUlXOZenWWpwaGMWWsW0jcy32Y3VEAA4CSlOwFY/QAjoov/+47Ts2spuDa8vJO
         g3g+6iptmh435ZzzLuvN7sUxFk1d0W0xEIRcEsVqVCeh7pGnsqVRHd3gSlcY1Lgc5tti
         XG2LBKT3XmqYyca8AMKBp7NB+Riy7tmzL30pWuEXNxVP09rf7E2958relKFCqTxMuIfA
         PmU6uXZwPzhdKsuyN1jmQFicL+o2I2AuTR62cFBGToAq8TRuh8gVSLy3O3FXDycJrqxd
         N/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5Q7u58F6l2JZ0p4YchFIOElg4tS0GMZkcm6JNAdwZZI=;
        b=EXfzymtpMPMBbUHkhTeGC24XwWLeP1vGG7ytNQsQI3+13jeM8o9hBhwp8vbFfZY3Mu
         CnscJB5WKyAMz2JZIHJVuYXjxIm1UyqXmMjv/R4Db7zpi9W4Uw0i53R1a3fAwvphqWZF
         fsdI8LBqemdaTT0JaSD36T2c7cLjSMXHpYG42xJOabD+e38m46wMDihQdVwd33pLN2K/
         6/bl8lUAy93N+33ty/Yo5B/H82zaGl5vYvv/1mVuHwlyuQJu1DwNWZoXnWku4sfyJonw
         bMLxLeX3hGrCSbYEbtfDSGvzCiZ0OLBYtwXh2888oNdVkiW/vmamuO7SUDHZMhb6s6bz
         jiMA==
X-Gm-Message-State: AGi0PuZQy9E6if1MzLMuHjJfevKSRDbWXhknKB0bTpaXLUSEOYd1f0Qy
        1TkeKbkTVirls/h5kn9ceGU=
X-Google-Smtp-Source: APiQypI7Gkaitg2nS4icOQfpi/UHfFzKjKct0O7G1ATUREFnm/XrfEZxAS4WsUupim8vlrtZESFSLA==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr5193209wmb.181.1587476090363;
        Tue, 21 Apr 2020 06:34:50 -0700 (PDT)
Received: from [192.168.43.138] ([80.246.137.75])
        by smtp.gmail.com with ESMTPSA id l9sm3815467wrq.83.2020.04.21.06.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 06:34:49 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] tpm: tpm_tis: Add check_data handle to
 tpm_tis_phy_ops
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Christophe Ricard <christophe-h.ricard@st.com>
References: <20200407162044.168890-1-amirmizi6@gmail.com>
 <20200407162044.168890-3-amirmizi6@gmail.com>
 <20200408183324.GB33486@linux.intel.com>
From:   Amir Mizinski <amirmizi6@gmail.com>
Message-ID: <0cfa0486-8ccb-d7d1-acf2-ca103f723b3a@gmail.com>
Date:   Tue, 21 Apr 2020 13:34:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200408183324.GB33486@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello jarkko,
I reconfigure my email client by the instructions you've sent, and
re-responsing as you requested.
please tell me if there are still any issues. thank you.

On 2020-04-08 18:33, Jarkko Sakkinen wrote:
> On Tue, Apr 07, 2020 at 07:20:39PM +0300, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>
>> In order to validate data integrity we need to compute the crc over the data
>> sent in lower layer (I2C for instance).
>
> s/crc/CRC/
>
>> To do that tpm_tis_check_data() calls a "check_data" operation (if available).
>
> "check_data" does not exist.
>

it is added in this commit to "tpm_tis_phy_ops" struct in
"tpm_tis_core.h", which is inherited in "tpm_tis_i2c.c" on later patch
(7/7).

>> If data integrity check fails, a retry to save the sent/received
>> data is implemented in tpm_tis_send_main()/tpm_tis_recv() functions.
>>
>> Considering this commit, the following steps are done when sending a command:
>>    1. Host writes to TPM_STS.commandReady.
>>    2. Host writes command.
>>    3. Host checks that TPM received data is valid.
>>    4. If data is currupted go to step 1.
>>
>> When receiving data:
>>    1. Host checks that TPM_STS.dataAvail is set.
>>    2. Host saves received data.
>>    3. Host checks that received data is correct.
>>    4. If data is currupted Host writes to TPM_STS.responseRetry and go to
>>       step 1.
>
> These sequences in the commit message look somewhat uselss. Maybe
> just remove them.
>

Their main porpose is to describe how the retry attempt is implemented
in case of currupted data.
should i just describe that with a few words or that's unnecessary?

>>
>> Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
>> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
>> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 102 +++++++++++++++++++++++++---------------
>>  drivers/char/tpm/tpm_tis_core.h |   3 ++
>>  2 files changed, 67 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 27c6ca0..6c4f232 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -242,6 +242,15 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>>      return status;
>>  }
>>  
>> +static bool tpm_tis_check_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>
> Not sure if this is the best possible function name, "check" can
> mean almost anything.
>

Ok, i'm changing it to "verify_data_integrity". is that ok?

>> +{
>> +    struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +
>> +    if (priv->phy_ops->check_data)
>> +        return priv->phy_ops->check_data(priv, buf, len);
>
> New line here before the return statement.
>
>> +    return true;
>> +}
>> +
>>  static void tpm_tis_ready(struct tpm_chip *chip)
>>  {
>>      struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> @@ -308,47 +317,59 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>  {
>>      struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>      int size = 0;
>> -    int status;
>> +    int status, i;
>>      u32 expected;
>> +    bool check_data = false;
>>  
>> -    if (count < TPM_HEADER_SIZE) {
>> -        size = -EIO;
>> -        goto out;
>> -    }
>> +    for (i = 0; i < TPM_RETRY; i++) {
>> +        if (count < TPM_HEADER_SIZE) {
>> +            size = -EIO;
>> +            goto out;
>> +        }
>>  
>> -    size = recv_data(chip, buf, TPM_HEADER_SIZE);
>> -    /* read first 10 bytes, including tag, paramsize, and result */
>> -    if (size < TPM_HEADER_SIZE) {
>> -        dev_err(&chip->dev, "Unable to read header\n");
>> -        goto out;
>> -    }
>> +        size = recv_data(chip, buf, TPM_HEADER_SIZE);
>> +        /* read first 10 bytes, including tag, paramsize, and result */
>> +        if (size < TPM_HEADER_SIZE) {
>> +            dev_err(&chip->dev, "Unable to read header\n");
>> +            goto out;
>> +        }
>>  
>> -    expected = be32_to_cpu(*(__be32 *) (buf + 2));
>> -    if (expected > count || expected < TPM_HEADER_SIZE) {
>> -        size = -EIO;
>> -        goto out;
>> -    }
>> +        expected = be32_to_cpu(*(__be32 *) (buf + 2));
>> +        if (expected > count || expected < TPM_HEADER_SIZE) {
>> +            size = -EIO;
>> +            goto out;
>> +        }
>>  
>> -    size += recv_data(chip, &buf[TPM_HEADER_SIZE],
>> -              expected - TPM_HEADER_SIZE);
>> -    if (size < expected) {
>> -        dev_err(&chip->dev, "Unable to read remainder of result\n");
>> -        size = -ETIME;
>> -        goto out;
>> -    }
>> +        size += recv_data(chip, &buf[TPM_HEADER_SIZE],
>> +                  expected - TPM_HEADER_SIZE);
>> +        if (size < expected) {
>> +            dev_err(&chip->dev, "Unable to read remainder of result\n");
>> +            size = -ETIME;
>> +            goto out;
>> +        }
>>  
>> -    if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>> -                &priv->int_queue, false) < 0) {
>> -        size = -ETIME;
>> -        goto out;
>> +        if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>> +                      &priv->int_queue, false) < 0) {
>> +            size = -ETIME;
>> +            goto out;
>> +        }
>> +
>> +        status = tpm_tis_status(chip);
>> +        if (status & TPM_STS_DATA_AVAIL) {    /* retry? */
>> +            dev_err(&chip->dev, "Error left over data\n");
>> +            size = -EIO;
>> +            goto out;
>> +        }
>> +
>> +        check_data = tpm_tis_check_data(chip, buf, size);
>> +        if (!check_data)
>> +            tpm_tis_write8(priv, TPM_STS(priv->locality),
>> +                       TPM_STS_RESPONSE_RETRY);
>> +        else
>> +            break;
>>      }
>> -    status = tpm_tis_status(chip);
>> -    if (status & TPM_STS_DATA_AVAIL) {    /* retry? */
>> -        dev_err(&chip->dev, "Error left over data\n");
>> +    if (!check_data)
>>          size = -EIO;
>> -        goto out;
>> -    }
>> -
>>  out:
>>      tpm_tis_ready(chip);
>>      return size;
>> @@ -453,14 +474,19 @@ static void disable_interrupts(struct tpm_chip *chip)
>>  static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>>  {
>>      struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -    int rc;
>> +    int rc, i;
>>      u32 ordinal;
>>      unsigned long dur;
>> +    bool data_valid = false;
>>  
>> -    rc = tpm_tis_send_data(chip, buf, len);
>> -    if (rc < 0)
>> -        return rc;
>> -
>> +    for (i = 0; i < TPM_RETRY && !data_valid; i++) {
>> +        rc = tpm_tis_send_data(chip, buf, len);
>> +        if (rc < 0)
>> +            return rc;
>> +        data_valid = tpm_tis_check_data(chip, buf, len);
>> +    }
>> +    if (!data_valid)
>> +        return -EIO;
>>      /* go and do it */
>>      rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
>>      if (rc < 0)
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> index d06c65b..486c2e9 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -34,6 +34,7 @@ enum tis_status {
>>      TPM_STS_GO = 0x20,
>>      TPM_STS_DATA_AVAIL = 0x10,
>>      TPM_STS_DATA_EXPECT = 0x08,
>> +    TPM_STS_RESPONSE_RETRY = 0x02,
>>  };
>>  
>>  enum tis_int_flags {
>> @@ -106,6 +107,8 @@ struct tpm_tis_phy_ops {
>>      int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
>>      int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
>>      int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
>> +    bool (*check_data)(struct tpm_tis_data *data, const u8 *buf,
>> +               size_t len);
>
> Aren't you validating the contents of the buf?
>
> /Jarkko

i do.
when sending, the data is written to the buff in "tpm_tis_send_data(chip,buf, len)".
and validated in "data_valid = tpm_tis_check_data(chip, buf, len)".
data is not sent until TPM_STS_GO is set.

when receiving, the data in the buffer is verified after recv_data, and
writing to TPM_STS_RESPONSE_RETRY in case it fails to recive it again.


Thank you
Amir Mizinski

