Return-Path: <linux-integrity+bounces-7627-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B5C69585
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Nov 2025 13:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B41EE2B2FB
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Nov 2025 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A17301499;
	Tue, 18 Nov 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NACC1nP2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247A1E5714;
	Tue, 18 Nov 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468452; cv=none; b=KxQvoyFY6WF9UxUIKfDHPc9NrHSMSgTZVS7kkkP3eNJPMhLlOaV2l54GJKaxzWcXPD3WlOz6oZUSG8UqQsBFi6izXFg+fbpwfDvHCJlsI0RvrTuNC8LnH8iZX7+JF+MnBE61M/I9UCcVWtRmtc9+ZTZYtrnF1SAeRm3kRoCpdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468452; c=relaxed/simple;
	bh=GVRJlpDF8xrYLl1WhyXJ0U4K5iusSxsWmXPfW0IF8DE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PVzxmSgd9pwI5Rs57lo+LxPTKw+7dtK1i6a0RTNVVtYJja8qhFCyl5amWAM6p+nJR1cDbP8B1Q3Sh75tbhAq/6wL/k1JtODP+1bBuWfW7/PlLJMhsVOlHvzQwNxA+QZNY7l1rEAQn0FlzYa6yfM9MZ7r0qpf1qTo52x9FHMdCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NACC1nP2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHLqGBh028653;
	Tue, 18 Nov 2025 12:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lyhY8E
	ntmkR94BhtT2/pCjFipvKnQo7TILmccwMs99A=; b=NACC1nP2+Ol5T2M82baQnG
	O90H/U1Rp7jUA6LJsgHhFZbAfpfDWQlT0qHpltpfvyUXClyUPrbkfrY68fsl/vID
	PUeO80sSmr+gRSJShqNAceLpCaRvkOEm/hwaRnuYV0zShdAhGYr4nDD5n36qGw6y
	cxEEbEx+r3csUe+bbliZUHVyYPyPdCsabcc2S3Sp/griILlmuKCKSh7Em3kpgPEr
	LfIx2wj+ZLRiTCHhe/1j1rlCClx9TQMZe5NlbgMk57VD+8nMnPwsUS0ooIFiFCaS
	XfI4ZhizmCBf6b8TMceHToK4VO3ZrJHhJtJ90sd4lThIKMU9zg6s98og5+DgT43w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsje77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 12:19:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AICJrlZ029594;
	Tue, 18 Nov 2025 12:19:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsje73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 12:19:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIC6t9G022386;
	Tue, 18 Nov 2025 12:19:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umtywa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 12:19:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AICJqNt19268182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 12:19:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F9B58053;
	Tue, 18 Nov 2025 12:19:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C97558043;
	Tue, 18 Nov 2025 12:19:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.13.83])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 12:19:50 +0000 (GMT)
Message-ID: <fca9a7b41a5e428fadfe2d7e3b004ada2763375c.camel@linux.ibm.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>,
        James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Luis
 Chamberlain	 <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez	 <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Roberto Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MODULE SUPPORT"
 <linux-modules@vger.kernel.org>
In-Reply-To: <42qcfcxxlmwphctzvji76hy5tycfabiiv5u6zw6lgg2p3e2jwv@fp4g2y7ecf2y>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <20251031074016.1975356-1-coxu@redhat.com>
	 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
	 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
	 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
	 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
	 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
	 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
	 <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
	 <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>
	 <42qcfcxxlmwphctzvji76hy5tycfabiiv5u6zw6lgg2p3e2jwv@fp4g2y7ecf2y>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Nov 2025 07:19:50 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tmx0S859D2PjT-GcS_PiFz6ExPxs8ajY
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691c646a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=lMX6Wg8gRfqxLgtVRk4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: gAS9-5b4YybH3DfeKDBYJcVlI9B8-D4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX58kgaZkoYOHV
 vNfeRlo8tH98ik327mO9zkSPcXtkQE9G9dxlLFiA73mqddV5alGRttVQO6GUE5aOAlwdY/OWny9
 E8PLov8hz1t+/E7uo5ly7XKCIB3xbu8IlvcliHaT8UeB+tpcQlBDUG5OCBN+S766bgTx401T+O+
 brJVYM3ufPa/Aooa3qpAfO3O7+PAyvKvi7P7ix2br7wpb5FNRbsU28LnEocv0N6LyLJ40XpF3AI
 smUXMrYzr/RZVwmC+8CnUcPm+WGchMVrEqXETqaSx9QGutAP3PW2Nv6R/uq+fMwNL7PVz1Qhelh
 9M9m8AAzPTILgWjGU4XV0HvTM3jGYAXZs4RUxFXGGcDu2QJFPMblHe4mzDZG940elrCQXD0OSs6
 OURZ/a2dWyaBRK/nrjtWLvEwoAEWpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Thu, 2025-11-13 at 12:06 +0800, Coiby Xu wrote:
