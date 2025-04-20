Return-Path: <linux-integrity+bounces-5944-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AAAA947D9
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 14:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693C6166075
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC513212A;
	Sun, 20 Apr 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kb3eOdx8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4713B2B8;
	Sun, 20 Apr 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745151764; cv=none; b=VrKgpSamLovHtO1XBxSfZ++G2umYzUdfqIeeT8TKg47BvyVDo33oq/WNEqR+neOQWQ7dXKNF4q8SVMsna+6Zx2K6IWkT2secqnvw0BXg1txlPQp+jkFY4/fSPVpZai5QRrguVZ5cx56ZRvXHIVHQIZuiJ1aDLYBBP6Pk8XCYf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745151764; c=relaxed/simple;
	bh=zNO7WjI67PM3EKtK/fGigTp31xUFddCofChy4F89Sc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrUZyEDvjpTzmnDeEXlHRYl+zWmwKpzCuoBJtI00MatN6Phga/Xvq6HO3DggEBe52hi4dTZd2vtrjdE/oios2UoGzHDbJZUTYCLC6WBovDuMZT2p2g0BWw22G346cQPtY0+iWWiOU2e44EtLfLc83sGIS+6ymHwKJneNpg33/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kb3eOdx8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.26] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4EBFE2052525;
	Sun, 20 Apr 2025 05:22:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EBFE2052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745151761;
	bh=WQo1K7jBqRM0/YSTh5Kpb9laSfyeR7CrBVY2PHjuCa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kb3eOdx8xQ2uisK3Lz9kgD6W3pDByJU+lqW3SnM9Xy5vxC9F6xUVhqXyrMi2F9PNn
	 LqAaTTgPYTajJcRZDi19310HruH6Vipo2iGb7AQqJxDYZpge5a3EfgF8if0XWo3bly
	 eq8OW5YPzH158DdY++ZeL0ZxWXg2HARsMBxrR3GQ=
Message-ID: <776f8f9d-afa1-4d01-b189-6c55089cfad6@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:22:37 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/9] ima: define and call ima_alloc_kexec_file_buf()
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
 <20250416021028.1403-3-chenste@linux.microsoft.com>
 <aAHWFjfQgDBq84lH@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAHWFjfQgDBq84lH@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/2025 9:33 PM, Baoquan He wrote:
> Hi Steven,
>
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> In the current implementation, the ima_dump_measurement_list() API is
>> called during the kexec "load" phase, where a buffer is allocated and
>> the measurement records are copied. Due to this, new events added after
>> kexec load but before kexec execute are not carried over to the new kernel
>> during kexec operation
>>
>> Carrying the IMA measurement list across kexec requires allocating a
>> buffer and copying the measurement records.  Separate allocating the
>> buffer and copying the measurement records into separate functions in
>> order to allocate the buffer at kexec 'load' and copy the measurements
>> at kexec 'execute'.
> Seems you didn't add note in this patch log to mention that the IMA
> measurement list fails to verify when doing two consecuritv "kexec -s -l"
> with/without a "kexec -s -u" in between. When people do bisecting and
> come to this patch, she/he will see the failure even though it's not a
> fatal blocker.
>
> ====
> After moving the vfree() here at this stage in the patch set, the IMA
> measurement list fails to verify when doing two consecutive "kexec -s -l"
> with/without a "kexec -s -u" in between.  Only after "ima: kexec: move IMA log
> copy from kexec load to execute" the IMA measurement list verifies properly with
> the vfree() here.
> ====
>
Hi Baoquan,

Thanks for your comments. I will add this in next version.

Steven

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 650beb74346c..b12ac3619b8f 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,26 +15,46 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +static struct seq_file ima_kexec_file;
>> +
>> +static void ima_free_kexec_file_buf(struct seq_file *sf)
>> +{
>> +	vfree(sf->buf);
>> +	sf->buf = NULL;
>> +	sf->size = 0;
>> +	sf->read_pos = 0;
>> +	sf->count = 0;
>> +}
>> +
>> +static int ima_alloc_kexec_file_buf(size_t segment_size)
>> +{
>> +	ima_free_kexec_file_buf(&ima_kexec_file);
>> +
>> +	/* segment size can't change between kexec load and execute */
>> +	ima_kexec_file.buf = vmalloc(segment_size);
>> +	if (!ima_kexec_file.buf)
>> +		return -ENOMEM;
>> +
>> +	ima_kexec_file.size = segment_size;
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>> +
>> +	return 0;
>> +}
>> +
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
>>   {
>> -	struct seq_file ima_kexec_file;
>>   	struct ima_queue_entry *qe;
>>   	struct ima_kexec_hdr khdr;
>>   	int ret = 0;
>>   
>>   	/* segment size can't change between kexec load and execute */
>> -	ima_kexec_file.buf = vmalloc(segment_size);
>>   	if (!ima_kexec_file.buf) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> +		pr_err("Kexec file buf not allocated\n");
>> +		return -EINVAL;
>>   	}
>>   
>> -	ima_kexec_file.file = NULL;
>> -	ima_kexec_file.size = segment_size;
>> -	ima_kexec_file.read_pos = 0;
>> -	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>> -
>>   	memset(&khdr, 0, sizeof(khdr));
>>   	khdr.version = 1;
>>   	/* This is an append-only list, no need to hold the RCU read lock */
>> @@ -71,8 +91,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   	*buffer_size = ima_kexec_file.count;
>>   	*buffer = ima_kexec_file.buf;
>>   out:
>> -	if (ret == -EINVAL)
>> -		vfree(ima_kexec_file.buf);
>>   	return ret;
>>   }
>>   
>> @@ -111,6 +129,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   		return;
>>   	}
>>   
>> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
>> +	if (ret < 0) {
>> +		pr_err("Not enough memory for the kexec measurement buffer.\n");
>> +		return;
>> +	}
>> +
>>   	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>>   				  kexec_segment_size);
>>   	if (!kexec_buffer) {
>> -- 
>> 2.43.0
>>


