Return-Path: <linux-integrity+bounces-9334-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKfmF5vz62k0TQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9334-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 00:50:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1D463E9B
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 00:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D747C300613B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A930366DD3;
	Fri, 24 Apr 2026 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aM/yAGMY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763A2673B0;
	Fri, 24 Apr 2026 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070999; cv=none; b=QGT5mwGOZ7qU3fAo9grOVkOWszYEp4zSCuX17IipnxTGk6Ahq6z5lsGmQ0yicJte28I62M8N4cyKDnQ/8p+XWLhrCgj9yG+Pg/JuRXEjgU0UPcAjhZDVDTSqklQPMjRFeE+4GpBqxCt3R+NohNm9E8ZQyNkzRebEeLwCcGybVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070999; c=relaxed/simple;
	bh=7pcMgIl+mAqbbbs/rWoWZZGmNLknhhmRxDaH4su564Y=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=iUcVh9ucKx/K6nWz3ROyPNEknhrIHDj8/1Z/qR5ZsvixNrT96KACmqdnh3MPwAzw4/cXN0s6CcS0ScieuiWsaOo6UFID5IhfC/FgNaC8/wN/BWOBRSB3jARROKZ1jOTH1f4dnsHHR4E9gzUsgcJ0TU5yQ/pqiK9yPQSY1wwxcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aM/yAGMY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OCVYqr3229166;
	Fri, 24 Apr 2026 22:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6PUYKv
	xWyxCnfYDINczo2CrN5MRwpmVokR6BqgvWo4U=; b=aM/yAGMY/mr/wYGlA1BBmX
	99VKzLzUY/1gDb4tKmjig41b1TxovwHORu8ruubOh7NRipSU9oW47rSCPkcvZnNc
	ZdhTY74lWmXda9o//M8BoUzlMryjSik4nCa/xaS6/nYspVufdybKIk7uyCTx9ero
	qlZtQ0thjovAbosjOH9Gn6LUPHfvQo7fVXJxxZKRQVnrpp0Ly2tEjsAT1eNdWk7T
	ugfCiZqXehgK4ec2xVXecJ/+FgG3mE+IfPt8PBisHy6IBIusEyNaKZd4AymkCTk4
	Bd4LAF38DhYBxyqaV/2swDoDa1AVXvlzGau9hBHoxXjNSeK7b+ERKA6IZjZ7MujA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2g67u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 22:49:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OMZQ3J007657;
	Fri, 24 Apr 2026 22:49:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkycsjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 22:49:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OMnSw514221924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 22:49:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9ED05804B;
	Fri, 24 Apr 2026 22:49:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E3C958055;
	Fri, 24 Apr 2026 22:49:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.11.225])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 22:49:26 +0000 (GMT)
Message-ID: <1e51c2fd090e5ceb07b1d09e50650c70fd3ccdb1.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, roberto.sassu@huawei.com,
        Jonathan
 McDowell <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jarkko@kernel.org,
        jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org,
        oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        noodles@meta.com, sebastianene@google.com
In-Reply-To: <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
References: <aeoAlVEwzRUPrlVe@e129823.arm.com>
	 <aeoRxWPyOHGJd+Jh@e129823.arm.com> <aeoWO2Cwo04YYu2l@earth.li>
	 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
	 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
	 <aeotq8nPVu4wvEx5@e129823.arm.com>
	 <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
	 <aephL3MzYoqFGaT5@e129823.arm.com>
	 <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
	 <aesGU8a3mbVzvteH@e129823.arm.com>
	 <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
	 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
	 <CAHC9VhTW3=RJ8L91RWXYYA9tFjfSXGN-DMEEwdiD6big9H57Ew@mail.gmail.com>
	 <1f78fc75b2e95239973612a4b6c4cc782960b7ac.camel@linux.ibm.com>
	 <CAHC9VhS4JmPmCJrYTdbjxb3TO-uK6cB3Zij-ef=wswGce2BGzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 18:49:26 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BYlQdtA16k2P2wxouf2QQi1JdFQQ9yXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIyMyBTYWx0ZWRfX7eYu4KC3WB1B
 0hB1lGPQNXcKBmLBuOSTV3ZuRr2TsMu7mCbGAcNFMqDoxx8oxVqHidKExzu6cHl6nd6bp5GENpz
 I0Lw25kfh0R7utjrGY+hqBSmHYNQ5cDdqq2nBAdn6J00YiX7s/7+G7P4OSRpgnH9DZgDz82dIm1
 wNn0CUuNjJa2FRloE/Fda3n8Dl3uw64tbGL1srmySw4dqDy6qdB+iS5aAdjzuIF6L06B0BVfgW1
 i+AdhlzmWIDbuoQAISRzc9o7HFUH0mjaLU8g9742exGmB+kcWONSwLPoU5NDYr2ZAk+OIvlp3/b
 d6L84fnwd4pJlr/cSaFncvmDLH1zdswZpanjdCGyKWh7Q1a9TSUClDYBiPnbuWv9P8f8t01gayT
 RGicxhByMp3hDWpRA3Hdd2E/tIaOvAQMajthdtjU+8aBJU9iud00sawpRzNaOyN5jWkKW0IZ6X7
 RwbYe2agyOfDI07c1ZA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ebf37b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8uTKPb2Waj3ysghmV9oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s-z82vbUyaezwgG1JHnrH41iYtTrJYkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240223
X-Rspamd-Queue-Id: EBD1D463E9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9334-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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

On Fri, 2026-04-24 at 18:10 -0400, Paul Moore wrote:
> (I'm assuming you meant initcall and not syscall above, but if you're
> talking about something else, please let me know.)
>=20
> Saying that you aren't comfortable moving IMA initialization to
> late-sync is inconsistent with allowing IMA initialization to be
> deferred to late-sync.  Either it is okay to initialize IMA in
> late-sync or it isn't.  You must pick one.

Yes, we're discussing late_initcall and late_initcall_sync.

I prefer to look at it as being pragmatic. I'd rather err on the side of ca=
ution
and not move the syscall to late_initcall_sync, than move it.  However, oth=
ers
have moved the syscall to address the TPM-bypass issue for their environmen=
t.

Mimi

