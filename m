Return-Path: <linux-integrity+bounces-4049-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1D9BFCE3
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 04:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EA5B22600
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C97155316;
	Thu,  7 Nov 2024 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ibj0DRTv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC56FBF;
	Thu,  7 Nov 2024 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949291; cv=none; b=FT2OgWdVCYnMTKdcoezEdtk2WB9dUHehF6oflLjPeT+HilOqsBLiBAvkxtszKsEvmgOW+tK6wo5af+k38nVwTreB/jhlYU6KAGQr/z7KdsfiYRp6IDHfL7G2+hXrnGUFDw7qA51HjSorly8vPN8eEM0VIrGBUtz1tk2NQ6YHqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949291; c=relaxed/simple;
	bh=tn1E9J2OF1qlcdvgYDS7dvMiq/Tlp/e8/AnoEYW8BKQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+VliWi8iK68szBVVU3ukP4gQ7WvZtF90jjExcW+6oHrHNOksq+mu/xHG/8eevqSee7kO09m4m+X0pi2SqGC2A53bTXLSmxfIfTdR2Sn2zDu+Ehzv1O0nMTaloIqWOngsf0Y/HYWxupbvgvWBWBJ04zItzm/q3QKzrT7GMXD5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ibj0DRTv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A72e5I3008619;
	Thu, 7 Nov 2024 03:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R/Qyy6
	tJoh3Ox+Ja5tCg77JjUk+IbOnTyEc7UPZwJvs=; b=ibj0DRTv9ZBUVDMvsTIuIA
	OvXEEyNWng/9zB6Ajm9JwMH+JegOYRUfieLwS8cnz1iVsXRTrum3hBc0rl6AKCQH
	ZP7HbuERl+AtHMu0YIZEogZildOZA6+FktOsXY80SNm/d1ntcPRZHbcY6yfDsHwy
	ly6DIMRAu1L12Ak+mEhRhVouA0ldzBDLTXQP+zIv6rCIXJbsYWwjWWL/608tZxJK
	DAqkhJg+i+U7v3wOCnko2oQ+yGHvp4iTJLpuPItzBSYSQXYf1dgbhcjtNhN+gpjr
	ap+ADLgNDodK8W6Bimj3eMrYN4JG1t6yoAJKAYb976GpxPQqrgifZEDh047SWyFw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rmyag4ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 03:14:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A73EYZ5008968;
	Thu, 7 Nov 2024 03:14:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rmyag4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 03:14:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71dsWo012253;
	Thu, 7 Nov 2024 03:14:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140ybk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 03:14:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A73EWbe51249412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 03:14:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCEB358052;
	Thu,  7 Nov 2024 03:14:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B75C5805D;
	Thu,  7 Nov 2024 03:14:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.85.129])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 03:14:32 +0000 (GMT)
Message-ID: <253ca7f4dcfdff7f42fd52800e9bd0c126429f0d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
	 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com,
        Paul Moore
 <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        christian@heusel.eu, Ken Goldman <kgold@linux.ibm.com>
Date: Wed, 06 Nov 2024 22:14:32 -0500
In-Reply-To: <D5FKM963NJ6O.3BGXETHW2FC5K@kernel.org>
References: <20241015193916.59964-1-zohar@linux.ibm.com>
	 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
	 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
	 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
	 <84fcb3e29f3aa1ea7a5b638307e500608bc8b11a.camel@linux.ibm.com>
	 <D5FI94F98BS0.2JMJGMV9W5GBC@kernel.org>
	 <0bca8c26693d28093a1cf4dd2df1dcc985cbf252.camel@linux.ibm.com>
	 <D5FKM963NJ6O.3BGXETHW2FC5K@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UB8gVbu1Pt0ebH2kTArJ0MX5Zibosbs-
X-Proofpoint-GUID: YiYvUfZEJWxX5SmX5VwdlTsEuRfrLs8D
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070021

On Thu, 2024-11-07 at 03:55 +0200, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 3:07 AM EET, Mimi Zohar wrote:
> > On Thu, 2024-11-07 at 02:03 +0200, Jarkko Sakkinen wrote:
> > > On Thu Nov 7, 2024 at 1:52 AM EET, Mimi Zohar wrote:
> > > > On Thu, 2024-11-07 at 01:22 +0200, Jarkko Sakkinen wrote:
> > > > > On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> > > > > >=20
> > > > > > I'm a bit confused here.  It's TPM2_PCR_Extend we have the trou=
ble with
> > > > > > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> > > > > >=20
> > > > > > The random number generator reseed occurs in a kernel thread th=
at fires
> > > > > > about once a minute, so it doesn't show up in really any of the=
 boot
