Return-Path: <linux-integrity+bounces-2439-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61228C8CA3
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 21:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152EC1C21CBB
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E013FD76;
	Fri, 17 May 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fpp/vl3D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0D13F423;
	Fri, 17 May 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973216; cv=none; b=ok9rZbwP6SBnQ3ydAey78g7sFx9YsB59h+E11RBBuLwU0js/izpFeK88hjflSt64LtW1H67z8BXftkpKseI3fVFkjizzfuw7w2EDzkHuqtlqsJ2lx1hlz2LFHV/tGRdB6UKrIpxSN7xam1dykkkRiZKcwCwojwykHM9ndiwNhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973216; c=relaxed/simple;
	bh=cl5z+RypzfaYXGWf+rnBBjI5OlA1WYqdwNwX6Edu4uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBvJuDcCVC/JfYhw9pXSqQC4rCodnPr1gKmcVu4Rj7PgKS10tH5lU9t9AUyyzUT2314l2ypu6ELPrRLFMvjtNupA6tCxYGiXvwvYBUKyskW0HmuGNixCY9FJnMM9BgVUtniV+v5nuDhliYhQTgfHo9KkzrquHv+BbCPbx/t107I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fpp/vl3D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6FAD220B915A;
	Fri, 17 May 2024 12:13:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FAD220B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715973207;
	bh=2p1wopyKvglG1K22JP2DhRwV85SJbq4dKxtjT1xHvtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fpp/vl3DKUdjSDRpvAjyDgeuyiVrUyujnX4va9QRUjeu+quEuTpy1VLMWrbI1o4O2
	 7tFT61OD7MvfnS0fygEkUh5vIkJKB8wvWKhgP7fqsqhi6YbLFLZ5KpReHrkz8TRyK5
	 gfobGVgWsvo7PzhwRCDJDIgnL1vDR71OaQIF5phw=
Message-ID: <234910c1-40c3-4489-94ab-6e9a5f00d93e@linux.microsoft.com>
Date: Fri, 17 May 2024 12:13:26 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/21] dm: add finalize hook to target_type
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com,
 linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-13-git-send-email-wufan@linux.microsoft.com>
 <aa767961-5e3-2ceb-1a1e-ff66a8eed649@redhat.com>
 <212b02a8-f5f0-4433-a726-1639dda61790@linux.microsoft.com>
 <bc9aa053-20a6-eaa-cbe4-344f340242b@redhat.com>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <bc9aa053-20a6-eaa-cbe4-344f340242b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/9/2024 10:07 AM, Mikulas Patocka wrote:
> 
> 
> On Wed, 8 May 2024, Fan Wu wrote:
> 
>>
>>
>> On 5/8/2024 10:17 AM, Mikulas Patocka wrote:
>>>
>>>
>>> On Fri, 3 May 2024, Fan Wu wrote:
>>>
>>>> This patch adds a target finalize hook.
>>>>
>>>> The hook is triggered just before activating an inactive table of a
>>>> mapped device. If it returns an error the __bind get cancelled.
>>>>
>>>> The dm-verity target will use this hook to attach the dm-verity's
>>>> roothash metadata to the block_device struct of the mapped device.
>>>>
>>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>>>
>>> Hi
>>>
>>> Why not use the preresume callback?
>>>
>>> Is there some reason why do we need a new callback instead of using the
>>> existing one?
>>>
>>> Mikulas
>> Thanks for the suggestion.
>>
>> Mike suggested the new finalize() callback. I think the reason for not using
>> the preresume() callback is that there are multiple points that can fail
>> before activating an inactive table of a mapped device which can potentially
>> lead to inconsistent state.
>>
>> In our specific case, we are trying to associate dm-verity's roothash metadata
>> with the block_device struct of the mapped device inside the callback.
>>
>> If we use the preresume() callback for the work and an error occurs between
>> the callback and the table activation, this leave the block_device struct in
>> an inconsistent state.
> 
> The preresume callback is the final GO/NO-GO decision point. If all the
> targets return zero in their preresume callback, then there's no turning
> back and the table will be activated.
> 
>> This is because now the block device contains the roothash metadata of it's
>> inactive table due to the preresume() callback, but the activation failed so
>> the mapped device is still using the old table.
>>
>> The new finalize() callback guarantees that the callback happens just before
>> the table activation, thus avoiding the inconsistency.
> 
> In your patch, it doesn't guarantee that.
> 
> do_resume calls dm_swap_table, dm_swap_table calls __bind, __bind calls
> ti->type->finalize. Then we go back to do_resume and call dm_resume which
> calls __dm_resume which calls dm_table_resume_targets which calls the
> preresume callback on all the targets. If some of them fails, it returns a
> failure (despite the fact that ti->type->finalize succeeded), if all of
> them succeed, it calls the resume callback on all of them.
> 
> So, it seems that the preresume callback provides the guarantee that you
> looking for.
> 
>> -Fan
> 
> Mikulas

Thanks for the info. I have tested and verified that the preresume() 
hook can also work for our case.

 From the source code 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-ioctl.c#n1149, 
the whole resume process appears to be:

1. Check if there is a new map for the device. If so, attempt to 
activate the new map using dm_swap_table() (where the finalize() 
callback occurs).

2. Check if the device is suspended. If so, use dm_resume() (where the 
preresume() callback occurs) to resume the device.

3. If a new map is activated, use dm_table_destroy() to destroy the old map.

For our case:

- Using the finalize() callback, the metadata of the dm-verity target 
inside the table is attached to the mapped device every time a new table 
is activated.
- Using the preresume() callback, the same metadata is attached every 
time the device resumes from suspension.

If I understand the code correctly, resuming from suspension is a 
necessary step for loading a new mapping table. Thus, the preresume() 
callback covers all conditions where the finalize() callback would be 
triggered. However, the preresume() callback can also be triggered when 
the device resumes from suspension without loading a new table, in which 
case there is no new metadata in the table to attach to the mapped device.

In the scenario where the finalize() callback succeeds but the 
preresume() callback fails, it seems the device will remain in a 
suspended state, the newly activated table will be kept, and the old 
table will be destroyed, so it seems there is no inconsistency using 
finalize() even preresume() potentially fails.

I believe both the finalize() callback proposed by Mike and the 
preresume() callback suggested by Mikulas can work for our case. I am 
fine with either approach, but I would like to know which one is 
preferred by the maintainers and would appreciate an ACK for the chosen 
approach.

-Fan

