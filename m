Return-Path: <linux-integrity+bounces-9002-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBz8FsjIuGnTjAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9002-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 04:21:44 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08A2A3243
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 04:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B4C30A282F
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A042C324C;
	Tue, 17 Mar 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fie2dKJh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AD2D1936;
	Tue, 17 Mar 2026 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717256; cv=none; b=tkVAT/OAiX18DSchJ0F1AonxGKCu5tZxmtETs7CxH4dA6dwTl4Q7/e7+49/urNBDK8IcS95wEpigxkP0Wpv5kaKVv2c6I2xtBmxuktgX1Gu57z3GNTr7pU5tehR3qI0pi0fi1O+O9yUToCJiYjoBhBNrbbhuXPArkEmmF1EGdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717256; c=relaxed/simple;
	bh=Hgvv2sMzviIsV5ayhpOLXlczyg1/nMnPBTWtKtUGjIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2ZNxSLVQ1CS/pWiemPmmw6/iDx7jnUD256+Iu3XR0ltaaPKQsQtTkgMqbEjI9qaxBE1sNX7Z7Ud31HpqjiLab6s4/I1TRXT7ug+XgqQEMmQuVqdxKecBBe5YUMIRIDElueqcQgDCoBCK+szNLJjVUWqCCcQ7JyHQQoWX0RqDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fie2dKJh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H0X9pp3176840;
	Tue, 17 Mar 2026 03:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BYrhz7
	7AlelDhFzZFk/8Tq75BeLNIKaJmT3DwxUnets=; b=Fie2dKJh1TnlA7ppPKNOva
	M6WApmALK1dUigITCnFmKeUuq3AfAWs4Xwumytpvkhmh5GTY+1uh48ewjUY4/ZkT
	2mCZAIz7FI1GIhX1OzXD0pEYcSpaXFphY4t5pOHViRc6dx8WpXC2TADBL9LSsiGO
	Tje5q1e7RwMkvKQ9Mik/3GowklT+htPe2DfJR3r2tfa9pr7a7ex13F83saD8UuBZ
	akANITX6llMc62h4Rk8iJL7wpKytBT7+ekGuvjeB50I/g3tFcyTupeSKRcAEmC/6
	PWmBSYKDfyJeNWhAIbEw+aBI5ATB5R/v9F5BdgQEcOWAFOifnReva5x6wSt4aFhg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3ctddf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 03:14:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H1MCMn004575;
	Tue, 17 Mar 2026 03:14:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s7g1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 03:14:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H3E8nd27066988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 03:14:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF9C5805D;
	Tue, 17 Mar 2026 03:14:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18E1C58056;
	Tue, 17 Mar 2026 03:14:05 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 03:14:04 +0000 (GMT)
Message-ID: <21cc6859-1750-4c22-91bb-116620764ca9@linux.ibm.com>
Date: Tue, 17 Mar 2026 08:44:03 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging
 in the tpm backend
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
 <20260220183426.80446-2-ssrish@linux.ibm.com>
 <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b8c702 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=jGS_jZea7UBjrvt4MQIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAyNSBTYWx0ZWRfXzLrFejMze+q7
 7vTx2T3Jbm/ssCwg6vki8X02yIx59v1T+pKDr2vvmJ9TtlZjFX+7vQItyd8BT1Wt5S7h2lzlhgj
 S4F/DjfPfIaXoJmojqSV1Joboj038broD9o0dpTKaby/o4lwj5WBadVdzjU/O8geMq7wxojojjJ
 fJdrskA0jh7M8JTD28T36OgE69QdlGXeNAiNIqZzOpbPbTZNIDP5HUPnJGYKgCDJJGxlw1a1iXz
 h+TyW4gF14YK/q5J8/Xvt7kiwPPIyA+o79/WZaDCEK4/uIHdY1KY0C2Xnx6JMTx3pMXwmHvQnaD
 Mue/pIIRaQcfPsA1/xReaxA4KbRbkaCnGDG/fyQru/yv1EIxnauQlqUA9Bm4qdV6D1x/rGccYYF
 7J2w4gW9c5BBQDvpQsOUO52z8sVYHRpUWpchy0xvm5i+qx16RTSNsD+9qGlo5kfCw2WmL+SOOdr
 uVTu9HgJ5nlieK8mtgQ==
