Return-Path: <linux-integrity+bounces-6567-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCCAEC440
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Jun 2025 04:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4A1563634
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Jun 2025 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF061CBA02;
	Sat, 28 Jun 2025 02:37:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2C5661;
	Sat, 28 Jun 2025 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751078252; cv=none; b=Ev1FOYcgtBjVkYP1blP8fsfJdtqN8l7Rm1Yd3jsrw/wQDzksM36GfTf45CPHmm17VUMbsvbZSSNPPy/p/fAgYHzMYtAWLXpG98Mqle4oeQj+67Ib0KIRamXsj6COm1qL0O1L5wbg1Sn/r/UPc+6ms6a2oSPMvKzcbqfVJhOj94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751078252; c=relaxed/simple;
	bh=pupNprCGYkqHbXsGtNUn13adsLGhlEmWMtEyoD/BQ5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q6jzPBhujLVNALVpt2rdsOEybOZKfay017WAjV33K/otJhveOBBWV9A9LOOk3MfoU8m8kzW4o+pfPLW5IEA3Ph85Q8ad0N8ZUNfRkOk63wgjlonb8HizbYzXvwT3KGSS/mhqgrev9kXBwaWG8rAoavTuzuqNRDduyPy2BCj9ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bTc0x6GgWzdbgF;
	Sat, 28 Jun 2025 10:33:21 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D61BC180B3F;
	Sat, 28 Jun 2025 10:37:20 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Jun
 2025 10:37:19 +0800
Message-ID: <267d0e56-6040-426c-8b1e-a53b18829871@huawei.com>
Date: Sat, 28 Jun 2025 10:37:18 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] integrity: Extract secure boot enquiry function
 out of IMA
To: Alexander Gordeev <agordeev@linux.ibm.com>
CC: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Eric Snowberg
	<eric.snowberg@oracle.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Lee,
 Chun-Yi" <jlee@suse.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, Lu Jialin
	<lujialin4@huawei.com>
References: <20250626023617.3885806-1-gongruiqi1@huawei.com>
 <aF6/ItTfd7oVN+Sn@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <aF6/ItTfd7oVN+Sn@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg100016.china.huawei.com (7.202.181.57)



On 2025/06/27 23:56, Alexander Gordeev wrote:
> On Thu, Jun 26, 2025 at 10:36:17AM +0800, GONG Ruiqi wrote:
> 
> Hi GONG,
> 
> ...
>> Compile-tested for powerpc, s390 and x86, all with allmodconfig.
> 
> This breaks defconfig and debug_defconfig builds on s390
> since IMA_ARCH_POLICY=n in these configurations and thus
> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n as well:

Hi Alexander,

Thanks for the feedback! I'll fix it and send a V2 asap.

BR,
Ruiqi

> 
> s390x-15.1.0-ld: security/integrity/ima/ima_main.o: in function `ima_load_data':
> /home/agordeev/linux.c3/security/integrity/ima/ima_main.c:902:(.text+0x54e): undefined reference to `arch_integrity_get_secureboot'
> s390x-15.1.0-ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_parse_cmdline':
> /home/agordeev/linux.c3/security/integrity/ima/ima_appraise.c:30:(.init.text+0x44): undefined reference to `arch_integrity_get_secureboot'
> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
> make[1]: *** [/home/agordeev/linux.c3/Makefile:1236: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
>> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
> 
> Thanks!

