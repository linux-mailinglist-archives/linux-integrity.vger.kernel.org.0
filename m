Return-Path: <linux-integrity+bounces-6602-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED7AF69AD
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 07:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBEF523DFB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 05:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB528DF50;
	Thu,  3 Jul 2025 05:19:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CE1CD1F;
	Thu,  3 Jul 2025 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519976; cv=none; b=KtzaqXuV+1YSpwx1Iv6dH2oegUnCTyALALSVK6KUuJ2BEvfAfY706YCWbmjq2vi0bJKdQRID3Prs0dic33A7AGzpnNhsWcqOuXdvh+IVzlfRlOHh+G03UOYd+tNGYJSNgzjwhfBp2MjOLA0IvVC21maLHw1RwT03buuAX+AQzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519976; c=relaxed/simple;
	bh=FLQHFyFnF79ZYkVvNFpZHokSY4TYrKj7rLTdiGbuHCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B1Mo9j9gdfLpVrBaGdHs6fZ03uxPvMSyzoMPpdqGRTAd+cksOK6iIUeymSEbus4rMoFToaww2LgAG3Wq0Rheph2T6816eR7g5WFM1BpyZo2UAxh/qR0bnCAx+uFO0q3dUqUfiba+T0CZ/RIgNHm81QBQ+lmuUyF+er6R4uUGGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXlPH5ymrz1R8bq;
	Thu,  3 Jul 2025 13:16:51 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 387E51A0188;
	Thu,  3 Jul 2025 13:19:23 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 3 Jul
 2025 13:19:22 +0800
Message-ID: <a06d0bc2-e5e3-43e1-9bed-f7d370afeec1@huawei.com>
Date: Thu, 3 Jul 2025 13:19:21 +0800
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
 <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
 <15ae451cf47f45a7b540200107ef1f5d1d1543f9.camel@linux.ibm.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <15ae451cf47f45a7b540200107ef1f5d1d1543f9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg100016.china.huawei.com (7.202.181.57)


On 7/3/2025 11:35 AM, Mimi Zohar wrote:
> ...
>>
>> You're right. I didn't realize it's arch-specific in the first place,
>> and moving and renaming arch_ima_get_secureboot() turned out to be a
>> real mess ...
>>
>> So the V3 keeps the prototype of arch_ima_get_secureboot(), and only
>> moves out its body, which I think can also better represent the
>> intention of the patch.
> 
> It's definitely much better.  To summarize, arch_ima_get_secureboot() becomes a
> wrapper for integrity_get_efi_secureboot().  Before loading the MOK/MOKx keys,
> load_uefi_certs() calls integrity_get_efi_secureboot() directly.

Exactly.

> 
> With load_uefi_certs() calling integrity_get_efi_secureboot() directly, please
> check to see whether an integrity_get_efi_secureboot() stub function needs to be
> defined.

For CONFIG_LOAD_UEFI_KEYS and CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT, the
former depends on CONFIG_EFI while the latter is implied by the same, so

  integrity-$(CONFIG_EFI) += secureboot.o

should be enough. I've compile-tested the V3 on x86/arm64/powerpc/s390,
with various config combinations as much as I can think of. Let's see if
the kernel test robot could find out some corner cases.

-Ruiqi

> 
> Mimi
> 
>>
>> As of the name of the new file, as V3 has been sent earlier and still
>> uses secureboot.c, I can't change it there. I can do it in V4.
>>
>> -Ruiqi
> 


