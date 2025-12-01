Return-Path: <linux-integrity+bounces-7749-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBEC98904
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8D7C4E1584
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253693191A2;
	Mon,  1 Dec 2025 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PHeTay+N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656221CC4F;
	Mon,  1 Dec 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610960; cv=none; b=PzMdGgEOsJi8gKnMha7JZvhB8O5Ur5h32BytPt8rSvi2nFDgQWp60FY9b0HOMpUlDRLe7ardWS8PVaroDC8ZdNJJ1vlN4Vpdy0IH+4/9cJWChcezUQ0UKzJxfmuG5g3A1L9oylQkkZowHb6jha0a/QC2sYlROGmLGn5wPCS3U34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610960; c=relaxed/simple;
	bh=15JvH6JyAOdfU2dbA0LcnPWilh0Np9iZya+hi+M2l48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHKPHoovvGzPlJKHE0Q3oyQX+SVSskDaOW/a7R+oW0/oZzYxIu84e8KFRybs3LJAF1Ih5/xveBYOHV21eFmLEiXfpRWUaBzxLpf04xKO/B6Yym1L81oFX2Gc9HemnAw08DjRI5uyHKQxceKVP1YhtSGfYkoMxWhdee7DlZbdc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PHeTay+N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.147] (unknown [131.107.1.211])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A6812012085;
	Mon,  1 Dec 2025 09:42:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A6812012085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610957;
	bh=15JvH6JyAOdfU2dbA0LcnPWilh0Np9iZya+hi+M2l48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PHeTay+NT3vQVhzAmGxWFzrTgRWdo++4FNdGGW9zOtnQic/EXhpPlog189FX4O0cX
	 Au2rdy3lWjfPmrNXH4usdXBDY7fhGJ/9liv/6k1khvJ5spgtK60aVyiUYKe7rnXcJ8
	 OLJfdS2wLGx5AC1g7NBNWHtfiNTmJFERfRN9+Ylo=
Message-ID: <2e7b89ae-2fac-45a6-928a-094a2d972c91@linux.microsoft.com>
Date: Mon, 1 Dec 2025 09:42:38 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/1] Implement IMA Event Log Trimming
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
 <7722dff4e68ef5fb7f39bd732a8a77422bad5549.camel@huaweicloud.com>
 <a77e9609-f6bd-4e6d-88be-5422f780b496@linux.microsoft.com>
 <1e5a3b427fe2783e57e88ca14630f5e38e01fac5.camel@huaweicloud.com>
 <bbafa611-3a6c-5cf8-631c-20f72f651d9@linux.microsoft.com>
 <3f85e98e2e4ef6a0de4fe4f6c2093791def1e30b.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <3f85e98e2e4ef6a0de4fe4f6c2093791def1e30b.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/2025 1:45 AM, Roberto Sassu wrote:
> On Wed, 2025-11-26 at 15:40 -0800, Gregory Lumen wrote:
>> Greetings Roberto,
>>
>> If I may chime in a bit:
>>
>>> The only way to make the verification of measurements list snapshots
>>> work is that the verification state is stored outside the system to
>>> evaluate (which can be assumed to be trusted), so that you are sure
>>> that the system is not advancing the PCR starting value by itself.
>> You are correct; to make the described approach work, an external source
>> of trust is required in order to detect unexpected or unauthorized
>> trimming of the event log (for example, by signing the trim-to PCR values
>> from the previous verification/attestation cycle). This should be true
>> regardless of the mechanism of trimming. More generally, I will go so far
>> as to suggest that any attempt to attest the integrity of a system using
>> IMA will likely fall into one of two general approaches: either the entire
>> IMA event log is retained (either in kernel or user space) from boot and
>> claims of system integrity are built by validating and examining the
>> entire log for signs of tampering, or an external source of trust is
>> introduced to allow incremental validation and examination of the log.
>> Other more innovative approaches may exist, but we make no such claims.
>>
>> I will also say that it should be possible to implement either approach to
>> attestation (retaining the entire log, or relying on an external source of
>> trust) with any sane implementation for IMA log trimming.
>>
>> As for our proposed implementation, storing the starting PCR values in the
>> kernel preserving the ability for any arbitrary user space entity to
>> validate the retained portion of the IMA event log against the TPM PCRs at
>> any time, without requiring awareness of other user space mechanisms
>> implemented by other entities that may be initiating IMA trimming
>> operations. My personal sense is that this capability is worth preserving,
>> but it is entirely possible the general consensus is that the value
>> offered does not balance against the additional technical complexity when
>> compared to simpler alternatives (discussed in a moment). To stress the
>> point, this capability would only enable validation of the integrity of
>> the retained portion of the event log and its continuity with the PCRs,
>> and could not be used to make any claims as to the overall integrity of
>> the system since, as you observed, an attacker who has successfully
>> compromised the system could simply trim the event log in order to discard
>> evidence of the compromise.
> Hi Gregory
>
> all you said can be implemented by maintaining the PCR starting value
> outside the system, in a trusted entity. This would allow the
> functionality you are hoping for to validate the retained portion of
> the measurement list.
>
> Keeping the PCR starting value in the kernel has the potential of
> misleading users that this is an information they can rely on. I would
> rather prefer to not run in such risk.
>
>> If the ability to validate the retained portion of the IMA event log is
>> not worth designing for, we could instead go with a simpler "Trim-to-N"
>> approach, where the user space interface allows for the specification of
>> an absolute index into the IMA log to be used as the trim position (as
>> opposed to using calculated PCR values to indicate trim position in our
>> current proposal). To protect against unexpected behavior in the event of
> >From implementation point of view, it looks much simpler to me to
> specify N relative to the current measurement list.

Hi Roberto,

I will send "trim N entries" patch out this week.

Regards,

Steven

>> concurrent trims, index counting would need to be fixed (hence absolute)
>> such that index 0 would always refer to the very first entry written
>> during boot, even if that entry has already been trimmed, with the number
>> of trimmed entries (and thus starting index of the retained log) exposed
>> to use space via a pseudo-file.
> In my draft patch [1] (still need to support trimming N entries instead
> of the full measurement list), the risk of concurrent trims does not
> exist because opening of the snapshot interface is exclusive (no one
> else can request trimming concurrently).
>
> If a more elaborated contention of remote attestation agent is
> required, that could be done at user space level. I'm hoping to keep in
> the kernel only the minimum code necessary for the remote attestation
> to work.
>
> Roberto
>
> [1] https://github.com/robertosassu/linux/commit/b0bd002b6caa9d5d4f4d0db2a041b1fd91f33f8a
>
>> With such a trim approach, it should be possible to implement either
>> general attestation approach: retaining the entire log (copy the log to
>> user space, then trim the copied entries), or relying on an external
>> source of trust (quote, determine the log index corresponding to the quote
>> plus PCRs, trim, then securely store the trim position/starting PCRs for
>> future cycles).
>>
>> -Gregory Lumen



