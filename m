Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E239515B3B1
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 23:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgBLWa1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 17:30:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47882 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWa1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 17:30:27 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8670020B9C02;
        Wed, 12 Feb 2020 14:30:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8670020B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581546626;
        bh=NUHobxfL+geUi+bYVC6mVUzTu5F8T6tQj72MtVtjTGg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=emcoU9vBbJ592sx4KQcu6JfCoKEWTR6ew1L19xR88+ixXeBb49RETwSge7xyTZB8U
         YlmtOoxJRqG6PtdHijT44jEe4ibgxh7cqmjB4FtYZNoxp3u1SHfLXT7kLGJ4shDrUn
         2/eRY636y4r2i4hzN95XuUfz/30de3V5hKpoYPiY=
Subject: Re: [PATCH v3 2/3] IMA: Add log statements for failure conditions.
To:     Mimi Zohar <zohar@linux.ibm.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
 <20200211231414.6640-3-tusharsu@linux.microsoft.com>
 <1581518823.8515.49.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <ce89d382-8e8b-71d0-5271-4db83d324f94@linux.microsoft.com>
Date:   Wed, 12 Feb 2020 14:30:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581518823.8515.49.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-02-12 6:47 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> Please remove the period at the end of the  Subject line.
Thanks. I will fix it in the next iteration.
> 
> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
>> process_buffer_measurement() does not have log messages for failure
>> conditions.
>>
>> This change adds a log statement in the above function.
> 
> I agree some form of notification needs to be added.  The question is
> whether the failure should be audited or a kernel message emitted.
>   IMA emits audit messages (integrity_audit_msg) for a number of
> reasons - on failure to calculate a file hash, invalid policy rules,
> failure to communicate with the TPM, signature verification errors,
> etc.
I believe both IMA audit messages and kernel message should be emitted -
for better discoverability and diagnosability.
> 
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Joe Perches <joe@perches.com>
>> ---
>>   security/integrity/ima/ima_main.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 9fe949c6a530..6e1576d9eb48 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
>>   		ima_free_template_entry(entry);
>>   
>>   out:
>> +	if (ret < 0)
>> +		pr_err("%s: failed, result: %d\n", __func__, ret);
>> +
>>   	return;
>>   }
>>   
> 
> With 3/3 "IMA: Add module name and base name prefix to log", the
> resulting message will be "KBUILD_MODNAME: KBUILD_BASENAME: func:".
>   Isn't that a bit much?
> 
For this specific message, it will look like below.
"ima: ima_main: process_buffer_measurement: failed, result: %d"

In general, adding KBUILD_BASENAME seems helpful to pinpoint the 
location of the issue.


> Mimi
> 
