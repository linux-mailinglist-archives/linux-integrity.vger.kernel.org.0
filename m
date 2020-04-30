Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9E1C01D3
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgD3QLr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726688AbgD3QLr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 12:11:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925D4C035494
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 09:11:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so2522757wra.7
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fJgyHOzPEI2g3Gsgqprz29Gt4ZGlNPB/oNH7ftTdv4s=;
        b=T/vBdmKAg3Qk5QTuTlbwumttwVbeivHY4qUdGg70fqOelgiZom0dy6zqKHwc8DlC+y
         2pYJkTeILdi4qAlXcvCOTw23H1Pe2aV6UFKiEqa2C7IOUDFhi7pr7OxlNHp22VzSbLgh
         yRULolJBY+DUyEQFzWJ7sWNNDv6+SoEtttdpiFz8pnIawcVKNV4QyGcmka+wlYPGbi/W
         hI1yAKLkJiqa9oAvEIn0BPDGEfIlAqIxWQiOYjF8TJUf8PyphBI8CtiCLoybQlZ3MMft
         Uk3B4dE1L4ho81IW0FPEF+Z2eKd1oog4HkygUjdoe+dQeqflZNwbNZAZA8hY3TrG7rkX
         dR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fJgyHOzPEI2g3Gsgqprz29Gt4ZGlNPB/oNH7ftTdv4s=;
        b=RZI/wPcWeJNPr/tQWgG48O1zxuNH9/MiiCzzwbNLW7k+uLFJ3KJc21ezTCsjZNje4L
         RfDYoXZlQ+w7tk63Fx9HjpOLopiG8bp6Zdn5lKJYwjjpv5JYtr1cD3lvwZ0J4CcXo26Z
         cgDMxVS51ZjipVRGmpZvW4U3gOsI+YyEW8JYj+0wNIA4zyAv+fLTgeO9kfo4YhYFO/4H
         kYoLG8DDc7QWGeufzRr7cS40T/0bKQqHhurZHxG/KqMWhnnB/xBsNudhe5oU+HVAPdjx
         LFxcrBCdeB71yH7NHJBbr1OAlhaTm8bUHTlkjpNmw8Ds1PH9PWOTZbtIb1+ZhwojyN1L
         efIw==
X-Gm-Message-State: AGi0PubSI59hiv14Bo30Bft88f7c7bIPBWLUlcFL35U5dGXWrZc4wKm/
        NyrUIyMVTHEGk/X/JQbdQMISHOOwi+dlYzICj4FKxaQBn3c=
X-Google-Smtp-Source: APiQypJ6eyooEY7Dm8zSQefN0hcHyFW3sN0aHy335MbUBEiTsqj6Vc5r5Bm6gZR2btcW9rNw0yYUWLq47AjsJv1zZBY=
X-Received: by 2002:a5d:4ac9:: with SMTP id y9mr5007296wrs.182.1588263105143;
 Thu, 30 Apr 2020 09:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
