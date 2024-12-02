Return-Path: <linux-integrity+bounces-4271-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2E9E0EE4
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 23:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6CAB283DB
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77F1DF27E;
	Mon,  2 Dec 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EKSXT6ZV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B631DE3AF;
	Mon,  2 Dec 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177726; cv=none; b=IlP5CrUNI1tyklIhX4iwV1tDCY6LA1xU4J+ICPXY/LWMBbxT70FsDd7SC69M3OxTGvsB/5CWBrNHeZe4mGxHzfXQgcmnq2SKe0ZMq75eo2Vbly4Dksk6orhMMc5XBk6isgUjzezk/BzLL3L0bBvQlBnJeMJx93MP3pBtOQncTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177726; c=relaxed/simple;
	bh=q4HkAbO72lqAvSiyEaGYKu2Cqm5ciWIcD4uxttho7bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jquGyTp/qguvuTXdyA+evI7j4puukPUVegmFA3CwUqnE6a0CX/IhvJWCaOeQ3Jz7CI+ePfKhCXFmKCYdSh80O/4/gJnFiWYPC70fIdpb7jyHquw8oZFU3JkCzsaRAPnR2jqVGfLaV93WGcDCl42awRz+RDuj/pwdYS6juZ9rWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EKSXT6ZV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JIhgd020289;
	Mon, 2 Dec 2024 22:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EtSWkH
	2KGCBHcN+5Th++bxlhJSseoSqJAsaXifznjBE=; b=EKSXT6ZVjmMK1FJFVgLruJ
	kZ6W3dnSpUE06Bp70swE/QiGblnCOU09ApCMFQNcMPC6dJ1iDdcBI6s3jYLUzSwd
	DK0bVc4KGjhm3oxG0nGgbNuyQeoEHqFgFajSTzZ4aKpJN79NkqsTZmgfo5LHUi3q
	QZQ6a4r9H8otV+x4c7plnY0uVpB2LAQbMYH+Q+KQpsfSUqNgFgKdqJX/U4gVPGdU
	qFhc3oq/wRkdVwazecTAb+Hb/qamIrIF0HWTLUB9MS8nZktlg0ltc29KJ6dHTCPY
	xnlz9vluvQnjOK+Oqwwbh53HPryX+SNCxKFem2hm3MIxPuGBfCMwKURajDkZVGuA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hu4x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 22:15:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B2MEQDo014322;
	Mon, 2 Dec 2024 22:15:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hu4x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 22:15:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2L8PTq029494;
	Mon, 2 Dec 2024 22:15:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddya5e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 22:15:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2MFHuJ6095486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 22:15:17 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A080058059;
	Mon,  2 Dec 2024 22:15:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD08D5805B;
	Mon,  2 Dec 2024 22:15:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 22:15:16 +0000 (GMT)
Message-ID: <ce7fa562-7cb7-4adc-934a-560b94ce44f0@linux.ibm.com>
Date: Mon, 2 Dec 2024 17:15:16 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones since
 1b6d7f9eb150
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Christian Heusel <christian@heusel.eu>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>
 <D54YWMOV7KOO.2X0N035UHEFBD@kernel.org>
 <b3a01060-f59b-430d-afcc-48c5ec628bcb@heusel.eu>
 <D5Z62H0XCOQM.J4V5ZDH9E7C7@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D5Z62H0XCOQM.J4V5ZDH9E7C7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N2wjq-mLeF-yaiI6ysA8v9C6bzw8fhuV
X-Proofpoint-ORIG-GUID: sISoTb_AfN8h-K6JsVaQLAGKHUBp3fl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020183



On 11/29/24 9:44 PM, Jarkko Sakkinen wrote:
> On Tue Nov 26, 2024 at 1:42 PM EET, Christian Heusel wrote:
>> On 24/10/25 05:47PM, Jarkko Sakkinen wrote:
>>> Yeah, this is on the list.
>>>
>>> See: https://bugzilla.kernel.org/show_bug.cgi?id=219383#c5
>>>
>>> I had a fix for the AMD boot-time issue already over a month ago
>>> but unfortunately took time to get enough feedback.
>>>
>>> BR, Jarkko
>>
>> I'm not sure if this is supposed to be fixed, but AFAIK we hoped that
>> the patchset that was mentioned in bugzilla also helped this issue.
>>
>> The reporter said that the bug is still present in 6.12.1, so this might
>> need further poking 🤔
> 
> I'd suggest a workaround for the time being.
> 
> In 6.12 we added this for (heavy) IMA use:
> 
> tpm.disable_pcr_integrity= [HW,TPM]
>                          Do not protect PCR registers from unintended physical
>                          access, or interposers in the bus by the means of
>                          having an integrity protected session wrapped around
>                          TPM2_PCR_Extend command. Consider this in a situation
>                          where TPM is heavily utilized by IMA, thus protection
>                          causing a major performance hit, and the space where
>                          machines are deployed is by other means guarded.
> 
> Similarly it might make sense to have "tpm.disable_random_integrity"
> that disables the feature introduced by the failing commit.
> 

I am wondering what could be the not-so-obvious root cause for this? 
Could it be due to a (TPM or RNG-related) lock? I guess the audio 
popping could occur if an application cannot meet timing requirements 
when it runs into some sort of blocking lock...

> What do you think?
 > >>
>> Cheers,
>> Chris
> 
> BR, Jarkko
> 


