Return-Path: <linux-integrity+bounces-6735-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672DBB123C7
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEB188A9D5
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83A24728F;
	Fri, 25 Jul 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WN4IeqK5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAA1C8FBA;
	Fri, 25 Jul 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468202; cv=none; b=qtbZgc6z0C0Psu/5fpror6mjlGorql18HavgIXXjKkuc+XKoAYZyO7Ku076fEA1iy3x7a2lYLlqM6J/LjwF8msXGu0LVwsHXSoJJCsx6ZLsamIffxOrYmCaJ/nRnli+F0RwUT6uY8C0sNG31Ypr3/Yg4yasyFRa3Pf5fZbO3bW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468202; c=relaxed/simple;
	bh=BmIA7pdIgrUwDwqPfmLGxIDTM71gVTo5N4NhvNRkaNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMz00aMIOgW/1gBEOY3PC9790vE8al8ZVxJ9d/8Lk044XcNGtq/+Pgq97bC2UcWk7LyuNRLs+ulW6p44UJhRnfXe3V6ka6cVF6kibNeaJXKYfKzr2huwLXzblnrbzZBaqaD013V6103QCLiZGIg0GBZJRRlz5nP9ULZ/BisVRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WN4IeqK5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PC6YRm024282;
	Fri, 25 Jul 2025 18:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gwHqhN
	TrsKC7iDkKMerSwZnTlYFq0WR3tYd0atWHduQ=; b=WN4IeqK5U776N14XxABujA
	bjkb6BaV9U5K9y8aKdcDFUNIitOgqquSoaz7Fq9mSBU9zfI0mR2g3+mXBD20hJfl
	lnOkZXltjQ1CaY9rSjq+yXzoj2rWbAfusXg3mTmAjp1/PNf+Jgfl1baUnzswM8V4
	wbZpbZR37ZMEwpScDZh/isrkUPjphFvdLrCM3C4yn6C04dFWF/zBNTU1NV+JszUD
	sEiHOOxxcFc78YHGAmYixOjdMzj9NtmzRHDL7znwCpnYFvrHF0ctIybpwE2sXTDj
	e7aua9rU0wQ0CC9eKLZD327WIwoSNPLsAXi+gwLVfL4kCPgyYKgvG5GiY3+RFi4g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchvjcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 18:29:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56PITWMM005867;
	Fri, 25 Jul 2025 18:29:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchvjcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 18:29:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGRHBG014302;
	Fri, 25 Jul 2025 18:29:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480pppjrub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 18:29:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56PITUxF10748428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 18:29:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 348AB58054;
	Fri, 25 Jul 2025 18:29:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45ACC5804E;
	Fri, 25 Jul 2025 18:29:28 +0000 (GMT)
Received: from [9.61.131.29] (unknown [9.61.131.29])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Jul 2025 18:29:28 +0000 (GMT)
Message-ID: <683380bb-ef1b-44ab-b7df-83c23dd76ff7@linux.ibm.com>
Date: Fri, 25 Jul 2025 14:29:27 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] integrity: Extract secure boot enquiry function out of
 IMA
To: GONG Ruiqi <gongruiqi1@huawei.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, "Lee, Chun-Yi" <jlee@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Lu Jialin <lujialin4@huawei.com>
References: <20250628063251.321370-1-gongruiqi1@huawei.com>
 <eb91dcf034db28e457a4482faa397dd7632f00fd.camel@linux.ibm.com>
 <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
 <e8aa7f94-3e52-488d-a858-564d3d1edd4b@linux.ibm.com>
 <362b3e8a-0949-42d1-a1d0-90bd12d86b09@huawei.com>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <362b3e8a-0949-42d1-a1d0-90bd12d86b09@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1NiBTYWx0ZWRfX4KxyCFL3+SdL
 67Rt3tFuxDe4L+z9znmO5L6MT+8UFdj+VGyS6VYDdQvlssI0LW+Zv4XZ4Z1nEqyyejHkBQPLgDP
 nfEzUzLPb2ts/mxBmIJVmBKcs5bSE+fgKItXRzOgfUEcT6TNn15SOhKvmDvfRXd3v+IA18cUZLJ
 B4M3EOH4yP3n1VLTKPqkylnSyOilq9mncMpkspyMn9qHbLGmbrFwulb91YYx+28RekdCg5wLQSV
 bUxyF4uMskc375/JP2lpU5o/yd5alQnj8vFSmIWMsNT/Ya8QBzYwkx5pAZ0ZTLEL2cI+xF7eUod
 KqYQ30UZoUULTd67YiJicD763xXd5OCDw/IdOmHo2leynUx+rpAvRFweZGBHl11wqmCGoV+98Rw
 Ro7BVRedADGohswUg8LdXKofYwbH+ltGygJzb0USpxCW21dilx1huWAKc4r17zQ9gNaKdMDG
