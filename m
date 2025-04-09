Return-Path: <linux-integrity+bounces-5690-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C5A82B3E
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557EE9A5919
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA072676DD;
	Wed,  9 Apr 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rO19Fh5u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C3263F4E
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213223; cv=none; b=bDHh5++TRolojd82Nmy0lPcmdtx0021ZpXqh2aZ50mYHDTnLc/lQzBWoY8kF7LP6SvpG0p9xvzPrSqoCGIUMopS5+8SnBzGhIDxBOEjfNJfoWbj2OcvazS4qLpxjjDJOXOgbgAb498bi0yLEgPzW9OII6IMvmp1J4k8y+qxkESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213223; c=relaxed/simple;
	bh=PrcIxWostPRHrAo9gsoiNRD6pd4uCgrCbYeQjhDDTBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJzyCTeyHakiyjlMfIKSarxLkJX3GCDZ7NeolWn7rTLWaikbTVhGvy6mpW+S0lEkQH4IcKm7bVm0xgZKyZ2vNokxCjJKoFS14te5LQXV5A/BlAZnoPHdglqGpiDR4ckYolzhwe7Nm76RdZg9jjp2s95NiEN31CjGlUEfp/OdCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rO19Fh5u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399CgEH009133;
	Wed, 9 Apr 2025 15:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/eEGCH
	Wso6tW+nWSDSY9FoU5Yly9eomYFdp72kkfd9g=; b=rO19Fh5uEmm7XHdosRPlGX
	UAgg0maOy1tN+6rYIVRpsCGX3WlkguGcoe7NHARoIHeYCz//6QiZTNjAUZxamfhm
	NXZG3c06PhObozNRJdoZxWL1N/mtloj40dzMsktXGEvSom4CWjrn7xzVpe+davVH
	ltow7jqS2m4SoB63pzY21+P6lxY7LWPcLJfPm7ZaXSuPYUbjAAqh8XpI3ISCYCvO
	gjQGoU8/P0XpoxWhLW61gRtrN2NnXNL7EutKBA1pUJmLabE+TEN5vLQIxtzHYum5
	GhJpFYz91ra+czl3CEBi2FEk08YgOBUFg15BZUNIhGVhfOehcssDkSiaUO4eufpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wayr4gt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:40:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539EpJkr018451;
	Wed, 9 Apr 2025 15:40:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kr6cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:40:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539FeD1i32244240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 15:40:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E38558061;
	Wed,  9 Apr 2025 15:40:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DBE58060;
	Wed,  9 Apr 2025 15:40:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 15:40:12 +0000 (GMT)
Message-ID: <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, chenste@linux.microsoft.com
Cc: Coiby Xu <coxu@redhat.com>, RuiRui Yang <ruyang@redhat.com>,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date: Wed, 09 Apr 2025 11:40:12 -0400
In-Reply-To: <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
	 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
	 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
	 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
	 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
	 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
	 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
	 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
	 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
	 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
	 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
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
X-Proofpoint-ORIG-GUID: AjQU931g0Kl01vGx1lIIfPdtW8s1fAk3
X-Proofpoint-GUID: AjQU931g0Kl01vGx1lIIfPdtW8s1fAk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=961 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090098

On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
> On 04/07/25 at 07:46am, Mimi Zohar wrote:
> > On Mon, 2025-04-07 at 09:34 +0800, Baoquan He wrote:
> > > On 04/03/25 at 04:03pm, Mimi Zohar wrote:
> > > > On Wed, 2025-04-02 at 19:49 +0800, Baoquan He wrote:
> > > > > On 04/02/25 at 04:43pm, Coiby Xu wrote:
> > > > > > On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > > > > > > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> > > > > > [...]
> > > > > > > > > > that.  Please don't make it generic like this.
> > > > > > > > > >=20
> > > > > > > > > > Please refer to ima_appraise_parse_cmdline().
> > > > > > > > >=20
> > > > > > > > > Hi Mimi,
> > > > > > > > >=20
> > > > > > > > > To save memory for kdump, it seems init_ima has been to b=
e skipped thus
> > > > > > > > > ima=3Doff is necessary (ima_appraise=3Doff won't serve th=
e purpose). Or do
> > > > > > > > > you have any specific concerns in mind?
> > > > > > > >=20
> > > > > > > > I think as Mimi said see below logic enforces the IMA even =
with the
> > > > > > > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > > > > > > if (sb_state) {
> > > > > > > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORC=
E))
> > > > > > > >                         pr_info("Secure boot enabled: ignor=
ing
> > > > > > > > ima_appraise=3D%s option",
> > > > > > > >                                 str);
> > > > > > > >         } else {
> > > > > > > >                 ima_appraise =3D appraisal_state;
> > > > > > > >         }
> > > > > >=20
> > > > > > Thanks for pointing me to the above code! Note with the whole I=
MA
> > > > > > disabled as done by this patch, the above code will not run so =
IMA
> > > > > > (appraisal) won't be enforced.
> > > > > >=20
> > > > > > >=20
> > > > > > > Thanks, RuiRui.
> > > > > > >=20
> > > > > >=20
> > > > > > Mimi, so do I understand it correctly that your want IMA-apprai=
sal to be
> > > > > > always enabled as long as secure boot is enabled even if users =
choose to
> > > > > > disable IMA?=C2=A0
> > > >=20
> > > > Secure boot is not the only reason.  Based on policy IMA-appraisal =
and EVM
> > > > calculate and store file hashes and HMAC's in their respective secu=
rity xattrs.
> > > > Normally the usage of file hashes and HMAC's is limited to mutable =
files.=20
> > > > Disabling IMA-appraisal could result in not properly updating the s=
ecurity
> > > > xattrs, which would result in not being able to verify the file's i=
ntegrity on
> > > > reboot.
> > > >=20
> > > > On systems where the RPM includes file signatures, file signatures =
of immutable
> > > > files can be safely restored.  Although it is possible to walk the =
filesystem(s)
> > > > "fixing" the xattrs of mutable files, it defeats the purpose.  "fix=
" mode should
> > > > only be enabled in a trusted environment.
> > > >=20
> > > > > > I wonder what security issue will it bring if this promise
> > > > > > gets broken considering other LSMs can SELinux can be disabled =
when
> > > > > > secure boot is enabled?
> > > >=20
> > > > The builtin IMA policy rules are not defined in terms of SELinux la=
bels.  If the
> > > > initial IMA custom policy defines rules based on SELinux labels and=
 SELinux is
