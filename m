Return-Path: <linux-integrity+bounces-9146-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAsWNM2Q1mmiGQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9146-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 19:30:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356363BF961
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6ABE301457F
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDFD3B27CA;
	Wed,  8 Apr 2026 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ejwqzfZw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBC351C0B;
	Wed,  8 Apr 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669447; cv=none; b=Dw+304D6yX1ldfpS6uXsUkVWQpp0kxawl4acuM6Ci4ENFB1CFV2gAQeei7HCQFRzkIHo44wV/Hoy4Wsy10ELYQdTXSDvEuzJlPEQWcPgNtnptDXJ1W2aMXb3tP/M3tkPelgivE4NAovpyDUzsCy+dYLGYUZinQZ2TohemFIiNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669447; c=relaxed/simple;
	bh=V9Ysri9yBV0ssb6z7/sHiNxJ/2JfcKp9FBo2tQIxH+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abr1wnUkjlObOHFlLscU/siGttrrSLd8gedhbXMqRLvrhv2JdNYnmzEsGkyItkqhwnTc9MNrpoVawjb+nx+w2I3aVpv7+Y3Hv7p58AmbyTx6Bi79xAg2rlvEcyvEQjxTSEz0x1ieiFy1lNlTsNCDRB4PlwfGaOzDve+DqjyhcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ejwqzfZw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6387A5T22211023;
	Wed, 8 Apr 2026 17:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2L9Rxw
	LB5Yun5hkXaWCX44IyoaSD4xIhAzlmUoq9v0w=; b=ejwqzfZwSePmBP4I8Io3Fl
	/cHVf+lZCq0woEJbQzTW34oEGYs0cDbWL3qIK9VzNO4TVgoudL2UMxPdzltnAAD4
	2n4pHK6wxtUnw1fkwAJZlDRgxlANS8TczPDTwxioypCyalw9ORo3Hx29VLJ1eGSa
	MSxXosL45l58zlowEtrbx/p0kv6RhvMIAm7DlEjj0HPb4uSurB67AfRD8WAb24qE
	1UcDllUOFn2BgBOSm6Ztz3jvx/U3jynnoaPRs83aI+hh+uE8kMd+vrQlDGOBWsAF
	Ir6t0iVeYhslZmh0qxqoXRgaSBfJHanPNqpa+4ft2mvFra79XryNuk+LZP76d3+w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hgh9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:25:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638G0H1T018877;
	Wed, 8 Apr 2026 17:25:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9gakw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:25:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638HPJI025297424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 17:25:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE6FD58055;
	Wed,  8 Apr 2026 17:25:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AEFF5803F;
	Wed,  8 Apr 2026 17:25:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 17:25:18 +0000 (GMT)
Message-ID: <a38caed3-150c-4438-8ead-465c628899a4@linux.ibm.com>
Date: Wed, 8 Apr 2026 13:25:17 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: public_key: Remove check for valid hash_algo
 for ML-DSA keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, David Howells <dhowells@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20260405231224.4008298-1-stefanb@linux.ibm.com>
 <20260405231224.4008298-2-stefanb@linux.ibm.com> <20260406165350.GD2971@sol>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260406165350.GD2971@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MSBTYWx0ZWRfX/FNcyuAJmjFE
 2laY4tXIATjWXCFua5RH0zQWrG/l1CrUcNIfrNXIwv/V8jZyuQhn/WnJ9QEvIc8jO5JyNYdbyGY
 GXykXTAp+WCJItRjVgNYmpyI3yCuHK28ETctcXFQYDfTQ39HXVwXMSVRnBK2Srcnb/ltM1Rd84Z
 dUCXkhf8bq3ztt7IsZKED4VtOyvM4M2ZIYlxIr8i75cbxRR9yL8CETHLU+9BD8d5OIgWZTUtaKb
 IuNAwmG+8iEeCkVwN5/3beT9vwNbB6MbSX3Ac88qjsLaizkT2Lf1LYQ4BphpVX7Vap83fpHQOR3
 QdXRDY4Ulkn/MqpPHTQ9aAUV6DNxCOlIPZ09QQwRIirGBh8QA8No7UuWw1muPFJ/Se7OzMCeKr/
 s5RADDAR28NwTYZSFqXCLy8TJy8fko7E0UvCo0aPwW2N4EE54SLwmATLK0ehihUbazCYg7YEICK
 fqv+KLcwf5SUQmGOO8Q==
X-Proofpoint-GUID: P-YEUHDbPH_rP0TK97HeWmxXcwQ207Zo
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d68f81 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=SDgfmxtV1g6ypeqyy2kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P-YEUHDbPH_rP0TK97HeWmxXcwQ207Zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080161
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
	TAGGED_FROM(0.00)[bounces-9146-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.win:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid,wunner.de:email];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 356363BF961
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/6/26 12:53 PM, Eric Biggers wrote:
> On Sun, Apr 05, 2026 at 07:12:22PM -0400, Stefan Berger wrote:
>> Remove the check for the hash_algo since ML-DSA is only used in pure mode
>> and there is no relevance of a hash_algo for the input data.
>>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: Ignat Korchagin <ignat@linux.win>
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-crypto@vger.kernel.org
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   crypto/asymmetric_keys/public_key.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
>> index 09a0b83d5d77..df6918a77ab8 100644
>> --- a/crypto/asymmetric_keys/public_key.c
>> +++ b/crypto/asymmetric_keys/public_key.c
>> @@ -147,11 +147,6 @@ software_key_determine_akcipher(const struct public_key *pkey,
>>   		   strcmp(pkey->pkey_algo, "mldsa87") == 0) {
>>   		if (strcmp(encoding, "raw") != 0)
>>   			return -EINVAL;
>> -		if (!hash_algo)
>> -			return -EINVAL;
>> -		if (strcmp(hash_algo, "none") != 0 &&
>> -		    strcmp(hash_algo, "sha512") != 0)
>> -			return -EINVAL;
> 
> Does this broaden which hash algorithms are accepted for CMS signatures
> that use ML-DSA and contain signed attributes?

Right... dropping this patch and using the "none" route now.

> 
> - Eric
> 


