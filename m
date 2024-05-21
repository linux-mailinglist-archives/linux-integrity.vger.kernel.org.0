Return-Path: <linux-integrity+bounces-2532-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B608CB572
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 23:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1661F21922
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278B2AE6C;
	Tue, 21 May 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pobkyxdG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D12148821;
	Tue, 21 May 2024 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327770; cv=none; b=lAQiKsbORL3csm6lFm/DdOyP+KIONYpWHFrMEethpVR3BDZpH6YJmu1CCUU8LviCs9eK6JfVUZRNhQBU59u6mQV31/vmq8Z3oNlMd38/35IVGT/+X/TA1HJ4DhKYoA1++Zp5U9QaMFKs3m79kzf4aT5VtWC5eDOOjG3O9qgYVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327770; c=relaxed/simple;
	bh=u9OHQk1eGnLPF7q8QnB3x/3atmb+9wZIs5n85uU/v2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9MM7xsvtqLN903geLKBlL7Ptr5pjIxAR5nNs5wW/QUUAvSHPVLvnMnuIRHV3h4HBOW+cC61ySxfdAHqjSxyfLVdoxR42EHHl8yeQ+JENPKLntuokb/MJKgLGpsIaiLIvg3go5yapjMUkft6Z5IslzH9vmhVAio//1r5b4UsaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pobkyxdG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCF0E2067900;
	Tue, 21 May 2024 14:42:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCF0E2067900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716327768;
	bh=BUSVrQbwhWTK6SmDrPgyWJrCD0hgOdRhFqYqUq240sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pobkyxdGe7YVFwF3dkaJkJgWbG+KavLPiuQF6SQQN1zBASMoAM9wcAdd5EmYZaB/L
	 61ecccz7Ow8aijjoRWVO+F98iR9BjxIC5czqVksM0Y0rMb0ZRRAKkfCOJ6tvNTRUK0
	 vikUnzUoW2A/1EOMAGY+LrNlY0+QdhS1KLRy/ENA=
Message-ID: <3bd4d9a8-58ce-4cb2-a91e-c0d33174d951@linux.microsoft.com>
Date: Tue, 21 May 2024 14:42:47 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/21] dm: add finalize hook to target_type
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>, corbet@lwn.net, zohar@linux.ibm.com,
 jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
 axboe@kernel.dk, agk@redhat.com, eparis@redhat.com, paul@paul-moore.com,
 linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com>
 <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com>
 <212b02a8-f5f0-4433-a726-1639dda61790@linux.microsoft.com>
 <bc9aa053-20a6-eaa-cbe4-344f340242b@redhat.com>
 <234910c1-40c3-4489-94ab-6e9a5f00d93e@linux.microsoft.com>
 <889a7880-8336-a44a-bea4-a4c81c5e5cce@redhat.com>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <889a7880-8336-a44a-bea4-a4c81c5e5cce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/2024 5:31 AM, Mikulas Patocka wrote:
> 
> 
> On Fri, 17 May 2024, Fan Wu wrote:
> 
>>> So, it seems that the preresume callback provides the guarantee that you
>>> looking for.
>>>
>>>> -Fan
>>>
>>> Mikulas
>>
>> Thanks for the info. I have tested and verified that the preresume() hook can
>> also work for our case.
>>
>>  From the source code
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-ioctl.c#n1149,
>> the whole resume process appears to be:
>>
>> 1. Check if there is a new map for the device. If so, attempt to activate the
>> new map using dm_swap_table() (where the finalize() callback occurs).
>>
>> 2. Check if the device is suspended. If so, use dm_resume() (where the
>> preresume() callback occurs) to resume the device.
>>
>> 3. If a new map is activated, use dm_table_destroy() to destroy the old map.
>>
>> For our case:
>>
>> - Using the finalize() callback, the metadata of the dm-verity target inside
>> the table is attached to the mapped device every time a new table is
>> activated.
>> - Using the preresume() callback, the same metadata is attached every time the
>> device resumes from suspension.
>>
>> If I understand the code correctly, resuming from suspension is a necessary
>> step for loading a new mapping table. Thus, the preresume() callback covers
>> all conditions where the finalize() callback would be triggered.
> 
> Yes.
> 
>> However, the preresume() callback can also be triggered when the device
>> resumes from suspension without loading a new table, in which case there
>> is no new metadata in the table to attach to the mapped device.
> 
> Yes.
> 
>> In the scenario where the finalize() callback succeeds but the preresume()
>> callback fails, it seems the device will remain in a suspended state, the
>> newly activated table will be kept, and the old table will be destroyed, so it
>> seems there is no inconsistency using finalize() even preresume() potentially
>> fails.
> 
> What does your security module do when the verification of the dm-verity
> hash fails? Does it halt the whole system? Does it destroy just the
> failing dm device? Or does it attempt to recover somehow from this
> situation?
>

I'm not sure which hash verification is being referred to here, but it 
could be either root hash signature verification or block-level hash 
verification. Our security module does not intervene in these processes, 
so the behavior remains as dm-verity currently handles it.

Within the device mapper, our security module uses the device mapper 
callback to duplicate the root hash of a dm-verity target and record the 
signature verification state of the dm-verity target, then attach this 
information to the security field of the block_device structure. This 
process can only fail if the system is out of memory.

With the root hash and signature verification state attached to the 
security field of the block device, the security system can access this 
important metadata to enforce policies. For example, these policies can 
include only allowing files from a dm-verity volume specified by its 
root hash to execute or only allowing files from a verified signed 
dm-verity volume to execute.

>> I believe both the finalize() callback proposed by Mike and the preresume()
>> callback suggested by Mikulas can work for our case. I am fine with either
>> approach, but I would like to know which one is preferred by the maintainers
>> and would appreciate an ACK for the chosen approach.
>>
>> -Fan
> 
> I would prefer preresume - we shouldn't add new callbacks unless it's
> necessary.
> 
> Mikulas
>

Thanks for the confirmation. I will switch to use prereume and I will 
send a new version later this week.

-Fan

