Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC352F7BB
	for <lists+linux-integrity@lfdr.de>; Sat, 21 May 2022 04:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiEUCuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 22:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiEUCuI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 22:50:08 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB1770928;
        Fri, 20 May 2022 19:50:06 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 04BFE3F4; Fri, 20 May 2022 21:50:05 -0500 (CDT)
Date:   Fri, 20 May 2022 21:50:04 -0500
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
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 05/26] ima: Move ima_htable into ima_namespace
Message-ID: <20220521025004.GC9107@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-6-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-6-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:12AM -0400, Stefan Berger wrote:
> Move ima_htable into ima_namespace. This way a front-end like
> securityfs can show the number of measurement records and number of
> violations of an IMA namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/ima/ima.h             | 33 +++++++++++++---------
>  security/integrity/ima/ima_api.c         | 18 +++++++-----
>  security/integrity/ima/ima_fs.c          |  8 ++++--
>  security/integrity/ima/ima_init.c        |  7 +++--
>  security/integrity/ima/ima_init_ima_ns.c |  4 +++
>  security/integrity/ima/ima_kexec.c       |  3 +-
>  security/integrity/ima/ima_main.c        | 14 +++++----
>  security/integrity/ima/ima_queue.c       | 36 ++++++++++++------------
>  security/integrity/ima/ima_template.c    |  5 ++--
>  9 files changed, 76 insertions(+), 52 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2305bf223a98..78798cfcf46c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -117,6 +117,12 @@ struct ima_kexec_hdr {
>  	u64 count;
>  };
>  
> +struct ima_h_table {
> +	atomic_long_t len;	/* number of stored measurements in the list */
> +	atomic_long_t violations;
> +	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
> +};
> +
>  struct ima_namespace {
>  	/* policy rules */
>  	struct list_head ima_default_rules; /* Kconfig, builtin & arch rules */
> @@ -128,6 +134,8 @@ struct ima_namespace {
>  
>  	/* An array of architecture specific rules */
>  	struct ima_rule_entry *arch_policy_entry;
> +
> +	struct ima_h_table ima_htable;
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> @@ -149,7 +157,8 @@ extern bool ima_canonical_fmt;
>  int ima_init(void);
>  int ima_fs_init(void);
>  int ima_ns_init(void);
> -int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> +int ima_add_template_entry(struct ima_namespace *ns,
> +			   struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
>  			   const unsigned char *filename);
>  int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
> @@ -158,7 +167,8 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
>  int ima_calc_field_array_hash(struct ima_field_data *field_data,
>  			      struct ima_template_entry *entry);
>  int ima_calc_boot_aggregate(struct ima_digest_data *hash);
> -void ima_add_violation(struct file *file, const unsigned char *filename,
> +void ima_add_violation(struct ima_namespace *ns,
> +		       struct file *file, const unsigned char *filename,
>  		       struct integrity_iint_cache *iint,
>  		       const char *op, const char *cause);
>  int ima_init_crypto(void);
> @@ -171,8 +181,10 @@ struct ima_template_desc *ima_template_desc_current(void);
>  struct ima_template_desc *ima_template_desc_buf(void);
>  struct ima_template_desc *lookup_template_desc(const char *name);
>  bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
> -int ima_restore_measurement_entry(struct ima_template_entry *entry);
> -int ima_restore_measurement_list(loff_t bufsize, void *buf);
> +int ima_restore_measurement_entry(struct ima_namespace *ns,
> +				  struct ima_template_entry *entry);
> +int ima_restore_measurement_list(struct ima_namespace *ns,
> +				 loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
> @@ -186,13 +198,6 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   */
>  extern spinlock_t ima_queue_lock;
>  
> -struct ima_h_table {
> -	atomic_long_t len;	/* number of stored measurements in the list */
> -	atomic_long_t violations;
> -	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
> -};
> -extern struct ima_h_table ima_htable;
> -
>  static inline unsigned int ima_hash_key(u8 *digest)
>  {
>  	/* there is no point in taking a hash of part of a digest */
> @@ -277,7 +282,8 @@ int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
>  			    enum hash_algo algo, struct modsig *modsig);
> -void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
> +void ima_store_measurement(struct ima_namespace *ns,
> +			   struct integrity_iint_cache *iint, struct file *file,
>  			   const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -293,7 +299,8 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>  int ima_alloc_init_template(struct ima_event_data *event_data,
>  			    struct ima_template_entry **entry,
>  			    struct ima_template_desc *template_desc);
> -int ima_store_template(struct ima_template_entry *entry, int violation,
> +int ima_store_template(struct ima_namespace *ns,
> +		       struct ima_template_entry *entry, int violation,
>  		       struct inode *inode,
>  		       const unsigned char *filename, int pcr);
>  void ima_free_template_entry(struct ima_template_entry *entry);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 90ef246a9f43..1b6c3e6174cd 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -99,7 +99,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
>   *
>   * Returns 0 on success, error code otherwise
>   */
> -int ima_store_template(struct ima_template_entry *entry,
> +int ima_store_template(struct ima_namespace *ns,
> +		       struct ima_template_entry *entry,
>  		       int violation, struct inode *inode,
>  		       const unsigned char *filename, int pcr)
>  {
> @@ -119,7 +120,8 @@ int ima_store_template(struct ima_template_entry *entry,
>  		}
>  	}
>  	entry->pcr = pcr;
> -	result = ima_add_template_entry(entry, violation, op, inode, filename);
> +	result = ima_add_template_entry(ns, entry, violation, op, inode,
> +					filename);
>  	return result;
>  }
>  
> @@ -130,7 +132,8 @@ int ima_store_template(struct ima_template_entry *entry,
>   * By extending the PCR with 0xFF's instead of with zeroes, the PCR
>   * value is invalidated.
>   */
> -void ima_add_violation(struct file *file, const unsigned char *filename,
> +void ima_add_violation(struct ima_namespace *ns,
> +		       struct file *file, const unsigned char *filename,
>  		       struct integrity_iint_cache *iint,
>  		       const char *op, const char *cause)
>  {
> @@ -144,14 +147,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>  	int result;
>  
>  	/* can overflow, only indicator */
> -	atomic_long_inc(&ima_htable.violations);
> +	atomic_long_inc(&ns->ima_htable.violations);
>  
>  	result = ima_alloc_init_template(&event_data, &entry, NULL);
>  	if (result < 0) {
>  		result = -ENOMEM;
>  		goto err_out;
>  	}
> -	result = ima_store_template(entry, violation, inode,
> +	result = ima_store_template(ns, entry, violation, inode,
>  				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
>  	if (result < 0)
>  		ima_free_template_entry(entry);
> @@ -297,7 +300,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   *
>   * Must be called with iint->mutex held.
>   */
> -void ima_store_measurement(struct integrity_iint_cache *iint,
> +void ima_store_measurement(struct ima_namespace *ns,
> +			   struct integrity_iint_cache *iint,
>  			   struct file *file, const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -332,7 +336,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>  		return;
>  	}
>  
> -	result = ima_store_template(entry, violation, inode, filename, pcr);
> +	result = ima_store_template(ns, entry, violation, inode, filename, pcr);
>  	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
>  		iint->flags |= IMA_MEASURED;
>  		iint->measured_pcrs |= (0x1 << pcr);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index f7ad93a56982..dca7fe32d65e 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -52,7 +52,10 @@ static ssize_t ima_show_htable_violations(struct file *filp,
>  					  char __user *buf,
>  					  size_t count, loff_t *ppos)
>  {
> -	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
> +	struct ima_namespace *ns = &init_ima_ns;
> +
> +	return ima_show_htable_value(buf, count, ppos,
> +				     &ns->ima_htable.violations);
>  }
>  
>  static const struct file_operations ima_htable_violations_ops = {
> @@ -64,8 +67,9 @@ static ssize_t ima_show_measurements_count(struct file *filp,
>  					   char __user *buf,
>  					   size_t count, loff_t *ppos)
>  {
> -	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
> +	struct ima_namespace *ns = &init_ima_ns;
>  
> +	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
>  }
>  
>  static const struct file_operations ima_measurements_count_ops = {
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 7e5b4187035d..47c9d561532e 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -39,7 +39,7 @@ struct tpm_chip *ima_tpm_chip;
>   * a different value.) Violations add a zero entry to the measurement
>   * list and extend the aggregate PCR value with ff...ff's.
>   */
> -static int __init ima_add_boot_aggregate(void)
> +static int __init ima_add_boot_aggregate(struct ima_namespace *ns)
>  {
>  	static const char op[] = "add_boot_aggregate";
>  	const char *audit_cause = "ENOMEM";
> @@ -83,7 +83,7 @@ static int __init ima_add_boot_aggregate(void)
>  		goto err_out;
>  	}
>  
> -	result = ima_store_template(entry, violation, NULL,
> +	result = ima_store_template(ns, entry, violation, NULL,
>  				    boot_aggregate_name,
>  				    CONFIG_IMA_MEASURE_PCR_IDX);
>  	if (result < 0) {
> @@ -142,7 +142,8 @@ int __init ima_init(void)
>  	rc = ima_init_digests();
>  	if (rc != 0)
>  		return rc;
> -	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
> +	/* boot aggregate must be first entry */
> +	rc = ima_add_boot_aggregate(&init_ima_ns);
>  	if (rc != 0)
>  		return rc;
>  
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index ae33621c3955..1945fa8cfc4d 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -17,6 +17,10 @@ static int ima_init_namespace(struct ima_namespace *ns)
>  	ns->ima_policy_flag = 0;
>  	ns->arch_policy_entry = NULL;
>  
> +	atomic_long_set(&ns->ima_htable.len, 0);
> +	atomic_long_set(&ns->ima_htable.violations, 0);
> +	memset(&ns->ima_htable.queue, 0, sizeof(ns->ima_htable.queue));
> +
>  	return 0;
>  }
>  
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13753136f03f..d7cc5cca6f84 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -146,7 +146,8 @@ void ima_load_kexec_buffer(void)
>  	rc = ima_get_kexec_buffer(&kexec_buffer, &kexec_buffer_size);
>  	switch (rc) {
>  	case 0:
> -		rc = ima_restore_measurement_list(kexec_buffer_size,
> +		rc = ima_restore_measurement_list(&init_ima_ns,
> +						  kexec_buffer_size,
>  						  kexec_buffer);
>  		if (rc != 0)
>  			pr_err("Failed to restore the measurement list: %d\n",
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 400865c521dd..005f9e784e7b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -112,7 +112,8 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
>   *	  could result in a file measurement error.
>   *
>   */
> -static void ima_rdwr_violation_check(struct file *file,
> +static void ima_rdwr_violation_check(struct ima_namespace *ns,
> +				     struct file *file,
>  				     struct integrity_iint_cache *iint,
>  				     int must_measure,
>  				     char **pathbuf,
> @@ -145,10 +146,10 @@ static void ima_rdwr_violation_check(struct file *file,
>  	*pathname = ima_d_path(&file->f_path, pathbuf, filename);
>  
>  	if (send_tomtou)
> -		ima_add_violation(file, *pathname, iint,
> +		ima_add_violation(ns, file, *pathname, iint,
>  				  "invalid_pcr", "ToMToU");
>  	if (send_writers)
> -		ima_add_violation(file, *pathname, iint,
> +		ima_add_violation(ns, file, *pathname, iint,
>  				  "invalid_pcr", "open_writers");
>  }
>  
> @@ -249,7 +250,7 @@ static int process_measurement(struct ima_namespace *ns,
>  	}
>  
>  	if (!rc && violation_check)
> -		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
> +		ima_rdwr_violation_check(ns, file, iint, action & IMA_MEASURE,
>  					 &pathbuf, &pathname, filename);
>  
>  	inode_unlock(inode);
> @@ -344,7 +345,7 @@ static int process_measurement(struct ima_namespace *ns,
>  		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
>  
>  	if (action & IMA_MEASURE)
> -		ima_store_measurement(iint, file, pathname,
> +		ima_store_measurement(ns, iint, file, pathname,
>  				      xattr_value, xattr_len, modsig, pcr,
>  				      template_desc);
>  	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
> @@ -987,7 +988,8 @@ int process_buffer_measurement(struct ima_namespace *ns,
>  		goto out;
>  	}
>  
> -	ret = ima_store_template(entry, violation, NULL, event_data.buf, pcr);
> +	ret = ima_store_template(ns, entry, violation, NULL, event_data.buf,
> +				 pcr);
>  	if (ret < 0) {
>  		audit_cause = "store_entry";
>  		ima_free_template_entry(entry);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 532da87ce519..43961d5cd2ef 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -31,13 +31,6 @@ static unsigned long binary_runtime_size;
>  static unsigned long binary_runtime_size = ULONG_MAX;
>  #endif
>  
> -/* key: inode (before secure-hashing a file) */
> -struct ima_h_table ima_htable = {
> -	.len = ATOMIC_LONG_INIT(0),
> -	.violations = ATOMIC_LONG_INIT(0),
> -	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
> -};
> -
>  /* mutex protects atomicity of extending measurement list
>   * and extending the TPM PCR aggregate. Since tpm_extend can take
>   * long (and the tpm driver uses a mutex), we can't use the spinlock.
> @@ -45,8 +38,10 @@ struct ima_h_table ima_htable = {
>  static DEFINE_MUTEX(ima_extend_list_mutex);
>  
>  /* lookup up the digest value in the hash table, and return the entry */
> -static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
> -						       int pcr)
> +static struct ima_queue_entry *ima_lookup_digest_entry
> +						(struct ima_namespace *ns,
> +						 u8 *digest_value,
> +						 int pcr)
>  {
>  	struct ima_queue_entry *qe, *ret = NULL;
>  	unsigned int key;
> @@ -54,7 +49,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>  
>  	key = ima_hash_key(digest_value);
>  	rcu_read_lock();
> -	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
> +	hlist_for_each_entry_rcu(qe, &ns->ima_htable.queue[key], hnext) {
>  		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
>  			    digest_value, hash_digest_size[ima_hash_algo]);
>  		if ((rc == 0) && (qe->entry->pcr == pcr)) {
> @@ -90,7 +85,8 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
>   *
>   * (Called with ima_extend_list_mutex held.)
>   */
> -static int ima_add_digest_entry(struct ima_template_entry *entry,
> +static int ima_add_digest_entry(struct ima_namespace *ns,
> +				struct ima_template_entry *entry,
>  				bool update_htable)
>  {
>  	struct ima_queue_entry *qe;
> @@ -106,10 +102,12 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>  	INIT_LIST_HEAD(&qe->later);
>  	list_add_tail_rcu(&qe->later, &ima_measurements);
>  
> -	atomic_long_inc(&ima_htable.len);
> +	atomic_long_inc(&ns->ima_htable.len);
>  	if (update_htable) {
>  		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
> -		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
> +		hlist_add_head_rcu(&qe->hnext, &ns->ima_htable.queue[key]);
> +	} else {
> +		INIT_HLIST_NODE(&qe->hnext);
>  	}
>  
>  	if (binary_runtime_size != ULONG_MAX) {
> @@ -156,7 +154,8 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>   * kexec, maintain the total memory size required for serializing the
>   * binary_runtime_measurements.
>   */
> -int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> +int ima_add_template_entry(struct ima_namespace *ns,
> +			   struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
>  			   const unsigned char *filename)
>  {
> @@ -169,14 +168,14 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  
>  	mutex_lock(&ima_extend_list_mutex);
>  	if (!violation && !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
> -		if (ima_lookup_digest_entry(digest, entry->pcr)) {
> +		if (ima_lookup_digest_entry(ns, digest, entry->pcr)) {
>  			audit_cause = "hash_exists";
>  			result = -EEXIST;
>  			goto out;
>  		}
>  	}
>  
> -	result = ima_add_digest_entry(entry,
> +	result = ima_add_digest_entry(ns, entry,
>  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>  	if (result < 0) {
>  		audit_cause = "ENOMEM";
> @@ -201,12 +200,13 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  	return result;
>  }
>  
> -int ima_restore_measurement_entry(struct ima_template_entry *entry)
> +int ima_restore_measurement_entry(struct ima_namespace *ns,
> +				  struct ima_template_entry *entry)
>  {
>  	int result = 0;
>  
>  	mutex_lock(&ima_extend_list_mutex);
> -	result = ima_add_digest_entry(entry, 0);
> +	result = ima_add_digest_entry(ns, entry, 0);
>  	mutex_unlock(&ima_extend_list_mutex);
>  	return result;
>  }
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index db1ad6d7a57f..e5c33a3f0296 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -404,7 +404,8 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
>  }
>  
>  /* Restore the serialized binary measurement list without extending PCRs. */
> -int ima_restore_measurement_list(loff_t size, void *buf)
> +int ima_restore_measurement_list(struct ima_namespace *ns,
> +				 loff_t size, void *buf)
>  {
>  	char template_name[MAX_TEMPLATE_NAME_LEN];
>  	unsigned char zero[TPM_DIGEST_SIZE] = { 0 };
> @@ -520,7 +521,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
>  
>  		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
>  			     le32_to_cpu(*(__le32 *)(hdr[HDR_PCR].data));
> -		ret = ima_restore_measurement_entry(entry);
> +		ret = ima_restore_measurement_entry(ns, entry);
>  		if (ret < 0)
>  			break;
>  
> -- 
> 2.34.1
