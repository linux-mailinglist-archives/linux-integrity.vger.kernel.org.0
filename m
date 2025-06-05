Return-Path: <linux-integrity+bounces-6371-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7903ACF23A
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 16:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324B3188EDA4
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F18184524;
	Thu,  5 Jun 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jNG0vLci"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5A2E659;
	Thu,  5 Jun 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134491; cv=none; b=k1mQArOKDlmYlyXhhdb+Pf0SuiFwBUDYeTN4BSFKDfoZBUdCQP8UFVEqdRV4fe9jkvIiJVitFs43aiuK7keEWnehD4rOsQqt6ud6M77I7UdSUphul4DJoBL209e739vul8Xtlo4ittKjYCcX63qtfCv64qDmTBa9YNeiDimYSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134491; c=relaxed/simple;
	bh=G4+47qc1n3bzX5gU3JB3YwOCDw7FrUpLqtOCy4J2WNk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=blOrspqQ/StGYrJD/7hR4SXX52XZLyqbHGdiBuUsMLHTE+xwFsZUITg+jyCCR5waoeunev3gaxJy3m2dcvNen7TJ2+FzWkSBwSi58dS8IdQWfKZMHt7T00aS87P69QyOn1VU549VSomJ8B/bNE2y4EiPL+AyfGD3/DAztCMyOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jNG0vLci; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555BYYaP029077;
	Thu, 5 Jun 2025 14:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WMO587
	RkCAs2RHbCh4bywkWzWURKdVqSdrgZo4cRfeQ=; b=jNG0vLciJY2CsB5MAZbwgY
	O4QO0DDRBrQms+0ruJXhfcNzzkC1yniWGKFECzJ+MhszMCHb89xAYZ2PWGPtIwcZ
	K/b0xogWr1Bb/0xKitRMtLw0LADyQWfeZK8qtcYns6H8ECHJbCezIc0QenuCODqO
	M4YXSkNeNmbmGGL+UNBkE8N3xwy/2SffAO6vuXCo/fRcuGSjNWkkDgPtKIBppTmJ
	sBdOroRnRffKAMFPxsvHMTEbq0qdinfV5SesdZa/f20mfQNQi/5yC9LIiQhMfI+T
	Sq7kCxGX1ET8vu1OkggVfqI5EB4RmJtUz1mBOQwMy9INyljPJ8XSA8/J+b+pQ5aw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyhbm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:35:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 555EVwFO007403;
	Thu, 5 Jun 2025 14:35:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyhbm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:35:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555D1UQm012562;
	Thu, 5 Jun 2025 14:35:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2ms1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:35:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 555EZhV515401646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Jun 2025 14:35:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E18558059;
	Thu,  5 Jun 2025 14:35:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C630D5804B;
	Thu,  5 Jun 2025 14:35:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.24.49])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Jun 2025 14:35:40 +0000 (GMT)
Message-ID: <a7b89a65ab24454676b8eb858d2b24445abe0a30.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
From: Mimi Zohar <zohar@linux.ibm.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David
 Woodhouse	 <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis
 Chamberlain	 <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sami
 Tolvanen	 <samitolvanen@google.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Roberto Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge
 E. Hallyn"	 <serge@hallyn.com>,
        Peter Jones <pjones@redhat.com>,
        Robert
 Holmes	 <robeholmes@gmail.com>,
        Jeremy Cline <jcline@redhat.com>, Coiby Xu	
 <coxu@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20250602132535.897944-1-vkuznets@redhat.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Jun 2025 10:35:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=6841ab41 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=D1HWW76GpMGOKR5Gno0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vHFrR4Ila0Sw6f-MNBSE6vwCv-niH7M_
X-Proofpoint-ORIG-GUID: RcUfx5CmD7cpmR59MoAjvRUeAcHLXhaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEyNSBTYWx0ZWRfX67RurhBXVm98 BdyZYmy5wGJ7aaw5jqMtNbWCizupbUA2uS8Tqr03rxbi0joFb6JPq9QV4+GU6QTK7bvHLf0j1Sz gQt1qwHoYqn+YS66brb4rTFalIq/Hi//iCojEyP1+U49l9vUKLLZXfMOQVMuKm9gsaOTGBj1RKx
 7HRkrt0bkCD9wzUHnuKt+flSboAUvguAmP3W1p4I7IVCCo7Hs8kANoBJBCISh/+H/4oKUy6nczM 5httlEmusJr4x4g42Nl7IeyoJR84CPI+cNPg1/fpqIv+aJuj8jUs32K2olnhWBweGTHSn1r81qh 0mJ6BfmBg+/HzFC8XsCLaCJ+/ufzsZnsgkKxzF17QcGRgrQuWncXGStU1pfVMy6dABaPNqDipkz
 Xmr6LaFkpx2OyJaoddr8/1FmuT0l1UwhaKkYN30tU2gaA/237EllMr8uMmI/wqge+vF4tbiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050125

