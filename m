Return-Path: <linux-integrity+bounces-566-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE23781E812
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Dec 2023 16:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD8DB21ABC
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Dec 2023 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547344EB42;
	Tue, 26 Dec 2023 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m2lRZLFs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07D4EB2B
	for <linux-integrity@vger.kernel.org>; Tue, 26 Dec 2023 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQBCZI7032100;
	Tue, 26 Dec 2023 15:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yOYfMYSFUNmk5Rc73/HwjptZwS5kDtizTIALFYWfpsc=;
 b=m2lRZLFsfSWuPgTJ6D3t/v7g2bun2M77aZmNvYLX5aVfUfl69g/KOx//dBqIDR6dUqmY
 VAZQudmZHSCmopomnVC61OhkYKOrlzcV01hP7j1LsoIE38EI3WkCrXzNURt68ZYkw6s3
 6AT7rD2U/uREa8ISS7fhv7JOqDWTGboJ0uyNS74km1RWGwDHQaKrIuH+/TD6QjVstmfL
 Y4IVgSMv5+ih3F8Z+RZ0k8FGx9beS94Diy+jt0g4bxjfJFhyk6knLBH44TmX5kQyVBSz
 KOs1PSJdOh8paKKFHcSfeZbUqzD2ZAUUXenDzz10P5xP4qaHcPpr3una9VTS0hlOL95s Zw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v7wrmcfnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 15:36:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQDDVu4016609;
	Tue, 26 Dec 2023 15:36:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6c3jvwun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 15:36:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BQFafim11862560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Dec 2023 15:36:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 589B55804B;
	Tue, 26 Dec 2023 15:36:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCEDC58055;
	Tue, 26 Dec 2023 15:36:40 +0000 (GMT)
Received: from [9.67.30.110] (unknown [9.67.30.110])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Dec 2023 15:36:40 +0000 (GMT)
Message-ID: <3da78a77-9bfb-45c7-9979-2dba6fe27f37@linux.ibm.com>
Date: Tue, 26 Dec 2023 10:36:39 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
Content-Language: en-US
To: "Guozihua (Scott)" <guozihua@huawei.com>,
        Mimi Zohar
 <zohar@linux.ibm.com>,
        Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
References: <20231214145152.36985-1-enrico.bravi@polito.it>
 <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
 <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
 <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
 <46e0fd93-86f6-bdf9-99d4-1ccf83f88afe@huawei.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <46e0fd93-86f6-bdf9-99d4-1ccf83f88afe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wDVWx2RbXBX6UkCyv19pghB6kBdFwpC7
X-Proofpoint-ORIG-GUID: wDVWx2RbXBX6UkCyv19pghB6kBdFwpC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-26_08,2023-12-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312260119



On 12/25/2023 8:00 AM, Guozihua (Scott) wrote:
>> After thinking about this some more, I realized that we didn't discuss
>> carrying the measurement list across kexec.   How will the kexec'ed
>> kernel be able to differentiate between the original and new
>> measurement list?   Neither the Kconfig nor making SHA1 backwards
>> compatible address this.   How will attestation servers be able to
>> differentiate between the two logs?
>>
>> Obviously the new measurement list with larger digests won't be
>> backwards compatible. Can we support carrying the original measurement
>> list across kexec to a new kernel?
>>
>> As long we're making changes to the IMA measurement list, we should
>> mention that we could include multiple digests, but I don't think it is
>> necessary.
>>
>>>>> An example of the resulting ima log is the following:
>>>>>
>>>>> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
>>>>> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
>>>>> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
>>>>> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache
>> The template DATA_FMT_DIGEST_WITH_ALGO field is a composite field
>> defined as <hash algo> + ':' + '\0' + digest.   The above ascii display
>> looks like the template composite field, but isn't.  It is two separate
>> fields.  Perhaps it should look differently as well.   Consider instead
>> of a string use the hash_algo value (include/uapi/linux/hash_info.h).
>>
>> binary measurement log:  <pcr> <hash_algo> <digest_len> <digest>
>>
> Hi Mimi and Enrico,
> 
> As we are extending all supported algorithms of a PCR bank, does
> algorithm of template-hash still matters?
> 

 From a security and verification viewpoint, I think you are correct. 
The template hash is redundant, and can always be calculated from the 
template data. In that sense, the template hash can be removed.

On the other hand there is one benefit to the template hash. If there is 
a bug in the software that creates the event log or the software that 
consumes the event log, the template hash may help to determine which 
event has a bug.

If the new event log has a template hash, I do believe that it also 
needs a hash algorithm.

