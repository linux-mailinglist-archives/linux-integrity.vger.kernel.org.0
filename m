Return-Path: <linux-integrity+bounces-9085-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UExEM8H8w2lXvQQAu9opvQ
	(envelope-from <linux-integrity+bounces-9085-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 16:18:25 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D42DA327BD9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBC2A30C79B1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C63C456B;
	Wed, 25 Mar 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y1202v4W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D828C869;
	Wed, 25 Mar 2026 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450579; cv=none; b=CXzlwEFu0pSVWTa/qZpsUUiUaO6wf+Q/8Cpz5iKHivb+aVs1mYJJ093pc/HexNFpHjNullst4/ZlnRCYxbJJM8XtY1GkUygw+6IXlasjD1y/scjCzg5BNrUTpUeAdd2xxGoQ1y2xtKOkaYDg0lgwvPGneNhpPRao68OUoBP18i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450579; c=relaxed/simple;
	bh=WwzWpqgtlmt1SpwOpw/O7QEKYO/35Ta68F+MuvhkvHY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Hqsqd7DHUFGSUBigBOWeWIgO/tGYEY/+sOPmTwyG4JmVPzsLoL/mKARb9enVjDZknJgFogVfM/q2+SatqQJlf+3CiXfQKao/+nuDoQAqg0JerjLhRINCkDjDXH/cyjRUZ33mxHAslFRJgvHGz+Se+K1vR/7h5GCFNdpFytbBLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y1202v4W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBDc7A561845;
	Wed, 25 Mar 2026 14:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1O6hI4
	qcBEdx9oCXoytQNf4dMuvnNfE147wzFOcjXxo=; b=Y1202v4WkQIg49AcnNJfaQ
	jjDbpw0tEv6CSsuk615C7H9QMvOlbLS8YxEK41rtc9rPa6W8Ig0JWrvIa7FQ2hDG
	9MxZ+gdamFyCVlBj89qLw22oUyzh7vesgdpFL0f1vQ1G3g9vVN1Eo1wnIlu4NClh
	j//Df0uDWlF0FQO43t2xrOFRp9b/ZxHoLsbZU0Rm8jVRqxwOX9C7HIUr8OriXo7F
	SNJAd963XB3FV0lA7k5YcY6eAqNxaCfXU6KxL6utTMMsiwA2cA1aDrfXYgM+EQCw
	+fCgctHHssUCu88m9Nvl0RexTPj/GbT+zb8UXRl3JWuyPy7dURZTxAosFRwmiXUQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky083jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 14:56:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAd1k2031631;
	Wed, 25 Mar 2026 14:56:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsy35f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 14:56:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PEu2lb32899590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 14:56:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207D85805A;
	Wed, 25 Mar 2026 14:56:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79A6F5805C;
	Wed, 25 Mar 2026 14:56:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.187.45])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 14:56:01 +0000 (GMT)
Message-ID: <3f9e7aa4e22ebaf38735a74b1912cf4601535791.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Allow sigv3 verification on
 EVM_XATTR_PORTABLE_DIGSIG
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        roberto.sassu@huawei.com
In-Reply-To: <20260325001051.754093-1-stefanb@linux.ibm.com>
References: <20260325001051.754093-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2026 10:56:00 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwNiBTYWx0ZWRfXzEPD4uoNoueP
 7K4SaOB3L768QAuotKnSk3FA3jOyLxle7mrm3fJOe0rYQD6DqBpMmV2o5FNEqNv+fjf4Mr+FrGY
 +AYSQjvvEbzrihipeMNCbQXBBciOM+JZneL8J/0puXhipRgsOG1hEuvqns2NbDqf/cRTscqCrfC
 GdpPjoMQUWz0YbRaodfE18K3PrHAW/ve8mZ57s64NQL3HkmIhVIaL9ZR5vBHVzr0dXXe9E3XOcs
 V2KkucedP3K9H/9qIYcVmldt2D77xVHcNR5gqdgdqsM8K+PKLIPxkQdrnNayufQXTubDyYR5sFF
 7QWUHwtvwWm9q22hliUXmnE3kw5qJEywdNdqWbN4ttjNQ98QY67cjgk0VeAWgAHFYsdx1Rwt55Y
 I7vCr10sAxyGf4fWeF5ZPVcVGARmwVGi3ZCLfWJl08dqlzdh/W8cesk8MimIk6AZh3rxJOLjhBN
 LK5uIk0fZISzM+xq2aA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3f783 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ptmlQRbomiGrh4vAHi0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dzLzVa_sz1Rk4m3p-Mku80EM3Mvcndip
X-Proofpoint-GUID: dzLzVa_sz1Rk4m3p-Mku80EM3Mvcndip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250106
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9085-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D42DA327BD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-24 at 20:10 -0400, Stefan Berger wrote:
> Allow sigv3 verification on EVM_XATTR_PORTABLE_DIGSIG on RSA, ECDSA,
> ECRDSA, and SM2 signatures.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.

IMA makes an exception allowing an EVM signature in lieu of an IMA signatur=
e,
when there is no IMA signature.  If the IMA policy rule requires an IMA sig=
v3
type signature, then EVM should also require a sigv3 type signature.

Currently any EVM signature type suffices.

Testing results:

#  EVM v2 type signature, with IMA hash (improperly succeeds)
evmctl sign --imahash -o --hashalgo sha256 --key <key> filename-v2

#  EVM v2 type signature, with IMA v2 type signature (fails properly)
evmctl sign --imasig -o --hashalgo sha256 --key f<key> filename-v2-imasig

# EVM v3 type signature, with IMA file hash (succeeds)
evmctl sign --v3 --imahash -o --hashalgo sha256 --key <key> filename-v3

# EVM v3 type signature, with IMA v3 type signature (succeeds)=20
evmctl sign --v3 --imasig -o --hashalgo sha256 --key <key> filename-v3-imas=
ig

Mimi


> ---
>  security/integrity/digsig_asymmetric.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/=
digsig_asymmetric.c
> index 6b21b9bf829e..6e68ec3becbd 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -154,7 +154,8 @@ static int calc_file_id_hash(enum evm_ima_xattr_type =
type,
>  	size_t file_id_size;
>  	int rc;
> =20
> -	if (type !=3D IMA_VERITY_DIGSIG && type !=3D EVM_IMA_XATTR_DIGSIG)
> +	if (type !=3D IMA_VERITY_DIGSIG && type !=3D EVM_IMA_XATTR_DIGSIG &&
> +	    type !=3D EVM_XATTR_PORTABLE_DIGSIG)
>  		return -EINVAL;
> =20
>  	tfm =3D crypto_alloc_shash(hash_algo_name[algo], 0, 0);
>=20
> base-commit: 3fa0dea50084da8279fb4b1175b3a9b4fc16f052

