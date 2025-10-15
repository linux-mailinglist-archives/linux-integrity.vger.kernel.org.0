Return-Path: <linux-integrity+bounces-7435-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8616BE0EBC
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Oct 2025 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924C14866C2
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Oct 2025 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A6305E2C;
	Wed, 15 Oct 2025 22:22:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452F2566E2;
	Wed, 15 Oct 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566977; cv=none; b=KL6NOswBoTYfEqbL+Tp3+vfm4cOULC6uAbQEw/8rE8RCM74mdOcVTYf6mr8lo0uBzy+sPtC8sUFnitmWPNc4/hpWSOEqVvCYSMUowm2/8wB9uyEyAsvElilBbKvoDPXqm28X5ddQTRr8ifZOArcvFLwdlRYidggxCut2G74BUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566977; c=relaxed/simple;
	bh=8gNyCx9yucUM9flUQkm0mtcfMi1xLck9D5c3+GpLY9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYxnz2049Lg8addhd/9gaHUEjKjTi6DGCVQiNFnvoyDAAQgsOdbxd8KV5cfRJhNXnRzW9fjj2wDxb5lhwu1MogGt5FWJwNFVt+qbn5GczqxsGyC20oIA9bs5iKYfquwqnUSjgFi2K7wrP6Akx7f++pGwCbRzWXXaSwcwaMCGtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD191688;
	Wed, 15 Oct 2025 15:22:46 -0700 (PDT)
Received: from [10.122.3.61] (unknown [10.122.3.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E90A33F738;
	Wed, 15 Oct 2025 15:22:53 -0700 (PDT)
Message-ID: <91d8e71a-7013-43d7-9d04-9a191fed50e9@arm.com>
Date: Wed, 15 Oct 2025 17:22:53 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_crb: Add idle support for the Arm FF-A start method
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 sudeep.holla@arm.com, Prachotan.Bathi@arm.com, linux-kernel@vger.kernel.org
References: <20250825205943.1225599-1-stuart.yoder@arm.com>
 <aKzcaaXGQyLfDPrf@kernel.org> <9227d35b-40d6-4faf-910d-ee7de9bbc094@arm.com>
 <aKzoaWeJOh5W0M6J@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <aKzoaWeJOh5W0M6J@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/25 5:49 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 25, 2025 at 05:19:34PM -0500, Stuart Yoder wrote:
>>
>>
>> On 8/25/25 4:58 PM, Jarkko Sakkinen wrote:
>>> On Mon, Aug 25, 2025 at 03:59:43PM -0500, Stuart Yoder wrote:
>>>> According to the CRB over FF-A specification [1], a TPM that implements
>>>> the ABI must comply with the TCG PTP specification. This requires support
>>>> for the Idle and Ready states.
>>>>
>>>> This patch implements CRB control area requests for goIdle and
>>>> cmdReady on FF-A based TPMs.
>>>>
>>>> The FF-A message used to notify the TPM of CRB updates includes a
>>>> locality parameter, which provides a hint to the TPM about which
>>>> locality modified the CRB.  This patch adds a locality parameter
>>>> to __crb_go_idle() and __crb_cmd_ready() to support this.
>>>>
>>>> [1] https://developer.arm.com/documentation/den0138/latest/
>>>>
>>>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
>>>
>>> Perhaps a dummy question but is this "QEMU testable"? I know how
>>> to bind swtpm to QEMU and make it appear as CRB device on x86-64.
>>>
>>> I don't see much testing happening with these ARM CRB patches,
>>> and if that works in the first palce  I could probably add
>>> a new board target to my BR2_EXTERNAL [1].
>>>
>>> I can of course do "negative testing' i.e. that these don't
>>> break x86 ;-)
>>
>> Unfortunately this is not currently testable on QEMU.  We are using
>> the Arm FVP [1], which is also a machine emulator, with the firmware
>> stack and an fTPM running in TrustZone.  The firmware, fTPM, etc are
>> not all publicly available yet, but everything is based on open
>> source projects and the intent is that all the components needed do
>> test this on FVP will be available at some point.
>>
>> There is nothing fundamental that would prevent this from running
>> on QEMU, but just a fair amount of integration and possibly firmware
>> work.
> 
> OK, it's cool and the patch looks totally fine and I can
> "hallucinate it" so:
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Hi Jarkko,

It looks like this patch did not make it into 6.18.  I wanted to make
sure it didn't get lost.  Will it be queued up for 6.19?

Thanks,
Stuart

