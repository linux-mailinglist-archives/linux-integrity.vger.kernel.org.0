Return-Path: <linux-integrity+bounces-7763-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B517FC9CBB7
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Dec 2025 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1883A2FA6
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88196279792;
	Tue,  2 Dec 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KVeg7Lyi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060F2D3A6D;
	Tue,  2 Dec 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702736; cv=none; b=cWbueN+QXkYyYK4UXUAM/c7wxadeQn7PX4niC8x5ba5IQIc/wFwwxqFNX1EpgBr6Yg5+jo+7eyMEBmBHsBWplUvTKPY5wtRWqXWA6JSUZGuv8RpvB5S4zwXJ8dO1z5b7EffI5dh1BmMk+BrXy4rgz+i1sxbsqiqwXuE8Vu3PSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702736; c=relaxed/simple;
	bh=eDVVe55xwZE59QQyC6xjXYbLeU/TO6qnG3VQfQxXCz4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KwbeEbEb1RzHMu22Gi03+6MRrfX6bSxQX5tjYRvhFKTjI9tMLXpfDgDgfJLKREIqkQNC9hcOe3ES38MHn2iqrKTxBGVJR6WYDuF0if9UU6LfZxyz3YYJx681/WKchyAPKibscnOQJClZ+ZQx9KFv50V0Fx/sGb940qteY2/tcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KVeg7Lyi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2ILF4Y012995;
	Tue, 2 Dec 2025 19:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oYgYLC
	n8hz68eytzRPHE6tlX29tM2LkBnQ+hzDM5p/4=; b=KVeg7LyiEPiiYmDL3GyYpX
	k2h4BcavvmE2nn2iUkmNUdJebX0ZdcoGStGAyALPSXcsF9aB9Inx0AzqlGLi/nc6
	vMn8nqoUvmCWnkZ/myUNZTDB6k78jxxu6uS9bzfItvbyMKCZeAYk71Z1lIQIXIWC
	/hJmsmeGS0r5smGeXdtc5xtMAPxIgco9FIcGNBGz0rl817QmPn4ZP89YZIVYKtxT
	DJp6l/ysfh3Mxl6pbfxzi++dxDvHoTVADLZnWl6nMK5hgrAgabX6IWujWUO7/NgQ
	snC1w1P659NEGvP6ny6X70RL5rFNvOn4hRbKbgFeRLhCOBhKRMG6Ad159jDV0NeQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh6xx1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 19:11:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B2JBiwo014633;
	Tue, 2 Dec 2025 19:11:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh6xx1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 19:11:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2I8IUU029323;
	Tue, 2 Dec 2025 19:11:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1dxfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 19:11:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2JBgop18023148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 19:11:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5068D58061;
	Tue,  2 Dec 2025 19:11:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F6658053;
	Tue,  2 Dec 2025 19:11:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.103.34])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 19:11:40 +0000 (GMT)
Message-ID: <93bd3c308c79414b3c620216b20d5962fcaccd15.camel@linux.ibm.com>
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar
	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>,
        Jiri Bohac	 <jbohac@suse.cz>,
        Sourabh Jain
 <sourabhjain@linux.ibm.com>,
        Guo Weikang	 <guoweikang.kernel@gmail.com>,
        Joel Granados <joel.granados@kernel.org>,
        Alexander Graf	
 <graf@amazon.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Jonathan McDowell	
 <noodles@fb.com>, linux-kernel@vger.kernel.org,
        yifei.l.liu@oracle.com, stable@vger.kernel.org,
        Paul Webb <paul.x.webb@oracle.com>,
        Roberto Sassu	
 <roberto.sassu@huaweicloud.com>,
        linux-integrity@vger.kernel.org
In-Reply-To: <CAMj1kXFDAypcEAAFw=O6pS5zD5aujXUvo3_95p_2fJiESsSmgQ@mail.gmail.com>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
	 <633a35b8-207b-4494-9a4e-24706abd3990@oracle.com>
	 <ec3c1b29004d1be28563b20765d6a06ccdf18db5.camel@linux.ibm.com>
	 <CAMj1kXFDAypcEAAFw=O6pS5zD5aujXUvo3_95p_2fJiESsSmgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Dec 2025 14:10:47 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=692f39f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=1KjwhN56EputrNbQnIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9EjezgUYTiO_zg4OtrA9pQ0oVfBx9_5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX18KkaWdTbhQY
 vyYxVuiRE9bUVO9CqD9MWexyweG4aPK5JCZGpMTHplVJq/nVwZ95LxGcmeMUSQYHKEVx2SXYCI4
 q0zwd6+VOa6MQ/qDp3k7KCzpMGemQCkrzSpCJfPtXZYNTuD6yGoE1yzCGSCNwEJdyAwZe4uwjla
 6vKGKIdMR/gepwZAVXtSt+mzCNuka1rStaSwzQr+LtOEqgGGdkuf179vwRpNnAWPkNMPsKb9W7j
 i+hKKJd7Ytf1FxtPbvppijnkkUyWwELXVFgMi2+kp3ptZF8PdKS9ALd7tuGWdpvCC1CJeV96GdN
 NpUSHlQ0sfXdz4hsneysmBjO60jY45+XJ8fZF2qttQcRCUIVqmQIyBxOw5LsBFyfv7m7EfEJ6js
 ctzJdP7k8jvERuG5p814fgo0GSiVjA==
X-Proofpoint-ORIG-GUID: BGHL2Pr0oHLb-s7qDfC24XX0Orp3mXtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

[Cc: Roberto Sassu, linux-integrity]

On Tue, 2025-12-02 at 08:16 +0100, Ard Biesheuvel wrote:
> On Mon, 1 Dec 2025 at 22:43, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >=20
> > On Mon, 2025-12-01 at 15:03 +0530, Harshit Mogalapalli wrote:
> > > Hi all,
> > >=20
> > > On 13/11/25 01:00, Harshit Mogalapalli wrote:
> > > > When the second-stage kernel is booted via kexec with a limiting co=
mmand
> > > > line such as "mem=3D<size>", the physical range that contains the c=
arried
> > > > over IMA measurement list may fall outside the truncated RAM leadin=
g to
> > > > a kernel panic.
> > > >=20
> > > >      BUG: unable to handle page fault for address: ffff97793ff47000
> > > >      RIP: ima_restore_measurement_list+0xdc/0x45a
> > > >      #PF: error_code(0x0000) =E2=80=93 not-present page
> > > >=20
> > > > Other architectures already validate the range with page_is_ram(), =
as
> > > > done in commit: cbf9c4b9617b ("of: check previous kernel's
> > > > ima-kexec-buffer against memory bounds") do a similar check on x86.
> >=20
> > It should be obvious that without carrying the measurement list across =
kexec,
> > that attestation will fail.  Please mention it here in the patch descri=
ption.
> >=20
>=20
> Couldn't we just use memremap() and be done with it? That will use the
> direct map if the memory is mapped, or vmap() it otherwise.

No, the IMA measurement list is not a continuous buffer, but a linked list =
of
records with varying types of fields and field sizes.  The call to
ima_dump_measurement_list() marshals the measurement list into a buffer, wh=
ile
ima_restore_measurement_list() unmarshals it.

--=20
thanks,

Mimi


