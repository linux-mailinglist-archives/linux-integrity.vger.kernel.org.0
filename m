Return-Path: <linux-integrity+bounces-8654-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPd7JDGfoGlVlAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8654-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 20:29:53 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C91AE5A0
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 20:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EBB13014F4E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DCA44D686;
	Thu, 26 Feb 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTmZERCz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B144D014;
	Thu, 26 Feb 2026 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133724; cv=none; b=SZxkwoTZg9mCqduVfVbeDSCsi/sgyXWnmlnCtHtpNJPMs7dNMEsWtpQlVG92dwIu6ymZhgHlTbqPjXI+K16gfBmR6TwPqs5RRSpaQlp30ixuolxYzzku9d89920dBND92LxGPrzX11LkxnAsp90F04aTKY1opUyzFCqc7QKtxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133724; c=relaxed/simple;
	bh=oUF6Q82itcp+x4+70TIjsKDl+qbmr+lkWsPLCDkUCnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aD+ipW0tU0JvdDnzjpDahMExySO5WbEbfhrA38l3TSL4ZswBj5cbqsviKG2R5eFZKcbcOuxl9PJH5SCsfuNBcbs83Msp7B1an+kmY6eUy0vh2uQGBRvqvDQL8fe7slS3GK8QHcsd0is+gde8O33ikqVCbAyo4IQY8IIpDHbpYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTmZERCz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QG2Gx62659374;
	Thu, 26 Feb 2026 19:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nLal4i
	sc2CuFQmiLAbdXMQCopWQi2r7SppJknQbPKPQ=; b=sTmZERCzSiM3Rwix/ph7AP
	YzAu0fR9jgEjOolMI70jEuDOhv6tTl4QXsvxEHLjcmTqb/bOV6mJLuQ+fEwM/IV9
	7y5WFn+Y1tVeoOgMD1RCUtuoko5zsB+w8h8UzbszAA7iK3b0Yvxvdt+aau3pKRqj
	xmjZ+XYGRVsoHQmBB5JR+IgupEq2jUP+ROMBSu/MNmD2EzSQPVxMsDF5jWPUV3v+
	2Yf8cu4qn3kM1lQkWwOkIMycTNgkjU3DoBR5C7KWs+hv8mEORiNwQe6EjXxpAtnJ
	gdFLQ/GfCrfDBhqcSzIKl6J6MievIgh4Iic0G37GVnEaRotbrURPwxN7e/PRBrSw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4728p9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:21:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QIvRTn027794;
	Thu, 26 Feb 2026 19:21:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr25cqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 19:21:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QJLhj863701390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 19:21:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0E9458060;
	Thu, 26 Feb 2026 19:21:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B148258061;
	Thu, 26 Feb 2026 19:21:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 19:21:42 +0000 (GMT)
Message-ID: <13ebe763-dcaf-4379-b9a7-82d06fd0fdb3@linux.ibm.com>
Date: Thu, 26 Feb 2026 14:21:41 -0500
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
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk> <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
 <20260226001049.GA3135@quark>
 <cba10ac6-3557-4fc1-9b86-55361d14156d@linux.ibm.com>
 <dc09be79-5efe-4756-a295-5b0428985525@linux.ibm.com>
 <da190dbbc692b9da8464bbbfffdde7bab26b3f1c.camel@redhat.com>
 <20260226165819.GA2251@sol>
 <969c74f3-81ed-442c-87dd-381274a642a7@linux.ibm.com>
 <20260226183248.GE2251@sol>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260226183248.GE2251@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ez6maZw7QaQ1_ty-q-waOXHKS2xJJ7zS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3NSBTYWx0ZWRfX9haF9xbuO76d
 hc2stPQ06n2ROMfGjkFGPYj4AWfKHy6o9lhv6HS4NgzEnDXB3CbNjG7H4VrHRVrIsiEjY9SXG+D
 Wmk0ByVIAPnJtZ+/o3aWSF1D0OqDsTU9RRJ3a24fQ16W8sNpjREfQ/slIyu5gY6CAW50JGnuae2
 bb187Z3mKFF9Ul8vwbelotzbZ04CsMt8ofaCJ45qMg6bPrS2FnklW4O+Q9ResnO+/wTipD/h5AP
 o39I3cGpZok6j7fCFOEvs1GiyMk2Tl0hoVPlSXQD5T9OpNdP7HwQvHfgXfdKi9o5SKFdnPRWyMd
 mcWHwoxcj17qAMwPT7+KO1eYoinRrpoRftWKDsLiqvHnzJ5vNW4OfhaLs6iyVb9EcDFQojEYTWh
 NaYOJIZWj3tVpHVCe3QcGPXnY0ZP7tdzb621MCnFU/xxYFDtqrqzuWwIYKzjlCDqi8IFEY02ywv
 x44FktKq5/eYoXVxaSg==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a09d4a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=6JQ1E2fCJFPygG1P36YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W03ktio5Ss-SmKhTMJRNV_hQRcm-jGFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8654-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: DF0C91AE5A0
