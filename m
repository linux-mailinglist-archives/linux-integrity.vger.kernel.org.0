Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0D5EFDB9
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Sep 2022 21:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiI2TPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Sep 2022 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI2TPc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Sep 2022 15:15:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352C51572A
        for <linux-integrity@vger.kernel.org>; Thu, 29 Sep 2022 12:15:29 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q10so2599403oib.5
        for <linux-integrity@vger.kernel.org>; Thu, 29 Sep 2022 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yf/8WC/DYqH8NUie8myJNN0/4LtlMUik3EmVrOxaY9Q=;
        b=DaHz7jnx/r9+gh+UrBzNiGWymlwe5U/4UlM8FpQWxFdji10rY+2a8DbU/jkLnLwiVH
         RTuePNf+PbsmWPq1e5Rw0tC4Na1cua6pKbvpn1NIMZmRwmQD1NWGwrDerOR19RJo0k7/
         tqhLQXYMDUidhpJbOzAErvZqiQAVSspPsOndRBxLFMx9Qk/56e+UpyWgfBeFWWA6fqjv
         416v2KBqpZRq2n1FMacI1FwvPncTtIZCpeMXagDueiQzlu6F9TBy9m9Gy8Yw/fKU4gG8
         vNpg/RRGUwBRqv/ZZROiQs+Qnfo4f7ujLgFbMiiRLjdZDKM5BsGysh5V/VLn4Th/vBRe
         CxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yf/8WC/DYqH8NUie8myJNN0/4LtlMUik3EmVrOxaY9Q=;
        b=6z5B/545u1dkNM2J/ux9lIA7UXb3CV8Wa4GBbdOXNrPDcRuQneVwu2i48pCOtkI0Zi
         2gmNZVBDCcXuOzObgirqFYFLJYN9YYsvyv8WZo15ZkybupOGozGo7/VlJ2UCjhiYNQzX
         VWTT9d05WUCzfkiXnXE6y+b/oQo+bILIuZJLLThFHKmlYeTUExAO0olWxLgNVX/bd8bS
         aE5Gfj9+LASDGjJiwZiSeP0SMh5t71xDQGqb7dYdrruPZUZsaOc3TYf3cyPl+9OFzQzG
         Un9LmZB3SOsE4TtU9ADXcQ2VuiGveZsAngjfPPw8tAn8OD9f5AyRCAUBouBfVB3VjRhE
         wW2Q==
X-Gm-Message-State: ACrzQf3VfYjxymlXO31lVgKKZjDgk344QfNlc60yk5TtgYdB47DUEaV/
        okHozJU11Ob6Ta0/mxev83NHjSdnvrVwKRrSznfc
X-Google-Smtp-Source: AMsMyM5buXcZU2WWeRA4j7WNkmGG+LD9rY61v8RROQHTg9bc9ki1ysYnnlYoXu7fuXJ4Xn1BHFZJbZTffKIvQ/FuiB4=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr2346251oic.172.1664478928551; Thu, 29
 Sep 2022 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-11-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-11-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 15:15:17 -0400
Message-ID: <CAHC9VhSHSk9MNK+FmydGTZDzDOuwF0b1A3SqYhG+X0NSCwoUEg@mail.gmail.com>
Subject: Re: [PATCH v4 10/30] selinux: implement get, set and remove acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 29, 2022 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
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
> these are all fairly simply hooks for SELinux.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>     /* v3 */
>     Paul Moore <paul@paul-moore.com>:
>     - Add get, and remove acl hook
>
>     /* v4 */
>     unchanged
>
>  security/selinux/hooks.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

One small nitpick below, but looks good regardless.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79573504783b..0e3cd67e5e92 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3239,6 +3239,27 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
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
> +static int selinux_inode_get_acl(struct user_namespace *mnt_userns,
> +                                struct dentry *dentry, const char *acl_name)
> +{
> +       const struct cred *cred = current_cred();
> +
> +       return dentry_has_perm(cred, dentry, FILE__GETATTR);
> +}

Both the set and remove hooks use current_cred() directly in the call
to dentry_has_perm(), you might as well do the same in the get hook.


> +static int selinux_inode_remove_acl(struct user_namespace *mnt_userns,
> +                                   struct dentry *dentry, const char *acl_name)
> +{
> +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> +}

--
paul-moore.com
