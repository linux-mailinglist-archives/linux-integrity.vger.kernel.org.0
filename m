Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52D148E954
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiANLnc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jan 2022 06:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiANLnc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 06:43:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC3C061574;
        Fri, 14 Jan 2022 03:43:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BDF6B825C7;
        Fri, 14 Jan 2022 11:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431F4C36AEB;
        Fri, 14 Jan 2022 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642160609;
        bh=bgmAhxQsVVgxRzj2THs9lrv78RfoWXCLdTlRB3+Zats=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1mn2vqUD2BXCpYE0h8pk23H+u7UvwHfpA+zYovyknErHV1CC4+IcQ6F715d78sPO
         YxIfWCvIH/0/Lv91iKXfPgvNSHKnKJLqHVtr9gfv8v4PhwWDLiFvbD3FyYgjMrqeeO
         6N9sH9d0CJsVeLHfhfh5hSPt6CeX7Es4oIpIBAKaz9/wyYHuJdZb5q7ep5dFq68F96
         LgiBA8rnT22mhRwuXwT5DCWX7zWJbj0ApzsXCyxWzg9EOqEiKb/E+yGVzT1DtPx3+g
         OATxfYpIxmzGQhuOOJjhKPE27ll8DnBcxgx9oQadXBJCYXecJG3J4V9s2nhrjgjhz/
         Atl9yO0yy3qNw==
Date:   Fri, 14 Jan 2022 12:43:21 +0100
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
Subject: Re: [PATCH v8 13/19] ima: Add functions for creation and freeing of
 an ima_namespace
Message-ID: <20220114114321.7prnt72ukvch4wxa@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-14-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220104170416.1923685-14-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 04, 2022 at 12:04:10PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement create_ima_ns() to create and initialize an ima_namespace
> and implement free_ima_ns() to free it.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h                      | 13 +++++
>  security/integrity/ima/Makefile          |  1 +
>  security/integrity/ima/ima.h             | 16 +++++++
>  security/integrity/ima/ima_init_ima_ns.c |  2 +-
>  security/integrity/ima/ima_ns.c          | 61 ++++++++++++++++++++++++
>  5 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/ima/ima_ns.c
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index e1d65162d1fb..06c88cb17b21 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -226,4 +226,17 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
>  	return false;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +#ifdef CONFIG_IMA_NS
> +
> +void free_ima_ns(struct user_namespace *ns);
> +
> +#else
> +
> +static inline void free_ima_ns(struct user_namespace *user_ns)
> +{
> +}
> +
> +#endif /* CONFIG_IMA_NS */
> +
>  #endif /* _LINUX_IMA_H */
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index f8a5e5f3975d..b86a35fbed60 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +ima-$(CONFIG_IMA_NS) += ima_ns.o
>  
>  ifeq ($(CONFIG_EFI),y)
>  ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f63c6f22b853..4255301e5b96 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -163,6 +163,7 @@ extern bool ima_canonical_fmt;
>  int ima_init(void);
>  int ima_fs_init(void);
>  int ima_ns_init(void);
> +int ima_init_namespace(struct ima_namespace *ns);
>  int ima_add_template_entry(struct ima_namespace *ns,
>  			   struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> @@ -503,4 +504,19 @@ static inline struct ima_namespace *get_current_ns(void)
>  	return &init_ima_ns;
>  }
>  
> +#ifdef CONFIG_IMA_NS
> +
> +struct ima_namespace *create_ima_ns(struct user_namespace *user_ns);
> +
> +#else
> +
> +static inline struct ima_namespace *
> +create_ima_ns(struct user_namespace *user_ns)

Why are you introducing these functions in 13/19 when you're first using
it in the last patch of this series?

> +{
> +	WARN(1, "Cannot create an IMA namespace\n");
> +	return ERR_PTR(-EFAULT);
> +}

I think I pointed this out earlier or made illustrated it in my draft
patch earlier. This function should not return a ptr to an ima
namespace. That's just not necessary: the ima namespace _is stashed in
struct user namespace_:

static int create_ima_ns(struct uesr_namespace *user_ns)
{
	[...]

	/* Pairs with [...] */
	smp_store_release(&user_ns->ima_ns, ns);
	return 0;
}

and in the other case:

static inline create_ima_ns(struct user_namespace *user_ns)
{
	return -EINVAL;
}