> > > > not enabled, the policy will fail to be loaded.
> > > >=20
> > > > > > > Coiby, would disabling just IMA-measurement, as opposed to IM=
A-appraisal, save
> > > > > > > sufficient memory for kdump?
> > > > > >=20
> > > > > > For disabling just IMA-measurement, do you mean not enabling an=
y measure
> > > > > > rules?  The more memory reserved for the kdump kernel, the less=
 memory
> > > > > > can be used by the 1st kernel. So from the perfective of kdump,=
 we try
> > > > > > to make the memory footprint as smaller as possible.
> > > >=20
> > > > Got it.
> > > >=20
> > > > > > Baoquan, do you have any statistics about the memory overhead o=
f IMA?
> > > > >=20
> > > > > I am getting a system to check that. I think there are two aspect=
s of
> > > > > IMA functionality we want to disable. One is disable the IMA-meas=
urement
> > > > > copying from 1st kernel to 2nd kernel, this is only needed by kex=
ec
> > > > > reboot; the other is IMA is not needed at all in kdump kernel, me=
ans we
> > > > > don't want to call ima_init() to initialize
> > > > > ima_keyring/crypto/template/digests/fs etc.=20
> > > > >=20
> > > > > With my shallow knowledge about IMA, I don't know how to imitate
> > > > > appraisal cmdline to disable IMA partially in kdump kernel case.
> > >=20
> > > Thanks for detailed explanations. Just back from holiday, sorry for l=
ate
> > > reply.
> > >=20
> > > >=20
> > > > The IMA policy controls how much or how little IMA measures and app=
raises.  Most
> > > > of the memory usage is the IMA measurement list, itself, and the pe=
r file cache
> > > > info.  (The per file cache info limits re-measuring or re-appraisin=
g files.)
> > >=20
> > > In Steve Chen's kexec supporting ima patchset, kdump kernel loading
> > > should skip ima_kexec buffers allocating and storing via checking if
> > > (image->type =3D=3D KEXEC_TYPE_CRASH).
> > > >=20
> > > > Similarly my knowledge of kdump is very limited.  Is there a way fo=
r the kernel
> > > > to differentiate between kexec and kdump?  If we need a mechanism t=
o disable
> > > > IMA-measurement, I'd *really* prefer it be limited to kdump.
> > >=20
> > > Yes, function is_kdump_kernel() is provided for checking if the curre=
nt
> > > kernel is in kdump kernel.
> > >=20
> > > As said in earlier reply, for kdump kernel, there are two things we
> > > should do:
> > > 1) when loading 2nd kernel to prepare for switching, we should not
> > > allocate buffer and store IMA measurement list;
> > > 2) when switched into kdump kernel, we should not call ima_init() to =
do
> > > kinds of init which is useless.
> > >=20
> > > My personnal opinion.
> >=20
> > Thanks for pointing out the KEXEC_TYPE_CRASH check and is_kdump_kernel(=
).  Both
> > changes sound reasonable.
>=20
> Thanks for confirming. I will consider how to fix it accordingly. Maybe
> after Steven's patches are merged. That would be great if the buffer
> allocating and storing can be skiped for kdump in Steven's patch. While
> I am worried that could disrupt the progress of Steven's patches.

Agreed, let's get Steven's patch set upstreamed and then make the kdump
exceptions.

- "ima: kexec: move IMA log copy from kexec load to execute" looks like it =
isn't
copying the IMA measurement list records (kexec_post_load), but the memory =
for
the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).

- Do you really want to totally disable IMA for kdump or would disabling IM=
A-
measurement be sufficient?  Remember there's already an option to disable I=
MA-
appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to con=
tinue
to work.  Meaning based on policy the integrity of files - executables, ker=
nel
image, etc - could still be verified.

Without IMA-measurement:
- No adding records to the IMA measurement list
- No IMA measurement list pseudo securityfs files
- No extending the TPM

With IMA-appraisal:
- Integrity verification of files based on keys, keyrings
- Loading keys

Obviously my preference would be to add support to disable IMA-measurement =
in a
kdump environment.

thanks,

Mimi