> On Fri, Nov 07, 2025 at 02:28:13PM -0500, Mimi Zohar wrote:
> > On Thu, 2025-11-06 at 17:15 -0500, Mimi Zohar wrote:
> > > On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
> > > > On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
> > > > > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
> > > > [...]
> > > > >=20
> > > > > Hi Coiby,
> > > > >=20
> > > > > Based on the conversation with Paul, there is no reason to remove=
 the existing
> > > > > security_kernel_post_read_file() call.
> > > > >=20
> > > > > The changes are similar to the 2nd link, but a bit different.
> > > > > - Define a single enumeration named READING_MODULE_COMPRESSED.
> > > > >=20
> > > > > - In module/main.c add a new security_kernel_post_read_file() cal=
l immediately
> > > > > after decompressing the kernel module.  Like a previous version o=
f this patch,
> > > > > call kernel_read_file() with either READING_MODULE or READING_MOD=
ULE_COMPRESSED
> > > > > based on MODULE_INIT_COMPRESSED_FILE.
> > > > >=20
> > > > > - In ima_post_read_file() defer verifying the signature when the =
enumeration is
> > > > > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_=
kernel_module.)
> > > >=20
> > > > Hi Mimi,
> > > >=20
> > > > Thanks for summarizing your conversation with Paul! I can confirm P=
aul's
> > > > approach works
> > > > https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_=
lsm_hook_paul
> > > >=20
> > > > While testing the patch today, I realized there is another
> > > > issue/challenge introduced by in-kernel module decompression. IMA
> > > > appraisal is to verify the digest of compressed kernel module but
> > > > currently the passed buffer is uncompressed module. When IMA uses
> > > > uncompressed module data to calculate the digest, xattr signature
> > > > verification will fail. If we always make IMA read the original ker=
nel
> > > > module data again to calculate the digest, does it look like a
> > > > quick-and-dirty fix? If we can assume people won't load kernel modu=
le so
> > > > often, the performance impact is negligible. Otherwise we may have =
to
> > > > introduce a new LSM hook so IMA can access uncompressed and origina=
l
> > > > module data one time.
> > >=20
> > > ima_collect_measurement() stores the file hash info in the iint and u=
ses that
> > > information to verify the signature as stored in the security xattr.
> > > Decompressing the kernel module shouldn't affect the xattr signature
> > > verification.
> >=20
> > In the case when the compressed kernel module hasn't previously been me=
asured or
> > appraised before loading the kernel module, we need to "collect" the fi=
le data
> > hash on READING_MODULE_COMPRESSED, but defer appraising/measuring it.
> >=20
> > An alternative to your suggestion of re-reading the original kernel mod=
ule data
> > to calculate the digest or defining a new hook, would be to define "col=
lect" as
> > a new "action" and pass the kernel_read_file_id enumeration to
> > process_measurement().  IMA_COLLECTED already exists.  Only IMA_COLLECT=
 would
> > need to be defined.  The new collect "action" should be limited to
> > func=3DMODULE_CHECK.
> >=20
> > The downside of this alternative is that it requires a new collect rule=
:
> > collect func=3DMODULE_CHECK mask=3DMAY_READ uid=3D0
> > appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig

As it turns out, the "collect" rule is unnecessary.  On
READING_MODULE_COMPRESSED, process_measurement() should calculate the compr=
essed
file hash.  Extending the IMA measurement list and verifying the signature =
can
then be differed to READING_MODULE.

>=20
> Thank for suggesting an alternative! I've implemented the idea in
> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_collect
>=20
> Note besides a new collect rule, another change is needed. Currently,
> process_measurement only accepts enum ima_hooks thus it can't tell if
> it's READING_MODULE_COMPRESSED so to only do collect action. So I
> create a fake MODULE_COMPRESSED_CHECK func.

Correct, either extending process_measurement() with the read_idmap enum or
defining the fake hook would work.

>=20
> And for the idea of re-reading the original kernel module data, it has
> been implemented in=20
> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_ho=
ok_paul
>=20
> Both branches have applied your requested three changes including
> respecting the 80 char line limit. Additionally, I made a change to the
> IPE LSM because of the new READING_MODULE_COMPRESSED kernel_read_file_id
> enumerate.
>=20
> After comparing the two implementations, personally I prefer re-reading
> the original kernel module data because the change is smaller and it's
> more user-friendly. But if there are other reasons I don't know, I'll
> post the patches of the new collect action approach to the mailing list.

The "re-reading" option fails some of the tests.  As the "collect" rule isn=
't
needed, let's stick with the first option.

--=20

thanks,

Mimi

