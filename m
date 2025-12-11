Return-Path: <linux-integrity+bounces-7931-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D13CB743B
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 23:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2609B302C23F
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 22:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079A2957C2;
	Thu, 11 Dec 2025 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bk+tlOQd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BD26D4F7;
	Thu, 11 Dec 2025 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490815; cv=none; b=un4MPIuciWbhwLgXbtnGPpRTvSX+AjgZSdxJZYxYXu2QYmz28G37peoJbHyMFezoQfOjO91RklTPxIM9AmpXLltXTHZKFq4mOEpYFPZ0J/CKQgkS3RqHdkzKlZI/ImS4W36UUoT2zfVJuVvOWSvn2DGaHsKXiQ8bcJ3cdc93+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490815; c=relaxed/simple;
	bh=nUtalkbD6QrDRv0OfEjeVGb+R8K62ZWJbHWqzS8WP6g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kT0wC1jAU6SUj8N1of5wsAxwKUtl5IrxrjiquYRwWOT7jrUBY9qD6DDXiycqLT0kNvX3nq/zHObPPAK0Y1YFBPpL8YviY9yOI56Qi8hshUK4L61tI9LHm/LSYhKaXWjMoVWFAYB5uXaw0/HJA6R1BwOp46TYcbTpyfvW1hhy1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bk+tlOQd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.150] (unknown [131.107.8.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B0842016010;
	Thu, 11 Dec 2025 14:06:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B0842016010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765490812;
	bh=0pGrHYxA8ivdEM4MAPDqLcRoJM2t5LZqyRAyL5kQDyY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bk+tlOQd1ZU8+0BL4CVcBdPgTyUHO+lgTuZmaonfc67WjPdb8PIJj3ujI73PIXvNG
	 ZffSPM6N66q9AVVEMxqhK1Xg9LPi5JoPFWgFjV5VZv/XOornDe/1I7IBoqN4sZZOUq
	 AgmVSXEdOsPRbG39CvdKFgI4FjhV60StgKRwaTiw=
Message-ID: <877e2fec-febf-4568-9b00-059094d1c23b@linux.microsoft.com>
Date: Thu, 11 Dec 2025 14:06:50 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
From: steven chen <chenste@linux.microsoft.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
 <9cb4cbab-bcca-4ac8-a7a5-0cf3de67353e@linux.microsoft.com>
 <d6ef2d61a2c31c0ae46741b6bd78f38bc02e6141.camel@huaweicloud.com>
 <b701686d-212e-4152-9db9-0c56f21e1fdc@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <b701686d-212e-4152-9db9-0c56f21e1fdc@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2025 11:20 AM, steven chen wrote:
> On 12/11/2025 2:18 AM, Roberto Sassu wrote:
>> On Wed, 2025-12-10 at 16:03 -0800, steven chen wrote:
>>> On 12/9/2025 2:17 AM, Roberto Sassu wrote:
>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>
>>>> Introduce the ability of staging the entire of the IMA measurement 
>>>> list, or
>>>> a portion, for deletion. Staging means moving the current content 
>>>> of the
>>>> measurement list to a separate location, and allowing users to read 
>>>> and
>>>> delete it. This causes the measurement list to be atomically truncated
>>>> before new measurements can be added. Staging can be done only once 
>>>> at a
>>>> time.
>>>>
>>>> User space is responsible to concatenate the staged IMA 
>>>> measurements list
>>>> portions following the temporal order in which the operations were 
>>>> done,
>>>> together with the current measurement list. Then, it can send the 
>>>> collected
>>>> data to the remote verifiers.
>>>>
>>>> The benefit of this solution is the ability to free precious kernel 
>>>> memory,
>>>> in exchange of delegating user space to reconstruct the full 
>>>> measurement
>>>> list from the chunks. No trust needs to be given to user space, 
>>>> since the
>>>> integrity of the measurement list is protected by the TPM.
>>>>
>>>> By default, staging the measurements list for deletion does not 
>>>> alter the
>>>> hash table. When staging is done, IMA is still able to detect 
>>>> collisions on
>>>> the staged and later deleted measurement entries, by keeping the entry
>>>> digests (only template data are freed).
>>>>
>>>> However, since during the measurements list serialization only the 
>>>> SHA1
>>>> digest is passed, and since there are no template data to 
>>>> recalculate the
>>>> other digests from, the hash table is currently not populated with 
>>>> digests
>>>> from staged/deleted entries after kexec().
>>>>
>>>> Introduce the new kernel option ima_flush_htable to decide whether 
>>>> or not
>>>> the digests of staged measurement entries are flushed from the hash 
>>>> table.
>>>>
>>>> Then, introduce ascii_runtime_measurements_staged_<algo> and
>>>> binary_runtime_measurement_staged_<algo> interfaces to stage/delete 
>>>> the
>>>> measurements. Use 'echo A > <IMA interface>' and 'echo D > <IMA 
>>>> interface>'
>>>> to respectively stage and delete the entire measurements list. Use
>>>> 'echo N > <IMA interface>', with N between 1 and ULONG_MAX, to 
>>>> stage the
>>>> selected portion of the measurements list.
>>>>
>>>> The ima_measure_users counter (protected by the ima_measure_lock 
>>>> mutex) has
>>>> been introduced to protect access to the measurement list and the 
>>>> staged
>>>> part. The open method of all the measurement interfaces has been 
>>>> extended
>>>> to allow only one writer at a time or, in alternative, multiple 
>>>> readers.
>>>> The write permission is used to stage/delete the measurements, the 
>>>> read
>>>> permission to read them. Write requires also the CAP_SYS_ADMIN 
>>>> capability.
>>> Hi Roberto,
>>>
>>> I released version 2 of trim N entries patch as bellow:
>>>
>>> [PATCH v2 0/1] Trim N entries of IMA event logs
>>> <https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t> 
>>>
>>>
>>> I adapted some of your idea and I think trim N has following 
>>> advantages:
>>> 1: less measurement list hold time than your current implementation
>>> 2. operation much simple for user space
>>> 3. less kernel code change
>>> 4. no potential issue as Gregory mentioned.
>> Please have a look at:
>>
>> https://marc.info/?l=linux-integrity&m=176545085325473&w=2
>>
>> and let me know if I'm missing something.
>>
>> Thanks
>>
>> Roberto
>
> Hi Roberto,
>
> what does this staging solution do that's not achieved by trim N 
> entries solution?
>
> You did not address all my comments and your other idea make things 
> more complex.

The following are steps for both proposals:

     the steps for trim N solution:
         1. User space reads list without lock
         2. User space decides to trim N entries and send command to kernel
         3. Kernel will lock the list use the same or less time as 
staged solution use(we can improve this together)

     the steps for staged N solution:
         1. User space reads list without lock
         2. User space stages list with lock
         3. User space decides to trim N entries and send command to kernel
         4. Kernel trim staged list (staged list may not empty after trim)
         5. kexec save the staged list during soft reboot
         6. kexec restore the staged list during soft reboot

>
> Also, Trim N solution is simple and will bring following two good points:
>     easy for future IMA development
will be easier for future "Kexec Measurement List Passing" project
> easy for code maintenance
>
> Could you also add your comments on the trim N solution?
>
> Thanks,
>
> Steven
>
>>
>>> Thanks,
>>>
>>> Steven 


