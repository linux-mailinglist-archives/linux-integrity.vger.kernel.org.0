Return-Path: <linux-integrity+bounces-9715-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M8HzHK4VHmrDhAkAu9opvQ
	(envelope-from <linux-integrity+bounces-9715-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 01:28:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CFF62654A
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 01:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BF1A300CB38
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 23:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C731159C;
	Mon,  1 Jun 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cBRgkLlV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBE1FC8;
	Mon,  1 Jun 2026 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780356521; cv=none; b=MxjdLT86gRRYXQYOfmhIG3YeOjd84eB+rMhp0RxEBZjLJTBNDUs+oA3hvj2ODjA7P/gbMrdhaRE64617UzNSQpFcjj6lVw9txgtGRUdceVnC1sWUYiuFsvoOavx1pYi8dGsd5aZh11ButY58kwqTsqvCYXQBx4WAJw2WXEj4ZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780356521; c=relaxed/simple;
	bh=Wu/y8X3SskheqKI1Lit4RrnET0vIls6UqBITyEp0pfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul4AmrOI605xhiMG53drphtQ9BYWkhA6sWaRAoyD7+TcHQDUAgDXgsbqcTyN7uZrNvooqkYC2SoDAlIk7Vu7LxDEJKmjFxd+Tj40MtWMIxgAfSjJcxkIi0243taFsu5mMP8eZkoeXQbk1rl+6i0hBeVN/vtApNWgh4UyOnnGsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cBRgkLlV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.14.127.139] (unknown [131.107.174.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id E84C720B7166;
	Mon,  1 Jun 2026 16:28:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E84C720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780356506;
	bh=zGJEsEVq5czVtNsRrd8cfYKxX0LdNCNnOdWT3Q3Cm2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cBRgkLlVdzLU0/O11GOhCLn4rifYManKTOau5ZM4IMCiTCvsziplgtLNialVqR3l4
	 qwtPkceRXbPrqTAnCF/5rBTq73PPIQyk4wBM7BPDgM6emjvy64MwN7S8SPusfM7E5F
	 V6ZTsFBI2hxbQ41YKG6Y7rrl9aM3VbdqnqISgl/8=
Message-ID: <15b7bb2f-d419-4d9f-bed4-f36d14c2a094@linux.microsoft.com>
Date: Mon, 1 Jun 2026 16:28:37 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] ima: Support staging and deleting N measurements
 entries
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
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
 <20260429160319.4162918-12-roberto.sassu@huaweicloud.com>
 <f00aabe05aeee7f6fd0426fd992839758d810da7.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <f00aabe05aeee7f6fd0426fd992839758d810da7.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9715-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 08CFF62654A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/2026 4:08 AM, Mimi Zohar wrote:
> On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Add support for sending a value N between 1 and ULONG_MAX to the IMA
>> original measurement interface. This value represents the number of
>> measurements that should be deleted from the current measurements list. In
>> this case, measurements are staged in an internal non-user visible list,
>> and immediately deleted.
>>
>> This staging method allows the remote attestation agents to easily separate
>> the measurements that were verified (staged and deleted) from those that
>> weren't due to the race between taking a TPM quote and reading the
>> measurements list.
> The reason for removing records from the IMA measurement list is to free kernel
> memory.  However, the level of precision in removing only those measurements
> needed for the quote seems necessary only if the measurement records are not
> being saved.  Upstreaming a feature to remove measurement records from the IMA
> measurement list is to address the kernel memory issue — clearly not to drop
> measurement records and break attestation.
>
>> In order to minimize the locking time of ima_extend_list_mutex, deleting
>> N entries is realized by doing a lockless walk in the current measurements
>> list to determine the N-th entry to cut, to cut the current measurements
>> list under the lock, and by deleting the excess entries after releasing the
>> lock.
>>
>> Flushing the hash table is not supported for N entries, since it would
>> require removing the N entries one by one from the hash table under the
>> ima_extend_list_mutex lock, which would increase the locking time.
>>
>> The ima_extend_list_mutex lock is necessary in ima_dump_measurement_list()
>> because ima_queue_delete_partial() uses __list_cut_position() to modify
>> ima_measurements, for which no RCU-safe variant exists. For the staging
>> with prompt flavor alone, list_replace_rcu() could have been used instead,
>> but since both flavors share the same kexec serialization path, the mutex
>> is required regardless.
> Thank you for the clear explanation for the changes and limitations required to
> support this feature.
>
> The changes needed for supporting "stage and delete N" measurement records
> should be limited to this patch.  Patch 9/13 should have used
> list_replace_rcu(), without the mutex_lock.
>
>> Link: https://github.com/linux-integrity/linux/issues/1
>> Suggested-by: Steven Chen <chenste@linux.microsoft.com>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Otherwise,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Steven Chen <chenste@linux.microsoft.com>
Reviewed-by: Steven Chen <chenste@linux.microsoft.com>


