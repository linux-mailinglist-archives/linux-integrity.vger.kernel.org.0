Return-Path: <linux-integrity+bounces-8486-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIoPI7/Ii2kwbAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8486-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Feb 2026 01:09:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039AD1203B0
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Feb 2026 01:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B249302C35D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Feb 2026 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071903207;
	Wed, 11 Feb 2026 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aey7S7E6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08A3C465;
	Wed, 11 Feb 2026 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770768571; cv=none; b=SCUELKP5niMSc2Jzvy163z8VvLKFUY2nLghF1sDa39wZZ/VhZg0yQZIYWLQIHL6ZLEznF421YbH7ZZzpsLe+6JWI23X5a617FnUnBQiMI3cs6Vb42H1e16qm/YHLOmh6VdjfPE6cR8EzTDco583/aQgkYVVCBEymyQUunslpr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770768571; c=relaxed/simple;
	bh=PGSjreK4laPXnFm1B/0xauo/R+rULx+muFKhDH1hA7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB01CsrRl1qx8iVKeAYcxsC7rJhSgVAoRBTV2DxgzOy+FTSqkM4I5WzHaHdZ86ZTy+ng/U/hJnnfT395SxasfiRzsYDbKlipoAlcEsLuujd5iXdJujz95uKQPZkc+BbKsZAFXUbkhq0WyMSUicLPkXQ46D246vdbgUYCx8hKjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aey7S7E6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.14.34.58] (unknown [131.107.1.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2A37720B7167;
	Tue, 10 Feb 2026 16:09:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A37720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770768564;
	bh=qdq0OTS1cnyJKI0m4amY0YNcRP9yyMsIbRMtck1kkLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aey7S7E6dFJfF+SJpKGBWtuIRPLT/O0a8+T2rjo65cSHz4GHhH/CJHbfTToD7zroC
	 U9+DsNiigCfytfwSvSIzgXn+m8CuKEzNCdbdSu497y+8xjrtVpS/hiPZGdMP/865pC
	 dnbN1IYzcBY2G3Q8bLJTvPC7LSkrjd2UnXWXc8ck=
Message-ID: <8db7000e-56ef-43cb-b5f6-bd55c1da0237@linux.microsoft.com>
Date: Tue, 10 Feb 2026 16:09:22 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
 <6b36d6b3-34e8-4bdc-bd68-d71ddf44eba8@linux.microsoft.com>
 <52069703-98fc-4667-8c29-446ea73249cb@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <52069703-98fc-4667-8c29-446ea73249cb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8486-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 039AD1203B0
X-Rspamd-Action: no action

On 1/29/2026 12:20 AM, Roberto Sassu wrote:
> On 1/28/2026 10:30 PM, steven chen wrote:
>> On 12/12/2025 9:19 AM, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Introduce the ability of staging the entire (or a portion of the) IMA
>>> measurement list for deletion. Staging means moving the current 
>>> content of
>>> the measurement list to a separate location, and allowing users to 
>>> read and
>>> delete it. This causes the measurement list to be atomically truncated
>>> before new measurements can be added. Staging can be done only once 
>>> at a
>>> time. In the event of kexec(), staging is reverted and staged 
>>> entries will
>>> be carried over to the new kernel.
>>>
>>> User space is responsible to concatenate the staged IMA measurements 
>>> list
>>> portions following the temporal order in which the operations were 
>>> done,
>>> together with the current measurement list. Then, it can send the 
>>> collected
>>> data to the remote verifiers.
>>>
>>> Also introduce the ability of trimming N measurements entries from 
>>> the IMA
>>> measurements list, provided that user space has already read them. 
>>> Trimming
>>> combines staging and deletion in one operation.
>>>
>>> The benefit of these solutions is the ability to free precious kernel
>>> memory, in exchange of delegating user space to reconstruct the full
>>> measurement list from the chunks. No trust needs to be given to user 
>>> space,
>>> since the integrity of the measurement list is protected by the TPM.
>>>
>>> By default, staging/trimming the measurements list does not alter 
>>> the hash
>>> table. When staging/trimming are done, IMA is still able to detect
>>> collisions on the staged and later deleted measurement entries, by 
>>> keeping
>>> the entry digests (only template data are freed).
>>>
>>> However, since during the measurements list serialization only the SHA1
>>> digest is passed, and since there are no template data to 
>>> recalculate the
>>> other digests from, the hash table is currently not populated with 
>>> digests
>>> from staged/deleted entries after kexec().
>>>
>>> Introduce the new kernel option ima_flush_htable to decide whether 
>>> or not
>>> the digests of staged measurement entries are flushed from the hash 
>>> table.
>>>
>>> Then, introduce ascii_runtime_measurements_staged_<algo> and
>>> binary_runtime_measurement_staged_<algo> interfaces to 
>>> stage/trim/delete
>>> the measurements. Use 'echo A > <IMA interface>' and
>>> 'echo D > <IMA interface>' to respectively stage and delete the entire
>>> measurements list. Use 'echo N > <IMA interface>', with N between 1 and
>>> LONG_MAX, to stage the selected portion of the measurements list, and
>>> 'echo -N > <IMA interface>' to trim N measurements entries.
>>>
>>> The ima_measure_users counter (protected by the ima_measure_lock 
>>> mutex) has
>>> been introduced to protect access to the measurements list and the 
>>> staged
>>> part. The open method of all the measurement interfaces has been 
>>> extended
>>> to allow only one writer at a time or, in alternative, multiple 
>>> readers.
>>> The write permission is used to stage/trim/delete the measurements, the
>>> read permission to read them. Write requires also the CAP_SYS_ADMIN
>>> capability.
>>>
>>> Finally, introduce and maintain dedicate counters for the number of
>>> measurement entries and binary size, for the current measurements list
>>> (BINARY_SIZE), for the current measurements list plus staged entries
>>> (BINARY_SIZE_STAGED) useful for kexec() segment allocation, and for the
>>> entire measurement list without staging/trimming (BINARY_SIZE_FULL) 
>>> useful
>>> for the kexec-related critical data records.
>> Is the following possible race condition for staged list:
>>
>> Agent A: create staged list            Staged list A1
>>           new measurement added    Measurement list M1
>>           Two lists in kernel: A1 and M1
>>
>> Agent B: read staged list (A1) to do verification
>>           new measurement added    Measurement list M2
>>           Two lists in kernel: A1 and M2
>>
>> Agent A: verified and remove staged list (A1)
>>           new measurement added    Measurement list M3
>>           One list in kernel: M3
>>
>> Agent C: create staged list            Staged list C1
>>           new measurement added    Measurement list M4
>>           Two lists in kernel: C1 and M4
>>
>> Agent B: remove staged list (?), C1 removed ---this will cause problem
>>           new measurement added    Measurement list M5
>>           One list in kernel: M5
>>
>> Agent C: try to remove staged list(?)
>
> If you remember the patch, we added a read-write protection to the 
> measurements interfaces. As long as you keep the interface open for 
> write no one else can make change on the staging. Sure, you can drop 
> the write, and reopen for read, but then you should expect someone 
> else to operate on the interface.
>
> If you want to be sure no one else changes the staged measurements, 
> just keep the interface open for write, read the staged measurements 
> and delete them.
>
> Roberto
>
For different use cases, we can compare lock time for both staged method 
and trim N method:

t1: user space measurement list lock time
t2: kernel measurement list lock time

     Stage approach use case 1:
               1. read PCR quote
               2. read list
               3. attestation
               4. get N from attestation response
---          5. hold the list in the user space
  ^   ---    6. hold the measurement list
        ^     7. stage the list
t1    t2   8. trim N
        v     9. put the rest of stage back to measurement list
  v   ---    10. release the measurement list
---          11. release the list in the user space
  For this case, agent race condition may happen

   Stage approach use case 2:
               1. read PCR quote
---          2. hold the list in the user space
  ^           3. stage the list
               4. read list
               5. attestation
t1    ---  6. hold the measurement list
          ^   7. get N from attestation response
          t2  8. trim N
          v    9. put the rest of stage back to measurement list
  v    ---   10. release the measurement list
---          11. release the list in the user space
  For this case, no agent race condition happen

the following use case for trim N method

    Trim N approach use case:
              1. read total trimmed T
              2. read PCR quote
              3. read list,
              4. attestation
              5. get N from attestation response
---         6. hold the list in the user space
  ^   ---   7. hold the measurement list
        ^
t1   t2   8. trim with format T:N, update T
        v
  v   ---    9 . release the measurement list
---          10. release the list in the user space
     no agent race condition happen

For all use cases, I think for both t1 and t2, trim N method has better 
result.

Steven

>> Possible solution?
>>    Save the total number trimmed T or tag
>>
>>    Trim request sync this parameter to trim the staged list
>>
>> Regards,
>>
>> Steven
>>
>>> Note: This code derives from the Alt-IMA Huawei project, and is being
>>>        released under the dual license model (GPL-2.0 OR MIT).
>>>
>>> Link: https://github.com/linux-integrity/linux/issues/1
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> --- 


