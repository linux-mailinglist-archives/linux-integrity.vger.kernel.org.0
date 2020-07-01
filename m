Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4760A2105C0
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2020 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgGAIEx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Jul 2020 04:04:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27943 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728630AbgGAIEh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593590674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kCynkoFy3XzG6kNN02gtrhqcsZ1FKd7XfZ+X5cMlfpk=;
        b=JuA8nZ/rfkm3MVC+Ke9yWTY9Cbb8ZfRx2Bgk4W+J2dgfK2bxaDl4TyN1vFoIGh+2kgMf6M
        up2m6Uv+P35pGe51MfHNHtm3jVVBawSJ/ZrMvXMcbbKKteq0Gh+UwPS9xhqs+imCqfHu+g
        ZckbjRJFBfWKhYzx+yf4SQi4Ym9PSq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-2H4RS7wNPJ2dbCKECCFJ1g-1; Wed, 01 Jul 2020 04:04:27 -0400
X-MC-Unique: 2H4RS7wNPJ2dbCKECCFJ1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0411E87950B;
        Wed,  1 Jul 2020 08:04:26 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33215BEA5;
        Wed,  1 Jul 2020 08:04:19 +0000 (UTC)
Date:   Wed, 1 Jul 2020 16:04:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        kexec@lists.infradead.org, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-integrity@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 11/11] ima: Support additional conditionals in the
 KEXEC_CMDLINE hook function
