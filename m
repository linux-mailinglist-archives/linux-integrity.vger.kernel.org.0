Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3B15B639
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 01:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgBMA43 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 19:56:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42806 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgBMA42 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 19:56:28 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id E437D20B9C02;
        Wed, 12 Feb 2020 16:56:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E437D20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581555388;
        bh=YGpo1uJZoJHFEn8VACUXkZRT8lfDnUmVI/rXjbWuwS8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CT3K2yfokZFCc3456yB6+C+LQHx7RHFHdXdX9ASjQVswRHV+QJa92lq3CjSPV6zfJ
         xkByTFgtU/PFXc0m+Dxd/6HU355FNkYnKa/sk3/ro+eecbqaiBPbJZ6zssB+N/7twM
         mg8qxxGjFY/5GpzLdrd4kf91TbpiiYf3bC4B5aDk=
Subject: Re: [PATCH v3 3/3] IMA: Add module name and base name prefix to log.
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        joe@perches.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
 <20200211231414.6640-4-tusharsu@linux.microsoft.com>
 <1581517770.8515.35.camel@linux.ibm.com>
 <1581521161.3494.7.camel@HansenPartnership.com>
 <d428f807-7e67-a173-183d-f2ab15bdef9e@linuxfoundation.org>
 <1581554308.8515.108.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <4086eda1-1155-6ca7-7b63-187ffaa03d3f@linux.microsoft.com>
Date:   Wed, 12 Feb 2020 16:56:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581554308.8515.108.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-02-12 4:38 p.m., Mimi Zohar wrote:
> On Wed, 2020-02-12 at 15:52 -0700, Shuah Khan wrote:
>> On 2/12/20 8:26 AM, James Bottomley wrote:
>>> On Wed, 2020-02-12 at 09:29 -0500, Mimi Zohar wrote:
>>>> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
>>>>> The #define for formatting log messages, pr_fmt, is duplicated in
>>>>> the
>>>>> files under security/integrity.
>>>>>
>>>>> This change moves the definition to security/integrity/integrity.h
>>>>> and
>>>>> removes the duplicate definitions in the other files under
>>>>> security/integrity. Also, it adds KBUILD_MODNAME and
>>>>> KBUILD_BASENAME prefix
>>>>> to the log messages.
>>>>>
>>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>>> Suggested-by: Joe Perches <joe@perches.com>
>>>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>
>>>> <snip>
>>>>
>>>>> diff --git a/security/integrity/integrity.h
>>>>> b/security/integrity/integrity.h
>>>>> index 73fc286834d7..b1bb4d2263be 100644
>>>>> --- a/security/integrity/integrity.h
>>>>> +++ b/security/integrity/integrity.h
>>>>> @@ -6,6 +6,12 @@
>>>>>     * Mimi Zohar <zohar@us.ibm.com>
>>>>>     */
>>>>>    
>>>>> +#ifdef pr_fmt
>>>>> +#undef pr_fmt
>>>>> +#endif
>>>>> +
>>>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " KBUILD_BASENAME ": " fmt
>>>>> +
>>>>>    #include <linux/types.h>
>>>>>    #include <linux/integrity.h>
>>>>>    #include <crypto/sha.h>
>>>>
>>>> Joe, Shuah, including the pr_fmt() in integrity/integrity.h not only
>>>> affects the integrity directory but everything below it.  Adding
>>>> KBUILD_BASENAME to pr_fmt() modifies all of the existing IMA and EVM
>>>> kernel messages.  Is that ok or should there be a separate pr_fmt()
>>>> for the subdirectories?
>>>
>>
>>> Log messages are often consumed by log monitors, which mostly use
>>> pattern matching to find messages they're interested in, so you have to
>>> take some care when changing the messages the kernel spits out and you
>>> have to make sure any change gets well notified so the distributions
>>> can warn about it.
>>>
>>> For this one, can we see a "before" and "after" message so we know
>>> what's happening?
>>>
>>
>> Mimi and James,
>>
>> My suggestion was based on thinking that simplifying this by removing
>> duplicate defines. Some messages are missing modules names, adding
>> module name to them does change the messages.
>>
>> If using one pr_fmt for all modules changes the world and makes it
>> difficult for log monitors, I would say it isn't a good change.
>>
>> I will leave this totally up to Mimi to decide. Feel free to throw
>> out my suggestion if it leads more trouble than help. :)
> 
> Thanks, Shuah.  Tushar, I don't see any need for changing the existing
> IMA/EVM messages.  Either remove the KBUILD_BASENAME from the format
> or limit the new format to the integrity directory.
Ok. I will remove the KBUILD_BASENAME from the format.
And I will keep the definition in security/integrity/integrity.h, and 
will keep the duplicates removed - as originally proposed in this patch 
v3 3/3.

> 
> thanks,
> 
> Mimi
> 
