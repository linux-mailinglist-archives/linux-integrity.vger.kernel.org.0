Return-Path: <linux-integrity+bounces-6060-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20236AA1A74
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E024E4F46
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC5240611;
	Tue, 29 Apr 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WaZLhtAh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DE253351;
	Tue, 29 Apr 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950820; cv=none; b=I/pQg0/JbsTqde+CWpe7ySVmbRIspOIQf23C9OzmafTyjXhdSEJzAKz5ELQ7fcl6QUK2xwbYX4zr0HpaCc6kpnLzudZWGTJxM3oSDPVqpKCSpS6MvlR8YQiRxIzLUmGYNquZBOy+chkBJo2nlA2UFr1IHq5nAvn33UJB6QgbjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950820; c=relaxed/simple;
	bh=4hR+d2vNf2xhtMSHfrLyYaR6nEV83lXcs55J8plYDeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpK0NXKeUoKZ6AcrFtTNd6Vn9y9E3BVqPxNW8/SiE8XuHrhnN5e8bVpN4RTqnLHInvoxQPOpkkfX/Htnj4fw2y9PBg3GwAoP6757r6hB4TmQI5Yhvs6fteYi3V9J2/uzYVv+gszRBDSyVikYumomgJcfkMudRFBgrhaPOblmwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WaZLhtAh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TFuSOL007829;
	Tue, 29 Apr 2025 18:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hb4Kjx
	XFhu/EJ1SsGxpqzVpHWUwguSutPy5sG1v/vNs=; b=WaZLhtAh7ihEzoAi9wyeGw
	rJtYdn/W9QGpo6/s2ZtuylGao6lzTnQIkNNi0997M5WpzLrDY+aNNf+LbNP8+hQj
	pmwTFvT3X+qLrTNPruC00+AquAj3FXUNcnUnj8itbC5AfWSHAytGVZbq+FRE0Zt6
	K+URn8pzESrva3E/rG4kajhW0vSeNwLY10HsXCeMl4K49BIEmNPF+TfXo04qYFnL
	vCe/nVfr9dtXdutfhEtMDINTsKZjzV85l/sflPqyRwBz3v8gOlce/5a8uuAaqfTX
	b4cveUWutpB/MbkoiGeNNA+MKkNL3poYfvWpr3M7KjSmFYWxMmxg5eFG8m/o+yMg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46akn0v8fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:19:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TI1vqp001830;
	Tue, 29 Apr 2025 18:19:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bammcwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:19:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TIJnIu27132620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 18:19:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D18C558054;
	Tue, 29 Apr 2025 18:19:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7F875805F;
	Tue, 29 Apr 2025 18:19:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 18:19:46 +0000 (GMT)
Message-ID: <089d0ec8-22b0-447a-be2d-f46dc3ecdb43@linux.ibm.com>
Date: Tue, 29 Apr 2025 14:19:46 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/9] ima: verify if the segment size has changed
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
 <20250421222516.9830-8-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-8-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AeCxH2XG c=1 sm=1 tr=0 ts=68111847 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=MkatkpbgwXaQsrjt-asA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VibdR5li-oorQ5Oc-xymM27MMtnayM3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzMyBTYWx0ZWRfX0e2U6pjOjAI8 Tfhl73tO4MJw+JJCBX4svj5w3To3cV31abCSO4ZuW05RgL+jT0diCHPLXsNAjrBywlpuu/dZL0H mLweoEoHGPrMAQEp0Ieo/FQ/c1+FElCe6ddO4YiMRtgTr8Uykwkh490xqrQ6C1B0pWTz/klGVE+
 SaIS12cXEI0T6gwV5CRbm/4xswSP+3QvKUFWg0/Bri3rHMvFYuT980sYynRlngndwVMVv319gRA vuPhrN+IZxRsrRH9XOMEhCdBu7N2/lXlwQ6h50wxKwnU11Tbzao1gmASpVR7ycEtp7RNeSZrNxA lnUY3I9znX28CmFw6gnSvkcfdqdhsF8hF01kcl+RbncrPqYPDfCG3yE6UQe7xImst+iza+3xFlN
 gyZWNeDOef/k3TYhvOInpqXQkGbaQuByZWT8hSK5u88aAdWqZt9p3MJAO4uiUuSgsPolhIxU
X-Proofpoint-GUID: VibdR5li-oorQ5Oc-xymM27MMtnayM3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290133



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> kexec 'load' may be called multiple times. Free and realloc the buffer
> only if the segment_size is changed from the previous kexec 'load' call.
> 
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima_kexec.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 5c3b3e0b2186..ed867734ee70 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -33,6 +33,14 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>   
>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>   {
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
> +		goto out;
> +
>   	ima_free_kexec_file_buf(&ima_kexec_file);
>   
>   	/* segment size can't change between kexec load and execute */
> @@ -41,6 +49,8 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   		return -ENOMEM;
>   
>   	ima_kexec_file.size = segment_size;
> +
> +out:
>   	ima_kexec_file.read_pos = 0;
>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


