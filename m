Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98E1602EC7
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJROuY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJROuX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 10:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CB7539E;
        Tue, 18 Oct 2022 07:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E532615AB;
        Tue, 18 Oct 2022 14:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F61EC433C1;
        Tue, 18 Oct 2022 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666104620;
        bh=ACwyqNY8oMu9XW5Mf3e+t059oyIQgnVusAf+tbTm86A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEP5H+ibgXeGfacp2P6LbFB8CwLh6GaIgBnutWNoDYMFtgq3FSbPqqTfQo+y0aorc
         dAeW5y1hnbQiDY8nvIa9bpy2lnxhzZ1q9Ekmg1jhOXq/Zwnao+7yEWaTF98UOYlJ1V
         vg4sYOPJ7niY2n0gMH8F1o9hyy+WMAnGNnC5XL1VsIY1R+2V4c8zJCweFLli7cLctk
         vUmqqz+XPwEIP/B1TjkDpw1V55Kd91E3gG4A+sNggdbathoZfdpSb1OUtabUn6wg6S
         Kn44ZZBc7TJWuT1OoO0JaebuIlVEvxbrDpUe42NXTXh61FjnmBbdJAuPhfFEKU0l5l
         24cQ9VSKGgREA==
Date:   Tue, 18 Oct 2022 16:50:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] LSM: Introduce inode_post_setattr hook
Message-ID: <20221018145013.duwxiczk5gj7pk66@wittgenstein>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013223654.659758-5-keescook@chromium.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 13, 2022 at 03:36:50PM -0700, Kees Cook wrote:
> IMA and EVM need to hook after setattr finishes. Introduce this hook and
> move IMA and EVM's open-coded stacking to use it.
> 
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jonathan McDowell <noodles@fb.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/attr.c                             |  3 +--
>  include/linux/evm.h                   |  6 ------
>  include/linux/ima.h                   |  9 ---------
>  include/linux/lsm_hook_defs.h         |  3 +++
>  security/integrity/evm/evm_main.c     | 10 +++++++++-
>  security/integrity/ima/ima.h          |  2 ++
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/ima/ima_main.c     |  1 +
>  security/security.c                   |  8 ++++++++
>  9 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 1552a5f23d6b..e5731057426b 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -423,8 +423,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
>  
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> -		ima_inode_post_setattr(mnt_userns, dentry);
> -		evm_inode_post_setattr(dentry, ia_valid);
> +		security_inode_post_setattr(mnt_userns, dentry, ia_valid);

I like that change. In general, no more separate evm_* and ima_*
invocations in the vfs would be much appreciated.
