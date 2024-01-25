Return-Path: <linux-integrity+bounces-890-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8B83CBFC
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 20:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D148A1C223E7
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D2134720;
	Thu, 25 Jan 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h+8GQMfz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBB1350CA
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210099; cv=none; b=pNNmQ2cpLgXYkSy39nJ+v0y+KpPcBq3BZ1B/KeV1jjg7I0KH6Uph/6ViMsaoYj+YpbDl3x31OtJN5mI8X2LEUoHun5KpOGr/YAL1FVCl+TkLmbZj3jog1oe7J40USPAHPtkNLyw/X6GGzsnIUPAEzc63aNxUvJJpNnetjC+yfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210099; c=relaxed/simple;
	bh=z6rPZ89/w+1zCBKYqNvvrcAIpVeXX/AF79kdW3Jz9fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWN3E4O354MHI4e/NcgDncAHLR7sxAeGJcIJf4pzC/O89GN5KDJGrk3C4Opst0pe6oYOMEpzQOB/f7WUb17c10SJTJpaiHqTv9XCmT/0mEpQM4ay96qIsQOfhg0I9CCDYA4wsd2uytBv163y4XPT4hLZ4Mqf/Ca/qjG6PQSUvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h+8GQMfz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 628A020E56B9;
	Thu, 25 Jan 2024 11:14:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 628A020E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706210097;
	bh=imB7GEmJRnpBmqjAfJIzLKPCa+cI90b46QJV+T438zM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+8GQMfzeS5nZJjz4KsL3R51MaGu9oHzZZ04j/wOkJsGBTJwlqYO5+L9Z6SFIfBih
	 dHbFB7yhEuEpLepq9OOs8+ZQB+88ultvx4qy1nJ+SV7vn60NZg0z1H9MTUoZ71u+4k
	 fehrYpDRP9xi/ikfQziSmgZ8Ev9BezJ+w3bmwzgs=
Message-ID: <2bdabacb-fafb-48c5-9328-6749f70f9a96@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:14:57 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
 <e2b67ca4e3f0869bcab683feef9b8f4ad773e38e.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e2b67ca4e3f0869bcab683feef9b8f4ad773e38e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 06:07, Mimi Zohar wrote:
> 
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>>   				  .top_down = true };
>>   	unsigned long binary_runtime_size;
>> +	unsigned long extra_size;
>>   
>>   	/* use more understandable variable names than defined in kbuf */
>>   	void *kexec_buffer = NULL;
>> @@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added during kexec.
>>   	 */
> 
> The memory is still being allocated at kexec "load",  so the extra memory is for
> additional measurement records "since" kexec load.
> 
> Mimi
> 
This wording was an attempt to address the comment in v3[1].
So I tried to make the comment generic.  But maybe I made it too generic.
I will update.

[1] Re: [PATCH v3 6/7] ima: configure memory to log events between kexec 
load and execute
https://lore.kernel.org/all/fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com/

"Additional records could be added as a result of the kexec
load itself.
...
Please remove any references to measurements between kexec load and
execute."

~Tushar

>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
>> +		extra_size = PAGE_SIZE / 2;
>> +	else
>> +		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
>> +
>>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>   		kexec_segment_size = ULONG_MAX;
>>   	else
>> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -					   PAGE_SIZE / 2, PAGE_SIZE);
>> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>   	if ((kexec_segment_size == ULONG_MAX) ||
>>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>   		pr_err("Binary measurement list too large.\n");
> 

