Return-Path: <linux-integrity+bounces-7509-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D508ABF1AF0
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 15:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE536424E16
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E531AF1F;
	Mon, 20 Oct 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g6ms8nni"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4E2F658A;
	Mon, 20 Oct 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968672; cv=none; b=bl9wteIEacmeA0tjiYEDT9SHgJvJqH02/i6QKiDI/Af6fgme7sPk4O1XFd2cujbGf4kaT5o/b4HR+npHqbhmPDbL8t36GTAFsHGqaXD2Yt6oXE9/g0eU7E5hyVzQ2QDYz9ruTX4+AjBKcsxWycEi5asKcAXB4meh1rdqsIq2LTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968672; c=relaxed/simple;
	bh=EfJewJKCqwkKnxiSznc8qcyZN1Vw2BXdpnDJWqxZO3M=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DqmDXHHwjBv7htwrhnikRC4yHwy+wVqMOtFvPqauGLt85Kpn0AATG4KBCbrWx7eB3jmjeyH2GZrpjDx6FcNPVPtQ52C0jnKFtxNUNSszdrqjM8ZgcIkgdLG8vXpoYhXuZgUI8llEYLrnuHOOuio8Gg1Hc+nvOnCUGvzdVs1oHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g6ms8nni; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K5beXo018793;
	Mon, 20 Oct 2025 13:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yve0yJ
	M7ZmdqGlpy1Xr7QhofFTNeb0RkHAzL/vklFHI=; b=g6ms8nnilt/ntpFu9cBDbx
	l5dJ1Gn0NmeVVi7Ya+Jv1dcTPDGju6L+/UoAG8Obpq6buVgFZpKRfMD7HQNUOVPC
	okN1iPRdGu35YdpQqqytbMgFy3sYTlqlsXjMkzNeNLoeFNeSV1JtGtXsEUqaeuGL
	AfxObgAwwhV1j+Je80tIdsaREGPXYk5CZAdL/EQTULogJlnbUzM6XPmo4BViUnL5
	u+4FJLmqPDInlTdCsLwrJbnhmqhu4n4GU+X1jXDMp0iWnpqL5cm4PABfXr28k0pl
	8iTzHJc0Fnp4fw00tnkUvdTIy5R8x4H/ges1xn1ivVgSRod2WY23y315erzb9tNg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326ht0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:57:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59KDsrJg018280;
	Mon, 20 Oct 2025 13:57:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326ht0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:57:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBggc4002926;
	Mon, 20 Oct 2025 13:57:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej5rnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 13:57:22 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KDvLVq26935934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:57:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2FFD58065;
	Mon, 20 Oct 2025 13:57:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F1745805D;
	Mon, 20 Oct 2025 13:57:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.31.144])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 13:57:20 +0000 (GMT)
Message-ID: <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Coiby Xu
 <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Karel Srot <ksrot@redhat.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	 <linux-security-module@vger.kernel.org>,
        open list	 <linux-kernel@vger.kernel.org>
In-Reply-To: <1987088bb29971883d2b5c06a31c8114c729422c.camel@huaweicloud.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
		 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
		 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
		 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
		 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
		 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
		 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
		 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
		 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
	 <1987088bb29971883d2b5c06a31c8114c729422c.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Oct 2025 09:57:19 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f63fc3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LYr_apTUxKL3MJBV5QwA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+N+qd4P3G6/q
 sye6RtQq++OVB4vJnqVJTGEAbRsIJTNsx/dfMwENh1/iO2IAGDyZbk552zaLA6uUtpsL/gRF8l0
 mu9rm92l7H7Yq7XmDDJh4NFbHF9Ho+MSxV7546aZHLHPLap2PIdEQ5Xpv+Iif/N6F9R2NeV+EKM
 E/WgNin4NeN3tDFvHsPmB71ugThzM9A8jnHazpUOHm2nvaIIE67J0Ngl3lvP0SdeoBgFD0BN/Sr
 YgEFyCGMyXMuCcT92Xev51b2pDmZq4pPSeHuTb4EgT3dE8kJcINpg73LCIUNATkgdSASQ4uwtVs
 otFsnZrBoZpxAW5ft1RTmbzGtqFbB1Lfh36L6qNGy37bJYTIQYofRAUY4k+UfE0AwsZvCqZ8hzU
 5rHhGVP1JV6E7aijX3y88O3wi0QmBA==
X-Proofpoint-GUID: VC6fmD9L6N0feWbC717oBjoqNRvXhHMg
X-Proofpoint-ORIG-GUID: ppal_x6lshzEVmSX5bZg-TvOczGHsl-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Mon, 2025-10-20 at 14:45 +0200, Roberto Sassu wrote:
> On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
> > On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
> > > > > > 2. Instead of defining an additional process_measurement() argu=
ment to identify
> > > > > > compressed kernel modules, to simplify the code it might be pos=
sible to define a
> > > > > > new "func" named COMPRESSED_MODULE_CHECK.
> > > > > >=20
> > > > > > +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COMPR=
ESSED_MODULE_CHECK
> > > > >=20
> > > > > I also thought about this approach. But IMA rule maps kernel modu=
le
> > > > > loading to MODULE_CHECK. If we define a new rule and ask users to=
 use
> > > > > this new rule, ima_policy=3Dsecure_boot still won't work.
> > > >=20
> > > > I don't have a problem with extending the "secure-boot" policy to s=
upport
> > > > uncompressed kernel modules appended signatures, based on whether
> > > > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to=
 the existing
> > > > MODULE_CHECK rule.
> > >=20
> > > I assume once the new rule get added, we can't remove it for userspac=
e
> > > backward compatibility, right? And with CPIO xattr supported, it seem=
s
> > > there is no need to keep this rule. So if this concern is valid, do y=
ou
> > > think we shall switch to another approach i.e. to make IMA support
> > > verifying decompressed module and then make "secure-boot" to allow
> > > appended module signature?
> >=20
> > Yes, once the rule is added, it wouldn't be removed.  As for "to make I=
MA
> > support verifying decompressed module", yes that might be a better solu=
tion,
> > than relying on "sig_enforce" being enabled. IMA already supports verif=
ying the
> > appended signatures.  A new IMA specific or LSM hook would need to be d=
efined
> > after module_decompress().
> >=20
> > Remember based on policy, IMA supports:
> > 1. verifying the signature stored in security.ima xattr
> > 2. verifying the appended signature (not for compressed kernel modules)
> > 3. verifying both the xattr and appended signatures
> > 4. none
> >=20
> > To prevent 3 - verifying both types of signatures, the IMA arch specifi=
c policy
> > rule only adds the "appraise func=3DMODULE_CHECK ..." rule if CONFIG_MO=
DULE_SIG is
> > NOT enabled.  Calling set_module_sig_enforced() from ima_appraise_measu=
rement()
> > to set sig_enforce could inadvertently result in requiring both the xat=
tr and
> > the appended signature kernel module verification.  To prevent this fro=
m
> > happening, "sig_enforce" should not be set, only verified in
> > ima_appraise_measurement().
> >=20
> > >=20
> > > Another thought is to make CPIO support xattr. Today I realize that
> > > ima_policy=3Dsecure_boot can also cause failure of loading kdump kern=
el.
> > > So the issue this patch tries to resolves has much less impact than I
> > > thought. Maybe we can wait until CPIO xattr support is ready? I'll he=
lp
> > > review and test Roberto's patches if this is the best way forward.
> >=20
> > I'm not sure of the status of the CPIO patch set.  Roberto?
>=20
> I haven't had time to look at it recently. I can take the openEuler
> version, address the remaining comments and repost.

Thank you!

