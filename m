Return-Path: <linux-integrity+bounces-4830-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFAA3551B
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 03:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47563AC5ED
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356501519A9;
	Fri, 14 Feb 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q96Mfj21"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84D1487DC
	for <linux-integrity@vger.kernel.org>; Fri, 14 Feb 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501854; cv=none; b=bZWBDR9VUNJynwRN6TnZouCv4iDi+I7B0ISVwd6WYSBKy73vgIpYubP3nNmMAzvm41M5ILImiFuftU9Cv8uDkxa4PTSCz6JeOMZXlt+YelTJ2QupFuZWkZ06lvLgJ6subx+KpCtEqIkfAwbCzdYwOgHARyCFLn8Rdu7pdCWWOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501854; c=relaxed/simple;
	bh=yMXr9r8krVmJCNrWM+wwjpaFrWKGnmxGCfEOHRVimQs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXcXBdsokPduwikyzm7Hpn7OBCnnl6Yy8SMT6VESjYX3RKUcAuu438fpK8/vGtIQr7YDrF92bKikQSQqUTEh9zEAxnQajyGcuP/GZZnbBnQSK6cJyYh+jd3O7P2CFV1BBg3rxHynI6qOgmYEzrN5qIYR160mNu7adrJOfUMePig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q96Mfj21; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E2oSm4014894;
	Fri, 14 Feb 2025 02:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RYzmma
	tAq2QGuaaxyjzEM12g4CAbKGeZZyGdqylVApA=; b=q96Mfj21pdxktl/2yY6TNl
	SqI9m5R6Ds8VeHCnSBVcYui/+NDc0hFLT+Jzu6yz2VKMNLd8mS5oB/JTwpSVmL0e
	1L61XnA2DYKoirpVv+uNm/mo/9nkjsXWDLCUrYiacFciKc6JZzgigK1CAeS3x5uc
	XrLuJvcZBBWrqVGvXDfqPEsm/jgmsas1c6KwQk7w3D/p8I0aDqoR/sBXOSDCNge9
	xLNrbC8XL7zzSnqBFNa9pkEkX7HyYJzji/TdfYSZ0KMwgqDe97Q50iMNgSlmltSk
	ybVucaA3rdWPQ1X7jUNx6N4P1wczvCyrW3GCQ+XbgevXdWq/y+BDVyfkiJicbvQQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44sceq5bb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 02:57:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E1mUl7021713;
	Fri, 14 Feb 2025 02:57:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phkt1q2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 02:57:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51E2vSXU33161754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 02:57:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFED58056;
	Fri, 14 Feb 2025 02:57:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14FAB58052;
	Fri, 14 Feb 2025 02:57:28 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.55.232])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 02:57:27 +0000 (GMT)
Message-ID: <f77c848b588811236ebb88e6731270943dd22e82.camel@linux.ibm.com>
Subject: Re: [RFC] Issue of  historical file and script invocation when
 using IMA for runtime attestation
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Wang, Nicholas" <chenkai3@illinois.edu>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>
Date: Thu, 13 Feb 2025 21:57:27 -0500
In-Reply-To: <6165162.lOV4Wx5bFT@nicoripper>
References: <6165162.lOV4Wx5bFT@nicoripper>
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
X-Proofpoint-GUID: fRVGmhFkEYIzsncmIL5QFqCS6VxjWOqh
X-Proofpoint-ORIG-GUID: fRVGmhFkEYIzsncmIL5QFqCS6VxjWOqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140016

On Thu, 2025-02-13 at 12:57 +0000, Wang, Nicholas wrote:
> Linux-integrity community,
>=20
> Hi, I'm Nicholas Wang from UIUC, and we are researching the potential=20
> challenges of a remote runtime attestation tool using IMA, Keylime, under=
 a=20
> simulated deployment environment. In the process, we conducted multiple=
=20
> experiments, and we encountered some issues that we realize may not be ab=
le to=20
> be solved entirely in userspace.
>=20
> To sum up the first issue, IMA may not reflect the whole picture of invoc=
ation=20
> or activation history. In particular, we are in question about "Once the=
=20
> earlier measurements are verified, there is no need to verify them again"=
=20
> according to IMA event log documentation. First off, Keylime uses directo=
ries=20
> or paths for matching and ignoring files in their policy file; in IMA pol=
icy,=20
> "dont_measure" filters out filesystems. We see two potential scenarios in=
 which=20
> malicious actors may silently bypass the attestation. We assume Keylime u=
ser=20
> does not use "dont_measure" filters in IMA policy and IMA indeed measured=
=20
> everything while Keylime attest the digests according to its own policy.=
=20
> Keylime would filter and ignore certain files based on its own directorie=
s and=20
> file filtering, and such ignored files would only appear in IMA log once =
as long=20
> as the system is not rebooted. Now the issue arises: 1. if the file being=
 moved=20
> within the same filesystem, it will never re-appear in IMA logs even with=
=20
> further invocations, as IMA treated them the exact same file. This may al=
low an=20
> attack to persist throughout until a fresh reboot. 2. In case of a long-l=
ived=20
> system which has patched a vulnerable version of one software, the old,=
=20
> vulnerable version which has been in the IMA log before will not appear i=
n=20
> case of further activation before a reboot. Thus, we believe that the des=
ign=20
> which measures each file once may in some cases not reflect a comprehensi=
ve=20
> state of the machine to meet runtime attestation needs.

Hi Nicholas,

Can you explain what you mean by "patched"?  In general, software packages =
on long-lived
systems can and would be updated (e.g. dnf, apt).  The new software would b=
e a different
inode and would be measured on first access.

There's been discussion on resetting the measured/appraised flags after a c=
onfigurable
period of time, but nobody has actually submitted patches.  There were a co=
uple of ideas:
- Walk the rb tree to reset the measured/appraised flags. (Obsolete)
- Include a timestamp in the iint to detect "expired" measured/appraised fl=
ags on access.

I welcome a patch set that enables re-measuring/re-appraising files.

>=20
> The other issue we run into is script invocation. We find this is tricky =
as we=20
> realize that scripts being too versatile and hard to enforce the attestat=
ion=20
> upon execution, and executing them directly (through shebang) versus pass=
ing=20
> it to interpreters/shell as arguments results in a drastically different=
=20
> attestation result as the latter only attests the interpreter binary itse=
lf.=20
> While a naive solution would be turning on attestation for file read oper=
ations=20
> in IMA policy or use SELinux file types to facilitate, however, we suspec=
t it=20
> would still be an unmanageable task with unbearable performance. As the n=
ature=20
> of the problem is essentially to distinguish code from data, the only=20
> reasonable solution we currently have thought is to have interpreters=20
> themselves to do the task, and indicate IMA what is code through API.=20
> Alternatively, the only probable way would be any attestation tool eventu=
ally=20
> had to have their own kernel modules and extended file types for IMA poli=
cy,=20
> and decide on what to be measured in separate components.

Perfect timing.  As Roberto mentioned, you should look at Micka=C3=ABl Sala=
=C3=BCn's "[PATCH v23
0/8] Script execution control (was O_MAYEXEC)" patch set.  It was upstreame=
d in the
current open window (6.14).

Mimi

>=20
> We wonder whether there is or has been discussions around these questions=
. If=20
> so, we would like to learn more about any ongoing efforts or plan on chan=
ging=20
> the current situation, or if not, would like to hear the opinions from th=
e=20
> kernel community regarding the two issues.
>=20
> Best regards,
>=20
> --
> Nicholas Wang


