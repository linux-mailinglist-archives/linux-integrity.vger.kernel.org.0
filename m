Return-Path: <linux-integrity+bounces-1358-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8385EB68
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 22:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA111F2279A
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471F126F2A;
	Wed, 21 Feb 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YyT8QR/K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C283A1F
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552373; cv=none; b=C9dcqdQAcd0wmdeBFlIox0EaiTa9bdcofEgFrmK0PkorRiGYN17JIZ4QKCT08bq2ONwy/GMYGTertJ2lRO48x1ekqmd6HVa5PMyAg1O7b604FZdzJpKU9s54Ok75GsLpiSXGxiKCU/jcbZLKg3+r9kvuJDxel+rI3+3rrcmguyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552373; c=relaxed/simple;
	bh=+ZC9+iF75snfd/xPCnOp8+MHpL8blh4xmxophRxdde4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=KnIh3fnd1gaFN22dt/tp2EX9d2SWg+5yVZUfl9Tfu11BAUOcO+dhUMTorK3473LKiJN1WozbSYjqwLL/czJRZu7Bnda8cLgqtKDYgPJJ4m+GIfih5g046r8CtTMVOqXZkaZE1ZXMGxbbzW7GcBBbFOW4w8iaFCaclAtcJD4UqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YyT8QR/K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LLc9aL029654;
	Wed, 21 Feb 2024 21:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hPklnWNvH4Hh82OPtREJD31DChKxWmRmIvjYQSw71jk=;
 b=YyT8QR/KedplJa9QizKmFoZae45a8LFJAXx8BBn1W0+ahKVoFD3t6Kh8EAZXN7vyi4jY
 f/l9G5v0+XK7x+/bA5QoDxgjs3IQLX/dBNxHFKYVx659DTo6JrCRm63Jp4sDtilUc/hd
 LxG8skkW2phZHnlQ8GAB+i9NmNX3bznrmiNSILVf+qwfGUvC5jF03R20RcuYem15tHwh
 pUk2gjMWa7gO7z/QRS7CkeJcz141PF5DG68DleTE3h6AN6HT4fpx02c84C5g+QasSqtJ
 2vFrnW2biMPk6xrsz+SP8+qnx2oEdLbKO/s6PirPads/G4Dr76+rm33UWAOUVoDkKUI4 Fg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wds8mr7nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 21:52:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJAwmX003620;
	Wed, 21 Feb 2024 21:52:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ttaq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 21:52:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LLqLIK45220122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 21:52:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBD685806F;
	Wed, 21 Feb 2024 21:52:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF03458071;
	Wed, 21 Feb 2024 21:52:19 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 21:52:19 +0000 (GMT)
Message-ID: <c19a84a7bf2f8313540eacdb2047ca5083dc8c1f.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stefan Berger
	 <stefanb@linux.ibm.com>, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 21 Feb 2024 16:52:14 -0500
In-Reply-To: <6c7158ef-2b12-4ba4-afc5-7618357d3aa4@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
	 <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
	 <6c7158ef-2b12-4ba4-afc5-7618357d3aa4@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N8A7nTplZfW8oLbWDsnXBItDzvgv0Jnj
X-Proofpoint-GUID: N8A7nTplZfW8oLbWDsnXBItDzvgv0Jnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210171

On Wed, 2024-02-14 at 22:55 -0800, Tushar Sugandhi wrote:
> 
> On 2/14/24 12:47, Stefan Berger wrote:
> > 
> > On 2/14/24 10:38, Tushar Sugandhi wrote:
> ...
> <snip/>
> ...
> > > +void kimage_file_post_load(struct kimage *image)
> > > +{
> > > +    ima_kexec_post_load(image);
> > > +}
> > > +
> > 
> > We get this here at this point but it disappears later -- missing header?
> > 
> > kernel/kexec_file.c:189:6: warning: no previous prototype for 
> > ‘kimage_file_post_load’ [-Wmissing-prototypes]
> >    189 | void kimage_file_post_load(struct kimage *image)
> >        |      ^~~~~~~~~~~~~~~~~~~~~
> > 
> > 
> Thanks Stefan.
> I was also getting it. 
> But couldn't figure out why. And I was puzzled why it was going away.
> 
> Since kimage_file_post_load() is called from the same file in patch 5/8,
> I don't see a need of declaring it in a header file like 
> include/linux/kexec.h.

Before trying to "fix" it, is there a need for a wrapper around
ima_kexec_post_load().  ima_add_kexec_buffer() is called directly.

Mimi

> 
> Making kimage_file_post_load() local static resolves the warning.
> But then it throws "defined but not used" warning. I will have to call 
> it from kexec_file_load syscall in this patch (4/8) instead 5/8 to 
> resolve that warning.
> 
> I will make the function a stub function in this patch and
> make it call ima_kexec_post_load(image) in the next patch to avoid any 
> potential bisect safe issues.
> 
> It aligns with the goals of patch 4/8 and 5/8 anyways.
> 
> +static void kimage_file_post_load(struct kimage *image)
> +{
> +	/*
> +	 * this will call ima_kexec_post_load(image) to map the segment
> +	 * and register the reboot notifier for moving the IMA log at
> +	 * kexec execute
> +	 */
> +}
> +
> 
> 
> @@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
> int, initrd_fd,
>          kimage_terminate(image);
> +    if (!(flags & KEXEC_FILE_ON_CRASH))
> +        kimage_file_post_load(image);
> +
> 
> ...
> ...<snip/>
> ...
> 
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Thanks for the tag. I will apply it on the next version.
> 
> ~Tushar


