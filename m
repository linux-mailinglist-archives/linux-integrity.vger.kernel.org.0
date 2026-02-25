Return-Path: <linux-integrity+bounces-8555-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCEdIJgGn2neYgQAu9opvQ
	(envelope-from <linux-integrity+bounces-8555-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 15:26:32 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965EE198B51
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E4DD302AAF9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F73D3494;
	Wed, 25 Feb 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsNiwTj1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E43AE703;
	Wed, 25 Feb 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029573; cv=none; b=kS8WZddesmNT2yI2VuyVxp+Y+qWy/5Oyqvd7BfDk6rW/y4Ok1gakVfIQ+zFb/nIqx7khEAPVQWY2DVuTIK0/59q8aaOXHT8YhLrVSaymQ47MPfT3mWuF+p181OrJ5aeDtHM5Qaf3KqeB4NoUfbH83brXWu4AYuGcrraTwgTsNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029573; c=relaxed/simple;
	bh=POFnvDRMDntoaKYYUzHLozgduV3d4+IdNOY4m5PKl4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpuBSqRNjCqpvw75mx+27DC39Ho/31gJmtWZZAVdwpY2kZIq0vOOjXHSokGxIxm5UJYBEjrsWOpXNtRvZct+CK1fOflRNcXNDbmef4P/JcRmgS749V7IuaswcUIe8ZEBWw+mvD7qaFwbtVwnb5be01dv5Gs7kR43d3ln6oDyJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsNiwTj1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PCEjjX2347293;
	Wed, 25 Feb 2026 14:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SHMqjR
	5JS4nc3Prvtwcb2C6pncruxyqQAeH0T5Ewzhc=; b=jsNiwTj1A5DYsXEXoJqQA+
	0TkBYk8v4ot1xoL3Bwy4ILnhsF88j1eSNeasaj7/PbWXz+Rnl6C1t9ZSwEdBywWg
	JgOfwI3RJ/oWs/RKCGbZG5tr5Bf/tt6aJQKBcE9NeK+xfn3mLq0Hc+3HvgxHzNmV
	Q39bihEexZoJBf1/yTVB5GSmjtQZcBkKNVInTo13tLucZ8oOruJw88LmIm1E8UJN
	+cvUJUgOzhguOCNKvqXjvZH4Jatk79gbeiCNrg+cbWIEY1YZzyMHkgK1rx7qHkf/
	qBQAq005yfS4e3yda9rUZvRmEpUNOI1KoduOTuHOULaoSH7fLhdWQBKV1/3IFq7w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858p0s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:25:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PDp8Si027794;
	Wed, 25 Feb 2026 14:25:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1wcej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:25:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PEPiLj30999090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 14:25:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AA9958059;
	Wed, 25 Feb 2026 14:25:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F0558063;
	Wed, 25 Feb 2026 14:25:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 14:25:43 +0000 (GMT)
Message-ID: <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
Date: Wed, 25 Feb 2026 09:25:43 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IMA and PQC
To: Coiby Xu <coxu@redhat.com>,
        =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>
Cc: dhowells@redhat.com, dmitry.kasatkin@gmail.com, ebiggers@kernel.org,
        eric.snowberg@oracle.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        roberto.sassu@huawei.com, simo@redhat.com, zohar@linux.ibm.com,
        michael.weiss@aisec.fraunhofer.de
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aYHznG6vbptVOjHQ@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzNSBTYWx0ZWRfX3qP5/QR4NiU0
 GOqGnNq7OdR6+Ew1H+Du8EZdvcu3XXvpqnjEgNAZOC5+zqjVH1bB6TOMKI753jx9CE4m7sbsGMJ
 JCiR9f2di7zqlSf1n1bNe0JyN6R0y7SQM4fu6Jz/q3fBMhxh5MqMVIPeMXLF5tNc+INOrewy31B
 IcvAZ8sK+vkSS8VYWhMBuLb4VpEQhWQ+TEiu/9GKn5JjBincwgzgDCk3a1ir09xfmGqTL/Q6OIo
 3YFKUEckgUnAFInxMCm/8Xt/+23R0ZmVXrut7aldZnp4u3tlNRJR0kyz54WSNCQhnE2XTJ3uDUt
 ei0IzhDuYrxEjdLXe2gpIsv64EGlWXZNuAtdfvJlPF9ks2bY1zhu/eTqDSq6eAhxhVK+iS6KCDW
 PSR+3/7xvNNs5cNDRCCtBX0XxBllt0uXCLoCQSHmHEbj34VVi8qCuxWcZfDsyx6vGnSHty2wsTo
 FwLd8a+eDi/0WjgiUjA==
X-Proofpoint-GUID: NgaRPDtkcA5qlnwKN1z91muvBPFRyMN8
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699f066a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=8AN272uGgGVaRbb4kAAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a5T0_K3QU7mjD237BGpEkprt9BYz8mkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8555-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com,aisec.fraunhofer.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 965EE198B51
X-Rspamd-Action: no action



On 2/3/26 8:32 AM, Coiby Xu wrote:
> On Fri, Jan 30, 2026 at 09:31:26PM +0100, Johannes Wiesböck wrote:
>> Hi all,
> 
> Hi Johannes,
> 
>>
>> we conducted an evaluation regarding PQC use in IMA last year (see [1] 
>> for all
>> details) where we also considered the interplay of different PQC 
>> signatures and
>> file systems (ext4, btrfs, XFS, f2fs).
> 
> Thanks for sharing this comprehensive study! There are many nuances in
> this research paper!
> 
>>
>> Coiby Xu <coxu@redhat.com> wrote:
>>
>>> According to my experiments done so far, for verification speed,
>>> ML-DSA-65 is consistently faster than ECDSA P-384 which is used by
>>> current CentOS/RHEL to sign files in a package.
>>
>> Regarding performance, similar to Coiby, we found that all variants of 
>> ML-DSA
>> consistently outperformed ECDSA P-256.
> 
> Glad to know ML-DSA is also faster than ECDSA P-256!

To avoid duplicate work: Is either one of you planning on writing 
patches for IMA to use ML-DSA and convert the current ML-DSA to also 
support HashML? I had done the work on this before and could dig out the 
patches again...

    Stefan


