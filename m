Return-Path: <linux-integrity+bounces-9016-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EwKF0hrvGnwyQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9016-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2026 22:31:52 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F42D2B0F
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2026 22:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 610EC301FBA7
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2026 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF93B27E9;
	Thu, 19 Mar 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mD7T1yYo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA23AC0EA;
	Thu, 19 Mar 2026 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955902; cv=none; b=UVvXujLHu3XvZ3XOlsLct46O1MF1bp174QYRIzyJnTxO8LzdqqLxrsOAnJz/T7kBXA0gSUGY4F1ilgBifbnMgfdHYj/XbxFB0D6HPIIBQVqHcnqReT8jfXmGr0nSu4LeEw75tg+EyKrINgsY/gT4zVRr90WZGHtyHYkPjGxheVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955902; c=relaxed/simple;
	bh=IS0BQLbOfw51GZ35diI4pTcOMtevg+pxbCdwDWl1wW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKG40lsW8SOJmC3sIiV0X4GnHMCIxPQgUVbqJjjN4pIh93S8nl7zlcZ89PjeyzpDatqvsfJBUgnDaFmBfItAfOw8Qh5lgSMfgS0Q7azkUU0xRkfGvDIRA0eNGXk3WPfxXkVOrKSnP+f/dwdyYrtEp1PBetSjc4MT9JLu965oWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mD7T1yYo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.97.93] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAFF320B710C;
	Thu, 19 Mar 2026 14:31:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAFF320B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773955895;
	bh=sdvNeWOmfmcsZBfkuiWzVYLD1GTROw2BwLTYy2DXIHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mD7T1yYo2+IzH6hpJubry/K2spBgFLJY6qHyKHWhfrZyPzkg06GNdACdF14VAQrIY
	 0wFq0deQkk/y3qX7Ieb75WhhxSJtVNjhidHSz9ynLvlLf4gWVCx9x58bJFLO17KXrh
	 uMzSraj6iaSSO2R7ydet9OjYZiUKkWKdsj9gt1G0=
Message-ID: <25e0a273-9044-4e0d-9812-0171ec99e1b7@linux.microsoft.com>
Date: Thu, 19 Mar 2026 14:31:31 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ima: Add support for staging measurements for
 deletion
To: Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
 <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
 <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9016-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: F25F42D2B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/2026 2:03 PM, Mimi Zohar wrote:
