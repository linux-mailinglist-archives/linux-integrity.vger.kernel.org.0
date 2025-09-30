Return-Path: <linux-integrity+bounces-7325-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B5BAD20D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 15:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361FA4A55C0
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187418CBE1;
	Tue, 30 Sep 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TLw1KVQf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F13081B5;
	Tue, 30 Sep 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240655; cv=none; b=H4IxSKhhbkotH67SLjtPTEoh4vuHeHf+gjktQSfzKYf5lsPu+Osamdh2CGt2tNHV9JluBCCWueP63tbqh1Saeu0ZmVN0v7jAMolz4aKDWgpqvEc/cY5fUBVCB8hqDqSKFjhZoPlDRE35WAo/XjBXHgyM8PIxngldrI0JyGS0/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240655; c=relaxed/simple;
	bh=In9r7c+wdcbNtEpOOZ44XfXzAN+ZfSmb7k4T8LbLBbI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WQwmk8CX1Hu6o/UtEYN5Kok8udlIQrxjAD253jKuGpMw3i9zGHsDv+k0za7C8GuS/6uFVpIGmTXV4yiVTzNSd2L4Gvw5lKamR8cIzm+9kykxFeGXy6IR4Tk9r+GFaLIUkMoYmSF9APJaRvxC5QYQ6ZvpD2sGDij3RXbiT3+yL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TLw1KVQf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U7R8kJ014796;
	Tue, 30 Sep 2025 13:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mc5QBp
	F0Q6KVKJJ9Xaf/eq8K5qiEWRGkQWTHOSi5bIE=; b=TLw1KVQfdmAaGxEbm17wNY
	lwtS66PJGp3n6gT8FTjWkArxDAiBlSr2roYIee4GK0sv2xWw0H3TVNOiHjQY43hu
	Y19NBuXO4IJUvJYLqPLb4iqkj89YJZC539sMb8PoHx/BIgIbA6Z4033gNfed3doL
	lNz6y0P5MIQRREXZVSiUCeRvgTpF37OXJjxO2N8PhDrs1yPuIJqpuS6opl53jy9L
	WfHzr0Ck+CFq1ustEDtYhwRAmglaVtksXCQvG8gfdP4A2Ab/CnTphAaUJVs9Vxy/
	oVN2kcibSz10SJ0d0s1aneApCRTGISuuNyzEhia371kG5y0Wh7+hpxNZAOLmeKzQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhh03k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:57:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58UDputd009852;
	Tue, 30 Sep 2025 13:57:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhh03e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:57:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UDWdJf001667;
	Tue, 30 Sep 2025 13:57:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfj3dv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 13:57:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UDv9Wh13959796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 13:57:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 526B858059;
	Tue, 30 Sep 2025 13:57:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AA0558043;
	Tue, 30 Sep 2025 13:57:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.16.91])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 13:57:07 +0000 (GMT)
Message-ID: <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
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
In-Reply-To: <20250928030358.3873311-1-coxu@redhat.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Sep 2025 09:57:07 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68dbe1b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=20KFwNOVAAAA:8 a=IwvpNu1LYuw_ebdDn2kA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX+/V5A4iDfgTZ
 JdAK48//JjlhZxfwDPDbXj59pnMIGkkGrLEANbNClXe+LwIhuyVXVrga0s49F2B1CycVpad92AC
 O9H7ZQ+gRjWGnFU6nyGr8j1rtPFr5Ymlk8T6evtMzQOLNviYV+tCi3ciBpxpwa2DmSZDtVvRzou
 nfgftcTLJivX/BwVzzTBepT4Zzbs1FKyx3IGeHdjh5HYNatwuPzSX5gBNt4S/sGkyLsXLd154wA
 Jxnuetn/cyNcMmRxRjVOKpx3WjYJHoK7l/MifvoXSEnRHtu5ezCM83J4oIH0marSGsJ89jz/9GP
 8YmahdF37us/0LE8W4JbVsXQFH+pQHTKdLE9WZzbIPKKxKVsRR4FBsmHtTGmx5slKZ4YR6cbYm8
 lFyKo5fN6R7U2/fJ2h0I/as7SPXqXw==
X-Proofpoint-GUID: BPmjQx43MbM_zqqdAXGY0s0-lHnc55ah
X-Proofpoint-ORIG-GUID: RAKkLfJ8ze8ZUMi4wI7P9nwzksqjxj-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010

On Sun, 2025-09-28 at 11:03 +0800, Coiby Xu wrote:
> Currently, for any IMA policy that requires appraisal for kernel modules
> e.g. ima_policy=3Dsecure_boot, PowerPC architecture specific policy,
> booting will fail because IMA will reject a kernel module which will
> be decompressed in the kernel space and then have its signature
> verified.
>=20
> This happens because when in-kernel module decompression
> (CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
> syscall instead of init_module to load a module. And IMA mandates IMA
> xattr verification for finit_module unless appraise_type=3Dimasig|modsig
> is specified in the rule.  However currently initramfs doesn't support
> xattr. And IMA rule "func=3DMODULE_CHECK appraise_type=3Dimasig|modsig"
> doesn't work either because IMA will treat to-be-decompressed kernel
> module as not having module signature as it can't decompress kernel
> module to check if signature exists.
>=20
> So fall back to default kernel module signature verification when we have
> no way to verify IMA xattr.
>=20
> Reported-by: Karel Srot <ksrot@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> Another approach will be to make IMA decompress the kernel module to
> check the signature. This requires refactoring kernel module code to
> make the in-kernel module decompressing feature modular and seemingly
> more efforts are needed. A second disadvantage is it feels
> counter-intuitive to verify the same kernel module signature twice. And
> we still need to make ima_policy=3Dsecure_boot allow verifying appended
> module signature.
>=20
> Anyways, I'm open to suggestions and can try the latter approach if
> there are some benefits I'm not aware of or a better approach.

Coiby, there are multiple issues being discussed here.  Before deciding on =
an
appropriate solution, let's frame the issues(s) properly.

1. The finit_module syscall eventually calls init_module_from_file() to rea=
d the
module into memory and then decompress it.  The problem is that the kernel
module signature verification occurs during the kernel_read_file(), before =
the
kernel module is decompressed.  Thus, the appended kernel module signature
cannot be verified.

2. CPIO doesn't have xattr support. There were multiple attempts at includi=
ng
xattrs in CPIO, but none were upstreamed [1].  If file signatures stored in
security.ima were available in the initramfs, then finit_module() could ver=
ify
them, as opposed to the appended kernel module signature.

3. The issues described above are generic, not limited to Power.  When
CONFIG_MODULE_SIG is configured, the arch specific IMA policy rules do not
include an "appraise func=3DMODULE_CHECK".

4. Unlike the arch specific IMA policy rules, the built-in secure boot IMA
policy, specified on the boot command line as "ima_policy=3Dsecure_boot", a=
lways
enforces the IMA signature stored in security.ima.

Partial solutions without kernel changes:
- Enable CONFIG_MODULE_SIG  (Doesn't solve 4)
- Disable kernel module compression.

Complete solution:
- Pick up and upstream Roberto Sassu's last version of initramfs support [1=
].
- Somehow prevent kernel_read_file() from failing when the kernel_read_file=
_id
enumeration is READING_MODULE and the kernel module is compressed.  The cha=
nge
might be limited to ima_post_read_file().

thanks,

Mimi

[1] [PATCH v4 0/3] initramfs: add support for xattrs in the initial ram dis=
k
https://lore.kernel.org/linux-fsdevel/20190523121803.21638-1-roberto.sassu@=
huawei.com/



