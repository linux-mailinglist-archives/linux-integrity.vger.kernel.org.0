Return-Path: <linux-integrity+bounces-9522-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNFaL/AZAmognwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9522-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2026 20:03:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68954514059
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2026 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E61E31BC210
	for <lists+linux-integrity@lfdr.de>; Mon, 11 May 2026 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC844D015;
	Mon, 11 May 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qPr3GfIA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB3423A6B;
	Mon, 11 May 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520568; cv=none; b=VSqGk/CMLnM09sLdfKkAI7t13p690q0HTI1BRh7eNTlKU3xXXa2ez6dATCvniVSoojcPqXicBzL1jYOD+O7RzGPay7TJOSV5VEOiBLwvRuY/1cPZfSWX6nd89tlyscjjbVDgnqCizWJhCLtrzc/x4cU3u5xpAvMdAozUBTPgMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520568; c=relaxed/simple;
	bh=yMWBpNUT5aNuw3V9XIZoorQgUxmjks1iackgkJ/snl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDXc7WUA/UWNvGzD8L2LbaZlpW51BJjm2JvKWkox+j9flsln4yphfFkP1PJDw+SDb7BNaMutvC/Ag51NpFEi7Du1/iv8x+9BOqxneXdxPYMansWERtYpk7WgxHVfijx6rgkFUsqWsXtFXlCLw6hcqeB8/kyjPBJfuZBQm+/SAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qPr3GfIA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.2.212.4] (unknown [131.107.8.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0EC9B20B7166;
	Mon, 11 May 2026 10:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EC9B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778520564;
	bh=EY/LhrL3JM0ElRC6pWR4zlZABquSUEPTVPGME7ilfAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qPr3GfIAExhTrBx+vW6z04VEtwuHufnzKC2Cuobqhgi+jXK8B5WJn5U/8AuY4IuR1
	 gctDJYqvaGxDiuM3sdUmiMnyj8eQav91qWB47p3T2RM2WYl1MYeUYAcqhOAWOjKQ64
	 3wnHZX/hx0hhTM8+aGFGvVBJXMR24gFYj+iX5v54=
Message-ID: <aaed52cf-26e1-4c40-812d-3788024ce5b5@linux.microsoft.com>
Date: Mon, 11 May 2026 10:29:23 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
To: steven chen <chenste@linux.microsoft.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
 <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
Content-Language: en-US
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <99c30be6-8b0f-486a-890c-cf74c5930726@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68954514059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9522-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,huaweicloud.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nramas@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/7/2026 9:47 AM, steven chen wrote:
>>
>> Usage
>> =====
>>
>> The IMA staging mechanism can be enabled from the kernel configuration
>> with the CONFIG_IMA_STAGING option.
>>
>> If it is enabled, IMA duplicates the current measurements interfaces
>> (both binary and ASCII), by adding the _staged file suffix. Both the
>> original and the staging interfaces gain the write permission for the
>> root user and group, but require the process to have CAP_SYS_ADMIN set.
>>
>> The staging mechanism supports two flavors.
>>
>> Staging with prompt
>> ~~~~~~~~~~~~~~~~~~~
>>
>> The current measurements list is moved to a temporary staging area, and
>> staged measurements are deleted upon confirmation.
>>
>> This staging process is achieved with the following steps.
>>
>>    1.  echo A > <original interface>: the user requests IMA to stage the
>>        entire measurements list;
>>    2.  cat <_staged interface>: the user reads the staged measurements;
>>    3.  echo D > <_staged interface>: the user requests IMA to delete
>>        staged measurements.
>>
>> Staging and deleting
>> ~~~~~~~~~~~~~~~~~~~~
>>
>> N measurements are staged to a temporary staging area, and immediately
>> deleted without further confirmation.
>>
>> This staging process is achieved with the following steps.
>>
>>    1.  cat <original interface>: the user reads the current measurements
>>        list and determines what the value N for staging should be;
>>    2.  echo N > <original interface>: the user requests IMA to delete N
>>        measurements from the current measurements list.
> 
> This submission proposes two ways for log trimming:
> 
> *Flavor 1:* Staging with prompt
> *Flavor 2:* stage and delete N
> 
> Functionally, both approaches address the same problem, but *Favour 2 
> *is the
> stronger design and should be preferred. There is no good reason to keep 
> *Flavor 1.*
> 
>  From a kernel implementation perspective, *Flavor 2 *is more efficient 
> because it
> minimizes the time spent holding the list lock (can’t be shorter). It 
> also substantially
> reduces the amount of kernel-side logic, removing nearly half of the 
> code required
> by the alternative approach.
> 
>  From a user-space perspective, *Flavor 2 *results in a much cleaner 
> model. It avoids
> the need to track and reconcile both old and staged lists in user space 
> as well as
> two lists (cur and staged) in the kernel space, which simplifies log 
> trimming logic
> and reduces maintenance overhead. In addition, it preserves the existing 
> external
> behavior by not exposing any staged list to user space.
> 
> Overall, *Flavor 2 *provides the same functional result with lower 
> kernel complexity,
> shorter kernel list lock hold time, and a simpler user-space interface. 
> For those
> reasons, it is the preferable approach and *Favour 1* does not appear to 
> offer sufficient
> justification to keep both implementations.
> 
> Steven

Roberto, Mimi:

I want to add on to the point Steven has brought up.

With "Stage and Delete N" approach, we have the following sequence of 
tasks for trimming the IMA log:

	1. User mode locks the IMA measurement list through the "write interface".
		a. While this prevents any other user mode process from updating the 
IMA log, kernel can still add new IMA events to the measurement log
	2. User mode reads the TPM Quote and the IMA measurement events and 
sends it to the remote attestation service
	3. Once the remote service has successfully processed the IMA events, 
the user mode determines the number of IMA events "N" to be removed from 
the measurement list maintained in the kernel
	4. User mode provides the value "N" to the kernel
	5. Kernel now determines the point at which to snap the IMA measurement 
list using "N" - without holding a lock
	6. Then, the kernel lock is held and the list is snapped at the point 
determined in the previous step thus keeping the kernel lock time to the 
minimum.
	7. Now, user mode removes the "write" lock on the IMA measurement list

With the above, we believe "Stage and Delete N" alone is sufficient to 
trim IMA log.

  -lakshmi

>>   .../admin-guide/kernel-parameters.txt         |   4 +
>>   Documentation/security/IMA-staging.rst        | 163 +++++++++
>>   Documentation/security/index.rst              |   1 +
>>   MAINTAINERS                                   |   2 +
>>   security/integrity/ima/Kconfig                |  16 +
>>   security/integrity/ima/ima.h                  |  32 +-
>>   security/integrity/ima/ima_api.c              |   2 +-
>>   security/integrity/ima/ima_fs.c               | 315 ++++++++++++++++--
>>   security/integrity/ima/ima_init.c             |   5 +
>>   security/integrity/ima/ima_kexec.c            |  53 ++-
>>   security/integrity/ima/ima_queue.c            | 283 ++++++++++++++--
>>   11 files changed, 803 insertions(+), 73 deletions(-)
>>   create mode 100644 Documentation/security/IMA-staging.rst
>>


