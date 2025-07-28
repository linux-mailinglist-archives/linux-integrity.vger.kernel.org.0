Return-Path: <linux-integrity+bounces-6741-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55617B13A52
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE917C384
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21524DD01;
	Mon, 28 Jul 2025 12:17:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257A3B280;
	Mon, 28 Jul 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705041; cv=none; b=OOVvGuI+UJ9vqYkW2UjTCVoUgeU5WsdnI2Xdh+zgC4Z7XXNw+OIik3z935jMoLD3A8ltgNn2NGpRtYZwwYGkc0x8ckgj8eF0syUxwt1eIsROWSh/WW0qREjSX36DuhGhgK3qxOEx0K8jFbX9w5Ny0mI9yAc8IkcKy5ze6V/r+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705041; c=relaxed/simple;
	bh=my8xQtIIqget5FC/01hNyxi+xx7G96/J8OXPtSZnfCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QQJwn4XqcCeZhqpttzNjHWCkYWaVLZ498t1B7s2+5aMj9VFGa4c+KjrgXy9R2YSC+DyMUgn2pMRMwZgXZzhYSv5CAq/OVQmoBlA52tyQRk3E8uEzJIXXTCa4XFaUxnZ9HUK37784R1H7BWcj3OKC/gVfFDSpve90Y158VTMf9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4brHRw6X1Bzdbw2;
	Mon, 28 Jul 2025 20:13:00 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 939681402EA;
	Mon, 28 Jul 2025 20:17:13 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 20:17:12 +0800
Message-ID: <a8bec841-149c-4349-b7a0-ffebe43dd671@huawei.com>
Date: Mon, 28 Jul 2025 20:17:12 +0800
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
 <362b3e8a-0949-42d1-a1d0-90bd12d86b09@huawei.com>
 <683380bb-ef1b-44ab-b7df-83c23dd76ff7@linux.ibm.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <683380bb-ef1b-44ab-b7df-83c23dd76ff7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemg100016.china.huawei.com (7.202.181.57)


On 7/26/2025 2:29 AM, Nayna Jain wrote:
> 
> On 7/17/25 8:29 AM, GONG Ruiqi wrote:
>> On 7/8/2025 4:35 AM, Nayna Jain wrote:
>>> On 7/2/25 10:07 PM, GONG Ruiqi wrote:
>>>> ...
>>
>> Yes, IMA_ARCH_POLICY was not set. The testing was conducted on
>> openEuler[1], a Linux distro mainly for arm64 & x86, and the kernel was
>> compiled based on its own openeuler_defconfig[2], which set
>> IMA_ARCH_POLICY to N.
> 
> Thanks Ruiqi for the response.
> 
> It seems the main cause of the problem was that IMA_ARCH_POLICY config
> wasn't enabled; and it sounds like you don't need IMA arch policies but
> you do need the arch specific function to get the secure boot status.
> 
> In that case, removing IMA_SECURE_AND_OR_TRUSTED_BOOT config dependency
> on IMA_ARCH_POLICY config and updating the corresponding help is all
> that is needed.

I think it doesn't solve the real problems, which are: 1. the implicit
dependency of LOAD_UEFI_KEYS to IMA_SECURE_AND_OR_TRUSTED_BOOT, which
surprises people, and 2. what arch_ima_get_secureboot() does is
essentially a stand-alone function and it's not necessarily be a part of
IMA, but it's still controlled by IMA_SECURE_AND_OR_TRUSTED_BOOT.

I agree that adjusting Kconfig could be simpler, but breaking
IMA_SECURE_AND_OR_TRUSTED_BOOT's dependency to IMA_ARCH_POLICY doesn't
help on both. If that's gonna be the way we will take, what I would
propose is to let LOAD_UEFI_KEYS select IMA_SECURE_AND_OR_TRUSTED_BOOT,
which states the dependency explicitly so at least solves the problem 1.

-Ruiqi

> 
> The help text can be updated to:
> This option is selected by architectures to detect systems with secure
> and/or trusted boot enabled, in order to load the appropriate IMA
> runtime policies and keys.
> 
> Thanks & Regards,
> 
>     - Nayna
> 


