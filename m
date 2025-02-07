Return-Path: <linux-integrity+bounces-4753-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B8A2CC79
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 20:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C43AABDE
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549419D072;
	Fri,  7 Feb 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SecTTOrV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BE19C54C;
	Fri,  7 Feb 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956223; cv=none; b=fCsbzS6Ouvbm//URY913vqiFiY2W4jSCr9GIkJHXMQPzWbI6T2ig+U5U6PLIHG0gic4NyA8+JBsHQVUKw3eeVyff9YZ5RDVIcsWlgEoxpbTO64S54sboIKZwTKBZ0djWnnP17PJz5TDtfRJpHQIAatZMeWp5NA6ULy1vuFeuRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956223; c=relaxed/simple;
	bh=8MbEJHUAnmFkC4AXfklUkLaQ7QSVqyMXCuTljOpWDkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IentTRrXRTTfFkqOu7ln2v0uQimknu4i+AlCDaTFRwjtFGhYFrKqHiSM2FDhhLeqMsa6cH2C5OYnTrcOwNR6L9ROXt5QNPeLfiQWaoH/FK+L+Bb1641iL5l0m4OPlYjh47KGpKuvh8+kPZV2PT2wOS6+80oRjGHwNSMH74kQiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SecTTOrV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id E824C2107306;
	Fri,  7 Feb 2025 11:23:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E824C2107306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956221;
	bh=EoLJ5bDNcw7tjbOauCSXGT8dabn5ExzMhG8BNOChz24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SecTTOrVqBTCGw1QtsfbKYSD8/AKM3u4XWP9VnYyhnpNG2jq8PnFZ05QgzdGccqpv
	 dBn2vSJyxccAuqWT+pCEBT4JRo5B7YiQ+f6KHckUL0StzoAhdounj//tkI+iSDZ2t2
	 HmtpqiRdXARRKV5yAYk5GqVKe/kFGkdjo+bcU8ag=
Message-ID: <ba702678-e1a3-49b5-9c5e-76329e83c812@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:23:40 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-2-chenste@linux.microsoft.com>
 <1a7e9cf84715386b7ac3dc2103fd38ba180dd216.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <1a7e9cf84715386b7ac3dc2103fd38ba180dd216.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/7/2025 11:10 AM, Mimi Zohar wrote:
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>> Carrying the IMA measurement list across kexec requires allocating a
>> buffer and copying the measurement records.  Separate allocating the
>> buffer and copying the measurement records into separate functions in
>> order to allocate the buffer at kexec 'load' and copy the measurements
>> at kexec 'execute'.
>>
>> This patch includes the following changes:
>>   - Refactor ima_dump_measurement_list() to move the memory allocation
>>     to a separate function ima_alloc_kexec_file_buf() which allocates
>>     buffer of size 'kexec_segment_size' at kexec 'load'.
>>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>>     a local static to the file, so that it can be accessed from
>>     ima_alloc_kexec_file_buf(). Compare actual memory required to ensure
>>     there is enough memory for the entire measurement record.
>>   - Copy as many measurement events as possible.
>>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>>     the above two functions.
>>   - Compared the memory size allocated with memory size of the entire
>>     measurement record. If there is not enough memory, it will copy as many
>>     IMA measurement records as possible, and this situation will result
>>     in a failure of remote attestation.
>>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |   1 +
>>   security/integrity/ima/ima_kexec.c | 105 +++++++++++++++++++++--------
>>   security/integrity/ima/ima_queue.c |   4 +-
>>   3 files changed, 80 insertions(+), 30 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 3c323ca213d4..447a6eb07c2d 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_template_desc
>> *ima_template);
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>>   int ima_measurements_show(struct seq_file *m, void *v);
>> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
>>   unsigned long ima_get_binary_runtime_size(void);
>>   int ima_init_template(void);
>>   void ima_init_template_list(void);
>> diff --git a/security/integrity/ima/ima_kexec.c
>> b/security/integrity/ima/ima_kexec.c
>> index 52e00332defe..b60a902460e2 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -15,62 +15,99 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +static struct seq_file ima_kexec_file;
>> +
>> +static void ima_reset_kexec_file(struct seq_file *sf)
>> +{
>> +	sf->buf = NULL;
>> +	sf->size = 0;
>> +	sf->read_pos = 0;
>> +	sf->count = 0;
>> +}
>> +
>> +static void ima_free_kexec_file_buf(struct seq_file *sf)
>> +{
>> +	vfree(sf->buf);
>> +	ima_reset_kexec_file(sf);
>> +}
>> +
>> +static int ima_alloc_kexec_file_buf(size_t segment_size)
>> +{
>> +	/*
>> +	 * kexec 'load' may be called multiple times.
>> +	 * Free and realloc the buffer only if the segment_size is
>> +	 * changed from the previous kexec 'load' call.
>> +	 */
>> +	if (ima_kexec_file.buf &&
>> +		(ima_kexec_file.size == segment_size)) {
>> +		goto out;
>> +	}
> Nice cleanup from v5.  The line doesn't doesn't need to be split.  Both the
> parenthesis and the brackets can be removed.
>
> In the future, before posting patches, please use scripts/checkpatch.pl.
>
> CHECK: Unnecessary parentheses around 'ima_kexec_file.size == segment_size'
> #82: FILE: security/integrity/ima/ima_kexec.c:41:
> +	if (ima_kexec_file.buf &&
> +		(ima_kexec_file.size == segment_size)) {
>
> CHECK: Alignment should match open parenthesis
> #83: FILE: security/integrity/ima/ima_kexec.c:42:
> +	if (ima_kexec_file.buf &&
> +		(ima_kexec_file.size == segment_size)) {
>
> Or simply join the two lines.
>
> thanks,
>
> Mimi
>
>> +
>> +	ima_free_kexec_file_buf(&ima_kexec_file);
>> +
>> +	/* segment size can't change between kexec load and execute */
>> +	ima_kexec_file.buf = vmalloc(segment_size);
>> +	if (!ima_kexec_file.buf)
>> +		return -ENOMEM;
>> +
>> +	ima_kexec_file.size = segment_size;
>> +
>> +out:
>> +	ima_kexec_file.read_pos = 0;
>> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space
>> */
>> +
>> +	return 0;
>> +}
>>
Thanks, Mimi, will update in the next release


