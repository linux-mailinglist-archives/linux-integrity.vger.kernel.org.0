Return-Path: <linux-integrity+bounces-2864-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B14B90BB79
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2024 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECC2284D0E
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2024 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEAB1741D7;
	Mon, 17 Jun 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ibXnG1Ve"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD24D53E;
	Mon, 17 Jun 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654203; cv=none; b=Ex8tTQ6Oenw8Lun/Otrr+M/zmNE++pWvb/09TwMF8aNzMkQCvJJpo2Fu13WqtvksPtPlxl1jbOp7aKFjeYwLWvCT+BAuzMGrBu8PGGeYaPANQGmmhq4zyeWYscxdWj8iz5MILtuo06hwFvfHWPAcUKfqEeoxschOrL30b1RcDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654203; c=relaxed/simple;
	bh=qNJkXv/wkxkDKTwXrq81qhL2hb2PzEuHXPrhbfByun0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwRaznECjfqV4yxrVJdrrBEqgZLMTeM6+zUKaTPYteE1qIId85PJ7dISCrB5s47VpZrmwB0c1APPbg4HwLaJdPVxOVJdKi59GKhj07YkJ+PxW3JHBf+7D+w25gmDPtIoIBSNJtifLjBvgMAvYSgmXL2b2+ItyyR/qurqaHf1MaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ibXnG1Ve; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HJ01b2024582;
	Mon, 17 Jun 2024 19:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=5
	gTrKfTGK7nkUx0z1WmZsTK++4OVmR4Dpoli52j9yRw=; b=ibXnG1VeyRbwgtzb9
	AJPdHgM6gn9rgUXKRMT1AcTKcVbyjtkRQOFOWk46J7gG7pwykeY/5ExqNv/uqiZ3
	lgVA81hBm2F6JDU0IY2jAEHGy0odTUTT4QqwEil0jPtVpZoftwSqQhaYRFCM6inV
	AUv7T175gsvVfCu77w3Elsx3us3w/SFwFMrP8f7/QMy3U3GVcZoqCnUasRKU/eMU
	iPcxfWhWowiK2mz+/z/AGfe3ngkaE3SHJhNtJ5+jN8dwKdXdHqIe0pCMEz0cmeY3
	mqFlgbKa4FHM2GlcKNwk6tLWLOZiVNlKzOo8hqgxqW8Z+mYOOHr3xGwSUQBPhyK9
	tOd4Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yttwc840t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:56:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HIK70b011442;
	Mon, 17 Jun 2024 19:56:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsmvtp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:56:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HJuQWT38469990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 19:56:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87BDA58069;
	Mon, 17 Jun 2024 19:56:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08CAB5805D;
	Mon, 17 Jun 2024 19:56:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 19:56:25 +0000 (GMT)
Message-ID: <5bd68636-ece6-4ba5-a4c0-c0535afc33c8@linux.ibm.com>
Date: Mon, 17 Jun 2024 15:56:25 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        naveen.n.rao@linux.ibm.com
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <dfc4feaef0d63d616bab8cdec5d409369f9dacf1.camel@HansenPartnership.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <dfc4feaef0d63d616bab8cdec5d409369f9dacf1.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R6DyKD6fRPgMFtsS9Tn2awO1IbQ2YzPy
X-Proofpoint-GUID: R6DyKD6fRPgMFtsS9Tn2awO1IbQ2YzPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170153



On 6/17/24 15:42, James Bottomley wrote:
> On Mon, 2024-06-17 at 15:34 -0400, Stefan Berger wrote:
>> Fix the following type of error message caused by a missing call to
>> tpm2_sessions_init() in the IBM vTPM driver:
>>
>> [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error
>> 0x01C4
>> [    2.987140] ima: Error Communicating to TPM chip, result: -14
>>
>> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
>> b/drivers/char/tpm/tpm_ibmvtpm.c
>> index d3989b257f42..1e5b107d1f3b 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
>> *vio_dev,
>>                  rc = tpm2_get_cc_attrs_tbl(chip);
>>                  if (rc)
>>                          goto init_irq_cleanup;
>> +
>> +               rc = tpm2_sessions_init(chip);
>> +               if (rc)
>> +                       goto init_irq_cleanup;
> 
> This looks wrong: the whole thing is designed to occur in the bootstrap
> phase from tpm_chip_register() (which tpm_ibmvtpm.c definitely calls),
> so why isn't it happening?

Because flags = TPM_OPS_AUTO_STARTUP has not been set for this driver.
> 
> James
> 

