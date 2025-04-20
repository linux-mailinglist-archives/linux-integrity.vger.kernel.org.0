Return-Path: <linux-integrity+bounces-5947-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81813A947E5
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D871892B6F
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA96EB7C;
	Sun, 20 Apr 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bXWMcxxe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D183288CC;
	Sun, 20 Apr 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745152397; cv=none; b=G/ws4gju+xVaI2D2qjfn0yVsChE+dqVSffqG5yLxAOM5vnpOsZtVhE0N8/0cccsjWInP0/ow3vK9B0mlM5c1SCzVdlbCqmfItEUvKBY1u8eQuIPluHvwntKADzA4VL+ApvDby47PkZExaW6/nC4hsS7euM2COfucSsNwVGMMn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745152397; c=relaxed/simple;
	bh=QCMs88tF/w+2GynbSwK5b75+viaCr7sRkqq58kGoZkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIbV6D0jhfXXK/KL57bIW0tb3Kuj+k2INgID1NU/mh5Lx8ffBgwOCFmjhxKm5grhaJMEGKgHgWRcljyiFZnrxa54ABGqvubQaK4Xdrzjh+ZJEZ07Tk9M3hnzHO+9gpT9hbceITvoPqR/q2cXTte/k52kMt9Qx60dWJGZOy3PnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bXWMcxxe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.26] (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 077892052525;
	Sun, 20 Apr 2025 05:33:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 077892052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745152395;
	bh=np2gxTjaHDpb1rtQXoHJcdS3uyHNDSp77IUqwm4GRBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bXWMcxxeSTBTuvhzky/PK/kzwiTKenzUefcYBTl40OvexVFJ34QfeeXJWhmErVzrF
	 URG/kDn+nEc6SjsPehefverHc4IrfRRLD2gNlmV4/h/SUvvAdBbn0719UhQfx3nAcG
	 rREeBW6sTr2HEXjlNli8RsW0B+svH1w1pJuv4+Do=
Message-ID: <6a4ecd66-4249-476c-87fa-b5a3806fae5e@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:33:10 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-6-chenste@linux.microsoft.com>
 <aAIB9ga3wPWb5sC8@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAIB9ga3wPWb5sC8@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/2025 12:40 AM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The IMA log is currently copied to the new kernel during kexec 'load'
>> using ima_dump_measurement_list(). However, the log copied at kexec
>> 'load' may result in loss of IMA measurements that only occurred after
>> kexec "load'. Setup the needed infrastructure to move the IMA log copy
>> from kexec 'load' to 'execute'.
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
>> IMA log copy operation will happen at the end of the operation chain, so
>> that all the IMA measurement records extended into the TPM are copied
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^
>
>   The tag
Hi Baoquan,

I will add Co-developed-by tag in next version.

Thanks,

Steven
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   include/linux/ima.h                |  3 ++
>>   security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
> Other than the tag, this looks good to me:
>
> Acked-by: Baoquan He <bhe@redhat.com>
>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 0bae61a15b60..8e29cb4e6a01 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>>   extern void ima_add_kexec_buffer(struct kimage *image);
>> +extern void ima_kexec_post_load(struct kimage *image);
>> +#else
>> +static inline void ima_kexec_post_load(struct kimage *image) {}
>>   #endif
>>   
>>   #else
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 7e0a19c3483f..e79f6caf895b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -12,10 +12,14 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of.h>
>>   #include <linux/ima.h>
>> +#include <linux/reboot.h>
>> +#include <asm/page.h>
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +static bool ima_kexec_update_registered;
>>   static struct seq_file ima_kexec_file;
>> +static void *ima_kexec_buffer;
>>   
>>   static void ima_free_kexec_file_buf(struct seq_file *sf)
>>   {
>> @@ -162,6 +166,49 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>>   		      kbuf.mem);
>>   }
>> +
>> +/*
>> + * Called during kexec execute so that IMA can update the measurement list.
>> + */
>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>> +				   unsigned long action, void *data)
>> +{
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block update_buffer_nb = {
>> +	.notifier_call = ima_update_kexec_buffer,
>> +	.priority = INT_MIN
>> +};
>> +
>> +/*
>> + * Create a mapping for the source pages that contain the IMA buffer
>> + * so we can update it later.
>> + */
>> +void ima_kexec_post_load(struct kimage *image)
>> +{
>> +	if (ima_kexec_buffer) {
>> +		kimage_unmap_segment(ima_kexec_buffer);
>> +		ima_kexec_buffer = NULL;
>> +	}
>> +
>> +	if (!image->ima_buffer_addr)
>> +		return;
>> +
>> +	ima_kexec_buffer = kimage_map_segment(image,
>> +					      image->ima_buffer_addr,
>> +					      image->ima_buffer_size);
>> +	if (!ima_kexec_buffer) {
>> +		pr_err("Could not map measurements buffer.\n");
>> +		return;
>> +	}
>> +
>> +	if (!ima_kexec_update_registered) {
>> +		register_reboot_notifier(&update_buffer_nb);
>> +		ima_kexec_update_registered = true;
>> +	}
>> +}
>> +
>>   #endif /* IMA_KEXEC */
>>   
>>   /*
>> -- 
>> 2.43.0
>>


