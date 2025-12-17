Return-Path: <linux-integrity+bounces-8110-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F4CC96DC
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 20:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382D9301D9D5
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 19:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3E2C027A;
	Wed, 17 Dec 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JPjzcvlu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A2270EC3;
	Wed, 17 Dec 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000488; cv=none; b=P8oW1+YRK+XlTAWC7vXtz+oNmSjZKSiluArs1ZkhDdgx3mGxEONDrGWH/p+Q95pdbMiK+r8UgXBTkYvQBuWTadYUTuqwOjkOpdwfChqTRXTMyD2pVTG/D/nQ2jjejZNQafLyvC6l6TPXrhn4C66egIg2ru93G4MSS3TkqFhlJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000488; c=relaxed/simple;
	bh=+ZypzMriPvRtTLk1UX6FA8/lBlKEUmOB3SVlQMRfSjE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YK9veTjkqKXgmyJ6XQgXEbDz5B7/tjQNji5COEbW8GiuNHgpITqc6a9DV6vC+5VUnH1W9Ji51lYN1AQqapm+SfftQbTUdW/wG4+qcDSReToliss/RO1m4C7R4z2z3QRZX3m03PPfsxvy/sRKr5c26EUPCtGV5sR5FuSMvQ2eR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JPjzcvlu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHBKDMo029270;
	Wed, 17 Dec 2025 19:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lu4Dg1
	iWw05HEQbbeDiHRsTb1m1n2aqxv/D2YbRLv7M=; b=JPjzcvlu+86zFwNL13iNEE
	Sdjk7xiIHaE54Uk7mNzore9w016xvtZptZpV4S3NnwGtDccmwHYvsfrn4YmCmXAX
	vXzL88/ugC67VJ2/6BKFuWYTcrm1BEvC3/L6Kmrg9mH7XwtYSILynWB47yUt3DhE
	N3RsmxvN5ylWJipIYex+b5aOL95VVPH5d+M1sm3H3ob54OxaO2vukWwYxFkbrbJi
	kIFFxUN5p8iG/frKbUnHEFzvqxTQWDvvHJUGI2ddyDCaMRcbvm3ydik70+Y+ANbq
	WxwTFrX586Vbm0dSmHHNHzXeddZvtu19GsvY5AGF42DfPLFipgoWs72WXJ9iYClg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvf0j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 19:41:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHJcomP014918;
	Wed, 17 Dec 2025 19:41:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvf0j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 19:41:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHIJKtK005806;
	Wed, 17 Dec 2025 19:41:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp313g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 19:41:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BHJf3r024183550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 19:41:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4759A58058;
	Wed, 17 Dec 2025 19:41:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5531E58057;
	Wed, 17 Dec 2025 19:41:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.5.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 19:41:02 +0000 (GMT)
Message-ID: <8ef8a96eacbaa71f359ff800e7417ae565b95e81.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <41ead1c44a678b597ffd3350cce332a8a5d4ac7c.camel@huaweicloud.com>
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
		 <45ca26a5b08f42fb1318cd78a62dda20b9adb84e.camel@linux.ibm.com>
	 <41ead1c44a678b597ffd3350cce332a8a5d4ac7c.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Dec 2025 14:41:01 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfXx22SN0YXGd1y
 i3/COUJHtVrRzFgjzLA5WOqV/hv1Of5bdUqZbOQk/ra+SPrzbs/jLGdbK4Doxcmwwjn8zM4vB+q
 7t65I+bms27tdTFh5+ffmTuDXi/7CAts1Wpwxcdi57jrVgPM57MVEjFwOBYKFI19y4Rx/tksn+d
 eJ4QOPSLKyETTEhjAkpSDLwONQ4waR6FJo3YckvdVUED3LunRMoxDCkztqd4pA/EaIaBvSIlqJj
 3it2xT5TDUQ8UIKpGEz6Yng+B2zOF3vOULV+lImdTxLiHppr2GjZC54+3kTzxXsuTTlz0UNC2y3
 3pH79b1KeFgmwcpg68M3epIKWG9MwRjAU/eIOONZRUk7QfeqlDqJnw42BCSqIDZ6WcMJR1bLkej
 kx9gDVRe9Qnx/l6DB8nifTl20eWMgQ==
X-Proofpoint-ORIG-GUID: WDL9zEmPZ02Er_BtEUpOJbQIrYWTNoQa
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69430751 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=f4KxpfNTu-1Vb7Gj6-cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A2JYgC1vBlzfih75d51bimKymf17DbjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

On Wed, 2025-12-17 at 17:01 +0100, Roberto Sassu wrote:
> On Wed, 2025-12-17 at 10:26 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> >=20
> > Thank you!  Everything is working as designed.
> >=20
> > - Only public functions require kernel-doc comments, but other function=
s would
> > benefit having a comment.
> >=20
> > - As I mentioned in response to Steven's patch, "After trimming the mea=
surement
> > list, existing verifiers, which walk the IMA measurement list, will obv=
iously
> > fail to match the PCRs.  Breaking existing userspace applications is a =
problem
> > and, unfortunately, requires yet another Kconfig option.  It needs to b=
e at
> > least mentioned here in the patch description."
>=20
> Hi Mimi
>=20
> sure.
>=20
> > On Fri, 2025-12-12 at 18:19 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Introduce the ability of staging the entire (or a portion of the) IMA
> > > measurement list for deletion. Staging means moving the current conte=
nt of
> > > the measurement list to a separate location, and allowing users to re=
ad and
> > > delete it. This causes the measurement list to be atomically truncate=
d
> > > before new measurements can be added.=C2=A0
> >=20
> > This last sentence is the crux of your of your proposal.
> >  -> "quickly be atomically ... so ..."
>=20
> Ok.
>=20
> > I must be missing something.  With the ability of trimming N records, i=
t's
> > unclear to me the benefit of staging the measurement list and requiring=
 a
> > separate deletion. The measurement list can be read before trimming wit=
hout
> > loosing any measurements.  Like now, the entire measurement list could =
be moved
> > to a staging area. Instead of freeing all of the records, only N record=
s would
> > be freed.  Afterwards the remaining staged measurements (N+1) could be =
restored
> > to the head of the measurement list.
>=20
> My hope is to avoid trimming based on N in the kernel, but rather offer
> the same functionality on a user space service that simply gets all the
> measurements it can from the kernel (with the stage all approach), and
> exposes the desired measurements to requesting applications (based on N
> or based on a PCR value, as Microsoft requested).

Agreed, the measurement list needs to be copied to userspace and saved.  Ho=
w
userspace applications will access it needs to be defined and documented.

I thought Microsoft backed away from trimming the measurement list based on=
 a
PCR value. At least basing it on a PCR value, is not implemented in the ker=
nel.

>=20
> I think it was already mentioned earlier in the discussion. By reading
> and trimming at two different times, there is a race window where two
> separate remote attestation agents determine N on the current
> measurements list and attempt to trim one after another with the same
> N, but the latter attempts to do it on an already trimmed measurements
> list. They could take the write lock for the read too to avoid that.

Yes, I saw the problem in v1, when the second request wasn't rejected but w=
as
synchronized by a mutex.  That should have been fixed in v2 with your locki=
ng
changes.

>=20
> The stage all approach is not susceptible to this race window, because
> it does not require a prior read before the operation.

I'm not convinced of that, as any application with cap sysadmin can initiat=
e a
trim or trim & delete.  At least at the moment, there's no way of limiting =
the
trim/delete to a given application.  Perhaps it could be limited based on
SELinux labels.

--=20
thanks,

Mimi






