Return-Path: <linux-integrity+bounces-2295-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2898B8038
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 20:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FD2283648
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251AC184136;
	Tue, 30 Apr 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RjWb4Lwa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604C38DE4;
	Tue, 30 Apr 2024 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503595; cv=none; b=fY9P0Rn1k5i7ROp7PxUJxRkgxKifqtwp/tOiukP7AVGmsNQ/Jx2rfk1VEe58dch2MjZ0fP7iqsZqEfriy0CtMlKxCGvBbRJpY2Zz7DRuGoSYkegoloXc6Vtg124qbtJSzLT1tgkfttu1S2nXcV9TiTBsXV+STNbRhRlsjfjgf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503595; c=relaxed/simple;
	bh=jRIAEzC1gyWC3ZdXiZlUDhdGWTeLDgSdfGYIWfCdL5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbXDa0Ccj8v8c5OP77QpQ5BCORbSk83rl7Jn/FjdXlNbEZDMBqIK2jAKHhali8GfJWkpyAlOfE4oH4pke4zCEcTPucZiCHzoYn8nQXCv7nIxQuG/7FjlRuaLsA80tJQABNay6/zYyzXOkiWQspS56whIy9xDDImuAGlU/aaMqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RjWb4Lwa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UIhHES022279;
	Tue, 30 Apr 2024 18:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jUtYkYDscMZFps8f8WcIB6OLCAFITxp3hX1wfwkZUE4=;
 b=RjWb4LwaO1GrgQh/9TtCa3ZbfxxnDYMF5NCZA0omehQO3t/GJd73BxRMil/SdDClxZoC
 z5a1+HTltsU7r0FMdXhV6lzslA9P+Mntxxu1dvRchvPR9RT/RPihgxri3XKlEtdgW8g5
 xFptbBl3Rr8WK9C1zTgT9LlV7q+ry1uJjBb8nGnpinicHgwfBKT/U3uwpBb3LqpF94vq
 CDboc7pBFlxG4nTk0ZQX42KIg7jR5aQeWe/PQbwfdwv+ZVcI93WaEUKjAf65pEpaq2xZ
 BMS95XRgiU8f0oWEdjlNt+iEg0s9bCTLMtJGUuaoZ5Ppvh8c7OKojCb9EuZGVWTCOCrr uw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu65m012n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:59:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43UI0qWP011781;
	Tue, 30 Apr 2024 18:57:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsdwm6by8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:57:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UIvZPh19399256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 18:57:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C0F58058;
	Tue, 30 Apr 2024 18:57:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D2558066;
	Tue, 30 Apr 2024 18:57:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Apr 2024 18:57:35 +0000 (GMT)
Message-ID: <4c405d6c-0bc8-4637-a604-505ebb7d4c70@linux.ibm.com>
Date: Tue, 30 Apr 2024 14:57:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2 transactions
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <D0WYKBCRV1BS.EWPTEY7QUG85@kernel.org>
 <D0X0BN0RI4UG.2T8WRIFTWXE96@kernel.org>
 <3e6bafc8-99df-4e84-8f3a-8181c9f84e24@linux.ibm.com>
 <D0XOBKC3XWJK.3U49LYWO3POOL@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D0XOBKC3XWJK.3U49LYWO3POOL@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ChtTtZQBhfjaW9cqfjiUyHaDnvEHzM4q
X-Proofpoint-ORIG-GUID: ChtTtZQBhfjaW9cqfjiUyHaDnvEHzM4q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300136



On 4/30/24 14:37, Jarkko Sakkinen wrote:
> On Tue Apr 30, 2024 at 2:18 PM EEST, Stefan Berger wrote:
>>
>>
>> On 4/29/24 19:49, Jarkko Sakkinen wrote:
>>> On Tue Apr 30, 2024 at 1:26 AM EEST, Jarkko Sakkinen wrote:
>>>> Right and obviously 3rd option is to send a PR to
>>>> https://gitlab.com/jarkkojs/linux-tpmdd-test.
>>>>
>>>> I.e. patch file goes to patches/qemu (BR2_GLOBAL_PATCH_DIR
>>>> points there).
>>>
>>> Stefan, can I do a "zero QEMU changes" negative test for
>>> changing null seed by somehow reseting swtpm? That would
>>> be best possible option (if it is possible).
>>
>> You cannot easily reset swtpm without changing 'something' and resetting
>> the NULL seed only works when running TPM2_Startup. You could modify
>> some TPM2 command to do what HierarchyStartup does with the nullSeed to
>> simulate what you want.
> 
> Hmm... I'm not too eager to modify swtpm itself.

You would modify libtpms. You may just want to copy the few relevant 
lines from HierarchyStartup function into another TPM 2 command that 
then resets the null seed and whatever else you need reset as a side 
effect. This sounds simpler to me than what you are proposing with 
system(). Who or what would run system().

> 
> So one hacky option might be to run swtpm using system() in an
> interposer program and that program would again create chardev
> using cuse.
> 
> That program would again have to modify traffic "at some point".
> 
> Maybe +1 command after TPM2_StartAuthSession or later?
> 
> BR, Jarkko

