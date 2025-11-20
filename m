Return-Path: <linux-integrity+bounces-7651-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B62BDC751D7
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 16:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75E1836410D
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2897F1B4138;
	Thu, 20 Nov 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="afGi3yXH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C42773E6;
	Thu, 20 Nov 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653209; cv=none; b=Gpht1Wll+W4iXElKi3snfRV8Xq7ca0YKbX2F72LGQ4QysjdiRIcUsbAD70GwOIcfr8bBFNuo62KJ65empaSc+dt1oRg2MhfCVbnJILCu9oBjpt8sKRaIlPBuAOL6Sftn1TMPxgE09EXXlRtGYzRFUp4VFEXKrAFnRModu4wf0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653209; c=relaxed/simple;
	bh=XDAyAEci4/N6LxfoiJFw04BNQW2HE9TmENDL0opohHw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ol8ij/B2CRY0VYvTmmKuLbF1gv0GeUeHNarRrhJHGWR3/KXk++RUi5knecoOf+guxBJVNu8pnnZqaZ5HYR+TGOmkU2BShTLM/SP5B4k6WPje3xzvzkMSYkLRv/BigFsCuox6Ank7FW+CCcdKvjTOfgE4YyIbVnkQ+B0UCUJnCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=afGi3yXH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCVGgT004022;
	Thu, 20 Nov 2025 15:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cRR0o2
	N2FBm3wf13KB7hlFlLM/YGfjnr7VgEdvhnT3M=; b=afGi3yXHAkBS67ptTT5Dg6
	KIOjThGgHhZeAafvndSwyWNVbFIz8YqdpF2WPuk5AqPD2kh9v4PWB+u3o/oZvJSa
	EI0XG2KFFVLeFkFcAAhMUgVEOrxTP5ppd6Mf/yBrCesOJdg4jCitrmyqskrCL/gY
	fzOjwj8ME6UFz4Z71wVk30B4G3uQEgw7F9MmOFkjFCeSwNvro4RMEvfwv3q5SNJl
	z81+9iPaBTD2k8hAl7VC+g5DnUgxXDQXjDMKlBnPlTxN6mkMKJ9+8nCjY2L42nV1
	Q/+EVe+unmluKFVm51/6HgRUQlC3hDhOvvhUK3OmC0AyGpab9k8Yjxse00VOFv7w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju5rk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 15:39:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKFdZEk015036;
	Thu, 20 Nov 2025 15:39:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju5rk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 15:39:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKEc0ue017326;
	Thu, 20 Nov 2025 15:39:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1xuqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 15:39:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKFdXAd39781040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 15:39:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C78D58054;
	Thu, 20 Nov 2025 15:39:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6417C58052;
	Thu, 20 Nov 2025 15:39:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.44.232])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Nov 2025 15:39:32 +0000 (GMT)
Message-ID: <9f593c5f5882e8ed0d807376eefd4530462741d3.camel@linux.ibm.com>
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, code@tyhicks.com
Cc: Lennart Poettering <mzxreary@0pointer.de>
In-Reply-To: <16c73b4e0761a1622770102d1d48982fe9ae86ac.camel@linux.ibm.com>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
	 <16c73b4e0761a1622770102d1d48982fe9ae86ac.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Nov 2025 10:39:31 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NRgJbhtNLeCAqPbRYsjw6qnS0Phsok9N
X-Proofpoint-ORIG-GUID: nZXzqB3Y4K6G6ifu_Acve7niwZA4FPVj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8a5s9pbUlcZ6
 P6eFxLQnYNUA7vLcZv6dCc5EFSvHDHPdLFbQpkUdYww2ie29VM1KNR48l1zZZnRPiAZ41x6rUIO
 8HdyHXYLqgl9EqT6iL+rT/+9byUIB40loZU/flQaZf0VRNN6bVwR5l9P4v7p+E+2viVW+UuVMF6
 MeJZrk/bSTXvERQXe+VNKXtd2u98jky+QFQRvlb0WfEXk0EyKbYYjx0xceJbkePL7g4sr8aSqAg
 Ksu17MIfkR99bWuYXVDhuOkohcteGautJAaGqZt/zwAIcZ71ceU8Az2UMiZi/HY9r0RZ5GioA6m
 kbMQ17VEzB9RpIYUxwxgNpTBrbDIqhayOX8QOUzuv78D7zZ3lmCSaFTJy8xykp4dPqR4V6R5ia2
 L3jCzOAD2H74QzCiJHZtmpvTBPvQ6Q==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691f3637 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=ecaSOxdSUfGXkan3tZ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

On Tue, 2025-11-11 at 06:40 -0500, Mimi Zohar wrote:
> [Cc'ing Lennart Poettering]
>=20
> On Thu, 2025-11-06 at 18:14 +0000, Tahera Fahimi wrote:
> > Prevent redundant IMA policy rules by checking for duplicates before in=
sertion. This ensures that
> > rules are not re-added when userspace is restarted (using systemd-soft-=
reboot) without a full system
> > reboot. ima_rule_exists() detects duplicates in both temporary and acti=
ve rule lists.
> >=20
> > Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>
>=20
> Sorry for the delay in responding ...
>=20
> Before trying to fix the "problem", let's try to understand it first.  At=
 least
> on my test system (-rc5), kexec is working as designed.  On boot, systemd
> replaces the existing builtin IMA policy with a custom IMA policy.  The a=
rch
> specific policies are not affected, as they are persistent.  On a soft re=
boot
> (kexec), the IMA custom policy is re-loaded as expected.
>=20
> To verify the above behavior, extend the IMA policy before the soft reboo=
t.=20
> Notice after the soft reboot that the original custom IMA policy is loade=
d and
> not the extended IMA policy.  Roberto, if there is a problem with this be=
havior,
> we'll discuss it independently of this proposed patch.
>=20
> The question is why are you seeing duplicate IMA policy rules?  What is s=
pecial
> about your environment?

I'm now able to reproduce what you're seeing by executing "systemctl soft-
reboot".  After each soft-reboot the custom IMA policy rules are re-loaded =
and
appended to the existing IMA policy.  As Roberto mentioned, there is no opt=
ion
to replace the existing custom IMA policy rules with a new custom policy. W=
e
might consider doing so in the future, but for now the onus for not re-load=
ing
the custom IMA policy should not be on IMA, but on systemd.

Reading the same securityfs policy file used for loading the IMA policy wil=
l
return the current IMA policy. systemd could detect whether the existing IM=
A
policy contains the custom policy rules, before actually loading them.  The=
re's
no reason for adding this functionality in the kernel.

--=20
thanks,

Mimi


