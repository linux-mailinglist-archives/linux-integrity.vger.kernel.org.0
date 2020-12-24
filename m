Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7BD2E22E0
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Dec 2020 01:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgLXAEP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 19:04:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgLXAEP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 19:04:15 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BO02rK1170192;
        Wed, 23 Dec 2020 19:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tLvO6SEvcChgdZNNMk9EMe9BKdPJmunmiub1yKoe5Bs=;
 b=C3Ebt7sSjC1YF6KKNFurFd0Nss6ZeoFAToX1WBUtuvn7UrMj80OHkoZfWByo7RdWGghW
 oGvYZXY0OdqQNeeaOsbPOmA/Cc5A2vQYWm1PniCnlLuyeGvCLCMUMucTbmJDmVxXCQJ9
 AM+dCO2WApOh1uWfZkaUGauvMNFg/0uyp2+V00VCWLm/O7UqTwI0Gvqho9XYykXaMMSm
 UpnKFtWTXP/RPQFAE/s/a7SPMKtlbTtF4+VIoxYglGordiJfCF2zUum7EIIdUqeiD5wh
 cjhfe5jF7/2RtBGasRV7xaie5Is8FOQ/3tobradbebO6otOReuMvAKcqHU8BbRSguInm 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35mff78mdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 19:03:27 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BO03RjI174558;
        Wed, 23 Dec 2020 19:03:27 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35mff78mcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 19:03:27 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BO02rW6029657;
        Thu, 24 Dec 2020 00:03:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 35h8sh4dhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Dec 2020 00:03:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BO03NcW43712808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Dec 2020 00:03:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3961652057;
        Thu, 24 Dec 2020 00:03:23 +0000 (GMT)
Received: from sig-9-65-213-118.ibm.com (unknown [9.65.213.118])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 930335204E;
        Thu, 24 Dec 2020 00:03:19 +0000 (GMT)
Message-ID: <4e83480731b937cea479f688029560444b9cb66a.camel@linux.ibm.com>
Subject: Re: [PATCH v9 2/8] IMA: add support to measure buffer data hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Wed, 23 Dec 2020 19:03:18 -0500
In-Reply-To: <20201212180251.9943-3-tusharsu@linux.microsoft.com>
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
         <20201212180251.9943-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_14:2020-12-23,2020-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230164
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
> The original IMA buffer data measurement sizes were small (e.g. boot
> command line), but the new buffer data measurement use cases have data 
> sizes that are a lot larger.  Just as IMA measures the file data hash,
> not the file data, IMA should similarly support the option for measuring 
> the hash of the buffer data.
> 
> Measuring in-memory buffer-data/buffer-data-hash is different than
> measuring file-data/file-data-hash. For the file, IMA stores the
> measurements in both measurement log and the file's extended attribute -
> which can later be used for appraisal as well. For buffer, the
> measurements are only stored in the IMA log, since the buffer has no
> extended attributes associated with it.

By definition, buffer data is only measured.  Nothing new is added by
the above paragraph.  Please remove it.

> 
> Introduce a boolean parameter measure_buf_hash to support measuring
> hash of a buffer, which would be much smaller, instead of the buffer
> itself.

Like the patch Subject line use "the buffer data hash" instead of the
"hash of a buffer".

There's no need to include the boolean parameter name
"measure_buf_hash".  Please remove it.

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h                 |  3 +-
>  security/integrity/ima/ima_appraise.c        |  2 +-
>  security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>  security/integrity/ima/ima_main.c            | 38 +++++++++++++++++---
>  security/integrity/ima/ima_queue_keys.c      |  3 +-
>  5 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e5622ce8cbb1..fa3044a7539f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -268,7 +268,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>  			   struct ima_template_desc *template_desc);
>  void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *func_data);
> +				int pcr, const char *func_data,
> +				bool measure_buf_hash);

Please abbreviate the boolean name to "hash".   The test would then be
"if (hash == true)" or "if (hash)".

