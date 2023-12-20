Return-Path: <linux-integrity+bounces-553-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA181A78F
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 21:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9ECB23561
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A636487AC;
	Wed, 20 Dec 2023 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JczChYlY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C94879E
	for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2023 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKJl0cA005212;
	Wed, 20 Dec 2023 20:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QGrZ5WG1uTruUSRtoz27vaI8p+nzVgCsiiHShd6D+tY=;
 b=JczChYlYDIDrjV9l1ayMoGOj7EhoooPVqGlEULyYw3/IQH9hVAcj9E2XCQuOGmzPAT94
 mviFlCCwVOykMoTLebpgVqpGR8Cs/1wGjbxKPIT5wiJutB3hEmpgxaplZaoBMmwZdfJ5
 uys3JYQcAbBe8T0/74lbGSq87eJTtF3ss9pgOJO6Yl9Lfju+ugdPY54XcjX3x9mJnp38
 4Jxa0kDJJhxN0Unxth/J1oSlRRpsM9D7jL3Rrv0kONRGYe8sI200ZHGiTDUQvo8nnHgN
 Ik6299qcbV/VmgSyPl/5MJOzmyhbNGcM8ktjda03zc8wCWI2QTVkCmfeLLpqoyvbLot+ Og== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v46qrrmjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:17:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKI1kjj027822;
	Wed, 20 Dec 2023 20:15:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rek8cca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:15:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKKFXFE47382914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 20:15:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D079E58058;
	Wed, 20 Dec 2023 20:15:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 533445805C;
	Wed, 20 Dec 2023 20:15:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.116.58])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 20:15:32 +0000 (GMT)
Message-ID: <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between
 kexec load and execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 20 Dec 2023 15:15:31 -0500
In-Reply-To: <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fyfM2qETtpX1VfoT_hQoIr6IcqZbw5xd
X-Proofpoint-ORIG-GUID: fyfM2qETtpX1VfoT_hQoIr6IcqZbw5xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200143

Hi Tushar,

The Subject line should include the word "extra".   The use of the
extra memory isn't limited to the measurements between the kexec load
and exec.  Additional records could be added as a result of the kexec
load itself.  Let's simplify the title to "ima: make the kexec extra
memory configurable".

Please remove any references to measurements between kexec load and
execute.

On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> IMA currently allocates half a PAGE_SIZE for the extra events that would
> be measured between kexec 'load' and 'execute'.  Depending on the IMA
> policy and the system state, that memory may not be sufficient to hold
> the extra IMA events measured after kexec 'load'.  The memory
> requirements vary from system to system and they should be configurable.

The extra memory allocated for carrying the IMA measurement list across
kexec is hardcoded as a half a PAGE.   Make it configurable.

> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added in the
> window from kexec 'load' to kexec 'execute'.

> Update ima_add_kexec_buffer() function to allocate memory based on the 
> Kconfig option value, rather than the currently hardcoded one.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/Kconfig     |  9 +++++++++
>  security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 60a511c6b583..8792b7aab768 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>  	default n
>  	help
>  	   This option disables htable to allow measurement of duplicate records.
> +
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int
> +	depends on IMA && IMA_KEXEC
> +	default 64

Since this isn't optional, the default should remain as a half page. 
Since a page is architecture specific, the default will need to be arch
 specific.

thanks,

Mimih

> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added in the window
> +	  from kexec 'load' to kexec 'execute'.
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 55bd5362262e..063da9c834a0 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -128,15 +128,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	int ret;
>  
>  	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added in the window from
> +	 * kexec 'load' to kexec 'execute'.
>  	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	binary_runtime_size = ima_get_binary_runtime_size() +
> +			      sizeof(struct ima_kexec_hdr) +
> +			      (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024);
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



