Return-Path: <linux-integrity+bounces-4663-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D3CA20F99
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8872188586C
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD31422A8;
	Tue, 28 Jan 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WZPP+Hiz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83825A643;
	Tue, 28 Jan 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085443; cv=none; b=YVJUiITBs+dJFjmubyEMT5VXTGZvSYDFSewxQvxfhkA2qomBFt9/ZBLVYhzJFfa+Ng43kZZvYJkfa1h+CqQAq4Di0/jJm5weUSbDNwKv4Q4DwO26Y46VlD0zp9EHYJgcuuVqnpnCbphy+t7i7lFxXHyqkv2XQIhUx/yC2FuTdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085443; c=relaxed/simple;
	bh=DJlOu/wYcTa3+E8QxS4g7kkM8s2kD2iy234rHFtN1YU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E8zCIVeg1tNt+Al/CIj/LBJR4C+wvg1SHEu9UjQ2PYZI08KZ3lF8nQcRG0Te4nkDht4e6QwSPmJfJge04I+8QTGZxl9S37AuLXle1vJ5n1HPexJ881DDByQL4J65Dx6dg2kEmuaqcHyaXhfFEbHRtXfgb4KYt6Q4ObkfOO5pT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WZPP+Hiz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SG7JTC023574;
	Tue, 28 Jan 2025 17:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F5yGEG
	RY/xbDWlX+R8+cT5HpmGJSF0Bze6cdd2wF9iQ=; b=WZPP+HizMOp7A/iS4JRSEr
	5NSPj/knjMYKaDW4XS1J785ocOKpM5j3zvBwhMJpjAF+O20USkaZrTvW0eWGcoS6
	QljXafLpF3LNOC67AjH3K7KK48rjJKjMXmAwE6TGQe8tAwNLGhL8BhJkjbmFOxIx
	cZ/E65rUSbW39rcULMs/N3q4K3oCuXZWARjjjS7aLi4zsgpF/UB0JJ+91c5sx86a
	Y6DgKmZsDb8uCg20fX9vzFDbeaZMaTKMoRk7mZa3COuceSElRwMBL8CHWeodajKb
	D50Pv8TbBZSQ5NGJmPCrYvjBK1jxy4wJYLGRRqJGY9HFIRG0l7Ia8TA5F2E62+qQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27kb7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 17:29:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SE1mJi028042;
	Tue, 28 Jan 2025 17:29:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskcb94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 17:29:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SHTDVW21627646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 17:29:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B33858055;
	Tue, 28 Jan 2025 17:29:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 325C258043;
	Tue, 28 Jan 2025 17:29:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 17:29:12 +0000 (GMT)
Message-ID: <19cd9b56-186c-4cc9-8d84-2b3d87591714@linux.ibm.com>
Date: Tue, 28 Jan 2025 12:29:11 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ima: measure kexec load and exec events as critical
 data
From: Stefan Berger <stefanb@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz,
        eric.snowberg@oracle.com, paul@paul-moore.com, code@tyhicks.com,
        nramas@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
        madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-8-chenste@linux.microsoft.com>
 <4efc1c73-6dc9-43ed-8143-74bb270f7fe7@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <4efc1c73-6dc9-43ed-8143-74bb270f7fe7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aHGw39W7_sGA_IrgvMurnUsyrBwSZF-i
X-Proofpoint-GUID: aHGw39W7_sGA_IrgvMurnUsyrBwSZF-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280128



On 1/28/25 10:28 AM, Stefan Berger wrote:
> 
> 
> On 1/24/25 5:55 PM, steven chen wrote:
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement list.  
>> The
>> indeterminate interval between kexec 'load' and 'execute' could 
>> exacerbate
>> this problem.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ 
>> ima/ima_kexec.c
>> index c9c916f69ca7..d416ca0382cb 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 256
>> +
>>   static struct seq_file ima_kexec_file;
>>   static void *ima_kexec_buffer;
>>   static size_t kexec_segment_size;
>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file 
>> *sf)
>>       ima_reset_kexec_file(sf);
>>   }
>> +static void ima_measure_kexec_event(const char *event_name)
>> +{
>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +    size_t buf_size = 0;
>> +    long len;
>> +
>> +    buf_size = ima_get_binary_runtime_size();
>> +    len = atomic_long_read(&ima_htable.len);
>> +
>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +            "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +            "ima_runtime_measurements_count=%ld;",
>> +                kexec_segment_size, buf_size, len);
>> +
>> +    ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
>> +                    strlen(ima_kexec_event), false, NULL, 0);
>> +}
>> +
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>>       /*
>> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t 
>> segment_size)
>>   out:
>>       ima_kexec_file.read_pos = 0;
>>       ima_kexec_file.count = sizeof(struct ima_kexec_hdr);    /* 
>> reserved space */
>> +    ima_measure_kexec_event("kexec_load");
>>       return 0;
>>   }
>> @@ -206,6 +227,8 @@ static int ima_update_kexec_buffer(struct 
>> notifier_block *self,
>>       if (ret)
>>           pr_err("Dump measurements failed. Error:%d\n", ret);
>> +    else
>> +        ima_measure_kexec_event("kexec_execute");

The problem is that this here ^^^^ currently comes after this block:

         ret = ima_dump_measurement_list(&buf_size, &buf,
                                         kexec_segment_size);

         if (ret)
                 pr_err("Dump measurements failed. Error:%d\n", ret);
         else
                 ima_measure_kexec_event("kexec_execute");  <--- after 
the dump

It has to be done before so that whatever it adds to the measurement 
list gets dumped as well. So this works for my testing:

+       ima_measure_kexec_event("kexec_execute");
+
         ret = ima_dump_measurement_list(&buf_size, &buf,
                                         kexec_segment_size);

         if (ret)
                 pr_err("Dump measurements failed. Error:%d\n", ret);


>>       if (buf_size != 0)
>>           memcpy(ima_kexec_buffer, buf, buf_size);
> 
> 
> I have been doing kexec's (on ppc64 KVM) applying one patch after 
> another in this series and then testing with this command:
> 
> evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/ 
> binary_runtime_measurements
> 
> Unfortunately it breaks at this patch. I am not sure what it is due to.
> 
> 


