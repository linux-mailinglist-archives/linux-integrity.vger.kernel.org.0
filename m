Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323375ED096
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiI0W5O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiI0W5M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 18:57:12 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F583BC8
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 15:56:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1319cf91d8aso1249208fac.5
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=N9qEMgiqxUd/9otLFy+P0/SRM49MpnfliPH1FnPcVI4=;
        b=JqBPKEaOR6vRaTr0jLpD0Eu1x+ED2CsYrCHCZY6bKzXmldyg2wKH8UVl0f8DiyHnXv
         F44XzVGcIrdZai4tA00RwixKiCWVjANypsw7ynKOFdoQ0tBh0KWAvD9OtYLEMd59ZjVa
         nHskPDfIAmRkVzUpsVm5cg14LjUpPAG7JrCoScjlNAds5SlAst78+iS1wEVWH0zWW6ZY
         hBvMqYvY//3NKjEx/JT0Xh1WVSYPKy0eTE+nYhYkvu0Cufp11jgTfY+diFwTV4SsJLlF
         iotaq3a5flI9o5BAenKAw3YVu0THhopPModbejb3F0AukykB9pQknCsetJPTNERdv23D
         EIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=N9qEMgiqxUd/9otLFy+P0/SRM49MpnfliPH1FnPcVI4=;
        b=aay2zYBu7hP7PchWXXzF8TGN/C4WTgjD1sUXyw74mD+CYAHEMCRYUKG11/lm1fvR7P
         TX16sAGaEJZfa9+j/WKi6eeo+rR4ussJf1qWxyZUJIKmo08XzZALHZxcr0wP9dSWvwht
         EiwQUZm8CiGeHwbKEs51OS3QVPrfwm3LTUei8JJLBzsL4h9Zs2uweosD8xqaK2lVOcnF
         NtUlrEaoT0bqJNs8/5owZI5F0/UMpOAiFCPuxREI4qyKu0im6xIHFD++AfW+en6zClbs
         35JUAYpgdgUeA1GUNYt1dsxD59+HtB9g9sAph7o5Vm4mcOhzpbZszyduF3V0spleZT58
         M+PQ==
X-Gm-Message-State: ACrzQf2SQq7EzmUKijeu9FKDNdqQU/1OEE0O33A5QtELnJp6YcVCOjMq
        nZlYe53iH76lIMlAXMWZ9ugZD3HSII7yfcoltay1
X-Google-Smtp-Source: AMsMyM6trTC+Bs2z8YL2MfKl+TsUO4g0UHYlBQ1lp05aHfXLcc9CUJG+zgpYTbdnGbSgtXAfNLsLXvW24lQK9LA/3bI=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr1944037oab.172.1664319415761; Tue, 27
 Sep 2022 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-19-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-19-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:56:44 -0400
Message-ID: <CAHC9VhTx-Pkh0E3Awr=BR-Zh31gmoP3d1MKHf-UPVibfV3VxKQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/30] evm: simplify evm_xattr_acl_change()
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
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

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The posix acl api provides a dedicated security and integrity hook for
> setting posix acls. This means that
>
> evm_protect_xattr()
> -> evm_xattr_change()
>    -> evm_xattr_acl_change()
>
> is now only hit during vfs_remove_acl() at which point we are guaranteed
> that xattr_value and xattr_value_len are NULL and 0. In this case evm
> always used to return 1. Simplify this function to do just that.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  security/integrity/evm/evm_main.c | 62 +++++++------------------------
>  1 file changed, 14 insertions(+), 48 deletions(-)
>
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 15aa5995fff4..1fbe1b8d0364 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -436,62 +436,29 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
>
>  /*
>   * evm_xattr_acl_change - check if passed ACL changes the inode mode
> - * @mnt_userns: user namespace of the idmapped mount
> - * @dentry: pointer to the affected dentry
>   * @xattr_name: requested xattr
>   * @xattr_value: requested xattr value
>   * @xattr_value_len: requested xattr value length
>   *
> - * Check if passed ACL changes the inode mode, which is protected by EVM.
> + * This is only hit during xattr removal at which point we always return 1.
> + * Splat a warning in case someone managed to pass data to this function. That
> + * should never happen.
>   *
>   * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
>   */
> -static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
> -                               struct dentry *dentry, const char *xattr_name,
> -                               const void *xattr_value, size_t xattr_value_len)
> +static int evm_xattr_acl_change(const void *xattr_value, size_t xattr_value_len)
>  {
> -#ifdef CONFIG_FS_POSIX_ACL
> -       umode_t mode;
> -       struct posix_acl *acl = NULL, *acl_res;
> -       struct inode *inode = d_backing_inode(dentry);
> -       int rc;
> -
> -       /*
> -        * An earlier comment here mentioned that the idmappings for
> -        * ACL_{GROUP,USER} don't matter since EVM is only interested in the
> -        * mode stored as part of POSIX ACLs. Nonetheless, if it must translate
> -        * from the uapi POSIX ACL representation to the VFS internal POSIX ACL
> -        * representation it should do so correctly. There's no guarantee that
> -        * we won't change POSIX ACLs in a way that ACL_{GROUP,USER} matters
> -        * for the mode at some point and it's difficult to keep track of all
> -        * the LSM and integrity modules and what they do to POSIX ACLs.
> -        *
> -        * Frankly, EVM shouldn't try to interpret the uapi struct for POSIX
> -        * ACLs it received. It requires knowledge that only the VFS is
> -        * guaranteed to have.
> -        */
> -       acl = vfs_set_acl_prepare(mnt_userns, i_user_ns(inode),
> -                                 xattr_value, xattr_value_len);
> -       if (IS_ERR_OR_NULL(acl))
> -               return 1;
> -
> -       acl_res = acl;
> -       /*
> -        * Passing mnt_userns is necessary to correctly determine the GID in
> -        * an idmapped mount, as the GID is used to clear the setgid bit in
> -        * the inode mode.
> -        */
> -       rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
> -
> -       posix_acl_release(acl);
> -
> -       if (rc)
> -               return 1;
> +       int rc = 0;
>
> -       if (inode->i_mode != mode)
> -               return 1;
> +#ifdef CONFIG_FS_POSIX_ACL
> +       WARN_ONCE(xattr_value != NULL,
> +                 "Passing xattr value for POSIX ACLs not supported\n");
> +       WARN_ONCE(xattr_value_len != 0,
> +                 "Passing non-zero length for POSIX ACLs not supported\n");
> +       rc = 1;
>  #endif
> -       return 0;
> +
> +       return rc;
>  }

This is another case where I'll leave the final say up to Mimi, but
why not just get rid of evm_xattr_acl_change() entirely?  Unless I'm
missing something, it's only reason for existing now is to check that
it is passed the proper (empty) parameters which seems pointless ...
no?

--
paul-moore.com
