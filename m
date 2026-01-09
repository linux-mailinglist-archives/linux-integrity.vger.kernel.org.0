Return-Path: <linux-integrity+bounces-8206-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C976D07F0A
	for <lists+linux-integrity@lfdr.de>; Fri, 09 Jan 2026 09:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8A93010980
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jan 2026 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821A350D4E;
	Fri,  9 Jan 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PzxRYRoP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06F345CC8;
	Fri,  9 Jan 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948501; cv=none; b=DDW5gyjcoD9umD9/AnbNphowS6qMk6O9wu8g7uDbuiI72icOa1G+rCPbOa9oXRHhunkDXtKq+nn5NS23uKwlczp5GFMZYGxglxHr0YhDgRPJmaP3jARlQMHK0nHTTs2irnoeURy0pyg7gu1FYPbZohrpL7pahgkG/A/5LB3N5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948501; c=relaxed/simple;
	bh=9fXD/1CoA7xkW4bXJ0ueVrAvuKBMwYsx/oGnEzfFJ7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHbAb06hxj2nf+a3nmj5Nrck6SUg0WDugFeOmrLaR6L7nJdUCwO+1D9vWCbUPYyw9bNblX7Gwfs/Q65Wo9rHFmODQQppYOiFHEdfdnXmeoxmzacgfIsXW7OiIO4TBytTXki7Ad99++gTXU7mdYuilZIPXVu8MQaNw9+5xHy0YCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PzxRYRoP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608NIF9t005078;
	Fri, 9 Jan 2026 08:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0mEdi+
	BCYDRwRTM1WDOhEF6QBDWqstYoh74f4c+yZok=; b=PzxRYRoPtdD3R9dDCk2AbO
	tZSF6iG2KqhgZpm223CGciINez7pBla/i1Qz2WsYidyL9JDtFI8G6FuVvXDl5BCn
	DY0qvS4/3+b6xy12nxs6Wotd0yKJ8ZughO/qI2Q6PGza4Z5VhdKSBWWQ7BrFDH3X
	jyMH9Ju0aaZEnGEaXPm/RfsbFfpHYlHqdoh4h+56EzD4XJAEStjR+wwvN4lVLY2L
	CJBhVpvzzTeHZKLBd91t/ZHr0yw0esM2Q2XJXdG8ZTK+a3ZRHzBTKswyKtkJ7n7N
	QiSTPTKx+avTpesAwuaaDgNP7xq3fgkqEcpbtb4XrLZqzs9e2BPCkBEMIlq/WoSQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkh41v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 08:48:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6098hbJD021337;
	Fri, 9 Jan 2026 08:48:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkh41q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 08:48:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60973pSk012572;
	Fri, 9 Jan 2026 08:47:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjunws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 08:47:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6098lvWG39191060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Jan 2026 08:47:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC1FE58059;
	Fri,  9 Jan 2026 08:47:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 618D358057;
	Fri,  9 Jan 2026 08:47:53 +0000 (GMT)
Received: from [9.98.107.249] (unknown [9.98.107.249])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Jan 2026 08:47:53 +0000 (GMT)
Message-ID: <b5086ef7-6f4c-4e4c-81d2-a6a663ee891e@linux.ibm.com>
Date: Fri, 9 Jan 2026 14:17:52 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] keys/trusted_keys: establish PKWM as a trusted
 source
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260106150527.446525-1-ssrish@linux.ibm.com>
 <20260106150527.446525-6-ssrish@linux.ibm.com> <aV-w2NbxAPuuXy_U@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <aV-w2NbxAPuuXy_U@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=6960c0c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ahMReMzOZ-clP6jsrXgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PMHcOicgPxegf2zG04kVH1q6_Yc3XGoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2MiBTYWx0ZWRfX5t9LgDpm/9I3
 c2Bxq/Nh+6LnJf0WNOdunckwZ/lvBeszT2cbs+Hm0gzEw0dHLqF3qXBp/7VGx8hUIPPU97LTA0E
 /aNNZV59fGIH7/dJU4ZQyIUVBGsS5CLn8xdxNKPfx2aY5ernaO22Fu3ExjqVWDzURSoEdeKayk8
 TcxE2T019smiAsR73lsR49NA0rXQ1W3YRhroIkZ2I4QDfnfxM/km0xDVUbV7rmywzNZ+hDIB6Bo
 JiQNyuK21uGU8x9Gpq9Qboo+/Ya0uhziz2lADbolMP5W1BYOipQLHrzxQFqVn5epZVsi1qa47nT
 i8/3Vu1skJyDM63kxQyDNu4IO2XROavgG+uTa4XtJhqRugAU2l/d/wHI/FXe+VTmQz/tyQE48X+
 KuFPQwqs1qeE+grif1zIjYvDfs9Geg7/RjxssqTvZhIbwUzdT9Qm9cvc0U9byLJT8tD0jy9ju/Z
 a7omP2w6Rn8EfzKNoHg==
