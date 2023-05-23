Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E1570D8CC
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjEWJU5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjEWJUv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 05:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0611F
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684833607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fn6/Mg38CazICzLvvCRl9KTjMS04MbP9e/f9SZahjis=;
        b=iB4lH1GofgLOJH7MWZN3wbAnWw1BzlRMxObp97SJ9BnK+z2aDdg2bxWpraveQyn/3lJRba
        eZCPW1DrfzlXyyxGT061G1lkINP2t/wtEnPj6KTg/0YLyyqYhUgEWp3J/pn5UV1KRNzwVt
        NQJbdqlKG0IW5MgalMsNfL/kmaPUGq8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-DE8zgEZvOGCf_BDASUDXHQ-1; Tue, 23 May 2023 05:20:06 -0400
X-MC-Unique: DE8zgEZvOGCf_BDASUDXHQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-970e0152da7so95297566b.2
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 02:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833605; x=1687425605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fn6/Mg38CazICzLvvCRl9KTjMS04MbP9e/f9SZahjis=;
        b=fdxdbds4jn4gH3M8xZZ66314y+o9K6qGNBlykRiVAL3gdWpFKeEVJwCh12nNmLwXB4
         YBp5EnNyft/G5XdDodYmyQ/484ZfmdZ7X5YTmJZakb+EdfNkzm2uV1IDcjTZga991Mdl
         +DhywH4tQo4rtQrFebAqDvjiCGh2lYozfMsYveso8E5bLDeczYpeDQAqjnaMYUZ/idCu
         k9nWn6II0HKeRVGdWoJ74iWayPPpT9+KokJN4PT3kiuqGv+tAt1D+KmjtxjO15zJkg8A
         /clS5Ssd4fWFHT7DDJLtt43yaBrHOa081jm4QQMtSLTnFTu2676zce+1r6QbLR4KcLS+
         dtig==
X-Gm-Message-State: AC+VfDz/UxSIpWhBNRIOr25s70nQVgeck/eYMqM3yCOk4MQSNdna9bV1
        GEgqBtKBE49uNzHNhH2IfiiE26UyabVfl4+Y/mVoFCWW2NoDiu9wd28b+op7SxtFLNtiZPxuoxN
        3NHW8ETg3S4qaWGeu5UtWWc7zPTkQ
X-Received: by 2002:a17:906:dc90:b0:96f:cf04:82a3 with SMTP id cs16-20020a170906dc9000b0096fcf0482a3mr7124256ejc.70.1684833604959;
        Tue, 23 May 2023 02:20:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QVxXgvr8hupi6y88smfN74RETs+4H065rSKm8uwDXUIIaBa/cxhH4Mj1EY+5no2GOcncMNA==
X-Received: by 2002:a17:906:dc90:b0:96f:cf04:82a3 with SMTP id cs16-20020a170906dc9000b0096fcf0482a3mr7124217ejc.70.1684833604525;
        Tue, 23 May 2023 02:20:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y2-20020a170906914200b0094e597f0e4dsm4152574ejw.121.2023.05.23.02.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:20:03 -0700 (PDT)
Message-ID: <2fae3c48-c9d6-7251-1692-7365f9d0cfa7@redhat.com>
Date:   Tue, 23 May 2023 11:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US, nl
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        oe-lkp@lists.linux.dev, lkp@intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 5/23/23 11:14, Péter Ujfalusi wrote:
> 
> 
> On 23/05/2023 10:44, Lukas Wunner wrote:
>> On Tue, May 23, 2023 at 09:48:23AM +0300, Péter Ujfalusi wrote:
>>> On 22/05/2023 17:31, Lino Sanfilippo wrote:
>> [...]
>>> This looked promising, however it looks like the UPX-i11 needs the DMI
>>> quirk.
>>
>> Why is that?  Is there a fundamental problem with the patch or is it
>> a specific issue with that device?
> 
> The flood is not detected (if there is a flood at all), interrupt stops
> working after about 200 interrupts - in the latest boot at 118th.
> I can check this later, likely tomorrow.
> 
>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>> @@ -752,6 +752,55 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>>>>  	return status == TPM_STS_COMMAND_READY;
>>>>  }
>>>>  
>>>> +static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
>>>> +{
>>>> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>>> +	int intmask = 0;
>>>> +
>>>> +	dev_err(&chip->dev, HW_ERR
>>>> +		"TPM interrupt storm detected, polling instead\n");
>>>
>>> Should this be dev_warn or even dev_info level?
>>
>> The corresponding message emitted in tpm_tis_core_init() for
>> an interrupt that's *never* asserted uses dev_err(), so using
>> dev_err() here as well serves consistency:
>>
>> 	dev_err(&chip->dev, FW_BUG
>> 		"TPM interrupt not working, polling instead\n");
>>
>> That way the same severity is used both for the never asserted and
>> the never deasserted interrupt case.
> 
> Oh, OK.
> Is there anything the user can do to have a ERROR less boot?

That is a good point. Even though the typical dmesg has at least some false-positive error messages I believe we should still strive to not log errors in cases where there is not e.g. an actual error which the user needs to care about (e.g. disk IO errors).

Usually in similar cases like this, where we are basically correcting for firmware bugs (1) we use:

	dev_warn(dev, FW_BUG "...", ...);

maybe we should switch both messages here to this ?

FW_BUG is: defined in linux/printk as:

#define FW_BUG		"[Firmware Bug]: "

And we are trying to use this in places like this both for uniformity of reporting these kinda bugs and to allow grepping for it.

Regards,

Hans



1) providing wrong / non working ACPI IRQ resources in this case

