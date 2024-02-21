Return-Path: <linux-integrity+bounces-1330-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE085E8F5
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 21:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA31C1F26E20
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE086130;
	Wed, 21 Feb 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4Cjo1wk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B52A8DA
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547045; cv=none; b=dosC1l7zrMTNPTRJVpNv6zpBQwAPZfIS0GdLcK8q6lg4Ha/eJbLu6xLxycjq8MtWcxP+pYDvDaXAg9/HsIe084HIzlgyA6CM9YywKLuY99ZvGFRavnTOOs90QTYt6CNBiXbu5BSlc3h211aXPu02zxmGm+DXCEPZTCRlSNxJX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547045; c=relaxed/simple;
	bh=iSa52No3Cmr22MSWpxwpBNC6ckZ9ZXX87g6rWf2zylQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=MG6HDACzzLbq5uagKccbiDeFTWOLgZVw8ssoCAjpxBv7V6BHL22RqjZbOimIsL67gEO5xFBFq+DMwrjImqw+QCvyeanI3gP/387bTORrJmocJI+UYKiMQR3I5COX58HVO8wHXXFIqPjYeADC+0TKf/VkfuYkgwM3Loo5YuJbYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4Cjo1wk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJdQfr010547;
	Wed, 21 Feb 2024 20:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=H0Knshgb/5Hes+ApBhBaRoQ2QNjfzNSdXlyo1Kv8i8Q=;
 b=e4Cjo1wkSqIQVEUvV5p2qSHtjW9Yiy/iW/OjXEdQpYIpHTGxX2sNGdb/dSgsI/LXM4FZ
 RzuWLma5VGB5UrsLNTsC+Krxu3sdsBdR1CrPKHZQRbSxXET8ICE5EFAscbEg8eaCxfnK
 RT8ODyHnKhs3BfPLT3vqXnLM1LuTDZBALxUOqdq7Tz2A8ujPCzPJ5WNPBLJnjg1zKb9G
 70yVeXDzwQaFkCHzXoSWpmcGFEGBMC2LVKR7RlpkoCxt5FjVB4hbgCD71RAfvuz6fJyl
 zIOYnWSwfECSwy3kkuV/t12EBPhZD9xrKDRn3m/X2++ckurMeGJav73bg41p0Wq7QkhN UA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdqh70u0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 20:23:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJ62hi003671;
	Wed, 21 Feb 2024 20:23:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tsvug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 20:23:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LKN8wb18678480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 20:23:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC355805A;
	Wed, 21 Feb 2024 20:23:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA955803F;
	Wed, 21 Feb 2024 20:23:07 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 20:23:06 +0000 (GMT)
Message-ID: <210e2579031b46afd3c8b39917ff535508d66866.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/8] kexec: define functions to map and unmap segments
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 21 Feb 2024 15:22:51 -0500
In-Reply-To: <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lw4GAElcCbfVd3gKmyerDV5udUzy05nU
X-Proofpoint-GUID: Lw4GAElcCbfVd3gKmyerDV5udUzy05nU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_07,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210159

On Wed, 2024-02-14 at 07:38 -0800, Tushar Sugandhi wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.  This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.  Implement functions to map and unmap
> segments to kimage.
> 
> Implement kimage_map_segment() to enable mapping of IMA buffer source
> pages to the kimage structure post kexec 'load'.  This function,
> accepting a kimage pointer, an address, and a size, will gather the
> source pages within the specified address range, create an array of page
> pointers, and map these to a contiguous virtual address range.  The
> function returns the start of this range if successful, or NULL if
> unsuccessful.
> 
> Implement kimage_unmap_segment() for unmapping segments
> using vunmap().  Relocate 'for_each_kimage_entry()' macro from
> kexec_core.c to kexec.h for broader accessibility.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  include/linux/kexec.h | 13 ++++++++++
>  kernel/kexec_core.c   | 59 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 400cb6c02176..3145447eb77a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -486,6 +486,11 @@ static inline void arch_kexec_pre_free_pages(void *vaddr,
> unsigned int pages) {
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>  #endif
>  
> +#define for_each_kimage_entry(image, ptr, entry) \
> +	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
> +		ptr = (entry & IND_INDIRECTION) ? \
> +			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
> +

I don't see a reason for moving this macro.

Mimi


