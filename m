Return-Path: <linux-integrity+bounces-4067-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3899C0E62
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 20:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9DD1C209E6
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DB17BD6;
	Thu,  7 Nov 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CZzNohBH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59F366
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006541; cv=none; b=AAotusFoc74XsMYpPxfWtjh7QpRwCdHLAHcJGROgpr8JkYjNxRjkionnD5jE7uG1lXLfJ3/66lI7lZCSvSL4d2bUOi2NXXMp/erl2hgvka3F4wVjn/0B3UWLGn5+Tn0HF6rR0nlaie1GsT8GB5KSTcNsQEGlcUMSQ2tENzWSYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006541; c=relaxed/simple;
	bh=H983ZH5ZKMpIFzHUp22HMqpZWCR/35GHTUfIgl/UDRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQKLap46oXnrdItApW+Q8g2uzafRyR9vmFZzHm86ODdtQe9PFr1Wl9IS6U+d6OrtNpDW0kf5BEYM/vLlKltp97QQt6Z36uSfjjDIH/ojPOK5ZT8FCWF71FQxLOlDtEK4cklotq80qfRmrCeOYw3x5RpgTduN+V5aqe0ObA8p/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CZzNohBH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IeGPM018041;
	Thu, 7 Nov 2024 19:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BP4BWq
	WoIh3khczNl1ykLy4vzRr4wJcUQF1HqAdiCcM=; b=CZzNohBHdNoCQTSAn5VB3I
	QgpKCm6urTZXSPwBgwsu0GsayW2NyRFyBWkYmoGnI+xeY+ToRQmkUfFLJm7AGRLB
	Pp0gpsMVP0ScfuZDJQ7bqXQhUbPKAKWFRhwY8azlFA6hnjx83soFWlxU4C7x38+q
	qG9bFO3SzozWvUDADefpkVBDO9beXfUL9+Y7VF9p3hWe7DOR1+L9f258M9RXSqSW
	YkST7xDxazHPL2lD83r0iQpBeEkKgtPGh17CeBcOvKEkHQCXFdJNEZ80nEl/iDOF
	ivpMlE8av0um8J/NFP3r7JfZJ7LierZW3FnwHWGGrE14XugFwyEksBhhEFq6/ZTA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s319g48y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:06:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7J5ieG005382;
	Thu, 7 Nov 2024 19:06:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s319g48n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:06:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7INX3E024174;
	Thu, 7 Nov 2024 19:06:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxt01x2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 19:06:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7J6sfE47907086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 19:06:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B84DD5805E;
	Thu,  7 Nov 2024 19:06:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CA9A58056;
	Thu,  7 Nov 2024 19:06:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 19:06:53 +0000 (GMT)
Message-ID: <262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
Date: Thu, 7 Nov 2024 14:06:52 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
To: Takashi Iwai <tiwai@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        Andy Liang <andy.liang@hpe.com>, jenifer.golmitz@hpe.com
References: <20241107112054.28448-1-tiwai@suse.de>
 <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
 <878qtvi5he.wl-tiwai@suse.de>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <878qtvi5he.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mjmWTCbx_gr3QOkN4L5gd7e7AAAnSSR0
X-Proofpoint-ORIG-GUID: iGvwL9T9dldZkXIhC0as6-tXukL0Rapw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=753
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070145



On 11/7/24 7:38 AM, Takashi Iwai wrote:
> On Thu, 07 Nov 2024 13:17:33 +0100,
> Paul Menzel wrote:
>>
>> Dear Takashi,
>>
>>
>> Thank you for the patch.
>>
>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
>>> The TPM2 ACPI table may request a large size for the event log, and it
>>> may be over the max size of kmalloc().  When this happens, the driver
>>
>> What is kmalloc()’s maximum size?
> 
> 128kB or so, IIRC.
> And according Andy, the table can be over 4MB.

Can you copy the contents of the file on that machine and tell us what 
size it has:

cp /sys/kernel/security/tpm0/binary_bios_measurements ./

I wonder what the BIOS on that system writes into this file and wouldn't 
exclude a buggy BIOS indicating wrong size and producing a much smaller log.



