Return-Path: <linux-integrity+bounces-1386-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208985FC50
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691EB28BC90
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Feb 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54921149013;
	Thu, 22 Feb 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eYqwki7v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83A1482E9
	for <linux-integrity@vger.kernel.org>; Thu, 22 Feb 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615612; cv=none; b=VCNb7oR84IugZ7PEGbUteUMv0KHgY/ztCQji3MMx+LbVO8wPF/yjI0bImlh28nIjoggISJMMoXgfYIHIt/51UPqLQlo/4y8gC3hRBAos4wyte/oX3h3qxCV7kt5p2Nw6mMxZv9PsNv/+bVrw4HqoPayYtiC1RnaVK+4wQFgOBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615612; c=relaxed/simple;
	bh=yPs/9MCvAEgPU2dL0rz5lIwinxZXUcQ/O1O6wj9tT9c=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:Mime-Version; b=jfqTwnJe3qKbxmPz6aRrAQmuOBfMa5Q2IteXSV6Sxi4uMN50voNuUC1oPxWD9BuEyOmwAat4F23ehW/T2juL3c0odec7TCFT4F6ZMXExBDB98zjCz0Au9nj+KIEy/LWIHpBydLP0lD0Sa6HCrx0hK3oVmuQB5Me3wT1TzOiLy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eYqwki7v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MF7AiQ025669;
	Thu, 22 Feb 2024 15:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : date :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4c5Ch3b5+d7XfrRUSS2n7mwD85IKo3ivrFMXtB1Q1z4=;
 b=eYqwki7vXgfNX6B0sTpBGetEBrj4832MwnjBtS1JRd3T6c0w8dkx8DdZVLtMtLEitGqa
 3xvfQTsrN1df/j6HU/ULJmaCjzzSWuWYHRMy0lpYWuL4JT7uP5vQFfKTkZPySnLjYkrD
 2gM34SlJ6WOpFvtCCSfwRY7itlk2cOtzwUVo/EunURmH+bjWl4lUI5enj6gvkDoHRy0Q
 r7ZQ54HglB/LWkT5y9mn5/MPcdxUi0Zn89h6poI0jpbXSoI13coMorpOKcYm3RwkqqbI
 9sNbncv/pbda1E7w1A+sskP//MGSQoJmQbUobL3H2gV3f8Rfy0p2yA7MgYybBaUjq6Ye Zw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we8mkghdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:26:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MDpI2R003596;
	Thu, 22 Feb 2024 15:26:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tya2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:26:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41MFQF1O7209478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 15:26:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B803858045;
	Thu, 22 Feb 2024 15:26:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9161058068;
	Thu, 22 Feb 2024 15:26:14 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.99.109])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 15:26:14 +0000 (GMT)
Message-ID: <cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/8] ima: suspend measurements during buffer copy at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
In-Reply-To: <20240214153827.1087657-7-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-7-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Feb 2024 09:14:36 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2dd6iHc-c8TSKOXOb2vcu3SPHgn0BThY
X-Proofpoint-ORIG-GUID: 2dd6iHc-c8TSKOXOb2vcu3SPHgn0BThY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220123

Hi Tushar,

On Wed, 2024-02-14 at 07:38 -0800, Tushar Sugandhi wrote:
> New measurements added to the IMA log while the log is being copied
> during the kexec 'execute' may not get copied over.

As long as there is enough memory for the additional records, isn't the problem
"after" copying the mesaurement list records, not during?

> This can cause the
> measurement log to be out of sync with the TPM PCRs that IMA extends,
> which could result in breaking the integrity of the measurements after
> kexec soft reboot.
> 
> Implement and call the functions ima_measurements_suspend() and 
> ima_measurements_resume() from ima_update_kexec_buffer().

After copying the measurement list records, would not be the time to resume
taking additional measurements.

> Add a check in the ima_add_template_entry() function not to measure
> events when 'suspend_ima_measurements' flag is set.
> 
> This ensures the integrity of the IMA log while it is being copied over
> to the new Kernel during kexec 'execute'.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h       |  2 ++
>  security/integrity/ima/ima_kexec.c |  7 +++++++
>  security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..49a6047dd8eb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct
> ima_template_desc *ima_template);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> +void ima_measurements_suspend(void);
> +void ima_measurements_resume(void);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index 98fc9b9782a2..dbeeb7f1355e 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -184,6 +184,7 @@ static int ima_update_kexec_buffer(struct notifier_block
> *self,
>  	void *buf = NULL;
>  	size_t buf_size;
>  	int ret = NOTIFY_OK;
> +	bool resume = false;
>  
>  	if (!kexec_in_progress) {
>  		pr_info("%s: No kexec in progress.\n", __func__);
> @@ -195,12 +196,15 @@ static int ima_update_kexec_buffer(struct notifier_block
> *self,
>  		return ret;
>  	}
>  
> +	ima_measurements_suspend();
> +
>  	ret = ima_dump_measurement_list(&buf_size, &buf,
>  					kexec_segment_size);
>  
>  	if (!buf) {
>  		pr_err("%s: Dump measurements failed. Error:%d\n",
>  		       __func__, ret);
> +		resume = true;

Only on failure to copy the measurement list records will measurements be
"resumed".  Measurements will be suspended from when the IMA reboot notifier is
called until reboot.

The patch suject line, description and comments don't match the code.  There is
no "during buffer copy" in "ima: suspend measurements during buffer copy at
kexec execute".  Measurements are suspended.

The question is whether you could suspend measurements a bit later, just after
copying the measurement records.

>  		goto out;
>  	}
>  	memcpy(ima_kexec_buffer, buf, buf_size);
> @@ -208,6 +212,9 @@ static int ima_update_kexec_buffer(struct notifier_block
> *self,
>  	kimage_unmap_segment(ima_kexec_buffer);
>  	ima_kexec_buffer = NULL;
>  
> +	if (resume)
> +		ima_measurements_resume();
> +

What is the point in resuming the measurement list on failure to copy them?

>  	return ret;
>  }
>  
> diff --git a/security/integrity/ima/ima_queue.c
> b/security/integrity/ima/ima_queue.c
> index 532da87ce519..5946a26a2849 100644
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
> @@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg,
> int pcr)
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
>  /*
>   * Add template entry to the measurement list and hash table, and
>   * extend the pcr.
> @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry
> *entry, int violation,
>  		}
>  	}
>  
> +	/*
> +	 * suspend_ima_measurements will be set if the system is
> +	 * undergoing kexec soft boot to a new kernel.
> +	 * suspending measurements in this short window ensures the
> +	 * consistency of the IMA measurement list during copying
> +	 * of the kexec buffer.
> +	 */

Either remove the 2nd sentence "suspending measurements in this short window
..." or explain what is meant by "short window".

Mimi

> +	if (atomic_read(&suspend_ima_measurements)) {
> +		audit_cause = "measurements_suspended";
> +		audit_info = 0;
> +		goto out;
> +	}
> +
>  	result = ima_add_digest_entry(entry,
>  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>  	if (result < 0) {


