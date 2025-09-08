Return-Path: <linux-integrity+bounces-7034-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33782B49B4C
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 22:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06BD4E4750
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E02DC34B;
	Mon,  8 Sep 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pv2X6O+3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5B2DC338;
	Mon,  8 Sep 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365111; cv=none; b=aw5OhPNwPBn3oiKqcLzxhpxpBgY5dHXCuX1mOmO2Hm7WTWpH6Abjr2o8Wa2FBtO67MkM0vMs54Yg5PskCskUClTYYSKrdvhnzs+cqoASNNuXsYYY9HpWTmewknjadrpGeyA/NDYFXi5a7ypYeFKLeoYn4PZNkXFNgIpll+0KRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365111; c=relaxed/simple;
	bh=4thkF1YwBFEYK4kLOlebSDWiMStEwrhTHQm9+zku5J8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gMrKdxvvnSZ7f8TEnhe65oj7CjMOM9Nv5ylxqmyDrPupeSpe6ek7QkBgkucxpwlQ2Hs4AcC2WnXw9Il8drOadtiu4UkIKOOVsdz7RBqhIAtMdI50ICs6sEx83kM4WPkXUA+xZv309ZbyZu3+xpr6O5XcK9avrDOocCwLj0EKA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pv2X6O+3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588JcNih009190;
	Mon, 8 Sep 2025 20:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lifV1g
	Hgbyl3UY5fdAgu6jOph8ep32IeJsccMuOyjpg=; b=pv2X6O+34W0TebnU86aZdE
	9az+CVSSb+2p7Ef+4HIJoB2PLx97fd44S4qkva4YYQuI2R6ZZaaVPrdU6Q1RifJE
	2uTyv3AgWtQqShQwzZfwMBOsL2boJVpfCd/Mxx3qK104Avlj9EsAIkEUB+jGLFQY
	c94yaAFmt9OaAv7Ix0mdzwjw5XXpLQDyKUh+2WKdOKs/W+PWBbyeNZ2ZeAutVZCE
	847RgfZPHBJlQJdJA9cHADTn1ugojWu+bohw+QshITFs1ETfF53L5SI/ZgRHUzYz
	T7wRT4j6b1NRzlpSjYRCcHCJ9AR9WGPArwbwMZtyq1/r0FE484djNlenhunRcPsw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acquwd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 20:58:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588Kw7rL011292;
	Mon, 8 Sep 2025 20:58:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acquwd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 20:58:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588K0DOZ020499;
	Mon, 8 Sep 2025 20:58:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0r24a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 20:58:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588Kw6dn28574076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 20:58:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63A8258051;
	Mon,  8 Sep 2025 20:58:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA1E5805A;
	Mon,  8 Sep 2025 20:58:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.151.244])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 20:58:05 +0000 (GMT)
Message-ID: <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	
 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
References: <20250902042515.759750-1-coxu@redhat.com>
		 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
		 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
	 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Sep 2025 16:58:05 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wm2LA_VY51gnsVuUZzmL5V_zMTUcOQih
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bf4360 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=l0XoPeyDebXZSsvv9nAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QawslZNTIAq1j2t7XwWPxB1569r3NAhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXztNDf731NSlP
 gRqwkRV4rCsnRDiZh+Ombu+CX8cEhEI9aXbanfn+l3vDKfcAPyaA4JiSCum+EWV0AuPXChTIH2W
 TNqwOV7BAskqmnJSTL7VGwUBA+xMLO6RhP3bIJMM33i8PR1Dsd501HjD+0z7ILo1OXlIE9F/ZwJ
 PPaDawQ8mSEF+HpqWAE6ZXtZZlkZSY8BaQLbPGEO37B+PXHhLi4U7UzYxa62YnOX10gKeFuJlRg
 oebH6UuMPiLFal0CrEEhHuE7qSEQdeyRpTLa7jjmDipbIEAcT/J0nB5WvPAz8cR+bfMO2MR/EYk
 5BfIRvuQ7lJScjHNdYfyRJ8+w9CHZCi7PrBR/K08DOCJn0RaRgJahaAzLzbSJjQtyV+XUOpzlzd
 FC2ZxLyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
> Hi Coiby,
>=20
> On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
> > >=20
> > > Even without an IMA appraise policy, the security xattrs are written =
out to the
> > > filesystem, but the IMA_DIGSIG flag is not cached.
> >=20
> > It seems I miss some context for the above sentence. If no IMA policy i=
s
> > configured, no ima_iint_cache will be created. If you mean non-appraisa=
l
> > policy, will not caching IMA_DIGSIG flag cause any problem?
>=20
> Sorry.  What I was trying to say is that your test program illustrates th=
e
> problem both with or without any of the boot command line options as you
> suggested - "ima_appraise=3Dfix evm=3Dfix ima_policy=3Dappraise_tcb".  Wr=
iting some
> other security xattr is a generic problem, whether the file is in policy =
or not,
> whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should ins=
tall
> the IMA signature regardless.

My mistake.  An appraise policy indeed needs to be defined for the file
signature to be replaced with a file hash.

>=20
> SELinux doesn't usually re-write the security.selinux xattr, so the probl=
em is
> hard to reproduce after installing the rpm-plugin-ima with "dnf reinstall
> <package>".
>=20
> thanks,
>=20
> Mimi
>=20


