Return-Path: <linux-integrity+bounces-865-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF1839E66
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 02:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F9B26FCE
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BC15BB;
	Wed, 24 Jan 2024 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqNDj5OT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D115A8
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060953; cv=none; b=ser0Ddxj0Xezvvb9NpMNuoKxiea8VDkCy+13lftcdokJt6H/PtUJcu6Sx6l7lmqjTDwHbn5JbCUAy8m6ZcQ0ypR5jlfkdpPRVfRzPEDZFUSCzIsIbmjtaZzwzwMIBS1F8n/in60X7Sb78br9JHdNrEv09x5VOghHxcpO0tM/PIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060953; c=relaxed/simple;
	bh=RV1mHPsyY6tGfID4vfg5EwPil0oy59BBTcMwhBQvGk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8tYP7q9kZSH8guEB7Gr2dv6Sgvc/RFXMp/OVglk9JFlKrzjaOfuVbfYK3IVC7kc1O7Yqg0zuLnntBUXPkCrsnajs40E3KTLGtiyNd1UPnjmRZTyuyxRwfLZhAcHoGkUOKjUMazga1rnGPV0kl7iqxb88Pm4VGoCkEoo1I2uhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqNDj5OT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O02J4Z018509;
	Wed, 24 Jan 2024 01:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EgqCdL4/rwaAqOUfg59/kVKHqHSgCZVraSsQKqN8jx0=;
 b=rqNDj5OTnmp2OM8GTVpp0rfvmhH0lLyakq16KtMY9tF4b2NMR+Y2jNMcdt18cdgFj9ZO
 fCMJ1+8hnc1Um+DjL5ccGsJUKYycOZWbmEb2YI+yFl3S3Ot40sFfCwUdO+S3X6Z/ea+n
 v9gfPh/I8mnTmqxXnuUDV6Ycw0r+G3bqtT5XfSXmFrw46xLg6wDxF2CyXWmYvf9EGkKK
 I8qz0KTM2ap5E1DILniXoHEbp1pBHb0xfVAX2Rq4HiwMp/W3AwAEMkjDAv6arCPnDZ87
 6xwZP8XZRBPs+53eDhijCKMEFBz8Y2RPrV7wQDUfmODHrcU45bpHLovx0k8+BsughUKH iQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtqnd9yyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 01:48:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NNKCBS026879;
	Wed, 24 Jan 2024 01:48:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtb950-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 01:48:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40O1mU6816056938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 01:48:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAC5558061;
	Wed, 24 Jan 2024 01:48:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20CF58057;
	Wed, 24 Jan 2024 01:48:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 01:48:29 +0000 (GMT)
Message-ID: <f1061219-f210-4f4f-b8b8-c506e141abd5@linux.ibm.com>
Date: Tue, 23 Jan 2024 20:48:29 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
 <bdf8c31a-59db-4568-ad7b-e2b3f36c3836@linux.ibm.com>
 <022986e8-07f5-4d3d-8a60-f06dbae31ae8@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <022986e8-07f5-4d3d-8a60-f06dbae31ae8@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pzd3P0NEFQe1sYdzKMN3K_D3xykdj1lt
X-Proofpoint-GUID: pzd3P0NEFQe1sYdzKMN3K_D3xykdj1lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240012



On 1/23/24 16:19, Tushar Sugandhi wrote:
> Thanks again Stefan for taking a look.
> 
> On 1/23/24 11:02, Stefan Berger wrote:
>>
>>
>> On 1/22/24 13:38, Tushar Sugandhi wrote:
>>> The extra memory allocated for carrying the IMA measurement list across
>>> kexec is hardcoded as half a PAGE.  Make it configurable.
>>>
>>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>>> extra memory (in kb) to be allocated for IMA measurements added during
>>> kexec soft reboot.  Ensure the default value of the option is set such
>>> that extra half a page of memory for additional measurements is 
>>> allocated
>>> to maintain backwards compatibility.
>>>
>>> Update ima_add_kexec_buffer() function to allocate memory based on the
>>> Kconfig option value, rather than the currently hardcoded one.
>>>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> ---
>>>   security/integrity/ima/Kconfig     | 11 +++++++++++
>>>   security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
>>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/Kconfig 
>>> b/security/integrity/ima/Kconfig
>>> index 60a511c6b583..fc103288852b 100644
>>> --- a/security/integrity/ima/Kconfig
>>> +++ b/security/integrity/ima/Kconfig
>>> @@ -338,3 +338,14 @@ config IMA_DISABLE_HTABLE
>>>       default n
>>>       help
>>>          This option disables htable to allow measurement of 
>>> duplicate records.
>>> +
>>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>>> +    int
>>> +    depends on IMA && IMA_KEXEC
>>> +    default 0
>>> +    help
>>> +      IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>>> +      allocated (in kb) for IMA measurements added during kexec soft 
>>> reboot.
>>> +      If set to the default value, an extra half page of memory for
>>> +      additional measurements will be allocated to maintain backwards
>>> +      compatibility.
>>
>> Is there really an issue with 'backwards compatibility' that the user 
>> needs to know about ? From looking at the code it seems more important 
>> that a bit of additional memory is reserved now to fit the kexec 
>> 'load' and 'exec' critical data events but that's not 'backwards 
>> compatibility'.
>>
> I was contemplating how to put the right description in place 
> considering the conversation we had in v3 of this series[1].
> Without that context[1] default 0 could be equally confusing to the end 
> user.  With the phrase 'backwards compatibility', I was trying to 
> address the potential confusion around the default value 0 in the config 
> - that it represents half-a-page as default. And that particular value 
> choice ( half-a-page) is for backwards compatibility.
> You are right, I the user shouldn't care about it.  But I had to start 
> somewhere so that we can have this discussion on this thread. :)
> 
> Let me know how this description looks after removing the phrase 
> 'backwards compatibility':
> 
> " IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>    allocated (in kb) for IMA measurements added during kexec soft reboot.
>    If set to the default value, an extra half a page of memory for those
>    additional measurements will be allocated."

Sounds good to me.
> 
> Lastly, do you want me to add suggested-by and/or reviewed-by tag to 
> this patch? Let me know. I will be happy to do so.

Either way is fine by me.

> 
> Thanks,
> Tushar
> 

