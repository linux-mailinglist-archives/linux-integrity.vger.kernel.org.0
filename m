Return-Path: <linux-integrity+bounces-7528-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78FC0D5D2
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43934425057
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Oct 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DD2FF169;
	Mon, 27 Oct 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ti54F2YP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B72F616B;
	Mon, 27 Oct 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565858; cv=none; b=gr/QD2f5w+NVFo5Z9r1qDXJKZ/vZ3qLE+Sev9akoc8DWiEMe94r/lxiRql8GEUp4xorSTIaT5gXQbnfbM4CXAIYFgqtDOzKSENx2DYTft3OvFnvDzoyO3BNikjiMP4V+ZW6wEaAUoIfutlZQ+TQcB9pqJrYQlHx4I9wN3SR1LYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565858; c=relaxed/simple;
	bh=kRxbqv9V3bIG+mdvrIcvzgSy3xsHfoxKyfsKfO2UySw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=GXG2TUfP8Ah1xJaZom/tQt9Qrday3NBczw3Q7CkIkX72r8P7T1lIIPbfFmVN/hdlpZk1fYFGCgrKh1Ft+oAlF0pPP4KecRk05Yo1vz7PzSDfZqq5OwXE3qwstDPj6znDMoyslcAPGC6gG8JkRZUW0aTQciuK+f+xFE41Si3yZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ti54F2YP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QJrwH6032230;
	Mon, 27 Oct 2025 11:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y6v86r
	x7/XGs1peAi1UX5G49p8mC0nAvti66w2gmeII=; b=Ti54F2YPigBgClPEpqG0Gb
	DjnAiYV3VV9aOxmxxMbV0ZRMg3ZbKU8FCjoMViD3+LhHNO7Ay4cHaLlCLPhzSOAZ
	5JtO1qOqA4BIrDYON9jlXp553u7QMdfZUuZG6SedlWZprIuePWH3+cFse6L0y+lV
	1XZLlRG8bUe8w10U6EcQUu+8ZyG/RopOGF7GSONlSxmR4eQvdmk7I9PC76p3emjd
	P9EIXGurZPKqN5hjz1fA6Mhyt7BJgM/y+65xcNNfb1Q7kyTgyD7+/pKd6DTy7dzE
	7MXn33OBtSt5Y3LWZYiIUbP+HzARdcXf+pkkZ/ObrF1aOgjmAmTqzEqWNKLCqHog
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt6msf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 11:50:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RBonKY008885;
	Mon, 27 Oct 2025 11:50:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt6msc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 11:50:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBADgP022022;
	Mon, 27 Oct 2025 11:50:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vrwfha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 11:50:48 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RBomaw24511158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 11:50:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3523A5805C;
	Mon, 27 Oct 2025 11:50:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4050F5805D;
	Mon, 27 Oct 2025 11:50:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.87.131])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 11:50:47 +0000 (GMT)
Message-ID: <6fe4fb1126f2d45b77637c34bf274bef4205a427.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] pm: Ensure exclusive userspace access when
 using /dev/tpm<n>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Jonathan McDowell
 <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        James Bottomley
 <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aPvLtt7a7X0Y1LBI@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
	 <cover.1760958898.git.noodles@meta.com> <aPvLtt7a7X0Y1LBI@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 07:50:46 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d2nhWjqc5p_oYcExvqOsgZI2mO6ouuwh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfXxrvryAvJXKyc
 kpvLKNbIQtE55j8Ot3nshtan+3kG1RzPNTM6r+/1G5iXhXUu64XGHvMsOpcdXaplF40acMssdKj
 99qKHwivj4qr4S0r4vEgEAYaKc5u08Vau3DEe05pvLeYAuWWpC0FDi04ycEv5/UIxlPPeYKz9vk
 ZZTQSyQt8pvYt3ZaAor2gbX6U7OuKb7yt9Q27AqRHei/3X0ReZ9pZoQyhtzx6gAkpWhOy/ZTnhe
 jLzcCeDAIfTy4U1nPtJDOWnFdyEjBW/NBQqjddtiRdshX/ekR02tlioogi2YPS5CXbhWFzcQ+Sk
 z7lV9C8ex5J+66gZOhsz25V/feQ0o1grjNKjHfImn2L9nBezWbn/gStStZu3yZGOqqKkUIEIl+x
 /3FLYRX6PF9u20aq5uAzkurASKykYw==
