Return-Path: <linux-integrity+bounces-6063-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EBAA1B23
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 21:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097689A8431
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861E241679;
	Tue, 29 Apr 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HvtvWtKc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E551E89C;
	Tue, 29 Apr 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953632; cv=none; b=aqcVn3MjnMl25WWVLEj+nMFUmdxWjL3MweRNLlEOQgqiL+hmveoVqyhdOWjcfl3oljcNKqk3F6EWix36Oq7FvszU0iuqAyA2neziY6/3zewu7iWm9+q3hqunW8pwKwoKxmw028LLgjfgvNUVBFQ5d1rp84q3ocwhF/KZOuaBmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953632; c=relaxed/simple;
	bh=sShgxYQ9vlbExuc+kXWpWMypB/PTyaHgBmXQHeNO3jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBZ9aqRd+C93htw9htxwsTvhRDMxtw5j0Crp9Ms7w+/U9kJHzHQ3hOJ0UFOkwQ/R1MR+IZMeHGte4Ut11DwPc0eRoQxu++xhikjgDRgiZnFs9r5KTaAYmo0iW2xjYCiglr47dx8lSNur53trfZU1OYIlaIQDbF8bJ0ca0+GKMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HvtvWtKc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAenNe009168;
	Tue, 29 Apr 2025 19:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BcdvBr
	LiMDKoqa0VIJPRb3jP4UHmfILg+1l8AjaUNbs=; b=HvtvWtKcFJJNZw014msRTq
	MkAdjBfB/y4F4t+e/3JgIOqeqbof4mKM1Vw8QtrAEPACu4muXcda9gL4QFCpQcjz
	/x6YrHsRHmCnpVH0MzY7rRLXDwV4YLuTTvk1Zq+Tlzf8BDUX2IV9xBCrC8Ws0J9v
	puX6jmOt2T329Fn4a20Mrw8L1Q49+bDRKwsD/4wT6da0lhMV4YDo/SzbPQS97xEM
	BBTAoeNJ/ZmpcRyxk9ZZmLccRfvp3vpSHMJq/KNozzq1oxGPCf021a1l7bO/4O/K
	zd2GmLZnDKePv4U1DlhBlXBkYRZZU6HRG5GPHewkEmnqi+xrKggGIS2bImj6ucGA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46aw7t2b90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 19:06:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53THkVd8000644;
	Tue, 29 Apr 2025 19:06:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpcpcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 19:06:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TJ6hND33686132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 19:06:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC9A5806A;
	Tue, 29 Apr 2025 19:06:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1636D58054;
	Tue, 29 Apr 2025 19:06:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 19:06:40 +0000 (GMT)
Message-ID: <f9652da1-78a5-443c-9893-41d76007a974@linux.ibm.com>
Date: Tue, 29 Apr 2025 15:06:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 8/9] ima: make the kexec extra memory configurable
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-9-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-9-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0MSBTYWx0ZWRfXyad5O9YWwMKl pUFSHK2yC1IOa/JgQKLEdsmOsR+BNqvkBpH01TeKIUaE7Bkuk4AGHpaLb9PMlvWn8BhT8otYRnc E4lr0zQDqFqGomUv5o/1w0XhzSFM2c9pcCpqAvwFnHSfbjiugCiCOgL151is4jM/3dubNr6m6bt
 u1Aow/jJhXp3ZMJxUVsvJZUPXEw2+JBG+w2Avjz6/Fne7WoYpXuc5cv6gPlRBLcnqBDpXYTccAE AK0xMZUdULeNcLUiaCTXx83VXRLykgvAGY/559WQeFwOvXi7NeMqe7vv2a3Ki+jVtRijGURpC04 TNtfgD5QtJfIxE0ajrHiTeHifdT9vwS2IbWfdR69HRZ8+nEyucVKWijWEURl2kMHEd7lolWM8Fu
 LFl1nw3R0jvB4IyR1ld2BN6NekvwAOtTyCPuL0IXZoIrVL5xJmFdfKYfMMOZ6C2IG6787kO2
X-Proofpoint-GUID: V9bKG-VWG5fqWmJX5LxLxIWb4oltzlFi
X-Authority-Analysis: v=2.4 cv=MJRgmNZl c=1 sm=1 tr=0 ts=68112345 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=d6lEWhlZ57pmn9SoDCoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V9bKG-VWG5fqWmJX5LxLxIWb4oltzlFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290141



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
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
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   security/integrity/ima/Kconfig     | 11 +++++++++++
>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>   2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 475c32615006..976e75f9b9ba 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -321,4 +321,15 @@ config IMA_DISABLE_HTABLE
>   	help
>   	   This option disables htable to allow measurement of duplicate records.
>   
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int "Extra memory for IMA measurements added during kexec soft reboot"
> +	range 0 40
> +	depends on IMA_KEXEC
> +	default 0
> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value of 0, an extra half page of memory for those
> +	  additional measurements will be allocated.

If you have an IMA policy taking quite a few measurements and you are 
fast after reboot to log in to initiate the 'kexec load' (While system 
is still starting up), the system may end up with loss of measurements 
very easily if the default is 0 and pages are small. -> Set the default 
to the max? Also, would we expect distros to all go through the new 
config option and choose 40 or will they likely leave it at 0?

> +
>   endif
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index ed867734ee70..d1c9d369ba08 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -118,6 +118,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>   				  .top_down = true };
>   	unsigned long binary_runtime_size;
> +	unsigned long extra_memory;
>   
>   	/* use more understandable variable names than defined in kbuf */
>   	size_t kexec_buffer_size = 0;
> @@ -125,15 +126,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	int ret;
>   
>   	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>   	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_memory = PAGE_SIZE / 2;
> +	else
> +		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
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


