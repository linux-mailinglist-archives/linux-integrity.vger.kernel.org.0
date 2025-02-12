Return-Path: <linux-integrity+bounces-4802-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A9A331CB
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 22:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885393A8286
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB9203717;
	Wed, 12 Feb 2025 21:55:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02481FF1DF;
	Wed, 12 Feb 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397331; cv=none; b=BYHdqz0394+p0lCylRtNuq819msbkOAQtKgoAlmYSMky7W7HDj0tuPEh6NO920eo3IUeTNm0Q1DezXDjd1QHeUEaCB/NsEXzEn1v00wTLZm8coU5TR2Ty9RwuAAHVwIBYBLxDpOXhK+U4wPG8E5MO/odcNknlSd/ZLxp7VTUdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397331; c=relaxed/simple;
	bh=gHcV0lnpLWJYJxLs7QprlXgEmM1aIqcMb4O8yITOdz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHnM9F6qFdWTIzuOu7IbJDrmOr0GsN2hX6QHC5iUvrSPKIeXz4yUhNNIWbUpTgc2Ur7WI0FmTTpofMxqCf2iJ+511kM85w6vYUHCF6TQpS8vpjddPjiFx1XNVGJEdkD1R4d62pWPj6eAmSNPsC50NEtF98fMWcCEcprlZnU8BZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E893113E;
	Wed, 12 Feb 2025 13:55:48 -0800 (PST)
Received: from [10.118.100.66] (G9L3377F54.austin.arm.com [10.118.100.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494AB3F58B;
	Wed, 12 Feb 2025 13:55:27 -0800 (PST)
Message-ID: <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
Date: Wed, 12 Feb 2025 15:55:26 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Sumit Garg <sumit.garg@linaro.org>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/25 1:39 AM, Sumit Garg wrote:
> On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>
>> Hi Sumit,
>>
>> On 2/11/25 12:45 AM, Sumit Garg wrote:
>>> + Jens
>>>
>>> Hi Stuart,
>>>
>>> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>>>
>>>> These patches add support for the CRB FF-A start method defined
>>>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
>>>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
>>>> (https://developer.arm.com/documentation/den0138/latest/)
>>>
>>> Nice to have a specification standardizing interface to TPM
>>> managed/implemented by the firmware. Care to add corresponding kernel
>>> documentation under Documentation/security/tpm/.
>>
>> Yes, I can add some documentation there.
>>
>>> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
>>> possibilities for an abstraction layer on top of communication channel
>>> based on either FF-A or TEE or platform bus?
>>
>> I think the CRB and OP-TEE based messaging approaches for interacting
>> with a TZ-based TPM are fundamentally different and I don't see how
>> to harmonize them through some abstraction.
>>
>> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
>> buffer and sends a message to the TPM referencing that buffer.
>>
>> The CRB uses a permanently shared memory carve-out that in addition
>> to the command/response data has other fields for locality control,
>> command control, status, TPM idle, etc. The only 'message' needed is
>> something to signal 'start'.  Any OS that is FF-A aware and has a
>> CRB driver can simply add a new start method, which is what this
>> patch series does.
> 
> Okay, I see how the CRB driver is closely tied to the ACPI based
> systems.

The CRB driver is currently probed based on ACPI, but it fundamentally
doesn't have to be.  If there was a DT binding for CRB-based
TPMs the different start methods would be defined there and the
CRB driver could support that.

> I was expecting the FF-A based TPM interface to be
> independent of ACPI or DT such that it's not constrained by the
> hardware description a platform chooses to use. I suppose there will
> be a different TPM FF-A driver or spec when someone wants to deploy it
> on DT based systems, right?

The CRB is just a shared memory buffer, with some architected semantics
defined by TCG. The basic CRB usage model is that a client puts
something in the CRB, such as the bytes of a TPM command, and then
notifies the TPM that a change was made to the CRB. The CRB over
FF-A spec just defines the message to perform that notification
when FF-A is used.

So, whether the fTPM was advertised via ACPI or DT, it doesn't matter.
The FF-A based interface is only about the the notification messages
needed for the OS driver to tell the TPM that something has changed
in the CRB.

Thanks,
Stuart

