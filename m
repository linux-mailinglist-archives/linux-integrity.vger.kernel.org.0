Return-Path: <linux-integrity+bounces-736-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337982B45F
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCCF1F242A2
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D652F78;
	Thu, 11 Jan 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d+Q1w/wM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D7652F74
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F7BA20B3CC1;
	Thu, 11 Jan 2024 09:56:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F7BA20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704995765;
	bh=bjDCby8arrnCLXKoPLXG5spNzDaZaj7J3NIFKAE7WLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+Q1w/wMPcaJqMMjIY8snExyEKPtVO+I+LBkepU8x1truvKczkDoaCu5fW2rMK4ZX
	 4hv1052godKnPSya4ggfTvI0z13UEOsHFRnigBnQycASElCjbtB2Ul7NgDQDwLu/6c
	 AaQTiHcvhi0WcTdOi/ehkDuy9cVJXerHOtkRpGP0=
Message-ID: <fcc6cf08-083c-4013-a164-359b2a2140b3@linux.microsoft.com>
Date: Thu, 11 Jan 2024 09:56:03 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
 <0c98853722d57472d451e7838d4b1176665de1c0.camel@linux.ibm.com>
 <db16303d-44b7-45d2-b844-cf4d7fe89647@linux.microsoft.com>
 <ddd990a0faeb79260709b973b2b959a89e6c65bc.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <ddd990a0faeb79260709b973b2b959a89e6c65bc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/24 06:24, Mimi Zohar wrote:
> On Fri, 2024-01-05 at 12:22 -0800, Tushar Sugandhi wrote:
>>>> @@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>>>>               return ret;
>>>>       }
>>>>    
>>>> +    buf_size = ima_get_binary_runtime_size();
>>>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>>> +              "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
>>>> +              kexec_segment_size, buf_size);
>>>> +
>>>> +    ima_measure_critical_data("ima_kexec", "kexec_execute",
>>>> +                              ima_kexec_event, strlen(ima_kexec_event),
>>>> +                              false, NULL, 0);
>>>> +
>>>
>>> Please consider including the number of measurement records as well.
>> Will do. I think that would be valuable information.
>>
>> Per my understanding, I will have to use the function
>> ima_show_measurements_count() or ima_show_htable_value() to get the
>> number of measurement records value[1]. So I will have to expose that
>> function from "ima_fs.c" to "ima_kexec.c". Hope that's ok.
>>
>> [1]
>> https://elixir.bootlin.com/linux/latest/sourcesecurity/integrity/ima/ima_fs.c
>>
>>
>> static ssize_t ima_show_measurements_count(struct file *filp,
>>                                            char __user *buf,
>>                                            size_t count, loff_t *ppos)
>> {
>>           return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
> 
> I don't see a need to expose this function.  ima_htable is defined in ima.h.
> You can read the ima_htable.len directly, as ima_show_htable_value does.
> 
Agreed. Thanks for the pointer.
That's what I concluded too when I was implementing this change.
I will use ima_htable.len directly.

~Tushar