In-Reply-To: <20200429073935.11913-1-roberto.sassu@huawei.com>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Thu, 30 Apr 2020 19:11:33 +0300
Message-ID: <CAP22eLEQqE18OGCNp0Qm-y365C4FsQ-GmnjtvscU7_5Muc5wEA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 29, 2020 at 10:45 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> EVM is a module for the protection of the integrity of file metadata. It
> protects security-relevant extended attributes, and some file attributes
> such as the UID and the GID. It protects their integrity with an HMAC or
> with a signature.
>
> What makes EVM different from other LSMs is that it makes a security
> decision depending on multiple pieces of information, which cannot be
> managed atomically by the system.
>
> Example: cp -a file.orig file.dest
>
> If security.selinux, security.ima and security.evm must be preserved, cp
> will invoke setxattr() for each xattr, and EVM performs a verification
> during each operation. The problem is that copying security.evm from
> file.orig to file.dest will likely break the following EVM verifications if
> some metadata still have to be copied. EVM has no visibility on the
> metadata of the source file, so it cannot determine when the copy can be
> considered complete.
>
> On the other hand, EVM has to check metadata during every operation to
> ensure that there is no transition from corrupted metadata, e.g. after an
> offline attack, to valid ones after the operation. An HMAC update would
> prevent the corruption to be detected, as the HMAC on the new values would
> be correct. Thus, to avoid this issue, EVM has to return an error to the
> system call so that its execution will be interrupted.
>
> A solution that would satisfy both requirements, not breaking user space
> applications and detecting corrupted metadata is to let metadata operations
> be completed successfully and to pass the result of the EVM verification
> from the pre hooks to the post hooks. In this way, the HMAC update can be
> avoided if the verification wasn't successful.
>
> This approach will bring another important benefit: it is no longer
> required that every file has a valid HMAC or signature. Instead of always
> enforcing metadata integrity, even when it is not relevant for IMA, EVM
> will let IMA decide for files selected with the appraisal policy,
> depending on the result of the requested verification.
>
> The main problem is that the result of the verification currently cannot be
> passed from the pre hooks to the post hooks, due to how the LSM API is
> defined. A possible solution would be to use integrity_iint_cache for this
> purpose, but it will increase the memory pressure, as new structures will
> be allocated also for metadata operations, not only for measurement,
> appraisal and audit. Another solution would be to extend the LSM API, but
> it seems not worthwhile as EVM would be the only module getting a benefit
> from this change.
>
> Given that pre and post hooks are called from the same system call, a more
> efficient solution seems to move the hooks outside the LSM infrastructure,
> so that the return value of the pre hooks can be passed to the post hooks.
> A predefined error (-EAGAIN) will be used to signal to the system call to
> continue the execution. Otherwise, if the pre hooks return -EPERM, the
> system calls will behave as before and will immediately return before
> metadata are changed.
>
> Overview of the changes:
>
> evm_inode_init_security()       LSM (no change)
> evm_inode_setxattr()            LSM -> vfs_setxattr()
> evm_inode_post_setxattr()       LSM -> vfs_setxattr()
> evm_inode_removexattr()         LSM -> vfs_removexattr()
> evm_inode_post_removexattr()    vfs_removexattr() (no change)
> evm_inode_setattr()             LSM -> vfs_setattr()
> evm_inode_post_setattr()        vfs_setattr() (no change)
> evm_verifyxattr()               outside LSM (no change)
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/attr.c           |  5 ++++-
>  fs/xattr.c          | 17 +++++++++++++++--
>  security/security.c | 18 +++---------------
>  3 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index b4bbdbd4c8ca..8f26d7d2e3b4 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -224,7 +224,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
>  {
>         struct inode *inode = dentry->d_inode;
>         umode_t mode = inode->i_mode;
> -       int error;
> +       int error, evm_error;
>         struct timespec64 now;
>         unsigned int ia_valid = attr->ia_valid;
>
> @@ -328,6 +328,9 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
>         error = security_inode_setattr(dentry, attr);
>         if (error)
>                 return error;
> +       evm_error = evm_inode_setattr(dentry, attr);
> +       if (evm_error)
> +               return evm_error;
>         error = try_break_deleg(inode, delegated_inode);
>         if (error)
>                 return error;
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e13265e65871..3b323b75b741 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -183,6 +183,7 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
>                         fsnotify_xattr(dentry);
>                         security_inode_post_setxattr(dentry, name, value,
>                                                      size, flags);
> +                       evm_inode_post_setxattr(dentry, name, value, size);
>                 }
>         } else {
>                 if (unlikely(is_bad_inode(inode)))
> @@ -210,7 +211,7 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
>                 size_t size, int flags)
>  {
>         struct inode *inode = dentry->d_inode;
> -       int error;
> +       int error, evm_error;
>
>         error = xattr_permission(inode, name, MAY_WRITE);
>         if (error)
> @@ -221,6 +222,12 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
>         if (error)
>                 goto out;
>
> +       evm_error = evm_inode_setxattr(dentry, name, value, size);
> +       if (evm_error) {
> +               error = evm_error;
> +               goto out;
> +       }
> +
>         error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
>
>  out:
> @@ -382,7 +389,7 @@ int
>  vfs_removexattr(struct dentry *dentry, const char *name)
>  {
>         struct inode *inode = dentry->d_inode;
> -       int error;
> +       int error, evm_error;
>
>         error = xattr_permission(inode, name, MAY_WRITE);
>         if (error)
> @@ -393,6 +400,12 @@ vfs_removexattr(struct dentry *dentry, const char *name)
>         if (error)
>                 goto out;
>
> +       evm_error = evm_inode_removexattr(dentry, name);
> +       if (evm_error) {
> +               error = evm_error;
> +               goto out;
> +       }
> +
>         error = __vfs_removexattr(dentry, name);
>
>         if (!error) {
> diff --git a/security/security.c b/security/security.c
> index 7fed24b9d57e..e1368ab34cee 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1255,14 +1255,9 @@ int security_inode_permission(struct inode *inode, int mask)
>
>  int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  {
> -       int ret;
> -
>         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>                 return 0;
> -       ret = call_int_hook(inode_setattr, 0, dentry, attr);
> -       if (ret)
> -               return ret;
> -       return evm_inode_setattr(dentry, attr);
> +       return call_int_hook(inode_setattr, 0, dentry, attr);
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>
> @@ -1291,10 +1286,7 @@ int security_inode_setxattr(struct dentry *dentry, const char *name,
>                 ret = cap_inode_setxattr(dentry, name, value, size, flags);
>         if (ret)
>                 return ret;
> -       ret = ima_inode_setxattr(dentry, name, value, size);
> -       if (ret)
> -               return ret;
> -       return evm_inode_setxattr(dentry, name, value, size);
> +       return ima_inode_setxattr(dentry, name, value, size);
>  }
>
>  void security_inode_post_setxattr(struct dentry *dentry, const char *name,
> @@ -1303,7 +1295,6 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
>         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>                 return;
>         call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> -       evm_inode_post_setxattr(dentry, name, value, size);
>  }
>
>  int security_inode_getxattr(struct dentry *dentry, const char *name)
> @@ -1335,10 +1326,7 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
>                 ret = cap_inode_removexattr(dentry, name);
>         if (ret)
>                 return ret;
> -       ret = ima_inode_removexattr(dentry, name);
> -       if (ret)
> -               return ret;
> -       return evm_inode_removexattr(dentry, name);
> +       return ima_inode_removexattr(dentry, name);
>  }
>
>  int security_inode_need_killpriv(struct dentry *dentry)
> --
> 2.17.1
>

Hi Roberto,

I apologize that due to my relatively small experience I may not
understand completely your patch.
Please be patient.
To my understanding, EVM knows(configuration) which security
attributes must be taken into HMAC, security.selinux, security.smack,
system.acl, security.ima, etc.
So until HMAC calculation should fail until cp command will not finish
copying all security attributes.
Is it the desired behavior of HMAC?
If the number of security attributes varies between files under EVM,
can we just remove
evm_inode_setxattr() from secutity_inode_setxattr() because it is the
job of evmctl utility to compute security.hmac value?

Actually I do not see the use case why HMAC should be computed inline.
I come from embedded word and will never modify extended attributes
because the signing key will never be placed on the target device. I
think this argument stands also for production servers and for package
management as well.

Regards,
Lev