X-Proofpoint-GUID: lqR9b5_uSbJ8glNt9TZyNxbxink6xjJt
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=68ff5c9a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=ox_7eZu1UUYG7ki4LxcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001

On Fri, 2025-10-24 at 21:55 +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 20, 2025 at 12:30:32PM +0100, Jonathan McDowell wrote:
> > I hit a problem where ~ 1% of TPM firmware upgrades were failing.
> > Investigating revealed the issue was that although the upgrade tool use=
s
> > /dev/tpm0 this does not actually prevent access via /dev/tpmrm0, nor
> > internal kernel users. It *does* prevent access to others via /dev/tpm0
> >=20
> > So the upgrade process started, the HW RNG came in to get some
> > randomness in the middle, did the HMAC context dance, and confused
> > everything to the point the TPM was no longer visible to the OS even
> > after a reboot.
> >=20
> > Thankfully I've been able to recover those devices, but really what I'd
> > like is the ability for a userspace tool to exclusively access the TPM
> > without something coming in behind it. Given the lightweight attempt at
> > locking that already exists I think this was the original intention.
> >=20
> > I've reworked this series based on feedback received.
> >=20
> > Firstly, it's been reordered TPM sharing functionality doesn't break
> > during bisection.
> >=20
> > Secondly, the O_EXCL check has been tightend up to ensure the caller is
> > also opening the device O_RDWR. Callers shouldn't really be opening the
> > TPM except for reading + writing, but this should help guard against
> > unexpected flags usage a bit more.
> >=20
> > Finally, this revision keeps the prohibition on more than one user of
> > /dev/tpm#, to avoid unexpected breakages for clients that expect this t=
o
> > guard against multiple invocations. A client only then needs to use
> > O_EXCL if it wants to prevent *all* other access, even with
> > ContextSaves, such as the firmware upgrade case.
> >=20
> > (I've sent a separate standalone patch that allows the TPM HW RNG to be
> > disabled at run time, and it's now in -next, but even with that I think
> > something like this is a good idea as well.)
> >=20
> > Jonathan McDowell (4):
> >   tpm: Remove tpm_find_get_ops
> >   tpm: Add O_EXCL for exclusive /dev/tpm access
> >   tpm: Include /dev/tpmrm<n> when checking exclusive userspace TPM
> >     access
> >   tpm: Allow for exclusive TPM access when using /dev/tpm<n>
> >=20
> >  drivers/char/tpm/tpm-chip.c       | 90 +++++++++++++++----------------
> >  drivers/char/tpm/tpm-dev-common.c |  8 +--
> >  drivers/char/tpm/tpm-dev.c        | 35 ++++++++++--
> >  drivers/char/tpm/tpm-dev.h        |  1 +
> >  drivers/char/tpm/tpm-interface.c  | 20 +++++--
> >  drivers/char/tpm/tpm.h            |  3 +-
> >  drivers/char/tpm/tpm2-space.c     |  5 +-
> >  drivers/char/tpm/tpm_tis_core.c   |  3 +-
> >  drivers/char/tpm/tpmrm-dev.c      | 20 ++++++-
> >  include/linux/tpm.h               |  4 +-
> >  10 files changed, 124 insertions(+), 65 deletions(-)
> >=20
> > --=20
> > 2.51.0
> >=20
>=20
> I will put to queue with my tags but I just want to make first sure that =
we do not
> break anything.
>=20
> I'll upgrade my test suite first to have TPM 1.2 tests (which is also
> needed for my own series) and run it in bunch of configurations.  And on
> TPM2 I check the behavior with TSS2 daemon on / off.
>=20
> I have no doubts on the code changes, and it is most importantly a
> security improvement, given that "who has the access and how long"=20
> can be deduced for a system configuration. I just feel that with
> this code change it is better to check and verify everything :-)

Roberto has already commented on this patch set, saying it would affect IMA=
[1].
I still need to look at the patch set, but please don't break IMA.

[1]https://lore.kernel.org/linux-integrity/cec499d5130f37a7887d39b44efd8538=
dd361fe3.camel@huaweicloud.com/

--=20
thanks,

Mimi

