Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3357C7AD8
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Oct 2023 02:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjJMA2l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Oct 2023 20:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMA2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2023 20:28:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE33B7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2023 17:28:38 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D0ElcQ032168;
        Fri, 13 Oct 2023 00:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/ypOCXjj7e/1dSOcT9mtKJsl9KWlFRKZKcB/w1msUng=;
 b=CfEdxM5n4ZJzN6gUfxOfhqk+IlAA9XKCNylIqeNI3fWra5c8vVSbYLIwFrl93XIGAe25
 hRWVAG5rx/LVzkYkr7v5sketw8w+jpeyhcPwd2lFvgr15hwdyqzcK1cs+01n6gvdTQqU
 JrPXWQxGXyVUpmj3D/cFH4UX4eNlocQXNx3v9ytSJ8NeNt+yT63FFP/EcJAC+NlRm1w7
 USU4U+mk0LwLCarTLrvjbdn7FtBSyK0mwN4ftsxJhf5xX+o2jnV5gB/Znpx5iuS0aiDg
 AON81Kko3TNEoTG47m5jARVM/8O1QYe1ZLssUrGCgnFqXAmArKL02u5DramMPbXjLFiF zA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpu678b1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:28:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CN43Fe009040;
        Fri, 13 Oct 2023 00:28:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt57ge5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:28:21 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D0SL1x23986708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 00:28:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5E158056;
        Fri, 13 Oct 2023 00:28:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FC5758052;
        Fri, 13 Oct 2023 00:28:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 13 Oct 2023 00:28:20 +0000 (GMT)
Message-ID: <0c5ce35f-cb45-400e-4485-fac724f6b760@linux.ibm.com>
Date:   Thu, 12 Oct 2023 20:28:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-3-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20231005182602.634615-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gUGISqVrFP8ANBNDuoNbCTsZMgUwgz5i
X-Proofpoint-GUID: gUGISqVrFP8ANBNDuoNbCTsZMgUwgz5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130001
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/5/23 14:25, Tushar Sugandhi wrote:
> In the current IMA implementation, ima_dump_measurement_list() is called
> during the kexec 'load' operation.  This can result in loss of IMA
> measurements taken between the 'load' and 'execute' phases when the
> system goes through Kexec soft reboot to a new Kernel.  The call to the
> function ima_dump_measurement_list() needs to be moved out of the
> function ima_add_kexec_buffer() and needs to be called during the kexec
> 'execute' operation.
>
> Implement a function ima_update_kexec_buffer() that is called during
> kexec 'execute', allowing IMA to update the measurement list with the
> events between kexec 'load' and 'execute'.  Move the
> ima_dump_measurement_list() call from ima_add_kexec_buffer() to
> ima_update_kexec_buffer().  Make ima_kexec_buffer and kexec_segment_size
> variables global, so that they can be accessed during both kexec 'load'
> and 'execute'.  Add functions ima_measurements_suspend() and
> ima_measurements_resume() to set and reset the 'suspend_ima_measurements'
> variable respectively, to suspend/resume IMA measurements.  Use
> the existing 'ima_extend_list_mutex' to ensure that the operations are
> thread-safe.  These function calls will help maintaining the integrity
> of the IMA log while it is being copied to the new Kernel's buffer.
> Add a reboot notifier_block 'update_buffer_nb' to ensure
> the function ima_update_kexec_buffer() gets called during kexec
> soft-reboot.
>
> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/ima.h       |  2 ++
>   security/integrity/ima/ima_kexec.c | 58 +++++++++++++++++++++++++-----
>   security/integrity/ima/ima_queue.c | 18 ++++++++++
>   3 files changed, 69 insertions(+), 9 deletions(-)
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
> index 307e07991865..2c11bbe6efef 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>   #ifdef CONFIG_IMA_KEXEC
>   struct seq_file ima_kexec_file;
>   struct ima_kexec_hdr ima_khdr;
> +static void *ima_kexec_buffer;
> +static size_t kexec_segment_size;
>   
>   void ima_clear_kexec_file(void)
>   {
> @@ -142,7 +144,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	/* use more understandable variable names than defined in kbuf */
>   	void *kexec_buffer = NULL;
>   	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>   	int ret;
>   
>   	/*
> @@ -167,14 +168,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> -	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -					kexec_segment_size);
> -	if (ret < 0) {
> -		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> -		       __func__, ret);
> -		return;
> -	}
> -
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;
> @@ -192,6 +185,53 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		 kbuf.mem);
>   }
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
> +	int ret;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("%s: No kexec in progress.\n", __func__);
> +		return NOTIFY_OK;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> +		return NOTIFY_OK;
> +	}
> +
> +	ima_measurements_suspend();
> +
> +	buf_size = ima_get_binary_runtime_size();
There doesn't seem to be a need to call this function and pass in the 
binary runtime size into the dump function. You should be able to remove it.
> +	ret = ima_dump_measurement_list(&buf_size, &buf,
> +					kexec_segment_size);
> +
> +	if (!buf || ret < 0) {
I don't think this function can (or should) ever return ret >= 0 with 
buf == NULL.
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
> +	return NOTIFY_OK;
> +}
> +struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
>   #endif /* IMA_KEXEC */
>   
>   /*
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 532da87ce519..9e7d1196006e 100644
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
> @@ -147,6 +152,19 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>   		pr_err("Error Communicating to TPM chip, result: %d\n", result);
>   	return result;
>   }
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
>   
>   /*
>    * Add template entry to the measurement list and hash table, and
