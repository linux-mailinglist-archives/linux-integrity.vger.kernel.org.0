Return-Path: <linux-integrity+bounces-6310-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC8AC50AD
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 16:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E163A181F
	for <lists+linux-integrity@lfdr.de>; Tue, 27 May 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB527602C;
	Tue, 27 May 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oZJzEvrt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CCA1E5B7D;
	Tue, 27 May 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355496; cv=none; b=fDQ8zCIEJYSuvXvgUBCRxneAHv9JS1ZzNIWYt7nWBMMupL5tgoRXEgJUn78vodQsYbB74IpJnWk51gGPyMf5Fe9Uh0hNJpPTAWQ9LzczavbdWwuF3ERGD22PSbuReoiHpznvLgjqSeEbqk3T/uYpsVYzJJUhboVy9K7IZnRG2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355496; c=relaxed/simple;
	bh=Jrs2PsKuvoVp1OsGBlJRS5Aku/uOu1fascx9y3dS0Ds=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=duTriPUXqlgN8CpF8SYH6UocNIkhxIhxSGfGDYXMGy0PlU4zSgxxyUDgVgEdSGfKDKhR6Xh3TpJOu3f8JMbOMmkUaqPss2gMDDpv9Rb2LN3L9eOsET4x+c9+uA9VyRim1J+bHzCm2IzFIPmmWQ94Y3W/PkKuq5joSdPaBXZILmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oZJzEvrt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RE32vG011956;
	Tue, 27 May 2025 14:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gdCpPJ
	gY2BBY5QHOA9MLQEpeCzq2THP0NuLmeUUStW8=; b=oZJzEvrt2evzEEMucZ0kBX
	7XGTiedUi0Tc2jixr+Hy24P83PGEXrWoEc41FGuQMzZj2TpyPFwhdmArZGA1eme+
	eKX+aULptDG5LkkQogqiTlmYhxy33xKLaCkiXuR7Si1Jg9uJZcni/Nv87xRIlcwc
	WrskWGdxxYNQTaLlw821AZdoZ5EA5Ctg6rcJaUR+7/ut9ClKucNEoEDI1DQrb9RI
	Iymy1/iC2ghGDxtyTFKvRQa2hxxuuf20DKOc4K76vuPZUf23VwjApZcggRktPRtf
	XRHoRAh3jHAgtV0UtcMWPKR64eUA/5MlJ6KBiy6cH382yfHkcC9kD/hgXveAL26A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u4hnevyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 14:17:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54RDJFtu028925;
	Tue, 27 May 2025 14:17:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46useptxuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 14:17:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54REHtMo24773338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 14:17:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49EE58053;
	Tue, 27 May 2025 14:17:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A297B5805D;
	Tue, 27 May 2025 14:17:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.137.101])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 14:17:54 +0000 (GMT)
Message-ID: <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Pingfan Liu <piliu@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: prudo@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de, coxu@redhat.com, ruyang@redhat.com,
        chenste@linux.microsoft.com
In-Reply-To: <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
	 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
	 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
	 <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
	 <aC86NSypHlER2C3L@MiWiFi-R3L-srv>
	 <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 May 2025 10:17:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HvB2G1TS c=1 sm=1 tr=0 ts=6835c995 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=IVwv8Uz7kQULgHmu4x4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vkp5hxhSLJ7zdSMRQ-chaKB_rRihN71G
X-Proofpoint-ORIG-GUID: vkp5hxhSLJ7zdSMRQ-chaKB_rRihN71G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDExNSBTYWx0ZWRfX09z5M1jtFHoP I/3VEGR33cRH6XswNGrgzAfviqpa4uzihkKguUioEeLZnNaivMyni0MLwBIbp3MJ4MI/i9eCnL1 nXd/sUwBDtmFqPax6qBZNDBtAdAjD3nazrGzhXeYpLoEyvLR5C/3UYAVQ4pJvOHcwr8D/mntKXR
 br7C4QMfiiYPfgkWNcxRkSZWSZjvjbA/tYvM4fmyLMqsVNJVv2bE8iJbBTkho/rpIYOVeR/rj02 IKQcONvHxAO04BphJ0Rt2jOu6R1Plpu8yPpBZLCxsFAA3eAUe44wp/OPwmf2ofWVQcR6aKAFeFh geKhdMQKBLewU8TL855aRiNOp+vGbsF1atEjyNHfwe3ZniNSJY3tUNhL1Em8VTszFSiQPXo27Nk
 Ku6V6h7ZIUkVvOnZEE+5kp5VVfYkdO6hZspjXDMAEiN/kRZG2E+L4CDS4RyHQAcafOniOwoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270115

On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote

When responding to kernel mailing lists, please use plain text not Mime enc=
oded.

> On Thu, May 22, 2025 at 10:52=E2=80=AFPM Baoquan He <bhe@redhat.com> wrot=
e:
> > On 05/22/25 at 07:08am, Mimi Zohar wrote:
> > > On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
> > > > On 05/21/25 at 08:54am, Mimi Zohar wrote:
> > > > > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > > > > > CC kexec list.
> > > > > >=20
> > > > > > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > > > > > Kdump kernel doesn't need IMA functionality, and enabling IMA=
 will
> > > > > > > cost
> > > > > > > extra memory. It would be very helpful to allow IMA to be dis=
abled
> > > > > > > for
> > > > > > > kdump kernel.
> > > >=20
> > > > Thanks a lot for careufl reviewing and great suggestions.
> > > >=20
> > > > >=20
> > > > > The real question is not whether kdump needs "IMA", but whether n=
ot
> > > > > enabling
> > > > > IMA in the kdump kernel could be abused.=C2=A0 The comments below=
 don't
> > > > > address
> > > > > that question but limit/emphasize, as much as possible, turning I=
MA
> > > > > off is
> > > > > limited to the kdump kernel.
> > > >=20
> > > > Are you suggesting removing below paragraph from patch log because =
they
> > > > are redundant? I can remove it in v2 if yes.
> > >=20
> > > "The comments below" was referring to my comments on the patch, not t=
he
> > > next
> > > paragraph.=C2=A0 "don't address that question" refers to whether the =
kdump
> > > kernel
> > > could be abused.
> > >=20
> > > We're trying to close integrity gaps, not add new ones.=C2=A0 Verifyi=
ng the
> > > UKI's
> > > signature addresses the integrity of the initramfs.=C2=A0 What about =
the
> > > integrity of
> > > the kdump initramfs (or for that matter the kexec initramfs)?=C2=A0 I=
f the
> > > kdump
> > > initramfs was signed, IMA would be able to verify it before the kexec=
.
>=20
> IMHO, from the higher level, if there is a requirement on the integrity o=
f the
> initramfs, it should take a similar approach as UKI. And the system admin=
 can
> choose whether to disable the unsafe format loader or not.

Yes, that is a possibility, probably a good aim, but in the case of kexec/k=
dump
that isn't really necessary.  As filesystem(s) support xattrs, IMA policies
could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to include the
initramfs.

>=20
> This other thing is how to make a handy signature on initramfs? It is nei=
ther
> PE nor ELF.

IMA supports signatures stored in the security.ima xattr or as an appended
signatures.

Mimi






