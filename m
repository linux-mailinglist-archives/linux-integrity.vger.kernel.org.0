Return-Path: <linux-integrity+bounces-8570-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EZoIXtYoGlPigQAu9opvQ
	(envelope-from <linux-integrity+bounces-8570-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 15:28:11 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C21A78A4
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B7D30882D6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF13AEF4C;
	Thu, 26 Feb 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnn489YU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A920DD52;
	Thu, 26 Feb 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115417; cv=none; b=tEyhYBuovji2IcsuJEnJ6hjVU0I6cNTzch73Eu8u478d87zTqXNKnCLNeUPYzd8X0f7V7PQ4OMenlVenQFtT2luhq/i9Ybbrs4U+l5tRQYkq3eOcSrkcr+3rIc/DCu0iJkIZge8pdTCs+3F7zmXtmBl3s7dg07DRzGxFs70ctKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115417; c=relaxed/simple;
	bh=E8DKflhAVL3TKeub7x1adlGOAnbNXueSf0qELTC/N+I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZE2Y3Rb2ZWx1/bd2kPuoGs0aBcVyu8x6gcx4aT+u6D0slwjd2SfFoP2Z6PT20CgXnMTUsKB94wXLQbPv4O6pVGBvnCznvNULS2wnzy0ah+cpBCJNarK8wIqC4cmttwtMkPglPcbXALsVnTi0YTLWD62Z3sk0ZakfIChYkdBQ5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnn489YU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q63mEO1361599;
	Thu, 26 Feb 2026 14:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cm/laZ
	GdtotgeWcA9ew0IQ+N4BXALkMFoQEJiztxDEo=; b=cnn489YUqixYZLjkU2KQlO
	8TMwQ2KLFJ1n4mNieHh1E874u7CVWqf9k01qtn3p/C5dn4ZPXu1c62UWFRSOo/88
	CP8fGyr+0xyeeLiNaOyQQqGMnoKrDJbsl8+8LhsWnlMGO6+VCIVuckhyZLLWsHKa
	yHik4d2wQiCP0kn0EFJcCgvepVyB7HWLB47ZjLjF/9y9E0QMloFzYB/YyotgCFzX
	fIhdEz9t+8U+QniXIeBKpH5rZcsQfP0CF/PnalvhXn/5mVBPJYSXj/hEWYlMISLU
	za87ulnFDwf1dIlX2w7+nTnfiMqsZkajQq+2fSBy0rO+6SGzad9Z0HTXpLAynFeg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34ce1e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 14:16:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QCvPoA001646;
	Thu, 26 Feb 2026 14:16:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1nbwaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 14:16:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QEGYCT16319182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 14:16:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17F825803F;
	Thu, 26 Feb 2026 14:16:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A59C858056;
	Thu, 26 Feb 2026 14:16:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 14:16:32 +0000 (GMT)
Message-ID: <dc09be79-5efe-4756-a295-5b0428985525@linux.ibm.com>
Date: Thu, 26 Feb 2026 09:16:32 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IMA and PQC
From: Stefan Berger <stefanb@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Coiby Xu <coxu@redhat.com>,
        =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
        dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        roberto.sassu@huawei.com, simo@redhat.com, zohar@linux.ibm.com,
        michael.weiss@aisec.fraunhofer.de
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk> <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
 <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyOCBTYWx0ZWRfX55CZZsp+wRNu
 EvykSJ1COzivLjDSdolsjrmXB5SyAHGcs7wBghqvvsXEiB98jPGvAoliGx7hgnu8AuFQh+Bsj5s
 oSSF3y8G30bWlWX0qHYKrikCS/B4s2uVTe3Nw+A+IPJY/LOVK57fS2+txUAOP0TSuzsYyAydQDp
 lwYFDN+HRxw8MS9EuOCK6jpj69/kePlUPhqWUWiIeVc8j3wTzO1RmkF2VUXoTOYK01ULeoNQR70
 H7qgvnx6pG+lu+JjLDyAZFbDFausDtgCZGcVhkn9GlauWc7yNKmp8Li4iCljN5sR/rtvuTBxXp7
 oFvYvfFa2wlWfVxSTn7pvlKr8j4TzWNliUdjuuObcGt6wWEU55/NtvQf5zFBdmX9+ICr3VQgUoa
 P3qgmb833eV+mmEvzPQOLXIdBXnEmRNrnaUOjM/YKL6Bka4hhCW/br7NGKuOPeZiFPgVwlrjyNp
 SsPWRidSJG5WOkP/IMw==
X-Proofpoint-ORIG-GUID: vKkRArfHCBC2sY0dOEq3UVMMthAC4oCz
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a055c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=or4u6VGYAAAA:8 a=0-tci4tB3JD_nLbTkkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=f52p4T1hNPgkgD0SKpRM:22
X-Proofpoint-GUID: auGwW4fRF8eMQ05GAA8LePE63cIzrQgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260128
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8570-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keymaterial.net:url,linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 374C21A78A4
X-Rspamd-Action: no action



On 2/26/26 7:42 AM, Stefan Berger wrote:
> 
> 
> On 2/25/26 7:10 PM, Eric Biggers wrote:
>> On Wed, Feb 25, 2026 at 09:25:43AM -0500, Stefan Berger wrote:
>>> To avoid duplicate work: Is either one of you planning on writing 
>>> patches
>>> for IMA to use ML-DSA and convert the current ML-DSA to also support 
>>> HashML?
>>> I had done the work on this before and could dig out the patches 
>>> again...
>>
>> IMA already had to add its own digest prefixing support, since it was
>> needed to disambiguate between full-file digests and fsverity digests.
>> See 'struct ima_file_id'.  Thus the message signed is at most 66 bytes.
> 
> The hash there is still only a hash over a file and that hash is signed, 
> isn't it?
> 
>>
>> With that being the case, HashML-DSA isn't necessary.  It's not even
>> possible to use here, since there are no OIDs assigned for the fsverity
>> digests, so it cannot replace the ima_file_id.
> 
> For non-fsverify IMA signatures it is 'possible' to use HashML-DSA and 
> it's 'working' (recycled old patches yesterday):
> 
> Linux: https://github.com/stefanberger/linux/commits/ 
> dhmlsa%2Bima.202602025/
>
> ima-evm-utils: https://github.com/linux-integrity/ima-evm-utils/pull/19/ 
> commits
> 
>>
>> I'll also note that HashML-DSA is controversial (e.g. see
>> https://keymaterial.net/2024/11/05/hashml-dsa-considered-harmful/),
> 
> The problem with this is that NIST would have to react to these 
> controversies as we race to support PQC. If something is wrong with the 
> standard then it would be best for NIST to withdraw/modify HashML-DSA 
> asap. Otherwise it's the best to follow the standard IMO because if you 
> don't you get criticism otherwise.

What I am not clear about from FIPS-204 is whether availability of 
HashML-DSA is a "must-use" or  a "may-use". What speaks against it for 
our use case is performance. The lookup of a hash's ID (last digit of 
OID) and the creation of the 11 byte encoding to prepend before every 
digest for every signature takes cycles.

Maybe it should explicitly state in FIPS-204 something along the lines 
of "with a given hash either ML-DSA or HashML-DSA can be used (for as 
long as you use it in the same way from then on)." At least this way 
nobody can point out that HashML-DSA should have been used when you didn't.

> 
>> since it was added to the ML-DSA specification at a late stage without
>> sufficient review, and what it does can be achieved in better ways.
> 
> In case of doubt I would use the standard, though. It's probably not a 
> good idea for everyone to implement their own (bad) solution.
> 
>> Which is exactly what we are seeing here, since again, IMA needs to do
>> the digest calculation and prefixing itself anyway.
> 
> Use the standard...
> 
>     Stefan
> 
>>
>> - Eric
> 
> 