X-Rspamd-Action: no action



On 2/26/26 1:32 PM, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 12:22:32PM -0500, Stefan Berger wrote:
>>> I see that IMA indeed never upgraded full file hashes to use
>>> 'struct ima_file_id'.  Building a new feature that relies on this seems
>>> like a bad idea though, given that it's a security bug that makes the> IMA
>> protocol cryptographically ambiguous.  I.e., it means that in IMA,
>>> when the contents of some file are signed, that signature is sometimes
>>> also valid for some other file contents which the signer didn't intend.
>>
>> You mean IMA should not sign the digest in the ima_file_id structure but
>> hash the ima_file_id structure in which this file digest is written into
>> (that we currently sign) and sign/verify this digest? And we would do this
>> to avoid two different files (with presumably different content) from having
>> the same hashes leading to the same signature? Which hashes (besides the
>> non-recommended ones) are so weak now that you must not merely sign a file's
>> hash?
>>
>> The problem with this is that older kernels (without patching) won't be able
>> to handle newer signatures.
> 
> IMA needs to sign the entire ima_file_id structure, which is indeed what
> IMA already does when it uses that structure.  (Well, actually it signs
> a hash of the struct, but that's best thought of an implementation
> detail of legacy signature algorithms that can only sign hashes.  For a
> modern algorithm the whole struct should be passed instead.)  Just IMA
> uses that structure only for fsverity hashes, which is a bug that makes
> the IMA protocol ambiguous.  It needs to use ima_file_id consistently,
> otherwise a signed message sometimes corresponds to multiple unique file
> contents even without a break in the cryptographic hash function.

Before we jump into making changes on this old stuff I think it's good 
to understand the underlying problem and the likelyhood of signatures 
validating different data, such as a file and fsverity data. How likely 
is this?

Assuming a strong hash I suppose that is not a concern with RSA because 
here the digest is padded and then directly encrypted with the private 
key. Upon verification (pub key decrypt) we would unpad and memcmp the 
digests.

Again, assuming a strong hash: With ECDSA NIST P256 for example we have 
a 32 byte signature. With a SHA512 being used for hashing for example we 
would be doing a projection of a 64byte hash space to a 32byte signature 
space with. Just by this projection of a much larger space into a 
smaller space signatures that validate multiple input data could be a 
problem. One 'easy' case where signatures for different input data is 
the same (not exactly the same due to nonce involved the signature is 
verifyable), albeit unlikely, is that there could be different input 
data for the SHA512 that lead to the same 32bytes prefix, which is then 
used after truncating the sha512 to the first 32 bytes for the ECDSA 
signature, and this then leads to a signature that is verifyable for 
different input data. So that's the 'simple' case at least for this 
thought experiment for a non-expert.

Now what should still be difficult to do is given a file and a 
hash-to-use that you can create fsverity content that leads to a hash 
that in turn leads to a NIST-P256 signature that can be used for 
signature verification(s) of the file and the totally different fsverity 
data. Is this a problem that is as difficult to solve just as finding 
different input data for a hash that leads to the same digest?

> 
> Sure, when that bug is fixed, old kernels won't support the new
> signatures for files that use a full-file hash.  But the same applies to
> starting to use a new signature algorithm, such as ML-DSA.
> 
> - Eric
> 


