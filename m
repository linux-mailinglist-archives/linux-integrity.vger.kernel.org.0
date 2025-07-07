Return-Path: <linux-integrity+bounces-6638-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BBAFBC9B
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Jul 2025 22:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A921AA690A
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Jul 2025 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E22219A6B;
	Mon,  7 Jul 2025 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HUcH24Dw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06ECA932;
	Mon,  7 Jul 2025 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920574; cv=none; b=X/8czirzFPRbLZdsb2j9DwDc7FL7CQ1BjckhyllAOUSN47vkS3WMQLRC9Hf2iomfdli0orHptFOOJ3iXthIoREBACPBLeykzMyICx4M14QvA+LETdE79y6uKAsDu20+5qxfgThULbPdk1gnOBnKTS4po+tjaCaovIc7jYj0vTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920574; c=relaxed/simple;
	bh=zWPrwd3wg5x9gNKa3ecf3D48+KXLVbGRBDo1at35nuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDSNsCrMC05lTnxo5kB/q/vO1OgICXhsx40olIBUIrYP5IPxz/ccFoSXR+paZ6/JaPlDNUOSz9uXCeiGRz5A9QNieYj8H97KuwUGV6aYVlbnDfEZVX2W1pHy4AZ/ofAd9XT9pkDO4LoqteyCB/LihxY58GhaqMR7MLZTaC7pj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HUcH24Dw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IkRLv020724;
	Mon, 7 Jul 2025 20:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BFnUtE
	rzqi+YrOuLQHHe/HmmEuiWzUgAukevdWHaQtE=; b=HUcH24DwcvCPOm3PDDcfLM
	HVIMdtaBq+zjU+EnIVaKtvk/C0Ei4HkfmBYrKj83PDR47o9Ndy/q67RdjBzsrYUr
	MBor8MHerh6BtErq14W2pZVcbqui/RUKemAKfd2JLDsdA97WRiHV6poIcmcC99Jf
	G/HVrWKjo4gRapnVvvwHNTzV41mRj27seDusIe2cC3zJe3lZcSBwMGHaTc9LxL8z
	3+tHOeEKsj0b53lUmhfGHI0S4IQqPWHOyLOGX5TDRpq/0p2tIFoGMsIXWhvOBx48
	TB7/sor1/z4FFI/hwS5E2yNdYvOKyuJG3fvhSX91hezE6k9gyQiOZzYSeVZPfFQg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur6uwwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 20:35:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 567KZfrJ024112;
	Mon, 7 Jul 2025 20:35:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur6uwwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 20:35:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 567HSKfa003123;
	Mon, 7 Jul 2025 20:35:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvm7px5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 20:35:39 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 567KZbLm19989208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 20:35:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D991D58066;
	Mon,  7 Jul 2025 20:35:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05CDD58059;
	Mon,  7 Jul 2025 20:35:36 +0000 (GMT)
Received: from [9.61.104.52] (unknown [9.61.104.52])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Jul 2025 20:35:35 +0000 (GMT)
Message-ID: <e8aa7f94-3e52-488d-a858-564d3d1edd4b@linux.ibm.com>
Date: Mon, 7 Jul 2025 16:35:35 -0400
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
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEzNCBTYWx0ZWRfX53yA02ssT3+2 /gIxgy0haxwvya29kT6g0bpAanaNmXV5bL1kndK/P0mrTKdZ49SFu1TJP5w1IqUWfbQ8Q/7bznI p29/fompY+x+URuYQnREA77BOBHkHDEmm6AN+HjDBDDd/RTr2UaK74qWvyJpHwehOnPzp5QzpxI
 ViFpWyHYtpHSNs7sq+DgHFFe3uHzVgoK0nLx9qzRJhfYstdyq+scQd26JdcgQnPrcJKdrxtstzl Y7GBE8NyVQz6HC57xZGbQLTG+sCw7gv8tihuKzlQYUUQ+ap1JWDBvUxKlEN17jKZRMOzcH6dAYJ bexK7F/f5ySSxPQ058yPVn13UnaJHWwzTgez/gZP7lcrVUBsHmwJqAMghch41iaIIy1XpOVbOIK
 X1P4HInyVbuTTrX82/sSSTp06SuDddd+PLM1rGoky6MjBgSeqcetdZDjnk+u5rQfeghbBPu9