>  void ima_audit_measurement(struct integrity_iint_cache *iint,
>  			   const unsigned char *filename);
>  int ima_alloc_init_template(struct ima_event_data *event_data,
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 8361941ee0a1..46ffa38bab12 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -352,7 +352,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>  		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
>  			process_buffer_measurement(NULL, digest, digestsize,
>  						   "blacklisted-hash", NONE,
> -						   pcr, NULL);
> +						   pcr, NULL, false);
>  	}
>  
>  	return rc;
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index 1c68c500c26f..a74095793936 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -60,5 +60,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	 */
>  	process_buffer_measurement(NULL, payload, payload_len,
>  				   keyring->description, KEY_CHECK, 0,
> -				   keyring->description);
> +				   keyring->description, false);
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e76ef4bfd0f4..0f8409d77602 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -779,7 +779,7 @@ int ima_post_load_data(char *buf, loff_t size,
>  }
>  
>  /*
> - * process_buffer_measurement - Measure the buffer to ima log.
> + * process_buffer_measurement - Measure the buffer or the buffer data hash
>   * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
>   * @buf: pointer to the buffer that needs to be added to the log.
>   * @size: size of buffer(in bytes).
> @@ -787,12 +787,23 @@ int ima_post_load_data(char *buf, loff_t size,
>   * @func: IMA hook
>   * @pcr: pcr to extend the measurement
>   * @func_data: private data specific to @func, can be NULL.
> + * @measure_buf_hash: measure buffer hash

^@hash: measure buffer data hash

>   *
> - * Based on policy, the buffer is measured into the ima log.
> + * Measure the buffer into the IMA log, and extend the @pcr.

IMA always measures/appraises files and measures buffer data based on
policy.  The above sentence succintly summarizes what
process_buffer_measurement() does.   This patch adds support for
measuring the "buffer data hash".   The following would be an
appropriate change.

* Based on policy, either the buffer data or buffer data hash is
measured

> + *
> + * Determine what buffers are allowed to be measured, based on the policy rules
> + * and the IMA hook passed using @func.
> + *
> + * Use @func_data, if provided, to match against the measurement policy rule
> + * data for @func.
> + *
> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
> + * else measure the buffer data itself.

This patch should be limited to adding "buffer data hash" support. 
These changes don't belong in this patch.  Please remove.

>   */
>  void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *func_data)
> +				int pcr, const char *func_data,
> +				bool measure_buf_hash)
>  {
>  	int ret = 0;
>  	const char *audit_cause = "ENOMEM";
> @@ -807,6 +818,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
>  	} hash = {};
> +	char buf_hash[IMA_MAX_DIGEST_SIZE];
> +	int buf_hash_len = hash_digest_size[ima_hash_algo];
>  	int violation = 0;
>  	int action = 0;
>  	u32 secid;
> @@ -849,13 +862,27 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  		goto out;
>  	}
>  
> +	if (measure_buf_hash) {

^ if (hash) {
> +		memcpy(buf_hash, hash.hdr.digest, buf_hash_len);
> +
> +		ret = ima_calc_buffer_hash(buf_hash, buf_hash_len,
> +					   iint.ima_hash);
> +		if (ret < 0) {
> +			audit_cause = "measure_buf_hash_error";

I don't see a good no reason for defining a new audit cause.  Use the
existing "hashing_error".

thanks,

Mimi

> +			goto out;
> +		}
> +
> +		event_data.buf = buf_hash;
> +		event_data.buf_len = buf_hash_len;
> +	}
> +
>  	ret = ima_alloc_init_template(&event_data, &entry, template);
>  	if (ret < 0) {
>  		audit_cause = "alloc_entry";
>  		goto out;
>  	}
>  
> -	ret = ima_store_template(entry, violation, NULL, buf, pcr);
> +	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
>  	if (ret < 0) {
>  		audit_cause = "store_entry";
>  		ima_free_template_entry(entry);
> @@ -890,7 +917,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  		return;
>  
>  	process_buffer_measurement(file_inode(f.file), buf, size,
> -				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
> +				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL,
> +				   false);
>  	fdput(f);
>  }
>  
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index 69a8626a35c0..c2f2ad34f9b7 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -162,7 +162,8 @@ void ima_process_queued_keys(void)
>  						   entry->payload_len,
>  						   entry->keyring_name,
>  						   KEY_CHECK, 0,
> -						   entry->keyring_name);
> +						   entry->keyring_name,
> +						   false);
>  		list_del(&entry->list);
>  		ima_free_key_entry(entry);
>  	}


