Return-Path: <linux-integrity+bounces-5773-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A24A84604
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D371BA4CCA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75328A404;
	Thu, 10 Apr 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SAx6X8MC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2128A407;
	Thu, 10 Apr 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294435; cv=none; b=P5jAiBPI0cGP0J8G60YHPjgABxS3UUQIvJXtPPlyNasesRLyFw+8+LzwZ1wHGzfJrEVY6Oex2M9FTCGeARzJVta9DcMR4MP7u1rTeNriPuCmfzb/mYiUH4kpind4Rsbfej4Pnoejc8M5au2PsbV6cmUmWMFsVTMRPQu8Fz2Ph7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294435; c=relaxed/simple;
	bh=qFzmG+8vvYNiGahoaDUXf4zVGM29W+K7UrXueTUEiK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGMWFB6NKUFKbgLBMdh1kjkPBqDjl3DtY+M2NnWmPN+vBwJtSFgtAI6w5Xujyq+5OWLdF2CFzphXu+BJSxVqQixWDLNoUV+H6ZUIurj0/DBamhDCG2NWUoALVdZWnFsXHPbd3f3oOHclclw4ro8yuIaAJ2pENCEHfSkRASSPbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SAx6X8MC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.180] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60AC32114DA5;
	Thu, 10 Apr 2025 07:13:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60AC32114DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294433;
	bh=C8ms2drYX3b/coVXj+lhvtPuBfcvsMd9srrchobseXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SAx6X8MCrg6kMd78jooH+IKG21F8FQ28qatQJMcBMm07hc1ThblOgBn53uw5gXP13
	 Jl14Vei+YllF1a0krFo2xaqgPT7c34QPBjr0qNVKYowrNUePFQrtT+Rhpoig5EweBm
	 QfaxHha1qECQcUo4/fB/0WoHAYTPaTzmsZgYFIWA=
Message-ID: <51203aaf-b3a2-4352-b5a0-1ad6094d0243@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:13:49 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-6-chenste@linux.microsoft.com>
 <90fff5f793fb48659e20fa69cb5895867f51e021.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <90fff5f793fb48659e20fa69cb5895867f51e021.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/2025 7:21 AM, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
>> The IMA log is currently copied to the new kernel during kexec 'load'
>> using ima_dump_measurement_list(). However, the log copied at kexec
>> 'load' may result in loss of IMA measurements that only occurred after
>> kexec "load'.
> Ok
>
>> Therefore, the log needs to be copied during kexec
>> 'execute'.
> The above line is unnecessary.
>
>> Setup the needed infrastructure to move the IMA log copy from
>> kexec 'load' to 'execute'.
>>
>> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
>> It will be used to call ima_dump_measurement_list() during kexec 'execute'.
>>
>> Implement ima_kexec_post_load() function to be invoked after the new
>> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
>> IMA buffer to a segment in the newly loaded Kernel.  It also registers
>> the reboot notifier_block to trigger ima_update_kexec_buffer() at
>> kexec 'execute'.
>>
>> Set the priority of register_reboot_notifier to INT_MIN to ensure that the
>> IMA log copy operation will happen at the end of the operation chain, which
>> is crucial for maintaining the integrity of the logs
> Instead of ", which is crucial for maintaining the integrity of the logs"
> say something like ", so that all the IMA measurement records extended into the
> TPM are copied."

Hi Mimi,

I will update in next version.

Thanks,

Steven

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Thanks, Steven.  With the change to use INT_MIN, the "kexec_execute" record is
> now added to the IMA measurement list, extended into the PCR, and included in
> the IMA measurement list records copied.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>