> > > > > > timings.  Plus even with sessions added, what there now isn't a
> > > > > > significant overhead even to the running kernel given it's asyn=
chronous
> > > > > > and called infrequently.
> > > > >=20
> > > > > Ah, right then we need the boot flag, and my earlier comments to =
the
> > > > > parameter apply. I've never used IMA so I don't actually even kno=
w in
> > > > > detail how it is using TPM.
> > > >=20
> > > > Huh?  A simple explanation is that IMA-measurement maintains a meas=
urement list,
> > > > similar to the pre-boot event log.  Each IMA-measurement record ext=
ends the TPM
> > > > PCR (default PCR 10).
> > > >=20
> > > > Assuming IMA is enabled in the kernel, then just add "ima_policy=3D=
tcb" or
> > > > "ima_policy=3Dcritical_data" on the boot command line.  To view the=
 measurement
> > > > records, cat <securityfs>/integrity/ima/ascii_runtime_measurements.=
  Normally
> > > > the IMA policy specified on the boot command line is replaced with =
a finer
> > > > grained custom policy.
> > >=20
> > > I'll try to figure out how to test it regularly. And yeah we need the
> > > flag obviously.
> > >=20
> > > I have my (CI compatible) framework that I run regularly with upstream
> > > that I've mentioned a few times earlier.
> > >=20
> > > https://codeberg.org/jarkko/linux-tpmdd-test
> > >=20
> > > How would I would make all files in /etc get to get the checksums, and
> > > how can I generate legit and illegit change to some file in that tree?
> > >=20
> > > No need to address how to implement that to my framework, I can figure
> > > that out. I just would love throw something so that any performance
> > > regressions will be catched right at the get go, i.e. before they
> > > end up to the mainline.
> >=20
> > Yes, I still need to look at it.  FYI, the IMA policy cannot be defined=
 in terms
> > of pathnames.  For testing, we've been loopback mounting a filesystem a=
nd
> > defining policy rules based on the UUID of the filesystem.  If you're u=
sing
> > SELinux, then rules can be defined in terms of SELinux labels. There ar=
e other
> > methods of identifying files.  Ken's been working on new IMA documentat=
ion[1],
> > which can be viewed here
> > https://ima-doc.readthedocs.io/en/latest/ima-concepts.html .
> >=20
> > Here are some examples as to how to locally verify the IMA measurement =
list and
> > the boot aggregate.
> >=20
> > 1. To locally verify the IMA measurement list matches TPM PCR-10, use e=
vmctl
> > (ima-evm-utils).  For example,
> >=20
> > a. An IMA measurement list without integrity violations
> > (/sys/kernel/security/ima/violations)
> >=20
> > evmctl ima_measurement /sys/kernel/security/ima/binary_runtime_measurem=
ents
> >=20
> > b. An IMA measurement list with integrity violations
> >=20
> > evmctl ima_measurement --ignore-violations
> > /sys/kernel/security/ima/binary_runtime_measurements
> >=20
> > 2. To locally verify the 'boot_aggregate' record, the first record in t=
he IMA
> > measurement list, use "evmctl ima_boot_aggregate -v" and compare the re=
sulting
> > hash with the one in the boot_aggregate record.
>=20
> Thanks! I write an issue based on this to my Codeberg repository, and
> purge it once the time. I'll start by that and later on formalize
> some commits or perhaps IMA specific buildroot config...

Another important test would to be to make sure that IMA doesn't go into "T=
PM-
bypass" mode, which happens when the TPM initialization is for some reason
delayed.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sec=
urity/integrity/ima/ima_init.c#n124
> As far as the patch goes, I thought that I refine the patch myself, and
> save everyone's time and nervers from unnecessary reviews rounds. It
> does not make any radical changes to the approach.

Thanks
>=20
> See https://lore.kernel.org/linux-integrity/20241107004708.108667-1-jarkk=
o@kernel.org/
>=20
> I cannot take reviewed/tested-by's from any of the authors but if you
> can check that it works for you I can surely send it Linus without
> further tags than three SOB's :-) That said happy to get at least
> tested-by from someone.

Our emails crossed.  I suggested removing the word "encrypted" throughout t=
he
patch, as pcr_extend isn't encrypted, just HMAC'ed.

I'll re-test first thing tomorrow morning. Does the module_param require a =
value
or is specifying the name on the boot command line enough?

>=20
> I'll send a PR to Linus as soon as possible.

Ok
>=20
> >  =20
> > [1] https://github.com/linux-integrity/ima-doc
> > [2] https://github.com/linux-integrity/ima-evm-utils/tree/next-testing/

thanks,

Mimi

