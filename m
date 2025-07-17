Return-Path: <linux-integrity+bounces-6648-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70116B08CE2
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Jul 2025 14:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496F23B1775
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Jul 2025 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A62BE651;
	Thu, 17 Jul 2025 12:29:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91512989BC;
	Thu, 17 Jul 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755361; cv=none; b=uAdxCNvfwam7vdvrTfm0629z1kddvwKbjAzAf4I4ZUzxaF8n/u4GO1n8enQdAiqs9K648DvE2wN+sw5lLUu/eMW1TLa9Hf6XnWdrpBBzjzrB/WkcvqjIQp6b8FgezsUHGYXE4afKMJ06Rc4j9KSnJnShAe7JIuz3D2gXWYPcdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755361; c=relaxed/simple;
	bh=rUMZyQff5ZmD3KADfcyWUpSRiydZT7kOQan8y+z/Y0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CeQzXRNHq4N492ewRrVYaamhAJuMfaky1hvGf9p728MQ2E9GhqLYs5iwt0X9eaKSoGVHb9//koFhj35aq0e6kO0nObp5iLu4JLUbrBNKqD6Nwrhp/vPCe1f32/D/d0QizfrG5ldE/4wHcsbdEzi6Bujj2lXY6V7HnolEd4A0WQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bjXGT3dmMzZhwR;
	Thu, 17 Jul 2025 20:26:25 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D0B1D180B3F;
	Thu, 17 Jul 2025 20:29:14 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Jul
 2025 20:29:13 +0800
Message-ID: <362b3e8a-0949-42d1-a1d0-90bd12d86b09@huawei.com>
Date: Thu, 17 Jul 2025 20:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] integrity: Extract secure boot enquiry function out of
 IMA
To: Nayna Jain <nayna@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
	<dmitry.kasatkin@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"Lee, Chun-Yi" <jlee@suse.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, Lu Jialin
	<lujialin4@huawei.com>
References: <20250628063251.321370-1-gongruiqi1@huawei.com>
 <eb91dcf034db28e457a4482faa397dd7632f00fd.camel@linux.ibm.com>
 <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
 <e8aa7f94-3e52-488d-a858-564d3d1edd4b@linux.ibm.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <e8aa7f94-3e52-488d-a858-564d3d1edd4b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemg100016.china.huawei.com (7.202.181.57)


On 7/8/2025 4:35 AM, Nayna Jain wrote:
> 
> On 7/2/25 10:07 PM, GONG Ruiqi wrote:
>> 
>> ...
>>
>> "We encountered a boot failure issue in an in-house testing, where the
>> kernel refused to load its modules since it couldn't verify their
>> signature. The root cause turned out to be the early return of
>> load_uefi_certs(), where arch_ima_get_secureboot() returned false
>> unconditionally due to CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n, even
>> though the secure boot was enabled.
> Thanks for sharing additional details.
> 
> From x86 Kconfig:
> 
> /For config x86:
> 
>     imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> /
> And IMA_SECURE_AND_OR_TRUSTED_BOOT is dependent on IMA_ARCH_POLICY .
> 
> And from Linux Kernel Kbuild documentation( https://docs.kernel.org/
> kbuild/kconfig-language.html) :
> 
> /weak reverse dependencies: “imply” <symbol> [“if” <expr>]
> 
> This is similar to “select” as it enforces a lower limit on another
> symbol except that the “implied” symbol’s value may still be set to n
> from a direct dependency or with a visible prompt.
> 
> /Following the example from the documentation, if  it is EFI enabled and
> IMA_ARCH_POLICY is set to y then this config should be default enabled.
> 
> If it is EFI enabled and IMA_ARCH_POLICY is set to N, then the setting
> for IMA_SECURE_AND_OR_TRUSTED_BOOT should be prompted during the build.
> The default setting for prompt is N. So, the person doing the build
> should actually select Y to enable IMA_ARCH_POLICY.
> 
> Wondering what is the scenario for you? Unless you have IMA_ARCH_POLICY
> set to N, this config should have been ideally enabled. If you have
> explicitly set it to N, am curious any specific reason for that.

Hi Nayna. Sorry for the late reply. Super busy these days...

Yes, IMA_ARCH_POLICY was not set. The testing was conducted on
openEuler[1], a Linux distro mainly for arm64 & x86, and the kernel was
compiled based on its own openeuler_defconfig[2], which set
IMA_ARCH_POLICY to N.

-Ruiqi

[1]: https://www.openeuler.org/en/
[2]:
https://gitee.com/openeuler/kernel/blob/OLK-6.6/arch/arm64/configs/openeuler_defconfig


> 
> Thanks & Regards,
> 
>    - Nayna
>>
>> ...


