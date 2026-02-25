Return-Path: <linux-integrity+bounces-8558-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPTaA0xSn2k7aAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8558-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 20:49:32 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC019CEE2
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D5AB300579D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030E265621;
	Wed, 25 Feb 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c8P2eZzW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF82D7D42;
	Wed, 25 Feb 2026 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048880; cv=none; b=jIQrLCew7bGPj6omDu/JZWRpmGUfxzLfkPlt81hUglmMovGpXF4wI7Gu8IViNne5ZZzOhPKNWoin9eOC7ikXNxYO+4RbaAVCKnoFrp9X7zcgmYYlit3u4ImQJNPlAqxpo7N+sTbFeFY0XMMx/quY3FeclzaF0NiqQZ02lxYoNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048880; c=relaxed/simple;
	bh=O22QWGP20LdnFN1ot3oZsCxuyb5VBLUJPsrldlmzr+w=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=praz8ji/azFER+sV2skCJeVmaaaMqV3la3MA1A8j/h8avCQaHLUJJXpW/TALUin/vRkJ71hPKkws0/zyaXVU/wOq80fOeCf2SyQevmnSBqEPNhnQR1lny+K8kKWA9bEC4TaPNlBIjeK5l6dgk8oHuZZ6zgzs7sXC5wO8h800vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c8P2eZzW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PFxDM93169038;
	Wed, 25 Feb 2026 19:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N2RQ8y
	twqz+bfqkoBRJcUzFxpvIgM7cqnIpvddaqV4Y=; b=c8P2eZzWpRxp+19Rxx8Yyv
	BQRXY+s0uckHg/fUmzu5QOFwAKz/2tfYCQeGdql18F861R2xTB29zu5avd8oppmq
	kveBqYGImVxIyFE9YOAzU3kJpc4aVQf0ZaMOJnssT/rLeeXEeoRPzamFsfRE+ebf
	ep3KqRI2ugLD7QN4yUAEExCUEKsSXmVmA+0CG7d71CA7axy/Kp8mS04GCwh7YNB0
	tPWiV//JSIXhnMWPGCjrpOyIFdzfCmvOODp/Vbg4gZBNB/nZ/NVVrJa0WrE4p2Du
	TB5OO+5otwcvbctq6G6KFZXTVhoOx0wCp2XX6ddFskbQVqxJM9QqWyGCHYyJymXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr26wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 19:47:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PJGSMA015970;
	Wed, 25 Feb 2026 19:47:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sq7cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 19:47:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PJlYmm8061820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 19:47:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDAF58055;
	Wed, 25 Feb 2026 19:47:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C50E58043;
	Wed, 25 Feb 2026 19:47:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.41.157])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 19:47:33 +0000 (GMT)
Message-ID: <497680e302e67a51a3163371c81e8eea7fa4d258.camel@linux.ibm.com>
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
In-Reply-To: <55905382b88f00de0d7a82aff0605b6d0d9a1e8c.camel@linux.ibm.com>
References: <20260225125301.87996-1-roberto.sassu@huaweicloud.com>
	 <55905382b88f00de0d7a82aff0605b6d0d9a1e8c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Feb 2026 14:47:32 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: laX0fGb_8p9vh2khuoe6pvSwOWAN1v7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4OCBTYWx0ZWRfX9w39UptBD/aP
 XTFaoskvJRYriuluqBeELFR8YrBFgO+Iq5TPkCkbvkwdmzAzFrbw8FDoWUoqCqo8gxAIpEFVEg9
 MQfgT6GIbX291GpKkUjgXhVPASSt1TvdJPCE+aLn5/JXxeZVrh+vRWYV6T3WZKd5Lfr8Lh9ijTN
 olOoOSFXp8MBT1n/UoVaRNeZw3NXNnsRAbRC8cPI1krVZHc2xAXXLlDyPOUdmykpzTfr+2sDzfI
 T5vdtPImTLG4MlCUxOczgE//T//MGmA1sibw3yyc09iJzh+3ZYy2HqgOUU0Jw4QgpDRxLs+ts8R
 JuLri1TU5LovfoHLFWoz41LGjwbzp8+Y6VfsCWMZi+dCs2MsUuM8HPLU3gLQGHD14S92NxMDC6p
 1LV3hmbMema/nBbO4ML6jvHXVxUW58SQdHTf8T9Ogd8E3Ls2ZbMuWw4NWUtiOV7WcLVivvbcDqn
 Iw69pG0g+3tmnygUKUA==
X-Proofpoint-GUID: wXN-FcpEa9qDt3dk5xd5rX0D2dt4_PW4
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699f51d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=i0EeH86SAAAA:8
 a=9tkCJDwMW1n1EJalk3EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huaweicloud.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	TAGGED_FROM(0.00)[bounces-8558-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,dima.arista.com];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5FEC019CEE2
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 13:37 -0500, Mimi Zohar wrote:
> On Wed, 2026-02-25 at 13:53 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Add the digest_size field to the ima_algo_desc structure to determine t=
he
> > digest size from the correct source.
> >=20
> > If the hash algorithm is among allocated PCR banks, take the value from=
 the
> > TPM bank info; if the hash algorithm is SHA1, use the predefined value;=
 if
> > the hash algorithm is the default one but not among the PCR banks, take=
 the
> > digest size from the crypto subsystem (the default hash algorithm is
> > checked when parsing the ima_hash=3D command line option).
> >=20
> > Finally, use the new information to correctly show the template digest =
in
> > ima_measurements_show() and ima_ascii_measurements_show().
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Thanks, Roberto.  The patch looks fine, other than the patch title.  Coul=
d it be
> renamed as "ima: define and use a digest_size field in the ima_algo_desc
> structure"?

The original design relied on the kernel's hash algorithm size.  This patch
changes it to use the TPM's hash algorithm size, without comparing it to th=
e
kernel's definition.

At minimum, this change in design should be noted above in the patch
description.

Mimi

