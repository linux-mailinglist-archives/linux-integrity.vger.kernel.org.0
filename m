Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C131208D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEBQwW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 12:52:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbfEBQwV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 12:52:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42GgSVq051857
        for <linux-integrity@vger.kernel.org>; Thu, 2 May 2019 12:52:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s83q9tbqw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 May 2019 12:52:19 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 May 2019 17:52:18 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 17:52:15 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42GqEAM50725064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 16:52:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A283AE053;
        Thu,  2 May 2019 16:52:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73619AE051;
        Thu,  2 May 2019 16:52:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.175])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 16:52:13 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] added a new ima policy func buffer_check, and
 ima hook to measure the buffer hash into ima
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com
Date:   Thu, 02 May 2019 12:52:02 -0400
In-Reply-To: <20190429214743.4625-2-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
         <20190429214743.4625-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050216-0012-0000-0000-00000317A1FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050216-0013-0000-0000-000021501213
Message-Id: <1556815922.4134.76.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020109
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-04-29 at 14:47 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> added a new ima policy func buffer_check, and ima hook to
>  measure the buffer hash into ima logs.

When defining a new LSN/IMA hook please conform to the existing naming
conventions.  Generally LSM hooks are specific to a particular
function.  In this instance, the name of the hook would be something
like security_kexec_cmdline() or ima_kexec_cmdline(), which would call
the generic process_buffer_measurement() you've defined.

Mimi

> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>  Documentation/ABI/testing/ima_policy |  1 +
>  include/linux/ima.h                  |  5 ++
>  security/integrity/ima/ima.h         |  1 +
>  security/integrity/ima/ima_api.c     |  1 +
>  security/integrity/ima/ima_main.c    | 89 ++++++++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c  |  8 +++
>  6 files changed, 105 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 74c6702de74e..12cfe3ff2dea 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,6 +29,7 @@ Description:
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> +				[BUFFER_CHECK]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index dc12fbcf484c..f0abade74707 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -26,6 +26,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> +extern void ima_buffer_check(const void *buff, int size,
> +				const char *eventname);
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> @@ -92,6 +94,9 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  	return;
>  }
>  
> +static inline void ima_buffer_check(const void *buff, int size,
> +		const char *eventname)
> +{}
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..de70df132575 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -184,6 +184,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	hook(KEXEC_KERNEL_CHECK)	\
>  	hook(KEXEC_INITRAMFS_CHECK)	\
>  	hook(POLICY_CHECK)		\
> +	hook(BUFFER_CHECK)		\
>  	hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)	ENUM,
>  
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c7505fb122d4..cb3f67b366f1 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -169,6 +169,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
>   *	subj,obj, and type: are LSM specific.
>   *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> + *	| BUFFER_CHECK
>   *	mask: contains the permission mask
>   *	fsmagic: hex value
>   *
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..3db3f3966ac7 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -576,6 +576,95 @@ int ima_load_data(enum kernel_load_data_id id)
>  	return 0;
>  }
>  
> +/*
> + * process_buffer_measurement - Measure the buffer passed to ima log.
> + * (Instead of using the file hash the buffer hash is used).
> + * @buff - The buffer that needs to be added to the log
> + * @size - size of buffer(in bytes)
> + * @eventname - this is eventname used for the various buffers
> + * that can be measured.
> + *
> + * The buffer passed is added to the ima logs.
> + * If the sig template is used, then the sig field contains the buffer.
> + *
> + * On success return 0.
> + * On error cases surface errors from ima calls.
> + */
> +static int process_buffer_measurement(const void *buff, int size,
> +				const char *eventname, const struct cred *cred,
> +				u32 secid)
> +{
> +	int ret = -EINVAL;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {iint, NULL, NULL,
> +					    NULL, 0, NULL};
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash;
> +	int violation = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +
> +	if (!buff || size ==  0 || !eventname)
> +		goto err_out;
> +
> +	if (ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr)
> +		!= IMA_MEASURE)
> +		goto err_out;
> +
> +	memset(iint, 0, sizeof(*iint));
> +	memset(&hash, 0, sizeof(hash));
> +
> +	event_data.filename = eventname;
> +
> +	iint->ima_hash = &hash.hdr;
> +	iint->ima_hash->algo = ima_hash_algo;
> +	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +	ret = ima_calc_buffer_hash(buff, size, iint->ima_hash);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	ret = ima_alloc_init_template(&event_data, &entry);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	ret = ima_store_template(entry, violation, NULL,
> +					buff, pcr);
> +	if (ret < 0) {
> +		ima_free_template_entry(entry);
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	pr_err("Error in adding buffer measure: %d\n", ret);
> +	return ret;
> +}
> +
> +/**
> + * ima_buffer_check - based on policy, collect & store buffer measurement
> + * @buf: pointer to buffer
> + * @size: size of buffer
> + * @eventname: event name identifier
> + *
> + * Buffers can only be measured, not appraised.  The buffer identifier
> + * is used as the measurement list entry name (eg. boot_cmdline).
> + */
> +void ima_buffer_check(const void *buf, int size, const char *eventname)
> +{
> +	u32 secid;
> +
> +	if (buf && size != 0 && eventname) {
> +		security_task_getsecid(current, &secid);
> +		process_buffer_measurement(buf, size, eventname,
> +				current_cred(), secid);
> +	}
> +}
> +
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..b12551ed191c 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -291,6 +291,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> +	// Incase of BUFFER_CHECK, Inode is NULL
> +	if (!inode) {
> +		if ((rule->flags & IMA_FUNC) && (rule->func == func))
> +			return true;
> +		return false;
> +	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
>  		return false;
> @@ -869,6 +875,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = KEXEC_INITRAMFS_CHECK;
>  			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
>  				entry->func = POLICY_CHECK;
> +			else if (strcmp(args[0].from, "BUFFER_CHECK") == 0)
> +				entry->func = BUFFER_CHECK;
>  			else
>  				result = -EINVAL;
>  			if (!result)

