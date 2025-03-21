Return-Path: <linux-integrity+bounces-5358-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722DAA6BF87
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E883717146E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6222D4DA;
	Fri, 21 Mar 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VXCPZao7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9376B226D1B;
	Fri, 21 Mar 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573812; cv=none; b=f6q3JeHioCwQ7yHW6WuASZRMF1ngTCr+/PT9+gVIh+AGjHMSiCqZkljjw0JeJiN6Iuy69uYD2VLaLkQ6zqCdojKOkUgP4ECcmBo4e9Sxu+XrPhpOwM8dPppj48pREycdsds3wPx3EICvQnceeIvVnOun8MEkrM6tyWAuqSAvLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573812; c=relaxed/simple;
	bh=g4njPH8ooH1e2h/tZs1yCYEpzY85WHP+MRJtcNkh5oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6oN5p7QGpjmbUrEg/vns1G5b8Pwfjims65uYr9qmplZMkHH+AcY5YXbBRlLpSq9qhD41SrHvAJD+pvskBLr0rX/0nApqe7WXNNH+pSYR0kOGU7q92pOPSp+1CWO66xlT9tKXCnNz27GlOqUl6uS08kM2SNDepfu2YgBxm4UIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VXCPZao7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 07F52202537E;
	Fri, 21 Mar 2025 09:16:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07F52202537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742573810;
	bh=R1nD5dBAblQuNZ9vwCHQrc+0rDQkVy0Dn4/k8PPkSg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VXCPZao7zvdMcq+p5QAf2NTnAQSKSj1jGH57/DoHd8DBvMhknS0QK93UGTaai0LcJ
	 gys+d3sy6s/OMLq5IyV3YRm6PUSXyyeeTu0RQrqLHpbWu8E9OkcSkYhU7KG0sw7Vwg
	 NZ7ofHMq8wQCv3++xbQjEadUjMVD4S4tGyUHt/7s=
Message-ID: <4340a887-f0d1-481f-b47f-cd0226adf869@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:16:50 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
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
 <20250318010448.954-2-chenste@linux.microsoft.com>
 <255e75954d9418e2658a6eba6879804c31b3713f.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <255e75954d9418e2658a6eba6879804c31b3713f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/2025 6:42 AM, Mimi Zohar wrote:
> Fix spelling: set_file
>
>
> On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
>> The name of the local variable "file" of type seq_file defined in the
>> ima_dump_measurement_list function is too generic. To better reflect the
>> purpose of the variable, rename it to "ima_kexec_file". This change will
>> help improve code readability and maintainability by making the variable's
>> role more explicit.
> The reason for making the variable name change is the variable scope.
>
> -> Before making the function local seq_file "file" variable global, rename it
> to ima_kexec_file.
>
>> The variable ima_kexec_file is indeed the memory allocated for copying IMA
>> measurement records. The ima_dump_measurement_list function calculates the
>> actual memory occupied by the IMA logs and compares it with the allocated
>> memory. If there is enough memory, it copies all IMA measurement records;
>> otherwise, it does not copy any records, which would result in a failure
>> of remote attestation.
> This paragraph is not applicable to the patch change.
>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
>>   1 file changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 9d45f4d26f73..8567619889d1 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,33 +15,41 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +/*
>> + * Copy the measurement list to the allocated memory
>> + * compare the size of IMA measurement list with the size of the allocated memory
>> + *    if the size of the allocated memory is not less than the size of IMA measurement list
>> + *        copy the measurement list to the allocated memory.
>> + *    else
>> + *        return error
>> + */
> Please minimize patch changes.  Before posting, please look at the patch(s) and
> remove anything not applicable to it.  In this case, the comment is not
> applicable to the variable name change.
>
> thanks,
>
> Mimi
>    
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
>>   {
>> +	struct seq_file ima_kexec_file;
>>   	struct ima_queue_entry *qe;
>> -	struct seq_file file;
>>   	struct ima_kexec_hdr khdr;
>>   	int ret = 0;
>>   
>>   	/* segment size can't change between kexec load and execute */
>> -	file.buf = vmalloc(segment_size);
>> -	if (!file.buf) {
>> +	ima_kexec_file.buf = vmalloc(segment_size);
>> +	if (!ima_kexec_file.buf) {
>>   		ret = -ENOMEM;
>>   		goto out;
>>   	}
>>   
>> -	file.file = NULL;
>> -	file.size = segment_size;
>> -	file.read_pos = 0;
>> -	file.count = sizeof(khdr);	/* reserved space */
>> +	ima_kexec_file.file = NULL;
>> +	ima_kexec_file.size = segment_size;
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>>   
>>   	memset(&khdr, 0, sizeof(khdr));
>>   	khdr.version = 1;
>>   	/* This is an append-only list, no need to hold the RCU read lock */
>>   	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
>> -		if (file.count < file.size) {
>> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>>   			khdr.count++;
>> -			ima_measurements_show(&file, qe);
>> +			ima_measurements_show(&ima_kexec_file, qe);
>>   		} else {
>>   			ret = -EINVAL;
>>   			break;
>> @@ -55,23 +63,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   	 * fill in reserved space with some buffer details
>>   	 * (eg. version, buffer size, number of measurements)
>>   	 */
>> -	khdr.buffer_size = file.count;
>> +	khdr.buffer_size = ima_kexec_file.count;
>>   	if (ima_canonical_fmt) {
>>   		khdr.version = cpu_to_le16(khdr.version);
>>   		khdr.count = cpu_to_le64(khdr.count);
>>   		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>>   	}
>> -	memcpy(file.buf, &khdr, sizeof(khdr));
>> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>>   
>>   	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
>> -			     file.buf, file.count < 100 ? file.count : 100,
>> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
>> +			     ima_kexec_file.count : 100,
>>   			     true);
>>   
>> -	*buffer_size = file.count;
>> -	*buffer = file.buf;
>> +	*buffer_size = ima_kexec_file.count;
>> +	*buffer = ima_kexec_file.buf;
>>   out:
>>   	if (ret == -EINVAL)
>> -		vfree(file.buf);
>> +		vfree(ima_kexec_file.buf);
>>   	return ret;
>>   }
>>   

Hi Mimi,

I will update in next version.

Thanks,

Steven


