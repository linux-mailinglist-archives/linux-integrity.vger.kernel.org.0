Return-Path: <linux-integrity+bounces-5315-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A4A677C3
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B4B3B75F4
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7420E71C;
	Tue, 18 Mar 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fG1SW8fb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BF20E70B;
	Tue, 18 Mar 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311768; cv=none; b=vF/ZvbRJ79Dl5suHfj0F8o+i/CF8XHPFAHTObFQYNXDXWp1eWmQsOfQ47ftB1LIhh+b4KRlDKcEKhQ94s278YaaImzmcreuzWSxqDVc3MoFLqKR8G26V7vNSE1lDIEtiD0I+OxYh76SX/Pay/STEzfdzCrVMfKxEKDzg/V/3eiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311768; c=relaxed/simple;
	bh=diepUrYB4HsR5xj+eFHg5fT9v7F67Mx3c1NL1VqSUNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7nGEeoaUN/Nj6FmeTJfSUpHUKAdFknD57YQyel8Epq0OITTbycwT6NyY5GeIDoHR7a7Bcb45vglkevjIyzIYaxPPtdfII6ypLJzVVtml4vYmSXnNnQQIpxXJiL269qfohROpnYgqfANGNZIQQ7X7SLVPlHfrQERvC8R39zpPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fG1SW8fb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IE3LPJ027998;
	Tue, 18 Mar 2025 15:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YYG3Ja
	ZM3uuDtvjfp113LnshRYPfiJjdFC627bwY4eg=; b=fG1SW8fbrVNG5WXJ8T8UdI
	bYB9ACz64McFP+tYa0R6/ItXtbwooIjex/vEBm8f+2MSnXDPUArhBSbHkZODOZQI
	pHWu8EnAta6xWQqpFNcNqlzFJ3oT92/57Fcm3b1NxWDOIZBB+Pcz3YwKbrCud2TA
	hJpXntxsQ+/qcTuSLn2UUVQwj1Fhp/mZXPEc2QIg9DvBaAYD3pnGEAUbx8EdM0H9
	aY2qUgnRl3+VDFOd0HIIETOKkg4sqTjRBBWiPTxeVa/QFLV6Ra1dZkoCHEsLIZVZ
	3FIHxoEkmeA7yS/M2EyJU5hToMKOHrvKdY/9FVaRsA4/5Hz0K7snZQuRKdwtc1rQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8p8bfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 15:10:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IF3QO0024431;
	Tue, 18 Mar 2025 15:10:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncm4bhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 15:10:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IFAiXI2687644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 15:10:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D1158055;
	Tue, 18 Mar 2025 15:10:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6381358043;
	Tue, 18 Mar 2025 15:10:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 15:10:42 +0000 (GMT)
Message-ID: <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
Date: Tue, 18 Mar 2025 11:10:41 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-2-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250318010448.954-2-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0RYjHXm3NJDxS1KCWYAn74mGAGYo60lW
X-Proofpoint-ORIG-GUID: 0RYjHXm3NJDxS1KCWYAn74mGAGYo60lW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180107



On 3/17/25 9:04 PM, steven chen wrote:
> The name of the local variable "file" of type seq_file defined in the
> ima_dump_measurement_list function is too generic. To better reflect the
> purpose of the variable, rename it to "ima_kexec_file". This change will
> help improve code readability and maintainability by making the variable's
> role more explicit.
> 
> The variable ima_kexec_file is indeed the memory allocated for copying IMA
> measurement records. The ima_dump_measurement_list function calculates the
> actual memory occupied by the IMA logs and compares it with the allocated
> memory. If there is enough memory, it copies all IMA measurement records;
> otherwise, it does not copy any records, which would result in a failure
> of remote attestation.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>


> ---
>   security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 9d45f4d26f73..8567619889d1 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,33 +15,41 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +/*
> + * Copy the measurement list to the allocated memory
> + * compare the size of IMA measurement list with the size of the allocated memory

Compare the size of the IMA ... memory.


> + *    if the size of the allocated memory is not less than the size of IMA measurement list
> + *        copy the measurement list to the allocated memory.
> + *    else
> + *        return error

If the size of the allocated memory is not less than the size of IMA 
measurement list, copy the measurement list to the allocated memory, 
return an error otherwise.

Looked a bit unusual. With this nit:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> + */
>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   				     unsigned long segment_size)
>   {
> +	struct seq_file ima_kexec_file;
>   	struct ima_queue_entry *qe;
> -	struct seq_file file;
>   	struct ima_kexec_hdr khdr;
>   	int ret = 0;
>   
>   	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf) {
>   		ret = -ENOMEM;
>   		goto out;
>   	}
>   
> -	file.file = NULL;
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> +	ima_kexec_file.file = NULL;
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>   
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
>   	/* This is an append-only list, no need to hold the RCU read lock */
>   	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>   			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>   		} else {
>   			ret = -EINVAL;
>   			break;
> @@ -55,23 +63,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   	 * fill in reserved space with some buffer details
>   	 * (eg. version, buffer size, number of measurements)
>   	 */
> -	khdr.buffer_size = file.count;
> +	khdr.buffer_size = ima_kexec_file.count;
>   	if (ima_canonical_fmt) {
>   		khdr.version = cpu_to_le16(khdr.version);
>   		khdr.count = cpu_to_le64(khdr.count);
>   		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>   	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>   
>   	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>   			     true);
>   
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
>   out:
>   	if (ret == -EINVAL)
> -		vfree(file.buf);
> +		vfree(ima_kexec_file.buf);
>   	return ret;
>   }
>   


