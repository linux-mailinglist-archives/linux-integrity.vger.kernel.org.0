Return-Path: <linux-integrity+bounces-9200-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O3ooLXny32lDawAAu9opvQ
	(envelope-from <linux-integrity+bounces-9200-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 22:18:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3560407954
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 22:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273663080A74
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3AA35294E;
	Wed, 15 Apr 2026 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q6INEjBM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC62F9998;
	Wed, 15 Apr 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284167; cv=none; b=K4x+2Qs7s04rBsIrEzpcKHREv3j8FPTZkz0IDNXgWG0OZ+K6ijRaweGTnzoN4EqRn1Q+WVVy8TBesRQpLVr5KgRQlSQT7eRzKxTvkkgRo2GWVaPM/ESpaK0dU+RpqkAxDfL1JKqW0KtcMR1kUWNxiezAibluffxM+4IyF/qIS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284167; c=relaxed/simple;
	bh=HqouabVFKoZD1tIB8RQNz/frr7pV0L4E50sp1pv13rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqiRIc3SKlj9r9+Z0SvEN7z5Ypyk8qUzM5N313d6C5F4WeoxFFC1Ux3ZCiDjGAfcpMcaPT/2IrNP/DNzcEeCw+/7NSTFRo8Q+rtdw7wZ+J1G6YXMHZfrsHY1ltP9jVH2tXNzT+GpaqWN/XvQ/jBlnqrNeIYjMsnq+mF6Sjj55OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q6INEjBM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FFdiKw1804521;
	Wed, 15 Apr 2026 20:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yiMATA
	DwFXNCP8RMO+91pro4WnGCWc9uX8Q/OqAspmo=; b=Q6INEjBMiAfqATMFGWNk4N
	3fJP1lQWAdetRfqwnN27U43dng97UDt9LN688xif2ga7NxQuPEPy9J/ysIdepVGO
	3TdTIukOsFoLzW/sd86iQHLjLRCAYEEYO6ETtOYvjqycS0vLwHzFvizcz5sFUcBG
	4lIglHODV2rZtARRnhBzOE1Ey+k3ZAJ8g558XsE5d3zqjMjw1H3pu3cLlvlxjVtB
	Wi1UVeNslNpHqmaqhreDY6+aQYjycpOgsv04YCeuLMo1O9+e+6tCui1F0k3dkw+r
	Al8KMoQO0oMVzHqWgWrQQrVryh/6Y57/z7tv+T9xw7K3lMh9I/hR3uVa5AER3Euw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k9hrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:15:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FHmVQF025862;
	Wed, 15 Apr 2026 20:15:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujqqhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:15:55 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FKFTsq22413904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 20:15:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB5C658059;
	Wed, 15 Apr 2026 20:15:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208605805D;
	Wed, 15 Apr 2026 20:15:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 20:15:54 +0000 (GMT)
Message-ID: <a502efde-57ec-46e3-9996-08a90fcde73d@linux.ibm.com>
Date: Wed, 15 Apr 2026 16:15:53 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] integrity: Refactor asymmetric_verify for
 reusability
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        ebiggers@kernel.org
References: <20260408174154.139606-1-stefanb@linux.ibm.com>
 <20260408174154.139606-2-stefanb@linux.ibm.com>
 <0375ccecdfb77286dff7f40af5ddbd20f7d6e0fa.camel@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <0375ccecdfb77286dff7f40af5ddbd20f7d6e0fa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YopBmcN5aaELjviR4OR9SEHr59AzhMYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE4NSBTYWx0ZWRfX79Cf0M67o1Yf
 fMkUtRmwRWTDypl/wKrBFwMs6Pih49G4bgWvvChk5tB1yKFDLMvarnbYPdKwxOZLDGHoP5N8s5R
 9/CMi6T/S0Svm3e8phGDTc9o/MdYsjwPnbCCT7VgbDlZMSnY9h/HQ6aI/3zOxby83/4qsDekzlS
 urcyMEQ8DMQnlrgGop5/49ITrx0dkOtJwJ1xkpNvUCqePnP61uJRchvmzsVV45/WtSjqAVgIYYh
 0D9wfEm19/r9t/Xrfvs0HoQ1MYU3Bd8KAPCVRo2aMk/e/dxE57Ug13TmC+xF1MNXae2r7SPsXqV
 fHl7c05O3nJCFc5W4JYKZxE/r8ZO4gn9ghduKaoxGMcLraZlmowXGLT6QBmyCTKt0UfcArIZ9d1
 UMixeRN3A8i9jTkNxFQ+P+bQYPGe9nnelWDz3GSifmfrBkP761D9jKSmWvdC0G+TSDPlC0ALxFp
 wTPNyxgZjdyYsfHHp2Q==
