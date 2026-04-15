Return-Path: <linux-integrity+bounces-9201-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMA0Evn132kTbAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9201-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 22:32:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E660C407A8F
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F980304555D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24931AA87;
	Wed, 15 Apr 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nroOUvPt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D972222D0;
	Wed, 15 Apr 2026 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285174; cv=none; b=h/sPE+ija3Yu9S0SWHHLtWOefrZkPVuZbB60mz4aK2eHFe4pyL9qgK4e5ZZpvkCFYziWILGrAljbUwZjY0okJGFPvk3an+U9HmNi9JicEUwv4gCuJjbH/LuH4jM9/qzMQtN8AHtJ57W26oEgEPIdCwJ3bN2EP7ovhI4SY7ag8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285174; c=relaxed/simple;
	bh=K1URluIj0cdEaODFooYuB8im6L2bLEqaFCC2O7SoCls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puG9FhhaUD2l22o3z0A7N6Pu6EZR2m2UT6lMA9wimj0i9B+RkEow2d0V18Iel+SDt2gz2HkpvjYsKwUydfo4mhf4FpSZog52JthKCsZLC959i99PWpHfvjv8g/Cd+pXx+zMEgMUyBbcwecjL7S+skwjraIV8wV9h36ZU2L3r6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nroOUvPt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FH5a1J1834640;
	Wed, 15 Apr 2026 20:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2D+6e+
	liD73SBB5g9gxJQqUK4+/I/WKA4veH9C8ibRs=; b=nroOUvPtoMB4ivZgwoHr8d
	64Bk/WB0mqCywvEJ02p7nLJfKbFzQKtuk8y4sF8BAn44X5mEyJe1CNsG50hfHhal
	fNrwrpIeP10wJTqs5F0KxI9Zi37tF6bStGaHslBVXe0tjAfmts2PJ+N0UpgZjZxX
	q73duDWyYteDEgVhfXEW9MWX9WpEt7bnUd6ALFW5H5JC9TYLIg2EAzUP4859UUv9
	wcrxPt6JI7ZdPmrev5E/s76DA4qauKRTnc2RhIUlO7ywnm1iOUxsIscjFD2MaenS
	ZhQBGGaR896sz3Lp/433uFstmUdhgP+LU/Cm+qUbWTuX5p+q2fbNpk0CRFNiUKgA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rj7yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:32:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FHQ0Q1004180;
	Wed, 15 Apr 2026 20:32:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kfwhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 20:32:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FKWii614942826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 20:32:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82ED55803F;
	Wed, 15 Apr 2026 20:32:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03F658055;
	Wed, 15 Apr 2026 20:32:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 20:32:43 +0000 (GMT)
Message-ID: <52b6f2d4-0044-4629-836a-3b3c8064b5a6@linux.ibm.com>
Date: Wed, 15 Apr 2026 16:32:41 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] integrity: Add support for sigv3 verification
 using ML-DSA keys
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        ebiggers@kernel.org
References: <20260408174154.139606-1-stefanb@linux.ibm.com>
 <20260408174154.139606-3-stefanb@linux.ibm.com>
 <be3fdb81a322ab96e356e165b737c46f00c12cc3.camel@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <be3fdb81a322ab96e356e165b737c46f00c12cc3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE5MCBTYWx0ZWRfX8s4nKgsYe1Tb
 dssNIn3+eRkH9G0VhVEJxzG2OeCO5CA/E1NCqbok9xNANMV+eUOeIcd+INRI2NsXQWEfBHxCks/
 NCEKjC8XUrPAw3dy31QN/XYcs4GB+/koDc134KCQBfNwsy17tEX8wb3c0kwjzELVYMOnKvJLODN
 +cY5NzKVhMTc91cWq1aPyT4EPZNPW1vkvN9HC8sSvUvnlZXeBnSNmaq9O057OTC0wMELSCs/1FD
 PeAKAPxoBBds8yybjF0c07O08CqDLLnxBSVFVd5iNEtB7+iVPezG/r9qnxNBby/soHNMkT3KdJx
 EiAzMxoU0TCTORghfyKxQZRaDAkw2DfqVAihG+tMKjbnPC2NczY85v2trWMsp3RcZj83uMuQxCU
 sOSVUlZGBFghqHWlyb3zFN4zBM10NUwHV7tor9DAcfahyXLUtLc4v8YGOLdzLEPLwaViIuT/8+k
 zZdQ6PBocbCj+C9RBIw==
