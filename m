Return-Path: <linux-integrity+bounces-4661-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8CA20CF5
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA933A3CF0
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF961AAE28;
	Tue, 28 Jan 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d/2tKVtD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89318DF86;
	Tue, 28 Jan 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077900; cv=none; b=a66XFZbZzfiuy1FNUv/LBUQxkHxRpeCdgx6Z39zYA1RgbUlgT1twUDHK0aexCq6kDxzqXKfmC/ZDZjJXTkd17yDXlwsVOoSC/3L/d3aMRT7oiVmLWCnw10NMS2uC1PPDPO2CybQnlIFyZtuge16eXuk7JEpfHIez8LCdt+UXMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077900; c=relaxed/simple;
	bh=AKZKxpAVAgAexZFYE6xDE61t6BVD6c4bhvi/UTWcqgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJKAjiCk954yfBegYrBYs7nxyFH81AbWgclYzY27zvMY2tGGv2oZFtrGQjS8SKjh3Kgh7Owb7dmE5Yuyn5BDSQovSWkyc/HEuJepixVUmXcGatKT69YeDFfcOeyFGobTUk6kuej1HqmxU1JfhmxP73yaqjUF5V26oOz68/RSE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d/2tKVtD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S5O1ud023593;
	Tue, 28 Jan 2025 15:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=esNtiH
	I2LLogj19tsep9LDRutntI57GEZpZqgTdg2tI=; b=d/2tKVtDsTPOFrazYdx6a2
	PuwiI6qiszN2FS5sjb3+zYyioTIwT0XEo4c89Z+Q4v5pjj4PK6f1R6CfXVpc3Tu4
	MWPhEn5vWgvRs5S8sjhKJLV+Mt4Md/tR3dpqOX4XrwM9M4Ukv1PrKqbUtgPnpAFb
	wEX+PfXVqRrubPfbtfymPD5sdO6brSm17yZ8zMXRNIRLCq/fzdSoksSRn93jXXVv
	Rr0ZVlmAQUJBNFXS4hVrgqRhF3eoFHlM5ZCzUNlBPvhuoAbSQbdugW5vfq/EpzoV
	nvf9rTu7oTtvNNcvX1v/Jc51cAN6m18XadOarrBQAH/3RRE36yLA77j8QkpRI4Cw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44es27jp1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:23:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SEWSle022193;
	Tue, 28 Jan 2025 15:23:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjkjfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:23:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SFNh7B1639038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 15:23:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6B75805C;
	Tue, 28 Jan 2025 15:23:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24F495805F;
	Tue, 28 Jan 2025 15:23:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 15:23:42 +0000 (GMT)
Message-ID: <35dcea8e-6418-4c60-b4ab-8e6c26721715@linux.ibm.com>
Date: Tue, 28 Jan 2025 10:23:41 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz,
        eric.snowberg@oracle.com, paul@paul-moore.com, code@tyhicks.com,
        nramas@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
        madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-4-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250124225547.22684-4-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0tIXa8_uq4cCDqSwi1a8lB0icsL1QuBw
X-Proofpoint-GUID: 0tIXa8_uq4cCDqSwi1a8lB0icsL1QuBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280111



On 1/24/25 5:55 PM, steven chen wrote:
> kexec_calculate_store_digests() calculates and stores the digest of the
> segment at kexec_file_load syscall where the IMA segment is also
> allocated.  With this series, the IMA segment will be updated with the
> measurement log at kexec soft reboot.  Therefore, it may fail digest

... log at kexec execute stage when the soft reboot is initiated.

> verification in verify_sha256_digest() after kexec soft reboot into the
 > new Kernel.  Therefore, the digest calculation/verification of the IMA

kernel

> segment needs to be skipped.
> 
> Skip IMA segment from calculating and storing digest in function
> kexec_calculate_store_digests() so that it is not added to the
> 'purgatory_sha_regions'.
> 
> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
> no change is needed in verify_sha256_digest() in this context.
> 
> With this change, the IMA segment is not included in the digest
> calculation, storage, and verification.
> 
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>   include/linux/kexec.h              |  3 +++
>   kernel/kexec_file.c                | 10 ++++++++++
>   security/integrity/ima/ima_kexec.c |  3 +++
>   3 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f8413ea5c8c8..f3246e881ac8 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -362,6 +362,9 @@ struct kimage {
>   
>   	phys_addr_t ima_buffer_addr;
>   	size_t ima_buffer_size;
> +
> +	unsigned long ima_segment_index;
> +	bool is_ima_segment_index_set;
 >   #endif>
>   	/* Core ELF header buffer */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..4ff3ba0f3e8e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -764,6 +764,16 @@ static int kexec_calculate_store_digests(struct kimage *image)
>   		if (ksegment->kbuf == pi->purgatory_buf)
>   			continue;
>   
> +#ifdef CONFIG_IMA_KEXEC
> +		/*
> +		 * Skip the segment if ima_segment_index is set and matches
> +		 * the current index
> +		 */
> +		if (image->is_ima_segment_index_set &&
> +		    i == image->ima_segment_index)
> +			continue;
> +#endif
> +
>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>   					  ksegment->bufsz);
>   		if (ret)
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index b60a902460e2..283860d20521 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -162,6 +162,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;
> +	image->is_ima_segment_index_set = false;
>   	ret = kexec_add_buffer(&kbuf);
>   	if (ret) {
>   		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -172,6 +173,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	image->ima_buffer_addr = kbuf.mem;
>   	image->ima_buffer_size = kexec_segment_size;
>   	image->ima_buffer = kexec_buffer;
> +	image->ima_segment_index = image->nr_segments - 1;
> +	image->is_ima_segment_index_set = true;
>   
>   	/*
>   	 * kexec owns kexec_buffer after kexec_add_buffer() is called

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


