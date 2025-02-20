Return-Path: <linux-integrity+bounces-4935-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0E6A3E0AE
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 17:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA10617C480
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7AB2045AB;
	Thu, 20 Feb 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V63/MU68"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECE20D4E5;
	Thu, 20 Feb 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068653; cv=none; b=fe+VGT/wI1AM77UdujX1qMBsvpm3wffB6Vxygk3B7/7aOPfvEJKEDy+Cf5moANEKZRARB/HpsEhIG0sgtHMk8OMbSdVthD2YUpRDUZ2CQzgvxm9vHxzBQ9FH3sCqSNMW8mNhJ06cUnxZ/Qh4xUnxBBQfSX8/G/+9nx+MDKjVxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068653; c=relaxed/simple;
	bh=+/6yjCYYDC/vx/Xl0epM+sZBCKo21xZL+bewavcyoUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rV7sPc3+9shaVLV165t4n7ce0+3dL8hFJT3VnD6yAqb8/VXe1RgPpmjCMuT6NTCU4snIFSEbtbbfaGT1Tg+EQWDJ76E1U15/ULee1ydkpY5k0amvKLwzvatFKVmS/iT3qkhlHwruK7I/5Wm5FBq73BR1y94DwxWPs0D0VR0+tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V63/MU68; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KAVe4o023220;
	Thu, 20 Feb 2025 16:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VzLAvJ
	4OFYe9FsbbjKeRVznanRJha9P7le1bYv/dDM8=; b=V63/MU68CqnbjiETxInFou
	dDQUV6roS0RmVkfOv/FI/QdZU0BBipbmj6Zvc0Qg1oCxWEKy+RKKqCVfdru1LsGN
	KQGLTR48fGHSSBs4p5pnkoelmmzIz1+nWX6wtFAHVr6rjvliGTuJH3VIaGlmK5iq
	sCvDAmltgDQgM5vqLl7rwTqyAYxiY5ZUraI7EbHMYS5NKYEj87nsRHlxHjMXAH2D
	5TtepDr4db8xh6ZtTXZ2QyzB0/HaXRfKaeuSnrGhsUmaXnvaZ/VbZ2R9wmdqBRNB
	68K0xvt1P6eb6XVXfdRdeFTxx2fKHNCyNfUbcEjUjcLHzBugcC4MLBr4k2pII7Hg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wu80bxtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:23:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFHavG005817;
	Thu, 20 Feb 2025 16:23:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xjwwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:23:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KGNZbY22544992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:23:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 827F05805E;
	Thu, 20 Feb 2025 16:23:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65CE658051;
	Thu, 20 Feb 2025 16:23:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.68.26])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 16:23:34 +0000 (GMT)
Message-ID: <241e6b5336d1dcee751cb35554e507e552563a16.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        steven chen
	 <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 20 Feb 2025 11:23:34 -0500
In-Reply-To: <58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-2-chenste@linux.microsoft.com>
	 <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
	 <58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com>
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
X-Proofpoint-GUID: jLH567s1uVFEACBTyWlJqrwhOXCg8KrD
X-Proofpoint-ORIG-GUID: jLH567s1uVFEACBTyWlJqrwhOXCg8KrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=478 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113

On Thu, 2025-02-20 at 10:04 -0500, James Bottomley wrote:
> On Thu, 2025-02-20 at 09:53 -0500, Mimi Zohar wrote:
> > On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> [...
> > > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >=20
> > Steven, thank you again for picking up this patch set.
> >=20
> > As previously explained, there is no tag named "Author" in
> > https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> > .=C2=A0 To give credit to the original author use "Co-developed-by".
>=20
> Just on this, only use the co-developed-by if you actually *modified*
> the patch.=C2=A0 If you're just transmitting the patch unmodified you can
> give original author credit by including a=20
>=20
> From: original author <email>
>=20
> Followed by a blank line at the beginning of the email.=C2=A0 That makes =
the
> git author field contan whatever the From: line says.=C2=A0 You still nee=
d a
> signoff from yourself in the original patch because you transmitted it.
>=20
> Some people also consider minor modifications to be insufficient to
> disturb the original copyright ownership and simply document what they
> did in square brackets under their signoff, like this:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Db5d1e6ee761a109400e97ac6a1b91c57d0f6a43a

Originally I had said:

   > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
   > Signed-off-by: steven chen <chenste@linux.microsoft.com>

   Before the "Co-developed-by" tag was defined, it was implied simply by t=
his ordering
   of the "Signed-off-by" tags.
  =20
   For those patches you didn't modify, simply import Tushar's patch with h=
im as the
   author and add your Signed-off-by tag after his.

Thanks, James, for the explanation of using "From: original author <email>"=
 to force the
author to be Tushar.

Mimi

