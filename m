Return-Path: <linux-integrity+bounces-8507-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLOGAVAQlGnC/gEAu9opvQ
	(envelope-from <linux-integrity+bounces-8507-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Feb 2026 07:53:04 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66007149121
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Feb 2026 07:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D4FC3013A5F
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Feb 2026 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CE1FC7C5;
	Tue, 17 Feb 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="btVO8xDh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6B5FDA7;
	Tue, 17 Feb 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311180; cv=none; b=Jf1pKbCqBrCNebfxISGDAHuFh3TS5Cn4H+O4hTDjPPhFEGB5z+dlISqRmCnwYOhWDlAyIFlA4xtDTii8o/s6iqvK2XLLlSoxdr8EajUnbWl76/FpGU2VnznVSTnJeK6Hcp+OL6DusmTXPGLoigSmoAeuNbiQzEELU9bQhw9VrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311180; c=relaxed/simple;
	bh=NWlhU+VZAdoMQgB4qo7AOJYsrhpnlsY7uHuvDHi1xR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnLXBmg90fqKVmCQuQzeHH09M9MRwbuYz9wYSswA38t/AseB9envrQ+sTZR7zhwHLz3Xdc6WP21QU7D41kvquihQtvVPoU9wPz65vNV3/7+wETp8QUYcThxKRIQvVVBcK/HoK74RKa8fFPSu0IuWPgzDUdVmH3zOzUke/Rs2Y8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=btVO8xDh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GDxonn3800571;
	Tue, 17 Feb 2026 06:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AAjhmf
	KkcZgG6YJce51j6QJpADLdJ8F7gWkbyez8V8c=; b=btVO8xDhB+2iVuGFuXErzy
	7e0YmXKyaHU+EvZvLzZuFUVXTuXw89A+e/ZgKEdAg8YBXlS/jkLOHoLLMxs+LKED
	liBVkLB92aGLri1NDfMgoX/bZwDSRft0zlkscgaRqhMak8dysBDIROUm6jhFof3C
	d0/jr8A/7zcPYme8gJUlqJUPJwspRQYjWwRrkfOCc8aTE/oa0i2hfsqwH0ShAcNP
	FbaLKLHvHHka8knleFs1chEbfTTmcQ2b1Xs82la1lydvL6jlfJwtfTo1M2k9RW9s
	jnA0+6PyVU1zO/LpuuNj+P+UVyBplgsgnOahfA4398frety2qB40Qp6736d4IoKg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcja1c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 06:52:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H3DvNx001419;
	Tue, 17 Feb 2026 06:52:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2b9dhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 06:52:48 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61H6qkog31916578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 06:52:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24995805A;
	Tue, 17 Feb 2026 06:52:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532725803F;
	Tue, 17 Feb 2026 06:52:43 +0000 (GMT)
Received: from [9.39.26.105] (unknown [9.39.26.105])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 06:52:42 +0000 (GMT)
Message-ID: <6f53ba98-ca01-47f0-978f-809ef01917f0@linux.ibm.com>
Date: Tue, 17 Feb 2026 12:22:39 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] keys/trusted_keys: move TPM-specific fields into
 trusted_tpm_options
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        nayna@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        Srish Srinivasan <ssrish@linux.ibm.com>
References: <20260123165504.461607-1-ssrish@linux.ibm.com>
 <20260123165504.461607-3-ssrish@linux.ibm.com> <aXZMLbQ2ykqPQp48@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <aXZMLbQ2ykqPQp48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gIXG3ZA-TAiKiXS5IEv7DlDkH-DqEA0_
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69941040 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=w09nOruQvyUnvy34TYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA1NCBTYWx0ZWRfX7oNaHed7uGR6
 zyYFkIOsjxbK/WWiYupp2N7NkoX8/2SBnnnhx0TBOViYRNNcovw6+vga2zzvDJHPETTZlmtKVR1
 vQAJKpPbW93q0FkGBF5zgCbmnj+aXJ3Ak5G5Ns5XD04CHpD5Xi8D/t7kF6scjyZUSX0qDGwnN1h
 i961QJjE3a7jgLsDktPTu8Cv3+NCD126SD4oC4TZCU/6XDjau8A+ZO7+qWnWLPhCqzlyEWvdUpe
 VBn924lOkLHT2TX5Aabt/L2h8CKp5Fikh39uvccNasZS0VWCxaQma144iQ2+n9T5D7NacnGbT8D
 vDo8VPsoO8DR3zk5q5xnB53Ef+VNR1qR6gBTQ+2h54/uINYJu3/wxPQXvFnZnp9jp7TrPexMF02
 vG9RfyjMd4vbHsYgSllnqGgsxhkqEPxdhiaHCROoxLFfZEsLQsg3MmMOIE5BUxYHLqn0Z1LCN2Q
 0vHEZVoMJnxFpqdJu0A==
