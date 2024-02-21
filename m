Return-Path: <linux-integrity+bounces-1359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C39D85EBE6
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3AB1F252CC
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569983C099;
	Wed, 21 Feb 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b1HQ1Xjx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A43BB37
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555227; cv=none; b=Ei+eDhTY3iN9H0L+cN1gCka4pQuy5MkyfqE/si4ZdrRGoj1oV9e5MNIWUoWlLgzEBKrIopSd4dwo+u1nkJgYwef9TQNgqsHbwzyN/+F7pZ3qxMHbct7Fi9xpGVgjULFRVBvZycY2SGBPvyBXtUpQ1Wo/3dqiiuYVJ2dhyH8aQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555227; c=relaxed/simple;
	bh=Nm4vohVN2MnrdmWHCzPg0IndVB+YQ0gytqLf2qE4XJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=pmKNFnYY0pA1sgdBPiNzVHdOO9GOMWunhEU3xsR9Q/HQ0Dtp62BPpneuPoe+jdfuexP9HHKfWwo9C/dPlG73QBYRuWBPxdS9bUslJlwy0xBsIyAJdakZw6ykSp6VvF1i/hJEGfEO2xfMU8eSYRs3paydZwx2xt5JVuEWGCNTkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b1HQ1Xjx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LMNSH1001848;
	Wed, 21 Feb 2024 22:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ketIvyi/+E3D58gaoR84h46SBu1di8pPAkKAB+63l38=;
 b=b1HQ1Xjx/QBMQ0vSoMxaNenCSTVexipyrVqTbgqRKvp4rC2Px/JzK8k8TVlF6Y42i/Ut
 o3VSPK0iyHv3IEOt9fmsAT+Wde3h/HCuD5j0D95nMWhlpE7Fsrq38Ah3+D0qG8NkRthn
 u7TNFYTzWVse/wWgqnHiE+9RlMyTYJr0O4zoTDlOxeTunJnudUz+TPVAmiiNXAMxxEk3
 5mBPGGhZY3wXNqmd/mFo18N6Vyzm2HgSV34X7jVb9VKXCe83Rh2rOfqXdbCsyxCCbqwg
 tkqu3RY8cB3U34bFCE9L+tKqQXGAtmJFi6oFqbThs/Gbcm0MG4xmdhwnqQVeRf38YRUS qw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdswy8ers-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 22:39:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LLWSAI031117;
	Wed, 21 Feb 2024 22:39:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bm1uq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 22:39:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LMdoBX13763192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 22:39:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AAE458060;
	Wed, 21 Feb 2024 22:39:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A26D35805A;
	Wed, 21 Feb 2024 22:39:49 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 22:39:49 +0000 (GMT)
Message-ID: <1bad88f238452bd2b86cf549ed8b7a4727795bfa.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 21 Feb 2024 17:39:34 -0500
In-Reply-To: <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
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
X-Proofpoint-GUID: khDHV2CKQKPs6IfsFba0cPIpBIXQYkQC
X-Proofpoint-ORIG-GUID: khDHV2CKQKPs6IfsFba0cPIpBIXQYkQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210178

Additional comments ...

> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index ccb072617c2d..1d4d6c122d82 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
>  #include <linux/kexec.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
>  static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
>  
>  static void ima_reset_kexec_file(struct seq_file *sf)
>  {
> @@ -184,6 +188,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at
> 0x%lx.\n",
>  		      kbuf.mem);
>  }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb = {

This should be defined as static.  update_buffer_nb should be prefixed with
'ima_'.

> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */
> +void ima_kexec_post_load(struct kimage *image)
> +{

In ima_alloc_kexec_file_buf(), the buffer is only re-allocated if the size
changes.  Here there doesn't seem to be way of detecting a size change.  At
least, add a comment here indicating that kexec 'load' may be called multiple
times.

Mimi

> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer = NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer = kimage_map_segment(image,
> +					      image->ima_buffer_addr,
> +					      image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Could not map measurements buffer.\n", __func__);
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered = true;
> +	}
> +}
> +
>  #endif /* IMA_KEXEC */
>  
>  /*


