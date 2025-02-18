Return-Path: <linux-integrity+bounces-4880-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4994A3A859
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 21:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503A03A4FFF
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B912021B9C6;
	Tue, 18 Feb 2025 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kp/gLChc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51621B9E4
	for <linux-integrity@vger.kernel.org>; Tue, 18 Feb 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908819; cv=none; b=cBE4wNtfYn5/P4nQsaREWPVCbH6HYkXseVF5tBD/NlTcQa+d19ddRKTe1e3oAPsA4qRF0LIgSdKQQSnsrdjGF62Bt6or0MhG/SBwJ2PdxYEbj1SWi24PjJRxltGgCWa+M4w5k0T3UjEga2EqNey1Hk3iAQZpO6MN5ZFvPUF1BgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908819; c=relaxed/simple;
	bh=oJRaHUXdW2yTDICL0A57MPoltMJ6iS/3wB5ZmF9sI9M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+LAzCMfrz4XqbOUGfPWfLGS3NU2sb9dhPJkUm0tgxxIx2Cm5P2UkvT3Mm0xtEp6jW+la45qgOdMoUas8GEfAKoo/MfYoQC6SEXxfAk4dXo5AjEM+1OdUocpqz/6xTruaProinptOGwHAPF6ysnp+9xhqXx/ra7WwnifSrIGKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kp/gLChc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIxeF6025458;
	Tue, 18 Feb 2025 20:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v8RpPR
	GMR0TauxDZ0DTZZPyr9kDBvVCvWvINdudXozY=; b=Kp/gLChc710oh4vaF5fgxC
	E/L3xTQEivNCWuYyRcIEBil/aoAcPjLZPHgYekGsF1rZBK4HC3XbG4A/1UrnbtY4
	SH28WCsdApB7yMTRWz80D3XRWeJr2uCXDxjkrh8SqnDZlCyCOS4wbwCblD3D2/2s
	0a9OJWvVoXcf88kvwFaSxfbbgnqj7DxkFPjB+DnJxe8v4YZ4dBEd2sGnK0dU8vr3
	l4QpddSK8S6+KF0uBw2nJBPsAy1uXZ7tEsUzOU6b/enorY7xTXCtGlPD5WRZV5Pa
	Y5PTMvgGaBL685CSjOIWr55NtIrqqyZ5lu/ZIS1LylKf9SarWv+mCK3dm5jczKog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyynr7sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 20:00:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJ8juA009646;
	Tue, 18 Feb 2025 20:00:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y066r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 20:00:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IK0DDG27329192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 20:00:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7292958043;
	Tue, 18 Feb 2025 20:00:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34D7C5805D;
	Tue, 18 Feb 2025 20:00:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 20:00:13 +0000 (GMT)
Message-ID: <ed0adec273c5fff47e85b61a3d2b969af475d8dd.camel@linux.ibm.com>
Subject: Re: [RFC] Issue of  historical file and script invocation when
 using IMA for runtime attestation
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Wang, Nicholas" <chenkai3@illinois.edu>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>
Date: Tue, 18 Feb 2025 15:00:12 -0500
In-Reply-To: <2601749.ElGaqSPkdT@nicoripper>
References: <6165162.lOV4Wx5bFT@nicoripper>
	 <f77c848b588811236ebb88e6731270943dd22e82.camel@linux.ibm.com>
	 <2601749.ElGaqSPkdT@nicoripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xa8Er2UdbU1hf0pl_q4xfxjJMS-gMg13
X-Proofpoint-GUID: xa8Er2UdbU1hf0pl_q4xfxjJMS-gMg13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502180137

