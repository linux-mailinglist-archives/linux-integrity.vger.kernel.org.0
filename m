Return-Path: <linux-integrity+bounces-8647-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O3BAzWJoGlvkgQAu9opvQ
	(envelope-from <linux-integrity+bounces-8647-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 18:56:05 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C18311AD09B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 18:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B0330300C8
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF553290D4;
	Thu, 26 Feb 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aeZK+BM6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4A3290AE;
	Thu, 26 Feb 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126941; cv=none; b=GLH6o66NebAqSimhTuPIcDHr8PDrDfp2CL2q5dRdMF1Ut7ZJMQQ2wes5Nf4RRhSUsvkT5q14u1mkmCUSlFaYq0f9660Vg3PA7WX/u4p0spTKsJf854zarqAj5shH1az/GO0Roijsxbzu2kNQxu+5b1YxWUw1PfSuam0xlwqPrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126941; c=relaxed/simple;
	bh=bjaNKFkzHoUI+kWr67zSeFe+Bb6StP2VQr7jdluS3Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXv6jwAGD8Kvv/xR6OaVzATsCzX1QF0fHLCaR+ASOaVkmKx7ZEYl9Q4u22ONsxyBynjqdj849tyI5hiTDUdSIcNnKmprwObEthnKfnu6i4hNsbp9r54TwrlHGWtzbGJS7aYcLai4qPopG2UfW2hn8gRzcmpyymN7POOTlqAXp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aeZK+BM6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDHKel2345995;
	Thu, 26 Feb 2026 17:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D1o3ev
	FHvAD1MYwkO3j4sN6+RY/qe+ugyNzSt+LRcek=; b=aeZK+BM6j5SlrEEE0NyS4a
	lO5222pxrMIv5bnNGQyfJGCP8IOJ8pl1IemGYpLP3Abtt2cOJszHH81ZHGVTh5x4
	Wb1LBqHKNB53PKm6dF5dr6PbLpzzKCqVtcAOXor/Wq0nHgZujCOPLU8j3lmCXxEt
	ez9/nV0LACYmHwFbD1ckQkCLVBQLXBCX9jyJ/EuUFRi7kprFIFxT/6rSmtdASBHY
	NOaMJDpZ1Adlde9LOJxBH5BeZg59rX84UwXM64p2XI6zlX3tfTDP5gJ36E764G8+
	a1LDiQi0bXuIhDQqZMsI9Z5uq/4L366vSSe9sjr37afMbqZxZe08HntcsDxzd58A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858wc93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:22:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QGTf7f027887;
	Thu, 26 Feb 2026 17:22:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr24q73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:22:38 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QHMcY815532768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 17:22:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84B8B5803F;
	Thu, 26 Feb 2026 17:22:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC73658056;
	Thu, 26 Feb 2026 17:22:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 17:22:37 +0000 (GMT)
Message-ID: <969c74f3-81ed-442c-87dd-381274a642a7@linux.ibm.com>
Date: Thu, 26 Feb 2026 12:22:32 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IMA and PQC
To: Eric Biggers <ebiggers@kernel.org>, Simo Sorce <simo@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>,
        =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
        dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        roberto.sassu@huawei.com, zohar@linux.ibm.com,
        michael.weiss@aisec.fraunhofer.de
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk> <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
 <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
 <dc09be79-5efe-4756-a295-5b0428985525@linux.ibm.com>
 <da190dbbc692b9da8464bbbfffdde7bab26b3f1c.camel@redhat.com>
 <20260226165819.GA2251@sol>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260226165819.GA2251@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1NSBTYWx0ZWRfX6BhYsrxbCFzO
 r49GkhBY4NvgTUJcI4mhd1sx7zNQ7ekW0OifMbKBadBSL9DPhSZ+ixrtiQJJOYv5pAEu17cqJdd
 Ah0jSDIOzb83M7aC9vLm6pE86beajbk1+gjMYkX8m5YfL1UpW6p2PKNRMT8thxstbQm+CRnNuk7
 XppY1Dih6bv4jxsxNp8Pcgbxa0UWx4iPRF326Z6LzAKqSO/x5ef1p+cLceeEKd5Jb/Uk2+DcxIo
 g+HBmhf63ifdlW/6gnR8xnVumRK6Jy5aCJpjYacLJX6+9jABO/B37LLGjeu1JyR+bR3NEcJnNx8
 n1JljDw9e0bV6Qgd4v20k9IvY7fQtQ74pMKtUnrfDgZedxW0fIjgzfuUXZah67dw/D9A7sE0rwi
 m4Aoo0OwARLIpM8fglCkGktT4paL5UrFIArh9yZR/YNCSdYWx719e2l2sPN+lcF2ZrHtrMv7T0+
 xtrd7SeDs7ER6IHHLHA==
X-Proofpoint-GUID: zvqGvLYmqPH-mtQViRvGYitqTKR9a8sy
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a08160 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=or4u6VGYAAAA:8 a=KSdFDonAzZUnY1rFAaAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=f52p4T1hNPgkgD0SKpRM:22
X-Proofpoint-ORIG-GUID: uo65ftNaWgDJnXHFOyq6XUGy94c9AUMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8647-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,keymaterial.net:url,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: C18311AD09B
X-Rspamd-Action: no action



On 2/26/26 11:58 AM, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 10:27:43AM -0500, Simo Sorce wrote:
>> On Thu, 2026-02-26 at 09:16 -0500, Stefan Berger wrote:
>>> On 2/26/26 7:42 AM, Stefan Berger wrote:
>>>> On 2/25/26 7:10 PM, Eric Biggers wrote:
>>>>> On Wed, Feb 25, 2026 at 09:25:43AM -0500, Stefan Berger wrote:
>>>>>> To avoid duplicate work: Is either one of you planning on writing
>>>>>> patches
>>>>>> for IMA to use ML-DSA and convert the current ML-DSA to also support
>>>>>> HashML?
>>>>>> I had done the work on this before and could dig out the patches
>>>>>> again...
>>>>>
>>>>> IMA already had to add its own digest prefixing support, since it was
>>>>> needed to disambiguate between full-file digests and fsverity digests.
>>>>> See 'struct ima_file_id'.  Thus the message signed is at most 66 bytes.
>>>>
>>>> The hash there is still only a hash over a file and that hash is signed,
>>>> isn't it?
>>>>
>>>>>
>>>>> With that being the case, HashML-DSA isn't necessary.  It's not even
>>>>> possible to use here, since there are no OIDs assigned for the fsverity
>>>>> digests, so it cannot replace the ima_file_id.
>>>>
>>>> For non-fsverify IMA signatures it is 'possible' to use HashML-DSA and
>>>> it's 'working' (recycled old patches yesterday):
>>>>
>>>> Linux: https://github.com/stefanberger/linux/commits/
>>>> dhmlsa%2Bima.202602025/
>>>>
>>>> ima-evm-utils: https://github.com/linux-integrity/ima-evm-utils/pull/19/
>>>> commits
>>>>
>>>>>
>>>>> I'll also note that HashML-DSA is controversial (e.g. see
>>>>> https://keymaterial.net/2024/11/05/hashml-dsa-considered-harmful/),
>>>>
>>>> The problem with this is that NIST would have to react to these
>>>> controversies as we race to support PQC. If something is wrong with the
>>>> standard then it would be best for NIST to withdraw/modify HashML-DSA
>>>> asap. Otherwise it's the best to follow the standard IMO because if you
>>>> don't you get criticism otherwise.
>>>
>>> What I am not clear about from FIPS-204 is whether availability of
>>> HashML-DSA is a "must-use" or  a "may-use". What speaks against it for
>>> our use case is performance. The lookup of a hash's ID (last digit of
>>> OID) and the creation of the 11 byte encoding to prepend before every
>>> digest for every signature takes cycles.
>>
>> It is a recommendation, but there are plenty of protocols (TLS,
>> OpenPGP, etc...) where the decision has been made to use "pure" ML-DSA
>> only, even if what you are signing is not the full data, but something
>> containing a hash.
>>
>> Ideally you do not sign *just* a hash, but some structured data, like a
>> context label that identifies the hash and some other related metadata
>> for example. In order to make forgeries much harder should the hashing
>> algorithm used to hash the data weaken over time. But it is not
>> strictly necessary (NIST mentioned in some forum, sorry I do not have
>> the message handy for quoting, that a structured packet is perfectly
>> fine for use with pure ML-DSA, because it does enough to address the
>> same issues that a separate internal context does with HashML-DSA).
>>
>> If pure-ML-DSA works better for IMA, just use pure ML-DSA.
>>
>>> Maybe it should explicitly state in FIPS-204 something along the lines
>>> of "with a given hash either ML-DSA or HashML-DSA can be used (for as
>>> long as you use it in the same way from then on)." At least this way
>>> nobody can point out that HashML-DSA should have been used when you didn't.
>>
>> NIST will not change the standard documents any time soon, but for FIPS
>> certification there are Implementation Guidelines.
>>
>> In any case a FIPS module cannot distinguish between data that happens
>> to be 32 bytes long and a hash of larger data, so the point is kind of
>> moot. From the FIPS perspective HashML-DSA is just an available
>> algorithm that protocol implementations can use, or not.
>>
>> There are additional guidelines on what this may be useful for, but so
>> far NIST has not objected to the use of pure ML-DSA even where
>> theoretically HashML-DSA could be used.
> 
> I see that IMA indeed never upgraded full file hashes to use
> 'struct ima_file_id'.  Building a new feature that relies on this seems
 > like a bad idea though, given that it's a security bug that makes 