X-Proofpoint-ORIG-GUID: YopBmcN5aaELjviR4OR9SEHr59AzhMYV
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69dff1fc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=eTezRDW_NLVY9748B9YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150185
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9200-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: E3560407954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/14/26 10:00 PM, Mimi Zohar wrote:
> On Wed, 2026-04-08 at 13:41 -0400, Stefan Berger wrote:
>> Refactor asymmetric_verify for reusability. Have it call
>> asymmetric_verify_common with the signature verification key and the
>> public_key structure as parameters. sigv3 support for ML-DSA will need to
>> check the public key type first to decide how to do the signature
>> verification and therefore will have these parameters available for
>> calling asymmetric_verify_common.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.
> 
>> ---
>>   security/integrity/digsig_asymmetric.c | 42 +++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
>> index 6e68ec3becbd..e29ed73f15cd 100644
>> --- a/security/integrity/digsig_asymmetric.c
>> +++ b/security/integrity/digsig_asymmetric.c
>> @@ -79,18 +79,15 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
>>   	return key;
>>   }
>>   
>> -int asymmetric_verify(struct key *keyring, const char *sig,
>> -		      int siglen, const char *data, int datalen)
>> +static int asymmetric_verify_common(const struct key *key,
>> +				    const struct public_key *pk,
>> +				    const char *sig, int siglen,
>> +				    const char *data, int datalen)
>>   {
>> -	struct public_key_signature pks;
>>   	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
>> -	const struct public_key *pk;
>> -	struct key *key;
>> +	struct public_key_signature pks;
>>   	int ret;
>>   
>> -	if (siglen <= sizeof(*hdr))
>> -		return -EBADMSG;
>> -
>>   	siglen -= sizeof(*hdr);
> 
> Normally kernel-doc is unnecessary for static functions.  Here, however, since
> only the caller verifies the signature length, there should be a kernel-doc
> function definition.  It should indicate that all callers must verify the
> signature length (siglen) and that the public key (pk) is not NULL, before
 > calling asymmetric_verify_common().

Will add.

> 
>>   
>>   	if (siglen != be16_to_cpu(hdr->sig_size))
>> @@ -99,15 +96,10 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>>   	if (hdr->hash_algo >= HASH_ALGO__LAST)
>>   		return -ENOPKG;
>>   
>> -	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
>> -	if (IS_ERR(key))
>> -		return PTR_ERR(key);
>> -
>>   	memset(&pks, 0, sizeof(pks));
>>   
>>   	pks.hash_algo = hash_algo_name[hdr->hash_algo];
>>   
>> -	pk = asymmetric_key_public_key(key);
>>   	pks.pkey_algo = pk->pkey_algo;
>>   	if (!strcmp(pk->pkey_algo, "rsa")) {
>>   		pks.encoding = "pkcs1";
>> @@ -127,11 +119,33 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>>   	pks.s_size = siglen;
>>   	ret = verify_signature(key, &pks);
>>   out:
>> -	key_put(key);
> 
> The kernel-doc function definition should also indicate that the caller must
> free the key.

Ok, I will add it. However, symmetric_verify_common cannot free the key 
since it is passed as const(!) struct key *key...

> 
>>   	pr_debug("%s() = %d\n", __func__, ret);
>>   	return ret;
>>   }
>>   
>> +int asymmetric_verify(struct key *keyring, const char *sig,
>> +		      int siglen, const char *data, int datalen)
>> +{
>> +	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
>> +	const struct public_key *pk;
>> +	struct key *key;
>> +	int ret;
>> +
>> +	if (siglen <= sizeof(*hdr))
>> +		return -EBADMSG;
>> +
>> +	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
>> +	if (IS_ERR(key))
>> +		return PTR_ERR(key);
>> +	pk = asymmetric_key_public_key(key);
> 
> Please add a test here making sure pk is not null.

As a separate patch for backporting?

Return -ENOKEY in case we hit a NULL pointer?

> 
> thanks,
> 
> Mimi
> 
>> +
>> +	ret = asymmetric_verify_common(key, pk, sig, siglen, data, datalen);
>> +
>> +	key_put(key);
>> +
>> +	return ret;
>> +}
>> +
>>   /*
>>    * calc_file_id_hash - calculate the hash of the ima_file_id struct data
>>    * @type: xattr type [enum evm_ima_xattr_type]
> 


