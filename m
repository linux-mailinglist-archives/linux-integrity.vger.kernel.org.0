Return-Path: <linux-integrity+bounces-7329-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAABAE88F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05903C4FD1
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F93B241663;
	Tue, 30 Sep 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hI90/ig1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71344C81;
	Tue, 30 Sep 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264114; cv=none; b=Gxt5JFcA6iVtQ8+2qSfzkoPHZEX3ugCruOM2SHuC08KhLV5aJvGr7SMRB2CrZDZ2Xqftz1U9WZbJpg8zACOMWCQcqo+nYIeP0QQBHieiKGTnjxP5aVaddq8V87FQSWYUPiC9Nzn71ZoaLA84fmFYkt73FcMYUEVuDzxiCkdHxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264114; c=relaxed/simple;
	bh=rVT8LLqQ2BIIqhRUGOt1DEgpSaOhe56wD2gSY9BrNjg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XIYoCIU7PQMqQY2OLqsCVM4hvx5ZlU7vcj5wsI3iK+VREnK9ovkahCt+50pnK3T+RQzzxYhltAkA7hxukgK9lYd7ZboF42y3DuyMIbvIZM3hkdXHG7nCcymU3rPh7yazqaM78c7ZYK3mizZjuuabRdUDB5Y7kNd1dp2njabz/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hI90/ig1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJt0oc002106;
	Tue, 30 Sep 2025 20:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZgxRUx
	J+4q2dn8A5VIJXA3qVsUiULbZMIbn7ozado9A=; b=hI90/ig1hSxFSWKDr9PcA9
	CMHVS5XkEkF6oAnQwAo9HFIEQAJkX+R8Ey/t5ERu5eH8DzPIizOfDIRZ/KRL+1FD
	CMn4qg8v3VzSbM2DH+ludkqA1RhzvwOagPExAbeeX2Ib8M8c02ESodapHmkc2Vo+
	KuVS0gWRQNwpbFYsY9ydISZpe5NcelwW0W5azO1S5yP5zYe9wIqdP0UWRkeADFoB
	VYHfzpnXMr2usiKPjoopBYu/ZC2ft1V4CcEDK5iNgnqnlRwzDlHmTu8ZHT1QWBNQ
	vYLUzHKjnSaAbn3WwnZwFG7XjmHQm08u+O+wn70uPmME15TM9LRZwQH7anD02MhA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwjshh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 20:28:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58UKOYFg001786;
	Tue, 30 Sep 2025 20:28:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwjshd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 20:28:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJ1nGh020098;
	Tue, 30 Sep 2025 20:28:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8s5kus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 20:28:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UKSF9n18154016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 20:28:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85AC958054;
	Tue, 30 Sep 2025 20:28:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB055805A;
	Tue, 30 Sep 2025 20:28:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 20:28:14 +0000 (GMT)
Message-ID: <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Karel Srot
 <ksrot@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg	
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris	
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        open list
 <linux-kernel@vger.kernel.org>
In-Reply-To: <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Sep 2025 16:28:14 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX9wXa+qUPKdkw
 h7ohSrateouz8s8IRgIyn/th/P2PeNjoImjN5h4izFYvcTrNZJE17/6mBW+Tj6FvpifeFoRdvUH
 +aadSST/9YnPeOIbqXPYF8nVu2aFf1b59YOYpRep2PCb9fAdLKs8elgk0MUc382kebDggeHeUyX
 kpDjV4b+AUIt743Uvqui6ItBDgLxqNmmqgi+JNg2db5zV4eGcD6GFArSV5J1i2WJr/NW/x8w/w/
 gfb+7q8VA6KVXkg3MUUjQHtHA8kGR/UXq0U5FBFCPyncVDq7DwKBCvjzLwFL0oIGWlEfxjQSedS
 Hdz++IW581EZqHlU3955zHKoOKC4zD+VNGAb7EccGN3D8nRUXub2LraZBoUoCBNtbYdEEN70u9H
 XCZRRc/MR2fZY/PvbIu8i4BaI1wfQA==