On Mon, 2025-06-02 at 15:25 +0200, Vitaly Kuznetsov wrote:
> UEFI SecureBoot 'db' keys are currently not trusted for modules signature=
s
> verification. RedHat based downstream distros (RHEL, Fedora, ...) carry a
> patch changing that for many years (since 2019 at least). This RFC is an
> attempt to upstream it as the functionality seems to be generally useful.
>=20
> Previously, pre-boot keys (SecureBoot 'db', MOK) were not trusted within
> kernel at all. Things have changed since '.machine' keyring got introduce=
d
> making MOK keys optionally trusted.

The changes were made incrementally:

The original trust model relied on the secure boot signature chain of trust=
.
After pivoting root, only keys that were built into the kernel were trusted=
.=20
Anyone building a kernel could embed their keys in the kernel image, but th=
ere
was no way of loading other keys.

- The original exception was for verifying the kexec kernel image.  For tha=
t
reason and that reason alone, the pre-boot keys were loaded onto the platfo=
rm
keyring.

- From an IMA perspective, the second exception allowed loading public keys
needed for verifying locally signed code.  The first attempt stored and loa=
ded
keys from the TPM.  (Unfortunately) instead, what was upstreamed was loadin=
g
public keys stored in MOK.  There's an option to only load CA certificates
stored in MOK, which would be "safer".

Changing the existing behavior will impact everyone's security/integrity
assumptions of the existing system trusted keyrings.=20

What's clear today is that we need finer key granularity than at the level =
of
keyrings.

Mimi

> Before that, there was a discussion to
> make .platform trusted by default:
> https://lore.kernel.org/lkml/1556116431-7129-1-git-send-email-robeholmes@=
gmail.com/
> which didn't go very far because the assumption was that this is only use=
ful
> when the user has control over 'db'. I believe there's a fairly common
> use-case where this is true.
>=20
> The use-case: virtualized and cloud infrastructure generally provide an
> ability to customize SecureBoot variables, in particular, it is possible
> to bring your own SecureBoot 'db'. This may come handy when a user wants =
to
> load a third party kernel module (self built or provided by a third party
> vendor) while still using a distro provided kernel. Generally, distro
> provided kernels sign modules with an ephemeral key and discard the priva=
te
> part during the build. While MOK can sometimes be used to sign something
> out-of-tree, it is a tedious process requiring either a manual interventi=
on
> with shim or a 'certmule'=20
> (see https://blogs.oracle.com/linux/post/the-machine-keyring). In contras=
t,
> the beauty of using SecureBoot 'db' in this scenario is that for public
> clouds and virtualized infrastructure it is normally a property of the OS
> image (or the whole infrastructure/host) and not an individual instance;
> this means that all instances created from the same template will have 'd=
b'
> keys in '.platform' by default.
>=20
> The suggested approach is not to change the default, but to introduce a
> Kconfig variable (CONFIG_MODULE_SIG_PLATFORM) doing the job. Note, the=
=20
> kernel already trusts '.platform' for kexec (see commit 278311e417be=20
> ("kexec, KEYS: Make use of platform keyring for signature verify"))
> and dm-verity (see commit 6fce1f40e951 ("dm verity: add support for
> signature verification with platform keyring")) so maybe changing the
> default or introducing a generic '.plarform is fully trusted' option
> would actually be better.
>=20
> Vitaly Kuznetsov (1):
>   module: Make use of platform keyring for module signature verify
>=20
>  Documentation/admin-guide/module-signing.rst |  6 ++++++
>  kernel/module/Kconfig                        | 11 +++++++++++
>  kernel/module/signing.c                      |  9 ++++++++-
>  security/integrity/Kconfig                   |  2 +-
>  4 files changed, 26 insertions(+), 2 deletions(-)
>=20


