Return-Path: <linux-integrity+bounces-4103-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE39C6F1A
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 13:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68F11F235C4
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5D1DF755;
	Wed, 13 Nov 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OPS9YKnS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511D4C81;
	Wed, 13 Nov 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501199; cv=none; b=LApALi1w79sRgBC9IOM63tITy7iG7XU+XUC9JS0M3J+zXBOam/6cPUVjeq8t9GkIwBbBFgAp7hpY6ZvQ/N08GQUbHobOwb0Z3cxbJrKNvNXLiU9v5wohfFhWd2pT+VldXg6TEWs1IMyB0l8Ma+RYkxP388QcPXOKC18MISMc+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501199; c=relaxed/simple;
	bh=ojzcGIB9941E35oVcvIXfN2E6iur5Ozi5Ww/WaflAJ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZtUMSAvx9TMaRFmxA7gdP5G061StnKAqij3OHQs3o9o3CCoTzDvNJyJxdqabkshwN9cpVCMvApzCaDVUp6ktqggHvBmHbEicJ2S6+M116qn8sR0/Qgx9eq4tAF7NXWUmf4L+G0LOdoia2UK/tmv8t5/edIXPt6efL8suVWQbpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OPS9YKnS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADBe1xQ006269;
	Wed, 13 Nov 2024 12:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Zjhyx
	wOI0fnkEYiFheXSls2X5u8cNQv20LoK+7e/aA=; b=OPS9YKnSUvnr8E36/rQTUE
	TYmYe8Svvjh9GAeoeSmeuWnAKJVRmEghq1KJ00M/9AkRPLYW5OO8m8kSITHs6p0N
	HpcaOJ308Jq59RUf38W9mMj8M1GA6jB6OyceCs31iYKOBp01QXArb7NQ80J9G3eY
	d8aBb7L5hgq6E2IK1vDgg5VkAraLWzjdI7U+TLgQouQ34MPJmltGO4ucefW8ERD9
	d185JBLNohD2cOrYFYBy6utpyRvaQ6abnOu9Yg9DhSAp+WW7KS+Jz5E9sYESOu6g
	qVeMBqdlhqNdVB/ASlY2rLPrxsaYKX2w5swEVQSRrztQ/lX5VxBsyt1bfwcZlGpg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vued87ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 12:33:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD45nlc018606;
	Wed, 13 Nov 2024 12:33:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2mx761-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 12:33:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADCX7Ed59572648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 12:33:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7748858056;
	Wed, 13 Nov 2024 12:33:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F92B58052;
	Wed, 13 Nov 2024 12:33:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 12:33:07 +0000 (GMT)
Message-ID: <7e66377e-38d6-4885-acb6-e9a72573a697@linux.ibm.com>
Date: Wed, 13 Nov 2024 07:33:06 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ima: Suspend PCR extends and log appends when
 rebooting
From: Stefan Berger <stefanb@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
References: <20241112165206.756351-1-stefanb@linux.ibm.com>
 <a616939fa13b9e01b9cb6be68246152772944a76.camel@linux.ibm.com>
 <e72ec14c-1593-410f-a4ed-a5583b36fc7c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e72ec14c-1593-410f-a4ed-a5583b36fc7c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _d7VT8Fh9J-GxNG2DEf41YAOsLdWydZL
X-Proofpoint-GUID: _d7VT8Fh9J-GxNG2DEf41YAOsLdWydZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411130104



On 11/12/24 9:28 PM, Stefan Berger wrote:
> 
> 
> On 11/12/24 6:42 PM, Mimi Zohar wrote:
>> On Tue, 2024-11-12 at 11:52 -0500, Stefan Berger wrote:
>>> To avoid the following types of error messages due to a failure by 
>>> the TPM
>>> driver to use the TPM, suspend TPM PCR extensions and the appending of
>>> entries to the IMA log once IMA's reboot notifier has been called. This
>>> avoids trying to use the TPM after the TPM subsystem has been shut down.
>>>
>>> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: 
>>> -19
>>> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: 
>>> -19
>>>
>>> This error could be observed on a ppc64 machine running SuSE Linux where
>>> processes are still accessing files after devices have been shut down.
>>>
>>> Suspending the IMA log and PCR extensions shortly before reboot does not
>>> seem to open a significant measurement gap since neither TPM quoting 
>>> would
>>> work for attestation nor that new log entries could be written to 
>>> anywhere
>>> after devices have been shut down. However, there's a time window 
>>> between
>>> the invocation of the reboot notifier and the shutdown of devices in
>>> kernel_restart_prepare() where __usermodehelper_disable() waits for all
>>> running_helpers to exit. During this time window IMA could now miss log
>>> entries even though attestation would still work. The reboot of the 
>>> system
>>> shortly after may make this small gap insignificant.
>>>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Thanks, Stefan.  The patch looks good.  Based on the updated patch 
>> description,
>> I'm wondering if we should be testing the "system_state" instead of 
>> registering
>> a reboot notifier?
> 
> That's a possibility and would definitely be less code. I don't see why 
> not...
> 
... the missing synchronization with the mutex speaks against it. If we 
don't have it we could try to use the TPM subsystem after it's been shut 
down.

