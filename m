Return-Path: <linux-integrity+bounces-4852-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C33A38A26
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 17:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E4318940B5
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58E22652B;
	Mon, 17 Feb 2025 16:57:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D36226528;
	Mon, 17 Feb 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811422; cv=none; b=VUDjg+HCTFphd7gZ1ERb6LmX/3S/nYUvncRMDspVzlQEo/li7QhnjgyJeY4uZl37QDFi0vJi/51HE31u0WFBiJ9Xr/Dn/AlmpqcUqUvpOzVUiUYxuC5MTNNrUmMXQq+M/x8E6Prr4hovbN29FF4u/xr5vD+AM2q1vlndPbfEzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811422; c=relaxed/simple;
	bh=+Slhdyr87sEDrXnPmfmh/DMOQQHysATe1TTy7flwAmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rq8UFvNo7tEv3tVgFo6L2HK3abnfmyIgIIhSWg8FEnT8cqSO+WSyzSLku5MI6v/HWlyx4oE/X5ZRIpDvYmU50TWiACdQXlFGloy2hJSNFR5OjZvT/Yw8xqW0cT8yhtWu4/oA6bD9/Oyl/PMeSuMMLlIEuyRjWbUWiZa3MyafHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B13F152B;
	Mon, 17 Feb 2025 08:57:18 -0800 (PST)
Received: from [10.122.18.64] (unknown [10.122.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042953F5A1;
	Mon, 17 Feb 2025 08:56:58 -0800 (PST)
Message-ID: <5dae96fa-0e54-4274-bcc6-1c20fe846f60@arm.com>
Date: Mon, 17 Feb 2025 10:56:58 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-integrity@vger.kernel.org,
 jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>,
 Rob Herring <robh@kernel.org>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
 <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
 <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com> <Z7LGbZsOh_w-HRY2@sumit-X1>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <Z7LGbZsOh_w-HRY2@sumit-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/25 11:17 PM, Sumit Garg wrote:
> On Thu, Feb 13, 2025 at 09:19:58AM -0600, Stuart Yoder wrote:
>>
>>
>> On 2/12/25 11:31 PM, Sumit Garg wrote:
>>> + Rob
>>>
>>> On Thu, 13 Feb 2025 at 03:25, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/12/25 1:39 AM, Sumit Garg wrote:
>>>>> On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>>>>>
>>>>>> Hi Sumit,
>>>>>>
>>>>>> On 2/11/25 12:45 AM, Sumit Garg wrote:
>>>>>>> + Jens
>>>>>>>
>>>>>>> Hi Stuart,
>>>>>>>
>>>>>>> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
>>>>>>>>
>>>>>>>> These patches add support for the CRB FF-A start method defined
>>>>>>>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
>>>>>>>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
>>>>>>>> (https://developer.arm.com/documentation/den0138/latest/)
>>>>>>>
>>>>>>> Nice to have a specification standardizing interface to TPM
>>>>>>> managed/implemented by the firmware. Care to add corresponding kernel
>>>>>>> documentation under Documentation/security/tpm/.
>>>>>>
>>>>>> Yes, I can add some documentation there.
>>>>>>
>>>>>>> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
>>>>>>> possibilities for an abstraction layer on top of communication channel
>>>>>>> based on either FF-A or TEE or platform bus?
>>>>>>
>>>>>> I think the CRB and OP-TEE based messaging approaches for interacting
>>>>>> with a TZ-based TPM are fundamentally different and I don't see how
>>>>>> to harmonize them through some abstraction.
>>>>>>
>>>>>> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
>>>>>> buffer and sends a message to the TPM referencing that buffer.
>>>>>>
>>>>>> The CRB uses a permanently shared memory carve-out that in addition
>>>>>> to the command/response data has other fields for locality control,
>>>>>> command control, status, TPM idle, etc. The only 'message' needed is
>>>>>> something to signal 'start'.  Any OS that is FF-A aware and has a
>>>>>> CRB driver can simply add a new start method, which is what this
>>>>>> patch series does.
>>>>>
>>>>> Okay, I see how the CRB driver is closely tied to the ACPI based
>>>>> systems.
>>>>
>>>> The CRB driver is currently probed based on ACPI, but it fundamentally
>>>> doesn't have to be.  If there was a DT binding for CRB-based
>>>> TPMs the different start methods would be defined there and the
>>>> CRB driver could support that.
>>>>
>>>
>>> Can't we rather enable the CRB driver itself probed based on FF-A bus
>>> and rather dynamically discover the shared memory buffer via FF-A
>>> instead? AFAIU, FF-A provides you with a discovery framework for
>>> firmware bits.
>>
>> Yes, you could do this. But, then the TPM CRB drivers in all the
>> ACPI-based OSes (Linux, Windows) and hypervisors need to be
>> taught this new method of discovery. Adding new start methods is
>> reasonably straightforward, but changing the basic discovery
>> mechanism is a much bigger change.
> 
> We will be teaching every other OS or hypervisor about FF-A
> communication regardless. So it's rather about if we want to do it
> properly leveraging auto discovery mechanisms supported by FF-A or not.
> 
>>
>>> But if we still want to overload ACPI or DT with the
>>> discoverable firmware bits then it seems like an overkill here.
>>
>> I think it would make sense to do ACPI based discovery or FF-A
>> based discovery, but doing both I think would be overkill.  For
>> ease of OS integration ACPI is the way to go.  And, potentially
>> device tree in the future.
> 
> Encoding firmware bits in ACPI/DT can be seen as an easy upstream path
> in the shorter run. But when the ACPI/DT becomes overloaded with
> information that has to be passed from firmware to the OS rather than
> purely describing hardware to the OS, it's ABI maintainability becomes
> complex. We are already dealing with DT ABI compatibility challenges
> especially the forward compatibility, so let's not make it even worse
> with firmware information that can be discovered automatically.

The TCG defined ACPI table has the following:
    -Physical address of the TPM
    -Start method
    -Start method specific parameters
    -event log address

This has been in place 8+ years and this is what OSes expect.
The start method advertises the mechanism a driver uses to
signal the TPM that something has changed in the CRB, and
this allows different types of TPM implementations:
    -memory mapped
    -signal via ACPI
    -signal via ARM SMC (legacy)
    -signal via Pluton mailbox
    -signal via FF-A

I don't see this as overloading the ACPI table, it's just what
the OS needs to know.

The TPM does not know (and should not know) the address of
the event log. An FF-A based TPM has no way to know this.

I don't see how changing TPM discovery to be via FF-A directly
would improve maintainability.

> The other benefit of auto discovery is that platform enablement becomes
> really smooth. Once the firmware starts supporting a particular feature
> like TPM over FF-A then the OS can discover and support it.

If we added new CRB/FF-A ABIs to get the CRB physical address,
start method specific parameters, event log, it would mean that
all OSes and hypervisors need to re-architect their CRB drivers
or create new FF-A specific CRB drivers.  That will not smooth
enablement for TPMs.  And I don't see advantages for
maintainability.

Thanks,
Stuart



