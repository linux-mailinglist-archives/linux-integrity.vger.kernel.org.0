Return-Path: <linux-integrity+bounces-5361-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90DA6BFC7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7F516C2CA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F1226CF7;
	Fri, 21 Mar 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fHwfb+/I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8A1A238C;
	Fri, 21 Mar 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574208; cv=none; b=dN2A7csrgd+6J8xY5VIo/PtZHeYTY6WwfWdRMs1a3h+EWi87HKASoL+f9tzg6Sn8mu93UuEFH1aX4jQbVqJcxczYOQOyvddTuA4E91eEuc5Xk8npLK6kECJ5hCQu4Ep8B5p0uME/Vg1h/WdvhhnDrss8WybUBt4btNS4pcnl5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574208; c=relaxed/simple;
	bh=xA3OKFh4pwWxu3qLNV/twuwU8eHXbz9A/i7Ap0xbR58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jdei2mnDUv2DppcnxOyCTyodh8NoesOntc6QDtTAeV5l/PpaRJev4eQKayXlIFpuheRcV6BLSY5LwVfyJXEkT0PK2dfi7Fo1lhMfKFpteCdVAPAsNYEKUFomiPtU26q5rSlGnIBNFKpuBEvH9GBJs+U+xefdA+sdWaoysHaw0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fHwfb+/I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DE9D2025381;
	Fri, 21 Mar 2025 09:23:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DE9D2025381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742574206;
	bh=w60sAgvcLAWgVyv6WquYLLOQicpf5ZRmpFvyjyfnVwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHwfb+/I4DJcL3178I7/xgS79wmL4RJO6TCuOPNtrXBsqnt20gS+HlmY70drCXBK9
	 N55lDPEhKf9tFwz2tFyqK+ir/EQGbFp9Z+CMRku9V4+w7lbUOIdXiFn9daYeQRORsY
	 bwElckzWHCPbK3gRP/HyJr/E1Irv9GxEIBnXOSW4=
Message-ID: <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:23:26 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/2025 7:06 PM, Baoquan He wrote:
> On 03/17/25 at 06:04pm, steven chen wrote:
> ...snip...
>> ---
>>   kernel/kexec_file.c                | 10 ++++++
>>   security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>>   2 files changed, 40 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 606132253c79..ab449b43aaee 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>>   }
>>   #endif
>>   
>> +static void kimage_file_post_load(struct kimage *image)
>> +{
>> +#ifdef CONFIG_IMA_KEXEC
>> +	ima_kexec_post_load(image);
>> +#endif
>> +}
>> +
>>   /*
>>    * In file mode list of segments is prepared by kernel. Copy relevant
>>    * data from user space, do error checking, prepare segment list
>> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>   
>>   	kimage_terminate(image);
>>   
>> +	if (!(flags & KEXEC_FILE_ON_CRASH))
>> +		kimage_file_post_load(image);
> machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
> we should use it to do things post load, but not introducing another
> kimage_file_post_load().

Hi Baoquan,

Could you give me more detail about this?

Thanks,

Steven

>
>> +
>>   	ret = machine_kexec_post_load(image);
>>   	if (ret)
>>   		goto out;
> ...snip...



