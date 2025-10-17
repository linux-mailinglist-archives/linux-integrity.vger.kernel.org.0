Return-Path: <linux-integrity+bounces-7444-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83999BEB1E1
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C1524E2794
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5432F8BF8;
	Fri, 17 Oct 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m3EWAfgn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5C2FFF89;
	Fri, 17 Oct 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723442; cv=none; b=W7GLe554XV53GSTyEHDAraLqBlimPMnzPpS/Vgy5L37ypjyLbWazcpby5hFGR8QZm0z3GtuWMFXApSKFqRzRNAbCygXVb7NHtLvkxusF8dimNdmG4AUP0rF9DCv/aW96PRZaHLOlirgA6iLmXLGLMUb0kLheOyxngPSTxJUMJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723442; c=relaxed/simple;
	bh=H4v+J2vr1k8P5MVZuxRLmPaHX76Kp9nogLrI0kRIThw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=m0eXGoKn7Vm/SXs3phl3qOWYMzsK16cuBqof9BXsXB/4dDe8ycRb3SLxK8i4hN6urPk6bgOTXGN2P1FVbfJmAm4f+WM3x3MOCciBXZecEOXFNKJg/MiuNyBypbhf3b64Of1ZcCXtGkoWDqg2WsxlHwrzroPhXCUUcGv4ASnI02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m3EWAfgn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HAMW2c021074;
	Fri, 17 Oct 2025 17:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZUYslV
	E9NtS8Zj7gTmakZPJadn5EsDRyOgc6VGfTm+0=; b=m3EWAfgnzMZd9yStrkUIjH
	nPwhon1qzYFzQjIMTNHoodtDg1nRM1pg0kDvlClDCH8+cCBO7FtEU/Nzt4qEuXaD
	mkwAxfHQ+SPqdecbSOccdWPBubkpHho07pBAk/p/E5I0ENPY4rvE4cOaJeL0aFoW
	HLpVZZh22KkiselH2H6dwNSBtMrllXlL6+BP6MI+PFViTK1l4euD86Bssj/5YBy2
	oURtoX4J+UbPTHOK2dco3SkkXE9DEGhzwFgBUG9eQp5pLSrvmhTio+dtiAHvxLjf
	Edr/AUzYCq8yY12VV+D/I1iZtRze/WITZSRyP/Qzv56NRSu8F28xJCF/JbrE0g9A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0jrgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 17:50:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HHe3KL023113;
	Fri, 17 Oct 2025 17:50:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0jrgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 17:50:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HFCeCi016996;
	Fri, 17 Oct 2025 17:50:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32kekgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 17:50:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59HHo0Wt51642754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 17:50:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA7758045;
	Fri, 17 Oct 2025 17:49:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D97058052;
	Fri, 17 Oct 2025 17:49:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.50.185])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 17:49:58 +0000 (GMT)
Message-ID: <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
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
In-Reply-To: <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
	 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
	 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
	 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
	 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Oct 2025 13:49:58 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _WU9ULW3VlvgYks0zpzRnOg_u9IYSWqL
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f281c9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=GDQNn2IJJl9ZOXiabFkA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX8IeU7L9A2GDj
 9rDeE+YztgrqFIUa5TpXEm6EmneDUQrP/V1/BHU5wo86o8aDgTnsE/HloCLPGr24/bepyQvBaPH
 1hIkequcpVFk9JSgr/ZKr4A4bHzumLZ20fIXq7K9esrRJsBkNMaxdD1WunJCoQ9ENqW7gqbMD//
 JYXw9qdfbBOpOo+AeT0GbjeMX3lX36TC1/8C8bp2L6oWrOodM5TgQyeLrGxWRLiRPDBxOozA2s/
 x6jH34A2+99n+uDDVElAj66oTAu3LR35UsDkM1I7tzDCd4C5uJ0Tcz9mMDCvkJPPGBjJs10H/Fc
 c6fsGFGLkM924tbNlTtl9S2K2c6vGTjFkKbsdO/Fdlpzs20FMZ++kqXZBpVF/2Tdsp+F6KlN/dO
 bW8iYn+vS1lFUTQ6/FUHVHHgma0d2Q==
