Return-Path: <linux-integrity+bounces-9395-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCGIIzcQ9Gmq+AEAu9opvQ
	(envelope-from <linux-integrity+bounces-9395-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 04:30:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C62A4A9CF1
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 04:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D128530179F7
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E8D2EA732;
	Fri,  1 May 2026 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H9TNOEXr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8A2DF68
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602601; cv=none; b=GIbpSfWtt/Ce9NXkafq5UQL9SejDLR4XN9lIuG7DgfAnQB6nPgk6vNh/lni3rqqdYsQcMjGz/INOLOCJBWu5r9orCzGsHQps/RcdY8fze8tAtNRRE38mjVtrcckK6K3KR/3ZDoBy/STiJ9T9PeLp3O+IQxoiS1FbZSfwXUOL3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602601; c=relaxed/simple;
	bh=qj1DXjWd5fGoxGXDtxkIv9c+ZH1LfOgLBRZV0WkZ/xA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=K+9pKOue2xVGIhPw9ReIqCgVE8e7nsMIHFf//39FP1PESagH+xbkeOs5F/4Wt3XfVhMTjYJUslx+2XC1JvDRhkb041YGfFhd1Ug2C/kdAor3o8ZGNvNrvnmUrwgnnPHAa2hgJkLH7mZ0E+rPc/M+bIX2Ez9/rtryTYfyW6UrbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H9TNOEXr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UKw6iL3241446;
	Fri, 1 May 2026 02:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bnueu+
	lm5GtAQJyq90nWPQ2PFO8IyYhlSJRbQkfaKfU=; b=H9TNOEXrmiR8+doPuNiuYg
	RsHaUgfGi5Cb1mg5Kn0KRm4xrYS9DoNMK5KYlxunalg/z8CiNSFxHFFF9nTyr8Ip
	EIQh4++Tl6eDGxsWjw986Trx2S5OIbbsfa2ZZ93oGT5Ocrzn92dwcnPMruqraVK0
	rPFdqYs6jEdzQCNzs6m/+9oEsY7sRpp43IdI6Xt4VqHxgjPF/iGchX1J13hAR2zx
	a05QwR5sC+s6x9h+1KocibOT+TDQQgOJZNMESMg4VADow/qf4h0G2k8k5XgUAvAt
	oXwFdE1szggRM1bsGLh7Jhq/5t8rSJSqtpqL+TlVU6vYAq0eWnpYS4+xWJfM2bDw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn4531fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 02:29:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6412Nrfd013132;
	Fri, 1 May 2026 02:29:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw5vf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 02:29:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6412Ttp816187918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 02:29:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 716A258055;
	Fri,  1 May 2026 02:29:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A02335804B;
	Fri,  1 May 2026 02:29:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.95])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 02:29:54 +0000 (GMT)
Message-ID: <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed
 by structurally immutable filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org
Cc: Sahil Gupta <s.gupta@arista.com>, Julien Gomes <julien@arista.com>,
        Pierre De Abreu <pierre@arista.com>,
        Kunal Bharathi <kbharathi@arista.com>
In-Reply-To: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
References: 
	<CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 22:29:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RfE_uiMdNdhx0W-z_yD_QgOwhAleb-P7
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f41025 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NanBD4gs66f5bfShZLoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RfE_uiMdNdhx0W-z_yD_QgOwhAleb-P7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDAyMCBTYWx0ZWRfXw2d1irebZfH4
 oM16mU3Y7mNxWNiHLwqPt1yfKBpc2ksj/7FcTgTYZA/u1tV1MdOa679iXPotDJXj5mLbHVj79j6
 cx/dnFMrPP0ngzJgbhwDbokaANHu9uFk5BsoHOZxmTZgTgELWnf6ysn6yfnNNWd3ODraETnVWqZ
 aRt5lX8jY4M6xq5nvNWCXRfzBtwj/tpSPd2syhKGNb69h+/8JX75H3yXOxes4xqsMU9PtgjmT7P
 V5k1DfY2EjyRr5psdOM/itPWnMQpVf9oxm1E+iKLEjafLraivSxwqoM3XTe9xcAt1EBcIi3Rp8B
 BPgoTMeT3lvBA4BYB5EcLvae2Ugy788otmLS5BjJVJ4qqa1VlMAUB8uYKGypPpEPex0W1s/jXsW
 eD/8TgzLhDz9dq8qbT7+zLRzy2yDX6L0l9k+XoSzs4InpJXZoY6XDYYz+tY+wbyIXsokfY6/iX7
 zOEKexnWDXLeWdMVNQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_07,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010020
X-Rspamd-Queue-Id: 1C62A4A9CF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9395-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]

On Thu, 2026-04-30 at 16:55 -0700, Danny Hu wrote:
> Hi,
>=20
> We observed that IMA will always invalidate the cached measurement
> result and re-hash a file on overlayfs stacked on top of squashfs. The
> behavior was introduced by commit b836c4d29f27 ("ima: detect changes
> to the backing overlay file=E2=80=9D). We would like some feedback on the
> proposed direction we are considering before sending in any patches.
>=20
> Problem:
>=20
> process_measurement() in security/integrity/ima/ima_main.c includes a
> stacked-filesystem re-evaluation block that clears IMA_DONE_MASK when
> the backing inode is not IS_I_VERSION. This check does not
> differentiate between two distinct cases:
>=20
> 1. The backing fs does not implement i_version but it's inodes can change
> 2. The backing fs does not need  i_version because it's inodes cannot cha=
nge
>=20
> For the latter case, squashfs being an inherently immutable filesystem
> with no write paths does not set the IS_I_VERSION flag and ends up
> paying the cost of IMA hashing on every single IMA appraisal
> operation. This is perhaps overly conservative because the contents of
> squashfs cannot be modified anyways so the cached result will never be
> stale.
>=20
>=20
> Proposed direction:
>=20
> Add an s_iflags bit, potentially SB_I_IMMUTABLE, that a filesystem can
> set in fill_super to indicate that it is structurally immutable. IMA
> can then leverage this bit to short circuit the stacked-fs
> re-evaluation block and trust the cached appraisal value instead of
> forcing a re-hash. A motivator for this approach is to follow existing
> precedent. IMA already consults s_iflags for filesystem facts that
> affect appraisal. The SB_I_IMA_UNVERIFIABLE_SIGNATURE flag is already
> checked in the same process_measurement() in the block above the
> stacked fs re-evaluation.
>=20
> Happy to provide more details or clarifications if required.

Have you considered using IS_RDONLY(real_inode)?

Mimi