On Tue, 2025-02-18 at 18:06 +0000, Wang, Nicholas wrote:
> Hi,
>=20
> Thank you both Roberto and Mimi for your timely replies! I have been=20
> discussing with our collaborators since and we believe the information=
=20
> definitely helps us more on understanding the issue from IMA's perspectiv=
e.=20
> While I cannot immediately give a comprehensive reply, I can quickly clar=
ify=20
> some of it whichever I can.
>=20
> On Friday, 14 February 2025 14:30:42 CST Zohar, Mimi wrote:
> > On Thu, 2025-02-13 at 12:57 +0000, Wang, Nicholas wrote:
> > > Linux-integrity community,
> > >=20
> > > Hi, I'm Nicholas Wang from UIUC, and we are researching the potential
> > > challenges of a remote runtime attestation tool using IMA, Keylime, u=
nder=20
> > > a
> > > simulated deployment environment. In the process, we conducted multip=
le
> > > experiments, and we encountered some issues that we realize may not b=
e
> > > able to be solved entirely in userspace.
> > >=20
> > > To sum up the first issue, IMA may not reflect the whole picture of
> > > invocation or activation history. In particular, we are in question a=
bout
> > > "Once the earlier measurements are verified, there is no need to veri=
fy
> > > them again" according to IMA event log documentation. First off, Keyl=
ime
> > > uses directories or paths for matching and ignoring files in their po=
licy
> > > file; in IMA policy, "dont_measure" filters out filesystems. We see t=
wo
> > > potential scenarios in which malicious actors may silently bypass the
> > > attestation. We assume Keylime user does not use "dont_measure" filte=
rs
> > > in IMA policy and IMA indeed measured everything while Keylime attest=
 the
> > > digests according to its own policy. Keylime would filter and ignore
> > > certain files based on its own directories and file filtering, and su=
ch
> > > ignored files would only appear in IMA log once as long as the system=
 is
> > > not rebooted. Now the issue arises: 1. if the file being moved within=
 the
> > > same filesystem, it will never re-appear in IMA logs even with furthe=
r
> > > invocations, as IMA treated them the exact same file. This may allow =
an
> > > attack to persist throughout until a fresh reboot. 2. In case of a
> > > long-lived system which has patched a vulnerable version of one softw=
are,
> > > the old, vulnerable version which has been in the IMA log before will=
 not
> > > appear in case of further activation before a reboot. Thus, we believ=
e
> > > that the design which measures each file once may in some cases not
> > > reflect a comprehensive state of the machine to meet runtime attestat=
ion
> > > needs.
> >=20
> > Hi Nicholas,
> >=20
> > Can you explain what you mean by "patched"?=C2=A0 In general, software =
packages
> > on long-lived systems can and would be updated (e.g. dnf, apt).=C2=A0 T=
he new
> > software would be a different inode and would be measured on first acce=
ss.
>=20
> By patched I meant exactly updated to a patched version, and I believe in=
 most=20
> cases your arguments should hold: old executable is either directly=20
> overwritten, or been deleted and then replaced with new version by the pa=
ckage=20
> manager. HOWEVER, I believe the inode assumption does not apply to the=
=20
> scenarios I tried to describe. In case 1, assuming attacker "moves" the f=
ile,=20
> inode would stay the same, result would be that executable being executed=
 in a=20
> new directory without reflecting in the IMA log; In case 2, assuming a so=
ftware=20
> is updated, new binary now has a new inode, and is executed therefore att=
ested=20
> by IMA after update. IMA log now shows an entry of the vulnerable version=
, as=20
> well as an entry of the updated version, with the same path. Now if attac=
ker=20
> replace updated executable with the previous vulnerable version at the ex=
act=20
> same path, based on our testing, further execution of the vulnerable vers=
ion=20
> would never cause a third entry to appear in IMA log, regardless inode is=
 same=20
> or different (as long as it has identical path to the first (vulnerable v=
ersion=20
> exec.) IMA log entry).

Hi Nicholas,

Right, the renamed file (case 1) would not be re-measured unless the file w=
as also
modified.  As Roberto explained, the file name is part of the directory, no=
t metadata
associated with the inode.  Refer to the getdents man page.

The case 2 concern was addressed by enabling CONFIG_IMA_DISABLE_HTABLE.  Fo=
r an
explanation, please refer to commit 52c208397c24 ("IMA: support for duplica=
te measurement
records") patch description.

>=20
> >=20
> > There's been discussion on resetting the measured/appraised flags after=
 a
> > configurable period of time, but nobody has actually submitted patches.=
=20
> > There were a couple of ideas: - Walk the rb tree to reset the
> > measured/appraised flags. (Obsolete) - Include a timestamp in the iint =
to
> > detect "expired" measured/appraised flags on access.
> >=20
> > I welcome a patch set that enables re-measuring/re-appraising files.
>=20
> Thanks for the information and we will look into the past discussions and=
=20
> further discuss with our team, see if we would propose a feasible solutio=
n and=20
> potentially submit a patch set to upstream.

Sounds good.

Mimi


