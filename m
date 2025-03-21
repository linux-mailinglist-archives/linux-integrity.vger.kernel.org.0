Return-Path: <linux-integrity+bounces-5360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC7A6BFCD
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FD218911DF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433B1D86F2;
	Fri, 21 Mar 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VLb9Rk1n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0A22A7FF;
	Fri, 21 Mar 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574045; cv=none; b=YvMRMpfKNQtuANlTbh7Hgah79giWwrJaSJT5Pd/Gn5QOIy2L0Z099NuBoSjNCcYFTarJaSvHpFqo8a3O/3gIcTq7OU5Lq9oZ0zi0GvK1L0oZqcpiXrMPHlZSfsBUYafqcF26grfzh4ixeMwB+jQWTnHvYNmnVFZUJ/TTBNrrrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574045; c=relaxed/simple;
	bh=9IPumhR8QxDcPA24Mmf7vajLJMy4eOf3y0bChtJN2Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPQUCTfjAlNUkeRe9NThPQbE5O1RcA2fwJHHv8esMwr2wnhRO32kxkSnE9oUye4frxaC/T6APF+UzKXAKfp3ZYZ3iZ7Jfj7lzg7eTz8ZBTN/J8bJ/iN0gJfjqcij3MJSCh2XMqMhFDPxuFBd+BwywZGYPiBzmm4ibOpTBNGquws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VLb9Rk1n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8ED532025381;
	Fri, 21 Mar 2025 09:20:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ED532025381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742574043;
	bh=y+z+RAKtNeuU7YlgaSgKz7JAuYHxLuoQg0CN8Edx6z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VLb9Rk1n7fKAhX+9YpXfR+LczOfpMdWDo75ei0nfDr0Y6l25ygbNcXnDLWjP+8mh8
	 nKzCrr09s5/QKOMVZH8TCTTCAjw00NgGFkMBHBsogPMsv0TZHm5WeEzq/B8cUGDIh7
	 s9HCHEtrE+MmInNgm5P9tROnLbpEdiHtLI9JafdE=
Message-ID: <922470b6-7223-400f-aae1-66b2215e5e41@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:20:44 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <b3491376fc2137f930755a3ab5591ac0982a9540.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <b3491376fc2137f930755a3ab5591ac0982a9540.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/2025 1:53 PM, Mimi Zohar wrote:
> On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
>> ima_dump_measurement_list() is called during kexec 'load', which may
>> result in loss of IMA measurements during kexec soft reboot. Due to
>> missed measurements that only occurred after kexec 'load', this function
>> needs to be called during kexec 'execute'.
> -> , defer calling ima_dump_measurement_list() to kexec 'execute'.
>
>> This patch includes the following changes:
>>   - Implement kimage_file_post_load() function to be invoked after the new
>>     kernel image has been loaded for kexec.
>>   - Call kimage_file_post_load() from kexec_file_load() syscall only for
>>     kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
>>     map the IMA segment, and register reboot notifier for the function
>>     ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>>     reboot.
>>   - Make kexec_segment_size variable local static to the file so that it
>>     becomes accessible both during kexec 'load' and 'execute'.
>>   - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>>     to ima_update_kexec_buffer().
>>   - Copy the measurement list as much as possible.
> Let's summarize the above changes, as below, and then remove the list.
>
> Define and call the new kimage_file_post_load() to call ima_kexec_post_load(),
> which registers the reboot notifier (ima_update_kexec_buffer).
>
> Finally, move ima_dump_measurement_list() from ima_add_kexec_buffer()
> to ima_update_kexec_buffer() to defer copying the measurement list.
>
>>   - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>>     that the buffer is being copied at kexec 'execute', and resetting the
>>     file at kexec 'load' would corrupt the buffer.
> Instead of adding and then removing the ima_reset_kexec_file() call from
> ima_add_kexec_buffer(), defer adding the test in ima_alloc_kexec_file_buf() to
> see if the segment size has changed.  That should be a subsequent patch, after
> this one.
>
> ima_reset_kexec_file() is then ever called from only one place.  Combine
> ima_reset_kexec_file() with ima_free_kexec_file_buf().
>
> thanks,
>
> Mimi

