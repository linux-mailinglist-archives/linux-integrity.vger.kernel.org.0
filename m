Return-Path: <linux-integrity+bounces-8234-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCFAD1FA34
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AB5C3009F2E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205C1EF09B;
	Wed, 14 Jan 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OAreXrHY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DB3168F2
	for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403526; cv=none; b=n+rDMcO2UQGIZp0q9OGr2UaaoRxq8vIN2ZGK1d69GIbIp7fk1wNeZ0WfwdW1f1i2lKrcLufYgoi+ICPtG7zk7p90Y6/lR4StC4m3I9fecwvjk9EhB07I3kz7R+Npu/eiFScTBb7cyOInnNCd/Tg9UHG7FDNdq2B/Eq8c0EgeutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403526; c=relaxed/simple;
	bh=GFhDXxtQOOoEkWKmVZbsCRPZPlZccP8v389vSIUUGps=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SSUbbaO5yS9JBzrayRdL0DJT6VS7eXzgQ+5HmGedEmAJhvIvUrLbMDGSI0nH0eUdoU5TPawgsIImnUW6r1jZMWnB5adR7Eo9fsJL/pKywn8kLsFeV0RfSR/yMBTRFAC9XFMx/rkLF+zrBF3bZbUpBuaBSBQUnkmMerfognnHFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OAreXrHY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EE1ctU013363;
	Wed, 14 Jan 2026 15:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VQS6zr
	w/Rv+8VRfrDR4ZQiwYSwb0FJjDA0oTmHAH6WU=; b=OAreXrHYnls+XNzOn+iule
	+0V9UeBMb1zz1ADs4xLBBrFl/gNH0g5KvHAcxHUtqtV2MCg0LHs2ucGx6wtIIKxO
	LFZZWPjVBpbRy1IMAb5mJy1s6a52OtlA4wYpPXoqp6i6cQt1y47bEIGgqRprV1Q5
	NQqh3O58RKdZ1aFUbd2SLh0phK/LV24KP1A2mxhpPyO/gnj7SyV5VSB4Kw7ydxmE
	XV6u1ZqCo2bgLGCsLgZ86gTZZFiv01lFMdbxFkfCzy97D82RxINHW7mdXPk9nW0Y
	mHppkXH5uwGuQmx/v7ffi1/MyegJp1HORKV1LQQ61iDm2lgcYxzbrn59Z0W2Cm5Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt1kjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 15:11:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EEVVNV025848;
	Wed, 14 Jan 2026 15:11:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kkjqgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 15:11:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EFBexh27591190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 15:11:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B51985805E;
	Wed, 14 Jan 2026 15:11:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61A5E58066;
	Wed, 14 Jan 2026 15:11:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.13.234])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 15:11:58 +0000 (GMT)
Message-ID: <41d432e3b9c16d712080295235ca000a6cb6e07c.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima_kexec.sh: Document kernel config dependencies
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20260107155737.791588-2-pvorel@suse.cz>
References: <20260107155737.791588-1-pvorel@suse.cz>
	 <20260107155737.791588-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jan 2026 10:11:58 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX2Jr+Uv04Tgmz
 minhAVAqdl2On7tAwIyWTeS1Fcp06zgspCZGevN3omzM7+Ty/Y12tINMwGfGHXpdYhZCi3DaQ7P
 DATIa7WV64wNY1/TEATbbcnQ7X91pv6s3jYfx13b1y0E5eMMXGyvSTV4Paid1buZVBC9rTwwpOz
 BDI9xrwbWIB2gTBj6xEXlReGa0uHW7pPoi43NqkSElLFb0VK50Dkyzg0mwuiOChYaOxptsIOVqo
 XRfu51sUdr28QIxAcc0vu8VqdLp9KsFOllxa5bxukglmGGcnSxt2fIZBnFHcXZ1nT2d2DI/Ij5X
 jYnuy7v8Ru3AooyaUE3mjYZB8Mp3SaDIsRUNjiaRFmSoRKBXDW5g8v2wKXTW3KcD5Eyhmsl4CiC
 lgXbfr3lhhinDrVS2slsGqdf3Uiu+vPzcPtGA6XftiKH54EzuW/j/46HmhTiXsrq2J6Mnv9AFWx
 kUcvrTajafKNz1RyclA==
X-Proofpoint-GUID: GRGK8s7iYE32UZHOb2wVKvattaoOMkFt
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6967b240 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wlRH1G3uh7w6tWQy2i0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GRGK8s7iYE32UZHOb2wVKvattaoOMkFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140123

On Wed, 2026-01-07 at 16:57 +0100, Petr Vorel wrote:
> CONFIG_HAVE_IMA_KEXEC=3Dy is enough for test, ie. test is working with:
>=20
>     # CONFIG_IMA_KEXEC is not set
>     CONFIG_HAVE_IMA_KEXEC=3Dy
>=20
> Probably obvious as CONFIG_HAVE_IMA_KEXEC is arch specific and
> CONFIG_IMA_KEXEC is "TPM PCRs are only reset on a hard reboot."
> and ima_kexec.c requires CONFIG_HAVE_IMA_KEXEC (only parts are skipped
> when CONFIG_IMA_KEXEC not set) but better to clarify for users.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_kexec.sh | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b=
/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> index 7688690af2..de595fcdd7 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> @@ -6,8 +6,11 @@
>  #
>  # Verify that kexec cmdline is measured correctly.
>  # Test attempts to kexec the existing running kernel image.
> +#
>  # To kexec a different kernel image export IMA_KEXEC_IMAGE=3D<pathname>.
>  # Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=3D1=
.
> +#
> +# Test requires CONFIG_HAVE_IMA_KEXEC=3Dy (CONFIG_IMA_KEXEC is not manda=
tory).

Correct.=C2=A0 The test verifies that the kernel image is measured.  It doe=
s not
execute the kexec, so there is no need for carrying the IMA measurement lis=
t
across kexec (CONFIG_IMA_KEXEC).

> =20
>  TST_NEEDS_CMDS=3D"grep kexec sed"
>  TST_CNT=3D3

