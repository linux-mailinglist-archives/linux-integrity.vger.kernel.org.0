Return-Path: <linux-integrity+bounces-8945-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE0uGlbhrmmoJgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8945-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 16:03:50 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 084AB23B354
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64F4B301688D
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Mar 2026 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3C3D6CC3;
	Mon,  9 Mar 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AsHjFMOo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3924CB5B;
	Mon,  9 Mar 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068627; cv=none; b=cuEIUdPB7dQ/yLhCcBugSDXGo0Wb0XGz9JpL1O/QexzQL+bEGR3v9mXhATs9TPGHi+K7gbu4pphCsfx4HuB4F0/nY48jCgTl5Y4CogwFzleea5bv/u1a88pSfKTFL3jrWJEqcycp3EsAnP0U6rkXjGSsmczcAWC9Cq33iAF8Cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068627; c=relaxed/simple;
	bh=v3V5rCmeVn3IzbzYe5qev136OY/Euq/d1vMjniSvgxw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mn90gzBgdBeOtduataBw2oja3kqXde8WLIwzeh1pnw09T75SxontOd6mG3MYPGQ5BsAf/+zafZgnFtPIc5clXQ+T84sPawJltj7uvlF9Yo1LWuvyGvvVtIF0ARn/SsON89eW4kdcSlx/svUK8ic0mNT8twyRK2hbBR5dwEw6uFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AsHjFMOo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629F2mEw1388081;
	Mon, 9 Mar 2026 15:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZNJKlr
	VlSko0ol3nwVaI7Fijz9Jj4uWjP1XI5hq2znw=; b=AsHjFMOoiYu75wC1viORnE
	SuK8wt3HXVSB7sNg65NqRfOLiznPf/fKteBsN40EWjt4iikjh8sN9JHmrabTIyGD
	TrSAoHEbk50+ThjrAUTw2szfzuoC9g4VTW/s1k1IFk9WgCx/Oeka2XNS7MVkn9V1
	fJwUa/4jvha50VcmwbmXg9WShQezKoOJvVppg6neQH4/pexx9AQ5buf8i1+9AE2w
	9qtDwKFfOYKSNjTRuuKs70N45MqX0TVx19dfm2WaqjfMGXNZTSP3VqgRDGZS46ZS
	rOKCNWN6bzy2080VouuFTHoi+LhtixvNZ/LSiz0S+l+uAKpUMDO+vHAIyl1NUakw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun6vdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 15:03:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629DNmDd021181;
	Mon, 9 Mar 2026 15:03:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsnj9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 15:03:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629F3IpJ12124890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 15:03:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AD4A58054;
	Mon,  9 Mar 2026 15:03:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC9C5804E;
	Mon,  9 Mar 2026 15:03:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.138])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 15:03:16 +0000 (GMT)
Message-ID: <1430cdbe141e490a2bc3807217b2b3fc6ff75c11.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: check return value of crypto_shash_final() in
 boot aggregate
From: Mimi Zohar <zohar@linux.ibm.com>
To: Daniel Hodges <hodgesd@meta.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E .
 Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260201024015.2862236-1-hodgesd@meta.com>
References: <20260201024015.2862236-1-hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 11:03:16 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jgpcYFsNAgklDGB-hODIojkY6KELP7Bx
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69aee138 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VabnemYjAAAA:8
 a=8Ma1dfE5B6paNGL1HSAA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzNiBTYWx0ZWRfXwsOqiLQMx6R5
 98x0BtCjshPYdjEOEdNBSNPPKhfZSdzr1FeM71IJl+Uvkh6BCSQyRS6qgsMGY1ipnGiflRtXWwu
 pp8yTXBjS/R9HESt9ALf2QYfCgIg2SVzw4JixOH3fuO8eSY3OQY3PFaTpLIh81PouvvjyDxfQ7f
 uDItceHi7mynvYvrEE/MFKPjijnt7VWCldfoqzrSflCtX7DOBwUlfXjN7xbIeSqR6f6osFVIzZk
 MT99cUhR82MLdsiai0pLqhBBwbgpgIpLSuUHpMNToFIBo/42aBYQTZCDT6PXjXEQA4dabhA1xKy
 532aNxRv8EuskeYekspyZt/xdX6BuXr5pElHn3l/jyji6egKJc7hRUgVNgur/cvt12TFPJYA0dP
 yJjeJy4RJm7fIjwGEnej9YvUAiuGoIAG9QmrQiQZW7XMKRlGgY1TsBENh619IBjpr/ljED0NBGI
 jmFUMsvG6UDe7LxflHQ==
X-Proofpoint-ORIG-GUID: fxLlFURkkCQWe4mGgSF0T4yMjrnmRlP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090136
X-Rspamd-Queue-Id: 084AB23B354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[meta.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8945-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.980];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Sat, 2026-01-31 at 18:40 -0800, Daniel Hodges wrote:
> The return value of crypto_shash_final() is not checked in
> ima_calc_boot_aggregate_tfm(). If the hash finalization fails, the
> function returns success and a corrupted boot aggregate digest could
> be used for IMA measurements.
>=20
> Capture the return value and propagate any error to the caller.
>=20
> Fixes: 76bb28f6126f ("ima: use new crypto_shash API instead of old crypto=
_hash")
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>

Thanks, Daniel.  The patch is now queueud.

Mimi