Message-ID: <20200701080416.GC3878@dhcp-128-65.nay.redhat.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-12-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626223900.253615-12-tyhicks@linux.microsoft.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,
On 06/26/20 at 05:39pm, Tyler Hicks wrote:
> Take the properties of the kexec kernel's inode and the current task
> ownership into consideration when matching a KEXEC_CMDLINE operation to
> the rules in the IMA policy. This allows for some uniformity when
> writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> and KEXEC_CMDLINE operations.
> 
> Prior to this patch, it was not possible to write a set of rules like
> this:
> 
>  dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
>  dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
>  dont_measure func=KEXEC_CMDLINE obj_type=foo_t
>  measure func=KEXEC_KERNEL_CHECK
>  measure func=KEXEC_INITRAMFS_CHECK
>  measure func=KEXEC_CMDLINE
> 
> The inode information associated with the kernel being loaded by a
> kexec_kernel_load(2) syscall can now be included in the decision to
> measure or not
> 
> Additonally, the uid, euid, and subj_* conditionals can also now be
> used in KEXEC_CMDLINE rules. There was no technical reason as to why
> those conditionals weren't being considered previously other than
> ima_match_rules() didn't have a valid inode to use so it immediately
> bailed out for KEXEC_CMDLINE operations rather than going through the
> full list of conditional comparisons.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> ---
> 
> * v2
>   - Moved the inode parameter of process_buffer_measurement() to be the
>     first parameter so that it more closely matches process_masurement()
> 
>  include/linux/ima.h                          |  4 ++--
>  kernel/kexec_file.c                          |  2 +-
>  security/integrity/ima/ima.h                 |  2 +-
>  security/integrity/ima/ima_api.c             |  2 +-
>  security/integrity/ima/ima_appraise.c        |  2 +-
>  security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>  security/integrity/ima/ima_main.c            | 23 +++++++++++++++-----
>  security/integrity/ima/ima_policy.c          | 17 +++++----------
>  security/integrity/ima/ima_queue_keys.c      |  2 +-
>  9 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 9164e1534ec9..d15100de6cdd 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -25,7 +25,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> -extern void ima_kexec_cmdline(const void *buf, int size);
> +extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> @@ -103,7 +103,7 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void ima_kexec_cmdline(const void *buf, int size) {}
> +static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index bb05fd52de85..07df431c1f21 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -287,7 +287,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			goto out;
>  		}
>  
> -		ima_kexec_cmdline(image->cmdline_buf,
> +		ima_kexec_cmdline(kernel_fd, image->cmdline_buf,
>  				  image->cmdline_buf_len - 1);
>  	}
>  
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 59ec28f5c117..ff2bf57ff0c7 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -265,7 +265,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
>  			   struct ima_template_desc *template_desc);
> -void process_buffer_measurement(const void *buf, int size,
> +void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
>  				int pcr, const char *keyring);
>  void ima_audit_measurement(struct integrity_iint_cache *iint,
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index bf22de8b7ce0..4f39fb93f278 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -162,7 +162,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>  
>  /**
>   * ima_get_action - appraise & measure decision based on policy.
> - * @inode: pointer to inode to measure
> + * @inode: pointer to the inode associated with the object being validated
>   * @cred: pointer to credentials structure to validate
>   * @secid: secid of the task being validated
>   * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a9649b04b9f1..6c52bf7ea7f0 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -328,7 +328,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>  
>  		rc = is_binary_blacklisted(digest, digestsize);
>  		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> -			process_buffer_measurement(digest, digestsize,
> +			process_buffer_measurement(NULL, digest, digestsize,
>  						   "blacklisted-hash", NONE,
>  						   pcr, NULL);
>  	}
> diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> index aaae80c4e376..1c68c500c26f 100644
> --- a/security/integrity/ima/ima_asymmetric_keys.c
> +++ b/security/integrity/ima/ima_asymmetric_keys.c
> @@ -58,7 +58,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  	 * if the IMA policy is configured to measure a key linked
>  	 * to the given keyring.
>  	 */
> -	process_buffer_measurement(payload, payload_len,
> +	process_buffer_measurement(NULL, payload, payload_len,
>  				   keyring->description, KEY_CHECK, 0,
>  				   keyring->description);
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8351b2fd48e0..8a91711ca79b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -726,6 +726,7 @@ int ima_load_data(enum kernel_load_data_id id)
>  
>  /*
>   * process_buffer_measurement - Measure the buffer to ima log.
> + * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
>   * @buf: pointer to the buffer that needs to be added to the log.
>   * @size: size of buffer(in bytes).
>   * @eventname: event name to be used for the buffer entry.
> @@ -735,7 +736,7 @@ int ima_load_data(enum kernel_load_data_id id)
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
> -void process_buffer_measurement(const void *buf, int size,
> +void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
>  				int pcr, const char *keyring)
>  {
> @@ -768,7 +769,7 @@ void process_buffer_measurement(const void *buf, int size,
>  	 */
>  	if (func) {
>  		security_task_getsecid(current, &secid);
> -		action = ima_get_action(NULL, current_cred(), secid, 0, func,
> +		action = ima_get_action(inode, current_cred(), secid, 0, func,
>  					&pcr, &template, keyring);
>  		if (!(action & IMA_MEASURE))
>  			return;
> @@ -823,16 +824,26 @@ void process_buffer_measurement(const void *buf, int size,
>  
>  /**
>   * ima_kexec_cmdline - measure kexec cmdline boot args
> + * @kernel_fd: file descriptor of the kexec kernel being loaded
>   * @buf: pointer to buffer
>   * @size: size of buffer
>   *
>   * Buffers can only be measured, not appraised.
>   */
> -void ima_kexec_cmdline(const void *buf, int size)
> +void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  {
> -	if (buf && size != 0)
> -		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   KEXEC_CMDLINE, 0, NULL);
> +	struct fd f;
> +
> +	if (!buf || !size)
> +		return;
> +
> +	f = fdget(kernel_fd);
> +	if (!f.file)
> +		return;
> +
> +	process_buffer_measurement(file_inode(f.file), buf, size,
> +				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
> +	fdput(f);
>  }
>  
>  static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 5eb14b567a31..294323b36d06 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -443,13 +443,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> -	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
> -		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
> -			if (func == KEY_CHECK)
> -				return ima_match_keyring(rule, keyring, cred);
> -			return true;
> -		}
> -		return false;
> +	if (func == KEY_CHECK) {
> +		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> +		       ima_match_keyring(rule, keyring, cred);
>  	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
> @@ -1007,10 +1003,9 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  			if (entry->action & ~(MEASURE | DONT_MEASURE))
>  				return false;
>  
> -			if (entry->flags & ~(IMA_FUNC | IMA_PCR))
> -				return false;
> -
> -			if (ima_rule_contains_lsm_cond(entry))
> +			if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
> +					     IMA_FOWNER | IMA_FSUUID |
> +					     IMA_EUID | IMA_PCR | IMA_FSNAME))
>  				return false;
>  
>  			break;
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index 56ce24a18b66..69a8626a35c0 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -158,7 +158,7 @@ void ima_process_queued_keys(void)
>  
>  	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
>  		if (!timer_expired)
> -			process_buffer_measurement(entry->payload,
> +			process_buffer_measurement(NULL, entry->payload,
>  						   entry->payload_len,
>  						   entry->keyring_name,
>  						   KEY_CHECK, 0,
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

Although I still do not understand the deep knowledge of IMA, I
still wonder to know what is the effect to the behavior changes end user
visible.   Does it work with a kernel built-in commandline? eg no
cmdlien passed at all.

Thanks
Dave

