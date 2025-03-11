Return-Path: <linux-integrity+bounces-5232-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C3BA5C8E4
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E691188040B
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CC25EF98;
	Tue, 11 Mar 2025 15:53:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04DA25EF89;
	Tue, 11 Mar 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708417; cv=none; b=itFDRkHRYe4NRWxoJMzuWO1VAd7KAKiEzhJ7wVR7+8JVFzlDw5mHhxZJd2fzOthSZAHwVeLcv5r1vuXt4zs/QNt8BgGGOnIqJ1m74ME8wEoCFBQLluHR5V7RV8KmFsB9AAU+xlkRV8JS8xziUKxzh3U+iw1Wdr/vkWdBU+DECPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708417; c=relaxed/simple;
	bh=54+k/qTljaoqoS/nzOGHavBczwfmeihS1x3jZEhqrFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/QS5C4jVEyCn1OexyzhY5vARAwOa0BVFx3EIynI1TaZJ7M4vP16lZKnBAOx+FOn7fooIjaPohGjuqSdfkTT+vxQZIFYZEeGbSl6Hnuux0UOH6wF6QnQK/a6Nf5Oot+tiGC+vgh9a5CIZxAI34f5DKISk1/InyJps0O28e8L+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A117E1516;
	Tue, 11 Mar 2025 08:53:45 -0700 (PDT)
Received: from [10.119.37.172] (unknown [10.119.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB6AD3F673;
	Tue, 11 Mar 2025 08:53:33 -0700 (PDT)
Message-ID: <92bc0a65-608f-4307-bb1c-16d8836d42e5@arm.com>
Date: Tue, 11 Mar 2025 10:53:33 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build error on -next due to tpm_crb.c changes?
To: Thorsten Leemhuis <linux@leemhuis.info>, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lenb@kernel.org, rafael@kernel.org, jgg@ziepe.ca, peterhuewe@gmx.de,
 sudeep.holla@arm.com, linux-integrity@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/25 10:21 AM, Thorsten Leemhuis wrote:
> On 05.03.25 18:36, Stuart Yoder wrote:
>> Firmware Framework for Arm A-profile (FF-A) is a messaging framework
>> for Arm-based systems, and in the context of the TPM CRB driver is used
>> to signal 'start' to a CRB-based TPM service which is hosted in an
>> FF-A secure partition running in TrustZone.
>>
>> These patches add support for the CRB FF-A start method defined
>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
>> in the Arm TPM Service CRB over FF-A (DEN0138) specification:
>> https://developer.arm.com/documentation/den0138/latest/
>> [...]
>> Stuart Yoder (5):
>>    tpm_crb: implement driver compliant to CRB over FF-A
>>    tpm_crb: clean-up and refactor check for idle support
>>    ACPICA: add start method for Arm FF-A
>>    tpm_crb: add support for the Arm FF-A start method
>>    Documentation: tpm: add documentation for the CRB FF-A interface
>>
>>   Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
>>   drivers/char/tpm/Kconfig                   |   9 +
>>   drivers/char/tpm/Makefile                  |   1 +
>>   drivers/char/tpm/tpm_crb.c                 | 105 +++++--
>>   drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
>>   drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
>>   include/acpi/actbl3.h                      |   1 +
>> [...]
> 
> My daily linux-next builds for Fedora failed building on ARM64 today. I did
> not bisect, but from the error message I suspect it's du to  patches in this
> series touching drivers/char/tpm/tpm_crb.c :
> 
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: drivers/char/tpm/tpm_crb.o: in function `crb_cancel':
> /builddir/foo//drivers/char/tpm/tpm_crb.c:496:(.text+0x2c0): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_request_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:285:(.text+0x768): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_relinquish_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:319:(.text+0x81c): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_request_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:285:(.text+0x8bc): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o: in function `__crb_relinquish_locality':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:319:(.text+0x958): undefined reference to `tpm_crb_ffa_start'
> ld: drivers/char/tpm/tpm_crb.o:/builddir/foo/drivers/char/tpm/tpm_crb.c:474: more undefined references to `tpm_crb_ffa_start' follow
> ld: drivers/char/tpm/tpm_crb.o: in function `crb_acpi_add':
> /builddir/foo/drivers/char/tpm/tpm_crb.c:830:(.text+0x1518): undefined reference to `tpm_crb_ffa_init'
> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> make[1]: *** [/builddir/foo/Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:259: __sub-make] Error 2
> 
> Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-41-aarch64/08750241-next-next-all/builder-live.log.gz
> 
> Same problem on Fedora 40, 42 and 43.

The problem seems to be that tpm_crb.o was built with
CONFIG_TCG_ARM_CRB_FFA enabled, yet somehow the
tpm_crb_ffa.o file is not being picked up by the build.

Not sure how this is possible. I've tested all combinations
I could through make menuconfig.

tpm_crb_ffa.h is defined as:

#if IS_ENABLED(CONFIG_TCG_ARM_CRB_FFA)
int tpm_crb_ffa_init(void);
int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor);
int tpm_crb_ffa_start(int request_type, int locality);
#else
static inline int tpm_crb_ffa_init(void) { return 0; }
static inline int tpm_crb_ffa_get_interface_version(u16 *major, u16 
*minor) { return 0; }
static inline int tpm_crb_ffa_start(int request_type, int locality) { 
return 0; }
#endif

And so due to the linker error, it's clear we're getting the function
prototypes and not the inline functions.

The tpm Makefile defines

obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o

So, it should not be possible on one had have
CONFIG_TCG_ARM_CRB_FFA being true when building tpm_crb.c
and false resulting in the tpm_crb_ffa.o not being
picked up in the build.

Thanks,
Stuart





