Return-Path: <linux-integrity+bounces-8664-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO9kKqy1oGnClwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8664-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 22:05:48 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DB21AF64F
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 22:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3D723011341
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27839526F;
	Thu, 26 Feb 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kMWwDEBX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB013939C6;
	Thu, 26 Feb 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139936; cv=none; b=Nhx4516qDQds6ANkHtykVD0BqNRVMJIxKvNkZUGrG/ZV7KJ3L1dJ6kfbbxhiPV1REl2cyLY9phB2JaFGo9+iov2WMnCu3kjW7h+XpS+IS9cWY2FTX30vNZOKJzyRnZV1HxSTpiRCzSIVpQpmGgQY79MgXc00MbqIOVrn45f6aHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139936; c=relaxed/simple;
	bh=CGJOtdEq3F146PP+b+MPdofOSSJn1EG7PDzHAp8/b3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsEqU8jVVCGfweW1NxPv/lbde/9kAJrQSv5U0v4KlOUU/TqRVIG1UwAK7I/iLfh8naoT281sZ7IY1TxYmpKqe9cFRB+1Q0hG5a1s0U71c1dswcj8E0sD/+BIfEISUvnJbuJ7Wx680GGx6/R9sQxp9BHK4Vh4ztTeT3lOVdfuiII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kMWwDEBX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHtqJC3003598;
	Thu, 26 Feb 2026 21:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=//3GCo
	5ghP7YnX/8DlB/b0HC567HIVL4lqpc0QRGdAA=; b=kMWwDEBXtVjB1FCTNB9RNg
	+Dwfah2GZAy0VXXdviJQWi6JByYjpQhPnbKPgZs2QnZrTnx1UZrlBIDOM7qVRr/4
	+Dus2pqqBQGiY/gk9CN58RcoNKFWxxr6V04qCYqwfPPDh6iD+RUfXdg1H6TE43+K
	N4H8jViSHaTc4IPsnwtkXWgxWPc718r9BW0+8i8qI2BxUv76fcLSGfZuSBwde/1o
	fxyYfB6m0RM2la/OIiyuYCPH8JRdR2bH70XEXs/EagtuD9i+SQ64S/lQ5LLT3l1S
	C7B2iFSoFOT26KQPomP6JVCHoDwzdYaH2xtw0p2hTsYAi4ZNuA/oBzAaV14+tw3Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs861v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 21:05:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QIV3aJ015983;
	Thu, 26 Feb 2026 21:05:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sx8sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 21:05:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QL5JPY27329254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 21:05:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 462B358056;
	Thu, 26 Feb 2026 21:05:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 641C65803F;
	Thu, 26 Feb 2026 21:05:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 21:05:18 +0000 (GMT)
Message-ID: <1faaa368-451c-49fa-8ba2-82610dfef3e8@linux.ibm.com>
Date: Thu, 26 Feb 2026 16:05:17 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IMA and PQC
To: Eric Biggers <ebiggers@kernel.org>
Cc: Simo Sorce <simo@redhat.com>, Coiby Xu <coxu@redhat.com>,
        =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
        dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        roberto.sassu@huawei.com, zohar@linux.ibm.com,
        michael.weiss@aisec.fraunhofer.de
References: <aYHznG6vbptVOjHQ@Rk>
 <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
 <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
 <dc09be79-5efe-4756-a295-5b0428985525@linux.ibm.com>
 <da190dbbc692b9da8464bbbfffdde7bab26b3f1c.camel@redhat.com>
 <20260226165819.GA2251@sol>
 <969c74f3-81ed-442c-87dd-381274a642a7@linux.ibm.com>
 <20260226183248.GE2251@sol>
 <13ebe763-dcaf-4379-b9a7-82d06fd0fdb3@linux.ibm.com>
 <20260226194406.GG2251@sol>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260226194406.GG2251@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vX2zSuxstHXhjgCw-A1HAYqr-CGGzolU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4OCBTYWx0ZWRfX/a2JQU9aa5ee
 2rKqdPf62pG74+XDCUnKIphMQ/4jhR5R4mE02G+Wm/dTV0ngzD2zU1a17D7kkbhZjWQyU4Je7Gj
 pilRlxcKp0OgA1ix4MKPI+5c6gKCq1VMifrNl9RW7gT4xE9VW86VT40OGHpIaXRsgZtSj1304/M
 m2myg4j8wgA+664aRPCdSjCdYgYrQVrgfD2bXfOkRVQFmUHibUu0bnzHXKdN/Mh7bCfV1S09VZw
 HlUgab1lgA2nZzKVgZ84vEHb4MRX4ZUVx0DmxeUuiOiQRehYmJTTjyZle+9sARyDJgHCiNL0JpQ
 himd4x0yeXVUoaXySaxyIUQb+a/IpGcQV3uL+2D3nTK6+gRR9TnIvU7zCzal8cWYoZQnGK5IUDi
 uy33sHXS2KmBg9yRrkqs0oiVaOPAY9eH8psumb12xcH5FWUd6dxI7KawEk9EjNkDLiS63N6NGwg
 2jZR7eOHQSPv05dbG8A==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a0b590 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=TKsHhThkkL6ydXzSVRkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WxIQyzXbclRQMkqPy7P1Z_1PNO7y14kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8664-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 51DB21AF64F
