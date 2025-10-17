Return-Path: <linux-integrity+bounces-7441-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4102FBE62D1
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 05:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE36D4E6002
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 03:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439823EAA3;
	Fri, 17 Oct 2025 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rCqwFc37"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDB3BB5A;
	Fri, 17 Oct 2025 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670126; cv=none; b=dWIEZt9zVGy7TlDWQ7iOgpg4Hhg0vVm1Wj47THOIeRSXWbczVXn6GMV6Vx3vwXhWKXRJ4T2cbREy9A4E+QVUtDGyQOCSA6BWYkm4gpWtENTZSUq2l7BdtWtloy/1n0gBvG7dgPOPM0HdjxkPh3dn7ZMoh4weuE5C+IaAJGqymsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670126; c=relaxed/simple;
	bh=Ldzsr8zUl/IeWKGzcXyTt7lNBVRbP7W3AK3ob6IJETA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=re2CpNyXCQpryLt/irVe80OTpNidr3jcxkHb5W+by9yW+CrN2/ac5BtxeF6hyT+yfQocaStLflCRfRruvMSqCugn2Z25wSGYFjMkBo3s9A2zfRhDl4P2GCwm8FsJ55rEncC6yz44eURatuLjk17WW/UPONHFLagWte3ovXA6we0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rCqwFc37; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GI5GGB021809;
	Fri, 17 Oct 2025 03:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4cQBdU
	sq/Z4fGuep25p4+a1J5XRk538LCKUr+XGZS3c=; b=rCqwFc37XVYQ3XtU/YxB5H
	CjQQEOy3gmsa2BmklnWKX/BIZ9SLeOFrpURC7jKeY5YFhqec6OZQMMpoxv9R+36H
	hUb7FSgzDqmG+UkdLBys0hCc7wuQ8ZJLg+Ze5o97sD0GQlkJY5IY3UxU7t1GJWP9
	GOnpPujf/Qf0z4l6cr4an/qcV9L5benQp21NSkofZ8p0K3aROLm941yercb+OWGt
	EyE8pGilNS5UP6PC+fFMRTtMa4ZoRPKrX9UZR5khJz4bfpVSe0pqrSj6b12Ib614
	u3CzeqX612sboewOQr/JFnbnCcDcTCptrlwcb64M8g398tibnHTT4y8N7cPH3eCQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey96fg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 03:01:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H31fqh006218;
	Fri, 17 Oct 2025 03:01:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey96ffs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 03:01:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H1cIfn016759;
	Fri, 17 Oct 2025 03:01:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k90ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 03:01:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H31egx38863326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 03:01:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C481580AF;
	Fri, 17 Oct 2025 02:31:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9759E585BE;
	Fri, 17 Oct 2025 02:31:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.36.221])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 02:31:35 +0000 (GMT)
Message-ID: <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
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
In-Reply-To: <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
	 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
	 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Oct 2025 22:31:35 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G0Q_apFzjPX5btUBV-__UEYFVbRczi_E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXzN5g6eD/U5Bn
 9maDPF1FKDuL9E2iina185p3+HMRdkHdUR53xekYIQd+bNMNm7RPHn7wedCeUMrqAb0rbUxMU1r
 Rl7UgLuZptVendBogiv5UYrCG4WyKYwrd5KsXeOUoAO6k0QZtPQqbGNR9agi0U86lvluLHCMJOU
 dJJ5RG8vYYBWQ+ZCcu8ycB5QjTRxMG62T7sDh82eRYeiConzF5i4m9Sc0CDM06DG+LDutERgPch
 AWlA2GVXi1/bhFnKOKv2eXFXG1UoeTij4IFhUHsmVHvGvZcmfd8+jWW8Tb0JoopLF2qtFcEUEjf
 Nssh2rt6FS8eSnqMBkmw5PcoCj5ezOycv35TftWuNsZ+x84PZ5osMk8ts+FQEQufDa2EYL2gi0v
 jv3dPKVprhCx853uTy067kS0IK3nmw==
X-Proofpoint-GUID: 2fS2YbptSe-aloPSYFxxdQ8DwG5OPJmm
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f1b196 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=fgkEvsZqHlba2UCyol4A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