> Hi Roberto,
>
> On Wed, 2026-03-11 at 18:19 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Introduce the ability of staging the IMA measurement list for deletion.
>> Staging means moving the current content of the measurement list to a
>> separate location, and allowing users to read and delete it. This causes
>> the measurement list to be atomically truncated before new measurements can
>> be added.
> I really like this design of atomically moving and subsequently deleting the
> measurement list.  However this is a solution, not the motivation for the patch.
> Please include the motivation for the patch, before describing the solution.
>
>> Staging can be done only once at a time. In the event of kexec(),
>> staging is reverted and staged entries will be carried over to the new
>> kernel.
>> Staged measurements can be deleted entirely, or partially, with the
>> non-deleted ones added back to the IMA measurements list.
> This patch description is really long, which is an indication that the patch
> needs to be split up.  Adding support for partially deleting the measurement
> list records, by prepending the remaining measurement records, should be a
> separate patch.
>
>> This allows the
>> remote attestation agents to easily separate the measurements that where
>> verified (staged and deleted) from those that weren't due to the race
>> between taking a TPM quote and reading the measurements list.
>>
>> User space is responsible to concatenate the staged IMA measurements list
>> portions (excluding the measurements added back to the IMA measurements
>> list) following the temporal order in which the operations were done,
>> together with the current measurement list. Then, it can send the collected
>> data to the remote verifiers.
> This belongs in a Documentation patch.
>
>> The benefit of staging and deleting is the ability to free precious kernel
>> memory,
> This is the motivation for the patch.
>
>> in exchange of delegating user space to reconstruct the full
>> measurement list from the chunks. No trust needs to be given to user space,
>> since the integrity of the measurement list is protected by the TPM.
> Agreed the measurement list, itself, is protected by the TPM.  However, relying
> on userspace to reassemble the chunks is another concern. Support for staging
> and deleting the measurement list should be configurable.  Defining a Kconfig
> should be part of this initial patch.
>
>> By default, staging the measurements list does not alter the hash table.
>> When staging and deleting are done, IMA is still able to detect collisions
>> on the staged and later deleted measurement entries, by keeping the entry
>> digests (only template data are freed).
>>
>> However, since during the measurements list serialization only the SHA1
>> digest is passed, and since there are no template data to recalculate the
>> other digests from, the hash table is currently not populated with digests
>> from staged/deleted entries after kexec().
>>
>> Introduce the new kernel option ima_flush_htable to decide whether or not
>> the digests of staged measurement entries are flushed from the hash table,
>> when they are deleted. Flushing the hash table is supported only when
>> deleting all the staged measurements, since in that case the old hash table
>> can be quickly swapped with a blank one (otherwise entries would have to be
>> removed one by one for partial deletion).
> Allowing the hash table to be deleted would be an example of another patch.
>
>> Then, introduce ascii_runtime_measurements_<algo>_staged and
>> binary_runtime_measurements_<algo>_staged interfaces to stage and delete
>> the measurements. Use 'echo A > <IMA interface>' and
>> 'echo D > <IMA interface>' to respectively stage and delete the entire
>> measurements list. Use 'echo N > <IMA interface>', with N between 1 and
>> ULONG_MAX - 1, to delete the selected staged portion of the measurements
>> list.
>>
>> The ima_measure_users counter (protected by the ima_measure_mutex mutex)
>> has been introduced to protect access to the measurements list and the
>> staged part. The open method of all the measurement interfaces has been
>> extended to allow only one writer at a time or, in alternative, multiple
>> readers. The write permission is used to stage and delete the measurements,
>> the read permission to read them. Write requires also the CAP_SYS_ADMIN
>> capability.
> Yes, this is part of the initial patch that adds support for staging the
> measurement list.
>
>> Finally, introduce the binary_lists enum and make binary_runtime_size
>> and ima_num_entries as arrays, to keep track of their values for the
>> current IMA measurements list (BINARY), current list plus staged
>> measurements (BINARY_STAGED) and the cumulative list since IMA
>> initialization (BINARY_FULL).
>>
>> Use BINARY in ima_show_measurements_count(), BINARY_STAGED in
>> ima_add_kexec_buffer() and BINARY_FULL in ima_measure_kexec_event().
>>
>> It should be noted that the BINARY_FULL counter is not passed through
>> kexec. Thus, the number of entries included in the kexec critical data
>> records refers to the entries since the previous kexec records.
>>
>> Note: This code derives from the Alt-IMA Huawei project, whose license is
>>        GPL-2.0 OR MIT.
>>
>> Link: https://github.com/linux-integrity/linux/issues/1
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> The design looks good.  As I mentioned above, this patch description is quite
> long, which is an indication that the patch needs to be split up.  One method of
> breaking it up would be:
>
> - (Basic) support for staging measurements for deletion (based on a Kconfig)
> - Support for removing the hash table

Great work on performance improvement and hash table redesign.

If update the following "Trim N" method patch with your current patch 
lock time performance
improvement plus the hash table change, "Trim N" method can do the same 
kernel
measurement list lock time as staged method do, right?

https://lore.kernel.org/linux-integrity/20260205235849.7086-1-chenste@linux.microsoft.com/ 

> - Support for deleting N measurement records (and pre-pending the remaining
> measurement records)

Is there any problem to bring work of "stage" step together to the 
deletion step?

"Trim N" method does everything that "staged" method can do, right? 
what's the "stage"
method can do but "trim N" method can't do?

in user space, if in "staged" state, no other user space agent can 
access the IMA measure list, right?

Could you explain the benefit of bringing the "stage" step?

Thanks,

Steven

> - Adding documentation
>
> thanks,
>
> Mimi



