Return-Path: <linux-integrity+bounces-7521-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6966C06EC4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E6A3A32EA
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5156322C60;
	Fri, 24 Oct 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eef6F1Re"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC91A3160;
	Fri, 24 Oct 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319024; cv=none; b=MNnwUYWn+26GbWBazItQ70BZkTMB17wEadzR+4spXWlkbklujFWrZ0JV4Jfd8CWBVp6NmwDrBsJzqeXaRy1P8HmpuALy7Jev5eS5Xd1RDBq296+hf+kU5U5AhZ88PSEIPfp0vHTYhRaZ23NGdFY7oilOg6chLxGKrfJgaffglLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319024; c=relaxed/simple;
	bh=a6yvcST1bBb/gCzpwjJnJ0X2b8fRgFLFhOcgsKJKqJ4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=j8wZuCxUzKHsREACULI8H+sr6OkadT9dCA0qu6ndgZNIDPBfsN5trSaV7/KVCZnZDfTf97VoZXdjo2M36A7+DObPcpQNGasovm734P/z5OI7LwW2Kqh/aVXaMwckCBIiFkzOOFyzEIi+qQNBz4dnbzQ62AosJXp1BwfLkqsMITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eef6F1Re; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA2nHd023244;
	Fri, 24 Oct 2025 15:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+qbRb2
	zP2iNkMx37uViMBN1opWKnCEWdDRQ+ENovi7Q=; b=eef6F1ReviaqS6x+P2rDV2
	7cxHsIGoi8bZbRIC4LQ4Y+qYtzP0UVPhY13mhd83YgnYLFOInE1FSYxkFmS6trKc
	zozXNRvyf4h22+PqYKTYC8LQk3Pi8SuIGRuX475nWCTzIRJWJidyg9tSN+TkvR3q
	/Yh3HdPAgTIquUES2NW0liutvvvL4+GQyFiU+EkBh6rTBD2EZCkt8ca0ciDmKm3P
	zzOW5zVJrYhbFB3QD5em33md+uvBOHjrUHcqN9ipYZi51mJQxTxccq/IPgAyc2y+
	fajIXIpdsxhf1gEgwmAVpTBJAxbc4vDtXWTxdSr6D9AOYqyZ2VVi1ii8Vydjr2CQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3277yxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 15:16:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OFCbBl001704;
	Fri, 24 Oct 2025 15:16:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3277yxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 15:16:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OEAE0r024677;
	Fri, 24 Oct 2025 15:16:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkbkn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 15:16:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OFGdXJ24445550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 15:16:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141B95805A;
	Fri, 24 Oct 2025 15:16:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F5E58056;
	Fri, 24 Oct 2025 15:16:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.52.106])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 15:16:38 +0000 (GMT)
Message-ID: <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
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
In-Reply-To: <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
		 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
		 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
		 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
		 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
		 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
		 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
		 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
	 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Oct 2025 11:16:37 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb9859 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MBubdp0LbrEvKVWzv-8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxy/SHljbe7p/
 /eIINUXje6u/3kxpqxLTUswIr7D4AvMOrpNPTn5Zo3gkVmHxvBhJsl4Qyom8pEZUCg0/4Vm20Wf
 yGkvad8Shx5J++NTNbdYO3Gs2SGfQV0KeopNhTvLh2l/KpF0Fm0T8DzgFoSei8r7NbB7AEYaCiB
 NLLQMDHIWV0gMgU5Dj0D0KM5ES8Bt6yDayKM3CFQ4ijroculpaDfxI+aQHwBIHPvGdLvd8sKD0q
 AA3bgofERJ8X7PtH4sHyCVVTAipUriyrqp3aOXP8x6kL+f8ml/OO3QBcBe+xhTgEVobvuOSkBAT
 qrfCtv4mTswu8OSRIg3vwh5lklfmpxMKJoEx5/NULyav3u4FsS/kLLqTRNfB//xwcYmbhQ6s9ad
 3hC3LM9iXC0yney+yl2bVLNrWb+55w==
X-Proofpoint-GUID: R2a3dFHlfxOJSA6AqXfrCWxjUQg7m828
X-Proofpoint-ORIG-GUID: B-sxDXigq233DC-oBi2fpADgAA1faPpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
> On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
> > > > > 2. Instead of defining an additional process_measurement() argume=
nt to identify
> > > > > compressed kernel modules, to simplify the code it might be possi=
ble to define a
> > > > > new "func" named COMPRESSED_MODULE_CHECK.
> > > > >=20
> > > > > +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COMPRES=
SED_MODULE_CHECK
> > > >=20
> > > > I also thought about this approach. But IMA rule maps kernel module
> > > > loading to MODULE_CHECK. If we define a new rule and ask users to u=
se
> > > > this new rule, ima_policy=3Dsecure_boot still won't work.
> > >=20
> > > I don't have a problem with extending the "secure-boot" policy to sup=
port
> > > uncompressed kernel modules appended signatures, based on whether
> > > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to t=
he existing
> > > MODULE_CHECK rule.
> >=20
> > I assume once the new rule get added, we can't remove it for userspace
> > backward compatibility, right? And with CPIO xattr supported, it seems
> > there is no need to keep this rule. So if this concern is valid, do you
> > think we shall switch to another approach i.e. to make IMA support
> > verifying decompressed module and then make "secure-boot" to allow
> > appended module signature?
>=20
> Yes, once the rule is added, it wouldn't be removed.  As for "to make IMA
> support verifying decompressed module", yes that might be a better soluti=
on,
> than relying on "sig_enforce" being enabled. IMA already supports verifyi=
ng the
> appended signatures.  A new IMA specific or LSM hook would need to be def=
ined
> after module_decompress().

Looking at the code further,=C2=A0decompressing the kernel module in IMA is
redundant.  Instead I think the best approach would be to:
- define DECOMPRESSED_MODULE, in addition to COMPRESSED_MODULE.

id(COMPRESSED_MODULE, compressed-kernel-module) \
id(DECOMPRESSED_MODULE, decompressed-kernel-module)    \

- instead of passing a boolean indicating whether the module is compressed,=
 pass
the kernel_read_file_id enumeration to differentiate between the compressed=
 and
decompressed module.

- define a new IMA hook, probably LSM hook as well, named
ima_decompressed_module().

- call the new ima_decompressed_module() from init_module_from_file()
immediately after decompressing the kernel module.  Something along the lin=
es
of:

err =3D ima_decompressed_module(f, (char *)info.hdr, info.len,
                              READING_DECOMPRESSED_MODULE);

For testing purposes to see the decompressed appended signature in the
measurement list, modify the MODULE_CHECK measure rule to include "template=
=3Dima-
modsig" in ima_efi.c.

--=20
Mimi


