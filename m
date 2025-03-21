Return-Path: <linux-integrity+bounces-5359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E9A6BFBE
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31F1188FDC7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF14B22AE76;
	Fri, 21 Mar 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kfOmQNWA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490722B8C4;
	Fri, 21 Mar 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573903; cv=none; b=H1bg831xOhiRy1B4VE8310lmh72fFzzg+H5acgEvM+qGTLN3XWLAwuDr2KiMqFoNEnOLCZg2pRNq+gjT+ED4a+QnsZL+/ZyVfjWv0sgpjQZBCAXC21X2o1tuZ8O27uenxp2Of4oX8+3BxqZsdpXgp+JOhXaa7p/DCcXEeNEFroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573903; c=relaxed/simple;
	bh=DJCH7ueIUm8zn+Nmq0dL4A36uMUfzDskfEgbmVv5vKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9xMf0haqb3OPbzyP14+fckdfaG1QeAWIvIK4nMzEdM+vEyzaEW6UeG/RhhrQUXyf/SVQPsFwgQuhxTIamedK70fFM2GPBRyJv+kolz3lEoLTHO/JjiXQtJ7wF+gvu3DsGn7jdtZYx0Sxt4hW4Gx463jsiBXZlTIcefkL9YAnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kfOmQNWA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95414202537E;
	Fri, 21 Mar 2025 09:18:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95414202537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742573901;
	bh=bREkR7Q4lq1SSvQYMg6DzgXSYgZuwjodek6Of27CdyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kfOmQNWAKkEYR30lvRiIVJDKpN6tjU/J3lpJFFShJOuoaAUJh5Y9O7BnWZFvlebN1
	 Hq2OHcxk8rSb9nvfQjnXFP3u9xTUlTc1vW5lqrd8oIlWKoOaMuPAPvAdmkX6+3M7lI
	 9Dt1QL2GGYad15+DeADgtjzAZ9WfRd4w2AIobkZI=
Message-ID: <798d64a7-eb93-433d-ab6b-37a7c5d89412@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:18:22 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-3-chenste@linux.microsoft.com>
 <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
 <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
 <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
 <a8368f2402e1145c134e445d015c434140874e06.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <a8368f2402e1145c134e445d015c434140874e06.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/2025 6:06 AM, Mimi Zohar wrote:
> On Thu, 2025-03-20 at 09:51 +0800, Baoquan He wrote:
>>>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>>>> index 8567619889d1..45170e283272 100644
>>>>> --- a/security/integrity/ima/ima_kexec.c
>>>>> +++ b/security/integrity/ima/ima_kexec.c
>>>>> @@ -15,6 +15,48 @@
>>>>>    #include "ima.h"
>>>>>    
>>>>>    #ifdef CONFIG_IMA_KEXEC
>>>>> +static struct seq_file ima_kexec_file;
>>>>> +
>>>>> +static void ima_reset_kexec_file(struct seq_file *sf)
>>>>> +{
>>>>> +	sf->buf = NULL;
>>>>> +	sf->size = 0;
>>>>> +	sf->read_pos = 0;
>>>>> +	sf->count = 0;
>>>>> +}
>>>>> +
>>>>> +static void ima_free_kexec_file_buf(struct seq_file *sf)
>>>>> +{
>>>>> +	vfree(sf->buf);
>>>>> +	ima_reset_kexec_file(sf);
>>>>> +}
>>>>> +
>>>>> +static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>>> +{
>>>>> +	/*
>>>>> +	 * kexec 'load' may be called multiple times.
>>>>> +	 * Free and realloc the buffer only if the segment_size is
>>>>> +	 * changed from the previous kexec 'load' call.
>>>>> +	 */
>>>>> +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
>>>>> +		goto out;
>>> The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
>>> ima_kexec_file.buf() hiding the fact that the above test always fails and falls
>>> through.  As a result, 'buf' is always being re-allocated.
> Hi Steven,
>
> [Reiterating the comment in the "ima: kexec: move IMA log copy from kexec load
> to execute" thread, here, for completeness.]
>
> Instead of adding and then removing the ima_reset_kexec_file() call from
> ima_add_kexec_buffer(), defer adding the segment size test to when it is
> actually possible for the segment size to change. Please make the segment size
> test as a separate patch.
>
> ima_reset_kexec_file() will then only be called by ima_free_kexec_file_buf().
> Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().
>
> thanks,
>
> Mimi

Hi Mimi,

I will update in next version.

Thanks,

Steven


