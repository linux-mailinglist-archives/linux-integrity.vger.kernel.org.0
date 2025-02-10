Return-Path: <linux-integrity+bounces-4767-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A3A2F4A1
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54EB18881E1
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E488157487;
	Mon, 10 Feb 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wu7tXo2u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE0256C98;
	Mon, 10 Feb 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207204; cv=none; b=s46MguSwj83L2GpzTWfEA8m04ohuWs0no2s09l/HaLHq/FBGfZWfW1mgg3UKwZePb+nxGAe1yjVqqxJevj81ILJdUrfVKcoVc3SRuxbtk2R6snijQg8pJrOo4s5WfzeoQ8hDD3sLHCAxOZ/n739hLfRAf3mPWdyxWq3aVEq+AKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207204; c=relaxed/simple;
	bh=TyUfWAmbEbR0Syct5DJ0eVHnlK1SeULECfjdeJXxZvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2njr2rRHkSrgDWRaTzTeAQZJcltHNsAueO74v2RQGyyFx4kuQ0eqQK9YBeyPv9zT/tSTkH8UHHxdMDOappbxksj3jgDuUnVM8cFfiiWyzB1m4lzs3LXq4MO7AHg3fJ98IOrPeeE2te90dNEgq31/IZxPW9qmQ7yq3uefV7IKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wu7tXo2u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.80] (unknown [131.107.8.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2DF12107A8C;
	Mon, 10 Feb 2025 09:06:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2DF12107A8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739207203;
	bh=hBpyYwH84HCTrmNtrOfgoYnF3s0Iwvrtgi04480qzkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wu7tXo2u19roGC3JKJIuc8Lip2MC7atTL9MEET8GC+paes93zHV3Yvh2rI8g8qFpL
	 y/spmSThEjUpGTNvdL4+4tQuc4XJNZ1C7kcxFZoCP1LLSdiijmgaaolHCZg5wutVe6
	 OP3RuYFwggt0BggyJQqLZhfsTwaAkzWUM4DFTQCk=
Message-ID: <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
Date: Mon, 10 Feb 2025 09:06:42 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-3-chenste@linux.microsoft.com>
 <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/7/2025 11:15 AM, Mimi Zohar wrote:
> Hi Steven,
>
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>> Currently, the mechanism to map and unmap segments to the kimage
>> structure is not available to the subsystems outside of kexec.  This
>> functionality is needed when IMA is allocating the memory segments
>> during kexec 'load' operation.  Implement functions to map and unmap
>> segments to kimage.
>>
>> Implement kimage_map_segment() to enable mapping of IMA buffer source
>> pages to the kimage structure post kexec 'load'.  This function,
>> accepting a kimage pointer, an address, and a size, will gather the
>> source pages within the specified address range, create an array of page
>> pointers, and map these to a contiguous virtual address range.  The
>> function returns the start of this range if successful, or NULL if
>> unsuccessful.
>>
>> Implement kimage_unmap_segment() for unmapping segments
>> using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> I don't recall previously adding my "Reviewed-by" tag.
>
> Eric, I'd appreciate your reviewing this and the subsequent patch "[PATCH v7 3/7]
> ima: kexec: skip IMA segment validation after kexec soft reboot" in particular.
Hi Eric, Could you help to review this patch as Mimi mentioned? Thanks!
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   include/linux/kexec.h |  7 ++++++
>>   kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..f8413ea5c8c8 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -467,6 +467,9 @@ extern bool kexec_file_dbg_print;
>>   #define kexec_dprintk(fmt, arg...) \
>>           do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>>   
>> +extern void *kimage_map_segment(struct kimage *image,
>> +					unsigned long addr, unsigned long size);
> scripts/Checkpatch.pl complains about the parenthesis alignment here and elsewhere.
>
> Mimi
>
>> +extern void kimage_unmap_segment(void *buffer);
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> @@ -474,6 +477,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
>>   static inline void crash_kexec(struct pt_regs *regs) { }
>>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>>   static inline int kexec_crash_loaded(void) { return 0; }
>> +static inline void *kimage_map_segment(struct kimage *image,
>> +					unsigned long addr, unsigned long size)
>> +{ return NULL; }
>> +static inline void kimage_unmap_segment(void *buffer) { }
>>   #define kexec_in_progress false
>>   #endif /* CONFIG_KEXEC_CORE */
>>   

Thanks, Mimi, I will update in next version


