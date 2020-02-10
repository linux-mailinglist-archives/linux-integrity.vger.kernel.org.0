Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5D15855F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 23:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBJWTB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 17:19:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38398 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWTB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 17:19:01 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 031B320B9C02;
        Mon, 10 Feb 2020 14:19:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 031B320B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581373141;
        bh=TI0cJ46BJu6j76vLmheZmnSllVJDhav+Cmu8YLFU14c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ovNduz9pAqHO+vsqTFZoAmdgF2sLVCPwVgj1QjS9b9N3GxtFGB0kyPgfz7MY/ZRQF
         pYGFMEg2xpgAJvMi8T8NOH9G8rOoWnZtD0Djm8N4MhLWTXdjbpXu6eBamBLUn7O2g4
         LO9qld0wPdmsqpFuwv7CMHhHjGWN9CMdT4OmyeJ0=
Subject: Re: [PATCH] IMA: Add log statements for failure conditions.
To:     Mimi Zohar <zohar@linux.ibm.com>, Joe Perches <joe@perches.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, khan@linuxfoundation.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
 <20200207195346.4017-2-tusharsu@linux.microsoft.com>
 <1581253027.5585.671.camel@linux.ibm.com>
 <da7bd0441ef3044cb40d705b8bb176bfdf391557.camel@perches.com>
 <41d61aa5-db98-6291-d91f-104f029c897f@linux.microsoft.com>
 <13eb9760ba13cee2f25c74c665198faac6a5a2f3.camel@perches.com>
 <0c9099b5-da29-3e71-0933-123dfe08442c@linux.microsoft.com>
 <1581371178.5585.913.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <58176dbd-f680-c937-9975-af02685a056d@linux.microsoft.com>
Date:   Mon, 10 Feb 2020 14:19:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581371178.5585.913.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Mimi.

On 2020-02-10 1:46 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Mon, 2020-02-10 at 13:33 -0800, Tushar Sugandhi wrote:
>> On 2020-02-10 8:50 a.m., Joe Perches wrote:
>>> On Mon, 2020-02-10 at 08:40 -0800, Lakshmi Ramasubramanian wrote:
>>>> On 2/9/20 6:46 PM, Joe Perches wrote:
>>>>
>>>>>> In addition, as Shuah Khan suggested for the security/integrity/
>>>>>> directory, "there is an opportunity here to add #define pr_fmt(fmt)
>>>>>> KBUILD_MODNAME ": " fmt to integrity.h and get rid of duplicate
>>>>>> defines."
>>>> Good point - we'll make that change.
>>>>
>>>> With Joe Perches patch (waiting for it to be re-posted),
>>>>>> are all the pr_fmt definitions needed in each file in the
>>>>>> integrity/ima directory?
>>>>> btw Tushar and Lakshmi:
>>>>>
>>>>> I am not formally submitting a patch here.
>>>>>
>>>>> I was just making suggestions and please do
>>>>> with it as you think appropriate.
>>>> Joe - it's not clear to me what you are suggesting.
>>>> We'll move the #define for pr_fmt to integrity.h.
>>>>
>>>> What's other changes are you proposing?
>>> https://lore.kernel.org/lkml/4b4ee302f2f97e3907ab03e55a92ccd46b6cf171.camel@perches.com/
>>>
>> Thanks Joe.
>>
>> Joe, Shuah:
>>
>> Could one of you please clarify if the changes proposed in the above URL
>> will be part of Shuah's future patchset?
>>
>> Or should I include those in my patchset? I am referring to the
>> following snippet in security/integrity/integrity.h.
> 
> Joe is saying that he made some suggestions, which Shuah commented on,
> but has no intention of posting a formal patch.  The end result of
> that discussion is to define pr_fmt once in integrity/integrity.h and
> remove any duplication in the integrity/ files.
> 
> I'd appreciate your including that change in this patch set, and if
> needed a similar one in ima/ima.h.
I will add the proposed change to pr_fmt to this patchset.
I will also check if a similar change is needed in ima/ima.h.
> 
> thanks,
> 
> Mimi
> 
