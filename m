Return-Path: <linux-integrity+bounces-6628-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F0AF9719
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175175670DD
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C618A6C4;
	Fri,  4 Jul 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei1w2BgW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC61156677;
	Fri,  4 Jul 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643566; cv=none; b=WtbZLmrZOPmTaKKpBBOOp7HB55+oAn6SGjtEnNBVNx5szezES0QfdKEwWFY8zSCNegQlP6weS5yE2vSyacDIjxafNq+d1KJORVhg8+8nO6RH1/pC2ATFJ0mfCRi8cjH6mxJ0Yi+zHfJs4KD5A+OFlGBTVFGBf9ryoB2qjlPhaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643566; c=relaxed/simple;
	bh=rNXv6LukB4ah6mKRuLZMXGmt83ZL9J2kgfygxTN4y6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoFjsdXYeRhoJxZDD4DK2quVxO30DyP8+qF+mnRqmxtiAY7W1QSkAm1TI3jb5Bx4RmIq/TJYHSFdeLC+OEsZo8ezbO43rMaZlsXqOnpUpT0USEvmlQ+Olkpt1iDab+2XIdU8nNvqDhpt7nmxqiyb9RqomivYPc1gv3RdS7FWYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei1w2BgW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so788254f8f.1;
        Fri, 04 Jul 2025 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751643562; x=1752248362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDlfcdGHPRVOhFJ7RkcWaBsI555BcGhUSa3bs4JwpbY=;
        b=Ei1w2BgWjQHNJGkZu7y45562AQVP7tNHLIGuV0zm7m7b2a3qqhcln6SxL46CkOzdK/
         VhzN9x0lJbDwZRaT6QtUsKMAKx/Qrf4NolrW8yGyMYMuxxVCmWwZfn6Mp1crK4+qYyaf
         DT67yseu6kkzOFxajzz+ZJ7t1qGSTOmIwGs7Lpuuux9PvNennfphENv5bCcmjpAKBF//
         ygFpk56+VmsH+TDWn4VU5Bx99TXmAB00OcN/iV5wJaBYO4htmmHRJR+Qu9ljw7yEAuWR
         Gp0lw+hzNHEEG2JfRMccga6S/ynzwRjWxHN+J3V0ALGK0FvIUpnsTwfsGNgjm4h9pBo5
         Ur0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751643562; x=1752248362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDlfcdGHPRVOhFJ7RkcWaBsI555BcGhUSa3bs4JwpbY=;
        b=A4ruDbWKWZuYEn9coxdNfDtmDBoy7qurf2TC1bKD7A5WC5bABOfzNUs6tOLg30bTFU
         nRk1ZE+k7z++2WhVHTU7wP49lzhxcjl6EQVvVsJYkPPjESDfzq0xJ2jCLo4vAEkJpAoI
         uiWiTI4iSkej5CEGzxpCUzAcAh+gTCvFV4P3AsM9MAzibGsMAXcEqgH90Jff1c+pI4lU
         5ZBUbvYzE/dTArrIMweo69+KcuTgvKMQelW/dWs5CyyAxcZ9fAwt5nwen5vV3SmpfPIQ
         eJMWLO7ZNiKY767hJXYb6hlZ7ldmcvI9ka5qwSJMt/+BLc92kjLD0LxFzhgMCqVsgT1Z
         oY4A==
X-Forwarded-Encrypted: i=1; AJvYcCWDmbF8JV3yESOijMLw3cM0xwp+2xEZmcFjNVbLehmqkLGrRu0SNJSfOzsh46IDg6wy7FLhh1pnefHIyJQ2@vger.kernel.org, AJvYcCWQQg/3srHRrLgM+2mq93xvyyRpIKpRHUxXBAaHHPJTEDcvFnpwTUN+q+l3vDbIRaV4XviSirr49H4QJSobszs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMB2KFztGQxYOXIBCwv6n/gmNYNuUDG9wdIUHyqXFw6AX4FHOK
	htzqu6Tr46DH1at5Kb0DcwfIhlT80ufIe3OKr/5msadrEpKNR+dQPq9m
X-Gm-Gg: ASbGncsWIOxKg9z0X/iwd84hIrBwuo4oO+wheXzG64qVapkZlE0j6XqQE71BaWEFhvQ
	fW3O4U3l3/+5eZmI8xygbDA2PhXuT9HG7N1cgdJc4WDaWCN9lMuHICbjlzln8GKqKzO0MKjkYBv
	jCItvz+CK2IduNf7pNOD07xeXtZ9OoQL5tdZ7gizyOh9czJklzzdZkWws9CHmmIE2ykprirhYiF
	CsJRidajU0MRWs8wfw8p6EyTfU5NXWkL2qotKiZWbCVDkFCggt3AoQYm9Nz5S2DMYQZXYFRCDhK
	WTGQW8c9/6xLpy1kosoWIbH00kbJZU8PrdHAJRIOGz2rowUKgb46fk1h1z9+NrHTxrXVB51CMES
	21nI=