Hi Mimi,

I will update the patchset in next version.

Thanks,

Steven

>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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
>> +
>>   	ret = machine_kexec_post_load(image);
>>   	if (ret)
>>   		goto out;
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 9336c4f60650..c390c745f882 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -19,6 +19,7 @@
>>   #ifdef CONFIG_IMA_KEXEC
>>   static bool ima_kexec_update_registered;
>>   static struct seq_file ima_kexec_file;
>> +static size_t kexec_segment_size;
>>   static void *ima_kexec_buffer;
>>   
>>   static void ima_reset_kexec_file(struct seq_file *sf)
>> @@ -67,7 +68,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>    *    if the size of the allocated memory is not less than the size of IMA measurement list
>>    *        copy the measurement list to the allocated memory.
>>    *    else
>> - *        return error
>> + *        copy the measurement list as much as possible.
>>    */
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
>> @@ -95,9 +96,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   		}
>>   	}
>>   
>> -	if (ret < 0)
>> -		goto out;
>> -
>>   	/*
>>   	 * fill in reserved space with some buffer details
>>   	 * (eg. version, buffer size, number of measurements)
>> @@ -117,7 +115,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   
>>   	*buffer_size = ima_kexec_file.count;
>>   	*buffer = ima_kexec_file.buf;
>> -out:
>> +
>>   	return ret;
>>   }
>>   
>> @@ -135,9 +133,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	unsigned long binary_runtime_size;
>>   
>>   	/* use more understandable variable names than defined in kbuf */
>> +	size_t kexec_buffer_size = 0;
>>   	void *kexec_buffer = NULL;
>> -	size_t kexec_buffer_size;
>> -	size_t kexec_segment_size;
>>   	int ret;
>>   
>>   	/*
>> @@ -162,13 +159,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   		return;
>>   	}
>>   
>> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>> -				  kexec_segment_size);
>> -	if (!kexec_buffer) {
>> -		pr_err("Not enough memory for the kexec measurement buffer.\n");
>> -		return;
>> -	}
>> -
>>   	kbuf.buffer = kexec_buffer;
>>   	kbuf.bufsz = kexec_buffer_size;
>>   	kbuf.memsz = kexec_segment_size;
>> @@ -186,12 +176,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	image->ima_segment_index = image->nr_segments - 1;
>>   	image->is_ima_segment_index_set = true;
>>   
>> -	/*
>> -	 * kexec owns kexec_buffer after kexec_add_buffer() is called
>> -	 * and it will vfree() that buffer.
>> -	 */
>> -	ima_reset_kexec_file(&ima_kexec_file);
>> -
>>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>>   		      kbuf.mem);
>>   }
>> @@ -202,7 +186,32 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   static int ima_update_kexec_buffer(struct notifier_block *self,
>>   				   unsigned long action, void *data)
>>   {
>> -	return NOTIFY_OK;
>> +	size_t buf_size = 0;
>> +	int ret = NOTIFY_OK;
>> +	void *buf = NULL;
>> +
>> +	if (!kexec_in_progress) {
>> +		pr_info("No kexec in progress.\n");
>> +		return ret;
>> +	}
>> +
>> +	if (!ima_kexec_buffer) {
>> +		pr_err("Kexec buffer not set.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
>> +
>> +	if (ret)
>> +		pr_err("Dump measurements failed. Error:%d\n", ret);
>> +
>> +	if (buf_size != 0)
>> +		memcpy(ima_kexec_buffer, buf, buf_size);
>> +
>> +	kimage_unmap_segment(ima_kexec_buffer);
>> +	ima_kexec_buffer = NULL;
>> +
>> +	return ret;
>>   }
>>   
>>   static struct notifier_block update_buffer_nb = {



