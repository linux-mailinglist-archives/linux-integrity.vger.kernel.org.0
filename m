Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F565E6972
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Sep 2022 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIVRRW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Sep 2022 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIVRRK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Sep 2022 13:17:10 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F754A11E
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:17:08 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11eab59db71so14772677fac.11
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RXzIteJ6nCXeS/RjCm/dkwIz5GGoIJdYrPgw6IN0hFg=;
        b=B0sDS+XQgrVw5c7DEKqz0Xr2iGv9rxXbHgO38HfuYPLZKL1Ip0wBQUMgwbpd4nZhPL
         4bF+vXSeLQfjM1irwqmufxvHnb7jX2Zh6FXe/FylJ8xxdgLiGwb3lygCQhk+tpu2c9Ng
         YFxBldJiiDqitLqjDVvTQ9ZxCz2vTLesh/rs9kNGsLJkvVFWxg1tGbZRSg3RmaN3q9yC
         YaRLEYaf5CXpMpCWqcwDkZgh6LWCNKMfURchUCuXwUSd5RnftB3MCCNAeRZOa1bfyYGq
         h8skqxZSCuPrHuS4FeF/KYO/9vrVpcJmTIqNTeYz2wExb6YKRQfD/80s3GGNrQg1btEC
         FehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RXzIteJ6nCXeS/RjCm/dkwIz5GGoIJdYrPgw6IN0hFg=;
        b=saLLzKBPt6VO4tNIJ24f8BT2I5ufbd27zMYC+DFG4E7YLOg5YvOrlfm3ZA4qUz/xMh
         IYLGvpp9GRfS1ffbuXP8VxedcsmmAY8RGQuVVNwOiHQU1VOFLq3FAGW5F7h0mWhu3k7e
         21o0fUZSJV2VaEP9fQ3yjPBu8ESXb/6l1hXGYxie1hllrSpSVWZtsuKaPmgOBeuNV//b
         qDUEo1CArmGJoEbCpqfHy9Kfq52/rZI/KfnlWwzDBvzu433zbPS7oTBJAn8HFvATR4Kr
         zg5gdg25YrtaZT/rMz0yh5pRB2Jid9FXQKD+k7fCzZc8pPvM6fuksA2Po0NjKNaFh8CP
         Kx4A==
X-Gm-Message-State: ACrzQf226KprZdfohh+3vgrM1s/X/bnFR/zuyTSidjE3Pmj4kGvwIDWo
        k4ycP5jMxY0t9NBqYJysBURNhzF9gVxoGjpA/V9O
X-Google-Smtp-Source: AMsMyM6ZsIUYuP1LhazMzrCtrUZzgvpvQn66hg7MoSwjk4Bg2XK7pf5kADeo5MDERr61V9YyqA+X1JTPQwmgQjJ6A0A=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr2697885oaa.172.1663867027871; Thu, 22
 Sep 2022 10:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org>
In-Reply-To: <20220922151728.1557914-11-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 13:16:57 -0400
Message-ID: <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 22, 2022 at 11:18 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module infrastructure and
> audited all codepaths. SELinux has no restrictions based on the posix
> acl values passed through it. The capability hook doesn't need to be
> called either because it only has restrictions on security.* xattrs. So
> this all becomes a very simple hook for SELinux.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  security/selinux/hooks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79573504783b..bbc0ce3bde35 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3239,6 +3239,13 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
>                             &ad);
>  }
>
> +static int selinux_inode_set_acl(struct user_namespace *mnt_userns,
> +                                struct dentry *dentry, const char *acl_name,
> +                                struct posix_acl *kacl)
> +{
> +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> +}
> +
>  static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>                                         const void *value, size_t size,
>                                         int flags)
> @@ -7063,6 +7070,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
>         LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
>         LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
> +       LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),

See my other reply about needing to see the full patchset in order to
properly review the changes, but one thing immediately jumped out at
me when looking at this: why is the LSM hook
"security_inode_set_acl()" when we are passing a dentry instead of an
inode?  We don't have a lot of them, but there are
`security_dentry_*()` LSM hooks in the existing kernel code.

-- 
paul-moore.com
