Return-Path: <linux-integrity+bounces-861-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB77E839935
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2C9B2C993
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 19:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E6282F1;
	Tue, 23 Jan 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A3Fvr6Zj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2B823A8
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036610; cv=none; b=VUDik+GC21oGy2GdeY4cOGYNPEoA/x43RlurVMfA41ejfEmuNwTVpAl7fUWL+RbBnXMDOntgDlnT2IjbacZQVKZ1OgKoKdVg6nlQ5hWMUNPWzjjmtLlOoYZ5+tXF7oq5OZN8PoH3diqogubQpgmYcZvEg32jRTwWbzlfXgjEqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036610; c=relaxed/simple;
	bh=HKYS7CEE4ZuvhNNzxhrRodznnh/T3W64WUMLkP/IaGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYVciM8dJ0sSo+y8KwKwtpSG/SHeaWpaYLuPuqjLKUQa+oYpyGQI/cLSzrfOkdqQuaIjyS092spHN46vPUhgk/IMME0eNBLxMFQwqInDJ98oElmN+VGLu6bfVUG48vwuVm6WkU85RgPcIhpLTINdOkY+f9CNPZyR7PdwK2r4fgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A3Fvr6Zj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGwJqY000656;
	Tue, 23 Jan 2024 19:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JK5lMxxygQKHGNpO1+U35W2pP+d1B2vDDpeyY2lyhx8=;
 b=A3Fvr6ZjWA7AamnKNgTW3Jm64GRZMphHLWce/5ffEGD/RJgONksGZW5lQGICzKIDWcj4
 D2UFDE67I7o7WPOB/afo5Gv4w2F3o/XrPYLHP+E3h7+cNM5v8D9Pg3gl65yeiUB/ASnO
 3S0Y63rH7gvZn5+Mop+lq0hcaLpGOk0XqpKL9wX7U6CXXzDo4jSsKuppcp1tgyVOxrWH
 yHQ+zJ1E7GFqDeCqJqfUrvW7Ul4OBemRPJtgJL/v6GW0mYIK9McngRp89wYOdkoC0IvU
 zvDjaMZ4HrsU7JzmGue1RFJC5pY2teeo/lxCO8iWJuii6LdMww2ZTL7oRDWptYThninX mw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vthep349p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 19:02:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NHPoOw010877;
	Tue, 23 Jan 2024 19:02:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrvys8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 19:02:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NJ2sgI17367790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 19:02:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E85F55805E;
	Tue, 23 Jan 2024 19:02:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF95658058;
	Tue, 23 Jan 2024 19:02:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 19:02:52 +0000 (GMT)
Message-ID: <bdf8c31a-59db-4568-ad7b-e2b3f36c3836@linux.ibm.com>
Date: Tue, 23 Jan 2024 14:02:52 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vwjKtMi9Mx8ceRK3VXB3wsrLpGOHrxn-
X-Proofpoint-ORIG-GUID: vwjKtMi9Mx8ceRK3VXB3wsrLpGOHrxn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230141



On 1/22/24 13:38, Tushar Sugandhi wrote:
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hardcoded as half a PAGE.  Make it configurable.
> 
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.  Ensure the default value of the option is set such
> that extra half a page of memory for additional measurements is allocated
> to maintain backwards compatibility.
> 
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hardcoded one.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/Kconfig     | 11 +++++++++++
>   security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 60a511c6b583..fc103288852b 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -338,3 +338,14 @@ config IMA_DISABLE_HTABLE
>   	default n
>   	help
>   	   This option disables htable to allow measurement of duplicate records.
> +
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int
> +	depends on IMA && IMA_KEXEC
> +	default 0
> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value, an extra half page of memory for
> +	  additional measurements will be allocated to maintain backwards
> +	  compatibility.

Is there really an issue with 'backwards compatibility' that the user 
needs to know about ? From looking at the code it seems more important 
that a bit of additional memory is reserved now to fit the kexec 'load' 
and 'exec' critical data events but that's not 'backwards compatibility'.

Also mention this as a guidance on either how kexec load+exec need to be 
used or as a hint that it may potentially require a lot of memory? :

The amount of extra memory that is necessary to carry all measurements 
across a kexec depends on memory requirements of the measurements taken 
between the kexec 'load' and 'exec' stages. The more measurements are 
taken, the more extra memory is required. Large amounts of extra memory 
can be avoided by running kexec 'load' and 'exec' in short sequence.

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index f26b5b342d84..c126aa6494e9 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>   				  .top_down = true };
>   	unsigned long binary_runtime_size;
> +	unsigned long extra_size;
>   
>   	/* use more understandable variable names than defined in kbuf */
>   	void *kexec_buffer = NULL;
> @@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
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

Code LGTM

