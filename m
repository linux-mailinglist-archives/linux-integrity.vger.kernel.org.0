Return-Path: <linux-integrity+bounces-6172-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC8AB1447
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A11189F026
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C652900B7;
	Fri,  9 May 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ARiMQVWK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848A1DA5F
	for <linux-integrity@vger.kernel.org>; Fri,  9 May 2025 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795812; cv=none; b=jVYhu2mE+kfBSwVJ5apXyCZOA80iLAtQloLOz4t6UZiT0hu9FnpyECWgJWaZ93XnT3x/Dzt8w3Pdy2ymvs3V08mKw01VsVnWOdMhajitOlH24z+rUYm5P/yW3SVOGuNXQznn6LW+4JMz1MVhr+m7uHod7CsIC5NqgUFHx1eDlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795812; c=relaxed/simple;
	bh=rOOF2/EvLuB6e/9CrQ6MmkFU9mriNEJg3U7g20kd+Kc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mNupIsKHsrIdDJf2IT7qwHokE/+4yJxih6itEYf6IA33LmN7yozbDd/0IEI+f3lhXawAYzHmGURvFLibcPALOSlkOX4XS1lKerug1zSv1uOCBJRgr2qkndb0nC1Z/4gwVW3UkaMN7E/a9Yd48nw6KKHh8okrVvXXPdlFmf7bCl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ARiMQVWK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494Bvr9012144;
	Fri, 9 May 2025 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TWNbZr
	UbHCS9Y686CldtYJ8a4simUKgK5DdocZuPW30=; b=ARiMQVWKEi52cXCADk1wcP
	Dz9SX+uGitWZpv4MNZDCiD2Exv9St4G5VPT5HJJDQkNZ3h+nKtVZUNSRE2g8jjfs
	YoJ1+41BSCg5trxsFwlZYcGdyqFNdQJ9hBh8HDuAKUlswuFFhkWHIIDhogh3aDZ0
	UGqL3O/H7XC1NEoE/KP9vLx7eGR02diHvYwhjHTkId3FLVXGK/CMSO2UM2YPH6K+
	c0abHaA5xDXR83F2apufL9SzeODFsTJ3Xxz8ZyFjsFPFFsmStLQo4Wxq/WeOKBvr
	h7vgY/483fIOioyMQ+4Mu2/DTW095bGLyi1PNHq8s+CT1qIaT0LVsJ7WItVD4kow
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4q8uttb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 13:03:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549CLTZu001316;
	Fri, 9 May 2025 13:03:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftujn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 13:03:13 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549D3CVA25559750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 13:03:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF36558054;
	Fri,  9 May 2025 13:03:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0F6D58050;
	Fri,  9 May 2025 13:03:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.107.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 13:03:11 +0000 (GMT)
Message-ID: <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: Baoquan He <bhe@redhat.com>, chenste@linux.microsoft.com,
        RuiRui Yang
 <ruyang@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Date: Fri, 09 May 2025 09:03:11 -0400
In-Reply-To: <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
References: 
	<h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
	 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
	 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
	 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
	 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
	 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
	 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
	 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
	 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
	 <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
	 <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N6spF39B c=1 sm=1 tr=0 ts=681dfd12 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=6vfXUpHqKcurmbtArcAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EtE5lB3ErEeO0xSFU0lX5h0GB4Msjc8A
X-Proofpoint-ORIG-GUID: EtE5lB3ErEeO0xSFU0lX5h0GB4Msjc8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEyMyBTYWx0ZWRfX5kvDaOU6oY0W gTh9rmohZ3DGQcj31kovEeaQMkL+cMSXz9O8dqkUyjiP6k4H1NkaQlcR/4iX/TAdNdmGJJREgIO x1KeO0ddsf5RBK/wGUxodIlfnxhPMmqL+bmFyBKWeKFNUjdjCBR2mJLZ7cV12eZUnPd8XfYuc0y
 jJg7QrpZaHw10o3kE4TXDY1P2ArJT9Rt33yywvCLBr2Py9OrI83/8mvJH7Q+/l4gIZEBxyh4Ahu ++34NI4uYsKbJbU3SMzJ1dT/D4WjZ1vNXeMLAMabqGgYgh1HLPTRbYqzJxOGNhuBgHYG6A2PwzZ 0QsMRPnwvWNTXTuCL2L30jYlu/XXzHayOCJTMw0BnpHpU8h3CEdfQELOAVQDnFWi8M/1IQAC9io
 6v03LPfkCwvX0VcPTEzkCfhqrJXCHbp08KEiGL5Gclg9+AQsLgBQz496oeTh0V1Tu1lxHXua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_05,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090123