On Thu, 2025-10-16 at 11:46 +0800, Coiby Xu wrote:
> On Tue, Sep 30, 2025 at 04:28:14PM -0400, Mimi Zohar wrote:
> > On Tue, 2025-09-30 at 09:57 -0400, Mimi Zohar wrote:
> > > On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
> > > > Currently, for any IMA policy that requires appraisal for kernel mo=
dules
> > > > e.g. ima_policy=3Dsecure_boot, PowerPC architecture specific policy=
,
> > > > booting will fail because IMA will reject a kernel module which wil=
l
> > > > be decompressed in the kernel space and then have its signature
> > > > verified.
> > > >=20
> > > > This happens because when in-kernel module decompression
> > > > (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
> > > > syscall instead of init_module to load a module. And IMA mandates I=
MA
> > > > xattr verification for finit_module unless appraise_type=3Dimasig|m=
odsig
> > > > is specified in the rule.  However currently initramfs doesn't supp=
ort
> > > > xattr. And IMA rule "func=3DMODULE_CHECK appraise_type=3Dimasig|mod=
sig"
> > > > doesn't work either because IMA will treat to-be-decompressed kerne=
l
> > > > module as not having module signature as it can't decompress kernel
> > > > module to check if signature exists.
> > > >=20
> > > > So fall back to default kernel module signature verification when w=
e have
> > > > no way to verify IMA xattr.
> > > >=20
> > > > Reported-by: Karel Srot <ksrot@redhat.com>
> > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > > ---
> > > > Another approach will be to make IMA decompress the kernel module t=
o
> > > > check the signature. This requires refactoring kernel module code t=
o
> > > > make the in-kernel module decompressing feature modular and seeming=
ly
> > > > more efforts are needed. A second disadvantage is it feels
> > > > counter-intuitive to verify the same kernel module signature twice.=
 And
> > > > we still need to make ima_policy=3Dsecure_boot allow verifying appe=
nded
> > > > module signature.
> > > >=20
> > > > Anyways, I'm open to suggestions and can try the latter approach if
> > > > there are some benefits I'm not aware of or a better approach.
> > >=20
> > > Coiby, there are multiple issues being discussed here.  Before decidi=
ng on an
> > > appropriate solution, let's frame the issues(s) properly.
>=20
> Hi Mimi,
>=20
> Thanks for listing and framing the issues! Sorry, it took me a while to
> go through your feedback as I also had a 8-day holiday.
>=20
> > >=20
> > > 1. The finit_module syscall eventually calls init_module_from_file() =
to read the
> > > module into memory and then decompress it.  The problem is that the k=
ernel
> > > module signature verification occurs during the kernel_read_file(), b=
efore the
> > > kernel module is decompressed.  Thus, the appended kernel module sign=
ature
> > > cannot be verified.
>=20
> Since IMA only accesses a kernel module as a fd or struct file*, even if
> IMA hook is triggerd after kernel module is decompressed, IMA still
> doesn't know the default verification has passed or can't access the
> decompressed kernel buffer [2] to do the verification by itself.
>=20
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/kernel/module/main.c?h=3Dv6.17#n3689
>=20
> > >=20
> > > 2. CPIO doesn't have xattr support. There were multiple attempts at i=
ncluding
> > > xattrs in CPIO, but none were upstreamed [1].  If file signatures sto=
red in
> > > security.ima were available in the initramfs, then finit_module() cou=
ld verify
> > > them, as opposed to the appended kernel module signature.
>=20
> Thanks you for pointing me to the work [1]. I'll take a more careful
> look at [1]. I think CPIO supporting xattr can be a long-term solution
> and also close a important security gap.
>=20
> > >=20
> > > 3. The issues described above are generic, not limited to Power.  Whe=
n
> > > CONFIG_MODULE_SIG is configured, the arch specific IMA policy rules d=
o not
> > > include an "appraise func=3DMODULE_CHECK".
>=20
> Yes, the issue is not limited to Power. And thanks for correcting me
> that Power arch specific IMA policy rules don't have this problem! Sorry
> I misread the code.
>=20
> > >=20
> > > 4. Unlike the arch specific IMA policy rules, the built-in secure boo=
t IMA
> > > policy, specified on the boot command line as "ima_policy=3Dsecure_bo=
ot", always
> > > enforces the IMA signature stored in security.ima.
> > >=20
> > > Partial solutions without kernel changes:
> > > - Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
> > > - Disable kernel module compression.
> > >=20
> > > Complete solution:
> > > - Pick up and upstream Roberto Sassu's last version of initramfs supp=
ort [1].
> > > - Somehow prevent kernel_read_file() from failing when the kernel_rea=
d_file_id
> > > enumeration is READING_MODULE and the kernel module is compressed.  T=
he change
> > > might be limited to ima_post_read_file().
> >=20
> > or perhaps not totally.
> >=20
> > init_module_from_file() doesn't pass the flags variable to kernel_read_=
file().
> > You might want to consider defining a new kernel_read_file_id enumerati=
on named
> > READING_COMPRESSED_MODULE.
>=20
> Thanks for suggesting the solutions! I like the solution of CPIO
> supporting xattr but it seems it won't land in upstream soon. So I
> prefer the last approach. I've implemented one [3] by defining a new
> kernel_read_file_id enumeration, would you like me to post the patches
> to the mailing list directly?
>=20
> [3] https://github.com/coiby/linux/tree/in_kernel_decompression_ima

A few thoughts, before you post the patch.

1. In the general case, the kernel module could be compressed, but without =
an
appended signature.  The new code should only defer appended signature
verification, if there isn't an xattr or appended signature.

2. Instead of defining an additional process_measurement() argument to iden=
tify
compressed kernel modules, to simplify the code it might be possible to def=
ine a
new "func" named COMPRESSED_MODULE_CHECK.

 +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COMPRESSED_MODUL=
E_CHECK

3. =C2=A0The patch title "ima: Use default kernel module signature verifica=
tion for
compressed ones" is a bit off.  It should be something along the lines of "=
ima:
defer compressed kernel module appended signature verification".

4. Simplify the patch description.

> >=20
Mimi

