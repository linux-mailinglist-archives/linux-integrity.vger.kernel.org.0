Return-Path: <linux-integrity+bounces-5253-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9168DA5E599
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 21:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F2B3AB318
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E9F1DED72;
	Wed, 12 Mar 2025 20:47:14 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537E6258A;
	Wed, 12 Mar 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812434; cv=none; b=MVG1jIR8uRJ9O1qlNDwd59MLRsRVjG7w4+nachT/H+8PJOxpU/gDBxC0gUZErDHWTbGD7oNw8DQiodOtRVG57nZG+IJ1/iRfsC+Qwei3qAitCz+ccrv1aH9p//EfVe4Bww4epBSCAIWkw87rH2oh5Wa0AtRiDCI5f6nYmpV3F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812434; c=relaxed/simple;
	bh=oHoaylZ0+e02kulPIew6Nn6BhlI26LCAOEVuoJmwZY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qapxFJ8kRCzPJZczyJuxV2Hm5LqJ3A9gtjk4vejrWOEEw9LVQctoWcBoX3LipnKW42A+mqjjlU6e6+qQrn2Kz2uY2GJe2t9Yh5DO+zDyHJSciv9hWg3uJ62iUAcfegv1yjgGCPebkqiU+ZmfKRMzoMYERdEdoap2lcxo8yrBH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E338015A1;
	Wed, 12 Mar 2025 13:47:21 -0700 (PDT)
Received: from [10.118.111.35] (G9L3377F54.austin.arm.com [10.118.111.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4ABA3F673;
	Wed, 12 Mar 2025 13:47:10 -0700 (PDT)
Message-ID: <25269252-e45f-4692-a519-a0703b6800a1@arm.com>
Date: Wed, 12 Mar 2025 15:47:10 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build error on -next due to tpm_crb.c changes?
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, jarkko@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org,
 rafael@kernel.org, jgg@ziepe.ca, peterhuewe@gmx.de,
 linux-integrity@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
 <92bc0a65-608f-4307-bb1c-16d8836d42e5@arm.com>
 <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
 <23c77291-7c6e-45ea-b1ad-952c01882579@arm.com>
 <20250311211700.bwizwecxyxorrwql@bogus>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <20250311211700.bwizwecxyxorrwql@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/25 4:17 PM, Sudeep Holla wrote:
> On Tue, Mar 11, 2025 at 01:25:50PM -0500, Stuart Yoder wrote:
>>
>>
>> On 3/11/25 11:51 AM, Thorsten Leemhuis wrote:
>>> On 11.03.25 16:53, Stuart Yoder wrote:
>>>> On 3/11/25 10:21 AM, Thorsten Leemhuis wrote:
>>>>> On 05.03.25 18:36, Stuart Yoder wrote:
>>>> [...]
>>>> So, it should not be possible on one had have
>>>> CONFIG_TCG_ARM_CRB_FFA being true when building tpm_crb.c
>>>> and false resulting in the tpm_crb_ffa.o not being
>>>> picked up in the build.
>>>
>>> Many thx for the answer. Maybe Fedora's way to prepare the .config files
>>> (which my package builds use to be close to Fedora's official packages)
>>> is doing something odd/wrong. Will take a closer look and report back.
>>
>> I've been experimenting with some different build config combinations
>> and have reproduced what must be the issue.
>>
>> This works fine:
>> <*>   TPM 2.0 CRB Interface                                         < >
>> TPM CRB over Arm FF-A Transport
>>
>> This works fine:
>> < >   TPM 2.0 CRB Interface                                         <*>
>> TPM CRB over Arm FF-A Transport
>>
>> This works fine:
>> <*>   TPM 2.0 CRB Interface                                         <*>
>> TPM CRB over Arm FF-A Transport
>>
>> This works fine:
>> <M>   TPM 2.0 CRB Interface                                         <M>
>> TPM CRB over Arm FF-A Transport
>>
>> This fails:
>> <*>   TPM 2.0 CRB Interface                                         <M>
>> TPM CRB over Arm FF-A Transport
>>
>> The 2 drivers are coupled, so we can't have one built as a module
>> and the other built-in.
>>
>> I'm not a Kconfig expert, and need to do some fiddling to see
>> if I can find a Kconfig syntax that prevents that failure scenario.
>>
> 
> 	default y if (TCG_CRB && ARM_FFA_TRANSPORT)
> 
> is the issue here. You can select it as built-in if either or one of the
> TCG_CRB and ARM_FFA_TRANSPORT is a module, but that is exactly what happens.
> Not sure if default value is a must for you. But just depends on each of
> these should be good enough and enable it in defconfig if needed. Or
> you can have multiple default at least 4 combinations I can see. Both
> are =y and either and both are =m

I would like a default, because if someone enables both
ARM_FFA_TRANSPORT and TPM_CRB I don't want them to forget to
turn on TCG_ARM_CRB_FFA.

I've experimented with a few ways of doing this and I think
this is simplest and gives the behavior we want:

config TCG_ARM_CRB_FFA
         tristate "TPM CRB over Arm FF-A Transport"
         depends on ARM_FFA_TRANSPORT && TCG_CRB
         default TCG_CRB

The TCG_ARM_CRB_FFA option only appears if both FFA and
TPM_CRB are enabled. And the default tracks the value
of TPM_CRB.

Thanks,
Stuart




