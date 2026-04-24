Return-Path: <linux-integrity+bounces-9329-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /TqZGGTZ62nfSAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9329-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:58:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30DF4635D0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F343F300C5B6
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0E3E2777;
	Fri, 24 Apr 2026 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zu5tdxyf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF537C92A;
	Fri, 24 Apr 2026 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064289; cv=none; b=N0PVJb1SNrJL1+gJFNlTqN53YK1hIpz1Wva5+AYELVvCGZoN5vGLl9+Ymg79gf4kx70hSClnjz7W1VyU435GhSCrvB6qvkv4gFADHSiHDgFCR/gPQaPrjPoURe3Rt6SUDZ9YDMZrP/4wQRZkd9zkvmHu4EnRcMIpTLeRzxrJLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064289; c=relaxed/simple;
	bh=LAR6IS3zJM+qSh27INp0jADSDQtfC5zNDRySOhcea3o=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rTWnVY3Zo+BCo1PxA6KocxuYAXs1dfItpwftkvgtYPzu48DWc9nHmamT8a9nn7dfY9reiljk+ccphnMm8B4nfz05wkcYNYg1Y5EObXTJ7+GgPbCdP0Yxb8OD6caHUUMvHni8MTnY+X/4PE6/0BtnHSnUHA7RGCfNWLKWcyTxmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zu5tdxyf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OAEr0d3107467;
	Fri, 24 Apr 2026 20:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YwGRsk
	VvJ+HErll2L33Iad8KfkmAeIUpOmdPI14ot44=; b=Zu5tdxyfSM8Cl+lTr/eM4B
	cUA78X1tafcLaWe6+b7iH1sOQMTnGZcKfYa4cFcWbCUKpKDtWxv8s1C6HAeNQ261
	reZT4dHk0sHs4O0+WmFSbjcQ6RJCvFswsq6q/4nwpUIIlX8fBcSEE4ei0s4bYMy/
	Mq0lYg0yJgTA3vXBmcsrZtELpb7dFc7gOY9SPshihjlLj+4uddjxADgDe2nUwMA9
	HPcM1PcsMeHbiZ2kj98UzJe5LpL0RDx8swqrTcD4b6YjaGofa/IgF59wR+mdAHPF
	/HaUx+YSLRShntA4jxJrmI+BL+uFAmGwHJO8piUoXmWXADVR2qtWcms+n5vHTDIw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6pxkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:57:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OKoKZ3015146;
	Fri, 24 Apr 2026 20:57:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkycheq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 20:57:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OKvaxN26149440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 20:57:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9946958052;
	Fri, 24 Apr 2026 20:57:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5446958045;
	Fri, 24 Apr 2026 20:57:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.11.225])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 20:57:34 +0000 (GMT)
Message-ID: <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
        roberto.sassu@huawei.com
Cc: Jonathan McDowell <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jarkko@kernel.org,
        jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org,
        oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        noodles@meta.com, sebastianene@google.com
In-Reply-To: <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 16:57:33 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIwMyBTYWx0ZWRfX06Ce639L3CbQ
 l/0x/77wK+IKQLPA5Q/B8rdy7BKQLMe7STCUzZpXuZSasflxv8h70wCR9sBxvWIYNaSZT8fglp8
 VakevzNaaRUjd3DqqHfnK+SbNri9ykAX9xFqU1Mr8zt51ELPO401WieaeOlqeXzd8uuo8W1zCNB
 bsGH4eb/jcqt3JjY+Tm8FhD8BULjuG7+BG3KvqTc8xyPLCGYdBMT7a+yCh2CQwXel+5/SHzhJuz
 ugYEYGpUHxYQpjAiI2VA79h67LHMzaYBUtRJLSeSEFDWPlkWhpzAVXsAqeHvMEiadv/gzrbZimq
 nSHSj26kHCrrmn8espLznx5ouPlqSS0+HF/BIasPKeLo9PjWWYcQqMy9/3lUGErRZUdzfrpdqez
 rHHNgoB2x5E2Ggb7EUcUjxKHSfRWIh902+XQTCNzxyNn+6pTDIhlfNOYgHMhLFD20AIhMtGBegk
 6QxcZ8QhVE8E/nJQvXA==
X-Proofpoint-ORIG-GUID: OvU2A1hQFsUaWSS9kjU--Uvph-WO9QpL
X-Proofpoint-GUID: UsUwDxwDZJc5Q5bv-vD3gXsvrj1A1z1X
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69ebd943 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=H6_ProKieZEkNf6nIh4A:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240203
X-Rspamd-Queue-Id: B30DF4635D0
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,huawei.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9329-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]

On Fri, 2026-04-24 at 16:15 -0400, Paul Moore wrote:
> On Fri, Apr 24, 2026 at 1:57=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com>=
 wrote:
> > > On Thu, Apr 23, 2026 at 2:13=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.=
com> wrote:
> > > >=20
> > > > Sounds good. Once the patch is posted, I=E2=80=99ll review it as we=
ll.
> > > > Sorry again for the noise, and thanks for your patience ;)
> > >=20
> > > My apologies for not getting a chance to look at this patchset sooner=
.
> > >=20
> > > This seems like an obvious, perhaps even stupid, question, but I have
> > > to ask: if IMA can be properly initialized via late_initcall_sync(),
> > > why not simply do the initialization in late_initcall_sync() and drop
> > > the late_initcall() initialization?
> > >=20
> > > Does any IMA functionality suffer if initialization waits until
> > > late_initcall_sync()?  If so, it seems non-critical if waiting until
> > > _sync() is acceptable, as it appears in these patches/comments.
> >=20
> > This is the way first patch did, and here is some discussion for this
> > (Might you have seen, but in case of you missed):
> >   - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe976c5b9=
b.camel@linux.ibm.com/
>=20
> Thanks for the pointer.
>=20
> Unfortunately, my concern remains the same: it's either "safe" to
> initialize IMA at late_initcall_sync() or it isn't.  Attempting to
> initialize IMA twice seems both odd and wrong.

Agreed.  However, IMA should be initialized as soon as the TPM becomes
available, not delayed.

In patch 2/4 patch description, Jonathan describes the reasoning:

Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
devices) are not reliably available during the initcall_late stage,
resulting in a log error:

  ima: No TPM chip found, activating TPM-bypass!

and no measurements into the TPM by IMA. We can avoid this by doing IMA
init in the initcall_late_sync stage, after the drivers have completed
their init + registration.

Rather than do this everywhere, and needlessly delay the initialisation
of IMA when there is no need to do so, we continue to try to initialise
at the earlier stage, only deferring to the later point if the TPM is
not available yet.

>=20
> I understand the need to ensure that the TPM is available, but if it
> isn't safe to wait to initialize IMA at late_initcall_sync() then it
> would seem like this is a bad option and we need another mechanism to
> synchronize IMA with TPM devices.  If it is safe to initalize IMA in
> late_initcall_sync(), just do that and be done with it.

Within the same initcall level there is no way of ordering the initializati=
on.
Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall=
"),
which is being reverted in this patch set.

Ordering within an initcall level needs to be fixed, but for now retrying a=
t
late_initcall_sync works for some, hopefully most, cases.

>=20
> I'm also guessing a two stage init process, e.g. some in
> late_initcall() and some in late_initcall_sync(), doesn't make much
> sense here, but that could be one other thing to consider if some IMA
> tasks must be done in late_initcall().

Perhaps something to think about for the future.

Mimi