X-Google-Smtp-Source: AGHT+IHZhKbfGfGlExToAuZziCBuCRIhAlaNu8CAiqEfA2WABvaAnVoam/fkLDfakdBNqSQuPWwwkQ==
X-Received: by 2002:a05:6000:2389:b0:3a4:f439:e715 with SMTP id ffacd0b85a97d-3b4964f3748mr3218286f8f.9.1751643562294;
        Fri, 04 Jul 2025 08:39:22 -0700 (PDT)
Received: from [10.24.66.211] ([15.248.3.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1687196sm29459055e9.21.2025.07.04.08.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 08:39:21 -0700 (PDT)
Message-ID: <048723bf-4a8d-451a-911b-f9f94a4270d7@gmail.com>
Date: Fri, 4 Jul 2025 16:39:20 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
To: Jarkko Sakkinen <jarkko@kernel.org>, Jonathan McDowell <noodles@earth.li>
Cc: "Orlov, Ivan" <iorlov@amazon.co.uk>, "peterhuewe@gmx.de"
 <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li> <aFwnG--lzZO0mQgc@kernel.org>
 <aGeYqQG15lb2_NaU@earth.li> <aGfwPbMZf-SHshXH@kernel.org>
Content-Language: en-US
From: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
In-Reply-To: <aGfwPbMZf-SHshXH@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2025 16:16, Jarkko Sakkinen wrote:
> On Fri, Jul 04, 2025 at 10:02:33AM +0100, Jonathan McDowell wrote:
>> On Wed, Jun 25, 2025 at 07:43:07PM +0300, Jarkko Sakkinen wrote:
>>> On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
>>>> On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
>>>>> The current implementation of timeout detection works in the following
>>>>> way:
>>>>>
>>>>> 1. Read completion status. If completed, return the data
>>>>> 2. Sleep for some time (usleep_range)
>>>>> 3. Check for timeout using current jiffies value. Return an error if
>>>>>    timed out
>>>>> 4. Goto 1
>>>>>
>>>>> usleep_range doesn't guarantee it's always going to wake up strictly in
>>>>> (min, max) range, so such a situation is possible:
>>>>>
>>>>> 1. Driver reads completion status. No completion yet
>>>>> 2. Process sleeps indefinitely. In the meantime, TPM responds
>>>>> 3. We check for timeout without checking for the completion again.
>>>>>    Result is lost.
>>>>>
>>>>> Such a situation also happens for the guest VMs: if vCPU goes to sleep
>>>>> and doesn't get scheduled for some time, the guest TPM driver will
>>>>> timeout instantly after waking up without checking for the completion
>>>>> (which may already be in place).
>>>>>
>>>>> Perform the completion check once again after exiting the busy loop in
>>>>> order to give the device the last chance to send us some data.
>>>>>
>>>>> Since now we check for completion in two places, extract this check into
>>>>> a separate function.
>>>>>
>>>>> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
>>>>> ---
>>>>> V1 -> V2:
>>>>> - Exclude the jiffies -> ktime change from the patch
>>>>> - Instead of recording the time before checking for completion, check
>>>>>   for completion once again after leaving the loop
>>>>>
>>>>> drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
>>>>> 1 file changed, 15 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>>>>> index 8d7e4da6ed53..6960ee2798e1 100644
>>>>> --- a/drivers/char/tpm/tpm-interface.c
>>>>> +++ b/drivers/char/tpm/tpm-interface.c
>>>>> @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
>>>>> 	return chip->ops->req_canceled(chip, status);
>>>>> }
>>>>>
>>>>> +static bool tpm_transmit_completed(struct tpm_chip *chip)
>>>>> +{
>>>>> +	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
>>>>> +
>>>>> +	return status_masked == chip->ops->req_complete_val;
>>>>> +}
>>>>> +
>>>>> static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>>>> {
>>>>> 	struct tpm_header *header = buf;
>>>>> @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>>>> 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
>>>>> 	do {
>>>>> 		u8 status = tpm_chip_status(chip);
>>>>> -		if ((status & chip->ops->req_complete_mask) ==
>>>>> -		    chip->ops->req_complete_val)
>>>>> +		if (tpm_transmit_completed(chip))
>>>>> 			goto out_recv;
>>>>
>>>> The only thing I'd point out here is we end up doing a double status read
>>>> one after the other (once here, once in tpm_transmit_completed), and I'm
>>>> pretty sure I've seen instances where that caused a problem.
>>>
>>> It would be easy to to prevent at least double reads after completion
>>> e.g., in tpm_chip_status():
>>
>> Or just take the simple approach and make the check after the while loop:
>>
>> 	if ((tpm_chip_status(chip) & chip->ops->req_complete_mask) ==
>> 	    chip->ops->req_complete_val)
>> 		goto out_recv;
>>
>> There might be potential for a longer term cleanup using chip->status to
>> cache things, but I'm little concerned that's going to open paths where we
>> might not correctly update it, so I think it should be a separate piece.
>>
>> (I'm motivated by the fact we've started to see the "Operation Canceled"
>> error and I'd like us to close on the best way to fix it. :) )
> 
> This would work for me too!
> 

Hi, and sorry for the late reply :(

I believe this option would work for us as well. Please let me know 
whether you'd like me to send V3 or you feel free to send it yourself if 
you want.

--
Kind regards,
Ivan Orlov