X-Proofpoint-GUID: tB-KkiZit6gq5ufEk7aIRLwGi9-y1m0n
X-Proofpoint-ORIG-GUID: cuKHRALnOoG-7pdT_3yVH_LnIYMUjbOi
X-Authority-Analysis: v=2.4 cv=G+ccE8k5 c=1 sm=1 tr=0 ts=6883cd0d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=__7AbSSk1QWdYEejdFoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250156


On 7/17/25 8:29 AM, GONG Ruiqi wrote:
> On 7/8/2025 4:35 AM, Nayna Jain wrote:
>> On 7/2/25 10:07 PM, GONG Ruiqi wrote:
>>> ...
>>>
>>> "We encountered a boot failure issue in an in-house testing, where the
>>> kernel refused to load its modules since it couldn't verify their
>>> signature. The root cause turned out to be the early return of
>>> load_uefi_certs(), where arch_ima_get_secureboot() returned false
>>> unconditionally due to CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n, even
>>> though the secure boot was enabled.
>> Thanks for sharing additional details.
>>
>>  From x86 Kconfig:
>>
>> /For config x86:
>>
>>      imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>> /
>> And IMA_SECURE_AND_OR_TRUSTED_BOOT is dependent on IMA_ARCH_POLICY .
>>
>> And from Linux Kernel Kbuild documentation( https://docs.kernel.org/
>> kbuild/kconfig-language.html) :
>>
>> /weak reverse dependencies: “imply” <symbol> [“if” <expr>]
>>
>> This is similar to “select” as it enforces a lower limit on another
>> symbol except that the “implied” symbol’s value may still be set to n
>> from a direct dependency or with a visible prompt.
>>
>> /Following the example from the documentation, if  it is EFI enabled and
>> IMA_ARCH_POLICY is set to y then this config should be default enabled.
>>
>> If it is EFI enabled and IMA_ARCH_POLICY is set to N, then the setting
>> for IMA_SECURE_AND_OR_TRUSTED_BOOT should be prompted during the build.
>> The default setting for prompt is N. So, the person doing the build
>> should actually select Y to enable IMA_ARCH_POLICY.
>>
>> Wondering what is the scenario for you? Unless you have IMA_ARCH_POLICY
>> set to N, this config should have been ideally enabled. If you have
>> explicitly set it to N, am curious any specific reason for that.
> Hi Nayna. Sorry for the late reply. Super busy these days...
>
> Yes, IMA_ARCH_POLICY was not set. The testing was conducted on
> openEuler[1], a Linux distro mainly for arm64 & x86, and the kernel was
> compiled based on its own openeuler_defconfig[2], which set
> IMA_ARCH_POLICY to N.

Thanks Ruiqi for the response.

It seems the main cause of the problem was that IMA_ARCH_POLICY config 
wasn't enabled; and it sounds like you don't need IMA arch policies but 
you do need the arch specific function to get the secure boot status.

In that case, removing IMA_SECURE_AND_OR_TRUSTED_BOOT config dependency 
on IMA_ARCH_POLICY config and updating the corresponding help is all 
that is needed.

The help text can be updated to:
This option is selected by architectures to detect systems with secure 
and/or trusted boot enabled, in order to load the appropriate IMA 
runtime policies and keys.

Thanks & Regards,

     - Nayna


