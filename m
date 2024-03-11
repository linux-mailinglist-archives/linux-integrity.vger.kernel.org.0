Return-Path: <linux-integrity+bounces-1710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFB878882
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Mar 2024 20:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBEB210CC
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Mar 2024 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647E5467A;
	Mon, 11 Mar 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PZMUJ6f3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7140847;
	Mon, 11 Mar 2024 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184290; cv=none; b=GeG/wfRqqok2GvN6ZanMDy9pFBRI6eW3jtSY7nrrlmtvUj5Q/FTLLCbQOtlzKFsSTmDXKJKTWMuj5weOn7eq6dRkReldEtYmgg3Au9YGH9Ti1zeX5s6bjmQFz+Ot5YEpaK9JHw/mm5r0cY5v3dIKUCN6Rpg32qZvMj1UJ2OyhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184290; c=relaxed/simple;
	bh=4LwPqX5B/kedEJN2uWC05iOjLmcODFip9S5O4WyitH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phhsMo5AbAzNYfz5CT2orzkoIYFfHR3ofo0/0j5B0ln+6CTmgJl6ynbw87FfewF1szTtHl+zbRcMqvPaYppjDkguYU4jVSLBoMm2alUSQ7KQdDuXlFOiM0aHLbqAPjwsXUyMJ7zqwlb8frhWwYRzfjAusTT7pVu+7l0UinjAxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PZMUJ6f3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BJ7luc011988;
	Mon, 11 Mar 2024 19:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cIC28NXyFQhnrE2WQSAna546CA7ZxTgRRfuoymC5yiU=;
 b=PZMUJ6f3AjMW2ZGqu1bXK12KjSIbvvGlefIKWVL4BIXvo4A/4fghfvVwFpMzv2ByyICj
 tnxi1qwYsFcCEStcZIhrIvVFbv6Z9yDoXfrPoU9UaL6qOXAyVABmZ4iO/bJhc6uTLrZv
 7LHbYthp8R0V+xAQOzoDwtEmv7aO5GEe7Jd+eTnd6AQ0HQzRwSO0bu5xwvlJ+TtWqRMk
 TdtxD5FrZ8fUL5hw7WIQhPZ2koz1tNHumrjQqgMTMy19VcwGhpySnx7w1xVNpmOih31H
 ybfrKzrMRAA6ujCJzQFOml8ZWNE4dj48Dlre8oRXGL0jCqYoLasn1Llum9h7zTXuc18/ 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt7uar1p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 19:11:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BJ98Nm016204;
	Mon, 11 Mar 2024 19:11:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt7uar1hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 19:11:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGXkRH014887;
	Mon, 11 Mar 2024 19:10:44 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33njfs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 19:10:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BJAguG46924208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 19:10:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83A3158055;
	Mon, 11 Mar 2024 19:10:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E095805B;
	Mon, 11 Mar 2024 19:10:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 19:10:41 +0000 (GMT)
Message-ID: <2c9dc099-f450-40af-9723-27ca2b69afdc@linux.ibm.com>
Date: Mon, 11 Mar 2024 15:10:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] powerpc/prom_init: Replace
 linux,sml-base/sml-size with linux,sml-log
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "rnsastry@linux.ibm.com" <rnsastry@linux.ibm.com>,
        "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "viparash@in.ibm.com" <viparash@in.ibm.com>
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-2-stefanb@linux.ibm.com>
 <0bde9a6f-e002-452e-8610-8d4040fb0b86@csgroup.eu>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <0bde9a6f-e002-452e-8610-8d4040fb0b86@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q89qBJgZ5Gn7UriGH1PV_pfbJEKXRzzy
X-Proofpoint-GUID: K94-f5m9lfd12jL9cXHK1-N4_xfkabyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403110146



On 3/11/24 13:24, Christophe Leroy wrote:
> 
> 
> Le 11/03/2024 à 14:20, Stefan Berger a écrit :
>> linux,sml-base holds the address of a buffer with the TPM log. This
>> buffer may become invalid after a kexec. To avoid accessing an invalid
>> address or corrupted buffer, embed the whole TPM log in the device tree
>> property linux,sml-log. This helps to protect the log since it is
>> properly carried across a kexec soft reboot with both of the kexec
>> syscalls.
>>
>> Avoid having the firmware ingest the whole TPM log when calling
>> prom_setprop but only create the linux,sml-log property as a place holder.
>> Insert the actual TPM log during the tree flattening phase.
>>
>> Fixes: 4a727429abec ("PPC64: Add support for instantiating SML from Open Firmware")
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---

>> @@ -2645,6 +2645,17 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
>>    		}
>>    		prev_name = sstart + soff;
>>    
>> +		if (!prom_strcmp("linux,sml-log", pname)) {
>> +			/* push property head */
>> +			dt_push_token(OF_DT_PROP, mem_start, mem_end);
>> +			dt_push_token(sml_size, mem_start, mem_end);
>> +			dt_push_token(soff, mem_start, mem_end);
>> +			/* push property content */
>> +			valp = make_room(mem_start, mem_end, sml_size, 1);
>> +			memcpy(valp, (void *)sml_base, sml_size);
> 
> You can't cast a u64 into a pointer. If sml_base is an address, it must
> be declared as an unsigned long.
> 
> Build with pmac32_defconfig :
> 
>     CC      arch/powerpc/kernel/prom_init.o
> arch/powerpc/kernel/prom_init.c: In function 'scan_dt_build_struct':
> arch/powerpc/kernel/prom_init.c:2663:38: error: cast to pointer from
> integer of different size [-Werror=int-to-pointer-cast]
>    2663 |                         memcpy(valp, (void *)sml_base, sml_size);
>         |                                      ^
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:243:
> arch/powerpc/kernel/prom_init.o] Error 1

Next round will have this block under #ifdef CONFIG_PPC64.

Thanks.

