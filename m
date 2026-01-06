Return-Path: <linux-integrity+bounces-8174-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9235CF6BD9
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 06:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82BAB30082E2
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73E2EDD57;
	Tue,  6 Jan 2026 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pL6YUpXz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB442F3C19;
	Tue,  6 Jan 2026 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676206; cv=none; b=IThaPnWhNHGcGctbTbEVzl2346SKX9y4mNCdsDagLfSx9dJK13cgbEy97Yie5BE4Zi+AlHk470StS4RXTjD+iiXCZXxtwpFArMbpFixCecQG1ZUqdlDYHCFnvhgqP3S7OlO3OG12fq+Mwq4e3qIU8AUPd5wAZvVPTBpq339oEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676206; c=relaxed/simple;
	bh=0lzdmg1n2qwWSgmJeaNC9U/IlJxudK9aYtcSvTh1JyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mak6SuVVu52BFDZtWY953PHDnOsQHfTokRuiverA43e5anPjTba+dt81YYspMGkGVEFykn8zyAF82XIt60MhZ/tU6YXBIaYKH+0VC+8rwENoInz+UoNfGOMe24V+7XUTyjNyvT6wUudM6I4JLec/gdZ6N8oPkpmKjvymkOV3/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pL6YUpXz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605EhWbe014268;
	Tue, 6 Jan 2026 05:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+kaidP
	U2r9UG5d+cT39AxQa40CxkXVRvwfc0y61s5NY=; b=pL6YUpXzSa0p3Q4ELWkgvo
	2ayEZ8sy/I2POBTvkYsEEKLpRbwpiTlQRj12ncjP6bHdvVqI0cOr+IQyz+pIdUNe
	h054D9+Y12xnK40SGEsuOl1ZsrjoISBmg2FCqaqM+Q218sUhdgw7IZrg9JZTcXzF
	rQ/s7UJ+W8XEQHygPqqmDPMEGAC2suLNeBibDVhzKXL/6wHWb5xz9Owxs77xIzlO
	Rv9nzty8xnLnPDFPSNeZuR2gaL62EtN/jPMkkuOKMF5HrvvS9DyIaaEzRZ0beqKy
	JwiucgW85tCly96kPv3+u3jVz1i/qsMknKwIHKN4jSUo2DkN4QVnQzFuOope+FPA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu62dfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 05:09:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60659pns013961;
	Tue, 6 Jan 2026 05:09:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu62dfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 05:09:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6064nbDs023501;
	Tue, 6 Jan 2026 05:09:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rm67ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 05:09:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60659mcC4064084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Jan 2026 05:09:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCC258051;
	Tue,  6 Jan 2026 05:09:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B46985805A;
	Tue,  6 Jan 2026 05:09:44 +0000 (GMT)
Received: from [9.124.214.6] (unknown [9.124.214.6])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Jan 2026 05:09:44 +0000 (GMT)
Message-ID: <9f2f041d-37a7-42ed-bc06-540b65e8b54f@linux.ibm.com>
Date: Tue, 6 Jan 2026 10:39:42 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] keys/trusted_keys: establish PKWM as a trusted
 source
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20251217172505.112398-1-ssrish@linux.ibm.com>
 <20251217172505.112398-6-ssrish@linux.ibm.com>
 <14a30e37e0cf8ef373b63d3b905ec1a7d807118a.camel@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <14a30e37e0cf8ef373b63d3b905ec1a7d807118a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695c9920 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=zoI4ALCl8jw1XMAjGw4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DmxY2bha4venHbUU40UgUVK-KtoI7j_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAzOCBTYWx0ZWRfXyoFXHwCbfM8y
 YBwaQNxTCM7fVJXN60Rlnw7lJH33D64qhnZfrRs05T1KkyDWLS/wXJJLN/GGNFIoayvipBiOMIN
 E1qkxWkrPY5xiXbfCGVFLUqza/yUMWxtAfmUaffqjDh9smmhSkASZQtk9zY5kVbZPDlM8kd+hwb
 8lP0NRSejJ9XwCII0dPhcdC8mlybz/I4xNgwJ/pRqUDT/iYe124ljOmTxbyhSAE4BouooWEwLly
 tsFFaak7NVQhE1MNtVr4hJya42s948amnOX2YNoYuqlzcEdhyggxkoRg0SoV2qBeBAp+aBWEBPM
 uFv2iUR238zwSiqqrYPh81L5fKKrrBGlR4FlQ+HNwPVKxFfBagh+Frivur4oNZGWqwMDhRy1faF
 Rhz/aFU7VtqEG1BWAlNEWufY3TissCCL1yim5ZJDymICCgFm5hAA6KivxYnvVfIPybFIStRKmHn
 c6gN534DrKdD8lE9Fiw==
X-Proofpoint-GUID: s2y3tF9tsH2IQgG83SdIEOTTrg7_KjkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060038

Hi Mimi,
thanks for taking a look.

On 1/2/26 11:14 PM, Mimi Zohar wrote:
> On Wed, 2025-12-17 at 22:55 +0530, Srish Srinivasan wrote:
>> The wrapping key does not exist by default and is generated by the
>> hypervisor as a part of PKWM initialization. This key is then persisted by
>> the hypervisor and is used to wrap trusted keys. These are variable length
>> symmetric keys, which in the case of PowerVM Key Wrapping Module (PKWM) are
>> generated using the kernel RNG. PKWM can be used as a trust source through
>> the following example keyctl command
> -> commands:

Yes, I will fix this.

>
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
>> -> All the other bits are requied to be not set.
> -> required

Noted.
Will fix this.

>
>> -> Set the kernel parameter trusted.source=pkwm to choose PKWM as the
>> backend for trusted keys implementation.
>> -> CONFIG_PSERIES_PLPKS must be enabled to build PKWM.
>>
>> Add PKWM, which is a combination of IBM PowerVM and Power LPAR Platform
>> KeyStore, as a new trust source for trusted keys.
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Thanks, Srish.  Other than fixing the typo and other suggestion above,
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks for the review Mimi.
Will fix these typos and send out v3.

thanks,
Srish.

