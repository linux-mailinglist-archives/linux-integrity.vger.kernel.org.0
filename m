Return-Path: <linux-integrity+bounces-4719-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C8A27B75
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 20:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C23A25D9
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB3204F7F;
	Tue,  4 Feb 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UfBeuDgt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D0204C15;
	Tue,  4 Feb 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698038; cv=none; b=rs0jdvKFHyziy5W/hy+HyiMQLXCPnBraqcqj77mSZV+fikPTBrGudEkYCz5PX5i0kuY3YdOfP/6Wrq0Bhlg9hvf/k0dQCR1+LpcrbAxNE+sB0Km6+Xq+1AKf2lqfY6knNTJoXJBcJHJp8TC1wXqZB5Y3jUpib4c7IgIjZNwhlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698038; c=relaxed/simple;
	bh=9uM5IP0WLr9HdjNFniPf6qQTeKQb6IUb02V93ndFUCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIm2F0eZ4eIBbF5g2kH3qHVSy7FSNvp/uzQB7EKEeD6kkCotgN358MCyiVoVSJZXqHJvwFysIF+wd/vSkwc0cSPEjWy0eOcMklrT888D2MghD/+d7UCAe/oxIdkmTW5SFFNur01YxLKQT4CI15JHt10FWJQ/P2l90xOqgZeoOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UfBeuDgt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEqdr029409;
	Tue, 4 Feb 2025 19:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nbwy+n
	Gq+1o1SgLagklaC9pBWpqbNKasmV3JuWKyZLs=; b=UfBeuDgtkXLMAI5NU2Sdtm
	YtpMl3HS6smuCs0CwZNbh0KxzTG3wY4FZO+LfJpmJPN3fx3Yq72q5z8RfH24kas0
	ntawlnZH/6EKALI6j0VvZS4lFB+GyT/3KIP50blMRse81ueGCvzIs1UbF4hvu/OY
	neuesc3TYK39T8JexvYCViU/iRZoe4EMy2NlsbOIfcWGQ/TRum9oxVdloeoZHuVf
	H7VTNA9tVVXk/j/HQ8+He5dqLC+Twn9KAoW0VEN5yyn9tdjVGW/yt8EQVi+a83mC
	brO9HH0vZHfRNGMRMT68ZHqp0jPo0oOvIPONyy/UL0SwFR6DOK/s1V9J1jUkvGdg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k8y9n2br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:39:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514GagLE006516;
	Tue, 4 Feb 2025 19:39:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekd2jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:39:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Jd92H28705426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 19:39:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD2D58055;
	Tue,  4 Feb 2025 19:39:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3033458043;
	Tue,  4 Feb 2025 19:39:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 19:39:08 +0000 (GMT)
Message-ID: <00eeeb8b-cc28-42af-873f-3478cd22fb6e@linux.ibm.com>
Date: Tue, 4 Feb 2025 14:39:07 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-4-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250203232033.64123-4-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3lTu4algauG_2DnpSlkJw5Wp7jnps3fb
X-Proofpoint-ORIG-GUID: 3lTu4algauG_2DnpSlkJw5Wp7jnps3fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040145

On 2/3/25 6:20 PM, steven chen wrote:
> kexec_calculate_store_digests() calculates and stores the digest of the
> segment at kexec_file_load syscall where the IMA segment is also
> allocated.  With this series, the IMA segment will be updated with the
> measurement log at kexec excute stage when soft reboot is initiated.

s/excute/execute

> Therefore, it may fail digest verification in verify_sha256_digest()
> after kexec soft reboot into the new kernel. Therefore, the digest
> calculation/verification of the IMA segment needs to be skipped.
> 
> Skip IMA segment from calculating and storing digest in function

Skip the calculation and storing of the digest of the IMA segment in 
kexec_calculate_store_digests() so that ...


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
 > --->   include/linux/kexec.h              |  3 +++
>   kernel/kexec_file.c                | 23 +++++++++++++++++++++++
>   security/integrity/ima/ima_kexec.c |  3 +++
>   3 files changed, 29 insertions(+)
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
>   #endif
>   
>   	/* Core ELF header buffer */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..a3370a0dce20 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -38,6 +38,22 @@ void set_kexec_sig_enforced(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_IMA_KEXEC
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	if (image->is_ima_segment_index_set &&
> +			i == image->ima_segment_index)

The 'i =' should be indented under 'image->'.

With these nits fixed:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> +		return true;
> +	else
> +		return false;
> +}
> +#else
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	return false;
> +}
> +#endif
> +
>   static int kexec_calculate_store_digests(struct kimage *image);
>   
>   /* Maximum size in bytes for kernel/initrd files. */
> @@ -764,6 +780,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
>   		if (ksegment->kbuf == pi->purgatory_buf)
>   			continue;
>   
> +		/*
> +		 * Skip the segment if ima_segment_index is set and matches
> +		 * the current index
> +		 */
> +		if (check_ima_segment_index(image, i))
> +			continue;
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


