Return-Path: <linux-integrity+bounces-4398-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D29F39E2
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A394216CEE9
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBA208977;
	Mon, 16 Dec 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPfp+f9Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D22207DF4;
	Mon, 16 Dec 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377388; cv=none; b=h8h4BL/mGBlYgRqYj6BplM807PG+xayQxr/0YrKPzQwu8KCmP1kLtuLsVNBV31MvVro+lQHyQZDo+CoKs844upJUzkI3VvCjvA7rZKGsbfX+cqixnAgc9i1SWhaAm9LTXYom77xfGzKvHsdbMJ7PZlwmVVvES/G8J+b6XBEUHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377388; c=relaxed/simple;
	bh=h8qaNQWxciY7ClWqxrYiTTUhLaN4zKXcwmLTSM1HB+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMrXz1hQGqsBrhtpu+QAJbdQXCgLlxbqU9KyqTmArOstKUicjAY8jKH81W0WL7RcvseCw0Hdi1LkCN/8OI/8Jb0+pPIzJNAiT9E3DSzWkeJiau5WfC/KySEWJ44yxfLvJOcmw3dmYkoIMObgD88R4BGNvQs3jw89/v3RGZ+sf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPfp+f9Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGE6Gnj011286;
	Mon, 16 Dec 2024 19:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2P8mFH
	wtitOPgTFCgxP0Y05pnjWJpATlTugFnwYeEEc=; b=EPfp+f9ZMh71Wbs77f5ZmH
	vC1IC/9xyyvDD90uBsgZUQIQX0uhP25WaHw+z4PvzRdN4/k+0UC2YlSVTbJteYU0
	w9FnXokEgmRg9WpFb3/Y6/8n/XzOlc05bRXJcTo5swtL1HSIxXsBq2/kuLPwKMkw
	CX+dhiNKbpOG1wvLp025t87JipZi2nbv92OcFiw/+Qyya8QfRQ2iFY2wq0Kayhuo
	6ISUmmHhpeA65Zi5bA3KBY3y9bw1q9mzIk662dVE/Pnk9e2qF6l593Ooszsg2mrQ
	+oxQdO0mPtdiYwp5LpQKygDWqAyXKKhfoBpZCLoa0pWZkN+Gji3L9+s/51YrSkaw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jnp4hn10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 19:29:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGH50w2014320;
	Mon, 16 Dec 2024 19:29:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxyjus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 19:29:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGJTYWs53084488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 19:29:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3042358052;
	Mon, 16 Dec 2024 19:29:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA21C5805D;
	Mon, 16 Dec 2024 19:29:33 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 19:29:33 +0000 (GMT)
Message-ID: <709d3abb-d94d-44fc-a730-054139b13188@linux.ibm.com>
Date: Mon, 16 Dec 2024 14:29:33 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm/eventlog: Limit memory allocations for event logs
 with excessive size
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andy Liang <andy.liang@hpe.com>,
        Takashi Iwai <tiwai@suse.de>
References: <20241210222608.598424-1-stefanb@linux.ibm.com>
 <D6B49LBSZXN4.3V519030X0YCG@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D6B49LBSZXN4.3V519030X0YCG@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DizIJ6cD1g-wiCUpkM5zi-ZKM6_Ey2KI
X-Proofpoint-ORIG-GUID: DizIJ6cD1g-wiCUpkM5zi-ZKM6_Ey2KI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160161



On 12/13/24 10:51 PM, Jarkko Sakkinen wrote:
> On Wed Dec 11, 2024 at 12:26 AM EET, Stefan Berger wrote:
>> The TPM2 ACPI BIOS eventlog of a particular machine indicates that the
>> length of the log is 4MB, even though the actual length of its useful data,
>> when dumped, are only 69kb. To avoid allocating excessive amounts of memory
>> for the event log, limit the size of any eventlog to 128kb. This should be
>> sufficient memory and also not unnecessarily truncate event logs on any
>> other machine.
>>
>> Reported-by: Andy Liang <andy.liang@hpe.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   drivers/char/tpm/eventlog/acpi.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
>> index 69533d0bfb51..701fd7d4cc28 100644
>> --- a/drivers/char/tpm/eventlog/acpi.c
>> +++ b/drivers/char/tpm/eventlog/acpi.c
>> @@ -26,6 +26,8 @@
>>   #include "../tpm.h"
>>   #include "common.h"
>>   
>> +#define MAX_TPM_LOG_LEN		(128 * 1024)
> 
> Instead, to common.h:
> 
> /*
>   * Cap the log size to the given number of bytes. Applied to the TPM2
>   * ACPI logs.
>   */
> #define TPM_MAX_LOG_SIZE (128 * 1024)

Done.

> 
>>
>> +
>>   struct acpi_tcpa {
>>   	struct acpi_table_header hdr;
>>   	u16 platform_class;
>> @@ -135,6 +137,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>>   		return -EIO;
>>   	}
>>   
>> +	if (len > MAX_TPM_LOG_LEN) {
>> +		dev_warn(&chip->dev, "Excessive TCPA log len %llu truncated to %u bytes\n",
>> +			 len, MAX_TPM_LOG_LEN);
>> +		len = MAX_TPM_LOG_LEN;
>> +	}
> 
> First, you are changing also TPM1 code path. Also in the case of

Ok, let's move it into the TPM2 code path then.

> TPM2 code path the log message is incorrect as TCPA does not exist.
> 
> Second, this does not make sense as the log ends up to be corrupted
> (i.e. not complete).

Truncating the log is something I am trying to prevent by giving it a 
generous size of 128 kb:
"To avoid allocating excessive amounts of memory
for the event log, limit the size of any eventlog to 128kb. This should be
sufficient memory and also not unnecessarily truncate event logs on any
other machine."

The 8MB the machine with the faulty BIOS indicates are holding 69kb of 
log data at the beginning and then unnecessary data after that. So 
truncating this one to 128kb doesn't affect the 69kb at the beginning.

> 
> Instead, in the TPM2 code path:
> 
> 		start = tpm2_phy->log_area_start_address;
> 		if (!start || !len) {
> 			acpi_put_table((struct acpi_table_header *)tbl);
> 			return -ENODEV;
> 		}
> 
> 		if (len > TPM_MAX_LOG_SIZE) {
> 			dev_warn(&chip->dev, "Excessive TPM2 log size of %llu bytes (> %u)\n",
> 				 len, MAX_TPM_LOG_LEN);
> 			log->bios_event_log = start;
> 			chip->flags |= TPM_CHIP_FLAG_TPM2_ACPI;
> 			return 0;
> 		}
> 
> This can then be used in tpm2.c to create a "slow path" in tpm2.c for
> parsing TPM2 ACPI log directly by mapping IO memory.

I thought the problem when getting request for 8MB is the code a bit 
further below from here that cannot allocated the 8MB.

  	/* malloc EventLog space */
  	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
  	if (!log->bios_event_log)





> 
> BR, Jarkko


