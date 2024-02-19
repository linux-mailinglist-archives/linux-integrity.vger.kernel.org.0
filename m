Return-Path: <linux-integrity+bounces-1296-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC785AE44
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Feb 2024 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB01C218FB
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Feb 2024 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8011A54F88;
	Mon, 19 Feb 2024 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qpEiGoMw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4854BEA
	for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2024 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381099; cv=none; b=E+sPnALY5lDPwqrILbJ6barbL6NGUFi4OABGyISgIR1W8Ay3r87y28wlaT3ewx6CySSMGQZLPqOsCOlgvPRHNbieV7JOIxr3FMZQIlBkKj9NKf5tkVV7apOD3ke2lvVbFGq4YS/s1UxBiiq4S3N3LvUpTVapxNUOhEdYXpc/0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381099; c=relaxed/simple;
	bh=w12ZLM49JaesoH00N79gM/ItJkbmDk/W6sjcc8HC4ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKGyS/SZ3URwZuwXtd6oX8lU/oV16ZYI4gj0QY480U2+Ufr2aq9IOOvD9m5GYe6jNC0OFdte4SH5TUinZoraZhRClorcP0dnMDVLYCafgrcXnlldD+SAv4t6sJQUwi7/96HDiTGX/CzjU5vOY0mv6/Z5RQ8/PFAFgjk9znJcvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qpEiGoMw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JM60of023284;
	Mon, 19 Feb 2024 22:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=m2vVnm3WIOYe8tuZvxVsO+fx9MrfXEx+Kc5KgrKSaic=;
 b=qpEiGoMwHmSAG+LlsDVzaIP8Z01j97qKKgXTCZnbv6Je+a4GbHJ+gcDsIH+iAasHe/d+
 paFuvpalrHhVGXfxAUT45lKr5D+t7mePHqlHXCCKFjCGn1hDkRtMuDDhZplT2ZlCl69g
 2ayTKNTuSQb3PhJuW1Uxiej8VYryFVRnys328SPm40Qt56xfKUX/C5RX9ag6hLK7Z3e1
 WtPZzzYneefEecifJOItvaxyqfpdxKLYi5uLAgDR7JMchxpm0GvRUSi4ZSaBFoAReN6z
 MpwTFf+Iha336UsObxyEDMqyqhd3XhXmrr59WWxRAyVcJP3d3tqiGdviBTpn7tjBANJh 9Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wce8n9wq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 22:16:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JJbDZt009540;
	Mon, 19 Feb 2024 22:16:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p49m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 22:16:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JMGtDj9503450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 22:16:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915535805E;
	Mon, 19 Feb 2024 22:16:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58A458051;
	Mon, 19 Feb 2024 22:16:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 22:16:53 +0000 (GMT)
Message-ID: <6a2b6fee-6f3c-4099-983a-3be3ecd091b6@linux.ibm.com>
Date: Mon, 19 Feb 2024 17:16:53 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-2-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240214153827.1087657-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2sJIqJ5zuL-g3LV3CBhtMkpIcqOU_G81
X-Proofpoint-ORIG-GUID: 2sJIqJ5zuL-g3LV3CBhtMkpIcqOU_G81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_20,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190167



On 2/14/24 10:38, Tushar Sugandhi wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
> 
> This patch includes the following changes:
>   - Refactor ima_dump_measurement_list() to move the memory allocation
>     to a separate function ima_alloc_kexec_file_buf() which allocates
>     buffer of size 'kexec_segment_size' at kexec 'load'.
>   - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>     as local static to the file, so that it can be accessed from

as -> a

>     ima_alloc_kexec_file_buf().
>   - Make necessary changes to the function ima_add_kexec_buffer() to call
>     the above two functions.
> 
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_kexec.c | 107 +++++++++++++++++++++--------
>   1 file changed, 78 insertions(+), 29 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index dadc1d138118..a9cb5e882e2e 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,62 +15,98 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_reset_kexec_file(struct seq_file *sf)
> +{
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;
> +}
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	ima_reset_kexec_file(sf);
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf &&
> +	    ima_kexec_file.size == segment_size &&
> +	    ima_kexec_file.read_pos == 0 &&
> +	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
> +		return 0;
> +
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
>   	struct ima_queue_entry *qe;
> -	struct seq_file file;
>   	struct ima_kexec_hdr khdr;
> -	int ret = 0;
>   
> -	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (!ima_kexec_file.buf) {
> +		*buffer_size = 0;
> +		*buffer = NULL;

If you return -EINVAL then the caller should not look at the buffer but 
at 'ret' (5/8). So I don't think it's necessary to initialize these 
variables since the caller shouldn't look at them.

> +		pr_err("%s: Kexec file buf not allocated\n", __func__);
> +		return -EINVAL;
>   	}
>   
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> -
>   	memset(&khdr, 0, sizeof(khdr));
>   	khdr.version = 1;
> +
> +	/* Copy as many IMA measurements list records as possible */
>   	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>   			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>   		} else {
> -			ret = -EINVAL;
> +			pr_err("%s: IMA log file is too big for Kexec buf\n",
> +			       __func__);
>   			break;
>   		}
>   	}
>   
> -	if (ret < 0)
> -		goto out;
> -
>   	/*
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
> -out:
> -	if (ret == -EINVAL)
> -		vfree(file.buf);
> -	return ret;
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
> +
> +	return 0;
>   }
>   
>   /*
> @@ -108,13 +144,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
>   		pr_err("Not enough memory for the kexec measurement buffer.\n");
>   		return;
>   	}
>   
> +	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +					kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> +		       __func__, ret);
> +		return;
> +	}
> +
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;
> @@ -129,6 +172,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	image->ima_buffer_size = kexec_segment_size;
>   	image->ima_buffer = kexec_buffer;
>   
> +	/*
> +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> +	 * and it will vfree() that buffer.
> +	 */

Actually, that's not quite right what I told you.   "kexec owns 
kexec_buffer due to ima->ima_buffer and it will vfree() this buffer."


> +	ima_reset_kexec_file(&ima_kexec_file);
> +
>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		      kbuf.mem);
>   }

