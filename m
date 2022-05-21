Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A152F7C2
	for <lists+linux-integrity@lfdr.de>; Sat, 21 May 2022 04:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354391AbiEUCzF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 22:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiEUCzE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 22:55:04 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7D190D3D;
        Fri, 20 May 2022 19:55:01 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 3D2B63F4; Fri, 20 May 2022 21:55:00 -0500 (CDT)
Date:   Fri, 20 May 2022 21:55:00 -0500
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
Subject: Re: [PATCH v12 06/26] ima: Move measurement list related variables
 into ima_namespace
Message-ID: <20220521025500.GD9107@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140633.753772-7-stefanb@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 10:06:13AM -0400, Stefan Berger wrote:
> Move measurement list related variables into the ima_namespace. This way
> a front-end like securityfs can show the measurement list inside an IMA
> namespace.
> 
> Also, in order for kexec to allocate memory for the existing
> measurement list, the measurement list memory size is stored in the
> binary_runtime_size variable.  To avoid special-casing init_ima_ns, as
> much as possible, move it into the ima_namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/ima/ima.h             |  5 +++--
>  security/integrity/ima/ima_fs.c          |  6 ++++--
>  security/integrity/ima/ima_init_ima_ns.c |  5 +++++
>  security/integrity/ima/ima_kexec.c       | 12 ++++++-----
>  security/integrity/ima/ima_queue.c       | 27 +++++++++++-------------
>  5 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 78798cfcf46c..82e8af2bf698 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -106,7 +106,6 @@ struct ima_queue_entry {
>  	struct list_head later;		/* place in ima_measurements list */
>  	struct ima_template_entry *entry;
>  };
> -extern struct list_head ima_measurements;	/* list of all measurements */
>  
>  /* Some details preceding the binary serialized measurement list */
>  struct ima_kexec_hdr {
> @@ -136,6 +135,8 @@ struct ima_namespace {
>  	struct ima_rule_entry *arch_policy_entry;
>  
>  	struct ima_h_table ima_htable;
> +	struct list_head ima_measurements;	/* list of all measurements */
> +	unsigned long binary_runtime_size;	/* used by init_ima_ns */
>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;
>  
> @@ -186,7 +187,7 @@ int ima_restore_measurement_entry(struct ima_namespace *ns,
>  int ima_restore_measurement_list(struct ima_namespace *ns,
>  				 loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> -unsigned long ima_get_binary_runtime_size(void);
> +unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
>  int __init ima_init_digests(void);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index dca7fe32d65e..5ef0e2b2cf64 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -80,12 +80,13 @@ static const struct file_operations ima_measurements_count_ops = {
>  /* returns pointer to hlist_node */
>  static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>  {
> +	struct ima_namespace *ns = &init_ima_ns;
>  	loff_t l = *pos;
>  	struct ima_queue_entry *qe;
>  
>  	/* we need a lock since pos could point beyond last element */
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> +	list_for_each_entry_rcu(qe, &ns->ima_measurements, later) {
>  		if (!l--) {
>  			rcu_read_unlock();
>  			return qe;
> @@ -97,6 +98,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>  
>  static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> +	struct ima_namespace *ns = &init_ima_ns;
>  	struct ima_queue_entry *qe = v;
>  
>  	/* lock protects when reading beyond last element
> @@ -107,7 +109,7 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>  	rcu_read_unlock();
>  	(*pos)++;
>  
> -	return (&qe->later == &ima_measurements) ? NULL : qe;
> +	return (&qe->later == &ns->ima_measurements) ? NULL : qe;
>  }
>  
>  static void ima_measurements_stop(struct seq_file *m, void *v)
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index 1945fa8cfc4d..a7477072c587 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -20,6 +20,11 @@ static int ima_init_namespace(struct ima_namespace *ns)
>  	atomic_long_set(&ns->ima_htable.len, 0);
>  	atomic_long_set(&ns->ima_htable.violations, 0);
>  	memset(&ns->ima_htable.queue, 0, sizeof(ns->ima_htable.queue));
> +	INIT_LIST_HEAD(&ns->ima_measurements);
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC) && ns == &init_ima_ns)
> +		ns->binary_runtime_size = 0;
> +	else
> +		ns->binary_runtime_size = ULONG_MAX;
>  
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index d7cc5cca6f84..fd5da31f19ee 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,7 +15,8 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> -static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
> +static int ima_dump_measurement_list(struct ima_namespace *ns,
> +				     unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
>  	struct ima_queue_entry *qe;
> @@ -36,7 +37,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
> -	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> +	list_for_each_entry_rcu(qe, &ns->ima_measurements, later) {
>  		if (file.count < file.size) {
>  			khdr.count++;
>  			ima_measurements_show(&file, qe);
> @@ -84,6 +85,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
>  				  .buf_min = 0, .buf_max = ULONG_MAX,
>  				  .top_down = true };
> +	struct ima_namespace *ns = &init_ima_ns;
>  	unsigned long binary_runtime_size;
>  
>  	/* use more understandable variable names than defined in kbuf */
> @@ -96,11 +98,11 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	 * Reserve an extra half page of memory for additional measurements
>  	 * added during the kexec load.
>  	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	binary_runtime_size = ima_get_binary_runtime_size(ns);
>  	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>  		kexec_segment_size = ULONG_MAX;
>  	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> +		kexec_segment_size = ALIGN(ima_get_binary_runtime_size(ns) +
>  					   PAGE_SIZE / 2, PAGE_SIZE);
>  	if ((kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
> @@ -108,7 +110,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +	ima_dump_measurement_list(ns, &kexec_buffer_size, &kexec_buffer,
>  				  kexec_segment_size);
>  	if (!kexec_buffer) {
>  		pr_err("Not enough memory for the kexec measurement buffer.\n");
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 43961d5cd2ef..0355c2b0932c 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -24,13 +24,6 @@
>  /* pre-allocated array of tpm_digest structures to extend a PCR */
>  static struct tpm_digest *digests;
>  
> -LIST_HEAD(ima_measurements);	/* list of all measurements */
> -#ifdef CONFIG_IMA_KEXEC
> -static unsigned long binary_runtime_size;
> -#else
> -static unsigned long binary_runtime_size = ULONG_MAX;
> -#endif
> -
>  /* mutex protects atomicity of extending measurement list
>   * and extending the TPM PCR aggregate. Since tpm_extend can take
>   * long (and the tpm driver uses a mutex), we can't use the spinlock.
> @@ -100,7 +93,7 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
>  	qe->entry = entry;
>  
>  	INIT_LIST_HEAD(&qe->later);
> -	list_add_tail_rcu(&qe->later, &ima_measurements);
> +	list_add_tail_rcu(&qe->later, &ns->ima_measurements);
>  
>  	atomic_long_inc(&ns->ima_htable.len);
>  	if (update_htable) {
> @@ -110,12 +103,14 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
>  		INIT_HLIST_NODE(&qe->hnext);
>  	}
>  
> -	if (binary_runtime_size != ULONG_MAX) {
> +	if (ns->binary_runtime_size != ULONG_MAX) {
>  		int size;
>  
>  		size = get_binary_runtime_size(entry);
> -		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
> -		     binary_runtime_size + size : ULONG_MAX;
> +		ns->binary_runtime_size =
> +			(ns->binary_runtime_size < ULONG_MAX - size)
> +			? ns->binary_runtime_size + size
> +			: ULONG_MAX;
>  	}
>  	return 0;
>  }
> @@ -123,14 +118,16 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
>  /*
>   * Return the amount of memory required for serializing the
>   * entire binary_runtime_measurement list, including the ima_kexec_hdr
> - * structure.
> + * structure. Carrying the measurement list across kexec is limited
> + * to init_ima_ns.
>   */
> -unsigned long ima_get_binary_runtime_size(void)
> +unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
>  {
> -	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
> +	if (ns->binary_runtime_size >=
> +				(ULONG_MAX - sizeof(struct ima_kexec_hdr)))
>  		return ULONG_MAX;
>  	else
> -		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
> +		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
>  }
>  
>  static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
> -- 
> 2.34.1
