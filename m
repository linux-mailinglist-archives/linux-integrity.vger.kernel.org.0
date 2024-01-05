Return-Path: <linux-integrity+bounces-673-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA5825B87
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 21:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F91F2414C
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409A3608F;
	Fri,  5 Jan 2024 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tQNowT04"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87A3608A
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jan 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0968720B3CC1;
	Fri,  5 Jan 2024 12:22:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0968720B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704486166;
	bh=uupHtXOGbKP6pvAq6/w2tyZfb+L+q+LE1ch/I/GE/70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tQNowT04HbArObQ3peUEUEOKkDMc0s3FoxoKxS4ISkevJRH0Iy+UhqczHEg+RfWSY
	 rUSRqmCd/ti7qFEeDLK9pELS6EKrp/EqMQm+C18n+dXKaRgciJu947U4BgdujhK2Cx
	 4qU4falIoGAnqnn5VglN4W+umn7ldrqbz0pkLxMs=
Message-ID: <db16303d-44b7-45d2-b844-cf4d7fe89647@linux.microsoft.com>
Date: Fri, 5 Jan 2024 12:22:45 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
 <0c98853722d57472d451e7838d4b1176665de1c0.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <0c98853722d57472d451e7838d4b1176665de1c0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/20/23 12:41, Mimi Zohar wrote:
> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> There could be a potential mismatch between IMA measurements and TPM PCR
>> quotes caused by the indeterminate interval between kexec 'load' and
>> 'execute'.  Memory allocated at kexec 'load' for IMA log buffer may run
>> out. It can lead to missing events in the IMA log after a soft reboot to
>> the new Kernel, resulting in TPM PCR quotes mismatch and remote
>> attestation failures.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>>
>> These events serve as markers in the IMA log to verify the IMA events are
>> captured between kexec 'load' and 'execute' window.  The presence of a
>> 'kexec_load' event in between the last two 'boot_aggregate' events in the
>> IMA log implies this is a kexec soft reboot, and not a cold-boot. And the
>> absence of 'kexec_execute' event after kexec soft reboot implies missing
>> events in that window which results in inconsistency with TPM PCR quotes,
>> necessitating a cold boot for further successful remote attestation.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 063da9c834a0..47da41a66dcc 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 128
>> +
>>   struct seq_file ima_kexec_file;
>>   static void *ima_kexec_buffer;
>>   static size_t kexec_segment_size;
>> @@ -33,6 +35,8 @@ void ima_free_kexec_file_buf(struct seq_file *sf)
>>   
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +
>>   	/*
>>   	 * kexec 'load' may be called multiple times.
>>   	 * Free and realloc the buffer only if the segment_size is
>> @@ -42,7 +46,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   	    ima_kexec_file.size == segment_size &&
>>   	    ima_kexec_file.read_pos == 0 &&
>>   	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
>> -		return 0;
>> +		goto out;
>>   
>>   	ima_free_kexec_file_buf(&ima_kexec_file);
>>   
>> @@ -55,6 +59,13 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   	ima_kexec_file.read_pos = 0;
>>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>>   
>> +out:
>> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		  "kexec_segment_size=%lu;", segment_size);
>> +
>> +	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
>> +				  strlen(ima_kexec_event), false, NULL, 0);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -179,6 +190,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   static int ima_update_kexec_buffer(struct notifier_block *self,
>>   				   unsigned long action, void *data)
>>   {
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>   	void *buf = NULL;
>>   	size_t buf_size;
>>   	bool resume = false;
>> @@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>>   		return ret;
>>   	}
>>   
>> +	buf_size = ima_get_binary_runtime_size();
>> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
>> +		  kexec_segment_size, buf_size);
>> +
>> +	ima_measure_critical_data("ima_kexec", "kexec_execute",
>> +				  ima_kexec_event, strlen(ima_kexec_event),
>> +				  false, NULL, 0);
>> +
> 
> Please consider including the number of measurement records as well.
Will do. I think that would be valuable information.

Per my understanding, I will have to use the function
ima_show_measurements_count() or ima_show_htable_value() to get the
number of measurement records value[1]. So I will have to expose that
function from "ima_fs.c" to "ima_kexec.c". Hope that's ok.

[1] 
https://elixir.bootlin.com/linux/latest/sourcesecurity/integrity/ima/ima_fs.c 


static ssize_t ima_show_measurements_count(struct file *filp,
                                          char __user *buf,
                                          size_t count, loff_t *ppos)
{
         return ima_show_htable_value(buf, count, ppos, &ima_htable.len);

}


~Tushar
> 
>>   	ima_measurements_suspend();
>>   
>>   	ret = ima_dump_measurement_list(&buf_size, &buf,
> 