the> IMA protocol cryptographically ambiguous.  I.e., it means that in IMA,
> when the contents of some file are signed, that signature is sometimes
> also valid for some other file contents which the signer didn't intend.

You mean IMA should not sign the digest in the ima_file_id structure but 
hash the ima_file_id structure in which this file digest is written into 
(that we currently sign) and sign/verify this digest? And we would do 
this to avoid two different files (with presumably different content) 
from having the same hashes leading to the same signature? Which hashes 
(besides the non-recommended ones) are so weak now that you must not 
merely sign a file's hash?

The problem with this is that older kernels (without patching) won't be 
able to handle newer signatures.

> 
> Just fix that bug first, which has to be done anyway.  Then just use
> pure ML-DSA to sign and verify the 'struct ima_file_id'.
 > > As Simo mentioned, FIPS 204 doesn't require HashML-DSA when signing a
> hash.  It's there as an *option* to solve a perceived problem, which is
> actually solvable in better ways.
> 
> NIST doesn't plan to update FIPS 204 until 2029, and most likely the
> updates will just be errata in the text (such as the ones I reported to
> them), not changes or withdrawals in the algorithms themselves.  But
> it's irrelevant: just because HashML-DSA is an option doesn't mean it
> has to be used.  Pure ML-DSA supports arbitrary data, which includes

And I was sure whether it was merely an 'option'. Who would use it then 
if it takes more cycles to hash the prepended 11 byte oid in HashML-DSA?

> formatted hashes which allow for pre-hashing perfectly well.
> 
> - Eric


