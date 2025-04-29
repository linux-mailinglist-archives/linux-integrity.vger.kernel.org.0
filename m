Return-Path: <linux-integrity+bounces-6042-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A817AA0A3B
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 13:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C7C7B062B
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C722C17A7;
	Tue, 29 Apr 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LadRgvew"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B827604B
	for <linux-integrity@vger.kernel.org>; Tue, 29 Apr 2025 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926771; cv=none; b=X6bKyKje915T0Nl4te6d6sSs9KaEvrr+ibQzpzDNOAtssrdEMzwaImN7JH46KP/EPtxyntHVAAe8MnYjFGTqTPi5i5DTn5EnFBihaGocJ8phYA5Vy1LayobUCemUwB0ukwDgXDU7RkkD8EHhHlQiXn4JyHyFDRTgj2ELqZjz1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926771; c=relaxed/simple;
	bh=5biDcbNueknq/WHh9y44pcD1QWzApZEkBa38sdSQEx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B00XIuAN0j3Z7R1fLzz1J3zYq+l9AmdFUsnAZL4VFnhoiO4s4lcS6XNeDLojvC6Co4/GrsM+15W5LpCcMAPOHYM13eqVtekxe+WPD3LeKuIF3ZOOjAO8GBZDMsH8VMsFNyFCL2PkizJ3jSjDdqnPDQ/+KLGWWPYAnTkMHt5hxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LadRgvew; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EMol006317;
	Tue, 29 Apr 2025 11:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A374Ia
	2eihIBArGg3av+KovsTBYAujbuPpUovFjTXlk=; b=LadRgvewpxqiXvDxJIhdRm
	t+ewj2K8QW0XQw2p4tY7vLpjfMzQA6fgWRkd83uVPp9XVFO+RvfwvuFEXkTLlIiR
	FlpHkfoh/ORmDXg5XNj4BDMcvPYb24f5AWMpta8+/x17602mdxb44P7NjPFmPzQT
	Hv2vU3Tm0xoNWVYu9AmXKGRqqomcFFQcqTPLBCLjCqcniiYbKK1hpxwGLu5TZ4K2
	HSETToHLc+FQbMN0fwwbLPSHG++OUjerNYV+Hx9X/CUy+gTjswbsp6JjUaTVCi6j
	Ox0vMIui9lvGlAncmWwWlAIeSgwDmP7Mj5X4fZSQz2BIBgh7GXc2OXJfqMbeOURw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9as1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 11:39:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T8pXkn016119;
	Tue, 29 Apr 2025 11:39:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70b3k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 11:39:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TBdIVN66257290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 11:39:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E22F58054;
	Tue, 29 Apr 2025 11:39:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA87D58045;
	Tue, 29 Apr 2025 11:39:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.23.164])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 11:39:17 +0000 (GMT)
Message-ID: <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date: Tue, 29 Apr 2025 07:39:17 -0400
In-Reply-To: <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
References: 
	<CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
	 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
	 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
	 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
	 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
	 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
	 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
	 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
	 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
	 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
	 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
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
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6810ba68 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=IEkr5_qL8TULfPe6LFIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l8EajplDRmdXjHixE9JkogN50rW0u7rP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4NiBTYWx0ZWRfX3Fj/ea1s26a5 I78qyPkSEDoGEkGs0f6f68WWhuq1zy/OY48w5mh3Z0MKR2cSAlUVo8M88oD3o5vn1jOn4wI2KTZ h8HsvSj2mi+/W56ofs8jEAXIUfbDonBeELGtp7+NzFXUPO/Bj5+hpj/3Yxd5TJknghkDPLmmjjT
 53Z1lOu6wQvFY5wxI066qW5p/+GwwIatN9Gp5FGpNgHF3KNUTzgLoZvvDITqrS1EFuZ3P8jnTvn jzdUgJotBzhWQNI06VtpVqa2Xsmv/KnlTuo1/NW6Lqv9RPz/5EGi9SuFboRWZ7bTwxBU3n69xti T3iAA2oLjJXtnmMQo1qNjEwsd8QMSS2BQeEq8AKzI5UpzD96weR8l6Qk+JsbRGo6f4GQBrhPsyr
 FiWfFWuFLb424f0QifMYsTD60oXrkikWiLZrDtwenwzUYAQ62yuiV/4w1hTPHXm/nbHOwNqV
X-Proofpoint-GUID: l8EajplDRmdXjHixE9JkogN50rW0u7rP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290086

