Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A674A88E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGGBnw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jul 2023 21:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGBnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jul 2023 21:43:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AED1BDB
        for <linux-integrity@vger.kernel.org>; Thu,  6 Jul 2023 18:43:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765a1690003so126162885a.0
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jul 2023 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688694229; x=1691286229;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6iaVAHDZFHnHVQGQy3/WAXwADLiMzIbro0LrR31f7o=;
        b=Z6yGZ5E1DoZhHK8B0qXu3gFqSaQ1BoS/JZCpSr5sz/3TSGaq5wME5Lmy4I3Z1XB2/N
         pKmFncpU2jB1c43TVM4QZBLJa1nKy+1phWTyrt7ciXIuh9D/du88ZvNGTF28CChRCQqV
         6N3GlyVo8mqG0MURK6Shk4xXoJScXnT2uX6g+XL8cyONAvNsYrg/m7hoXYIgWXLvCPAt
         dakGHhFJu0REc+JWnllYf0kLOkqrcUGYMgNjLsist0mT71RlQhOVF5lfxcYw7RuiqeSn
         gxduZpTRg1Z6cOyaGReDjFaWFh/FfOZ6XMgQPyYln0hznYScYbQo1dYgANGymcr8YVQ6
         tVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688694229; x=1691286229;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6iaVAHDZFHnHVQGQy3/WAXwADLiMzIbro0LrR31f7o=;
        b=K65Y4DWbCI7xExK54hkVCyKe623Os3e8uduY9bosGceslAGGNTz+UzYF9isUtbd8rg
         1otZs+BPivPL1WZ9d0AJIxRbqGgl22qdNFPMsaY6lWJUnqb3IR25VcL7dE21DJPpEhpn
         HlOMMEm5XrfOSuHaJM4NoQKmF29zebyTZRMUIWL89uemIJr9zSMiYqH5bd9wYsdCKnUL
         6j3gtNFa5hRTM2iQ6Xvdmv6vFrJ7HsN7BLwcOixDUrCgocs0WTWeZdpOCHerv/CEUswY
         9F23zs6ugDiRvQrPwKNyUg4uPxWno8Y+H7CfAPAsnGGfFZcOdgYfPAe8nyh+pXwD5rGe
         td5g==
X-Gm-Message-State: ABy/qLakCIztXU5IYRzRUkbJHwZY/BRySFHN+v+O0sWrZJ5DLztECMj4
        PlxHla3C2tCqSm0SplDoK/H9
X-Google-Smtp-Source: APBJJlEfi7VWuL66Nn8ERt1JyCIzYGS6gKtLA9qvkW+YNaoIwxze6G6o+qhKp/9q49H8DXWc66l/7w==
X-Received: by 2002:a05:620a:24d:b0:765:8c98:133a with SMTP id q13-20020a05620a024d00b007658c98133amr3404309qkn.9.1688694229207;
        Thu, 06 Jul 2023 18:43:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g19-20020a05620a109300b00767b4fa5d96sm6652qkk.27.2023.07.06.18.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 18:43:48 -0700 (PDT)
Date:   Thu, 06 Jul 2023 21:43:48 -0400
Message-ID: <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for  inode_init_security hook
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Currently, the LSM infrastructure supports only one LSM providing an xattr
> and EVM calculating the HMAC on that xattr, plus other inode metadata.
> 
> Allow all LSMs to provide one or multiple xattrs, by extending the security
> blob reservation mechanism. Introduce the new lbs_xattr_count field of the
> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> needs, and the LSM infrastructure knows how many xattr slots it should
> allocate.
> 
> Modify the inode_init_security hook definition, by passing the full
> xattr array allocated in security_inode_init_security(), and the current
> number of xattr slots in that array filled by LSMs. The first parameter
> would allow EVM to access and calculate the HMAC on xattrs supplied by
> other LSMs, the second to not leave gaps in the xattr array, when an LSM
> requested but did not provide xattrs (e.g. if it is not initialized).
> 
> Introduce lsm_get_xattr_slot(), which LSMs can call as many times as the
> number specified in the lbs_xattr_count field of the lsm_blob_sizes
> structure. During each call, lsm_get_xattr_slot() increments the number of
> filled xattrs, so that at the next invocation it returns the next xattr
> slot to fill.
> 
> Cleanup security_inode_init_security(). Unify the !initxattrs and
> initxattrs case by simply not allocating the new_xattrs array in the
> former. Update the documentation to reflect the changes, and fix the
> description of the xattr name, as it is not allocated anymore.
> 
> Adapt both SELinux and Smack to use the new definition of the
> inode_init_security hook, and to call lsm_get_xattr_slot() to obtain and
> fill the reserved slots in the xattr array.
> 
> Move the xattr->name assignment after the xattr->value one, so that it is
> done only in case of successful memory allocation.
> 
> Finally, change the default return value of the inode_init_security hook
> from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> conventions.
> 
> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  6 +--
>  include/linux/lsm_hooks.h     | 20 ++++++++++
>  security/security.c           | 71 +++++++++++++++++++++++------------
>  security/selinux/hooks.c      | 17 +++++----
>  security/smack/smack_lsm.c    | 25 ++++++------
>  5 files changed, 92 insertions(+), 47 deletions(-)

Two *very* small suggestions below, but I can make those during the
merge if you are okay with that Roberto?

I'm also going to assume that Casey is okay with the Smack portion of
this patchset?  It looks fine to me, and considering his ACK on the
other Smack patch in this patchset I'm assuming he is okay with this
one as well ... ?

> diff --git a/security/security.c b/security/security.c
> index ee4f1cc4902..d5ef7df1ce4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
>   * created inode and set up the incore security field for the new inode.  This
>   * hook is called by the fs code as part of the inode creation transaction and
>   * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
> - * hooks called by the VFS.  The hook function is expected to allocate the name
> - * and value via kmalloc, with the caller being responsible for calling kfree
> - * after using them.  If the security module does not use security attributes
> - * or does not wish to put a security attribute on this particular inode, then
> - * it should return -EOPNOTSUPP to skip this processing.
> + * hooks called by the VFS.  The hook function is expected to populate the
> + * @xattrs array, by calling lsm_get_xattr_slot() to retrieve the slots

I think we want to change "@xattrs array" to just "xattrs array" as
there is no function parameter named "xattrs" in the LSM/security_XXX
hook itself, just in the 'inode_init_security' hook implementation.

I might also break the new text describing the hook implementation
into a new paragraph.

> + * reserved by the security module with the lbs_xattr_count field of the
> + * lsm_blob_sizes structure.  For each slot, the hook function should set ->name
> + * to the attribute name suffix (e.g. selinux), to allocate ->value (will be
> + * freed by the caller) and set it to the attribute value, to set ->value_len to
> + * the length of the value.  If the security module does not use security
> + * attributes or does not wish to put a security attribute on this particular
> + * inode, then it should return -EOPNOTSUPP to skip this processing.
>   *
>   * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
>   * needed, or -ENOMEM on memory allocation failure.
> @@ -1604,33 +1609,51 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const struct qstr *qstr,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
> -	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> -	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -	int ret;
> +	struct security_hook_list *P;

The above comments were nitpicky, this one is even more so ...
convention within security/security.c is to call the
security_hook_list pointer "hp", not "P" (although I recognize P is
used in the macro).

> +	struct xattr *new_xattrs = NULL;
> +	int ret = -EOPNOTSUPP, xattr_count = 0;

--
paul-moore.com
