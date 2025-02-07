Return-Path: <linux-integrity+bounces-4747-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B912FA2CA7F
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D525B3A7A18
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086319ADA2;
	Fri,  7 Feb 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lrynlRbh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C81991B2;
	Fri,  7 Feb 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950562; cv=none; b=sfvJ2B6G1UIf/gImzdhfUIjJJzzaWH4kqeKIGGsnLjEuvM3tWI/fN4jomixKE3JTgTv762+Qr99eBE4wodJ6h/YPG2m4HrR/wezdbFRAZG+1HwYe/nIYSxCNVQd8KzY8i2z1P9RZyLkR83Y8tyZ1+D5DpqVufFM30pDmm394wL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950562; c=relaxed/simple;
	bh=jVPVyHRjrxgyQm/AnC921euASXtVzjyArNK4SSMJVUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVFo13K6r4DaHlOd0N8GKMupDVhUwRPjZ7KegNsT54r/20TYRsqHRr2VMG7oWBe657nen0Xc9/muXDfj9lWODFZFYG27p0eMBLE922gnoRiDZ1e1O30N3GVfknDDd+joFN07rPXKypZUx3GPUat4gbn1jOXBfHMXSPHLAKTFm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lrynlRbh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517FdtiN030918;
	Fri, 7 Feb 2025 17:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p0rgAV
	nGq97I5rtxVD8SA+5WhymNp91voigoE2yiu0Q=; b=lrynlRbh8DWxzwWrBPfTQP
	BGOyX33jv9CqszgCq0+CrID3MYrJADTlsh8LCjVReZ8Wjg850Dyd0wuQ9he9GnwM
	uT4CZ0RyhLLDGAC7ARK5CXi6oKWF/gH3N9JnxlBnvl1r1fHM3OB0x2KUe2PpFMTM
	MjC/aT102HjvvnlWFLQkeuck6LRf1jV9kcgA5QCmUIKKvlVRXD3EwyNVdy/8NcZl
	o9Teu2WluWJ/QcYMkNOdLoVWXvISdDTZeuxSyO+X9OLBv/L9TheVohAvDUE++lh7
	nVfWhXCFhpFsqNlf6goaIXjWCyCO1EV4MEtgib03J2x6A3Nsal3a59CLRwBa6syA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nn0tgp2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 17:48:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517G0oOm024461;
	Fri, 7 Feb 2025 17:48:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnmpxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 17:48:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517HmrvS23069312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 17:48:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B001058043;
	Fri,  7 Feb 2025 17:48:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA60858055;
	Fri,  7 Feb 2025 17:48:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 17:48:52 +0000 (GMT)
Message-ID: <8ca0bdd9-7cae-4adf-b4c0-eebf057d4c5b@linux.ibm.com>
Date: Fri, 7 Feb 2025 12:48:52 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] ima: measure kexec load and exec events as
 critical data
To: Mimi Zohar <zohar@linux.ibm.com>,
        steven chen <chenste@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-9-chenste@linux.microsoft.com>
 <3a4053664cde06622e1f9a9d8e3a5aab80b9beb7.camel@linux.ibm.com>
 <b2b3fa5d3d20284f790ce74bb97da2b9795a0e0e.camel@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <b2b3fa5d3d20284f790ce74bb97da2b9795a0e0e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WTwdbUUSl3JllWiJc8BOgTZbTaDWaax5
X-Proofpoint-ORIG-GUID: WTwdbUUSl3JllWiJc8BOgTZbTaDWaax5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070130



On 2/7/25 12:06 PM, Mimi Zohar wrote:
> On Fri, 2025-02-07 at 10:16 -0500, Mimi Zohar wrote:
>> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>>> The amount of memory allocated at kexec load, even with the extra memory
>>> allocated, might not be large enough for the entire measurement list.  The
>>> indeterminate interval between kexec 'load' and 'execute' could exacerbate
>>> this problem.
>>>
>>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>>> measured as critical data at kexec 'load' and 'execute' respectively.
>>> Report the allocated kexec segment size, IMA binary log size and the
>>> runtime measurements count as part of those events.
>>>
>>> These events, and the values reported through them, serve as markers in
>>> the IMA log to verify the IMA events are captured during kexec soft
>>> reboot.  The presence of a 'kexec_load' event in between the last two
>>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>>> after kexec soft reboot implies missing events in that window which
>>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>>> for a successful remote attestation.
>>
>> As a reminder, please include directions for verifying the buffer data hash against
>> the buffer data.  The directions would be similar to those in commit 6b4da8c0e7f
>> ("IMA: Define a new template field buf").
>>
>>>
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>> ---
>>>   security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/security/integrity/ima/ima_kexec.c
>>> b/security/integrity/ima/ima_kexec.c
>>> index c9c916f69ca7..0342ddfa9342 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -17,6 +17,8 @@
>>>   #include "ima.h"
>>>   
>>>   #ifdef CONFIG_IMA_KEXEC
>>> +#define IMA_KEXEC_EVENT_LEN 256
>>> +
>>>   static struct seq_file ima_kexec_file;
>>>   static void *ima_kexec_buffer;
>>>   static size_t kexec_segment_size;
>>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>>>   	ima_reset_kexec_file(sf);
>>>   }
>>>   
>>> +static void ima_measure_kexec_event(const char *event_name)
>>> +{
>>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>> +	size_t buf_size = 0;
>>> +	long len;
>>> +
>>> +	buf_size = ima_get_binary_runtime_size();
>>> +	len = atomic_long_read(&ima_htable.len);
>>> +
>>> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>> +			"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>>> +			"ima_runtime_measurements_count=%ld;",
>>> +				kexec_segment_size, buf_size, len);
>>
>>  From scripts/checkpatch.pl, "Alignment should match open parenthesis".
>>
>>> +
>>> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
>>> +					strlen(ima_kexec_event), false, NULL,
>>> 0);
>>
>>  From the kernel-doc scnprintf(), returns the number of bytes.  There should be no
>> need to calculate it using strlen().
>>
>>> +}
>>> +
>>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>   {
>>>   	/*
>>> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>   out:
>>>   	ima_kexec_file.read_pos = 0;
>>>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved
>>> space
>>> */
>>> +	ima_measure_kexec_event("kexec_load");
>>>   
>>>   	return 0;
>>>   }
>>> @@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct notifier_block
>>> *self,
>>>   		return ret;
>>>   	}
>>>   
>>> +	ima_measure_kexec_event("kexec_execute");
>>> +
>>>   	ret = ima_dump_measurement_list(&buf_size, &buf,
>>>   					kexec_segment_size);
>>>   
>>
>> After fixing up and applying this patch set to 6.14.0-rc1, I'm not seeing the
>> "kexec_execute".  Even after changing the default extra memory, I'm still not
>> seeing
>> the measurement.
> 
> FYI, after reverting commit 254ef9541d68 ("ima: Suspend PCR extends and log appends
> when rebooting"), I'm seeing the "kexec_execute" measurement.

I would try sth. like this:
static int ima_reboot_notifier(struct notifier_block *nb,
			       unsigned long action,
			       void *data)
{
	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
		ima_measure_kexec_event("kexec_execute");
> 
> Mimi
> 
> 


