Return-Path: <linux-integrity+bounces-552-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A781A725
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 20:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A4C1C2201B
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC454482D7;
	Wed, 20 Dec 2023 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y/Bpnji+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF1482D8
	for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2023 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKIC8Ul014493;
	Wed, 20 Dec 2023 19:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CEvD9W1vhl17TGK5JgqaAq3+siTbMKJnjrHwwMhEjqM=;
 b=Y/Bpnji+/62ljT8fRd2FDMm57xPvTogukVLNxmibAnrUrGaNDgvg+HrmwMlSjfEzWBLF
 LpbSmRG8rtNbXv49iP04SVaF6lJw4/V9P4V1rKm4ed4aO2vecbUE/1d+gWJiB9UsXHis
 0DRmwhyIxJC5L/8L8Mn7o0NOYhD56vd94RM8zrbTwypV/N71/H6YPyc1svFoYOsZzHQg
 zETk9FX1jB7dyWMB/sg3yQ3kWdkQmCWD+xyt1ccmEa9trh/RVBXtfDz5Q/OtMratM+nZ
 ksGCE4+25VznRXUIivMc8vEoAmxYrTlmjwuum12jEHHvBEHaRNV3h7C/fydcBNMX4eLx bg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v42q6xr3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 19:02:07 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKGQe1u029718;
	Wed, 20 Dec 2023 19:02:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1p7srjn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 19:02:04 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKJ23NE39649748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 19:02:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA4455805B;
	Wed, 20 Dec 2023 19:02:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DD9A5805C;
	Wed, 20 Dec 2023 19:02:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.116.58])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 19:02:02 +0000 (GMT)
Message-ID: <b01df40e800ab387d43adcbb7f643bcd9f172cbb.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/7] ima: kexec: move ima log copy from kexec load to
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 20 Dec 2023 14:02:02 -0500
In-Reply-To: <20231216010729.2904751-3-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-3-tusharsu@linux.microsoft.com>
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
X-Proofpoint-GUID: DHzv4-QZVB6gCIeOi2iNKUh6600BLx0E
X-Proofpoint-ORIG-GUID: DHzv4-QZVB6gCIeOi2iNKUh6600BLx0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_11,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200135

Hi Tushar,

On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> ima_dump_measurement_list() is called from  ima_add_kexec_buffer() during
> kexec 'load', which may result in loss of IMA measurements between kexec
> 'load' and 'execute'.  It needs to be called during kexec 'execute'.
> 
> Implement ima_update_kexec_buffer(), to be called during kexec 'execute'.
> Move ima_dump_measurement_list() function call from ima_add_kexec_buffer()
> to ima_update_kexec_buffer().  Make the needed variables global for
> accessibility during kexec 'load' and 'execute'. Implement and call
> ima_measurements_suspend() and ima_measurements_resume() to help ensure
> the integrity of the IMA log during copy. Add a reboot notifier_block to
> trigger ima_update_kexec_buffer() during kexec soft-reboot.  Exclude ima
> segment from calculating and storing digest in function
> kexec_calculate_store_digests(), since ima segment can be modified
> after the digest is computed during kexec 'load'.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Wow!   That's quite a bit for a single patch.

This patch moves the ima_dump_measurement_list() call from kexec load
to exec, but doesn't register the reboot notifier in this patch.  I
don't see how it is possible with just the previous and this patch
applied that the measurement list is carried across kexec. 

Please test after applying each patch in the patch set to make sure
that the measurement list is properly carried across kexec.

Additional inline comments below.

> ---
>  include/linux/kexec.h              |  3 ++
>  kernel/kexec_file.c                |  8 ++++
>  security/integrity/ima/ima.h       |  2 +
>  security/integrity/ima/ima_kexec.c | 61 +++++++++++++++++++++++++-----
>  security/integrity/ima/ima_queue.c | 19 ++++++++++
>  5 files changed, 84 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 22b5cd24f581..fd94404acc66 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -366,6 +366,9 @@ struct kimage {
>  
>  	phys_addr_t ima_buffer_addr;
>  	size_t ima_buffer_size;
> +
> +	unsigned long ima_segment_index;
> +	bool is_ima_segment_index_set;
>  #endif
>  
>  	/* Core ELF header buffer */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f989f5f1933b..bf758fd5062c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -734,6 +734,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		if (ksegment->kbuf == pi->purgatory_buf)
>  			continue;
>  
> +		/*
> +		 * Skip the segment if ima_segment_index is set and matches
> +		 * the current index
> +		 */
> +		if (image->is_ima_segment_index_set &&
> +		    i == image->ima_segment_index)
> +			continue;

With this change, the IMA segment is not included in the digest
calculation, nor should it be included in the digest verification. 
However, I'm not seeing the matching code change in the digest
verification.

Please make ignoring the IMA segment a separate patch.

>  		ret = crypto_shash_update(desc, ksegment->kbuf,
>  					  ksegment->bufsz);
>  		if (ret)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..49a6047dd8eb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> +void ima_measurements_suspend(void);
> +void ima_measurements_resume(void);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index ae27101d0615..0063d5e7b634 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -16,6 +16,8 @@
>  
>  #ifdef CONFIG_IMA_KEXEC
>  struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static size_t kexec_segment_size;
>  
>  void ima_free_kexec_file_buf(struct seq_file *sf)
>  {
> @@ -120,7 +122,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>  	int ret;
>  
>  	/*
> @@ -145,17 +146,10 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> -	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -					kexec_segment_size);
> -	if (ret < 0) {
> -		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> -		       __func__, ret);
> -		return;
> -	}
> -
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> +	image->is_ima_segment_index_set = false;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -166,10 +160,59 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_addr = kbuf.mem;
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
> +	image->ima_segment_index = image->nr_segments - 1;
> +	image->is_ima_segment_index_set = true;
>  
>  	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>  		 kbuf.mem);
>  }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	void *buf = NULL;
> +	size_t buf_size;
> +	bool resume = false;
> +	int ret = NOTIFY_OK;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("%s: No kexec in progress.\n", __func__);
> +		return ret;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> +		return ret;
> +	}
> +
> +	ima_measurements_suspend();
> +
> +	ret = ima_dump_measurement_list(&buf_size, &buf,
> +					kexec_segment_size);
> +
> +	if (!buf) {
> +		pr_err("%s: Dump measurements failed. Error:%d\n",
> +		       __func__, ret);
> +		resume = true;
> +		goto out;
> +	}
> +	memcpy(ima_kexec_buffer, buf, buf_size);
> +out:
> +	ima_kexec_buffer = NULL;
> +
> +	if (resume)
> +		ima_measurements_resume();
> +
> +	return ret;
> +}
> +
> +struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
>  #endif /* IMA_KEXEC */
>  
>  /*
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 532da87ce519..cb9abc02a304 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
>   */
>  static DEFINE_MUTEX(ima_extend_list_mutex);
>  
> +/*
> + * Used internally by the kernel to suspend-resume ima measurements.
> + */
> +static atomic_t suspend_ima_measurements;
> +
>  /* lookup up the digest value in the hash table, and return the entry */
>  static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  						       int pcr)
> @@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>  	return result;
>  }
>  
> +void ima_measurements_suspend(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	atomic_set(&suspend_ima_measurements, 1);
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
> +void ima_measurements_resume(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	atomic_set(&suspend_ima_measurements, 0);
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +

Suspending and resuming extending the measurement list should be a
separate patch as well, with its own patch description.

>  /*
>   * Add template entry to the measurement list and hash table, and
>   * extend the pcr.

-- 
thanks,

Mimi


