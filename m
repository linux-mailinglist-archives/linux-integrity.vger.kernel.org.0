Return-Path: <linux-integrity+bounces-5951-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3B9A9522C
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756293B447B
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A381266B5C;
	Mon, 21 Apr 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QTwNh/ZX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05126461D;
	Mon, 21 Apr 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243849; cv=none; b=F8ho9/8zqjm3TWAo97/65gbuo4NA4veRMljc5tqc6yyqeXMN+OSynhlMiFc0MO4l5SHt3HhAPqoDnC8UXInNIQjNRLgfoFpXn6NwOkNdhUPdDAOi2hdW8hGwQnqDY62brgN8C5l+taMhTJBpzLraIQRB3FbTsEK/Spbzd0FHH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243849; c=relaxed/simple;
	bh=DpxM/W3KLOT0bOG1M5mF2m7TOzys32pjRdcAJGXvzAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFOd4A8ZuLBsTCnnh31i93gTHeyqI/ssSJqW49R1ZDYfM1uawaTBaQrRJuN4XYrsqa/BHBF5FuSuUrUXeYPeNEKx27Z2KRcEWoKn4eY0ZYcrk9LahAGaOhfmoslesneIEWP08+MvR+7g7VNl4reiVQBPx4CiInxi8IbOVgIHsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QTwNh/ZX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LDE7gR022026;
	Mon, 21 Apr 2025 13:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LDiMB+
	IB9Epa4dk82xsNeI+gtOGLk4hDJ+02LRGwKvo=; b=QTwNh/ZXLAGNHoAyMQutNk
	ar1WOjVOVejBnDHeShFphwHHmTZq2dMry4zuiEH94Xgz8vwASgyXMxAz/5eu7lgy
	B3OAs7OF4esG1bYR7a8vC6UmaCuKYuwQAuUQ4bhCW/+VDQDPxw5a/vt3F/vJsH0j
	xg1+0uectaFrJZB6nbrCDcAQulE9HcfMBUMroAYB5Pk00AF2gIGWlc7UuyXIw69h
	eTgKoZWL0siS40KvW/LYkP560YSK8d3pfk+YYph5rBGhJiVbcyj7ofYy+HUjQRGs
	gYMFRWb5DXNXod3ZfPJQRU1yOj0XPCYyWBe0Dw5Ok6oeVk8R/Us6FHVN9MhZDaOw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46592vb1ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 13:51:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCFC1Y015377;
	Mon, 21 Apr 2025 13:51:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464qnkeetj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 13:51:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53LDpprL23790238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 13:51:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0D858055;
	Mon, 21 Apr 2025 13:51:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 887B658043;
	Mon, 21 Apr 2025 13:51:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.21.104])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Apr 2025 13:51:50 +0000 (GMT)
Message-ID: <dcde124baec01318e661f5430ce8a008a6d196c0.camel@linux.ibm.com>
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap
 segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, steven chen <chenste@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Mon, 21 Apr 2025 09:51:50 -0400
In-Reply-To: <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
	 <20250416021028.1403-4-chenste@linux.microsoft.com>
	 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
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
X-Proofpoint-ORIG-GUID: PCNqx9-9ZgpGycN3Ym2BvbFni4szNvPA
X-Authority-Analysis: v=2.4 cv=RorFLDmK c=1 sm=1 tr=0 ts=68064d79 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=bLk-5xynAAAA:8 a=yMhMjlubAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8
 a=LftU4j_592J91X9VZ9UA:9 a=QEXdDO2ut3YA:10 a=zSyb8xVVt2t83sZkrLMb:22 a=BpimnaHY1jUKGyF_4-AF:22
X-Proofpoint-GUID: PCNqx9-9ZgpGycN3Ym2BvbFni4szNvPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210105

On Fri, 2025-04-18 at 12:36 +0800, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
> > From: Steven Chen <chenste@linux.microsoft.com>
>  ^^^^^^

As James Bottomley previously explained[1], if you haven't made any changes=
 to
Tushar's patch, then the very first line of the patch description would be
"From: Tushar Sugandhi <tusharsu@linux.microsoft.com>" followed by a blank =
line.
If there is a minor change, you would add "<your email address>: explanatio=
n".
For example:

