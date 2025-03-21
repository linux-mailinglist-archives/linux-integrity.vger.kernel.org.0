Return-Path: <linux-integrity+bounces-5357-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E9A6BF82
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702313B90E5
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238522CBFC;
	Fri, 21 Mar 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WS/NuTZE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD261D86F2;
	Fri, 21 Mar 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573746; cv=none; b=Rm5gHDu56VOefcMl86pvgEIzYl405VUq96DuTJs4WMBaSIVCdxJVIY0oe+eFfTwCTqwuYwMzIna+fX2TgDre9vCqz0vfqgMduPjNK1/hQF+stoQjitcTqGnSo1dzzfbDW5mXzMhbNHWS3DO6o7Ey8TobGpkJAS8ZW08K3kK6Mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573746; c=relaxed/simple;
	bh=GYaoLdPCtsXF+sN1cNitommvdnhFFqRuz0mn+USugbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRW4JWaD58z6eOZR2oEUXQ7H+0unfSoh1IPZs9g+Lf1KQ+apwnjObH7lF8uHj39oGKHzYQLYWrAn6v7jh+kKnItyIpTxIA9BK/QVkwBk0JMlvChvL1T1mJJE6yrVMIGcDjiWQrrmgK9GXYtAE5fDcydUAa7xDTe59EMunUhNMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WS/NuTZE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0789A202537E;
	Fri, 21 Mar 2025 09:15:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0789A202537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742573743;
	bh=BRk5YV40nQnvrqNi6qYQSLR/DJ1q+CacJtEHwZzWwL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WS/NuTZEgk78GqVwM3nFClW8xzukz70tjDPQUa2/c9PImhrHqnFS8JINSAkDvZogj
	 1drLwzHZRHarZ6+GcvPRgaIKKlIwhcQakJWrrcHRjK/sRGhi/kEkVBmIAQZYjwc+oI
	 QfmV1YnYZG1Z37HpAO1VA87Qo/Nq3xNO+NXzrxE0=
Message-ID: <b8882b36-e3ef-424e-9dc1-564e3d1944f9@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:15:43 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
To: Baoquan He <bhe@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-2-chenste@linux.microsoft.com>
 <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
 <Z9ovT3CnxBqN+cKI@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z9ovT3CnxBqN+cKI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/2025 7:43 PM, Baoquan He wrote:
> On 03/18/25 at 11:10am, Stefan Berger wrote:
>>
>> On 3/17/25 9:04 PM, steven chen wrote:
>>> The name of the local variable "file" of type seq_file defined in the
>>> ima_dump_measurement_list function is too generic. To better reflect the
>>> purpose of the variable, rename it to "ima_kexec_file". This change will
>>> help improve code readability and maintainability by making the variable's
>>> role more explicit.
>>>
>>> The variable ima_kexec_file is indeed the memory allocated for copying IMA
>>> measurement records. The ima_dump_measurement_list function calculates the
>>> actual memory occupied by the IMA logs and compares it with the allocated
>>> memory. If there is enough memory, it copies all IMA measurement records;
>>> otherwise, it does not copy any records, which would result in a failure
>>> of remote attestation.
>>>
>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>
>>> ---
>>>    security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
>>>    1 file changed, 24 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>> index 9d45f4d26f73..8567619889d1 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -15,33 +15,41 @@
>>>    #include "ima.h"
>>>    #ifdef CONFIG_IMA_KEXEC
>>> +/*
>>> + * Copy the measurement list to the allocated memory
>>> + * compare the size of IMA measurement list with the size of the allocated memory
>> Compare the size of the IMA ... memory.
>>
>>
>>> + *    if the size of the allocated memory is not less than the size of IMA measurement list
>>> + *        copy the measurement list to the allocated memory.
>>> + *    else
>>> + *        return error
>> If the size of the allocated memory is not less than the size of IMA
>> measurement list, copy the measurement list to the allocated memory, return
>> an error otherwise.
> Ack the suggested change.

Thanks for the comments.


