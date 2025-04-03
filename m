Return-Path: <linux-integrity+bounces-5596-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56482A7B01A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 23:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FA517299F
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143A253B4B;
	Thu,  3 Apr 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BwU/KWEL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9182566E8
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710635; cv=none; b=mcFf5Kq9HkLAqVfya97NctMXzc76RPq3E4+jv70Eh4LNMg3NhSJ5d/FNYYiEVPxf3GD55/ALCXgqDggt6kAaREn5y7NP6GEkniNmJWimtqXAwMsGDUSa+U3adXX/8DaV1tAp8PVObsKk9fPFh4rWQDzMGINrovaMwIuhoTR67tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710635; c=relaxed/simple;
	bh=Qg4XXHqWpj/ejN1OHK65Sk1NUjBiMNj9t3kG92dBhVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GerSy7Olx2PbrQLu3OEax4KiXk8LI2J9kpq35wQOlk0Edwitfh9L9Wh91O7wNpbA/D5McN+/0o7Y5nlyM0ztRGnFr6vwLT/64rrbbLY4iwgaCF2EehNCJjtbq0c4999mCbW+NRxP9CENMPuKKIIEzCsEmD142cDEQstGjCuW3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BwU/KWEL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533FhT6j007564;
	Thu, 3 Apr 2025 20:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lTs1Ww
	ONNvstTLbDB+gWMOQsHyhJxJMCwy6FbePxvzo=; b=BwU/KWELwmSVFpvqbEHyK9
	cfHKK315UaHFYl4jnCL+nimFLNW6TWsmTIImLE7LwVQhOiZb442yrWcKB1a/PALB
	OqdbpCkS+jH/z8N6ZWTJWaynQXXt1WG0KlAMXD0UPnxsbV5W/Bvfk5lC4WaADYBF
	NiXCW9O98ftX36VYy8irB5dinfMnh2kpDUzktRxaubN+3amreKc7zlBehy44UXIg
	kTTfagwYxxr/3IAMng6FKvujbUPOUKB7BMss/FUe1cl1nSsHt+ElVOE/C/Oj9wRt
	G4YuvDT8144iLcN9MMV9XuNMYQuFPTUCQc/3tMAUIArBeeiZIl5f52TJgaoIqbkQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45surq9ucy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 20:03:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 533HQDSQ004757;
	Thu, 3 Apr 2025 20:03:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45puk06qvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 20:03:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 533K3kFl2687590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Apr 2025 20:03:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0281D58045;
	Thu,  3 Apr 2025 20:03:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 736F958054;
	Thu,  3 Apr 2025 20:03:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Apr 2025 20:03:45 +0000 (GMT)
Message-ID: <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, Coiby Xu <coxu@redhat.com>
Cc: RuiRui Yang <ruyang@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Date: Thu, 03 Apr 2025 16:03:45 -0400
In-Reply-To: <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
	 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
	 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
	 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
	 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
	 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
	 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
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
X-Proofpoint-GUID: BysYrzUsiqZo4DyzHP4moMvFZVdxU7jq
X-Proofpoint-ORIG-GUID: BysYrzUsiqZo4DyzHP4moMvFZVdxU7jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030105

On Wed, 2025-04-02 at 19:49 +0800, Baoquan He wrote:
> On 04/02/25 at 04:43pm, Coiby Xu wrote:
> > On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> > [...]
> > > > > > that.  Please don't make it generic like this.
> > > > > >=20
> > > > > > Please refer to ima_appraise_parse_cmdline().
> > > > >=20
> > > > > Hi Mimi,
> > > > >=20
> > > > > To save memory for kdump, it seems init_ima has been to be skippe=
d thus
> > > > > ima=3Doff is necessary (ima_appraise=3Doff won't serve the purpos=
e). Or do
> > > > > you have any specific concerns in mind?
> > > >=20
> > > > I think as Mimi said see below logic enforces the IMA even with the
> > > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > > if (sb_state) {
> > > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > > >                         pr_info("Secure boot enabled: ignoring
> > > > ima_appraise=3D%s option",
> > > >                                 str);
> > > >         } else {
> > > >                 ima_appraise =3D appraisal_state;
> > > >         }
> >=20
> > Thanks for pointing me to the above code! Note with the whole IMA
> > disabled as done by this patch, the above code will not run so IMA
> > (appraisal) won't be enforced.
> >=20
> > >=20
> > > Thanks, RuiRui.
> > >=20
> >=20
> > Mimi, so do I understand it correctly that your want IMA-appraisal to b=
e
> > always enabled as long as secure boot is enabled even if users choose t=
o
> > disable IMA?=C2=A0

Secure boot is not the only reason.  Based on policy IMA-appraisal and EVM
calculate and store file hashes and HMAC's in their respective security xat=
trs.
Normally the usage of file hashes and HMAC's is limited to mutable files.=
=20
Disabling IMA-appraisal could result in not properly updating the security
xattrs, which would result in not being able to verify the file's integrity=
 on
reboot.

On systems where the RPM includes file signatures, file signatures of immut=
able
files can be safely restored.  Although it is possible to walk the filesyst=
em(s)
"fixing" the xattrs of mutable files, it defeats the purpose.  "fix" mode s=
hould
only be enabled in a trusted environment.

> > I wonder what security issue will it bring if this promise
> > gets broken considering other LSMs can SELinux can be disabled when
> > secure boot is enabled?

The builtin IMA policy rules are not defined in terms of SELinux labels.  I=
f the
initial IMA custom policy defines rules based on SELinux labels and SELinux=
 is
not enabled, the policy will fail to be loaded.

> > > Coiby, would disabling just IMA-measurement, as opposed to IMA-apprai=
sal, save
> > > sufficient memory for kdump?
> >=20
> > For disabling just IMA-measurement, do you mean not enabling any measur=
e
> > rules?  The more memory reserved for the kdump kernel, the less memory
> > can be used by the 1st kernel. So from the perfective of kdump, we try
> > to make the memory footprint as smaller as possible.

Got it.

> > Baoquan, do you have any statistics about the memory overhead of IMA?
>=20
> I am getting a system to check that. I think there are two aspects of
> IMA functionality we want to disable. One is disable the IMA-measurement
> copying from 1st kernel to 2nd kernel, this is only needed by kexec
> reboot; the other is IMA is not needed at all in kdump kernel, means we
> don't want to call ima_init() to initialize
> ima_keyring/crypto/template/digests/fs etc.=20
>=20
> With my shallow knowledge about IMA, I don't know how to imitate
> appraisal cmdline to disable IMA partially in kdump kernel case.

The IMA policy controls how much or how little IMA measures and appraises. =
 Most
of the memory usage is the IMA measurement list, itself, and the per file c=
ache
info.  (The per file cache info limits re-measuring or re-appraising files.=
)

Similarly my knowledge of kdump is very limited.  Is there a way for the ke=
rnel
to differentiate between kexec and kdump?  If we need a mechanism to disabl=
e
IMA-measurement, I'd *really* prefer it be limited to kdump.

thanks,

Mimi

>=20
> One exmaple is 'cgroup_disable=3Dmemory' we have been doing to add into
> kdump cmdline because mem_cgroup is not needed at all for kdump kernel.
> We want to achieve that effect.