Steven Chen <chenste@linux.microsoft.com>: modified patch description

[1]
https://lore.kernel.org/lkml/58e70121aaee33679ac295847197c1e5511b2a81.camel=
@HansenPartnership.com/

> >=20
> > Implement kimage_map_segment() to enable IMA to map the measurement log=
=20
> > list to the kimage structure during the kexec 'load' stage. This functi=
on
> > gathers the source pages within the specified address range, and maps t=
hem
> > to a contiguous virtual address range.
> >=20
> > This is a preparation for later usage.
> >=20
> > Implement kimage_unmap_segment() for unmapping segments using vunmap().
> >=20
> > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>   ^^^^^^

Neither "Author:" nor "From:" belong here.  Please remove.

> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>   ^^^^^^^

Having Tushar's "Signed-off-by" tag and yours below indicate that you modif=
ied
the original author's patch.

thanks,

Mimi

> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Baoquan He <bhe@redhat.com>=20
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
>   ^^^^^
>=20
> The signing on this patch is a little confusing. I can't see who is the
> real author, who is the co-author, between you and Tushar. You may need
> to refer to Documentation/process/5.Posting.rst to make that clear.
>=20
> > Acked-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/kexec.h |  6 +++++
> >  kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >=20
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index f0e9f8eda7a3..7d6b12f8b8d0 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0=
)
> > =20
> > +extern void *kimage_map_segment(struct kimage *image, unsigned long ad=
dr, unsigned long size);
> > +extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> >  struct task_struct;
> > +struct kimage;
> >  static inline void __crash_kexec(struct pt_regs *regs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0=
; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > +static inline void *kimage_map_segment(struct kimage *image, unsigned =
long addr, unsigned long size)
> > +{ return NULL; }
> > +static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> >  #endif /* CONFIG_KEXEC_CORE */
> > =20
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index c0bdc1686154..a5e378e1dc7f 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
> >  	return result;
> >  }
> > =20
> > +void *kimage_map_segment(struct kimage *image,
> > +			 unsigned long addr, unsigned long size)
> > +{
> > +	unsigned long src_page_addr, dest_page_addr =3D 0;
> > +	unsigned long eaddr =3D addr + size;
> > +	kimage_entry_t *ptr, entry;
> > +	struct page **src_pages;
> > +	unsigned int npages;
> > +	void *vaddr =3D NULL;
> > +	int i;
> > +
> > +	/*
> > +	 * Collect the source pages and map them in a contiguous VA range.
> > +	 */
> > +	npages =3D PFN_UP(eaddr) - PFN_DOWN(addr);
> > +	src_pages =3D kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
> > +	if (!src_pages) {
> > +		pr_err("Could not allocate ima pages array.\n");
> > +		return NULL;
> > +	}
> > +
> > +	i =3D 0;
> > +	for_each_kimage_entry(image, ptr, entry) {
> > +		if (entry & IND_DESTINATION) {
> > +			dest_page_addr =3D entry & PAGE_MASK;
> > +		} else if (entry & IND_SOURCE) {
> > +			if (dest_page_addr >=3D addr && dest_page_addr < eaddr) {
> > +				src_page_addr =3D entry & PAGE_MASK;
> > +				src_pages[i++] =3D
> > +					virt_to_page(__va(src_page_addr));
> > +				if (i =3D=3D npages)
> > +					break;
> > +				dest_page_addr +=3D PAGE_SIZE;
> > +			}
> > +		}
> > +	}
> > +
> > +	/* Sanity check. */
> > +	WARN_ON(i < npages);
> > +
> > +	vaddr =3D vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
> > +	kfree(src_pages);
> > +
> > +	if (!vaddr)
> > +		pr_err("Could not map ima buffer.\n");
> > +
> > +	return vaddr;
> > +}
> > +
> > +void kimage_unmap_segment(void *segment_buffer)
> > +{
> > +	vunmap(segment_buffer);
> > +}
> > +
> >  struct kexec_load_limit {
> >  	/* Mutex protects the limit count. */
> >  	struct mutex mutex;
> > --=20
> > 2.43.0
> >=20
>=20
>=20


