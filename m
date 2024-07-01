Return-Path: <linux-integrity+bounces-2959-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A562D91E79D
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 20:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA58281FF4
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E416F830;
	Mon,  1 Jul 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I4cOk3eM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C016F0CB;
	Mon,  1 Jul 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858602; cv=none; b=M6101kmaE3zsewxOPDSnKiefwQ0guKM4TrI3hjNo/D7TwwgbVSPxiddXEAAXH1ne0ljoFdwvFJjx0gQSm0jvb8qtiqhfMqbYg+2O3RMN7WmbKw1hft0JMrKOzouIIoIRdgK496WsuqR2xbnKxphv8aEDFxqU27JcKTk/OAy4FYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858602; c=relaxed/simple;
	bh=3S2ICPf18exw28+3T4mdb3eom9LuI6fEgQhS5aTgFec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DboAHt+JnxxiODNoAigP9Sj/7xvrQRqjE+rxXgwkpDC3tpbRfvKfRVeiNRt6a2Cc+XttcK/LopscLd2M2UjqoRdRJazrmVo2amojTzpdbrNGj0/k+Tfz10K92/4yTIyq/+qvmTGk0+XPoeFLa3XDAzMwk2BrF25jHZKJBmk3Nbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I4cOk3eM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461IQpAZ023037;
	Mon, 1 Jul 2024 18:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	8M/NcLEsRj+FlvECMzLMigBD/zG81chYyCp7F5PFqCA=; b=I4cOk3eMOhM/v4Xp
	5RtQeHaUhKll9ZmTN6E5LFmSwRtwcNMlvvcT1YUa2SlAYUhGLZOr8voWFr+WZ81b
	C5G4HQmoMVP7tGdQfIwTxO7tYucZFxEANGZOPZKIW/Jw0BbqIouH3K5xG43brGa/
	ZOdrBXZSEj/dsob8ZE8l9vx72ub1rOMYwPFgqVAHmna5Lli4/I9+MnaFPl6lZ7yU
	EDPZxyR8ugSAfM+QpKmQAhDnc2DDqGEiip1GRTyevuj8MH1BiJk/+GwwHpjbPtnk
	gXHlsB7aUGn9Ly7Bfs4r6iN/MRnmccl8apBvTTsBMOP3bKhaDBFz8WCS2Gk9WfIH
	EPT+SA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4041car1hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 18:29:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461H0Fsv024077;
	Mon, 1 Jul 2024 18:29:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya38b0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 18:29:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461ITi7325035476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 18:29:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3C5258054;
	Mon,  1 Jul 2024 18:29:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF9A5803F;
	Mon,  1 Jul 2024 18:29:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 18:29:44 +0000 (GMT)
Message-ID: <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>
Date: Mon, 1 Jul 2024 14:29:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc: naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
 <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TxbAsl9mb4epcgFCGrxx9fVFbeSNOPDy
X-Proofpoint-ORIG-GUID: TxbAsl9mb4epcgFCGrxx9fVFbeSNOPDy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_18,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010138



On 7/1/24 11:22, Jarkko Sakkinen wrote:
> On Fri, 2024-06-28 at 17:00 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing the regression list]
>>
>> On 20.06.24 00:34, Stefan Berger wrote:
>>> Jarkko,
>>>    are you ok with this patch?
>>
>> Hmmm, hope I did not miss anythng, but looks like nothing happened for
>> about 10 days here. Hence:
>>
>> Jarkko, looks like some feedback from your side really would help to
>> find a path to get this regression resolved before 6.10 is released.
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> Sorry for latency, and except a bit more slow phase also during
> July because I'm most of this month on Holiday, except taking care
> 6.11 release.
> 
> This really is a bug in the HMAC code not in the IBM driver as
> it should not break because of a new feature, i.e. this is only
> correct conclusions, give the "no regressions" rule.
> 
> Since HMAC is by default only for x86_64 and it does not break
> defconfig's, we should take time and fix the actual issue.

It was enabled it on my ppc64 system after a git pull -- at least I did 
not enable it explicitly. Besides that others can enable it on any arch 
unless you now change the 'default x86_64' to a 'depends x86_64' iiuc 
otherwise the usage of a Fixes: , as I used in my patch, would be justified.

config TCG_TPM2_HMAC
	bool "Use HMAC and encrypted transactions on the TPM bus"
	default X86_64
	select CRYPTO_ECDH
	select CRYPTO_LIB_AESCFB
	select CRYPTO_LIB_SHA256

https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/char/tpm/Kconfig

> 
> BR, Jarkko
> 

