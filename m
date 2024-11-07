Return-Path: <linux-integrity+bounces-4068-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D3B9C0EFC
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 20:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115D52847A0
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B0219498;
	Thu,  7 Nov 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pjfv/yDA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC021791C
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007917; cv=none; b=phLM/vbuxZ/ATCuQayEmhIFqHF1OaVD+KSowO/XHyQbH92e2fyF8Q+vKAQzhDbSllhboog7satzXy4/6FfdOsAj86BWupZZI2t5lt/z85cfiG06DFg6IloYT6Au6WhT1/A85maztJ8O0/Keyl0wxIZgnIZNNAYh3MVdTiE1weoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007917; c=relaxed/simple;
	bh=xix7CsVBpMSN92MoSVkenNnycQCyG41MAKgMQInTTKk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ekhr+NeegoSA0zFFYm5wS7JNN7rDeJzM/vne+xqSP8dQCdJAk9rtXL5BiVwVVtNAZkUeSornLHuBxYH0XPs8pexswIJJtIBBSc8SNwOo5eH6Gm4EXzNQtSaZbwUrHzsDNgWYY8McnA6wxsUjk6Uy+jPPZJ4UQKVtVuNRltcInwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pjfv/yDA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HdvYh005310;
	Thu, 7 Nov 2024 19:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TqQdL5
	LuzhWBCTunt7fC/cWgB2GmuNEIT/aF7SlFW2E=; b=Pjfv/yDAOM+O5AFRQprjLj
	oDmnrbXEp5G1ZQbH54xjHkX4D+1NpjEBHVYgK6ivtf/J793uLeDi3sL64mH7f4yN
	B1Vxw7ZYTZ3/6DaTZRNbtyEFqQU85Zq8ERdUfbbd0V/uecWJhvfj7gsGR2rudA5j
	bMm5QIn79bqGwIMdsQ8KWzfBSy8zmm75aW2HRsKoSMskbYdOErmrP6lhReWklgvk
	Vj7D3u41vHgSSh2FbX47M51SMw9VlbKeyIjN/bQiK0WM8lu2IFiGGKXqCugV1M/I
	6pixEvy107wAdpcNmQQIzflfJiICm63OhmhnmB93fYSBSv2GHPAQ9bKyqBStbWWA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s2588g48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:31:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7JVdAG014063;
	Thu, 7 Nov 2024 19:31:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s2588g44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:31:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DeMFJ019096;
	Thu, 7 Nov 2024 19:31:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj8r2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:31:39 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7JVcVu20185648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 19:31:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BC515805A;
	Thu,  7 Nov 2024 19:31:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B82558062;
	Thu,  7 Nov 2024 19:31:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 19:31:37 +0000 (GMT)
Message-ID: <92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
Date: Thu, 7 Nov 2024 14:31:37 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
From: Stefan Berger <stefanb@linux.ibm.com>
To: Takashi Iwai <tiwai@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Andy Liang <andy.liang@hpe.com>, jenifer.golmitz@hpe.com
References: <20241107112054.28448-1-tiwai@suse.de>
 <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
 <878qtvi5he.wl-tiwai@suse.de>
 <262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NY_62kk0gmvulqL-UKCetIeIoesuEfrN
X-Proofpoint-ORIG-GUID: GkTq9OvhUHa0VmBe7sioucFi0SqFoKzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=814 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070149



On 11/7/24 2:06 PM, Stefan Berger wrote:
> 
> 
> On 11/7/24 7:38 AM, Takashi Iwai wrote:
>> On Thu, 07 Nov 2024 13:17:33 +0100,
>> Paul Menzel wrote:
>>>
>>> Dear Takashi,
>>>
>>>
>>> Thank you for the patch.
>>>
>>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
>>>> The TPM2 ACPI table may request a large size for the event log, and it
>>>> may be over the max size of kmalloc().  When this happens, the driver
>>>
>>> What is kmalloc()’s maximum size?
>>
>> 128kB or so, IIRC.
>> And according Andy, the table can be over 4MB.
> 
> Can you copy the contents of the file on that machine and tell us what 
> size it has:
> 
> cp /sys/kernel/security/tpm0/binary_bios_measurements ./

Actually, you may need to have the contents parsed by a user space tool 
since the driver does not detect where the actual end may be:

  tsseventextend -if ./binary_bios_measurements -sim -v

This may give you a feeling for how much is in that file and then you'd 
have to truncate it into half for example and see whether it still 
parses the same. My point is that we haven't seen such excessive-sized 
logs so far and following the parsing above we may find something like 
this more useful than allocating possibly large amounts of memory that a 
buggy ACPI table indicates (+ notify manufacturer):

   if (len > MAX_TPM_LOG_SIZE) {
       dev_err(&chip->dev, "Truncated excessive-sized TPM log of %d 
bytes\n", len);
       len = MAX_TPM_LOG_SIZE;
   }

If you send me the log I'd look at it.


> 
> I wonder what the BIOS on that system writes into this file and wouldn't 
> exclude a buggy BIOS indicating wrong size and producing a much smaller 
> log.
> 
> 


