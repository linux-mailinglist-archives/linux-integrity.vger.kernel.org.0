Return-Path: <linux-integrity+bounces-1316-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B985CC94
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 01:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E84B22560
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Feb 2024 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66383384;
	Wed, 21 Feb 2024 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iT1xpO0o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44552382
	for <linux-integrity@vger.kernel.org>; Wed, 21 Feb 2024 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474413; cv=none; b=rK6loyYbuFZCuGpUr0oZmrM+HyEOkDLQEXDeUqiwUXnbBffGvDrhybHsNXwPt8+VwDxWRj5/3vuyfDJB6TneFfRaqvV893AblHxIjO9uThKfWSvY5VyxNWXy225iDR4HdEP9fmfgX1lD0/Ut1bb3PeRNx+ykwB1q/XvhmkczvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474413; c=relaxed/simple;
	bh=CKNMOtP8j+agU2/RUVTcRJx+MlA31//x+SeNLMShd/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=asR6ljn9gJfUzMLnA+G2gcCtvzSnjRQR63DtD1nlngpD1n7NpIJ4LmZTE3El+5zP8lVSg/G5PiND5ruoTIOqB++FuSH5Abrgnt6vuW2qOGVDP9pJq8VMa6ax/t/LgIsKVVeeMxjckDweAffYHblwVgGeqm9YSKnYudVcpgX6sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iT1xpO0o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KNqDbK007078;
	Wed, 21 Feb 2024 00:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Yp/ZBXJPhPBj81TuSs1DSf3ZiDcGpEJbzWdV7Z50Mt8=;
 b=iT1xpO0ok+eNl9nNnfyEIswZwFKC178wuVz+q2/MQctTzV5kAKIPe3N7nTDCtTr+MSOC
 9oKN6sIi/7FmC8PxghceLuxs9dlcjxRQGCv+Lz80MuWnnymSm4hakxxJjNVYa3RC1loS
 aH//Vek5dnmv3gJpNvkR74JaUu/LwTk1DahWEvJ7ziOBsQt3g69wxIoH+xUb05W5Z4xV
 uBmuqc6HT23hUwC5a++Lp+pXTlpV1EUHqJXkQC4BXGz532Yyv747d/zqndgteICqWUwy
 IsWCrPsIigY4c2MasdsqdwrZ0Y3+2qg+C+2mgCqYoss5H800D0S7wGay1ClFMzlzJitd zg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd64krf0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 00:12:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLV13u003671;
	Wed, 21 Feb 2024 00:12:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tkytc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 00:12:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41L0CgHU29164194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 00:12:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E0D5805D;
	Wed, 21 Feb 2024 00:12:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E34B758056;
	Wed, 21 Feb 2024 00:12:41 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.5.81])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 00:12:41 +0000 (GMT)
Message-ID: <844e1af9a5d0414d4b972c8c947b7f821a776d71.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/8] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Tue, 20 Feb 2024 19:12:41 -0500
In-Reply-To: <20240214153827.1087657-2-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FSG5EdwaC9Ae5Em-jYhFQUOgWHylOBTl
X-Proofpoint-ORIG-GUID: FSG5EdwaC9Ae5Em-jYhFQUOgWHylOBTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210000

On Wed, 2024-02-14 at 07:38 -0800, Tushar Sugandhi wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
> 
> This patch includes the following changes:
>  - Refactor ima_dump_measurement_list() to move the memory allocation
>    to a separate function ima_alloc_kexec_file_buf() which allocates
>    buffer of size 'kexec_segment_size' at kexec 'load'.
>  - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>    as local static to the file, so that it can be accessed from 
>    ima_alloc_kexec_file_buf().
>  - Make necessary changes to the function ima_add_kexec_buffer() to call
>    the above two functions.
> 
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 107 +++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 29 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index dadc1d138118..a9cb5e882e2e 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,62 +15,98 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
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

ima_kexec_file.size will be initialized to zero.  No need to test anything other
than the segment size.

> +
> +	ima_free_kexec_file_buf(&ima_kexec_file);

The first time ima_free_kexec_file_buf() is called the memory has not been
allocated.  Test that the memory has been allocated before freeing it.  Since
there's no other ima_free_kexec_file_buf() caller, there's no need to clear the
other fields as they will be set below.

> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;

static variables are initialized to zero.  No need to set it here.

> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved
> space */
> +
> +	return 0;
> +}
> +
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void
> **buffer,
>  				     unsigned long segment_size)
>  {
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
>  	struct ima_kexec_hdr khdr;
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
> +		pr_err("%s: Kexec file buf not allocated\n", __func__);
> +		return -EINVAL;
>  	}
>  
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> -
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
> +
> +	/* Copy as many IMA measurements list records as possible */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {

With an extra half page memory allocated, there should be enough memory for a
few extra records as a result of the kexec load.  Subsequent patches are going
to change this assumption.  This test doesn't ensure there is enough memory for
the entire measurement record.  Call get_binary_runtime_size() to get the record
size to ensure there is enough memory for the entire record.

>  			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
> -			ret = -EINVAL;
> +			pr_err("%s: IMA log file is too big for Kexec buf\n",
> +			       __func__);

This message and the one above should probably be pr_debug().  There's a new
error message after the call to ima_dump_measurement_list().

>  			break;
>  		}
>  	}
>  
> -	if (ret < 0)
> -		goto out;
> -

Removing these lines is in for "copying as many measurements as possible". That
change isn't mentioned in the patch description.

>  	/*
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
>  	 */
> -	khdr.buffer_size = file.count;
> +	khdr.buffer_size = ima_kexec_file.count;
>  	if (ima_canonical_fmt) {
>  		khdr.version = cpu_to_le16(khdr.version);
>  		khdr.count = cpu_to_le64(khdr.count);
>  		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>  	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>  
>  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>  			     true);
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
>  }
>  
>  /*
> @@ -108,13 +144,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
>  		pr_err("Not enough memory for the kexec measurement buffer.\n");
>  		return;
>  	}
>  
> +	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +					kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> +		       __func__, ret);

Please remove "__func__" from the error message.

> +		return;
> +	}
> +
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> @@ -129,6 +172,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
>  
> +	/*
> +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> +	 * and it will vfree() that buffer.
> +	 */
> +	ima_reset_kexec_file(&ima_kexec_file);
> +
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at
> 0x%lx.\n",
>  		      kbuf.mem);
>  }

thanks,

Mimi


