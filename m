Return-Path: <linux-integrity+bounces-9622-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ceovJlk5D2otIAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9622-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 18:56:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E5A5A9B64
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 18:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB9853052B5D
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA85368D7A;
	Thu, 21 May 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fEDWx77C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12236C0AC;
	Thu, 21 May 2026 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379612; cv=none; b=b3hyMM8bD3LnCLZiRblIZWFYbEqjF/ZJ60cqVgOeo/YLsuu1Ro7qChHoo8NVlORxHIy4zRXy6rAPoOEwgtgRR2YSvvGemPiTiozC27w0me38vlm728IdLU8rvclF6SHG56fJiS5lYIabfiTjYR2v3M06uYoDwvVr0nkPcirusDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379612; c=relaxed/simple;
	bh=F+h9A4DIYpq1O/RX6QOqxkjZmifyrZ3T+wElt+iDwoE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RkMKlKsVccvW+UZ3ssiOuBtoOD9e2x4Lei+jL68WZpeYGg1Qi2eh9t11EXjf7RTO78Z1iLLrKQV9Q/eDVo9LwboKVliYXf+XhV3lqRBaejQhZWtcB8Ucd71VMsFfOM9xbaxfY5x0TtUDW7Smc3Xr++d1Okf/gWTOZQd9J64XHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fEDWx77C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LA6Nap764296;
	Thu, 21 May 2026 16:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qTaNXW
	TikQqOePAqk42SMJotrFg8rUHuYpCOrc6eva8=; b=fEDWx77CCDQjYPM9hiTTnR
	nuCUpeXCoGDSG5qIWuZHb2HEWFy3H3xF5a5R/Pwdj7+IN+MuY6CUfoH63iP35tFA
	dIST1ssE80m8hXQkv0NkoJoI81n1YawGt2BqrgojvMUwoT16XinpD0AbjIAKcoLT
	5MANpd5cACERs4SzW0mAToLgOug0WftBT+5dbphjBURmmy7wpcERMNmfo5iawjYD
	Auz6pdeKt06P7RUXbtRuugO99AYoGnpy5O24dmHJf06fy4o9wiGxk7NiQILtsavy
	yQxiIqN/+u8Lx9l2RKSqHkX8ArAtVt+tdFZTqmPWXozfEOY5EOqE+mFG4kN7xqug
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawesr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 16:06:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LFs60A012857;
	Thu, 21 May 2026 16:06:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqda41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 16:06:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LG5tDR27656772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 16:05:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B43C58052;
	Thu, 21 May 2026 16:06:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB52A58045;
	Thu, 21 May 2026 16:06:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.128])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 16:06:22 +0000 (GMT)
Message-ID: <51b452d09199374a74d713ff8e8cd44150a59867.camel@linux.ibm.com>
Subject: Re: [PATCH v5 10/13] ima: Add support for flushing the hash table
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
In-Reply-To: <20260429160319.4162918-11-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-11-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 12:06:22 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2MiBTYWx0ZWRfX7Wrra6AWT7c0
 9O7K3x9cqFyeJ1gbRAdz1XZMMbWjgQ6jCQvatmF3KxjrT/QkIIXwKrsFM2SLqjIS5Jfgw8v6Z3H
 5rEjtBjAH6/Wfki9bbFEgd+zHGUEULAN/2ndsyPaVhhK1DbngwTSqmq6Wsvy5wVA6XSlsE3nZro
 2S6KUiPwjOO5XJLwX8OK4yO6ISCvDOvHqzB2U65CsLagBLrnfH6BupRSV/bZyK3gJKKU3ihVyQQ
 mIW7XZyC/2tLKSjk6z1Bq6PA7w2DrPjEiBMNX6t7oOopwqhnVIrnXJtHlBBAZmF7tr+Q/LctLZs
 ku0lMDBlVRF0PqSCDtSyJgVN7Co7uRms+EGgk7FfiiDr/NLGNgMQURH1ILl2AMltAvyob3s/n3f
 dV0loCj8F4pulM055iuXfEEj7AQyce7qnXw67ffZ9G2IIpXYvNfdyDMuDokBEJX0o1uvKVcKueq
 g72F9PxHbMp/C5d+E/Q==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f2d82 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=jVX5zv5zQ3_5VHjuTu4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rLNEtsnc1riP4Js2UoSFzkYXbat_2Ili
X-Proofpoint-GUID: CVW9GPJ-laOE7SM3E5PwCd_-sze2Yl-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210162
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9622-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 78E5A5A9B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the new kernel option ima_flush_htable to decide whether or not
> the digests of staged measurement entries are flushed from the hash table=
,
> when they are deleted.

Unless explicitly requested, the existing hash table is not cleared after
exporting the measurement list. Why is clearing the hash table configurable=
? =C2=A0
The boot command line option does not provide enough information to decide =
why
you would or wouldn't want to clear the hash table.  Please update the patc=
h
description and the boot command line option.

thanks,

Mimi

>=20
> When the option is enabled, replace the old hash table with a new one,
> by calling ima_alloc_replace_htable(), and completely delete the
> measurements entries.
>=20
> Note: This code derives from the Alt-IMA Huawei project, whose license is
>       GPL-2.0 OR MIT.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

