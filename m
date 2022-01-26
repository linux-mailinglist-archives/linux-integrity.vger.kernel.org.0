Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B449C9E0
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiAZMjS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 07:39:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49278 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiAZMjR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 07:39:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E44A761A11;
        Wed, 26 Jan 2022 12:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF0BC340E3;
        Wed, 26 Jan 2022 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643200756;
        bh=xljfkSW5EOUxkIzXQglwFnRTwhw+nyf/3Ow0W6XX3Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LM+uoaziStbdr/lVGp7RVl8lcWdP71RQfpmIkI3pGoiaRTpwJpE7cimvx0+KoG5FT
         zIiyeG0nU/tsVYEsLLal/YUrcHtj5m3A9SLLiDGQ+BvNvdRCKqpKmfkhum14gibfI1
         A0lYcFl+j3eXbkwGWkynYmL28SfHmNj7iwhnmyGoz+5Oks1setkWc0TZrH2P6zxqW9
         SkfRGzQYKotXd4d9bwKOxb2mT6Rqcwz1AHODftvC8FpwT9mkMTQf4HMQp9RyQyhBve
         XiPPCDntq7dVabQTS+H5ebal5I2lOe3pKNkeN9CmAbM84rkuSZxpluCP2InW+FWm8W
         dI8Idnu6kVaeQ==
Date:   Wed, 26 Jan 2022 13:39:08 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 15/23] ima: Implement hierarchical processing of file
 accesses
