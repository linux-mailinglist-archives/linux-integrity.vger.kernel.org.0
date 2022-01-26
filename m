Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6983A49C631
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiAZJWJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 04:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbiAZJWJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 04:22:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0270C06161C;
        Wed, 26 Jan 2022 01:22:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37359615C9;
        Wed, 26 Jan 2022 09:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B5C340E3;
        Wed, 26 Jan 2022 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643188927;
        bh=n/jD5iTKOebcjbO5P/xZ/QgsZdDYFFRtrOcj2E7MyC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSh2u4tMdnHLXU0Znb2x0TEwxzzwN86oXHYj5Z0POT474W7sx7iGa6DeUwVfRHhxp
         dP+RjfwrZyIVoTadkPHInHfjTPnQoCaF7eJUzy0BlJP1II1XgQ+7dVN1PsVOUMT1xv
         KILvJl1gyJqePsoRXDEZj+6MUywlPEShI39KRhoWciItGJnh3aFFICS5PHllCNomFS
         CxEFZ9bnFaPMRUCbsQvazCoFpdxW0pTe/YLx92GKN3J9vTeh+QaPvk+uq98HNjMf7J
         /iejNq13n9mwdaeGC66wzV72et5jN3pdGnm8iT2GlnH2qhbwlMMZqalDzirwT2W9Cf
         Tmrgk4EL1JTZg==
Date:   Wed, 26 Jan 2022 10:21:59 +0100
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
Subject: Re: [PATCH v9 08/23] ima: Move measurement list related variables
 into ima_namespace
Message-ID: <20220126092159.4rgclr5s3jli7aqy@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-9-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-9-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:30PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Move measurement list related variables into the ima_namespace. This way
> a front-end like securityfs can show the measurement list inside an IMA
> namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

>  security/integrity/ima/ima.h             |  5 +++--
>  security/integrity/ima/ima_fs.c          |  6 ++++--
>  security/integrity/ima/ima_init_ima_ns.c |  5 +++++
>  security/integrity/ima/ima_kexec.c       | 12 ++++++-----
>  security/integrity/ima/ima_queue.c       | 27 +++++++++++-------------
>  5 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 340a59174670..45706836a77b 100644
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

Moving this into struct imans seems sane to me but I'm not going to ack
it because I don't have enough knowledge to guarantee that this code
will only run for init_ima_ns. I'll leave that to Mimi.

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
> index 9b4dce57c1a6..b2f088dd8572 100644
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
> index f3ef8a0df992..e83b18492f46 100644
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
> 2.31.1
> 
> 
