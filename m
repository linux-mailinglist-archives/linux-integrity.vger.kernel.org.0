Return-Path: <linux-integrity+bounces-9021-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBsdB96HvWnQ+gIAu9opvQ
	(envelope-from <linux-integrity+bounces-9021-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 18:46:06 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F152DEE08
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FB91313DE75
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836C3603E2;
	Fri, 20 Mar 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OgsD/4e1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8343D412C;
	Fri, 20 Mar 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028435; cv=none; b=kG8mtXKVwhu3Gu2YkekdRKhjDaKmy2OfafPPDlkqz1TxdeAvje6pXYEgy5rmwBe3+rmnxA7gF4CCcA3wbhwhDBSYR4B+8SoIUECvUR/2NXElI7QWVlnP2i+qeUVhJfD3BgoBxCEKeJa/oThqKIlkjKmwZH69uZUmgZaAUN2xMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028435; c=relaxed/simple;
	bh=lxrM4VrdSOng8feKo8IozpUUIHZJiXEwh6yrcvWsyNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gm0t8Phll17sSeJZnZYvkj+3ST5yCTed1AaHCLg53xUZTK9ogHcy4sCQ1HHcV+t1nuJXmdMM0ejyml/DobAIhWTA2ojk2U2LgcVlqlXnRIX4ePQ2+vhBZL8uwi01l99+6Svs8KSyvxG4D9M2kmNIBIL5Jjw9cXedV4SVrnXHWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OgsD/4e1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.10] (c-67-168-176-124.hsd1.wa.comcast.net [67.168.176.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9F82820B710C;
	Fri, 20 Mar 2026 10:40:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F82820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774028431;
	bh=BApc9oQNGAxlRGFGXH8mdZ544y8f53Db3gPDBsUcgQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OgsD/4e1GH2P6Gq4V/EFODoy+q4UtiDKuZMTJNzgumtH6cwNwhYhxV6Juw2PrQDc6
	 2pWhQ6hF1Qv5W/nyimmKvZFUYi7PVdDLdPgsOFXf2jxKSrmSSJ4ujOqaIJM8l3yeE5
	 /k5otW21AUFtUHX9nqN29erhqKy+G0u+NQwcV+R0=
Message-ID: <94cae71a-2000-4d46-83e2-636a18874205@linux.microsoft.com>
Date: Fri, 20 Mar 2026 10:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ima: Add support for staging measurements for
 deletion
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net, skhan@linuxfoundation.org,
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
 <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
 <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
 <25e0a273-9044-4e0d-9812-0171ec99e1b7@linux.microsoft.com>
 <ffe1d4645a66a690892163be8e16c4b5d24a690d.camel@linux.ibm.com>
 <c9258708-2db2-4c08-998f-e67a681781da@linux.microsoft.com>
 <332fc1447c03893988620189a40501cccaa8b4c5.camel@huaweicloud.com>
 <8f66014c-d7c8-4a33-be7b-cfd945af4a3a@linux.microsoft.com>
 <a523c0cf05e10838bf08e4d2e9a05df402f4c9b0.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <a523c0cf05e10838bf08e4d2e9a05df402f4c9b0.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-9021-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,linux.ibm.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73F152DEE08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/2026 10:26 AM, Roberto Sassu wrote:
> On Fri, 2026-03-20 at 10:24 -0700, steven chen wrote:
>> On 3/20/2026 10:10 AM, Roberto Sassu wrote:
>>> On Fri, 2026-03-20 at 09:58 -0700, steven chen wrote:
>>>> On 3/20/2026 5:41 AM, Mimi Zohar wrote:
>>>>> On Thu, 2026-03-19 at 14:31 -0700, steven chen wrote:
>>>>>
>>>>>>> - Support for deleting N measurement records (and pre-pending the remaining
>>>>>>> measurement records)
>>>>>> Is there any problem to bring work of "stage" step together to the
>>>>>> deletion step?
>>>>>>
>>>>>> "Trim N" method does everything that "staged" method can do, right?
>>>>>> what's the "stage" method can do but "trim N" method can't do?
>>>>>>
>>>>>> in user space, if in "staged" state, no other user space agent can
>>>>>> access the IMA measure list, right?
>>>>>>
>>>>>> Could you explain the benefit of bringing the "stage" step?
>>>>> The performance improvement is because "staging" the IMA measurement list takes
>>>>> the lock in order to move the measurement list pointer and then releases it.
>>>>> New measurements can then be appended to a new measurement list.  Deleting
>>>>> records is done without taking the lock to walk the staged measurement list.
>>>>>
>>>>> Without staging the measurement list, walking the measurement list to trim N
>>>>> records requires taking and holding the lock.  The performance is dependent on
>>>>> the size of the measurement list.
>>>>>
>>>>> Your question isn't really about "staging" the measurement list records, but
>>>>> requiring a userspace signal to delete them.  To answer that question, deleting
>>>>> N records (third patch) could imply staging all the measurement records and
>>>>> immediately deleting N records without an explicit userspace signal.
>>>>>
>>>>> I expect the requested "documentation" patch will provide the motivation for the
>>>>> delayed deletion of the measurement list.
>>>>>
>>>>> Mimi
>>>> "Staging" is great on reducing kernel IMA measurement list locking time.
>>>>
>>>> How about just do "stage N" entries and then delete the staged list in
>>>> one shot?
>>>> It means merge two APIs into one API
>>>>        int ima_queue_stage(void)
>>>>        int ima_queue_delete_staged(unsigned long req_value)
>>>>
>>>> The kernel lock time will be the same. And user space lock time will be
>>>> reduced.
>>> It is not the same. The walk on the staged list is done without holding
>>> ima_extend_list_mutex.
>>>
>>> Roberto
>> Is it possible to merge two APIs work into one API?
>>        int ima_queue_stage(void)
>>        int ima_queue_delete_staged(unsigned long req_value)
> It will be done transparently for the user. IMA will call both
> functions for the same securityfs write.
>
> Roberto

If merge two APIs into one API, it will reduce user space measurement
list lock time.
Thanks,
Steven



