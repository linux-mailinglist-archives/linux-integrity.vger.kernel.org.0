Return-Path: <linux-integrity+bounces-744-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74AE82B525
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 20:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E251C23B57
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3B52F9F;
	Thu, 11 Jan 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+jnGf6h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631739F
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BITJL8021065;
	Thu, 11 Jan 2024 19:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BHSJ6p/hh7+tcbgj8qwmKfNJUanV7bzRefX4WxB7ZZw=;
 b=L+jnGf6h+Equ57lldsbd/7s3nRlKonlAHSGvlz3Tj08ijJbn6I/yu3pDv6rEVQxn8w8B
 GcUZ2V074d7miNbKzsOrrKlNcdA5/zo08pmCxSknwoLmY20t32UyQuRuDa0y/G649eon
 DT3uFdkXWiqHFNTFSP/pZNG+xFmii6zybL/Q/AUajLcsv3eurcG4CchoWRez+HVuicze
 xY8+iussoOualFMpy7ihgamRm3M75JjmHXJdvDdcCxpXbQuDh51GnChdwRaJVfGUKEwj
 3Hq4M7bTXkKjdLKNsCWiX/DYh+txhYbERW20aEk6pjBEsBopA5ugzfJ4Pe1VFs58VTke XQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjjt060xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:20:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BIYdjH001339;
	Thu, 11 Jan 2024 19:20:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdkn7gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:20:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BJKw3G8323726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 19:20:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD7055805D;
	Thu, 11 Jan 2024 19:20:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC75658064;
	Thu, 11 Jan 2024 19:20:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 19:20:56 +0000 (GMT)
Message-ID: <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
Date: Thu, 11 Jan 2024 14:20:56 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZG4bSnlhTFaoi9Te6do-9QXYIZBm8gvT
X-Proofpoint-GUID: ZG4bSnlhTFaoi9Te6do-9QXYIZBm8gvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_11,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=473 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110151



On 1/11/24 13:13, Tushar Sugandhi wrote:
> 
> 
> On 1/7/24 09:00, Mimi Zohar wrote:
>> On Fri, 2024-01-05 at 12:20 -0800, Tushar Sugandhi wrote:
>>>>> diff --git a/security/integrity/ima/Kconfig 
>>>>> b/security/integrity/ima/Kconfig
>>>>> index 60a511c6b583..8792b7aab768 100644
>>>>> --- a/security/integrity/ima/Kconfig
>>>>> +++ b/security/integrity/ima/Kconfig
>>>>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>>>>       default n
>>>>>       help
>>>>>          This option disables htable to allow measurement of 
>>>>> duplicate records.
>>>>> +
>>>>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>>>>> +    int
>>>>> +    depends on IMA && IMA_KEXEC
>>>>> +    default 64
>>>>
>>>> Since this isn't optional, the default should remain as a half page.
>>>> Since a page is architecture specific, the default will need to be arch
>>>>    specific
>>>>
>>> It was a feedback from Stefan in the V2 of this series to convert it
>>> from number of PAGES to KB.[1]
>>>
>>> But I can revert it to number of pages again.
>>>
>>> Also, making the default value as a fraction (1/2 page) feels weird for
>>> a CONFIG variable.
>>>
>>> Is it ok to make the default value as one page rather than half page?
>>
>> The point is not whether the extra memory is specified in terms of 
>> pages or KB.
>> For backwards compatibility the existing default should be the same as
>> previously.  This means the default needs to be architecture specific.b
>> $ uname -m; getconf PAGESIZE
>> x86_64
>> 4096
>> $ uname -m; getconf PAGESIZE
>> ppc64le
>> 65536
>>
>> For example:
>>
>> default 32 if PPC_64K_PAGES
>> default 2
>>
> Ok. Thanks for the clarification.
> 
> 
> Do we want to support only 64K or 4K as possible PAGE_SIZE values?
> I spot checked a few architectures, there are scenarios where PAGE_SIZE
> could be 8K, 16K, 128K, 256K etc. And of course mega pages with
> PAGE_SIZE IN MBs (details below).

I would let the user specify the number of kilobytes to reserve and from 
this you can conclude the page numbers:

needed_pages = KBs_TO_RESERVE / PAGE_SIZE
if (KBs_TO_RESERVER % PAGE_SIZE)
     needed_pages++;

    Stefan

