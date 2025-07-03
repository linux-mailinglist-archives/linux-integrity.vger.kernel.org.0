Return-Path: <linux-integrity+bounces-6600-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C558AF68BB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 05:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BA61BC6A1F
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15F023C515;
	Thu,  3 Jul 2025 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRwWUeHU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8423BD1F;
	Thu,  3 Jul 2025 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751513754; cv=none; b=lZEU7xkx8gOl4Dfsl1J5j7oZyJ8yROODBvQU6xuraQI81YAB+T4/T6h8i4cWCkqfOHBRMHV+HaETMd/0M7xLUhsKyVebjrhoQqHu91UpPI8PT5uZOoK4Wgo6Kmqo2O6yLVgmMnWJteO5z7uQ5bLa5YJfIoGNK4ZMOKirjpg4FLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751513754; c=relaxed/simple;
	bh=/X73Wz/E8K7wkYSxARj+5BY4/U4OmymPE1FMHO+dvhU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BNdyrhFHwMoLxxqeFQ4+iJLh5dzeoJByBYVqhxSBU2tGr5iuloEwVk7xQayadCh6mc1v2/CGM4t3Q1JOlWl2/mKmPJp8cBll+URMd84yoG5TzsHQAIrrGntuHx+tE855fRTYG1XOWhqExiwhLzcqMb9vjMWHBDemVpFwV+EPE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRwWUeHU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5632R50O030860;
	Thu, 3 Jul 2025 03:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m6nkcE
	kUbQHeAdbCtT6Q18paXgpW7x/cYkeaZ4o5fBc=; b=nRwWUeHUMRpvrncYHlBV9h
	ywE4H87JsR3kceJu+/lvmF/XRgJM29vaeHewpSokDgrl7EMkr7OQpzBePSUFBnrv
	zhn+TQllU67IApuEITa64H4hzL9CDo0C/XESxmFMk3hAUg8JNP94jDCU/CttRafH
	RQM8nOD9woHzn91Jjc2fw7VvNihlcQ7I8Dg2uKakulaN/bcV0cqPUhc1FbwvCRYX
	Nk6VrNZwSqoZqx03M1C35j9bXo1dIbEuSkFrCKDuov3XtxIagUzZAWzN4JwO68aj
	goa+dGmuVIMCSEcvnS8S8S1KJPl4dISPF5LYs86lUFt+n+kznwEsCM0XAUVDLLTA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u20y1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 03:35:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5633ZOVr014843;
	Thu, 3 Jul 2025 03:35:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u20y16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 03:35:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5632609X006950;
	Thu, 3 Jul 2025 03:35:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmjnfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 03:35:23 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5633ZMWB29098524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 03:35:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21ABC58060;
	Thu,  3 Jul 2025 03:35:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC92558056;
	Thu,  3 Jul 2025 03:35:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.102.8])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 03:35:20 +0000 (GMT)
Message-ID: <15ae451cf47f45a7b540200107ef1f5d1d1543f9.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Extract secure boot enquiry function out
 of IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Madhavan Srinivasan	
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko
 Carstens	 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev	 <agordeev@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Christophe Leroy	
 <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, "Lee, Chun-Yi" <jlee@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Lu Jialin <lujialin4@huawei.com>,
        Nayna Jain	
 <nayna@linux.ibm.com>
In-Reply-To: <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
References: <20250628063251.321370-1-gongruiqi1@huawei.com>
	 <eb91dcf034db28e457a4482faa397dd7632f00fd.camel@linux.ibm.com>
	 <4c59f417-86cc-4dec-ae45-8fcf8c7eb16a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jul 2025 23:35:20 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 66tcBrmaIPJxL-a4EC_4D4tMRJ7g8dvd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAyNCBTYWx0ZWRfXwa7SUWdVahw/ cI6Xwl7cmB26jWHsRkM66kh9EeOde/acFw2JMdlaozyvu15i7EmuA4spUEnDZyZ8oknrMlxv5e5 bZQI5QjrxsAqViGyoj7LBhfjJ8/wHJfeNo/1h7WeWPnhVEiSvzUeVjZM549tBmUzLIIMSciaXuX
 1GGqr/rNcm5+/P5wh8br7p8XQyJC8zcteqJouLHSWU+PLmTYsJ2MPEZv4JaNvVs7JFoy1rGx+Yp hZBbn0pR8z1+phOG6Y/oEUyJepDpYw/WyEzRoOtLDkaGopTewI1ijinR85on0eRslZxhGNC7ZuB fA4MjD7Hp24Aaldyo/hNkBcifMp48huQ57Udbkw6AaqOJptd7hhB2V5muL0YOUXie45kwlGef8w
 mqNG3kcXS1CeihQGr2/vioYVdZPN5oQmIHzOmcr+RQ74KHd4kVrehXKe0geO/ID+Z3j/ZpTA
