Return-Path: <linux-integrity+bounces-6599-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD08EAF67BB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 04:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AC4A627A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257981AD3FA;
	Thu,  3 Jul 2025 02:07:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714A1AA1DA;
	Thu,  3 Jul 2025 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508473; cv=none; b=fis5RJPj9olWDkyLdt69y29/y8p1XnjV2b3ln+u0xUQK00Fq+ZgduafIhUj9TsecgzgchztzXFIN813neTNekzhAd5r/z9Cy4DgUp8qUS3kFP8Em3WJ6mOGzO9t7Z3kqgbSWNNMUBxUQjnoYnF4Yw36Vjwmy9jF6py02/bssvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508473; c=relaxed/simple;
	bh=IquZDjz7BuIdvLTYfPk+p86LfsQpBrAykfTP8M7LjY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mBYTb0qjpucKJtsshpx12pyGaZtw0W9kCF+gPsS4zmxJUFsJ+4CpcajKLhjjUIFEyTETNXa7D0ypPn+R/22adxDBQW/5ZTf6XWdsPPDUaMjDfXnCfhMe//M08rWL4ULygh+rsRo2ZIaol1CyrshzmllvvxfcqEK/B2VVDi8uqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bXgDB3grfz16TK1;
	Thu,  3 Jul 2025 10:08:42 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E8D49140109;
	Thu,  3 Jul 2025 10:07:45 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 3 Jul
 2025 10:07:44 +0800
Message-ID: <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
Date: Thu, 3 Jul 2025 10:07:39 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] integrity: Extract secure boot enquiry function out of
 IMA
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"Lee, Chun-Yi" <jlee@suse.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, Lu Jialin
	<lujialin4@huawei.com>, Nayna Jain <nayna@linux.ibm.com>
References: <20250628063251.321370-1-gongruiqi1@huawei.com>
 <eb91dcf034db28e457a4482faa397dd7632f00fd.camel@linux.ibm.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <eb91dcf034db28e457a4482faa397dd7632f00fd.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Hi Mimi,

On 7/3/2025 9:38 AM, Mimi Zohar wrote:
> [CC: Nayna Jain]
> 
> On Sat, 2025-06-28 at 14:32 +0800, GONG Ruiqi wrote:
>> ...
> 
> The original reason for querying the secure boot status of the system was in
> order to differentiate IMA policies.  Subsequently, the secure boot check was
> also added to safely allow loading of the certificates stored in MOK. So loading
> IMA policies and the MOK certificates ARE dependent on the secure boot mode.
>                                                                                 
> What is your real motivation for moving the secure boot checking out of IMA?    
>                                                                                 

Sorry for not stating that clearly in this patch. I think the cover
letter of V3 I just sent few minutes ago can answer your question, and I
quote:

"We encountered a boot failure issue in an in-house testing, where the
kernel refused to load its modules since it couldn't verify their
signature. The root cause turned out to be the early return of
load_uefi_certs(), where arch_ima_get_secureboot() returned false
unconditionally due to CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n, even
though the secure boot was enabled.

This patch set attempts to remove this implicit dependency by shifting
the functionality of efi secure boot enquiry from IMA to the integrity
subsystem, so that both certificate loading and IMA can make use of it
independently."

Here's the link of V3, and please take a look:
https://lore.kernel.org/all/20250703014353.3366268-1-gongruiqi1@huawei.com/T/#mef6d5ea47a4ee19745c5292ab8948eba9e16628d

> FYI, there are a number of problems with the patch itself.  From a very high
> level:  
>                                                                                 
> - The EFI secure boot check is co-located with loading the architecture specific
> policies.  By co-locating the secure boot check with loading the architecture
> specific IMA policies, there aren't any ifdef's in C code.  Please refer to the
> "conditional compilation" section in the kernel coding-style documentation on
> avoiding ifdef's in C code.
>                                                                                 
> - Each architecture has it's own method of detecting secure boot. Originally the
> x86 code was in arch/x86, but to prevent code duplication it was moved to IMA. 
> The new file should at least be named efi_secureboot.c.  

You're right. I didn't realize it's arch-specific in the first place,
and moving and renaming arch_ima_get_secureboot() turned out to be a
real mess ...

So the V3 keeps the prototype of arch_ima_get_secureboot(), and only
moves out its body, which I think can also better represent the
intention of the patch.

As of the name of the new file, as V3 has been sent earlier and still
uses secureboot.c, I can't change it there. I can do it in V4.

-Ruiqi

>                                                                                 
> - The patch title should be about moving and renaming the secure boot check. 
> The patch description should include a valid reason for the change.
> 
> Mimi & Nayna


