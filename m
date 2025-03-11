Return-Path: <linux-integrity+bounces-5236-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9DA5D352
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624E43B8C10
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72A2356CF;
	Tue, 11 Mar 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QbnG89nP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6D233159;
	Tue, 11 Mar 2025 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736714; cv=none; b=D237k7aFQksmWsW99kPWBADvjxdZnPk1ojY1WoUIrNh+0xiBCMqg5cn1FwrctVMaEUdnRv6l0q1/t7A5m+eFo8CHmyprcNMurLkpLX5MbmRzmZoKce8Q5XVuBtE4iqz3rXxhUzGL0QvEyYq6PakgcZHj/vvRxFks0Nzi+9EUSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736714; c=relaxed/simple;
	bh=WJxfrA9P0lTPif/rSZgxPJY3TmY+1BcIVavMPTrLyVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ij5EaZs87/9g0yVwflHTvtJ0qKRfCt7UhiwfyYXmKGAdMid1+XIqINAKSb3qlrnsS5eOQePUvyrhqZcxoBN+KZwrl0bslz17ppoCyhZ5x7U9kwt6D3x1ejud4yV5mVfEDyY5hup7pNHgdQgX7+jvve9hvF4smm4Zb8XGJUMe+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QbnG89nP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.106] (unknown [131.107.1.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 31B3D2045FE6;
	Tue, 11 Mar 2025 16:45:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31B3D2045FE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741736712;
	bh=glSiauzVyj5TpLPTPm8NokxVZzNbbmHbEu15WDGOzEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QbnG89nPuznMR4y1um2+WpeUgFAWN+cSKpbbFCY0CZ6BbVtYRj36XwUOl2La2ZtgM
	 qHDla5pUHmQcAVc3ubJSgLl1id0h/ReIkhzSDMOu2kmXmu5NZaeDI/EzqlGPhjmgld
	 jRd56jOpbDqDoh9kSebk1g7Khjhgqd1s/amhakBw=
Message-ID: <a952eaa2-faf4-4312-87bd-7cb6a9100df5@linux.microsoft.com>
Date: Tue, 11 Mar 2025 16:45:11 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records across
 kexec
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-2-chenste@linux.microsoft.com>
 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
 <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
 <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
 <69f43be0ed70eee45d3d9d9ac2aeaf39def5770a.camel@linux.ibm.com>
 <631f326006226e23f4f755fd32255792f6514a90.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <631f326006226e23f4f755fd32255792f6514a90.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/2025 5:44 AM, Mimi Zohar wrote:
> On Thu, 2025-03-06 at 21:51 -0500, Mimi Zohar wrote:
>> On Thu, 2025-03-06 at 14:45 -0800, steven chen wrote:
>>> On 3/5/2025 4:27 AM, Mimi Zohar wrote:
>>>> On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
>>>>> On 03/04/25 at 11:03am, steven chen wrote:
>>>>>> Carrying the IMA measurement list across kexec requires allocating a
>>>>>> buffer and copying the measurement records.  Separate allocating the
>>>>>> buffer and copying the measurement records into separate functions in
>>>>>> order to allocate the buffer at kexec 'load' and copy the measurements
>>>>>> at kexec 'execute'.
>>>>>>
>>>>>> This patch includes the following changes:
>>>>> I don't know why one patch need include so many changes. From below log,
>>>>> it should be split into separate patches. It may not need to make one
>>>>> patch to reflect one change, we should at least split and wrap several
>>>>> kind of changes to ease patch understanding and reviewing. My personal
>>>>> opinion.
>>>> Agreed, well explained.
>>>>
>>>> Mimi
>>>>
>>>>>>    - Refactor ima_dump_measurement_list() to move the memory allocation
>>>>>>      to a separate function ima_alloc_kexec_file_buf() which allocates
>>>>>>      buffer of size 'kexec_segment_size' at kexec 'load'.
>>>>>>    - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>>>>>      a local static to the file, so that it can be accessed from
>>>>>>      ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>>>>>      there is enough memory for the entire measurement record.
>>>>>>    - Copy only complete measurement records.
>>>>>>    - Make necessary changes to the function ima_add_kexec_buffer() to call
>>>>>>      the above two functions.
>>>>>>    - Compared the memory size allocated with memory size of the entire
>>>>>>      measurement record. Copy only complete measurement records if there
>>>>>>      is enough memory. If there is not enough memory, it will not copy
>>>>>>      any IMA measurement records, and this situation will result in a
>>>>>>      failure of remote attestation.
>>>>>>
>>>>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>> I will split this patch into the following two patches:
>>>
>>>       ima: define and call ima_alloc_kexec_file_buf
>>>       ima: copy measurement records as much as possible across kexec
>> Steven, breaking up code into patches is in order to simplify patch review.
>> This is done by limiting each patch to a single "logical change" [1].  For
>> example, the change below has nothing to do with "separate allocating the buffer
>> and copying the measurement records into separate functions".
>>
>>          /* This is an append-only list, no need to hold the RCU read lock */
>>          list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
>> -               if (file.count < file.size) {
>> +               entry_size += ima_get_binary_runtime_entry_size(qe->entry);
>> +               if (entry_size <= segment_size) {
>>                          khdr.count++;
>> -                       ima_measurements_show(&file, qe);
>> +                       ima_measurements_show(&ima_kexec_file, qe);
>>                  } else {
>>                          ret = -EINVAL;
>> +                       pr_err("IMA log file is too big for Kexec buf\n");
>>                          break;
>>                  }
>>          }
>>
>> The original code potentially copied a partial last measurement record, not a
>> complete measurement record.  For ease of review, the above change is fine, but
>> it needs to be a separate patch.
>>
>> Patches:
>> 1. ima: copy only complete measurement records across kexec
>> 2. ima: define and call ima_alloc_kexec_file_buf()
> Steven,
>
> The alternative would be to revert using ima_get_binary_runtime_entry_size() and
> simply use "ima_kexec_file.count < ima_kexec_file.size".  Only
> ima_kexec_file.size would be initialized in ima_alloc_kexec_buf().  The rest
> would remain in ima_dump_measurement_list().  get_binary_runtime_size() wouldn't
> need to be made global.
>
> To further simplify the patch review, first define a separate patch to just
> rename the seq_file "file" to "ima_kexec_file".
>
> Mimi

Hi Mimi,

I will work on it.

Thanks,

Steven


