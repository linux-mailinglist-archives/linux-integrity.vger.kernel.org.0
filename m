Return-Path: <linux-integrity+bounces-4660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F5A20CCC
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84113A1EBD
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C081AA1D2;
	Tue, 28 Jan 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hRpa9Xqy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9726AFC;
	Tue, 28 Jan 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077585; cv=none; b=tv72uQpKbT7DGBAqChZnAoTElSquHFYelXpYbAcS1mbSt8195aB5M5MZGLtKjGYAFB2628dcc8aO+KOnO8ioE3o8+VyqGUjwIn/mzJFxr60+jsmnpT33AoNLDQ0CLIfZ46qTblhjrdIX9W+QR/qqrUgTMVB1UOY1diUpJ8jodYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077585; c=relaxed/simple;
	bh=aZTk+EdZVUvpgX4KheAtSHXpn/XBugvRKLCVLZnl9PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTR/ZH1BgvxyaO7t5JIGES7s9HdNXHlQTi8pGKS+bc0vcMh7/g42Y3+UW6IlQIKV5f2dq99OGvE3UMHzyta2BllQ3czSPlV1AMBHSDwX1YotPFj1fWWT7m5mTPMYLJ40WFzRmqzrdvXsoHHQnYYsga8HtdD2PJB5jGmz7Spc3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hRpa9Xqy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SF1dFa007167;
	Tue, 28 Jan 2025 15:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ah9tcl
	E6JymIrvAtL3IV/RB05PBSoEi3oi2a5Yi2/8c=; b=hRpa9XqynAg4CkvYXqshpP
	U/55Uk+ztRZ2/NjMMeqFPYVsL5vxI2FZ1CcWWEKAh3b1nXTDj+UCptcit1d4Nsjz
	+/JpUU/5tMalPiz3bbwb23um7gyqeCVRI1AoLbghNvL6eyXytRD83DN66pHIMZjx
	s0azrU7Ke1EBGC0mpV57FW3Uh7PxvK2TiGqa0blJIonCr9/SK7mUQ0R8pYV1Vpvt
	4kIO7BGmFcNvRSUxw/NoTbz7X6Zr0DuB74MMwYCn4U5n4irryZAs0Ps6mGUsnpY4
	UIk9ysNpR2OY3t2p5OiRr3M7Fvd+fmCMVPG62P3qG4L7GxbnRdNdX8i8iGER5MKg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44f1gyg2g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:18:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SE1mfW028042;
	Tue, 28 Jan 2025 15:18:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskbrwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:18:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SFIQLN58524148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 15:18:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96FA15805A;
	Tue, 28 Jan 2025 15:18:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BCFA58054;
	Tue, 28 Jan 2025 15:18:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 15:18:25 +0000 (GMT)
Message-ID: <d127dad9-e392-49ef-af52-a7bcdaebe317@linux.ibm.com>
Date: Tue, 28 Jan 2025 10:18:24 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] ima: make the kexec extra memory configurable
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz,
        eric.snowberg@oracle.com, paul@paul-moore.com, code@tyhicks.com,
        nramas@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
        madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-7-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250124225547.22684-7-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lSgfFBIZTbiY2seeiZCL1eP9-RVbVnlj
X-Proofpoint-ORIG-GUID: lSgfFBIZTbiY2seeiZCL1eP9-RVbVnlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280111



On 1/24/25 5:55 PM, steven chen wrote:
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hard-coded as half a PAGE.  Make it configurable.
> 
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.  Ensure the default value of the option is set such
> that extra half a page of memory for additional measurements is allocated
> for the additional measurements.
> 
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hard-coded one.
> 
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>   security/integrity/ima/Kconfig     | 10 ++++++++++
>   security/integrity/ima/ima_kexec.c | 16 ++++++++++------
>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 475c32615006..7dd2ed8b2cdc 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>   	help
>   	   This option disables htable to allow measurement of duplicate records.
>   
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int

int "Extra memory for IMA measurements added during kexec soft reboot"

Without the description I wasn't able to modify the value.

> +	depends on IMA_KEXEC
> +	default 0
> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value, an extra half a page of memory for those
> +	  additional measurements will be allocated.
> +
>   endif
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index d5f004cfeaec..c9c916f69ca7 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -128,22 +128,26 @@ void ima_add_kexec_buffer(struct kimage *image)
>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>   				  .top_down = true };
>   	unsigned long binary_runtime_size;
> -
> +	unsigned long extra_size;
>   	/* use more understandable variable names than defined in kbuf */
>   	void *kexec_buffer = NULL;
>   	size_t kexec_buffer_size = 0;
>   	int ret;
>   
>   	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>   	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_size = PAGE_SIZE / 2;
> +	else
> +		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
> +
>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>   		kexec_segment_size = ULONG_MAX;
>   	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>   	if ((kexec_segment_size == ULONG_MAX) ||
>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>   		pr_err("Binary measurement list too large.\n");

With the changes to Kconfig:


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


