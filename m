Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D85306E3
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 02:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiEWAnD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWAnB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 20:43:01 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539730569;
        Sun, 22 May 2022 17:42:59 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 21705EB5; Sun, 22 May 2022 19:42:58 -0500 (CDT)
Date:   Sun, 22 May 2022 19:42:58 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com
Subject: Re: [PATCH v12 14/26] ima: Implement hierarchical processing of file
 accesses
Message-ID: <20220523004258.GA28089@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-15-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-15-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:21AM -0400, Stefan Berger wrote:
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
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> 
> ---
> 
> v10:
>   - Fixed compilation issue
> 
> v9:
>   - Switch callers to pass user_namespace rather than ima_namespace with
>     potential NULL pointer
>   - Add default case to switch statement and warn if this happens
>   - Implement ima_ns_from_user_ns() in this patch now
> ---
>  security/integrity/ima/ima.h      |  8 ++++
>  security/integrity/ima/ima_main.c | 76 +++++++++++++++++++++++--------
>  2 files changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 626a6ce2453c..2775a6d89e6d 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -497,4 +497,12 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
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
> index d44faf1c065d..17eb2971eb36 100644
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
> +	}
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
>  		security_current_getsecid_subj(&secid);
> -		return process_measurement(ns, file, current_cred(), secid,
> -					   NULL, 0, MAY_EXEC, MMAP_CHECK);
> +		return process_measurement(user_ns, file, current_cred(),
> +					   secid, NULL, 0, MAY_EXEC,
> +					   MMAP_CHECK);
>  	}
>  
>  	return 0;
> @@ -486,19 +522,19 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   */
>  int ima_bprm_check(struct linux_binprm *bprm)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	int ret;
>  	u32 secid;
>  
>  	security_current_getsecid_subj(&secid);
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
> @@ -513,11 +549,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   */
>  int ima_file_check(struct file *file, int mask)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	u32 secid;
>  
>  	security_current_getsecid_subj(&secid);
> -	return process_measurement(ns, file, current_cred(), secid, NULL, 0,
> +	return process_measurement(user_ns, file, current_cred(), secid,
> +				   NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> @@ -718,7 +755,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  		  bool contents)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
>  	enum ima_hooks func;
>  	u32 secid;
>  
> @@ -741,7 +778,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  	/* Read entire file for all partial reads. */
>  	func = read_idmap[read_id] ?: FILE_CHECK;
>  	security_current_getsecid_subj(&secid);
> -	return process_measurement(ns, file, current_cred(), secid, NULL,
> +	return process_measurement(user_ns, file, current_cred(), secid, NULL,
>  				   0, MAY_READ, func);
>  }
>  
> @@ -769,7 +806,8 @@ const int read_idmap[READING_MAX_ID] = {
>  int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
> -	struct ima_namespace *ns = &init_ima_ns;
> +	struct user_namespace *user_ns = current_user_ns();
> +	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
>  	enum ima_hooks func;
>  	u32 secid;
>  
> @@ -786,8 +824,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  
>  	func = read_idmap[read_id] ?: FILE_CHECK;
>  	security_current_getsecid_subj(&secid);
> -	return process_measurement(ns, file, current_cred(), secid, buf, size,
> -				   MAY_READ, func);
> +	return process_measurement(user_ns, file, current_cred(), secid,
> +				   buf, size, MAY_READ, func);
>  }
>  
>  /**
> -- 
> 2.34.1
