Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C896749CCF7
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbiAZO5o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:57:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52194 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbiAZO5n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:57:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3FBDCE1E5E;
        Wed, 26 Jan 2022 14:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F312C340E3;
        Wed, 26 Jan 2022 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209060;
        bh=D6cbGmc1FTqPMkEKRn+is7c8JC0OrlCoH5XSK8T4gLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlOCxITeWKmEb4oXqWpD+75wS/wCc+E6WWFW+Hc6GxAsV4FoV8dgodwInz1KaMs9r
         UDJBJAQZXB1jpliUnROk601rp8xlyKhupuoZ2ux8v9ZIpo3PXbGGICE1a6kFgv2IZ6
         Q9mkBOJQv4IhLGT/LWYN/Lh41gjLCn1vKGiU2vym7ohLgjnZjlONK3gFR0R71aBrIE
         Y8NO+vOrKkoREf9DWQCmuhovKdYNUeAbUgDb8Nd3MwuV/rgRV2UaCR0GNZmYE7pGrR
         kiQ7wHHApSfgWuDcXjtpnGbgr4neqcem9TRVbE3+0eJlcF8NHiTCIxRYqga5SpaqxW
         +ocE+N/rgXHwA==
Date:   Wed, 26 Jan 2022 15:57:32 +0100
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
Subject: Re: [PATCH v9 23/23] ima: Enable IMA namespaces
Message-ID: <20220126145732.o3rhlay7fbsnrani@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-24-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-24-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:45PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Introduce the IMA_NS in Kconfig for IMA namespace enablement.
> 
> Enable the lazy initialization of an IMA namespace when a user mounts
> SecurityFS and writes '1' into IMA's 'active' securityfs file. A
> user_namespace will now get a pointer to an ima_namespace and therefore
> implement get_current_ns() for the namespacing case that returns this
> pointer. Use get_current_ns() in those places that require access to the
> current IMA namespace. In some places, primarily those related to
> IMA-appraisal and changes to file attributes, keep the pointer to
> init_ima_ns, since there flags related to file measurements may be
> affected, which are not supported in IMA namespaces, yet.
> 
> Before using the ima_namespace pointer test it with ns_is_active()
> to check whether it is NULL and whether the ima_namespace is active.
> If it's not active, it cannot be used, yet. Therefore, return early
> from those functions that may now get either get a NULL pointer from
> this call or where ns->active is still 0. The init_ima_ns is always
> set to be active, thus passing the check.
> 
> Implement ima_ns_from_file() for SecurityFS-related files where we can
> now get the IMA namespace via the user namespace pointer associated
> with the superblock of the SecurityFS filesystem instance.
> 
> Return -EACCES to IMA's securityfs files, except for the 'active' file,
> until the IMA namespace has been set to active.
> 
> Switch access to userns->ima_ns to use acquire/release semantics to ensure
> that a newly created ima_namespace structure is fully visible upon access.
> 
> Only emit the kernel log message 'policy update completed' for the
> init_ima_ns.
> 
> Gate access to ima_appraise variable to init_ima_ns in ima_load_data().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v9:
>  - ima_post_key_create_or_update: Only handle key if in init_ima_ns
>  - Removed ns == NULL checks where user_namespace is now passed
>  - Defer setting of user_ns->ima_ns until end of ima_fs_ns_init();
>    required new ima_free_imans() and new user_ns_set_ima_ns()
>  - Only emit log message 'policy update completed' for init_ima_ns
>  - Introduce get_current_ns() only in this patch
>  - Check for ns == &init_ima_ns in ima_load_data()
> ---
>  include/linux/ima.h                          | 13 ++++
>  init/Kconfig                                 | 13 ++++
>  kernel/user_namespace.c                      |  2 +
>  security/integrity/ima/ima.h                 | 51 ++++++++++++--
>  security/integrity/ima/ima_appraise.c        |  3 +
>  security/integrity/ima/ima_asymmetric_keys.c |  6 +-
>  security/integrity/ima/ima_fs.c              | 74 ++++++++++++++++----
>  security/integrity/ima/ima_init_ima_ns.c     |  2 +
>  security/integrity/ima/ima_main.c            | 35 +++++----
>  security/integrity/ima/ima_ns.c              | 15 ++--
>  security/integrity/ima/ima_policy.c          | 16 +++--
>  11 files changed, 188 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index c584527c0f47..4e595bd9733e 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/security.h>
>  #include <linux/kexec.h>
> +#include <linux/user_namespace.h>
>  #include <crypto/hash_info.h>
>  struct linux_binprm;
>  
> @@ -68,6 +69,18 @@ static inline const char * const *arch_get_ima_policy(void)
>  }
>  #endif
>  
> +static inline struct user_namespace
> +*ima_ns_to_user_ns(struct ima_namespace *ns)
> +{
> +	struct user_namespace *user_ns;
> +
> +	user_ns = current_user_ns();
> +#ifdef CONFIG_IMA_NS
> +	WARN_ON(user_ns->ima_ns != ns);
> +#endif
> +	return user_ns;
> +}

As I showed in [1] there are legitimate instances where ima_parse_rule()
is reached and ima->user_ns != current_user_ns(). I illustrated two
examples. So you should skip the current_user_ns() check in there.

You should be able to trigger a WARN() expanding and fixing-up the
pseudo-code of the second example in [1]. You should probably add a
test-case for this if you have test-suite already.

[1]: https://lore.kernel.org/lkml/20220114144515.vbler7ae3jqebhec@wittgenstein
