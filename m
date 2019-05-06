Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2414963
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEFMOB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 08:14:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfEFMOB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 08:14:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46CC9Y6140248
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 08:14:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2samqp013v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 08:13:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 13:13:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 13:13:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46CDrlb52363266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 12:13:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0795211C04A;
        Mon,  6 May 2019 12:13:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5FB711C058;
        Mon,  6 May 2019 12:13:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.145])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 12:13:51 +0000 (GMT)
Subject: Re: [PATCH 5/5 v4] removed the LSM hook made available, and renamed
 the ima_policy to be KEXEC_CMDLINE
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com,
        nramas@microsoft.com, prsriva@microsoft.com
Date:   Mon, 06 May 2019 08:13:40 -0400
In-Reply-To: <20190503222523.6294-6-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
         <20190503222523.6294-6-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050612-4275-0000-0000-00000331E297
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050612-4276-0000-0000-00003841499B
Message-Id: <1557144820.14288.95.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-03 at 15:25 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> Per suggestions from the community, removed the LSM hook.
> and renamed the buffer_check func and policy to kexec_cmdline
> [suggested by: Mimi Zohar]

To improve readability of the patches, please fold this patch into the
other patches appropriately.

Mimi


> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>  Documentation/ABI/testing/ima_policy |  2 +-
>  include/linux/ima.h                  |  6 +--
>  include/linux/lsm_hooks.h            |  3 --
>  include/linux/security.h             |  1 -
>  kernel/kexec_core.c                  | 59 +---------------------------
>  kernel/kexec_file.c                  | 14 +------
>  security/integrity/ima/ima.h         |  2 +-
>  security/integrity/ima/ima_api.c     |  2 +-
>  security/integrity/ima/ima_main.c    | 11 +++---
>  security/integrity/ima/ima_policy.c  |  4 +-
>  security/security.c                  |  6 ---
>  11 files changed, 15 insertions(+), 95 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 12cfe3ff2dea..62e7cd687e9c 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,7 +29,7 @@ Description:
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> -				[BUFFER_CHECK]
> +				[KEXEC_CMDLINE]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index f0abade74707..2c7a22231008 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -26,8 +26,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> -extern void ima_buffer_check(const void *buff, int size,
> -				const char *eventname);
> +extern void ima_kexec_cmdline(const void *buff, int size);
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> @@ -94,8 +93,7 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  	return;
>  }
>  
> -static inline void ima_buffer_check(const void *buff, int size,
> -		const char *eventname)
> +static inline void ima_kexec_cmdline(const void *buff, int size)
>  {}
>  #endif /* CONFIG_IMA */
>  
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f18562c1eb24..a240a3fc5fc4 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1672,8 +1672,6 @@ union security_list_options {
>  	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
>  	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
>  
> -	int (*buffer_check)(const void *buff, int size, const char *eventname);
> -
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
>  					struct sock *newsk);
> @@ -1947,7 +1945,6 @@ struct security_hook_heads {
>  	struct hlist_head inode_notifysecctx;
>  	struct hlist_head inode_setsecctx;
>  	struct hlist_head inode_getsecctx;
> -	struct hlist_head buffer_check;
>  #ifdef CONFIG_SECURITY_NETWORK
>  	struct hlist_head unix_stream_connect;
>  	struct hlist_head unix_may_send;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8dece6da0dda..8a129664ba4e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -388,7 +388,6 @@ void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> -void security_buffer_measure(const void *buff, int size, char *eventname);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_lsm_notifier(enum lsm_event event, void *data)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4667f03d406e..8c0a83980d72 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1212,61 +1212,4 @@ void __weak arch_kexec_protect_crashkres(void)
>  {}
>  
>  void __weak arch_kexec_unprotect_crashkres(void)
> -{}
> -
> -/**
> - * kexec_cmdline_prepend_img_name - prepare the buffer with cmdline
> - * that needs to be measured
> - * @outbuf - out buffer that contains the formated string
> - * @kernel_fd - the file identifier for the kerenel image
> - * @cmdline_ptr - ptr to the cmdline buffer
> - * @cmdline_len - len of the buffer.
> - *
> - * This generates a buffer in the format Kerenelfilename::cmdline
> - *
> - * On success return 0.
> - * On failure return -EINVAL.
> - */
> -int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
> -				const char *cmdline_ptr,
> -				unsigned long cmdline_len)
> -{
> -	int ret = -EINVAL;
> -	struct fd f = {};
> -	int size = 0;
> -	char *buf = NULL;
> -	char delimiter[] = "::";
> -
> -	if (!outbuf || !cmdline_ptr)
> -		goto out;
> -
> -	f = fdget(kernel_fd);
> -	if (!f.file)
> -		goto out;
> -
> -	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
> -			ARRAY_SIZE(delimiter)) - 1;
> -
> -	buf = kzalloc(size, GFP_KERNEL);
> -	if (!buf)
> -		goto out;
> -
> -	memcpy(buf, f.file->f_path.dentry->d_name.name,
> -		f.file->f_path.dentry->d_name.len);
> -	memcpy(buf + f.file->f_path.dentry->d_name.len,
> -		delimiter, ARRAY_SIZE(delimiter) - 1);
> -	memcpy(buf + f.file->f_path.dentry->d_name.len +
> -		ARRAY_SIZE(delimiter) - 1,
> -		cmdline_ptr, cmdline_len - 1);
> -
> -	*outbuf = buf;
> -	ret = size;
> -
> -	pr_debug("kexec cmdline buff: %s\n", buf);
> -
> -out:
> -	if (f.file)
> -		fdput(f);
> -
> -	return ret;
> -}
> +{}
> \ No newline at end of file
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index d287e139085c..2eb977984537 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -191,8 +191,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	int ret = 0;
>  	void *ldata;
>  	loff_t size;
> -	char *buff_to_measure = NULL;
> -	int buff_to_measure_size = 0;
>  
>  	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
>  				       &size, INT_MAX, READING_KEXEC_IMAGE);
> @@ -244,15 +242,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			goto out;
>  		}
>  
> -		/* IMA measures the cmdline args passed to the next kernel*/
> -		buff_to_measure_size =
> -			kexec_cmdline_prepend_img_name(&buff_to_measure,
> -			kernel_fd, image->cmdline_buf, image->cmdline_buf_len);
> -
> -		ima_buffer_check(buff_to_measure, buff_to_measure_size,
> -					"kexec_cmdline");
> -
> -
> +		/* IMA measures the cmdline args passed to the next kernel */
> +		ima_kexec_cmdline(image->cmdline_buf, image->cmdline_buf_len - 1);
>  	}
>  
>  	/* Call arch image load handlers */
> @@ -267,7 +258,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  out:
>  
>  	/* In case of error, free up all allocated memory in this function */
> -	kfree(buff_to_measure);
>  	if (ret)
>  		kimage_file_post_load_cleanup(image);
>  	return ret;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index de70df132575..226a26d8de09 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -184,7 +184,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	hook(KEXEC_KERNEL_CHECK)	\
>  	hook(KEXEC_INITRAMFS_CHECK)	\
>  	hook(POLICY_CHECK)		\
> -	hook(BUFFER_CHECK)		\
> +	hook(KEXEC_CMDLINE)		\
>  	hook(MAX_CHECK)
>  #define __ima_hook_enumify(ENUM)	ENUM,
>  
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index cb3f67b366f1..800d965232e5 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -169,7 +169,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
>   *	subj,obj, and type: are LSM specific.
>   *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> - *	| BUFFER_CHECK
> + *	| KEXEC_CMDLINE
>   *	mask: contains the permission mask
>   *	fsmagic: hex value
>   *
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 7362952ab273..fc9cef54e37c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -618,7 +618,7 @@ static int process_buffer_measurement(const void *buff, int size,
>  	if (!buff || size ==  0 || !eventname)
>  		goto err_out;
>  
> -	action = ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr);
> +	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
>  	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
>  		goto err_out;
>  
> @@ -672,21 +672,20 @@ static int process_buffer_measurement(const void *buff, int size,
>  }
>  
>  /**
> - * ima_buffer_check - based on policy, collect & store buffer measurement
> + * ima_kexec_cmdline - based on policy, collect & store buffer measurement
>   * @buf: pointer to buffer
>   * @size: size of buffer
> - * @eventname: event name identifier
>   *
>   * Buffers can only be measured, not appraised.  The buffer identifier
>   * is used as the measurement list entry name (eg. boot_cmdline).
>   */
> -void ima_buffer_check(const void *buf, int size, const char *eventname)
> +void ima_kexec_cmdline(const void *buf, int size)
>  {
>  	u32 secid;
>  
> -	if (buf && size != 0 && eventname) {
> +	if (buf && size != 0) {
>  		security_task_getsecid(current, &secid);
> -		process_buffer_measurement(buf, size, eventname,
> +		process_buffer_measurement(buf, size, "Kexec-cmdline",
>  				current_cred(), secid);
>  	}
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index b12551ed191c..7ae59afbf28f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -875,8 +875,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = KEXEC_INITRAMFS_CHECK;
>  			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
>  				entry->func = POLICY_CHECK;
> -			else if (strcmp(args[0].from, "BUFFER_CHECK") == 0)
> -				entry->func = BUFFER_CHECK;
> +			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
> +				entry->func = KEXEC_CMDLINE;
>  			else
>  				result = -EINVAL;
>  			if (!result)
> diff --git a/security/security.c b/security/security.c
> index 2b575a40470e..23cbb1a295a3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -754,12 +754,6 @@ int security_bprm_check(struct linux_binprm *bprm)
>  	return ima_bprm_check(bprm);
>  }
>  
> -void security_buffer_measure(const void *buff, int size, char *eventname)
> -{
> -	call_void_hook(buffer_check, buff, size, eventname);
> -	return ima_buffer_check(buff, size, eventname);
> -}
> -
>  void security_bprm_committing_creds(struct linux_binprm *bprm)
>  {
>  	call_void_hook(bprm_committing_creds, bprm);