X-Proofpoint-GUID: QE8ppXUkowZJqhn0dm_i5UNsmv1NZE-b
X-Proofpoint-ORIG-GUID: QE8ppXUkowZJqhn0dm_i5UNsmv1NZE-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170025
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9002-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: AE08A2A3243
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/10/26 4:15 AM, Nayna Jain wrote:
>
> On 2/20/26 1:34 PM, Srish Srinivasan wrote:
>> The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
>> for logging debug information.
>>
>> Replace pr_info() with pr_debug(), and use KERN_DEBUG for 
>> print_hex_dump().
>> Remove TPM_DEBUG.
>>
>> No functional change intended.
> There is functional change here.  This change allows secret and nonce 
> in the function dump_sess() to be logged to kernel logs when dynamic 
> debug is enabled. Previously, it was possible only in the debug builds 
> and not the production builds at runtime. With this change, it is 
> always there in production build. This can result in possible attack.


Hi Jarkko,
Could you please let us know your thoughts on this one?

And Nayna,
thanks for bringing this up.

thanks,
Srish.


>
> Instead of doing this change, I think add a comment to prevent this 
> sort of change in the future.
>
> Thanks & Regards,
>
>     - Nayna
>
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/keys/trusted-keys/trusted_tpm1.c | 40 +++++++----------------
>>   1 file changed, 12 insertions(+), 28 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm1.c 
>> b/security/keys/trusted-keys/trusted_tpm1.c
>> index c865c97aa1b4..216caef97ffc 100644
>> --- a/security/keys/trusted-keys/trusted_tpm1.c
>> +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> @@ -46,28 +46,25 @@ enum {
>>       SRK_keytype = 4
>>   };
>>   -#define TPM_DEBUG 0
>> -
>> -#if TPM_DEBUG
>>   static inline void dump_options(struct trusted_key_options *o)
>>   {
>> -    pr_info("sealing key type %d\n", o->keytype);
>> -    pr_info("sealing key handle %0X\n", o->keyhandle);
>> -    pr_info("pcrlock %d\n", o->pcrlock);
>> -    pr_info("pcrinfo %d\n", o->pcrinfo_len);
>> -    print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
>> +    pr_debug("sealing key type %d\n", o->keytype);
>> +    pr_debug("sealing key handle %0X\n", o->keyhandle);
>> +    pr_debug("pcrlock %d\n", o->pcrlock);
>> +    pr_debug("pcrinfo %d\n", o->pcrinfo_len);
>> +    print_hex_dump(KERN_DEBUG, "pcrinfo ", DUMP_PREFIX_NONE,
>>                  16, 1, o->pcrinfo, o->pcrinfo_len, 0);
>>   }
>>     static inline void dump_sess(struct osapsess *s)
>>   {
>> -    print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
>> +    print_hex_dump(KERN_DEBUG, "trusted-key: handle ", 
>> DUMP_PREFIX_NONE,
>>                  16, 1, &s->handle, 4, 0);
>> -    pr_info("secret:\n");
>> -    print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
>> +    pr_debug("secret:\n");
>> +    print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
>>                  16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
>> -    pr_info("trusted-key: enonce:\n");
>> -    print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
>> +    pr_debug("trusted-key: enonce:\n");
>> +    print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
>>                  16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
>>   }
>>   @@ -75,23 +72,10 @@ static inline void dump_tpm_buf(unsigned char 
>> *buf)
>>   {
>>       int len;
>>   -    pr_info("\ntpm buffer\n");
>> +    pr_debug("\ntpm buffer\n");
>>       len = LOAD32(buf, TPM_SIZE_OFFSET);
>> -    print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 
>> 0);
>> -}
>> -#else
>> -static inline void dump_options(struct trusted_key_options *o)
>> -{
>> -}
>> -
>> -static inline void dump_sess(struct osapsess *s)
>> -{
>> -}
>> -
>> -static inline void dump_tpm_buf(unsigned char *buf)
>> -{
>> +    print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 1, buf, 
>> len, 0);
>>   }
>> -#endif
>>     static int TSS_rawhmac(unsigned char *digest, const unsigned char 
>> *key,
>>                  unsigned int keylen, ...)