X-Proofpoint-GUID: gIXG3ZA-TAiKiXS5IEv7DlDkH-DqEA0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-8507-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: 66007149121
X-Rspamd-Action: no action

Hi Jarkko,
thanks for taking a look.

And, apologies for the delayed response.

On 1/25/26 10:30 PM, Jarkko Sakkinen wrote:
> On Fri, Jan 23, 2026 at 10:25:04PM +0530, Srish Srinivasan wrote:
>> The trusted_key_options struct contains TPM-specific fields (keyhandle,
>> keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
>> policydigest_len, policydigest, and policyhandle). This leads to the
>> accumulation of backend-specific fields in the generic options structure.
>>
>> Define trusted_tpm_options structure and move the TPM-specific fields
>> there. Store a pointer to trusted_tpm_options in trusted_key_options's
>> private.
>>
>> No functional change intended.
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   include/keys/trusted-type.h               |  11 ---
>>   include/keys/trusted_tpm.h                |  14 +++
>>   security/keys/trusted-keys/trusted_tpm1.c | 103 ++++++++++++++--------
>>   security/keys/trusted-keys/trusted_tpm2.c |  62 ++++++++-----
>>   4 files changed, 121 insertions(+), 69 deletions(-)
>>
>> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
>> index 03527162613f..b80f250305b8 100644
>> --- a/include/keys/trusted-type.h
>> +++ b/include/keys/trusted-type.h
>> @@ -39,17 +39,6 @@ struct trusted_key_payload {
>>   
>>   struct trusted_key_options {
>>   	uint16_t keytype;
>> -	uint32_t keyhandle;
>> -	unsigned char keyauth[TPM_DIGEST_SIZE];
>> -	uint32_t blobauth_len;
>> -	unsigned char blobauth[TPM_DIGEST_SIZE];
>> -	uint32_t pcrinfo_len;
>> -	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
>> -	int pcrlock;
>> -	uint32_t hash;
>> -	uint32_t policydigest_len;
>> -	unsigned char policydigest[MAX_DIGEST_SIZE];
>> -	uint32_t policyhandle;
>>   	void *private;
>>   };
>>   
>> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
>> index 0fadc6a4f166..355ebd36cbfd 100644
>> --- a/include/keys/trusted_tpm.h
>> +++ b/include/keys/trusted_tpm.h
>> @@ -7,6 +7,20 @@
>>   
>>   extern struct trusted_key_ops trusted_key_tpm_ops;
>>   
>> +struct trusted_tpm_options {
>> +	uint32_t keyhandle;
>> +	unsigned char keyauth[TPM_DIGEST_SIZE];
>> +	uint32_t blobauth_len;
>> +	unsigned char blobauth[TPM_DIGEST_SIZE];
>> +	uint32_t pcrinfo_len;
>> +	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
>> +	int pcrlock;
>> +	uint32_t hash;
>> +	uint32_t policydigest_len;
>> +	unsigned char policydigest[MAX_DIGEST_SIZE];
>> +	uint32_t policyhandle;
>> +};
>> +
>>   int tpm2_seal_trusted(struct tpm_chip *chip,
>>   		      struct trusted_key_payload *payload,
>>   		      struct trusted_key_options *options);
>> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>> index 636acb66a4f6..0ab0234ebe37 100644
>> --- a/security/keys/trusted-keys/trusted_tpm1.c
>> +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> @@ -50,12 +50,14 @@ enum {
>>   #if TPM_DEBUG
>>   static inline void dump_options(struct trusted_key_options *o)
>>   {
>> +	struct trusted_tpm_options *tpm_opts = o->private;
>
> TPM context is obvious i.e., actually private would be a better name.


Noted. Will make the change.


>
>> +
>>   	pr_info("sealing key type %d\n", o->keytype);
>> -	pr_info("sealing key handle %0X\n", o->keyhandle);
>> -	pr_info("pcrlock %d\n", o->pcrlock);
>> -	pr_info("pcrinfo %d\n", o->pcrinfo_len);
>> +	pr_info("sealing key handle %0X\n", tpm_opts->keyhandle);
>> +	pr_info("pcrlock %d\n", tpm_opts->pcrlock);
>> +	pr_info("pcrinfo %d\n", tpm_opts->pcrinfo_len);
>>   	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
>> -		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
>> +		       16, 1, tpm_opts->pcrinfo, tpm_opts->pcrinfo_len, 0);
>>   }
> Should be replaced with pr_debug() and KERN_DEBUG as precursory patch
> (and remove TPM_DEBUG).


Will fix this, and make it a preparatory clean-up patch.


>
>>   
>>   static inline void dump_sess(struct osapsess *s)
>> @@ -624,6 +626,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>>   static int key_seal(struct trusted_key_payload *p,
>>   		    struct trusted_key_options *o)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	struct tpm_buf tb;
>>   	int ret;
>>   
>> @@ -634,9 +637,12 @@ static int key_seal(struct trusted_key_payload *p,
>>   	/* include migratable flag at end of sealed key */
>>   	p->key[p->key_len] = p->migratable;
>>   
>> -	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
>> +	tpm_opts = o->private;
> Not sure why this is not done in the declaration.


Will fix this.


>
>> +
>> +	ret = tpm_seal(&tb, o->keytype, tpm_opts->keyhandle, tpm_opts->keyauth,
>>   		       p->key, p->key_len + 1, p->blob, &p->blob_len,
>> -		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
>> +		       tpm_opts->blobauth, tpm_opts->pcrinfo,
>> +		       tpm_opts->pcrinfo_len);
>>   	if (ret < 0)
>>   		pr_info("srkseal failed (%d)\n", ret);
>>   
>> @@ -650,6 +656,7 @@ static int key_seal(struct trusted_key_payload *p,
>>   static int key_unseal(struct trusted_key_payload *p,
>>   		      struct trusted_key_options *o)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	struct tpm_buf tb;
>>   	int ret;
>>   
>> @@ -657,8 +664,10 @@ static int key_unseal(struct trusted_key_payload *p,
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
>> -			 o->blobauth, p->key, &p->key_len);
>> +	tpm_opts = o->private;
>> +
>> +	ret = tpm_unseal(&tb, tpm_opts->keyhandle, tpm_opts->keyauth, p->blob,
>> +			 p->blob_len, tpm_opts->blobauth, p->key, &p->key_len);
>>   	if (ret < 0)
>>   		pr_info("srkunseal failed (%d)\n", ret);
>>   	else
>> @@ -695,6 +704,7 @@ static const match_table_t key_tokens = {
>>   static int getoptions(char *c, struct trusted_key_payload *pay,
>>   		      struct trusted_key_options *opt)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	substring_t args[MAX_OPT_ARGS];
>>   	char *p = c;
>>   	int token;
>> @@ -710,7 +720,9 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   	if (tpm2 < 0)
>>   		return tpm2;
>>   
>> -	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>> +	tpm_opts = opt->private;
>> +
> I'd remove this empty line.


Will fix this.


>
>> +	tpm_opts->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>>   
>>   	if (!c)
>>   		return 0;
>> @@ -724,11 +736,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   
>>   		switch (token) {
>>   		case Opt_pcrinfo:
>> -			opt->pcrinfo_len = strlen(args[0].from) / 2;
>> -			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
>> +			tpm_opts->pcrinfo_len = strlen(args[0].from) / 2;
>> +			if (tpm_opts->pcrinfo_len > MAX_PCRINFO_SIZE)
>>   				return -EINVAL;
>> -			res = hex2bin(opt->pcrinfo, args[0].from,
>> -				      opt->pcrinfo_len);
>> +			res = hex2bin(tpm_opts->pcrinfo, args[0].from,
>> +				      tpm_opts->pcrinfo_len);
>>   			if (res < 0)
>>   				return -EINVAL;
>>   			break;
>> @@ -737,12 +749,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			if (res < 0)
>>   				return -EINVAL;
>>   			opt->keytype = SEAL_keytype;
>> -			opt->keyhandle = handle;
>> +			tpm_opts->keyhandle = handle;
>>   			break;
>>   		case Opt_keyauth:
>>   			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
>>   				return -EINVAL;
>> -			res = hex2bin(opt->keyauth, args[0].from,
>> +			res = hex2bin(tpm_opts->keyauth, args[0].from,
>>   				      SHA1_DIGEST_SIZE);
>>   			if (res < 0)
>>   				return -EINVAL;
>> @@ -753,21 +765,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			 * hex strings.  TPM 2.0 authorizations are simple
>>   			 * passwords (although it can take a hash as well)
>>   			 */
>> -			opt->blobauth_len = strlen(args[0].from);
>> +			tpm_opts->blobauth_len = strlen(args[0].from);
>>   
>> -			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
>> -				res = hex2bin(opt->blobauth, args[0].from,
>> +			if (tpm_opts->blobauth_len == 2 * TPM_DIGEST_SIZE) {
>> +				res = hex2bin(tpm_opts->blobauth, args[0].from,
>>   					      TPM_DIGEST_SIZE);
>>   				if (res < 0)
>>   					return -EINVAL;
>>   
>> -				opt->blobauth_len = TPM_DIGEST_SIZE;
>> +				tpm_opts->blobauth_len = TPM_DIGEST_SIZE;
>>   				break;
>>   			}
>>   
>> -			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
>> -				memcpy(opt->blobauth, args[0].from,
>> -				       opt->blobauth_len);
>> +			if (tpm2 &&
>> +			    tpm_opts->blobauth_len <=
>> +				sizeof(tpm_opts->blobauth)) {
>> +				memcpy(tpm_opts->blobauth, args[0].from,
>> +				       tpm_opts->blobauth_len);
>>   				break;
>>   			}
>>   
>> @@ -785,14 +799,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			res = kstrtoul(args[0].from, 10, &lock);
>>   			if (res < 0)
>>   				return -EINVAL;
>> -			opt->pcrlock = lock;
>> +			tpm_opts->pcrlock = lock;
>>   			break;
>>   		case Opt_hash:
>>   			if (test_bit(Opt_policydigest, &token_mask))
>>   				return -EINVAL;
>>   			for (i = 0; i < HASH_ALGO__LAST; i++) {
>>   				if (!strcmp(args[0].from, hash_algo_name[i])) {
>> -					opt->hash = i;
>> +					tpm_opts->hash = i;
>>   					break;
>>   				}
>>   			}
>> @@ -804,14 +818,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			}
>>   			break;
>>   		case Opt_policydigest:
>> -			digest_len = hash_digest_size[opt->hash];
>> +			digest_len = hash_digest_size[tpm_opts->hash];
>>   			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
>>   				return -EINVAL;
>> -			res = hex2bin(opt->policydigest, args[0].from,
>> +			res = hex2bin(tpm_opts->policydigest, args[0].from,
>>   				      digest_len);
>>   			if (res < 0)
>>   				return -EINVAL;
>> -			opt->policydigest_len = digest_len;
>> +			tpm_opts->policydigest_len = digest_len;
>>   			break;
>>   		case Opt_policyhandle:
>>   			if (!tpm2)
>> @@ -819,7 +833,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			res = kstrtoul(args[0].from, 16, &handle);
>>   			if (res < 0)
>>   				return -EINVAL;
>> -			opt->policyhandle = handle;
>> +			tpm_opts->policyhandle = handle;
>>   			break;
>>   		default:
>>   			return -EINVAL;
>> @@ -830,6 +844,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   
>>   static struct trusted_key_options *trusted_options_alloc(void)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	struct trusted_key_options *options;
>>   	int tpm2;
>>   
>> @@ -842,14 +857,23 @@ static struct trusted_key_options *trusted_options_alloc(void)
>>   		/* set any non-zero defaults */
>>   		options->keytype = SRK_keytype;
>>   
>> -		if (!tpm2)
>> -			options->keyhandle = SRKHANDLE;
>> +		tpm_opts = kzalloc(sizeof(*tpm_opts), GFP_KERNEL);
>> +		if (!tpm_opts) {
>> +			kfree_sensitive(options);
>> +			options = NULL;
>> +		} else {
>> +			if (!tpm2)
>> +				tpm_opts->keyhandle = SRKHANDLE;
>> +
>> +			options->private = tpm_opts;
>> +		}
>>   	}
>>   	return options;
>>   }
>>   
>>   static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>>   {
>> +	struct trusted_tpm_options *tpm_opts = NULL;
>>   	struct trusted_key_options *options = NULL;
>>   	int ret = 0;
>>   	int tpm2;
>> @@ -867,7 +891,9 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>>   		goto out;
>>   	dump_options(options);
>>   
>> -	if (!options->keyhandle && !tpm2) {
>> +	tpm_opts = options->private;
>> +
>> +	if (!tpm_opts->keyhandle && !tpm2) {
>>   		ret = -EINVAL;
>>   		goto out;
>>   	}
>> @@ -881,20 +907,22 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>>   		goto out;
>>   	}
>>   
>> -	if (options->pcrlock) {
>> -		ret = pcrlock(options->pcrlock);
>> +	if (tpm_opts->pcrlock) {
>> +		ret = pcrlock(tpm_opts->pcrlock);
>>   		if (ret < 0) {
>>   			pr_info("pcrlock failed (%d)\n", ret);
>>   			goto out;
>>   		}
>>   	}
>>   out:
>> +	kfree_sensitive(options->private);
>>   	kfree_sensitive(options);
>>   	return ret;
>>   }
>>   
>>   static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>>   {
>> +	struct trusted_tpm_options *tpm_opts = NULL;
>>   	struct trusted_key_options *options = NULL;
>>   	int ret = 0;
>>   	int tpm2;
>> @@ -912,7 +940,9 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>>   		goto out;
>>   	dump_options(options);
>>   
>> -	if (!options->keyhandle && !tpm2) {
>> +	tpm_opts = options->private;
>> +
>> +	if (!tpm_opts->keyhandle && !tpm2) {
>>   		ret = -EINVAL;
>>   		goto out;
>>   	}
>> @@ -924,14 +954,15 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>>   	if (ret < 0)
>>   		pr_info("key_unseal failed (%d)\n", ret);
>>   
>> -	if (options->pcrlock) {
>> -		ret = pcrlock(options->pcrlock);
>> +	if (tpm_opts->pcrlock) {
>> +		ret = pcrlock(tpm_opts->pcrlock);
>>   		if (ret < 0) {
>>   			pr_info("pcrlock failed (%d)\n", ret);
>>   			goto out;
>>   		}
>>   	}
>>   out:
>> +	kfree_sensitive(options->private);
>>   	kfree_sensitive(options);
>>   	return ret;
>>   }
>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> index 6340823f8b53..568c4af9010c 100644
>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> @@ -24,6 +24,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   			   struct trusted_key_options *options,
>>   			   u8 *src, u32 len)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	const int SCRATCH_SIZE = PAGE_SIZE;
>>   	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>>   	u8 *work = scratch, *work1;
>> @@ -46,7 +47,9 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>>   			       asn1_oid_len(tpm2key_oid));
>>   
>> -	if (options->blobauth_len == 0) {
>> +	tpm_opts = options->private;
>> +
>> +	if (tpm_opts->blobauth_len == 0) {
>>   		unsigned char bool[3], *w = bool;
>>   		/* tag 0 is emptyAuth */
>>   		w = asn1_encode_boolean(w, w + sizeof(bool), true);
>> @@ -69,7 +72,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   		goto err;
>>   	}
>>   
>> -	work = asn1_encode_integer(work, end_work, options->keyhandle);
>> +	work = asn1_encode_integer(work, end_work, tpm_opts->keyhandle);
>>   	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
>>   	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
>>   
>> @@ -102,6 +105,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>>   			   struct trusted_key_options *options,
>>   			   u8 **buf)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	int ret;
>>   	struct tpm2_key_context ctx;
>>   	u8 *blob;
>> @@ -120,8 +124,10 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>>   	if (!blob)
>>   		return -ENOMEM;
>>   
>> +	tpm_opts = options->private;
>> +
>>   	*buf = blob;
>> -	options->keyhandle = ctx.parent;
>> +	tpm_opts->keyhandle = ctx.parent;
>>   
>>   	memcpy(blob, ctx.priv, ctx.priv_len);
>>   	blob += ctx.priv_len;
>> @@ -233,6 +239,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>>   		      struct trusted_key_payload *payload,
>>   		      struct trusted_key_options *options)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	off_t offset = TPM_HEADER_SIZE;
>>   	struct tpm_buf buf, sized;
>>   	int blob_len = 0;
>> @@ -240,11 +247,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>>   	u32 flags;
>>   	int rc;
>>   
>> -	hash = tpm2_find_hash_alg(options->hash);
>> +	tpm_opts = options->private;
>> +
>> +	hash = tpm2_find_hash_alg(tpm_opts->hash);
>>   	if (hash < 0)
>>   		return hash;
>>   
>> -	if (!options->keyhandle)
>> +	if (!tpm_opts->keyhandle)
>>   		return -EINVAL;
>>   
>>   	rc = tpm_try_get_ops(chip);
>> @@ -268,18 +277,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>>   		goto out_put;
>>   	}
>>   
>> -	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>> +	rc = tpm_buf_append_name(chip, &buf, tpm_opts->keyhandle, NULL);
>>   	if (rc)
>>   		goto out;
>>   
>>   	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
>> -				    options->keyauth, TPM_DIGEST_SIZE);
>> +				    tpm_opts->keyauth, TPM_DIGEST_SIZE);
>>   
>>   	/* sensitive */
>> -	tpm_buf_append_u16(&sized, options->blobauth_len);
>> +	tpm_buf_append_u16(&sized, tpm_opts->blobauth_len);
>>   
>> -	if (options->blobauth_len)
>> -		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
>> +	if (tpm_opts->blobauth_len)
>> +		tpm_buf_append(&sized, tpm_opts->blobauth,
>> +			       tpm_opts->blobauth_len);
>>   
>>   	tpm_buf_append_u16(&sized, payload->key_len);
>>   	tpm_buf_append(&sized, payload->key, payload->key_len);
>> @@ -292,14 +302,15 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>>   
>>   	/* key properties */
>>   	flags = 0;
>> -	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
>> +	flags |= tpm_opts->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
>>   	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
>>   	tpm_buf_append_u32(&sized, flags);
>>   
>>   	/* policy */
>> -	tpm_buf_append_u16(&sized, options->policydigest_len);
>> -	if (options->policydigest_len)
>> -		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
>> +	tpm_buf_append_u16(&sized, tpm_opts->policydigest_len);
>> +	if (tpm_opts->policydigest_len)
>> +		tpm_buf_append(&sized, tpm_opts->policydigest,
>> +			       tpm_opts->policydigest_len);
>>   
>>   	/* public parameters */
>>   	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
>> @@ -373,6 +384,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>>   			 u32 *blob_handle)
>>   {
>>   	u8 *blob_ref __free(kfree) = NULL;
>> +	struct trusted_tpm_options *tpm_opts;
>>   	struct tpm_buf buf;
>>   	unsigned int private_len;
>>   	unsigned int public_len;
>> @@ -391,8 +403,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>>   		blob_ref = blob;
>>   	}
>>   
>> +	tpm_opts = options->private;
>> +
>>   	/* new format carries keyhandle but old format doesn't */
>> -	if (!options->keyhandle)
>> +	if (!tpm_opts->keyhandle)
>>   		return -EINVAL;
>>   
>>   	/* must be big enough for at least the two be16 size counts */
>> @@ -433,11 +447,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>>   		return rc;
>>   	}
>>   
>> -	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
>> +	rc = tpm_buf_append_name(chip, &buf, tpm_opts->keyhandle, NULL);
>>   	if (rc)
>>   		goto out;
>>   
>> -	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
>> +	tpm_buf_append_hmac_session(chip, &buf, 0, tpm_opts->keyauth,
>>   				    TPM_DIGEST_SIZE);
>>   
>>   	tpm_buf_append(&buf, blob, blob_len);
>> @@ -481,6 +495,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>>   			   struct trusted_key_options *options,
>>   			   u32 blob_handle)
>>   {
>> +	struct trusted_tpm_options *tpm_opts;
>>   	struct tpm_header *head;
>>   	struct tpm_buf buf;
>>   	u16 data_len;
>> @@ -502,10 +517,12 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>>   	if (rc)
>>   		goto out;
>>   
>> -	if (!options->policyhandle) {
>> +	tpm_opts = options->private;
>> +
>> +	if (!tpm_opts->policyhandle) {
>>   		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
>> -					    options->blobauth,
>> -					    options->blobauth_len);
>> +					    tpm_opts->blobauth,
>> +					    tpm_opts->blobauth_len);
>>   	} else {
>>   		/*
>>   		 * FIXME: The policy session was generated outside the
>> @@ -518,9 +535,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>>   		 * could repeat our actions with the exfiltrated
>>   		 * password.
>>   		 */
>> -		tpm2_buf_append_auth(&buf, options->policyhandle,
>> +		tpm2_buf_append_auth(&buf, tpm_opts->policyhandle,
>>   				     NULL /* nonce */, 0, 0,
>> -				     options->blobauth, options->blobauth_len);
>> +				     tpm_opts->blobauth,
>> +				     tpm_opts->blobauth_len);
>>   		if (tpm2_chip_auth(chip)) {
>>   			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
>>   		} else  {
>> -- 
>> 2.43.0
>>
> BR, Jarkko


I will shortly send out v2 with the changes.

Thanks,
Srish.


