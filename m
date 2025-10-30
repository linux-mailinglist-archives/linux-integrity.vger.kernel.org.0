Return-Path: <linux-integrity+bounces-7546-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B9C1E36B
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Oct 2025 04:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600FB1883989
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Oct 2025 03:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8619289824;
	Thu, 30 Oct 2025 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EgQvhcqx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBB2877D8;
	Thu, 30 Oct 2025 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795357; cv=none; b=QRIWe83HxaS19NWdrFvJ+8K+vck+ZwefaBfSuYtpJjrDaf75m7ulnlqavKufuqlUjh6rh0AbkFVAffgPLI7ZIJH1hDQJPhjoFDC+S8YFC0mGpFB2YonhlWr8CX/WLttyiJ3N2paElU+9EUjH548rDZ/ceqD2qEyNbZN6bBIZufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795357; c=relaxed/simple;
	bh=EvQ/5bKwDUtEf9AiD5um2+uxCVxKBdw9w0/JZ2SDjXU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UcC9n3Pjt75pP71NMgaY4sa10q4yDYmxdODfst8ocMepanu6bq8Fp/Gpl495S5sPeEuXDzdvADmSW2/PahdtEmGJjfh65O0FjQxqZBrBuOJ8DkWMu+xQJWUpCR8wWY9P+9AqYMh3bDiQMgWHqfx5gWSUAapRt4+SI449Vhv5UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EgQvhcqx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TLQWCl031470;
	Thu, 30 Oct 2025 03:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PpJ8T8
	iD1KR7ITAfQ53AMGj5fpGO31ZCrQIFW1meyaw=; b=EgQvhcqx3CnsMtUACV40cC
	L7o0NAHndTBQWTaPz8AdWH57M6ssnceKT5Oqrr/012dza57p3MQd0nD6vrBP5f3s
	kcKJ/+KsjEuXHJrIti4K7O8nioqJNqp2ORifIu83VJRCULY64sjvZwq+K77Ze/YO
	R+QGz1A78kUpiHmjz7Aw2/55tcaKaqpaH45o4t5nf9OExojs1uoUg9Cxj1sZ5goL
	DtFPOulCLpqBQVboQRaZEogqJqyIGbKtG7A4CYU5GqCcSXxcYvYBNVpKo52ydmx+
	Dufx6wZU/rm66e5rYIt3N18B2/XN7eesqTfIm6JZoq9a1zhJCGhbrgudMOJBpiQQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajp5qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 03:35:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U3ZZC4016839;
	Thu, 30 Oct 2025 03:35:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34ajp5qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 03:35:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U1wID7019373;
	Thu, 30 Oct 2025 03:35:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xweg0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 03:35:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59U3ZYQu29032968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 03:35:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0A75877C;
	Thu, 30 Oct 2025 03:01:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44EED58720;
	Thu, 30 Oct 2025 03:01:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.32.143])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 03:01:29 +0000 (GMT)
Message-ID: <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
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
In-Reply-To: <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
	 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
	 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
	 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
	 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
	 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
	 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
	 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
	 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
	 <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Oct 2025 23:01:27 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=6902dd08 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UXIAUNObAAAA:8 a=YMm9jw0qTLC_d0oe6EwA:9 a=QEXdDO2ut3YA:10 a=U308fY8ZEg0A:10
 a=a1s67YnXd6TbAZZNj1wK:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: AcH7RolWTlFm9MvrVEMp-3D4o2zQziF4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4Sm2N6+CCGEA
 SQZQAJWK5D+yCnNFLYnU7wetVV8qdr9XmfpM8a0lhHnmj882fZq+ihOaWrpDh+4dkGd9yNIf2qt
 Cxt6S9frtX3yRqmx/To4S+NaFykiaIGzucKoCfekaMuWe7yyJR8JA35wBpQzqqnb+aUHx+mn+3B
 tlGe2h9IiAJeRd0JroTJXJmQYbeF38wrbpOP23fDBs5Rcb83VmSuUg9Jy0QWYcFAi/9w3vWm6Kh
 4j5suLIc9B+4bwFgLldfZy409Q49T4u02sCW9Wp+KA2R67NueS1HEXVPZt9le2btiQyZQwxmRSz
 sUdjqHcBSTeHa49dTzo48PUgrkWlrZGKfu6Io4eRwSjc83C/4vBnv5qa6FtZsABAn/qLxBiWN7z
 m0BqtHHamwMS+XBS9cTMAIi33p41nw==
X-Proofpoint-ORIG-GUID: qgkqj84ktxezLlGSp810K1CeDhGZ9Gxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2510280166

