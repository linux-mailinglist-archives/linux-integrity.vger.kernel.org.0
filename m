Return-Path: <linux-integrity+bounces-4099-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C69C6747
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 03:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660D81F23E29
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C41713AD18;
	Wed, 13 Nov 2024 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hN2lgidy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E313AA47;
	Wed, 13 Nov 2024 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464914; cv=none; b=JzMratUbwP3s4LTmnAeXqkiSLx3HECdJo7HFwTr8AGT0tSdOFWKpI+EX4saxibH7gVhyrgOC462E1uRKR5srkQS1GiSREvUM5J3JhvaaowE+MCTb+n6GpuXSlQjbalIAnFOj7Lj8b56bmTwASAGdMzYMpq5OE9MWjuV9HM/mxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464914; c=relaxed/simple;
	bh=wa2vKLc8/54Rdf4o1x2MySDUsH/51w+TYLkh+/ysP28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8lvmpzi+2MzCvXcYuYmtwcjFGDzbmfcC3UMbZRolAddGmeIfnJnvClj6eU8It2LI/BmK+HEixjyThAjc7JmjNfNEdX/Fz27yA2IB9ejy4N2TV1T9ytpTpzWMD0OBr0UIyLDDBPH8ScgsIUxTgtbvyH1tXKzQTSHvuterLLB900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hN2lgidy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACNePGF008839;
	Wed, 13 Nov 2024 02:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZW+lut
	UDGZ1CNRlnvVZZW3gfm5VnoL6QBYI6HJevgIk=; b=hN2lgidys7IPBfwYmrj/ca
	2PYx5EQNXget+kLNjbHzadjlPRf6iwuMwAiGhETpz36X0qJ09R6j/an7dHXSo76q
	reh6bDR7wx8fFxanITDfeuY8aa0bZnECDViowc/s+QUiZizhXVGEG/TafB+18l9k
	rnlPsjI3ZKsn0DAGLOgT1ZP/hb0fqs1UnVuh39sKDcam05yQkTm5vdN+98B/OR5K
	32eF+1eJwQo/4h85lGULMR49WGcDnzCci2BbdQbYZFwLMxBRpNLn5YHC616/oXpl
	aW4rgEZ7L4c/Y54/WKYbxlrutjZ8TZy25NX0iPaZYfgqc6mrM5Uo0zjhBMW51Ywg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vgw0rf7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 02:28:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACH7awZ017527;
	Wed, 13 Nov 2024 02:28:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2mwcke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 02:28:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AD2SJZb23069196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 02:28:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60CC758052;
	Wed, 13 Nov 2024 02:28:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2EA758056;
	Wed, 13 Nov 2024 02:28:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 02:28:18 +0000 (GMT)
Message-ID: <e72ec14c-1593-410f-a4ed-a5583b36fc7c@linux.ibm.com>
Date: Tue, 12 Nov 2024 21:28:18 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ima: Suspend PCR extends and log appends when
 rebooting
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
References: <20241112165206.756351-1-stefanb@linux.ibm.com>
 <a616939fa13b9e01b9cb6be68246152772944a76.camel@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <a616939fa13b9e01b9cb6be68246152772944a76.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0BUGPbaJKm_mlzuTJyXW63wYqX68YttS
X-Proofpoint-ORIG-GUID: 0BUGPbaJKm_mlzuTJyXW63wYqX68YttS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130017



On 11/12/24 6:42 PM, Mimi Zohar wrote:
> On Tue, 2024-11-12 at 11:52 -0500, Stefan Berger wrote:
>> To avoid the following types of error messages due to a failure by the TPM
>> driver to use the TPM, suspend TPM PCR extensions and the appending of
>> entries to the IMA log once IMA's reboot notifier has been called. This
>> avoids trying to use the TPM after the TPM subsystem has been shut down.
>>
>> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
>> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19
>>
>> This error could be observed on a ppc64 machine running SuSE Linux where
>> processes are still accessing files after devices have been shut down.
>>
>> Suspending the IMA log and PCR extensions shortly before reboot does not
>> seem to open a significant measurement gap since neither TPM quoting would
>> work for attestation nor that new log entries could be written to anywhere
>> after devices have been shut down. However, there's a time window between
>> the invocation of the reboot notifier and the shutdown of devices in
>> kernel_restart_prepare() where __usermodehelper_disable() waits for all
>> running_helpers to exit. During this time window IMA could now miss log
>> entries even though attestation would still work. The reboot of the system
>> shortly after may make this small gap insignificant.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.  The patch looks good.  Based on the updated patch description,
> I'm wondering if we should be testing the "system_state" instead of registering
> a reboot notifier?

That's a possibility and would definitely be less code. I don't see why 
not...