X-Proofpoint-GUID: 8JwVH7MxVq-tLCvp1O0zKL_XLBrv5BUM
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6865fa7c cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=HGTOStO9Rt0DlFUCaRkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030024

On Thu, 2025-07-03 at 10:07 +0800, GONG Ruiqi wrote:
> Hi Mimi,
>=20
> On 7/3/2025 9:38 AM, Mimi Zohar wrote:
> > [CC: Nayna Jain]
> >=20
> > On Sat, 2025-06-28 at 14:32 +0800, GONG Ruiqi wrote:
> > > ...
> >=20
> > The original reason for querying the secure boot status of the system w=
as in
> > order to differentiate IMA policies.  Subsequently, the secure boot che=
ck was
> > also added to safely allow loading of the certificates stored in MOK. S=
o loading
> > IMA policies and the MOK certificates ARE dependent on the secure boot =
mode.
> >                                                                        =
        =20
> > What is your real motivation for moving the secure boot checking out of=
 IMA?   =20
> >                                                                        =
        =20
>=20
> Sorry for not stating that clearly in this patch. I think the cover
> letter of V3 I just sent few minutes ago can answer your question, and I
> quote:
>=20
> "We encountered a boot failure issue in an in-house testing, where the
> kernel refused to load its modules since it couldn't verify their
> signature. The root cause turned out to be the early return of
> load_uefi_certs(), where arch_ima_get_secureboot() returned false
> unconditionally due to CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dn, even
> though the secure boot was enabled.
>=20
> This patch set attempts to remove this implicit dependency by shifting
> the functionality of efi secure boot enquiry from IMA to the integrity
> subsystem, so that both certificate loading and IMA can make use of it
> independently."
>=20
> Here's the link of V3, and please take a look:
> https://lore.kernel.org/all/20250703014353.3366268-1-gongruiqi1@huawei.co=
m/T/#mef6d5ea47a4ee19745c5292ab8948eba9e16628d
>=20
> > FYI, there are a number of problems with the patch itself.  From a very=
 high
> > level: =20
> >                                                                        =
        =20
> > - The EFI secure boot check is co-located with loading the architecture=
 specific
> > policies.  By co-locating the secure boot check with loading the archit=
ecture
> > specific IMA policies, there aren't any ifdef's in C code.  Please refe=
r to the
> > "conditional compilation" section in the kernel coding-style documentat=
ion on
> > avoiding ifdef's in C code.
> >                                                                        =
        =20
> > - Each architecture has it's own method of detecting secure boot. Origi=
nally the
> > x86 code was in arch/x86, but to prevent code duplication it was moved =
to IMA.=20
> > The new file should at least be named efi_secureboot.c. =20
>=20
> You're right. I didn't realize it's arch-specific in the first place,
> and moving and renaming arch_ima_get_secureboot() turned out to be a
> real mess ...
>=20
> So the V3 keeps the prototype of arch_ima_get_secureboot(), and only
> moves out its body, which I think can also better represent the
> intention of the patch.

It's definitely much better.  To summarize, arch_ima_get_secureboot() becom=
es a
wrapper for integrity_get_efi_secureboot().  Before loading the MOK/MOKx ke=
ys,
load_uefi_certs() calls integrity_get_efi_secureboot() directly.

With load_uefi_certs() calling integrity_get_efi_secureboot() directly, ple=
ase
check to see whether an integrity_get_efi_secureboot() stub function needs =
to be
defined.

Mimi

>=20
> As of the name of the new file, as V3 has been sent earlier and still
> uses secureboot.c, I can't change it there. I can do it in V4.
>=20
> -Ruiqi