X-Proofpoint-ORIG-GUID: hhV8PvF_d0l4-_4w9tJyUzG-PQ3xDb9N
X-Proofpoint-GUID: hhV8PvF_d0l4-_4w9tJyUzG-PQ3xDb9N
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69dff5ee cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=J7pf2ADVnq6S3Gxr93MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150190
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9201-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E660C407A8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/14/26 10:01 PM, Mimi Zohar wrote:
> On Wed, 2026-04-08 at 13:41 -0400, Stefan Berger wrote:
>> Add support for sigv3 signature verification using ML-DSA in pure mode.
>> When a sigv3 signature is verified, first check whether the key to use
>> for verification is an ML-DSA key and therefore uses a hashless signature
>> verification scheme. The hashless signature verification method uses the
>> ima_file_id structure directly for signature verification rather than
>> its digest.
>>
>> Suggested-by: Eric Biggers <ebiggers@kernel.org>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
> 
> Thanks, Stefan.
>> ---
>> v2: Set hash_algo in public_key_signature to "none"
>> ---
>>   security/integrity/digsig_asymmetric.c | 84 ++++++++++++++++++++++++--
>>   1 file changed, 79 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
>> index e29ed73f15cd..c80cb2b117a6 100644
>> --- a/security/integrity/digsig_asymmetric.c
>> +++ b/security/integrity/digsig_asymmetric.c
>> @@ -190,17 +190,91 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
>>   	return rc;
>>   }
>>   
>> +/*
> 
> kernel-doc starts with "/**".

I followed the pattern of documentation of a static function that you 
just moved:

/*
  * calc_file_id_hash - calculate the hash of the ima_file_id struct data
  * @type: xattr type [enum evm_ima_xattr_type]


> 
>> + * asymmetric_verify_v3_hashless - Use hashless signature verification on sigv3
>> + * @key: The key to use for signature verification
>> + * @pk: The associated public key
>> + * @encoding: The encoding the key type uses
>> + * @sig: The signature
>> + * @siglen: The length of the xattr signature
>> + * @algo: The hash algorithm
>> + * @digest: The file digest
>> + *
>> + * Create an ima_file_id structure and use it for signature verification
>> + * directly. This can be used for ML-DSA in pure mode for example.
> 
> Like the comments on 1/2, please add a comment here indicating that all callers
> must verify the signature length (siglen) and the public key (pk) is not NULL,
> before calling asymmetric_verify_v3_hashless().  Also indicate that the caller
> must free the key.
> 
>> + */
>> +static int asymmetric_verify_v3_hashless(struct key *key,
>> +					 const struct public_key *pk,
>> +					 const char *encoding,
>> +					 const char *sig, int siglen,
>> +					 u8 algo,
>> +					 const u8 *digest)
>> +{
>> +	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
>> +	struct ima_file_id file_id = {
>> +		.hash_type = hdr->type,
>> +		.hash_algorithm = algo,
>> +	};
>> +	size_t digest_size = hash_digest_size[algo];
> 
> Defer initializing the digest_size and .m_size, below, until after checking the
> hash algorithm is valid.

This function is called by asymmetric_verify. asymmetric_verify calls 
calc_file_id_hash, which doesn't check algo for valid range, either. I 
suppose it's an untrusted value at this point (IMA never checked it's 
value for valid range?) an we should check it in asymmetric_verify then 
to cover both cases? Or you want to check it individually?

> 
>> +	struct public_key_signature pks = {
>> +		.m = (u8 *)&file_id,
>> +		.m_size = sizeof(file_id) - (HASH_MAX_DIGESTSIZE - digest_size),
>> +		.s = hdr->sig,
>> +		.s_size = siglen - sizeof(*hdr),
>> +		.pkey_algo = pk->pkey_algo,
>> +		.hash_algo = "none",
>> +		.encoding = encoding,
>> +	};
>> +	int ret;
>> +
>> +	if (hdr->type != IMA_VERITY_DIGSIG &&
>> +	    hdr->type != EVM_IMA_XATTR_DIGSIG &&
>> +	    hdr->type != EVM_XATTR_PORTABLE_DIGSIG)
>> +		return -EINVAL;
>> +
>> +	if (pks.s_size != be16_to_cpu(hdr->sig_size))
>> +		return -EBADMSG;
>> +
>> +	memcpy(file_id.hash, digest, digest_size);
> 
> First check the hash algorithm is valid, before using digest_size.
> 
>> +
>> +	ret = verify_signature(key, &pks);
>> +	pr_debug("%s() = %d\n", __func__, ret);
>> +	return ret;
>> +}
>> +
>>   int asymmetric_verify_v3(struct key *keyring, const char *sig, int siglen,
>>   			 const char *data, int datalen, u8 algo)
>>   {
>>   	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
>>   	struct ima_max_digest_data hash;
>> +	const struct public_key *pk;
>> +	struct key *key;
>>   	int rc;
>>   
>> -	rc = calc_file_id_hash(hdr->type, algo, data, &hash);
>> -	if (rc)
>> -		return -EINVAL;
>> +	if (siglen <= sizeof(*hdr))
>> +		return -EBADMSG;
>> +
>> +	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
>> +	if (IS_ERR(key))
>> +		return PTR_ERR(key);
>>   
>> -	return asymmetric_verify(keyring, sig, siglen, hash.digest,
>> -				 hash.hdr.length);
>> +	pk = asymmetric_key_public_key(key);
> 
> Please add a test to check that 'pk' isn't null.
> 
>> +	if (!strncmp(pk->pkey_algo, "mldsa", 5)) {
>> +		rc = asymmetric_verify_v3_hashless(key, pk, "raw",
>> +						   sig, siglen, algo, data);
>> +	} else {
>> +		rc = calc_file_id_hash(hdr->type, algo, data, &hash);
>> +		if (rc) {
>> +			rc = -EINVAL;
>> +			goto err_exit;
>> +		}
>> +
>> +		rc = asymmetric_verify_common(key, pk, sig, siglen, hash.digest,
>> +					      hash.hdr.length);
>> +	}
>> +
>> +err_exit:
> 
> Normally a label named 'err*' would be preceded by a return.  Here, the label
> "err_exit" is always called, not only when there is an error.  Please rename the
> label to something more appropriate - out, cleanup, etc.

Ok, will call it 'out'.

> 
>> +	key_put(key);
>> +
>> +	return rc;
>>   }
> 
> thanks,
> 
> Mimi
> 


