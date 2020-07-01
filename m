Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93D210DE1
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2020 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGAOi6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Jul 2020 10:38:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44218 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGAOi6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jul 2020 10:38:58 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C88CF20B717A;
        Wed,  1 Jul 2020 07:38:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C88CF20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593614335;
        bh=XI2DYzqVH+85ZlYkvoBj3U6K4g5Gt6k9k4N9Zb/43/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr0xM2dPU+ABOnfSwdPnDi7HE8X3JbRVI1astupYEFqoBABy2Ty7qbs0vaRdC3gX/
         AN0xls0BvLNj5qw5/iyGAemLhZa1pngHWt4beQG+B9OXd4KgTTQlJrJQ6hyShyEQfX
         QD3vkkyenTtvmKVr75LRgtr0+1FLeQeXib44MCdY=
Date:   Wed, 1 Jul 2020 09:38:52 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dave Young <dyoung@redhat.com>
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
Message-ID: <20200701143852.GG4694@sequoia>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-12-tyhicks@linux.microsoft.com>
 <20200701080416.GC3878@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701080416.GC3878@dhcp-128-65.nay.redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-01 16:04:16, Dave Young wrote:
> Hi,
> On 06/26/20 at 05:39pm, Tyler Hicks wrote:
> > Take the properties of the kexec kernel's inode and the current task
> > ownership into consideration when matching a KEXEC_CMDLINE operation to
> > the rules in the IMA policy. This allows for some uniformity when
> > writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> > and KEXEC_CMDLINE operations.
> > 
> > Prior to this patch, it was not possible to write a set of rules like
> > this:
> > 
> >  dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
> >  dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
> >  dont_measure func=KEXEC_CMDLINE obj_type=foo_t
> >  measure func=KEXEC_KERNEL_CHECK
> >  measure func=KEXEC_INITRAMFS_CHECK
> >  measure func=KEXEC_CMDLINE
> > 
> > The inode information associated with the kernel being loaded by a
> > kexec_kernel_load(2) syscall can now be included in the decision to
> > measure or not
> > 
> > Additonally, the uid, euid, and subj_* conditionals can also now be
> > used in KEXEC_CMDLINE rules. There was no technical reason as to why
> > those conditionals weren't being considered previously other than
> > ima_match_rules() didn't have a valid inode to use so it immediately
> > bailed out for KEXEC_CMDLINE operations rather than going through the
> > full list of conditional comparisons.
> > 
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: kexec@lists.infradead.org
> > ---
> > 
> > * v2
> >   - Moved the inode parameter of process_buffer_measurement() to be the
> >     first parameter so that it more closely matches process_masurement()
> > 
> >  include/linux/ima.h                          |  4 ++--
> >  kernel/kexec_file.c                          |  2 +-
> >  security/integrity/ima/ima.h                 |  2 +-
> >  security/integrity/ima/ima_api.c             |  2 +-
> >  security/integrity/ima/ima_appraise.c        |  2 +-
> >  security/integrity/ima/ima_asymmetric_keys.c |  2 +-
> >  security/integrity/ima/ima_main.c            | 23 +++++++++++++++-----
> >  security/integrity/ima/ima_policy.c          | 17 +++++----------
> >  security/integrity/ima/ima_queue_keys.c      |  2 +-
> >  9 files changed, 31 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 9164e1534ec9..d15100de6cdd 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -25,7 +25,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >  			      enum kernel_read_file_id id);
> >  extern void ima_post_path_mknod(struct dentry *dentry);
> >  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> > -extern void ima_kexec_cmdline(const void *buf, int size);
> > +extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> >  extern void ima_add_kexec_buffer(struct kimage *image);
> > @@ -103,7 +103,7 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > -static inline void ima_kexec_cmdline(const void *buf, int size) {}
> > +static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
> >  #endif /* CONFIG_IMA */
> >  
> >  #ifndef CONFIG_IMA_KEXEC
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index bb05fd52de85..07df431c1f21 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -287,7 +287,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >  			goto out;
> >  		}
> >  
> > -		ima_kexec_cmdline(image->cmdline_buf,
> > +		ima_kexec_cmdline(kernel_fd, image->cmdline_buf,
> >  				  image->cmdline_buf_len - 1);
> >  	}
> >  
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index 59ec28f5c117..ff2bf57ff0c7 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -265,7 +265,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
> >  			   struct evm_ima_xattr_data *xattr_value,
> >  			   int xattr_len, const struct modsig *modsig, int pcr,
> >  			   struct ima_template_desc *template_desc);
> > -void process_buffer_measurement(const void *buf, int size,
> > +void process_buffer_measurement(struct inode *inode, const void *buf, int size,
> >  				const char *eventname, enum ima_hooks func,
> >  				int pcr, const char *keyring);
> >  void ima_audit_measurement(struct integrity_iint_cache *iint,
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index bf22de8b7ce0..4f39fb93f278 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -162,7 +162,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
> >  
> >  /**
> >   * ima_get_action - appraise & measure decision based on policy.
> > - * @inode: pointer to inode to measure
> > + * @inode: pointer to the inode associated with the object being validated
> >   * @cred: pointer to credentials structure to validate
> >   * @secid: secid of the task being validated
> >   * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index a9649b04b9f1..6c52bf7ea7f0 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -328,7 +328,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
> >  
> >  		rc = is_binary_blacklisted(digest, digestsize);
> >  		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> > -			process_buffer_measurement(digest, digestsize,
> > +			process_buffer_measurement(NULL, digest, digestsize,
> >  						   "blacklisted-hash", NONE,
> >  						   pcr, NULL);
> >  	}
> > diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> > index aaae80c4e376..1c68c500c26f 100644
> > --- a/security/integrity/ima/ima_asymmetric_keys.c
> > +++ b/security/integrity/ima/ima_asymmetric_keys.c
> > @@ -58,7 +58,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> >  	 * if the IMA policy is configured to measure a key linked
> >  	 * to the given keyring.
> >  	 */
> > -	process_buffer_measurement(payload, payload_len,
> > +	process_buffer_measurement(NULL, payload, payload_len,
> >  				   keyring->description, KEY_CHECK, 0,
> >  				   keyring->description);
> >  }
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 8351b2fd48e0..8a91711ca79b 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -726,6 +726,7 @@ int ima_load_data(enum kernel_load_data_id id)
> >  
> >  /*
> >   * process_buffer_measurement - Measure the buffer to ima log.
> > + * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
> >   * @buf: pointer to the buffer that needs to be added to the log.
> >   * @size: size of buffer(in bytes).
> >   * @eventname: event name to be used for the buffer entry.
> > @@ -735,7 +736,7 @@ int ima_load_data(enum kernel_load_data_id id)
> >   *
> >   * Based on policy, the buffer is measured into the ima log.
> >   */
> > -void process_buffer_measurement(const void *buf, int size,
> > +void process_buffer_measurement(struct inode *inode, const void *buf, int size,
> >  				const char *eventname, enum ima_hooks func,
> >  				int pcr, const char *keyring)
> >  {
> > @@ -768,7 +769,7 @@ void process_buffer_measurement(const void *buf, int size,
> >  	 */
> >  	if (func) {
> >  		security_task_getsecid(current, &secid);
> > -		action = ima_get_action(NULL, current_cred(), secid, 0, func,
> > +		action = ima_get_action(inode, current_cred(), secid, 0, func,
> >  					&pcr, &template, keyring);
> >  		if (!(action & IMA_MEASURE))
> >  			return;
> > @@ -823,16 +824,26 @@ void process_buffer_measurement(const void *buf, int size,
> >  
> >  /**
> >   * ima_kexec_cmdline - measure kexec cmdline boot args
> > + * @kernel_fd: file descriptor of the kexec kernel being loaded
> >   * @buf: pointer to buffer
> >   * @size: size of buffer
> >   *
> >   * Buffers can only be measured, not appraised.
> >   */
> > -void ima_kexec_cmdline(const void *buf, int size)
> > +void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
> >  {
> > -	if (buf && size != 0)
> > -		process_buffer_measurement(buf, size, "kexec-cmdline",
> > -					   KEXEC_CMDLINE, 0, NULL);
> > +	struct fd f;
> > +
> > +	if (!buf || !size)
> > +		return;
> > +
> > +	f = fdget(kernel_fd);
> > +	if (!f.file)
> > +		return;
> > +
> > +	process_buffer_measurement(file_inode(f.file), buf, size,
> > +				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
> > +	fdput(f);
> >  }
> >  
> >  static int __init init_ima(void)
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 5eb14b567a31..294323b36d06 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -443,13 +443,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> >  {
> >  	int i;
> >  
> > -	if ((func == KEXEC_CMDLINE) || (func == KEY_CHECK)) {
> > -		if ((rule->flags & IMA_FUNC) && (rule->func == func)) {
> > -			if (func == KEY_CHECK)
> > -				return ima_match_keyring(rule, keyring, cred);
> > -			return true;
> > -		}
> > -		return false;
> > +	if (func == KEY_CHECK) {
> > +		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> > +		       ima_match_keyring(rule, keyring, cred);
> >  	}
> >  	if ((rule->flags & IMA_FUNC) &&
> >  	    (rule->func != func && func != POST_SETATTR))
> > @@ -1007,10 +1003,9 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >  			if (entry->action & ~(MEASURE | DONT_MEASURE))
> >  				return false;
> >  
> > -			if (entry->flags & ~(IMA_FUNC | IMA_PCR))
> > -				return false;
> > -
> > -			if (ima_rule_contains_lsm_cond(entry))
> > +			if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
> > +					     IMA_FOWNER | IMA_FSUUID |
> > +					     IMA_EUID | IMA_PCR | IMA_FSNAME))
> >  				return false;
> >  
> >  			break;
> > diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> > index 56ce24a18b66..69a8626a35c0 100644
> > --- a/security/integrity/ima/ima_queue_keys.c
> > +++ b/security/integrity/ima/ima_queue_keys.c
> > @@ -158,7 +158,7 @@ void ima_process_queued_keys(void)
> >  
> >  	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
> >  		if (!timer_expired)
> > -			process_buffer_measurement(entry->payload,
> > +			process_buffer_measurement(NULL, entry->payload,
> >  						   entry->payload_len,
> >  						   entry->keyring_name,
> >  						   KEY_CHECK, 0,
> > -- 
> > 2.25.1
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> Although I still do not understand the deep knowledge of IMA, I
> still wonder to know what is the effect to the behavior changes end user
> visible.   Does it work with a kernel built-in commandline? eg no
> cmdlien passed at all.

Ah, very good question. This IMA hook (KEXEC_CMDLINE) only measures the
string passed to the cmdline argument of the kexec_file_load(2) syscall.
However, kernel commandline options injected into a kernel with the
CONFIG_CMDLINE or CONFIG_CMDLINE_EXTEND Kconfig options would still be
measured, as part of the vmlinux as a whole, by the KEXEC_KERNEL_CHECK
IMA hook.

Tyler

> 
> Thanks
> Dave
