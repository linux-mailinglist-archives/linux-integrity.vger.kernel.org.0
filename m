Return-Path: <linux-integrity+bounces-869-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A083AB5B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11550B2227C
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1CA77F3A;
	Wed, 24 Jan 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cxCxj3TU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925C77F04
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105332; cv=none; b=HudN9IavwkmUIH0OPNZtMFGBHkKDso5qpt9r/i9XpMYDbHn9xrW6cbwBnv5vPTrYs9dT6HgqT0v7GpE70sZEgkPcYxakx+RWzoDaDDIqVucyxr1vPi2iZNTGifQB4ltq36N6gAPCT/Tppb1ylwd/ehgpCBn99a1zhOG/m9B0Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105332; c=relaxed/simple;
	bh=wcU87wv4+9o+yAst4cr2Lc4hKjTLN2XpZpo3w8bA6rA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=WeHKaajPW4j0ehA2QyID3KZhSnq2VpIaXvlU2RMT2798qTI3KMK52V1aWD0AqkNVKlSWYRCvvQ4NtVIa6LHb+4vAsRXk2qxK+NoOya/q3AHS9jscV2ERLZafYP0di3/2wa79l6mIRoqXPt69w0WChzdXV0yH5x5daEFTEP31mmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cxCxj3TU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ODbt32008712;
	Wed, 24 Jan 2024 14:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Hm3qe/jS79cJ399NwgirpWIoTXDVZz5Bk33NivrxYJY=;
 b=cxCxj3TUcjb1naT0K9v7uB3SQ80zaonEwxNvLUtkaFctwDojsLRLVjuZbXr/NOg0Haoj
 0C2m49Q8i1A+Rccg1cMmyoqYAxibksUtIgUOwxW0x2KssygBXXERmvtN/mlk0gpng5Jo
 pSAc6WaCSFZCTPVW5uMnUCk31XnYApFUefzJMajEP5pWqZRDuvQ6pwHyOYEt8EF/kadY
 i9EqkEZDWZH4I4YjxMcfmuC/y5akHR7FJ4Qh55z8ZXJMAE2kR4vxl58mJLSr1Kwfb2Y7
 JSld82Q0KrZKVENmc0fWX+AhihuQpUYDY38/YkLA7wdwatGg4esZVNim/VWdKaW1A2Kj sw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu3kprqs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:07:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40ODlOC7025637;
	Wed, 24 Jan 2024 14:07:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgp65h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:07:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OE7pEU3015582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:07:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05EB55803F;
	Wed, 24 Jan 2024 14:07:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079DE58056;
	Wed, 24 Jan 2024 14:07:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.166.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 14:07:49 +0000 (GMT)
Message-ID: <e2b67ca4e3f0869bcab683feef9b8f4ad773e38e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 24 Jan 2024 09:07:49 -0500
In-Reply-To: <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
	 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
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
X-Proofpoint-GUID: pFF5KI9rCvU2m05_bG8tCrTfE7aZfPt9
X-Proofpoint-ORIG-GUID: pFF5KI9rCvU2m05_bG8tCrTfE7aZfPt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=953
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240102


> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  				  .buf_min = 0, .buf_max = ULONG_MAX,
>  				  .top_down = true };
>  	unsigned long binary_runtime_size;
> +	unsigned long extra_size;
>  
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
> @@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	int ret;
>  
>  	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>  	 */

The memory is still being allocated at kexec "load",  so the extra memory is for
additional measurement records "since" kexec load.

Mimi

> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_size = PAGE_SIZE / 2;
> +	else
> +		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
> +
>  	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>  		kexec_segment_size = ULONG_MAX;
>  	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>  	if ((kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>  		pr_err("Binary measurement list too large.\n");


