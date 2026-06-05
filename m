Return-Path: <linux-integrity+bounces-9751-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cVsWGFntImpRfQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9751-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 17:38:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F76495EB
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 17:38:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Ko279fa7;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9751-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9751-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEB9630A4B32
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07393C2B9B;
	Fri,  5 Jun 2026 15:28:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E118C332;
	Fri,  5 Jun 2026 15:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673318; cv=none; b=AjWZHHxk+yI90TGOKp2qmviRlOSQL/McGN6ykCpeBbQnd98/qi5mBUqi7GjA+vQ9iJfZR7Jhp+i9cADXeexxuK57nim22DgeO3TOPhBFR3BkiRHRB1zwXYsCdf0IoMZDWuX4Q5iRO66TbO60SaqvAm5hFmjgimwvvZJQgjDsVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673318; c=relaxed/simple;
	bh=eO5deUNjUsSs5uHgXTzBnq8zxoJQfniS/ft3jMquW7w=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Gi+cDud2dzWLZm2RMAW8FPTqWoyZX137Q95wNn9u0zVjdq2MzkZMkfu82bIAWnex8LE50EjRJYOwDJPCPKIfrdQJp9yiSYPhPFn3VFG1V/pHuFm2YPeUiV1FFanj/YIOKGhJUoR5cEno0I1H68a610bdKFDiqvemnMFuSGXgpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ko279fa7; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6554Uu0G1954705;
	Fri, 5 Jun 2026 15:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J5rAMw
	xoTisKP4BMXx13HaD/fZQ0TGgiSbOKO18Eqv0=; b=Ko279fa7fWCjJhcCbX7M1W
	68vOnMb5fdqnN7cnL32+vmjbQsFV7lhsCwoZZbl99wy7NB+e5QylvF55vxoB47EX
	wV3wD1aFQfkMdQQLA6Ywnh3I7/arCDR7ravQdRXzc0Nv5bgUUYTK6avkua9IubZo
	KT4mWCZD7D8v2AWop30dMQGX9TGvnJeh2ebif5KrudqWSFTwVjCkIxviETdOvUgv
	V3eRbYi/q2qGiLyJRQrX2G0IR8mxQ6cSQx9pqmkZ1YMSgPxMZygy2siGCgdGnb0P
	XSBsE1ctw48J5+ThW1pamuIVa3drX1Wby12OxK62j/9BXa+BQ6ZkcrScgyfPpQBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4n5x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 15:28:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655FO70r026361;
	Fri, 5 Jun 2026 15:28:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqht6d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 15:28:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655FS8x932899826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 15:28:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7046058052;
	Fri,  5 Jun 2026 15:28:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A4CB5805D;
	Fri,  5 Jun 2026 15:28:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.67.126])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 15:28:07 +0000 (GMT)
Message-ID: <e71b3b9f040683aee106ad87ebba81fe09ac7d15.camel@linux.ibm.com>
Subject: Re: [PATCH v6 10/12] ima: Add support for flushing the hash table
 when staging measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260602111401.1706052-11-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
	 <20260602111401.1706052-11-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 11:28:06 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE0OSBTYWx0ZWRfX7e5ir0Yx1UaU
 crW0ECr3PQiEn9XO+oFe1AqC+xP3mQpE5NTk0x2ZVGvmGeCs39gYdablVKt/yXecXRlOdYQyNB6
 dbf5PZwzIEUxG0bVB8f3y8iR4VCC2YhClpVoKHbWu6yjYgystiyBa3wEsJRFYA3t42mjuGBPkgT
 zzp9fFox1IrV3oSJBpMCkXxjy/x5HVg1VVERwmOprIRE4OdHqb8wHkjVSP2cPNM6ZlQMQ3/A82z
 tu6fv/a+J3ndrUnNI5OhVO9vSQmzK9GkUg/4JXFIWsq/Dd5tq7QXn7SGaoOeU3t0sLHEEDtMtwy
 GzI8iUdKP3RFysnTM62iArxzo38jdzAznTS1MXfE6T0xbaHm2vYMevnNzbqGT2KayaKfCbZo3xx
 /G6flSMQDJ7qOEQKbThhQb/5JXhhoDcktWv7OwMS8Rg/K/DfMCk5ahb0NWciJLktimoeRcaMJ2n
 V8+U98QL8bEy9iFm/8g==
X-Proofpoint-GUID: -1pYE27db3Vbmv2q3v0Z5dFSpnvtqzkD
X-Proofpoint-ORIG-GUID: J3enxJpe2beIGJaEbrew44OCw_pNPsQk
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a22eb0a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=C3CPiBWLnMe3MCAkXaYA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050149
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9751-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huaweicloud.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C42F76495EB

On Tue, 2026-06-02 at 13:13 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> During staging and delete, measurements are not completely deallocated.
> Their entry digest portion is kept and is still reachable with the hash
> table to detect duplicate records. If the number of records is significan=
t,
> this reduces the memory saving benefit of staging.
>=20
> Some users might be interested in achieving the best memory saving (the
> measurements are completely deallocated) at the cost of having duplicate
> records across the staged measurement lists. Duplicate records are still
> avoided within the current measurement list.
>=20
> Introduce the new kernel option ima_flush_htable to decide whether or not
> the digests of staged measurement records are flushed from the hash table=
,
> when they are deleted, to achieve the maximum memory saving.
>=20
> When the option is enabled, replace the old hash table with a new one,
> by calling ima_alloc_replace_htable(), and completely delete the
> measurements records.
>=20
> Note: This code derives from the Alt-IMA Huawei project, whose license is
>       GPL-2.0 OR MIT.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  security/integrity/ima/ima.h                  |  1 +
>  security/integrity/ima/ima_queue.c            | 41 ++++++++++++++++---
>  3 files changed, 42 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..aad318803f82 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2343,6 +2343,12 @@ Kernel parameters
>  			Use the canonical format for the binary runtime
>  			measurements, instead of host native format.
> =20
> +	ima_flush_htable  [IMA]
> +			Flush the IMA hash table when deleting all the
> +			staged measurement records, to achieve maximum
> +			memory saving at the cost of having duplicate
> +			records across the staged measurement lists.

Thank you for patch description, kernel doc, and Kconfig updates.

> +
>  	ima_hash=3D	[IMA]
>  			Format: { md5 | sha1 | rmd160 | sha256 | sha384
>  				   | sha512 | ... }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a05db5b18982..d2e740c8ff75 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -343,6 +343,7 @@ extern atomic_long_t ima_num_records[BINARY__LAST];
>  extern atomic_long_t ima_num_violations;
>  extern struct hlist_head __rcu *ima_htable;
>  extern struct mutex ima_extend_list_mutex;
> +extern bool ima_flush_htable;

Making ima_flush_htable global is only needed for "[PATCH v6 11/12] ima: Su=
pport
staging and deleting N measurements records", not here.  Please make it sta=
tic
here and change it to global as needed.

Mimi

