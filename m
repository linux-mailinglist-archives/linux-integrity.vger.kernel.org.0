Return-Path: <linux-integrity+bounces-860-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5D839772
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 19:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01611F2A71A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA438121F;
	Tue, 23 Jan 2024 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NJ0pXjX1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AA5FDA8
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033923; cv=none; b=Do2RkrR3KOYuA5NhQ2PjdDbKpFjNWhEZbj8oW2Yu37uvYW/MU0bzIvSz69MeVrwSH+mrFb04Zd27IMDVkY1RiJfRFqCNYnQo9s3XokD3RrVqr6M4xdivoGIOlyVQbxxiDUIcvwKxo/pH/QDDUsF90Sruknz4Oo5hnNhmaWI6bFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033923; c=relaxed/simple;
	bh=tRJyL9WfWIJXuimtvj/04YLyMVkytOqfY1r5W1sgJOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RabHkzIqK/LWo9jy9qJaTe6nbJExhCZx39+W54U9yCzAIhJFY8MGdMF0oIZgAeyNmTsc4GZqz4jygDZ65jwBqRKxrSYP28BUu43ROcwHr8pcEXjxkzlT3pVk80s+uPT3XTdwaWl+LR1w/W2H10HpB4hQGvv3Rnkko+nN/X4z1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NJ0pXjX1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGfxAt031948;
	Tue, 23 Jan 2024 18:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=thKzIJqvRB52MBDm+eqDNHw32kf/htRwmQEYyPwJtg8=;
 b=NJ0pXjX1RQGfxP4CUVnAi35BxJmx8I+CpnUWU3fOgJKySnUQVgJqDJMtlC/PDN8LM+hX
 /v1zOtEvshmJzMRopqp8Hs/88iQMfNOcO0kJ4lRR4lRzUtqqOpESEbuSDd8zYrn5jpJa
 X93gY6+HOTRHxrNACXId8HBGPUuL5pcZXnrcZD5QIx1edNblpPCYtpS3U9jF6BQzGAZX
 0oENgXBL25WFitWpfpNCrI5jnRUZAPhnHPpsWVqlJKSvNVUL5T1lbMUo3uk2aHeZXpXR
 uwSWvRUUPpLMpjdUCKs/ml3v3ere2IuIWTAYeznRGUushF311ugwCFtp2AmxzCmM7hR7 /w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtggxkpad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:18:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGnWca028225;
	Tue, 23 Jan 2024 18:18:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72gd8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:18:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NII8PD48628038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 18:18:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1095E5805A;
	Tue, 23 Jan 2024 18:18:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BEA258054;
	Tue, 23 Jan 2024 18:18:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 18:18:06 +0000 (GMT)
Message-ID: <45afcefe-2e12-4e38-906b-cc7c1bc32dcc@linux.ibm.com>
Date: Tue, 23 Jan 2024 13:18:05 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] ima: suspend measurements during buffer copy at
 kexec execute
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-6-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240122183804.3293904-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X7JvSdBl8OIJluoz5nHWVHT7vhJ3AKjN
X-Proofpoint-GUID: X7JvSdBl8OIJluoz5nHWVHT7vhJ3AKjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401230135



On 1/22/24 13:38, Tushar Sugandhi wrote:
> New measurements added to the IMA log while the log is being copied
> during the kexec 'execute' may not get copied over.  This can cause the
> measurement log to be out of sync with the IMA TPM PCR, which could

It could be out of sync with any PCR that IMA extends, most often only 
the IMA TPM PCR.

> result in breaking the integrity of the measurements after kexec soft
> reboot.
> 
> Implement and call the functions ima_measurements_suspend() and
> ima_measurements_resume() from ima_update_kexec_buffer().
> 
> Add a check in the ima_add_template_entry() function not to measure
> events when 'suspend_ima_measurements' flag is set.
> 
> This ensures the integrity of the IMA log while it is being copied over
> to the new Kernel during kexec 'execute'.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   security/integrity/ima/ima.h       |  2 ++
>   security/integrity/ima/ima_kexec.c |  7 +++++++
>   security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..49a6047dd8eb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> +void ima_measurements_suspend(void);
> +void ima_measurements_resume(void);
>   unsigned long ima_get_binary_runtime_size(void);
>   int ima_init_template(void);
>   void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 25150bfc7129..f26b5b342d84 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -179,6 +179,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   	void *buf = NULL;
>   	size_t buf_size;
>   	int ret = NOTIFY_OK;
> +	bool resume = false;
>   
>   	if (!kexec_in_progress) {
>   		pr_info("%s: No kexec in progress.\n", __func__);
> @@ -190,12 +191,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   		return ret;
>   	}
>   
> +	ima_measurements_suspend();
> +
>   	ret = ima_dump_measurement_list(&buf_size, &buf,
>   					kexec_segment_size);
>   
>   	if (!buf) {
>   		pr_err("%s: Dump measurements failed. Error:%d\n",
>   		       __func__, ret);
> +		resume = true;
>   		goto out;
>   	}
>   	memcpy(ima_kexec_buffer, buf, buf_size);
> @@ -203,6 +207,9 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   	kimage_unmap_segment(ima_kexec_buffer);
>   	ima_kexec_buffer = NULL;
>   
> +	if (resume)
> +		ima_measurements_resume();
> +
>   	return ret;
>   }
>   
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 532da87ce519..5946a26a2849 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
>    */
>   static DEFINE_MUTEX(ima_extend_list_mutex);
>   
> +/*
> + * Used internally by the kernel to suspend-resume ima measurements.
> + */
> +static atomic_t suspend_ima_measurements;
> +
>   /* lookup up the digest value in the hash table, and return the entry */
>   static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>   						       int pcr)
> @@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>   	return result;
>   }
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
>   /*
>    * Add template entry to the measurement list and hash table, and
>    * extend the pcr.
> @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>   		}
>   	}
>   
> +	/*
> +	 * suspend_ima_measurements will be set if the system is
> +	 * undergoing kexec soft boot to a new kernel.
> +	 * suspending measurements in this short window ensures the
> +	 * consistency of the IMA measurement list during copying
> +	 * of the kexec buffer.
> +	 */
> +	if (atomic_read(&suspend_ima_measurements)) {
> +		audit_cause = "measurements_suspended";
> +		audit_info = 0;
> +		goto out;
> +	}
> +
>   	result = ima_add_digest_entry(entry,
>   				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>   	if (result < 0) {

