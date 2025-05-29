Return-Path: <linux-integrity+bounces-6338-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C6AC7FBC
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9294E6883
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306222A7FF;
	Thu, 29 May 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qhni8r+a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5121ABBB;
	Thu, 29 May 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529135; cv=none; b=iJPedKIopKIKye8cVCv/X9CSAv0yN3YsJ6gPrLl8PsFVs0m5FVnumA6jRnU7H38WEVDZEb0VzzQ/GN5JrNyfat2iTsvBdkgyFosqn9AViLSyuud4OomoLEWjtMXzKGGe2f70vMNuu6DgfOwcB5nGg++iF4Md2+m2HnzYNqmkut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529135; c=relaxed/simple;
	bh=Qv/KMzfYm4v3RnzhDmZ0RpU4dyBRdqyzgu8j3uJEp/k=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=MNWvqJDaYKyPQyD0VH6PIZczE5PQzTTSN7QFvP8SyZBmDHMA34T9Q9LDPGkB+IXc4R0VwmSUgrhcn3ekfPGqJ5kXPWVSKO6s2hLISwPRu2yVOIHUcEcd8ifvHBAJMsk40njleoANfZUK51w51lYb1N4A3PUjzjHx45BpiZZ6tws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qhni8r+a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDeFxD002030;
	Thu, 29 May 2025 14:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sBs1I6
	xHilGGQRussSPtkrqmDw9YqjU5AiWB9gav/i8=; b=Qhni8r+axcLKxqOJZEKHXq
	nzIHIlyjmEUl5vyzG2RoX4o4JdstdKtqOFr+nAu0ub7DkY49dL61k9EYEq1Qjapa
	WAep9qL0c39oICdmU6xFBYFqxE8uryMm+FtV/umpuBLFbtQ7AnPpTQwVrb3RI2OP
	kmV2XgS5fOIVcmIPZOby85ZvHqCIOJT0I972C+44fqlMUWbYZFfqcOhKO/IcFLPq
	hAD+wEAblg+AoAYb2WGNVROXsCTEntKQoghmuaiRYDukvtLxq/R+nHVnuf83eBpe
	Gr8CR6Yen/AjUjw9mKfpafz4FQvecPm0CHtmH5H/Y+c4aIHXFWpw0QY7JBUEJUsA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gp0k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 14:31:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54TCLibc006563;
	Thu, 29 May 2025 14:31:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0vw32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 14:31:56 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54TEVtFu30867996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 14:31:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5297458069;
	Thu, 29 May 2025 14:31:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BCC65805E;
	Thu, 29 May 2025 14:31:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.84.67])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 May 2025 14:31:54 +0000 (GMT)
Message-ID: <91a9aa935b3a194c57a166133c9c1a537a9ca802.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, prudo@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, coxu@redhat.com,
        ruyang@redhat.com, chenste@linux.microsoft.com
In-Reply-To: <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
	 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
	 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
	 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
	 <aC86NSypHlER2C3L@MiWiFi-R3L-srv>
	 <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
	 <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
	 <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 May 2025 10:31:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=68386fdc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=8hGtjK_r-kYd2dVNGJkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEzNiBTYWx0ZWRfXyEOtK7ZpFg9J lnVAWyCWxQPTKJBa8ZT/cCP1HrMSfQQaIrlmYGHALh/v0EGzBTIJXG5rSOMHBnTMj+5stW9M4KT RSY7jIfIy2sSiHZe+KYSZaG1DNVH5lcACtpb4liJduD+je1J+cKcFDnvNyGKR/h4jjcfQojnCRl
 4uH9BoqOz0UioUjz1Tw72jRsNKh9+UPPBr+3bHhv2ChAVW8KWWt8Ter3jZaGHqkM8D/VjSq4q10 C7zoc+giTl0qw6fm+KZuLpIESXiC50r/PLlaOIKVNInirl5KEOMmwNNv5VRIhQV12yyEA0CNYd1 +l1gpAQZqBChIZllDXoiKI5HrCqlKRyJititoepxeQymgQlRtWNUtHgTR6ffnx2NnTACf5RH+GR
 /IcHHDMfD+2QHlgmF+hzhtd87UMDc1BNJ3HVQJSbbKOYZVVsB5k8OfVjdeXC9KtoCdp/0F9R
X-Proofpoint-GUID: BXRwChCTEhrOCaz1qDFBrbZHmYfL-olt
X-Proofpoint-ORIG-GUID: BXRwChCTEhrOCaz1qDFBrbZHmYfL-olt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_07,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290136

On Thu, 2025-05-29 at 12:13 +0800, Pingfan Liu wrote:
> On Tue, May 27, 2025 at 10:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> >=20
> > On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote
> > > > >=20
> > > > >=20
> > > > > We're trying to close integrity gaps, not add new ones.=C2=A0 Ver=
ifying the
> > > > > UKI's
> > > > > signature addresses the integrity of the initramfs.=C2=A0 What ab=
out the
> > > > > integrity of
> > > > > the kdump initramfs (or for that matter the kexec initramfs)?=C2=
=A0 If the
> > > > > kdump
> > > > > initramfs was signed, IMA would be able to verify it before the k=
exec.
> > >=20
> > > IMHO, from the higher level, if there is a requirement on the integri=
ty of
> > > the
> > > initramfs, it should take a similar approach as UKI. And the system a=
dmin
> > > can
> > > choose whether to disable the unsafe format loader or not.
> >=20
> > Yes, that is a possibility, probably a good aim, but in the case of
> > kexec/kdump
> > that isn't really necessary.=C2=A0 As filesystem(s) support xattrs, IMA=
 policies
> > could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to include =
the
> > initramfs.
> >=20
>=20
> Just aware that we have such a cool feature. Thanks!

> I checked the code. IIUC, the relevant code has already been in the
> kernel. And the thing left to do is to install an IMA policy, right?

Correct.  The problem up to now has been that the initramfs was created on =
the
fly on the target system, so it was impossible to remotely sign it by the
distro.

>=20
> But there are still two things to be considered.
> -1.The UEFI partition is FAT format, which can not support xattr

The normal kexec/kdump kernel image and initramfs are stored in /boot, not =
the
UEFI partition.  Is that changing?

e.g. kexec -s -l /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`uname=
 -
r`.img --reuse-cmdline

> -2. Just like in the UKI case, the kernel fd content is not necessary
> for the kernel image itself. The initramfs fd can be used to pass some
> extra data if we use a temp file as a package. So checking the
> signatures at the initramfs level will block this usage

Sorry I lost you here.  What exactly is included in the UKI signature?  Wha=
t is
this initramfs fd extra data?  Is it included in the UKI signature?  Can yo=
u
point me to some documentation?

thanks,

Mimi
> >=20

