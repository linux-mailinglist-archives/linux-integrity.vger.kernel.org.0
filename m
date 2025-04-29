Return-Path: <linux-integrity+bounces-6061-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4EAA1AA3
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 20:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E321E1888A4F
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F112517BE;
	Tue, 29 Apr 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bsr2ACm2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3672472BD;
	Tue, 29 Apr 2025 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951448; cv=none; b=uNj9/55OxZ+0jm6yNhl2jNISpP0cjRHiHYpfeDGJO6C0/6Ns0iOO7MvcTMKNd+GsD7I9vGg3uSrwxR+1wHF2wXB7KwaqyO1UBOAXvMUVGs2fUCXET2I+red3CRNm7hTs93TJpDZjsTSitoHuAkqeDNnb/4Yj9KVb4ERYFyA09d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951448; c=relaxed/simple;
	bh=ULfpgkJpTy0iha7rQlDqNQk4yXROXMA61+k45jNO4RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nn+400bS8VsCajV5yrmueDaFWxwdqhx6UtoaLOvSFNYRYd7Xf3ss0NcYvb4RD73AneXiZJz43VIIAzFqH7QJbfLLwXnwbnphwYCoJquiWheEF7Df/SWXaRs+6ahQzQxb4/emR1EGbbHrM+uc0sLv8el3oVnszeiADKCKV16laPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bsr2ACm2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDLb6q006378;
	Tue, 29 Apr 2025 18:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y0jwA7
	qp++qfYNXHw9b2Hp6XvIPyaPAoEnT1kunT9Us=; b=bsr2ACm25FLNuD2SQUOorC
	pfrm9NlOLpijeWjFEmixaRVmEMZRM6m9j3EYtQy1bAjHKDi1AcoTrnQpfw1dvhBm
	Y0Azk/bQlgbA7BX2sW79+xMWV47Lf5GlNjMwd8qw+dGf50pQQBG9vvD6XomD+lY8
	InqyutDgKrxOFLozVMhaNyxzHpijud/BMP2JzEYukOO0pH+Jpr6Pr/WahXcxoyti
	31SWwYe7eP1a+M8Km820+XmOG+Im5ne3BeyMRVEcBJDkDX0o97ZpVWydXOe+Sz4T
	yutubliAJ3yYAAPT02hOwGc+Qf8umFs7MmTsmjM26ET7iwrO1hNTligSGad7GJKA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9ct5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:30:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TFANgG024643;
	Tue, 29 Apr 2025 18:30:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m49hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:30:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TIUHiU50201086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 18:30:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 209DC58054;
	Tue, 29 Apr 2025 18:30:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC7C058064;
	Tue, 29 Apr 2025 18:30:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 18:30:15 +0000 (GMT)
Message-ID: <018fb52f-71ee-421c-a783-2c6139a7c71b@linux.ibm.com>
Date: Tue, 29 Apr 2025 14:30:15 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/9] ima: define and call ima_alloc_kexec_file_buf()
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
 <20250421222516.9830-3-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-3-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=68111abb cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=OpzxEjsHCaZo50AtzuQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a2FXygkD4qtJq5sJRgO8Js1u9oKM2xYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzMyBTYWx0ZWRfX7+5d06jW9mFQ 5gpPv/0MazNmAU41y/ZFIgV+54v3g94OfQlqlCcgTukmPwHDVaZq0IDrAnzI0y3qRqKkxPsny2X 3KWz5INKi7B5b5RgAR/DDNDVe+N4/8JVi5KyuH+P11L1jloSVCv1l2lUWp8uZLuLwMocGUASn55
 O3P3WFxd3AJ4jtCEVGibSAVBoeEhpPAccDrWyuwnBYDOxx49s8Uhv4oLjXIpVY+Vf8MKuOIvYSQ WEKu/r9Y/VoqxYC9j2lO/ihULqdeHTCUeKfkGW0JA8Znfo1/xdg9dShvXMKYMmjCCBY64rI1BzH 7eclB1oxrCnD+68YPJVqK3TvEX+Jcw+1HhSsSauR54ra/FkunDFxQ45LLQwlHVvitsPgcaeJrNb
 o6KUmmp+PGYlTbQECI9E5oT1QVdC3wdOILq5tVpv8xRi+Y3aNyq7JEHsURudRz9PzdVX2G0A
X-Proofpoint-GUID: a2FXygkD4qtJq5sJRgO8Js1u9oKM2xYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290133



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> In the current implementation, the ima_dump_measurement_list() API is
> called during the kexec "load" phase, where a buffer is allocated and
> the measurement records are copied. Due to this, new events added after
> kexec load but before kexec execute are not carried over to the new kernel
> during kexec operation
> 
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
> 
> After moving the vfree() here at this stage in the patch set, the IMA
> measurement list fails to verify when doing two consecutive "kexec -s -l"
> with/without a "kexec -s -u" in between.  Only after "ima: kexec: move
> IMA log copy from kexec load to execute" the IMA measurement list verifies
> properly with the vfree() here.
> 
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 650beb74346c..b12ac3619b8f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,26 +15,46 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +
> +	return 0;
> +}
> +
>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   				     unsigned long segment_size)
>   {
> -	struct seq_file ima_kexec_file;
>   	struct ima_queue_entry *qe;
>   	struct ima_kexec_hdr khdr;
>   	int ret = 0;
>   
>   	/* segment size can't change between kexec load and execute */
> -	ima_kexec_file.buf = vmalloc(segment_size);
>   	if (!ima_kexec_file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +		pr_err("Kexec file buf not allocated\n");
> +		return -EINVAL;
>   	}
>   
> -	ima_kexec_file.file = NULL;
> -	ima_kexec_file.size = segment_size;
> -	ima_kexec_file.read_pos = 0;
> -	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
> -
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
>   	/* This is an append-only list, no need to hold the RCU read lock */
> @@ -71,8 +91,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   	*buffer_size = ima_kexec_file.count;
>   	*buffer = ima_kexec_file.buf;
>   out:
> -	if (ret == -EINVAL)
> -		vfree(ima_kexec_file.buf);
>   	return ret;
>   }
>   
> @@ -111,6 +129,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("Not enough memory for the kexec measurement buffer.\n");
> +		return;
> +	}
> +
>   	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>   				  kexec_segment_size);
>   	if (!kexec_buffer) {

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