On Thu, 2025-10-30 at 08:31 +0800, Coiby Xu wrote:
> On Fri, Oct 24, 2025 at 11:16:37AM -0400, Mimi Zohar wrote:
> > On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
> > > On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
> > > > > > > 2. Instead of defining an additional process_measurement() ar=
gument to identify
> > > > > > > compressed kernel modules, to simplify the code it might be p=
ossible to define a
> > > > > > > new "func" named COMPRESSED_MODULE_CHECK.
> > > > > > >=20
> > > > > > > +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COM=
PRESSED_MODULE_CHECK
> > > > > >=20
> > > > > > I also thought about this approach. But IMA rule maps kernel mo=
dule
> > > > > > loading to MODULE_CHECK. If we define a new rule and ask users =
to use
> > > > > > this new rule, ima_policy=3Dsecure_boot still won't work.
> > > > >=20
> > > > > I don't have a problem with extending the "secure-boot" policy to=
 support
> > > > > uncompressed kernel modules appended signatures, based on whether
> > > > > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition =
to the existing
> > > > > MODULE_CHECK rule.
> > > >=20
> > > > I assume once the new rule get added, we can't remove it for usersp=
ace
> > > > backward compatibility, right? And with CPIO xattr supported, it se=
ems
> > > > there is no need to keep this rule. So if this concern is valid, do=
 you
> > > > think we shall switch to another approach i.e. to make IMA support
> > > > verifying decompressed module and then make "secure-boot" to allow
> > > > appended module signature?
> > >=20
> > > Yes, once the rule is added, it wouldn't be removed.  As for "to make=
 IMA
> > > support verifying decompressed module", yes that might be a better so=
lution,
> > > than relying on "sig_enforce" being enabled. IMA already supports ver=
ifying the
> > > appended signatures.  A new IMA specific or LSM hook would need to be=
 defined
> > > after module_decompress().
> >=20
> > Looking at the code further,=C2=A0decompressing the kernel module in IM=
A is
> > redundant.  Instead I think the best approach would be to:
> > - define DECOMPRESSED_MODULE, in addition to COMPRESSED_MODULE.
> >=20
> > id(COMPRESSED_MODULE, compressed-kernel-module) \
> > id(DECOMPRESSED_MODULE, decompressed-kernel-module)    \
> >=20
> > - instead of passing a boolean indicating whether the module is compres=
sed, pass
> > the kernel_read_file_id enumeration to differentiate between the compre=
ssed and
> > decompressed module.
> >=20
> > - define a new IMA hook, probably LSM hook as well, named
> > ima_decompressed_module().
> >=20
> > - call the new ima_decompressed_module() from init_module_from_file()
> > immediately after decompressing the kernel module.  Something along the=
 lines
> > of:
> >=20
> > err =3D ima_decompressed_module(f, (char *)info.hdr, info.len,
> >                              READING_DECOMPRESSED_MODULE);
>=20
> Thanks for proposing a better solution! Yeah, decompressing the kernel
> module in IMA is unnecessary. Do you think we can further extend your
> idea to call one IMA hook only after kernel module decompression is
> done? If we call two IMA hooks in finit_module, we'll need coordination
> between two IMA hooks i.e. the 1st IMA hook shouldn't fail in order for
> the 2nd IMA hook to be executed. The new IMA hook will always have
> access to the decompressed kernel module buffer so there is no need to
> differentiate between compressed and decompressed module.

Agreed instead of verifying the kernel module signature on the LSM
kernel_post_read_file() hook, define and move it to a new IMA/LSM hook afte=
r it
is decompressed, would be much simpler than coordinating two LSM hooks.

>=20
> Another question is whether we should allow loading a kernel module with
> appended signature but misses IMA signature. Both IMA arch specific polic=
y
> and init_module syscall only require appended signature verification. On
> the other hand, we only allow "appraise_type=3Dimasig|modsig" but not
> appraise_type=3Dmodsig. How about we allow loading a kernel module with
> valid appended signature regardless of its IMA signature? We won't call
> set_module_sig_enforced but as long as we know is_module_sig_enforced()
> is true, we allow the module in IMA.

Based on the policy, IMA enforces signature verification. Only if
CONFIG_MODULE_SIG is configured, the IMA arch specific policy does not defi=
ne an
IMA kernel module appraise rule. However, custom policies could still requi=
re
both types of signatures, not necessarily signed by the same entity.

The option "appraise_type=3Dimasig|modsig" allows either an IMA signature O=
R an
appended signature.

>=20
> >=20
> > For testing purposes to see the decompressed appended signature in the
> > measurement list, modify the MODULE_CHECK measure rule to include "temp=
late=3Dima-
> > modsig" in ima_efi.c.
>=20
> I haven't figured out why to include "template=3Dima-modsig" for testing
> purpose considering we can simply check if the kernel module has been
> loaded successfully.

That's fine too.

> It it related to the design that "The d-modsig and
> modsig fields are only populated if both the measure and appraise rules
> trigger"? If so, can you also help me understand there is such a design?
>=20
> [1] https://ima-doc.readthedocs.io/en/latest/event-log-format.html#ima-mo=
dsig

The "ima-sig" template contains the file data hash and file signature, allo=
wing
the attestation server to verify the signature based on the file data hash
contained in the measurement list.

In addition to the file data hash and the file signature, the "ima-modsig"
template contains the file data hash without the appended signature, allowi=
ng
the attestation server to verify the appended signature against it.

Mimi

