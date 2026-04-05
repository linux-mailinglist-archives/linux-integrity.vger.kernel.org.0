Return-Path: <linux-integrity+bounces-9121-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGrpIHUv0mlFUAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9121-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Apr 2026 11:46:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EE39E013
	for <lists+linux-integrity@lfdr.de>; Sun, 05 Apr 2026 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62AE430086EC
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2026 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83341B6D1A;
	Sun,  5 Apr 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bj9BepNA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210D1F92E
	for <linux-integrity@vger.kernel.org>; Sun,  5 Apr 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775382386; cv=none; b=uObauQ0f6myAsmO4kX4yLCNcbZDTWhYYYKDILTl83MHV+hZHgPnu71GGe4BPuT52pXME4j1ODASeALqJ434tivo4v0EoPnkTuxGh43H+jeLkFRERXYa2QJT5ZileKTNo8+DpVa4s1DTtG+Rhe5jW00W3v+seHYDV5Cv/yQ+yeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775382386; c=relaxed/simple;
	bh=YzVK2g0iRHSCPN65dVWpouQkEsph4o/79GQ0dF/KqXY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=d2sPd/9RY77SoK9GWc8EiN0Zgvlk1Ti6NNCrcSNxEgaoy4wvOHARek9FqV0GhzghOHg2yoeOLSlT9nJ9GKkg80qjriQVTRzttKTppiDJDKo7fHNMAX+2UdQxYjiWAm3fqFvzaGHqKH801seDykpiYcV4bw3hTTFdiPuuBcB12+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bj9BepNA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6351t9VQ1439413;
	Sun, 5 Apr 2026 09:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/JrWBV
	aBfwnHUd0q8ZmJAwO/eZQeN1XbPVDJZUvLDCo=; b=Bj9BepNA3RHd99ayCMmU6g
	F2PBzDg7dpblJJ1t75e/olp3sD/MXOkeToVlK7ADpTa5YbnuOna088N0ZgtdYEnl
	sTk6TauOWuyIA9mn8MNSRJiPDCqXyxAsST0apv6rNJe5cDaFHo7xf9f5J78gjidJ
	zXGnB/IpehWYgPV2FyTrdYYI2UVp4wgwY6e9x/fXKQ3EtO1j8rzK+G/+tY1kPXol
	RD80Ge21T5wBsAY9M7u3PfaGDjMEEsToKvM/kih1tWBpCn+dOMQoem6ig52gSXsd
	aiGIyGMB/CpgSMD+zFoKLTKbBkrOCERVuG1WadcjCY7ZXUDuZN3PUKlllByuGFeg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2k6cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 09:46:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63594ve4020298;
	Sun, 5 Apr 2026 09:46:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdyn8ys6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 09:46:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6359kEkZ30540342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 09:46:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12E5E58056;
	Sun,  5 Apr 2026 09:46:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED5FB58052;
	Sun,  5 Apr 2026 09:46:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Apr 2026 09:46:12 +0000 (GMT)
Message-ID: <d57329c163a9e1427206ae1ab60720d7ae7e07d8.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] ima: Define asymmetric_verify_v3() to verify IMA
 sigv3 signatures
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260330201336.GE4303@sol>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
	 <20260324203929.2475782-2-zohar@linux.ibm.com> <20260330201336.GE4303@sol>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Apr 2026 05:46:11 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDA5MyBTYWx0ZWRfX9GgOeHt1rQDv
 AgP+ecmUM49bWtBukUup04czkM01xy6etEm8SNyUhJ52AEbts4x7YnpmaiPau+eFAwlBHXS4Re8
 nvR9/ExE0TaFzQ7dqDddBtDgsDBVM38ywdpvb21H3kRk9nhO33CkOS7g0cqRh0Zy+L4tFTlfODj
 xGpUMbOUnhdV9gDaqrRLDaEVm3D75XlrHT/DR6Gy4NA0knA9FUn1pjJGWvqZqwLBPY/fI+l/Snw
 g4MPIRCChAQjE7LjW7qbQRR2Zf87YU11eEORa9ufnHyiNLHbj0hyBWzIt0LPs8DV2NS0KENG0aB
 tjNupyoS4jMXQ+hParhoRokyoxl0oEnJCZOkrQg452XDGmYtGce95Me2oVksVEFejqkDrRKNwbC
 AtKTY+8PN8gMJJonpMRqVrMljbM5cRKHogoj933PAc10xfaAiS8cfFwRNRlTPMaZHMoJ3Og49Cg
 HEoYFa+bIsGYGTfv+fQ==
X-Proofpoint-GUID: YR3c2X_DNaOVaTy6Jtq3kzorsc7bkum2
X-Proofpoint-ORIG-GUID: YR3c2X_DNaOVaTy6Jtq3kzorsc7bkum2
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d22f68 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KLiygr_y7qZakWKfXh0A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050093
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9121-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DE2EE39E013
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-30 at 13:13 -0700, Eric Biggers wrote:
> On Tue, Mar 24, 2026 at 04:39:27PM -0400, Mimi Zohar wrote:
> > + * IMA signature version 3 disambiguates the data that is signed by
> > + * indirectly signing the hash of the ima_file_id structure data.
>=20
> The right way to think about it is that it's the ima_file_id itself that
> is being signed and verified, and taking the hash of it is only a
> workaround for legacy algorithms that can only sign and verify hashes.
> With modern algorithms like Ed25519 and ML-DSA that accept
> arbitrary-length messages, that workaround won't be needed.

I'll keep that in mind.  As previously discussed, the hashes are being
calculated for other purposes, like inclusion in the IMA measurement list a=
nd
the audit log.  Providing the potentially large, variable sized data so tha=
t the
crypto signing/verifying algorithm can recalculate the hash is superfluous.=
=20
Your recommendation of signing the ima_file_id works nicely.

thanks!

Mimi