Message-ID: <20220126123908.q65wgvr2v52lmxpw@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-16-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125224645.79319-16-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:37PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement hierarchical processing of file accesses in IMA namespaces by
> walking the list of user namespaces towards the root. This way file
> accesses can be audited in an IMA namespace and also be evaluated against
> the IMA policies of parent IMA namespaces.
> 
> Pass the user_namespace into process_measurement since we will be walking
> the hierarchy of user_namespaces towards the init_user_ns and we can easily
> derive the ima_namespace from the user_namespace.
> 
> __process_measurement() returns either 0 or -EACCES. For hierarchical
> processing remember the -EACCES returned by this function but continue
> to the parent user namespace. At the end either return 0 or -EACCES
> if an error occurred in one of the IMA namespaces.
> 
> Currently the ima_ns pointer of the user_namespace is always NULL except
> at the init_user_ns, so test ima_ns for NULL pointer and skip the call to
> __process_measurement() if it is NULL. Once IMA namespacing is fully
> enabled, the pointer may still be NULL due to late initialization of the
> IMA namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> 
> v9:
>   - Switch callers to pass user_namespace rather than ima_namespace with
>     potential NULL pointer
>   - Add default case to switch statement and warn if this happens
>   - Implement ima_ns_from_user_ns() in this patch now
> ---
>  security/integrity/ima/ima.h      |  8 ++++
>  security/integrity/ima/ima_main.c | 75 +++++++++++++++++++++++--------
>  2 files changed, 64 insertions(+), 19 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 0057b1fd6c18..aea8fb8d2854 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -493,4 +493,12 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
>  	return file_inode(filp)->i_sb->s_user_ns;
>  }
>  
> +static inline struct ima_namespace
> +*ima_ns_from_user_ns(struct user_namespace *user_ns)
> +{
> +	if (user_ns == &init_user_ns)
> +		return &init_ima_ns;
> +	return NULL;
> +}
> +
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index ae0e9b14554a..3385221ca1d5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -196,10 +196,10 @@ void ima_file_free(struct file *file)
>  	ima_check_last_writer(iint, inode, file);
>  }
>  
> -static int process_measurement(struct ima_namespace *ns,
> -			       struct file *file, const struct cred *cred,
> -			       u32 secid, char *buf, loff_t size, int mask,
> -			       enum ima_hooks func)
> +static int __process_measurement(struct ima_namespace *ns,
> +				 struct file *file, const struct cred *cred,
> +				 u32 secid, char *buf, loff_t size, int mask,
> +				 enum ima_hooks func)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> @@ -391,6 +391,41 @@ static int process_measurement(struct ima_namespace *ns,
>  	return 0;
>  }
>  
> +static int process_measurement(struct user_namespace *user_ns,
> +			       struct file *file, const struct cred *cred,
> +			       u32 secid, char *buf, loff_t size, int mask,
> +			       enum ima_hooks func)
> +{
> +	struct ima_namespace *ns;
> +	int ret = 0;
> +
> +	while (user_ns) {
> +		ns = ima_ns_from_user_ns(user_ns);
> +		if (ns) {
> +			int rc;
> +
> +			rc = __process_measurement(ns, file, cred, secid, buf,
> +						   size, mask, func);
> +			switch (rc) {
> +			case 0:
> +				break;
> +			case -EACCES:
> +				/* return this error at the end but continue */
> +				ret = -EACCES;
> +				break;
> +			default:
> +				/* should not happen */
> +				ret = -EACCES;
> +				WARN_ON_ONCE(true);
> +			}
> +		}
> +
> +		user_ns = user_ns->parent;
> +	};
> +
> +	return ret;
> +}
> +
>  /**
>   * ima_file_mmap - based on policy, collect/store measurement.
>   * @file: pointer to the file to be measured (May be NULL)
> @@ -404,13 +439,14 @@ static int process_measurement(struct ima_namespace *ns,
>   */
>  int ima_file_mmap(struct file *file, unsigned long prot)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	u32 secid;
>  
>  	if (file && (prot & PROT_EXEC)) {
>  		security_task_getsecid_subj(current, &secid);
> -		return process_measurement(ns, file, current_cred(), secid,
> -					   NULL, 0, MAY_EXEC, MMAP_CHECK);
> +		return process_measurement(user_ns, file, current_cred(),
> +					   secid, NULL, 0, MAY_EXEC,
> +					   MMAP_CHECK);
>  	}
>  
>  	return 0;
> @@ -485,19 +521,19 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   */
>  int ima_bprm_check(struct linux_binprm *bprm)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	int ret;
>  	u32 secid;
>  
>  	security_task_getsecid_subj(current, &secid);
> -	ret = process_measurement(ns, bprm->file, current_cred(), secid, NULL,
> -				  0, MAY_EXEC, BPRM_CHECK);
> +	ret = process_measurement(user_ns, bprm->file, current_cred(), secid,
> +				  NULL, 0, MAY_EXEC, BPRM_CHECK);
>  	if (ret)
>  		return ret;
>  
>  	security_cred_getsecid(bprm->cred, &secid);
> -	return process_measurement(ns, bprm->file, bprm->cred, secid, NULL, 0,
> -				   MAY_EXEC, CREDS_CHECK);
> +	return process_measurement(user_ns, bprm->file, bprm->cred, secid,
> +				   NULL, 0, MAY_EXEC, CREDS_CHECK);
>  }
>  
>  /**
> @@ -512,11 +548,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   */
>  int ima_file_check(struct file *file, int mask)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	u32 secid;
>  
>  	security_task_getsecid_subj(current, &secid);
> -	return process_measurement(ns, file, current_cred(), secid, NULL, 0,
> +	return process_measurement(user_ns, file, current_cred(), secid,
> +				   NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> @@ -698,7 +735,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  		  bool contents)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	enum ima_hooks func;
>  	u32 secid;
>  
> @@ -721,7 +758,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  	/* Read entire file for all partial reads. */
>  	func = read_idmap[read_id] ?: FILE_CHECK;
>  	security_task_getsecid_subj(current, &secid);
> -	return process_measurement(ns, file, current_cred(), secid, NULL,
> +	return process_measurement(user_ns, file, current_cred(), secid, NULL,
>  				   0, MAY_READ, func);
>  }
>  
> @@ -749,7 +786,7 @@ const int read_idmap[READING_MAX_ID] = {
>  int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();

That'll break compilation as youre checking:

ns == &init_ima_ns below.

security/integrity/ima/ima_main.c: In function ‘ima_post_read_file’:
security/integrity/ima/ima_main.c:798:7: error: ‘ns’ undeclared (first use in this function); did you mean ‘insl’?
  798 |   if (ns == &init_ima_ns &&
      |       ^~
      |       insl
security/integrity/ima/ima_main.c:798:7: note: each undeclared identifier is reported only once for each function it appears in

it's fixed later in the series but you might want to fix this up here as
well.

Fwiw, a good strategy is to:

git rebase -i -x "make LOCALVERSION=-imans" v5.16-rc2
