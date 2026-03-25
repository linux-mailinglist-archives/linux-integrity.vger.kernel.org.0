Return-Path: <linux-integrity+bounces-9084-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFJ0O3Upw2n2ogQAu9opvQ
	(envelope-from <linux-integrity+bounces-9084-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 01:16:53 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A031DF12
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 01:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BA48308F245
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE71D7995;
	Wed, 25 Mar 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nueLghgn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1F1E3DDE
	for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2026 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397762; cv=none; b=DB5DIIumgWsubgEsh0si5KwscKM31NhjGopg9/rX6SUZuET8iZbuAlLa6EK29NFZJjKZk4CtuSM5kC0NSfBf83gkwp59B7RSgxJaLmE3T5uFlB9MGBISxMJtkwI+KD73I0PHiolCODAKJUV5FsdTuHhTY+ZqTmyAkGuMSff1Qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397762; c=relaxed/simple;
	bh=gyuQrqDxl0ShZMJ/Gsc+C0TNyJyGyUiQWH33va9flnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm5vTRNjvQ20uPCH11BWYzZHXa7342B8UeC6jqdiArXwZlmt57rUu/AMdZL+FSKk2kKWrB7VSgbhb9GvogkTZTJcdnRmxIoyFra9ql0AFbPfy9x1ZjlWLtgeEJ7WUT2aSOs2GHVQP8TlbLynF3Kz/jI+Lf/Ad11ZrLfZ9PgMvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nueLghgn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ODO7qg2646739;
	Wed, 25 Mar 2026 00:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7wqvZu
	zBQ0+WHHc7+vJKMVRyhRJ3pH9EE0Wl/353UqU=; b=nueLghgnDoS8WDEGNF7tZ1
	D5j4U/y/9fULsrprsxH0KiLdmgW8gA3I3awqj1DvN+54llSdC+gzPfSSB0cIoeIL
	kVXKZIdQ+fYI6etHxhElb+TyTPsoQGyU5yoKtmG5WLnd11aWywFndyX4DxXEVXAt
	47xS06c8mEX1ZO98tXfgsDnTZofGuVs+R7UsD4ypcoz0YfPRjFzgvVOGPY+UP/N0
	BUGs319iv2OyjUGbH5ouCjwzlA6EqgGJzYxz3sQcCkf674RVuzQQsBOrxwnaC8N3
	BgzccBTxYOhIStDu0xgqesmH5xsbfWKTWP8cuavU1cBOI2+qL6eFlO9SgnAJld+w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky05ek7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 00:15:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OKlFBp004398;
	Wed, 25 Mar 2026 00:15:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c244v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 00:15:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P0Fqfx25231896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 00:15:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5AF758056;
	Wed, 25 Mar 2026 00:15:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7412058052;
	Wed, 25 Mar 2026 00:15:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 00:15:52 +0000 (GMT)
Message-ID: <35f4f73e-e261-4001-814f-4cff6adcd423@linux.ibm.com>
Date: Tue, 24 Mar 2026 20:15:52 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ima: add regular file data hash support for sigv3
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260324203929.2475782-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NCBTYWx0ZWRfX1kDaxaWDgQ8B
 XTKQhQu/NOWv/HfpHif9FkHX6eituQvgaoDKc2D8dV98Z9pa+0bvtR9ESPS23qideaqNeackiCC
 rUL4iyo9XlJgNEudbFHTGWR6OuPHTHukxg2mZKPlsxV9fIurMl2mzNFFY4FxS8c+aRXzWR8OTul
 QBogGIpSR8Qq+FdQOPZp1twXT3Lf89wXQvsL3EvqXAkklCeBMo3l4na4FrujjGwvyMM8yt3K/5W
 6Ir4Hlcrr7SjxJdwERED3ehGborb15INd4ppW2NAB5ekgmYpyVKohLNKJB900tu9i65OaE1b/mp
 gbPjXTuNIeXTbFHXPOAD6nvY3RvtwzKTvOv7hkdC7F2Phfydw3bGwpl34rGxxImY2JhUwHz58GJ
 QfO0og93FFOhG3Fnnm0Pknv71FzQL+w1wy0BYB4f32YoiFSLrDlEVzITFdiKR8iwNGxU6+/OvlO
 BthGWpiSWjr/350PsXQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3293b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_pRPkOYCL_UPi4XlPFUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fiAwczHATlW5SSV5kRCh16iCa5Vakeip
X-Proofpoint-GUID: fiAwczHATlW5SSV5kRCh16iCa5Vakeip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240184
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9084-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6A0A031DF12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/26 4:39 PM, Mimi Zohar wrote:
> IMA signature version 3 (sigv3) support was introduced to avoid file
> signature ambiguity. Instead of directly signing a raw fs-verity hash,
> IMA signs the hash of ima_file_id structure, containing the type of
> signature, the hash algorithm, and the hash.
> 
> Pure ML-DSA calculates and signs the hash directly rather than a
> pre-hashed digest. To avoid ML-DSA having to re-calculate the file data
> hash, Eric Biggers suggested signing the smaller ima_file_id structure.
> 
> This patch set adds the sigv3 support for regular file data hashes. A
> subsequent patch set will add the ML-DSA support.
> 
> Mimi Zohar (3):
>    ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
>    ima: add regular file data hash signature version 3 support
>    ima: add support to require IMA sigv3 signatures
> 
>   Documentation/ABI/testing/ima_policy   | 10 ++--
>   security/integrity/digsig.c            |  8 +--
>   security/integrity/digsig_asymmetric.c | 58 +++++++++++++++++++++
>   security/integrity/evm/evm_main.c      |  3 +-
>   security/integrity/ima/ima.h           |  1 +
>   security/integrity/ima/ima_appraise.c  | 72 ++++++++------------------
>   security/integrity/ima/ima_policy.c    | 22 ++++----
>   security/integrity/integrity.h         | 14 ++++-
>   8 files changed, 115 insertions(+), 73 deletions(-)
> 
> --
> 2.53.0
> 

Series:
Tested-by: Stefan Berger <stefanb@linux.ibm.com>