On Mon, 2025-04-28 at 11:48 +0800, Coiby Xu wrote:
> On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
> > On 04/09/25 at 11:40am, Mimi Zohar wrote:
> > > On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
> > ......snip..
> > > > Thanks for confirming. I will consider how to fix it accordingly. M=
aybe
> > > > after Steven's patches are merged. That would be great if the buffe=
r
> > > > allocating and storing can be skiped for kdump in Steven's patch. W=
hile
> > > > I am worried that could disrupt the progress of Steven's patches.
> > >=20
> > > Agreed, let's get Steven's patch set upstreamed and then make the kdu=
mp
> > > exceptions.
> > >=20
> > > - "ima: kexec: move IMA log copy from kexec load to execute" looks li=
ke it
> > > isn't
> > > copying the IMA measurement list records (kexec_post_load), but the m=
emory for
> > > the IMA measurement list is being allocated (ima_alloc_kexec_file_buf=
).
> > >=20
> > > - Do you really want to totally disable IMA for kdump or would disabl=
ing IMA-
> > > measurement be sufficient?=C2=A0 Remember there's already an option t=
o disable IMA-
> > > appraisal.=C2=A0 Disabling just IMA-measurement would allow IMA-appra=
isal to
> > > continue
> > > to work.=C2=A0 Meaning based on policy the integrity of files - execu=
tables, kernel
> > > image, etc - could still be verified.
> > >=20
> > > Without IMA-measurement:
> > > - No adding records to the IMA measurement list
> > > - No IMA measurement list pseudo securityfs files
> > > - No extending the TPM
> > >=20
> > > With IMA-appraisal:
> > > - Integrity verification of files based on keys, keyrings
> > > - Loading keys
>=20
> Thanks for listing the impacts of disabling IMA measurement or
> appraisal!=20
>=20
> kdump builds and loads its own initramfs as a cpio archive. After a
> kernel crashes, the loaded initramfs will save the crashed kernel's
> memory (vmcore) to specified location and then it will reboot the system
> immediately. Since kdump merely copy files from existing fs into its
> initramfs, I think at least majority of users don't need IMA for kdump.

That's fine.

> In fact, currently IMA-appraisal doesn't work for kdump because cpio
> doesn't support xattr.

Although CPIO doesn't support xattrs, tmpfs supports xattrs.  I'm aware tha=
t some
store the security xattr information in a file and write it out as xattrs.

> As for the issue of not properly updating the
> security xattrs, I think in most of cases disabling IMA-appraisal in
> kdump won't cause the trouble. If the vmcore is saved to a remote fs, the
> local fs won't even be touched. If the vmcore is saved to local fs and
> the appraisal rules cover the saved vmcore and the created logs files,
> we only need to update the xattr file of three files. So from the
> perspective of kdump, it's good to disable IMA for kdump to save memory.

Remember my original concerns weren't about disabling IMA for kdump, but ab=
out not
limiting disabling IMA to just kdump.

> Of course we can't rule out the possibility some users may want to need
> IMA in kdump. So a flexible solution like providing a knob to allow
> users to enable IMA in kdump will be the ideal solution.

Agreed

>=20
> Btw, recently, a colleague reminds me of an issue that the system hangs
> because systemd fails to load incorrect /etc/ima/ima-policy. Of course,
> we should ask users to verify the policy beforehand. But it's still
> possible the booting process may be stopped by a strict, albeit
> syntax-correct policy and users can't log into the system to fix the
> policy. Do you think a knob to disable IMA is needed to address these
> cases or is there a better solution?

Agreed a new policy should always be tested, before attempting to load it o=
n boot.=20
However there are situations when even a tested policy fails.  Commonly thi=
s occurs
when attempting to load an IMA policy based on IMA features that don't exis=
t in an
older kernel.  This can normally be resolved by booting into the newer kern=
el and
"fixing" the policy.  Instead of disabling IMA, I would allow specifying on=
 the boot
command line an alternate IMA policy (e.g. ima-policy.backup-version) to be=
 loaded
as fallback.

>=20
> >=20
> > Currently, Kdump has no demand to do integrity verification based on
> > keys, keyrings, except of Coiby's LUKS support in kdump:
> >=20
> > [PATCH v8 0/7] Support kdump with LUKS encryption by reusing LUKS volum=
e keys
> > https://lore.kernel.org/all/20250207080818.129165-1-coxu@redhat.com/T/#=
u
> >=20
> > I have talked to Coiby, he will do some investigations to see if loadin=
g
> > keys related to IMA or IMA-appraisal functionality is related to LUKS
> > support in kdump because the LUKS support in kdump also needs
> > store/restore keys/keyrings between normal kernel and kdump kernel.
>=20
> Thanks for reminding me about kdump LUKS support. IMA will create
> keyring like .ima for loading keys and other components can still create
> their own keyrings or use existing keyrings. And I can confirm kdump
> LUKS support won't be affected.=20

thanks,

Mimi


