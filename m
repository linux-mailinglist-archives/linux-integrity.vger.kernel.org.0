Return-Path: <linux-integrity+bounces-759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026F82C4A7
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC061F2239C
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C422626;
	Fri, 12 Jan 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NNjnAYa7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185F17540
	for <linux-integrity@vger.kernel.org>; Fri, 12 Jan 2024 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC05820B3CE1;
	Fri, 12 Jan 2024 09:26:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC05820B3CE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705080376;
	bh=KbxatyazcGOb5nVqjoWrzE226sOvTe/q3xt20G4j/YQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNjnAYa7dcmhzXN7wy7JcWFS/2uApgDBtTWnXOtv+Q8Hxtkf8v3wL+QrK6p7iHJYR
	 68TBJoI8PALpcCVnvowTMykrVzELltaSIcSUp632A8ZSmvs3ji1xUZJNPgHB0FbyGJ
	 LeMkB9++4X88Gfj4MeZh/KIH2yv/V9uNaTdCIpE0=
Message-ID: <30910120-2a44-46fd-b8d3-c7bff38b6269@linux.microsoft.com>
Date: Fri, 12 Jan 2024 09:26:15 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] ima: kexec: move ima log copy from kexec load to
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-3-tusharsu@linux.microsoft.com>
 <b01df40e800ab387d43adcbb7f643bcd9f172cbb.camel@linux.ibm.com>
 <c2ec280f-4789-4654-a7b4-7a9534476173@linux.microsoft.com>
 <8f5deffb34c9a948a20e63eae44a1e3343e2ffe4.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8f5deffb34c9a948a20e63eae44a1e3343e2ffe4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/12/24 09:06, Mimi Zohar wrote:
> 
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index f989f5f1933b..bf758fd5062c 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -734,6 +734,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>>>    		if (ksegment->kbuf == pi->purgatory_buf)
>>>>    			continue;
>>>>    
>>>> +		/*
>>>> +		 * Skip the segment if ima_segment_index is set and matches
>>>> +		 * the current index
>>>> +		 */
>>>> +		if (image->is_ima_segment_index_set &&
>>>> +		    i == image->ima_segment_index)
>>>> +			continue;
>>> With this change, the IMA segment is not included in the digest
>>> calculation, nor should it be included in the digest verification.
>>> However, I'm not seeing the matching code change in the digest
>>> verification.
>>>
>> Fair question.
>>
>> But I don't think anything else needs to be done here.
>>
>> The way kexec_calculate_store_digests() and verify_sha256_digest()
>> are implemented, it already skips verification of the segments if
>> the segment is not part of 'purgatory_sha_regions'.
>>
>> In kexec_calculate_store_digests(), my change is to 'continue' when the
>> segment is the IMA segment when the function is going through all the
>> segments in a for loop [1].
>>
>> Therefore in kexec_calculate_store_digests() -
>>    - crypto_shash_update() is not called for IMA segment [1].
>>    - sha_regions[j] is not updated with IMA segment  [1].
>>    - This 'sha_regions' variable later becomes 'purgatory_sha_regions'
>>      in kexec_calculate_store_digests  [1].
>>    - and verify_sha256_digest() only verifies 'purgatory_sha_regions'[2].
>>
>>    Since IMA segment is not part of the 'purgatory_sha_regions', it is
>>    not included in the verification as part of verify_sha256_digest().
>>
>>> Please make ignoring the IMA segment a separate patch.
>>>
>> Sure. Will do.
> Thank you for the explanation.  Please include in the patch description a
> statement about the "sha_regions" not including the IMA segment, so nothing is
> needed on the verify side.
Definitely.  Will do.