[Cc'ing Roberto]

On Fri, 2025-05-09 at 13:59 +0800, Coiby Xu wrote:
> On Tue, Apr 29, 2025 at 07:39:17AM -0400, Mimi Zohar wrote:
> > On Mon, 2025-04-28 at 11:48 +0800, Coiby Xu wrote:
> > > On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
> > > > On 04/09/25 at 11:40am, Mimi Zohar wrote:
> > > > > On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
> > > > ......snip..
> > > > > > Thanks for confirming. I will consider how to fix it accordingl=
y. Maybe
> > > > > > after Steven's patches are merged. That would be great if the b=
uffer
> > > > > > allocating and storing can be skiped for kdump in Steven's patc=
h. While
> > > > > > I am worried that could disrupt the progress of Steven's patche=
s.
> > > > >=20
> > > > > Agreed, let's get Steven's patch set upstreamed and then make the=
 kdump
> > > > > exceptions.
> > > > >=20
> > > > > - "ima: kexec: move IMA log copy from kexec load to execute" look=
s like it
> > > > > isn't
> > > > > copying the IMA measurement list records (kexec_post_load), but t=
he memory
> > > > > for
> > > > > the IMA measurement list is being allocated (ima_alloc_kexec_file=
_buf).
> > > > >=20
> > > > > - Do you really want to totally disable IMA for kdump or would di=
sabling
> > > > > IMA-
> > > > > measurement be sufficient?=C2=A0 Remember there's already an opti=
on to disable
> > > > > IMA-
> > > > > appraisal.=C2=A0 Disabling just IMA-measurement would allow IMA-a=
ppraisal to
> > > > > continue
> > > > > to work.=C2=A0 Meaning based on policy the integrity of files - e=
xecutables,
> > > > > kernel
> > > > > image, etc - could still be verified.
> > > > >=20
> > > > > Without IMA-measurement:
> > > > > - No adding records to the IMA measurement list
> > > > > - No IMA measurement list pseudo securityfs files
> > > > > - No extending the TPM
> > > > >=20
> > > > > With IMA-appraisal:
> > > > > - Integrity verification of files based on keys, keyrings
> > > > > - Loading keys
> > >=20
> > > Thanks for listing the impacts of disabling IMA measurement or
> > > appraisal!
> > >=20
> > > kdump builds and loads its own initramfs as a cpio archive. After a
> > > kernel crashes, the loaded initramfs will save the crashed kernel's
> > > memory (vmcore) to specified location and then it will reboot the sys=
tem
> > > immediately. Since kdump merely copy files from existing fs into its
> > > initramfs, I think at least majority of users don't need IMA for kdum=
p.
> >=20
> > That's fine.
> >=20
> > > In fact, currently IMA-appraisal doesn't work for kdump because cpio
> > > doesn't support xattr.
> >=20
> > Although CPIO doesn't support xattrs, tmpfs supports xattrs.
>=20
> Thanks for pointing it out! I thought tmpfs doesn't support xattrs
> because ima_policy=3Dtcb excludes TMPFS_MAGIC. There are still many
> interesting questions for me to explore. For example, I don't understand
> how 1st kernel's initramfs is shown as ramfs (which doesn't support
> xattrs) but kdump intiramfs without the squashfs module is shown as
> tmpfs.

Try adding "rootfstype=3Dtmpfs" to the boot command line.  For a detailed e=
xplanation,
take a look at commit 21528c69a0d8 ("rootfs: Fix support for rootfstype=3D =
when root=3D
is given").

>=20
> > I'm aware that some
> > store the security xattr information in a file and write it out as xatt=
rs.
>=20
> If the built initramfs as a CPIO file doesn't carry xattrs, the loaded
> initramfs still doesn't have xattrs. I just found the initramfs could
> opt to use squashfs or erofs which supports xattrs but currently it's
> hardcoded to disable xattrs. For example, recently the dracut erorfs
> module also follows squashfs to disable xattrs [1]. So in the near
> future, I don't expect xattrs to be supported in kdump.
>=20
> [1] https://github.com/dracut-ng/dracut-ng/pull

Right, so the issue isn't the initramfs root filesystem, but CPIO.  Either =
CPIO
would need to be extended, which multiple people have attempted to do, or t=
he xattrs
could be stored in a file and written out to the initramfs root filesystem.=
  In fact
Roberto's last attempts at adding CPIO xattr support did something like tha=
t.

https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sass=
u@huawei.com/

Mimi


