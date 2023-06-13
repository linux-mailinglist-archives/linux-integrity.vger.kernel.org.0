Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFA72EA02
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjFMRho (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFMRhn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 13:37:43 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF7192;
        Tue, 13 Jun 2023 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1686677862; x=1718213862;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VxLwfDAWnXzDoi+kxjEz7uUqZcBPwXcL07uF35QSu+E=;
  b=h7Z1uSKNqOjt+3+SqCiuRN43BoWPHNTlJrgQS8vQolOgYrqfQdoi9RMI
   tS2kXm6WcSI0hLOepHjDLxhgn6GuEat6xFSfmH4R04xS5g7wDncEyfJ2M
   fYWojpZTBeMEY3uFr/nVnnEBwAE2fh8KgAfNQHC7TLqPLbePVhe8eCLXD
   A=;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="18548631"
X-IronPort-AV: E=Sophos;i="6.00,240,1681164000"; 
   d="scan'208";a="18548631"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:37:40 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 19:37:40 +0200
Received: from [10.165.68.85] (10.165.68.85) by KLUSE818.infineon.com
 (172.28.156.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 19:37:39 +0200
Message-ID: <81e9b7a3-ec2a-435c-1e4d-2112e2d000a5@infineon.com>
Date:   Tue, 13 Jun 2023 19:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] tpm_tis: Use responseRetry to recover from data
 transfer errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
 <20230605175959.2131-4-Alexander.Steffen@infineon.com>
 <CT5VOWDNIK5S.1549VUD23JWWB@suppilovahvero>
 <34f01f17-3091-0ce2-f0c3-b0cd25ea61ce@infineon.com>
 <CT7BN97ICGN7.37I0H14NKKMYR@suppilovahvero>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <CT7BN97ICGN7.37I0H14NKKMYR@suppilovahvero>
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

On 08.06.23 16:00, Jarkko Sakkinen wrote:
> On Wed Jun 7, 2023 at 8:14 PM EEST, Alexander Steffen wrote:
>>>> -     if (status & TPM_STS_DATA_AVAIL) {      /* retry? */
>>>> +     if (status & TPM_STS_DATA_AVAIL) {
>>>
>>> Please remove (no-op).
>>
>> You mean I shouldn't change the line and leave the comment in? To me it
>> looked like a very brief TODO comment "should we retry here?", and since
>> with this change it now actually does retry, I removed it.
> 
> Right, ok, point taken, you can keep it.
> 
>>>>                 dev_err(&chip->dev, "Error left over data\n");
>>>>                 size = -EIO;
>>>>                 goto out;
>>>> @@ -396,10 +391,39 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>>>>         }
>>>>
>>>>    out:
>>>> -     tpm_tis_ready(chip);
>>>>         return size;
>>>>    }
>>>>
>>>> +static int tpm_tis_recv_with_retries(struct tpm_chip *chip, u8 *buf, size_t count)
>>>
>>> This *substitutes* the curent tpm_tis_recv(), right?
>>>
>>> So it *is* tpm_tis_recv(), i.e. no renames thank you :-)
>>>
>>>> +{
>>>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>>> +     unsigned int try;
>>>> +     int rc = 0;
>>>> +
>>>> +     if (count < TPM_HEADER_SIZE) {
>>>> +             rc = -EIO;
>>>> +             goto out;
>>>> +     }
>>>> +
>>>> +     for (try = 0; try < TPM_RETRY; try++) {
>>>> +             rc = tpm_tis_recv(chip, buf, count);
>>>
>>> I would rename single shot tpm_tis_recv() as tpm_tis_try_recv().
>>>
>>>> +
>>>> +             if (rc == -EIO) {
>>>> +                     /* Data transfer errors, indicated by EIO, can be
>>>> +                      * recovered by rereading the response.
>>>> +                      */
>>>> +                     tpm_tis_write8(priv, TPM_STS(priv->locality),
>>>> +                                    TPM_STS_RESPONSE_RETRY);
>>>> +             } else {
>>>> +                     break;
>>>> +             }
>>>
>>> And if this should really be managed inside tpm_tis_try_recv(), and
>>> then return zero (as the code block consumes the return value).
>>
>> What exactly should be done in tpm_tis_try_recv()? It could set
>> TPM_STS_RESPONSE_RETRY, but then it would still need to return an error
>> code, so that this loop knows whether to call it again or not.
> 
> So my thinking was to:
> 
> - Rename tpm_tis_recv() as tpm_tis_try_recv()
> - Rename this new function as tpm_tis_recv().

Sounds good, thanks. Will be done in v3.

> BR, Jarkko