X-Proofpoint-ORIG-GUID: NHCRxGbQrnjHikw_TyU3VMHH7EuT4LRr
X-Proofpoint-GUID: nOqafXKuj9pQmT9ZXLXn0MNV4CTV1aCQ
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dc3d61 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=20KFwNOVAAAA:8 a=16uMmaMVKecfaAtURF4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Tue, 2025-09-30 at 09:57 -0400, Mimi Zohar wrote:
> On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
> > Currently, for any IMA policy that requires appraisal for kernel module=
s
> > e.g. ima_policy=3Dsecure_boot, PowerPC architecture specific policy,
> > booting will fail because IMA will reject a kernel module which will
> > be decompressed in the kernel space and then have its signature
> > verified.
> >=20
> > This happens because when in-kernel module decompression
> > (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
> > syscall instead of init_module to load a module. And IMA mandates IMA
> > xattr verification for finit_module unless appraise_type=3Dimasig|modsi=
g
> > is specified in the rule.  However currently initramfs doesn't support
> > xattr. And IMA rule "func=3DMODULE_CHECK appraise_type=3Dimasig|modsig"
> > doesn't work either because IMA will treat to-be-decompressed kernel
> > module as not having module signature as it can't decompress kernel
> > module to check if signature exists.
> >=20
> > So fall back to default kernel module signature verification when we ha=
ve
> > no way to verify IMA xattr.
> >=20
> > Reported-by: Karel Srot <ksrot@redhat.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> > Another approach will be to make IMA decompress the kernel module to
> > check the signature. This requires refactoring kernel module code to
> > make the in-kernel module decompressing feature modular and seemingly
> > more efforts are needed. A second disadvantage is it feels
> > counter-intuitive to verify the same kernel module signature twice. And
> > we still need to make ima_policy=3Dsecure_boot allow verifying appended
> > module signature.
> >=20
> > Anyways, I'm open to suggestions and can try the latter approach if
> > there are some benefits I'm not aware of or a better approach.
>=20
> Coiby, there are multiple issues being discussed here.  Before deciding o=
n an
> appropriate solution, let's frame the issues(s) properly.
>=20
> 1. The finit_module syscall eventually calls init_module_from_file() to r=
ead the
> module into memory and then decompress it.  The problem is that the kerne=
l
> module signature verification occurs during the kernel_read_file(), befor=
e the
> kernel module is decompressed.  Thus, the appended kernel module signatur=
e
> cannot be verified.
>=20
> 2. CPIO doesn't have xattr support. There were multiple attempts at inclu=
ding
> xattrs in CPIO, but none were upstreamed [1].  If file signatures stored =
in
> security.ima were available in the initramfs, then finit_module() could v=
erify
> them, as opposed to the appended kernel module signature.
>=20
> 3. The issues described above are generic, not limited to Power.  When
> CONFIG_MODULE_SIG is configured, the arch specific IMA policy rules do no=
t
> include an "appraise func=3DMODULE_CHECK".
>=20
> 4. Unlike the arch specific IMA policy rules, the built-in secure boot IM=
A
> policy, specified on the boot command line as "ima_policy=3Dsecure_boot",=
 always
> enforces the IMA signature stored in security.ima.
>=20
> Partial solutions without kernel changes:
> - Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
> - Disable kernel module compression.
>=20
> Complete solution:
> - Pick up and upstream Roberto Sassu's last version of initramfs support =
[1].
> - Somehow prevent kernel_read_file() from failing when the kernel_read_fi=
le_id
> enumeration is READING_MODULE and the kernel module is compressed.  The c=
hange
> might be limited to ima_post_read_file().

or perhaps not totally.

init_module_from_file() doesn't pass the flags variable to kernel_read_file=
().=20
You might want to consider defining a new kernel_read_file_id enumeration n=
amed
READING_COMPRESSED_MODULE.

Mimi

>=20
> [1] [PATCH v4 0/3] initramfs: add support for xattrs in the initial ram d=
isk
> https://lore.kernel.org/linux-fsdevel/20190523121803.21638-1-roberto.sass=
u@huawei.com/
>=20
>=20