X-Proofpoint-GUID: qmpndCZCykWAfsfMieyIMC6LtCI8mUlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090062

Hi Jarkko,
thank you for taking a look.

On 1/8/26 6:57 PM, Jarkko Sakkinen wrote:
> On Tue, Jan 06, 2026 at 08:35:26PM +0530, Srish Srinivasan wrote:
>> The wrapping key does not exist by default and is generated by the
>> hypervisor as a part of PKWM initialization. This key is then persisted by
>> the hypervisor and is used to wrap trusted keys. These are variable length
>> symmetric keys, which in the case of PowerVM Key Wrapping Module (PKWM) are
>> generated using the kernel RNG. PKWM can be used as a trust source through
>> the following example keyctl commands:
>>
>> keyctl add trusted my_trusted_key "new 32" @u
>>
>> Use the wrap_flags command option to set the secure boot requirement for
>> the wrapping request through the following keyctl commands
>>
>> case1: no secure boot requirement. (default)
>> keyctl usage: keyctl add trusted my_trusted_key "new 32" @u
>> 	      OR
>> 	      keyctl add trusted my_trusted_key "new 32 wrap_flags=0x00" @u
>>
>> case2: secure boot required to in either audit or enforce mode. set bit 0
>> keyctl usage: keyctl add trusted my_trusted_key "new 32 wrap_flags=0x01" @u
>>
>> case3: secure boot required to be in enforce mode. set bit 1
>> keyctl usage: keyctl add trusted my_trusted_key "new 32 wrap_flags=0x02" @u
>>
>> NOTE:
>> -> Setting the secure boot requirement is NOT a must.
>> -> Only either of the secure boot requirement options should be set. Not
>> both.
>> -> All the other bits are required to be not set.
>> -> Set the kernel parameter trusted.source=pkwm to choose PKWM as the
>> backend for trusted keys implementation.
>> -> CONFIG_PSERIES_PLPKS must be enabled to build PKWM.
>>
>> Add PKWM, which is a combination of IBM PowerVM and Power LPAR Platform
>> KeyStore, as a new trust source for trusted keys.
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   MAINTAINERS                               |   9 ++
>>   include/keys/trusted-type.h               |   7 +-
>>   include/keys/trusted_pkwm.h               |  22 +++
>>   security/keys/trusted-keys/Kconfig        |   8 ++
>>   security/keys/trusted-keys/Makefile       |   2 +
>>   security/keys/trusted-keys/trusted_core.c |   6 +-
>>   security/keys/trusted-keys/trusted_pkwm.c | 168 ++++++++++++++++++++++
>>   7 files changed, 220 insertions(+), 2 deletions(-)
>>   create mode 100644 include/keys/trusted_pkwm.h
>>   create mode 100644 security/keys/trusted-keys/trusted_pkwm.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a0dd762f5648..ba51eff21a16 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14003,6 +14003,15 @@ S:	Supported
>>   F:	include/keys/trusted_dcp.h
>>   F:	security/keys/trusted-keys/trusted_dcp.c
>>   
>> +KEYS-TRUSTED-PLPKS
>> +M:	Srish Srinivasan <ssrish@linux.ibm.com>
>> +M:	Nayna Jain <nayna@linux.ibm.com>
>> +L:	linux-integrity@vger.kernel.org
>> +L:	keyrings@vger.kernel.org
>> +S:	Supported
>> +F:	include/keys/trusted_plpks.h
>> +F:	security/keys/trusted-keys/trusted_pkwm.c
>> +
>>   KEYS-TRUSTED-TEE
>>   M:	Sumit Garg <sumit.garg@kernel.org>
>>   L:	linux-integrity@vger.kernel.org
>> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
>> index 4eb64548a74f..45c6c538df22 100644
>> --- a/include/keys/trusted-type.h
>> +++ b/include/keys/trusted-type.h
>> @@ -19,7 +19,11 @@
>>   
>>   #define MIN_KEY_SIZE			32
>>   #define MAX_KEY_SIZE			128
>> -#define MAX_BLOB_SIZE			512
>> +#if IS_ENABLED(CONFIG_TRUSTED_KEYS_PKWM)
>> +#define MAX_BLOB_SIZE			1152
>> +#else
>> +#define MAX_BLOB_SIZE                   512
>> +#endif
>>   #define MAX_PCRINFO_SIZE		64
>>   #define MAX_DIGEST_SIZE			64
>>   
>> @@ -46,6 +50,7 @@ struct trusted_key_options {
>>   	uint32_t policydigest_len;
>>   	unsigned char policydigest[MAX_DIGEST_SIZE];
>>   	uint32_t policyhandle;
>> +	uint16_t wrap_flags;
>>   };
> We should introduce:
>
> 	void *private;
>
> And hold backend specific fields there.
>
> This patch set does not necessarily have to migrate TPM fields to this
> new framework, only start a better convention before this turns into
> a chaos.


Sure,
thanks for bringing this up.
I will make the required changes in my next version.

>
> BR, Jarkko
>

thanks,
Srish.

