Return-Path: <linux-integrity+bounces-670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40E825B34
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 20:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D112856F2
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 19:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1435EF7;
	Fri,  5 Jan 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c7dpog5K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F735F09
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jan 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85E2E20ACF28;
	Fri,  5 Jan 2024 11:47:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85E2E20ACF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704484056;
	bh=//O+s2IfcYrX6IMP4gFeQbnbUrrcIy652CQFn9huHd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c7dpog5Kw6vi7OmOvfTXHy41bnAunvDs2O0xeOHploiw1/+jAzghfY5X5j0FDB9Vk
	 3FIikwBHk7L/lkLoUrrjg61781w7Y9G7DKF9xgTZxX30wmllyCKa+acI/k6nny7ViG
	 vmXVaETnyxhbMTzl5+zSHuIdXyOqJOK0Pbfs957k=
Message-ID: <81a68238-614d-4576-91ef-1b12771d6c14@linux.microsoft.com>
Date: Fri, 5 Jan 2024 11:47:34 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-2-tusharsu@linux.microsoft.com>
 <ea2a4524bfd0af5515a547ce6e7fbbec8067e490.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ea2a4524bfd0af5515a547ce6e7fbbec8067e490.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Mimi for the feedback on V3.

Sorry for the late response, I was on vacation during the holidays.

Responses inline.

Happy new year! :)

On 12/20/23 08:13, Mimi Zohar wrote:
> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> Refactor ima_dump_measurement_list() to move the memory allocation part
>> to a separate function ima_alloc_kexec_file_buf() to allocate buffer of
>> size 'kexec_segment_size' at kexec 'load'.  Make the local variables in
>> function ima_dump_measurement_list() global, so that they can be accessed
>> from ima_alloc_kexec_file_buf().
> 
> Only ima_kexec_file is being moved and does not need to be global, but
> should be defined as local static.
> 

Will do.
I followed your comment on V2 of this series [1], and didn't make the
change last time. But making it local static scoped to this source file
(ima_kexec.c) makes sense.


[1] From v2 of this series
https://lore.kernel.org/all/2c9e3b71-5416-4336-82f1-cd78e26dd62e@linux.microsoft.com/
 >> Define "ima_kexec_file" as static since it only used in this file.
 >> Since the variable does not need to be global, is there still a reason
 >> for changing its name?   Minimize code change.
 >
 > Adding "static" would make ima_kexec_file a global static variable.
 > Please ignore my comment about reverting the variable name change.
 >
 > Mimi
 >


>> Make necessary changes to the function
>> ima_add_kexec_buffer() to call the above two functions.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 96 +++++++++++++++++++++---------
>>   1 file changed, 67 insertions(+), 29 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 419dc405c831..ae27101d0615 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,62 +15,93 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +struct seq_file ima_kexec_file;
> 
> ^static.
> 
Will do.

>> +void ima_free_kexec_file_buf(struct seq_file *sf)
> 
> ^static
Will do.

~Tushar
> 
>> +{
>> +	vfree(sf->buf);
>> +	sf->buf = NULL;
>> +	sf->size = 0;
>> +	sf->read_pos = 0;
>> +	sf->count = 0;
> 
> --
> thanks,
> 
> Mimi

