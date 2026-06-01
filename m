Return-Path: <linux-integrity+bounces-9708-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NuOGv2PHWrFbwkAu9opvQ
	(envelope-from <linux-integrity+bounces-9708-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 15:58:21 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B531762063E
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 15:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA463068912
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485943AC0C8;
	Mon,  1 Jun 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F1KSkzuU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612C21146C;
	Mon,  1 Jun 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321695; cv=none; b=LQg8n9s6UuUQ+aytQ2kPCq3QS8Mvlk2hePz5A49COJqY4VaBJwjPyX+3HKwUYCD4M6VGu0rOB+PFdaUoXwLJSibGn7QgXaHXmIIcVS5uXOIUOTuL5V9h3JCaPKQ14L4BRkz2BKb6ekTYhGH9KP33etoundB0IeQ5rPWsdat+AJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321695; c=relaxed/simple;
	bh=2vmAIzG9BHkUizyncnDuRtl/fSNZ0M2tETutuUoNECA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ga0vrPXKtSYGWCvgROT+/6ZX669eaDn23V5UH6jKdydRk80rXOI03ZSjP34Aj3gYsDuTlVTP3jVphp82voNdYxtLJ7Z1x/N1Cu9iyhlfCJoN3fVS1hcARcr84R1SHO5Zlrz5H1dRXM9eUOLWpySdnLATyBSSG1A2vavOpcoDPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F1KSkzuU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65119QPM1038075;
	Mon, 1 Jun 2026 13:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F5HkvC
	+kNGjLBzjZydhkow2CjEgsS8CPe48pvavBdGA=; b=F1KSkzuUMs/xTUSC4r+atn
	C/EdnFocRF1GXD9/6xgThPM6Txs+BqcBl/ls1i4TFxPi/qd6G/IErKOaZDpApL7C
	HCR2uWnIwV5jfO5i4jjkFHg6R8cU1WigGIUx48cVkJFxrYnC59/wg9z128VKWC35
	x123iJ4crjRU7SRZr70qig9kypfK4ns0pr3cQYwyFCVzEGorMl3IXjSuqtoBdQBa
	BzbirGDS45hToeJveRDDkHhRMCx1drwRO8ypaP1jm4C/tGH4l+OWngSQbbnsF+VB
	xIgL3Sqbfam+N6u6JWPJJiLquhPF7jyByLzOdjLS6fty70+MRf8tl5ZPhLfVUPbg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht0kfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:47:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Dd45Q008119;
	Mon, 1 Jun 2026 13:47:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q6jh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:47:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651Dlg0327001494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:47:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B155C58063;
	Mon,  1 Jun 2026 13:47:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4167C5804B;
	Mon,  1 Jun 2026 13:47:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.103.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 13:47:41 +0000 (GMT)
Message-ID: <a38e17e1aa02e112770580ef35356952a744cdaf.camel@linux.ibm.com>
Subject: Re: [PATCH v5 12/13] ima: Return error on deleting measurements
 already copied during kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <8a0c965e1c2f3eee1006c4941206d70a71e7d0f0.camel@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
		 <20260429160319.4162918-13-roberto.sassu@huaweicloud.com>
		 <ea886419ef3047ede1885504fad8f865cdcc5ce3.camel@linux.ibm.com>
	 <8a0c965e1c2f3eee1006c4941206d70a71e7d0f0.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:47:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bSs-SRFF3n9-tCYpH67IcrZMr79SNzpj
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1d8d80 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=i0EeH86SAAAA:8
 a=AXsC2Ne_jX60tyEfe8sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNiBTYWx0ZWRfX0nNs20jLKxhh
 cpanQfFtHLGWnblbVmtY2mPidvKfuhqEUlzRog8k7ZSnmcg7ZElThBQ4wQzS/bb/Sa2zegT7UA4
 7CZX6g8R0diJzjGSc7uI6J2Ojlwp3vZHoyqNgKWk+FEiqlgLQ6wGHHMI9YfNXs6CSWbRmxWBIc2
 Oh4Sri9jdoaWZW7q1l20cAKnYKBhcYsaAUaxJm+35IALSlbpyZF7tVuDsE18v8zTld6Bf9YXBL8
 z/0KwIMQXE8JJ79Ys+FNrYI5yJAaOm0rwW0aabw6LqMeYnBFtk70JR+kEaUhnHVGNXSgP30fDpi
 V4W3bwZUno5vzmo6ZT1AMAuivIiJD7uORXF2K1CUoO8bnS7GKNO6uggFgUzuGfJdePoP4FUawQ+
 DtsaDiuIF1kOkBjvLOfaXVz2qDuhViph6ZS87CKJi/BLqCH/bpoqn+ZtYIFben1YEzs+UMb7EyX
 mEWezfysgBnSOszN8QA==
X-Proofpoint-ORIG-GUID: b3kvSpWJEXVHvnuNtmNDVHqSRyAdpJtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010136
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9708-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: B531762063E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-29 at 16:59 +0200, Roberto Sassu wrote:
> On Tue, 2026-05-26 at 10:02 -0400, Mimi Zohar wrote:
> > On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Refuse to delete staged or active list measurements, if a kexec racin=
g with
> > > the deletion already copied those measurements in the kexec buffer. I=
n this
> > > way, user space becomes aware that those measurements are going to ap=
pear
> > > in the secondary kernel, and thus they don't have to be saved twice.
> >=20
> > There are two reboot notifiers: one to prevent additional measurements =
extending
> > the TPM, while the other copies the measurements for kexec.  This patch=
 prevents
> > deleting the staged measurements after the latter notifier.
> >=20
> > Instead of introducing a specific method for detecting whether the meas=
urement
> > list has been copied, rely on one of the two existing reboot notifiers.=
 The
> > simplest method would test "ima_measurements_suspended", which would pr=
event
> > deleting the staged measurements a bit earlier.
>=20
> Testing that the reboot notifier fired (with the
> ima_measurements_suspended variable) is not enough to know whether the
> measurements dump took place or not.
>=20
> We need a flag (one is enough) protected by ima_extend_list_mutex, so
> that we know reliably which event occurred first, or the dump or the
> staging/delete (which are also protected by ima_extend_list_mutex).

I'm suggesting not allowing the staged measurements, if there are any, to b=
e
deleted once the reboot notifier has started. They'll be copied at the late
reboot notifier.

Mimi