X-Proofpoint-GUID: 9YY1oyQC6cHyMbd3txRAWdcUnljcso27
X-Proofpoint-ORIG-GUID: ApRdDBF3eK6BnW2c7Srv0xd8U7XS3XOg
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686c2f9d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=0SdL4vufndsjM6Dj2E8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GHzZeaHGQcwA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_05,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070134


On 7/2/25 10:07 PM, GONG Ruiqi wrote:
> Hi Mimi,
>
> On 7/3/2025 9:38 AM, Mimi Zohar wrote:
>> [CC: Nayna Jain]
>>
>> On Sat, 2025-06-28 at 14:32 +0800, GONG Ruiqi wrote:
>>> ...
>> The original reason for querying the secure boot status of the system was in
>> order to differentiate IMA policies.  Subsequently, the secure boot check was
>> also added to safely allow loading of the certificates stored in MOK. So loading
>> IMA policies and the MOK certificates ARE dependent on the secure boot mode.
>>                                                                                  
>> What is your real motivation for moving the secure boot checking out of IMA?
>>                                                                                  
> Sorry for not stating that clearly in this patch. I think the cover
> letter of V3 I just sent few minutes ago can answer your question, and I
> quote:
>
> "We encountered a boot failure issue in an in-house testing, where the
> kernel refused to load its modules since it couldn't verify their
> signature. The root cause turned out to be the early return of
> load_uefi_certs(), where arch_ima_get_secureboot() returned false
> unconditionally due to CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=n, even
> though the secure boot was enabled.
Thanks for sharing additional details.

 From x86 Kconfig:

/For config x86:

     imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
/
And IMA_SECURE_AND_OR_TRUSTED_BOOT is dependent on IMA_ARCH_POLICY .

And from Linux Kernel Kbuild documentation( 
https://docs.kernel.org/kbuild/kconfig-language.html) :

/weak reverse dependencies: “imply” <symbol> [“if” <expr>]

This is similar to “select” as it enforces a lower limit on another 
symbol except that the “implied” symbol’s value may still be set to n 
from a direct dependency or with a visible prompt.

/Following the example from the documentation, if  it is EFI enabled and 
IMA_ARCH_POLICY is set to y then this config should be default enabled.

If it is EFI enabled and IMA_ARCH_POLICY is set to N, then the setting 
for IMA_SECURE_AND_OR_TRUSTED_BOOT should be prompted during the build. 
The default setting for prompt is N. So, the person doing the build 
should actually select Y to enable IMA_ARCH_POLICY.

Wondering what is the scenario for you? Unless you have IMA_ARCH_POLICY 
set to N, this config should have been ideally enabled. If you have 
explicitly set it to N, am curious any specific reason for that.

Thanks & Regards,

    - Nayna
>
> This patch set attempts to remove this implicit dependency by shifting
> the functionality of efi secure boot enquiry from IMA to the integrity
> subsystem, so that both certificate loading and IMA can make use of it
> independently."
>
> Here's the link of V3, and please take a look:
> https://lore.kernel.org/all/20250703014353.3366268-1-gongruiqi1@huawei.com/T/#mef6d5ea47a4ee19745c5292ab8948eba9e16628d
>
>> FYI, there are a number of problems with the patch itself.  From a very high
>> level:
>>                                                                                  
>> - The EFI secure boot check is co-located with loading the architecture specific
>> policies.  By co-locating the secure boot check with loading the architecture
>> specific IMA policies, there aren't any ifdef's in C code.  Please refer to the
>> "conditional compilation" section in the kernel coding-style documentation on
>> avoiding ifdef's in C code.
>>                                                                                  
>> - Each architecture has it's own method of detecting secure boot. Originally the
>> x86 code was in arch/x86, but to prevent code duplication it was moved to IMA.
>> The new file should at least be named efi_secureboot.c.
> You're right. I didn't realize it's arch-specific in the first place,
> and moving and renaming arch_ima_get_secureboot() turned out to be a
> real mess ...
>
> So the V3 keeps the prototype of arch_ima_get_secureboot(), and only
> moves out its body, which I think can also better represent the
> intention of the patch.
>
> As of the name of the new file, as V3 has been sent earlier and still
> uses secureboot.c, I can't change it there. I can do it in V4.
>
> -Ruiqi
>
>>                                                                                  
>> - The patch title should be about moving and renaming the secure boot check.
>> The patch description should include a valid reason for the change.
>>
>> Mimi & Nayna

