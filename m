Return-Path: <linux-integrity+bounces-6913-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA45B34EE4
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1AD7AC8CA
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037041F560B;
	Mon, 25 Aug 2025 22:19:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510BB1DDA15;
	Mon, 25 Aug 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160380; cv=none; b=XOtYCkQBL8U1VQot1+CGO99Q6IOY22SjNV4z0EaEN6/u9hfXnc2Mq5vkjhjcT/E9b+/RTde4fw2JLanEQQYBw1f3ZiMFrwEZtiTOvs3xr/LIKLOmQ5lM5uMaGUyKjy2z4NOStjj3noOS6wn6F06TKyAatQgMAmu9MeVdxyh+3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160380; c=relaxed/simple;
	bh=Iyx/rDLNirSE0KYGm3b6wMb4YBP+evfjFlAcm7kNnR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff22Es911i5qAroH1evg0X5snuohr2b6dzauYf6/Hfex/L7oRsz4mUtnCSWImf2NTMb2TtYTTgJZ/zFg6pgcUxKIUieDpWl+wkNI+v2wLmh4jtX5RA4sJ3L8apWLKlG5m4IwFBaDR5ny79b0Da9XyJE63jvcBAd6Gh0pZtuYGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9041D31;
	Mon, 25 Aug 2025 15:19:27 -0700 (PDT)
Received: from [10.119.36.130] (unknown [10.119.36.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A20B23F738;
	Mon, 25 Aug 2025 15:19:35 -0700 (PDT)
Message-ID: <9227d35b-40d6-4faf-910d-ee7de9bbc094@arm.com>
Date: Mon, 25 Aug 2025 17:19:34 -0500
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
 <aKzcaaXGQyLfDPrf@kernel.org>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <aKzcaaXGQyLfDPrf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/25 4:58 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 25, 2025 at 03:59:43PM -0500, Stuart Yoder wrote:
>> According to the CRB over FF-A specification [1], a TPM that implements
>> the ABI must comply with the TCG PTP specification. This requires support
>> for the Idle and Ready states.
>>
>> This patch implements CRB control area requests for goIdle and
>> cmdReady on FF-A based TPMs.
>>
>> The FF-A message used to notify the TPM of CRB updates includes a
>> locality parameter, which provides a hint to the TPM about which
>> locality modified the CRB.  This patch adds a locality parameter
>> to __crb_go_idle() and __crb_cmd_ready() to support this.
>>
>> [1] https://developer.arm.com/documentation/den0138/latest/
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> 
> Perhaps a dummy question but is this "QEMU testable"? I know how
> to bind swtpm to QEMU and make it appear as CRB device on x86-64.
> 
> I don't see much testing happening with these ARM CRB patches,
> and if that works in the first palce  I could probably add
> a new board target to my BR2_EXTERNAL [1].
> 
> I can of course do "negative testing' i.e. that these don't
> break x86 ;-)

Unfortunately this is not currently testable on QEMU.  We are using
the Arm FVP [1], which is also a machine emulator, with the firmware
stack and an fTPM running in TrustZone.  The firmware, fTPM, etc are
not all publicly available yet, but everything is based on open
source projects and the intent is that all the components needed do
test this on FVP will be available at some point.

There is nothing fundamental that would prevent this from running
on QEMU, but just a fair amount of integration and possibly firmware
work.

[1] 
https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Arm%20Architecture%20FVPs

Thanks,
Stuart

