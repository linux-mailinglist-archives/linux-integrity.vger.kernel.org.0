Return-Path: <linux-integrity+bounces-4969-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39233A3FFED
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 20:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70213AE2C8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8F250C08;
	Fri, 21 Feb 2025 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EuhPWIK+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD91EEA56;
	Fri, 21 Feb 2025 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166930; cv=none; b=P6Zva/YceGTy+ijo0agV+PuaDm7nrXsQklbH+2O6xtRreKfOZm0kjK1n55sYPw95DkJKBKPudlCdjbAr+qjA6jgdg1greYWaFY7z9iWIprwZ7ZJ4HfDstUTsnlXXqIdFSf9FbtVvVGV2109tAeKpaPsRLqjQLM5uCx98UcDTGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166930; c=relaxed/simple;
	bh=3jIMrZ1K/HmzHXeblxk0WPzMcv1riI+6h9rN/I7u09c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDmBjBL2p4wobcoWcRyNvKvqMsrWf1t7Tds1IhF56fSUTUl4uVw2qt+4eRpzOgoTr2WbCsFtnMEy4oVY1LRSWiUKTDoR2U4EkHwKx7lGfhiQ3LDXNPPFBfassIbpNJDc61suLgrIXQGbbDxPXoZAxUE6I297ZoG1H2jmz6rmN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EuhPWIK+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMekn031848;
	Fri, 21 Feb 2025 19:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HF5MBi
	fEh3vVBQDmW+nUvwQ0TG99jUSuezKu0RmcCDg=; b=EuhPWIK+aRWGm8JeAIF68u
	Ga0pUEP+D1ZGUTeYSOmPFFdSyIbLwlFW49PCWDjWH23QlGARJsxlU/xPEaXYO/p6
	XMOC86eDsISmiE8+q9ZrSP646Mhh1NgRbzm5xFtU6eAzDJ2PmNdl99R6kRTEAnbK
	Uqd4yGB57vmbCGw3coJ+A8GuBAs0yjH/7FCRGorcV5P8857E1czOO22FIA4vSIFC
	fVGf6ZWbeuxm+gi4QxpR0q58HpNUrEL9x9FG8gFGWbkO3ouH0+sfLjV6HVf/pcRb
	Q/jbGjMOPqlgGo3IzA0Z2XbuEgviCvwFFI3WU3nLbJ1l1rwvEfpVO4hVqn+7FOeg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb0cs46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 19:41:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LJ07Vr029303;
	Fri, 21 Feb 2025 19:41:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024svk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 19:41:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LJfgsD30474992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 19:41:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74DA65805D;
	Fri, 21 Feb 2025 19:41:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68A0758059;
	Fri, 21 Feb 2025 19:41:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 19:41:42 +0000 (GMT)
Message-ID: <6caeab8b-5803-4905-a693-13c0154061fe@linux.ibm.com>
Date: Fri, 21 Feb 2025 14:41:42 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
To: Mimi Zohar <zohar@linux.ibm.com>,
        steven chen <chenste@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-5-chenste@linux.microsoft.com>
 <36f8cb5131c51f784fa6e7a062b6318b30c9cc28.camel@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <36f8cb5131c51f784fa6e7a062b6318b30c9cc28.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I1dvLk2vrd635lqxmk20m-xkOfn04apu
X-Proofpoint-ORIG-GUID: I1dvLk2vrd635lqxmk20m-xkOfn04apu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210134



On 2/21/25 2:07 PM, Mimi Zohar wrote:
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> IMA log is copied to the new Kernel during kexec 'load' using
>> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
>> loss of IMA measurements during kexec soft reboot.  It needs to be copied
>> over during kexec 'execute'.  Setup the needed infrastructure to move the
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
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   include/linux/ima.h                |  3 ++
>>   security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 0bae61a15b60..8e29cb4e6a01 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>>   extern void ima_add_kexec_buffer(struct kimage *image);
>> +extern void ima_kexec_post_load(struct kimage *image);
>> +#else
>> +static inline void ima_kexec_post_load(struct kimage *image) {}
>>   #endif
>>   
>>   #else
>> diff --git a/security/integrity/ima/ima_kexec.c
>> b/security/integrity/ima/ima_kexec.c
>> index 704676fa6615..0fa65f91414b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -12,10 +12,14 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of.h>
>>   #include <linux/ima.h>
>> +#include <linux/reboot.h>
>> +#include <asm/page.h>
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>>   static struct seq_file ima_kexec_file;
>> +static void *ima_kexec_buffer;
>> +static bool ima_kexec_update_registered;
>>   
>>   static void ima_reset_kexec_file(struct seq_file *sf)
>>   {
>> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at
>> 0x%lx.\n",
>>   		      kbuf.mem);
>>   }
>> +
>> +/*
>> + * Called during kexec execute so that IMA can update the measurement list.
>> + */
>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>> +				   unsigned long action, void *data)
>> +{
>> +	return NOTIFY_OK;
>> +}
>> +
>> +struct notifier_block update_buffer_nb = {
>> +	.notifier_call = ima_update_kexec_buffer,
>> +};
>> +
>> +/*
>> + * Create a mapping for the source pages that contain the IMA buffer
>> + * so we can update it later.
>> + */
> 
> Hi Steven,
> 
> It does more than just that.  It also registers a second IMA reboot notifier.
> (Is a second reboot notifier really necessary?)  It seems that the
> ima_reboot_notifier() is executed after this one, otherwise the kexec_execute
> would be missing.  However, I'm not sure that is guaranteed.

By setting .priority = -1 in update_buffer_nb we could ensure that it 
will be called after the other notifier that does the suspend, so we 
would be sure that logging suspends before dumping the log to the buffer.

> 
> I'm wondering if this patch should be limited to saving the map segments.  In
> any case, using the reboot notifier is relatively new and should at least be
> reflected here and in the patch description.
> 
> thanks,
> 
> Mimi
> 
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
>> +					      image->ima_buffer_addr,
>> +					      image->ima_buffer_size);
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
>>   #endif /* IMA_KEXEC */
>>   
>>   /*
> 


