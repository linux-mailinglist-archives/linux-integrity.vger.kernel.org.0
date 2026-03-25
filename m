Return-Path: <linux-integrity+bounces-9086-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGZ8HRQfxGmZwgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9086-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 18:44:52 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CAF32A0D4
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B64303A84C
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417EA3FF896;
	Wed, 25 Mar 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fGmaK7d/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7A3E4C7C;
	Wed, 25 Mar 2026 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460269; cv=none; b=SLe9uL/4ENitfsLhAYWDcSSa6qG3AbSCW6OMdm+YV92OvKhB2/TSJiiDtMPPHG36lg+585/xaVHzLzXRfwxPxDWI6t2SEfgqaTJKmph7vcuqupDiV6sSK3fu4K6A22HJP2V/mjdmPd/X/7wyfAlb2zUPOUFJRexha7UZqZMAPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460269; c=relaxed/simple;
	bh=IX7lLf0rLEDKjMn+3/xOxsIZdnRPyT+l1TSz6epGW5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHRFgJzFlqTLEKkw/A4PPWHc7DM25UXeyYt9pEU5BeKXupw6rq8Om8dJ+7f0aWo37Zg0se2P44HssxaGibvvSxh6DPzPXpLcgRFftnd/gX1aogkotn0JVReklNTwd1syPY9VbGs1Hih88zLUPRa1wj5PQlMZ9qFuSulF7VQIv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fGmaK7d/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBUg5a510428;
	Wed, 25 Mar 2026 17:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f+1aLs
	Jr5NCVbysTUv5FcRFcQIIeNt5La94FLdZ5KHg=; b=fGmaK7d/amG280ScIRKHtj
	AwpO53K2Dr7d5zI++PyUnh5Pkp9co7HvQtMD3jX+KkooxfL4ekc5d4KOCjoOb/sn
	qEj2BxgxoMoLx2HZG+Tr1cKedpUQlENyDASZgwVx0ql2MZJws05LRGvAdE8rhqJz
	xbHG375afhxzgTmvvHhHpjiG9f5Rg1+AbdvUOOj1E6cJp9AdgGg2MQuWyOiJjbFE
	nuVdLR4fhCnWfVQqPGG0MgdfYhDHmehFbfdb5OlrCljvTScXBMmAz5o7m0O3ZL4f
	W7NU92XUCwWPir0gXmxReR+YDy5bZsriy35E8xuy1GaQ/01gaKms0NBZo0+5SsHg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa1p4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:37:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFAhcT005983;
	Wed, 25 Mar 2026 17:37:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yqp3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:37:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHbYsA31720096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:37:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D7558067;
	Wed, 25 Mar 2026 17:37:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DF1B58052;
	Wed, 25 Mar 2026 17:37:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:37:34 +0000 (GMT)
Message-ID: <6849d94f-6295-486d-aec2-0f2942539b33@linux.ibm.com>
Date: Wed, 25 Mar 2026 13:37:33 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] integrity: Allow sigv3 verification on
 EVM_XATTR_PORTABLE_DIGSIG
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        roberto.sassu@huawei.com
References: <20260325001051.754093-1-stefanb@linux.ibm.com>
 <3f9e7aa4e22ebaf38735a74b1912cf4601535791.camel@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3f9e7aa4e22ebaf38735a74b1912cf4601535791.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CCxWdeRkKEloOIJW0Hm8EWxzqXGqqAbL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyNSBTYWx0ZWRfX2YUrvWyIKgJi
 zVnEnhxLUOjhI34QhZ41H8O+xnzYO46EaiCQDin9eSD62Y9QSO0sHAUC3TzotAdmSI5ETJV0CDp
 ZZYTsjDLLqhNhWk/I/pN6uOoXYtZDme5qqyeoEIGE0ClPgPc137CNZdUq7lIchCn5Nfxdhnca2a
 C3zfNfeT5eMmF+H8HXpLmlQav7AKYOFTHfPsVapbtYdnpqpZeB4ORka84WdJnX1Gwn+F2Ig+5rk
 7DvaSv9yGswp/GQ6HmgljOXYnu/65e1ZyauPU+I6kCr9iST3ZsFAG9mZvWUIGkUrC1E6++ldmS5
 BGkkQwGA3ikM5YYkztid2Am33fX7mqh6aOtCBiTlhIkrMMniq8gF686Roo8WJBe7DHa2sHNoSbg
 zpT6WUNLbLkNLHwoh52n+9VrGth8pzlr1cSoV7kW0YXRDoVs49HcjK807YTJ6/wMwYbtfEZ6JAa
 e8bvVS4DQ3bxl9Xrniw==
X-Proofpoint-GUID: CCxWdeRkKEloOIJW0Hm8EWxzqXGqqAbL
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c41d60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=MVb0JHh8QJaILyxmr3AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250125
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9086-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D6CAF32A0D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/26 10:56 AM, Mimi Zohar wrote:
> On Tue, 2026-03-24 at 20:10 -0400, Stefan Berger wrote:
>> Allow sigv3 verification on EVM_XATTR_PORTABLE_DIGSIG on RSA, ECDSA,
>> ECRDSA, and SM2 signatures.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.
> 
> IMA makes an exception allowing an EVM signature in lieu of an IMA signature,
> when there is no IMA signature.  If the IMA policy rule requires an IMA sigv3
> type signature, then EVM should also require a sigv3 type signature.
 > > Currently any EVM signature type suffices.

Agreed, though it seems to be a problem that also exists with EVM 
non-portable signature, which should have a check. I cannot create them 
easily in my environment, so I cannot test with them.

Passing the flags from IMA into EVM is easy. What is a bit more 
challenging is the evm_verify_current_integrity code path...


> 
> Testing results:
> 
> #  EVM v2 type signature, with IMA hash (improperly succeeds)
> evmctl sign --imahash -o --hashalgo sha256 --key <key> filename-v2
> 
> #  EVM v2 type signature, with IMA v2 type signature (fails properly)
> evmctl sign --imasig -o --hashalgo sha256 --key f<key> filename-v2-imasig
> 
> # EVM v3 type signature, with IMA file hash (succeeds)
> evmctl sign --v3 --imahash -o --hashalgo sha256 --key <key> filename-v3
> 
> # EVM v3 type signature, with IMA v3 type signature (succeeds)
> evmctl sign --v3 --imasig -o --hashalgo sha256 --key <key> filename-v3-imasig
> 
> Mimi

