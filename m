Return-Path: <linux-integrity+bounces-4908-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EAA3C87D
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 20:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26C91898357
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E7D22B587;
	Wed, 19 Feb 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j5kJaBRW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A722A813;
	Wed, 19 Feb 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992917; cv=none; b=O2kKj0oB8mUqdlLsgs78ATAfB8GPQOCrqnzeglXsv70Y43bwonzQAVu4K96x9HsyaZvW+WClCcg4rcl5j8soNp5fsxs5cH/bl9WIUY0na+h7K3IBJ1sOM6XvQTvHdy/mOrF6Ul40kYkc5WJFGwfMv2Q0IE1b6Xj9za+YhuTWviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992917; c=relaxed/simple;
	bh=adWKiQEJVT6/B9N5eQDBQYCGF9NVr8QvocoDPUjiRz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jr5VZBRbwoNJfuBMgu5AiIgcmfgUMeC7AKPWjpHdURpIrHObDXmEaV3vRyp3mF4XiUxYCb9IIw6Ph+p3OhkURbXca0fmPNoKBogo2RA859YgPmOOiGI48A1ODSM/OLRqP5zsf3lTC2oYTQssORAc1uMXnsHU9kY8knqhpTxvim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j5kJaBRW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.130] (unknown [131.107.147.130])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9903B2043DE8;
	Wed, 19 Feb 2025 11:21:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9903B2043DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739992914;
	bh=pu/UW7PCLv8X83zZl5RWnpubpgAZ6B+Swf12/QdxSxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j5kJaBRWrM6equjNG9/ULVyGXaOGZkWvh/d9z/GERoOxMPje1JSbf/+HpyTUSdUZ2
	 MTeGmqRCHLphVU8p/RB6vUleYWgDhv4FaXYdwfqMNqAwnlNDUjBwBrrVcdcFeAKHAH
	 5LSb12vWUDz53yAyCcC6+JpCIUSLDSoIbnoDZlSc=
Message-ID: <05eadac7-fa98-42a5-88a8-079e7c99c0b9@linux.microsoft.com>
Date: Wed, 19 Feb 2025 11:21:54 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-5-chenste@linux.microsoft.com>
 <f102607b-963a-40c6-a14f-0803f8b059cc@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <f102607b-963a-40c6-a14f-0803f8b059cc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/2025 7:37 AM, Stefan Berger wrote:
>
>
> On 2/18/25 5:54 PM, steven chen wrote:
>> IMA log is copied to the new Kernel during kexec 'load' using
>
> The IMA log is currently copied to the new kernel ...
>
>
>> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
>> loss of IMA measurements during kexec soft reboot.  It needs to be 
>> copied
>
> However, the log copied at kexec 'load' may result in loss of IMA 
> measurements due to missed measurements that only occurred after kexec 
> 'load'. Therefore, the log needs to be copied during kexec 'execute'. 
> Setup the ...
>
>> over during kexec 'execute'.  Setup the needed infrastructure to move 
>> the
>> IMA log copy from kexec 'load' to 'execute'.
>>
>> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
>> It will be used to call ima_dump_measurement_list() during kexec
>> 'execute'.
>>
>> Implement ima_kexec_post_load() function to be invoked after the new
>> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
>> IMA buffer to a segment in the newly loaded Kernel.  It also registers
>> the reboot notifier_block to trigger ima_update_kexec_buffer() at
>> exec 'execute'.
>
> kexec 'execute'
>
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>
> With the above changes:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>> ---
>>   include/linux/ima.h                |  3 ++
>>   security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 0bae61a15b60..8e29cb4e6a01 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>>     #ifdef CONFIG_IMA_KEXEC
>>   extern void ima_add_kexec_buffer(struct kimage *image);
>> +extern void ima_kexec_post_load(struct kimage *image);
>> +#else
>> +static inline void ima_kexec_post_load(struct kimage *image) {}
>>   #endif
>>     #else
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 704676fa6615..0fa65f91414b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -12,10 +12,14 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of.h>
>>   #include <linux/ima.h>
>> +#include <linux/reboot.h>
>> +#include <asm/page.h>
>>   #include "ima.h"
>>     #ifdef CONFIG_IMA_KEXEC
>>   static struct seq_file ima_kexec_file;
>> +static void *ima_kexec_buffer;
>> +static bool ima_kexec_update_registered;
>>     static void ima_reset_kexec_file(struct seq_file *sf)
>>   {
>> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       kexec_dprintk("kexec measurement buffer for the loaded kernel 
>> at 0x%lx.\n",
>>                 kbuf.mem);
>>   }
>> +
>> +/*
>> + * Called during kexec execute so that IMA can update the 
>> measurement list.
>> + */
>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>> +                   unsigned long action, void *data)
>> +{
>> +    return NOTIFY_OK;
>> +}
>> +
>> +struct notifier_block update_buffer_nb = {
>> +    .notifier_call = ima_update_kexec_buffer,
>> +};
>> +
>> +/*
>> + * Create a mapping for the source pages that contain the IMA buffer
>> + * so we can update it later.
>> + */
>> +void ima_kexec_post_load(struct kimage *image)
>> +{
>> +    if (ima_kexec_buffer) {
>> +        kimage_unmap_segment(ima_kexec_buffer);
>> +        ima_kexec_buffer = NULL;
>> +    }
>> +
>> +    if (!image->ima_buffer_addr)
>> +        return;
>> +
>> +    ima_kexec_buffer = kimage_map_segment(image,
>> +                          image->ima_buffer_addr,
>> +                          image->ima_buffer_size);
>> +    if (!ima_kexec_buffer) {
>> +        pr_err("Could not map measurements buffer.\n");
>> +        return;
>> +    }
>> +
>> +    if (!ima_kexec_update_registered) {
>> +        register_reboot_notifier(&update_buffer_nb);
>> +        ima_kexec_update_registered = true;
>> +    }
>> +}
>> +
>>   #endif /* IMA_KEXEC */
>>     /*

Hi Stefan, thanks for your comments. I will update in next version.