X-Rspamd-Action: no action



On 2/26/26 2:44 PM, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 02:21:41PM -0500, Stefan Berger wrote:
>>
>>
>> On 2/26/26 1:32 PM, Eric Biggers wrote:
>>> On Thu, Feb 26, 2026 at 12:22:32PM -0500, Stefan Berger wrote:
>>>>> I see that IMA indeed never upgraded full file hashes to use
>>>>> 'struct ima_file_id'.  Building a new feature that relies on this seems
>>>>> like a bad idea though, given that it's a security bug that makes the> IMA
>>>> protocol cryptographically ambiguous.  I.e., it means that in IMA,
>>>>> when the contents of some file are signed, that signature is sometimes
>>>>> also valid for some other file contents which the signer didn't intend.
>>>>
>>>> You mean IMA should not sign the digest in the ima_file_id structure but
>>>> hash the ima_file_id structure in which this file digest is written into
>>>> (that we currently sign) and sign/verify this digest? And we would do this
>>>> to avoid two different files (with presumably different content) from having
>>>> the same hashes leading to the same signature? Which hashes (besides the
>>>> non-recommended ones) are so weak now that you must not merely sign a file's
>>>> hash?
>>>>
>>>> The problem with this is that older kernels (without patching) won't be able
>>>> to handle newer signatures.
>>>
>>> IMA needs to sign the entire ima_file_id structure, which is indeed what
>>> IMA already does when it uses that structure.  (Well, actually it signs
>>> a hash of the struct, but that's best thought of an implementation
>>> detail of legacy signature algorithms that can only sign hashes.  For a
>>> modern algorithm the whole struct should be passed instead.)  Just IMA
>>> uses that structure only for fsverity hashes, which is a bug that makes
>>> the IMA protocol ambiguous.  It needs to use ima_file_id consistently,
>>> otherwise a signed message sometimes corresponds to multiple unique file
>>> contents even without a break in the cryptographic hash function.
>>
>> Before we jump into making changes on this old stuff I think it's good to
>> understand the underlying problem and the likelyhood of signatures
>> validating different data, such as a file and fsverity data. How likely is
>> this?
>>
>> Assuming a strong hash I suppose that is not a concern with RSA because here
>> the digest is padded and then directly encrypted with the private key. Upon
>> verification (pub key decrypt) we would unpad and memcmp the digests.
>>
>> Again, assuming a strong hash: With ECDSA NIST P256 for example we have a 32
>> byte signature. With a SHA512 being used for hashing for example we would be
>> doing a projection of a 64byte hash space to a 32byte signature space with.
>> Just by this projection of a much larger space into a smaller space
>> signatures that validate multiple input data could be a problem. One 'easy'
>> case where signatures for different input data is the same (not exactly the
>> same due to nonce involved the signature is verifyable), albeit unlikely, is
>> that there could be different input data for the SHA512 that lead to the
>> same 32bytes prefix, which is then used after truncating the sha512 to the
>> first 32 bytes for the ECDSA signature, and this then leads to a signature
>> that is verifyable for different input data. So that's the 'simple' case at
>> least for this thought experiment for a non-expert.
>>
>> Now what should still be difficult to do is given a file and a hash-to-use
>> that you can create fsverity content that leads to a hash that in turn leads
>> to a NIST-P256 signature that can be used for signature verification(s) of
>> the file and the totally different fsverity data. Is this a problem that is
>> as difficult to solve just as finding different input data for a hash that
>> leads to the same digest?
> 
> There's no differentiation between a 'struct ima_file_id' that
> *represents* the contents of some file, and a file whose contents are
> *equal to* that 'struct ima_file_id' and that uses a full-file hash.  In
> both cases the same key and message are used for signing and verifying.

I hadn't been thinking of this... It's a side-effect of starting to sign 
ima_file_id for v3 that a file *content* could now hold the ima_file_id 
structure (as signed with v3) and the signature would validate when used 
with the v2 signature verification scheme. So, the content of the file 
would presumably be odd/useless (2 bytes + hash) but it would verify 
with the signature created for v3. We will have to offer the possibility 
to move to v3 signatures for all signing schemes and offer the 
possibility to deactivate older versions (<v3).

> 
> This means that every time a file is signed using the ima_file_id
> scheme, it also implicitly signs some other file contents, which an
> attacker can freely replace the file with.  Similarly, every time a file
> that happens to be a valid ima_file_id is signed using the older scheme,
> it also implicitly signs the contents that the ima_file_id correspond
> to, which the attacker can freely replace the file with.  In either
> case, no collision in the cryptographic hash function is required.
> 
> It's simply a broken protocol.  To fix this, IMA must only support
> signatures that use the ima_file_id scheme.
> 
> Of course, that will require making them support full-file hashes and
> not just fsverity hashes.  If I recall correctly, this was actually part
> of the original design of the ima_file_id-based signatures.  It's
> unclear why the implementation is still incomplete.
> 
> - Eric