X-Proofpoint-GUID: IjT5eJvhpczlThhxKduqWhQjNBOOX5oH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

On Fri, 2025-10-17 at 11:19 +0800, Coiby Xu wrote:
> On Thu, Oct 16, 2025 at 10:31:35PM -0400, Mimi Zohar wrote:
> > On Thu, 2025-10-16 at 11:46 +0800, Coiby Xu wrote:
> > > On Tue, Sep 30, 2025 at 04:28:14PM -0400, Mimi Zohar wrote:
> > > > On Tue, 2025-09-30 at 09:57 -0400, Mimi Zohar wrote:
> > > > > On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
> > > > > > Currently, for any IMA policy that requires appraisal for kerne=
l modules
> > > > > > e.g. ima_policy=3Dsecure_boot, PowerPC architecture specific po=
licy,
> > > > > > booting will fail because IMA will reject a kernel module which=
 will
> > > > > > be decompressed in the kernel space and then have its signature
> > > > > > verified.
> > > > > >=20
> > > > > > This happens because when in-kernel module decompression
> > > > > > (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_modu=
le
> > > > > > syscall instead of init_module to load a module. And IMA mandat=
es IMA
> > > > > > xattr verification for finit_module unless appraise_type=3Dimas=
ig|modsig
> > > > > > is specified in the rule.  However currently initramfs doesn't =
support
> > > > > > xattr. And IMA rule "func=3DMODULE_CHECK appraise_type=3Dimasig=
|modsig"
> > > > > > doesn't work either because IMA will treat to-be-decompressed k=
ernel
> > > > > > module as not having module signature as it can't decompress ke=
rnel
> > > > > > module to check if signature exists.
> > > > > >=20
> > > > > > So fall back to default kernel module signature verification wh=
en we have
> > > > > > no way to verify IMA xattr.
> > > > > >=20
> > > > > > Reported-by: Karel Srot <ksrot@redhat.com>
> > > > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > > > > ---
> > > > > > Another approach will be to make IMA decompress the kernel modu=
le to
> > > > > > check the signature. This requires refactoring kernel module co=
de to
> > > > > > make the in-kernel module decompressing feature modular and see=
mingly
> > > > > > more efforts are needed. A second disadvantage is it feels
> > > > > > counter-intuitive to verify the same kernel module signature tw=
ice. And
> > > > > > we still need to make ima_policy=3Dsecure_boot allow verifying =
appended
> > > > > > module signature.
> > > > > >=20
> > > > > > Anyways, I'm open to suggestions and can try the latter approac=
h if
> > > > > > there are some benefits I'm not aware of or a better approach.
> > > > >=20
> > > > > Coiby, there are multiple issues being discussed here.  Before de=
ciding on an
> > > > > appropriate solution, let's frame the issues(s) properly.
> > >=20
> > > Hi Mimi,
> > >=20
> > > Thanks for listing and framing the issues! Sorry, it took me a while =
to
> > > go through your feedback as I also had a 8-day holiday.
> > >=20
> > > > >=20
> > > > > 1. The finit_module syscall eventually calls init_module_from_fil=
e() to read the
> > > > > module into memory and then decompress it.  The problem is that t=
he kernel
> > > > > module signature verification occurs during the kernel_read_file(=
), before the
> > > > > kernel module is decompressed.  Thus, the appended kernel module =
signature
> > > > > cannot be verified.
> > >=20
> > > Since IMA only accesses a kernel module as a fd or struct file*, even=
 if
> > > IMA hook is triggerd after kernel module is decompressed, IMA still
> > > doesn't know the default verification has passed or can't access the
> > > decompressed kernel buffer [2] to do the verification by itself.
> > >=20
> > > [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/kernel/module/main.c?h=3Dv6.17#n3689
> > >=20
> > > > >=20
> > > > > 2. CPIO doesn't have xattr support. There were multiple attempts =
at including
> > > > > xattrs in CPIO, but none were upstreamed [1].  If file signatures=
 stored in
> > > > > security.ima were available in the initramfs, then finit_module()=
 could verify
> > > > > them, as opposed to the appended kernel module signature.
> > >=20
> > > Thanks you for pointing me to the work [1]. I'll take a more careful
> > > look at [1]. I think CPIO supporting xattr can be a long-term solutio=
n
> > > and also close a important security gap.
> > >=20
> > > > >=20
> > > > > 3. The issues described above are generic, not limited to Power. =
 When
> > > > > CONFIG_MODULE_SIG is configured, the arch specific IMA policy rul=
es do not
> > > > > include an "appraise func=3DMODULE_CHECK".
> > >=20
> > > Yes, the issue is not limited to Power. And thanks for correcting me
> > > that Power arch specific IMA policy rules don't have this problem! So=
rry
> > > I misread the code.
> > >=20
> > > > >=20
> > > > > 4. Unlike the arch specific IMA policy rules, the built-in secure=
 boot IMA
> > > > > policy, specified on the boot command line as "ima_policy=3Dsecur=
e_boot", always
> > > > > enforces the IMA signature stored in security.ima.
> > > > >=20
> > > > > Partial solutions without kernel changes:
> > > > > - Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
> > > > > - Disable kernel module compression.
> > > > >=20
> > > > > Complete solution:
> > > > > - Pick up and upstream Roberto Sassu's last version of initramfs =
support [1].
> > > > > - Somehow prevent kernel_read_file() from failing when the kernel=
_read_file_id
> > > > > enumeration is READING_MODULE and the kernel module is compressed=
.  The change
> > > > > might be limited to ima_post_read_file().
> > > >=20
> > > > or perhaps not totally.
> > > >=20
> > > > init_module_from_file() doesn't pass the flags variable to kernel_r=
ead_file().
> > > > You might want to consider defining a new kernel_read_file_id enume=
ration named
> > > > READING_COMPRESSED_MODULE.
> > >=20
> > > Thanks for suggesting the solutions! I like the solution of CPIO
> > > supporting xattr but it seems it won't land in upstream soon. So I
> > > prefer the last approach. I've implemented one [3] by defining a new
> > > kernel_read_file_id enumeration, would you like me to post the patche=
s
> > > to the mailing list directly?
> > >=20
> > > [3] https://github.com/coiby/linux/tree/in_kernel_decompression_ima
> >=20
> > A few thoughts, before you post the patch.
>=20
> Thank you for sharing your thoughts!
>=20
> >=20
> > 1. In the general case, the kernel module could be compressed, but with=
out an
> > appended signature.  The new code should only defer appended signature
> > verification, if there isn't an xattr or appended signature.
>=20
> I'll add these two condition checks, thanks!
>=20
> >=20
> > 2. Instead of defining an additional process_measurement() argument to =
identify
> > compressed kernel modules, to simplify the code it might be possible to=
 define a
> > new "func" named COMPRESSED_MODULE_CHECK.
> >=20
> > +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COMPRESSED_MO=
DULE_CHECK
>=20
> I also thought about this approach. But IMA rule maps kernel module
> loading to MODULE_CHECK. If we define a new rule and ask users to use
> this new rule, ima_policy=3Dsecure_boot still won't work.

I don't have a problem with extending the "secure-boot" policy to support
uncompressed kernel modules appended signatures, based on whether
CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to the exi=
sting
MODULE_CHECK rule.

>=20
> >=20
> > 3. =C2=A0The patch title "ima: Use default kernel module signature veri=
fication for
> > compressed ones" is a bit off.  It should be something along the lines =
of "ima:
> > defer compressed kernel module appended signature verification".
>=20
> >=20
> > 4. Simplify the patch description.
>=20
> I'll rephrase the title and try simplifying it. Thanks!

Thank you.


