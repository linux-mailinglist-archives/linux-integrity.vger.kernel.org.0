Return-Path: <linux-integrity+bounces-8557-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NEOO5hBn2laZgQAu9opvQ
	(envelope-from <linux-integrity+bounces-8557-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 19:38:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 143CB19C5BD
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 19:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4A4830299C3
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41C3DABE3;
	Wed, 25 Feb 2026 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n0ogOCAn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C233ECBEB;
	Wed, 25 Feb 2026 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044669; cv=none; b=jpANJ9/fCtN5CUVyjtpgEqoWOLHXw2G2gGho5dx664kRuJCNbltnft5vjiqZNTZLErAD7ae/UzNDc+zJsUXM3if+KNlsVM17ddKD2gKBDp4ltiSAXpwmBNqUoCEG9AAu0I8MfW7nuKhoUrX4UhmnaZm+LRm1e6LuXxNscs5Ew8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044669; c=relaxed/simple;
	bh=kgIkXix+021RYRrLeJUOdyBzFareGvYKJaQYHo+PH6g=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BoUkJPZFljtWfGmjNShVYEm0op+NzK+jmP1vYEX4eL0LW84PeGSh2pVMjZrOc+LFnklT8j/HQUBURDsy5TmV3cKP9LkKsGzBMTSie69bdgFGI6k2Ed27Dud9WU3oTOEcCkC1O89lzvpM3TD+pszmhztAInceZnDpfhgJmYxPN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n0ogOCAn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PC9XtD2848171;
	Wed, 25 Feb 2026 18:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RiHjwy
	IPIvAoJ2r0lQKIdeqSOPa/hMEPaI6bsLMadBg=; b=n0ogOCAn/zbHMIXJcds4Yb
	T7/DOIUNknhuVIRbadd2jPnX8m9aC7jtnWJ65BuSvbWCYWWGGKX25rSZeKNeTAko
	VWZoFngIFczwL5uCFXBTxyqo+zhI0vIMkkQRap41PO9YhQexHLScrW7NK4tNd8g7
	ZUAuFGfRkRi6t7eg5VWB9TO3PxKvxREr7EPQjgCBHQQCJaNLPeg0f/KhOvG0U7mV
	/Zm6yC1i2ECn/eagqYDY59RvlczLSnoHtwmnmAe+g/c1Nzp89R4Aw2mh0nhjta2Z
	O6AM33lg9kqQ4/F2cH9Wkt5cR7wAy1qvi9uqljWs14MwacNcPFufSQ0LuRH8A4zw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c93wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 18:37:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PGVJxq013478;
	Wed, 25 Feb 2026 18:37:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy6tsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 18:37:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PIbGGD40698490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 18:37:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 217385804B;
	Wed, 25 Feb 2026 18:37:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11AE058055;
	Wed, 25 Feb 2026 18:37:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.41.157])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 18:37:14 +0000 (GMT)
Message-ID: <55905382b88f00de0d7a82aff0605b6d0d9a1e8c.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Add digest_size field to ima_algo_desc structure
 and use to show meas.
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, devnull+dima.arista.com@kernel.org,
        Roberto
 Sassu	 <roberto.sassu@huawei.com>
In-Reply-To: <20260225125301.87996-1-roberto.sassu@huaweicloud.com>
References: <20260225125301.87996-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Feb 2026 13:37:14 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE3NCBTYWx0ZWRfX4r1hrnhENpKK
 kwvTqyD8u/z+zo7cP7GF6LT7ZUIvB/hXUXAyjCN3zDKEbXSQd4CzG51xOXMnFTjVJ6Sgdyg+Dqd
 KPDu20mmb8wzrKS6JWL9R1fHJRR9Yg3nBiV7dsIJjXn9UnWJlSs3R6TS6EspFwK7e5tPY8wEU9c
 2B1sndc8Z5ja9RMwYj2xVIH8gqLqUWvDUQSFzPppT8KTUV2qTY1xFDLiNZGZMk2AQUUo2UmYTEm
 CYJuG9+RGF1txoDGrlVxnrkzG6cxOSo2i8KKt3s7bqMuGQGBjisrqBXn3VNIRvn+74dPwBBuQWC
 UrmHQXKG2chDFHH+aYxgP6c9oBixAMMNVKn8NmBGc5Kk5LTqinURYbJy5cC08CjcaqpcWMmZ4C4
 XoFU4dKnUZRD+/YtuooDabIq/V9W2xl88COT4oUWhHOTvRpWJYu+hwlYMpvmgCfN/kZ3iGolW4V
 if4OdHPVGlaY2MhlBxQ==
X-Proofpoint-ORIG-GUID: RWhNM91VIvj2Oh4IluWsOS_z1H_WvNsX
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f415d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=i0EeH86SAAAA:8
 a=tQDo6FG_H1oQSaztVPsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Tayon7_p2jOMt5eU-ZNxJNvFYxqiki7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250174
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
	TAGGED_FROM(0.00)[bounces-8557-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,dima.arista.com];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 143CB19C5BD
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 13:53 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Add the digest_size field to the ima_algo_desc structure to determine the
> digest size from the correct source.
>=20
> If the hash algorithm is among allocated PCR banks, take the value from t=
he
> TPM bank info; if the hash algorithm is SHA1, use the predefined value; i=
f
> the hash algorithm is the default one but not among the PCR banks, take t=
he
> digest size from the crypto subsystem (the default hash algorithm is
> checked when parsing the ima_hash=3D command line option).
>=20
> Finally, use the new information to correctly show the template digest in
> ima_measurements_show() and ima_ascii_measurements_show().
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.  The patch looks fine, other than the patch title.  Could =
it be
renamed as "ima: define and use a digest_size field in the ima_algo_desc
structure"?

thanks,

Mimi

