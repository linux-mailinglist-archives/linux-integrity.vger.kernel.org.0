Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4222A5FF098
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJNOst (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Oct 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJNOss (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Oct 2022 10:48:48 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Oct 2022 07:48:47 PDT
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EEB1CBA89
        for <linux-integrity@vger.kernel.org>; Fri, 14 Oct 2022 07:48:47 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MppvR2nLHzMqyHl;
        Fri, 14 Oct 2022 16:40:03 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MppvP5kXxzxl;
        Fri, 14 Oct 2022 16:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665758403;
        bh=jcCyesxrLlJfomHPKJJgCzzHqJeECuX0/FAdPkYkMYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0csy4yyyeK2AmSYMeuhklSJZQhYq/NrsNgOTjTFHzuuLeF8Nu9NCkXSmcEUZuZN7V
         anHbM8mogDSj/xeRu1co7NT85d/1itjhoCUOh6JjJrU4XOSCA1qsPu8DGe4Yv/9CEK
         oeWOxoxwmciRMsy8Z5R4M5DiS3bjdiUUFWK/h8Xg=
Message-ID: <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
Date:   Fri, 14 Oct 2022 16:40:01 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221013223654.659758-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 14/10/2022 00:36, Kees Cook wrote:
> Move "integrity" LSM to the end of the Kconfig list and prepare for
> having ima and evm LSM initialization called from the top-level
> "integrity" LSM.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: "Mickaël Salaün" <mic@digikod.net>
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   security/Kconfig                  | 10 +++++-----
>   security/integrity/evm/evm_main.c |  4 ++++
>   security/integrity/iint.c         | 17 +++++++++++++----
>   security/integrity/ima/ima_main.c |  4 ++++
>   security/integrity/integrity.h    |  6 ++++++
>   5 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index e6db09a779b7..d472e87a2fc4 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -246,11 +246,11 @@ endchoice
>   
>   config LSM
>   	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf,integrity" if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf,integrity" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf,integrity" if DEFAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,bpf,integrity" if DEFAULT_SECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf,integrity"

This is not backward compatible, but can easily be fixed thanks to 
DEFINE_LSM().order

Side node: I proposed an alternative to that but it was Nacked: 
https://lore.kernel.org/all/20210222150608.808146-1-mic@digikod.net/


>   	help
>   	  A comma-separated list of LSMs, in initialization order.
>   	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 2e6fb6e2ffd2..1ef965089417 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -904,3 +904,7 @@ static int __init init_evm(void)
>   }
>   
>   late_initcall(init_evm);
> +
> +void __init integrity_lsm_evm_init(void)
> +{
> +}
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 8638976f7990..4f322324449d 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -18,7 +18,6 @@
>   #include <linux/file.h>
>   #include <linux/uaccess.h>
>   #include <linux/security.h>
> -#include <linux/lsm_hooks.h>
>   #include "integrity.h"
>   
>   static struct rb_root integrity_iint_tree = RB_ROOT;
> @@ -172,19 +171,29 @@ static void init_once(void *foo)
>   	mutex_init(&iint->mutex);
>   }
>   
> -static int __init integrity_iintcache_init(void)
> +void __init integrity_add_lsm_hooks(struct security_hook_list *hooks,
> +				    int count)
> +{
> +	security_add_hooks(hooks, count, "integrity");
> +}
> +
> +static int __init integrity_lsm_init(void)
>   {
>   	iint_cache =
>   	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>   			      0, SLAB_PANIC, init_once);
> +
> +	integrity_lsm_ima_init();
> +	integrity_lsm_evm_init();
> +
>   	return 0;
>   }
> +
>   DEFINE_LSM(integrity) = {
>   	.name = "integrity",
> -	.init = integrity_iintcache_init,
> +	.init = integrity_lsm_init,

For backward compatibility, there should be an ".order = 
LSM_ORDER_FIRST," here.
