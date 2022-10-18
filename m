Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6DE602F15
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiJRPCZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJRPCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 11:02:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A6DBBFC;
        Tue, 18 Oct 2022 08:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C80A0B81F94;
        Tue, 18 Oct 2022 15:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83774C433D6;
        Tue, 18 Oct 2022 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105340;
        bh=7/gSW/YAwojZ7rDGfHVc1ctabTFOpK3OWU/NQqBOtHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5kp4mGnLs85wnBjb8szwJHbw6vmzj0gjEP0Ax2jCOP4VnQBuRMnYScTtWnrLL7m1
         95xDI/uLa/XJRtnpCd8qysURAtjDI8sLjrcBrpZYkoYdg3MLHqoJ0ttyA/TQaAVGnX
         /hvlUH1S9Ctx3z3lg0pTDBIRUsQ3fg9xXEHwqZt0cSMTSlkiT1Z5YztBWjgEKCbs/C
         GIinoNw8dk+WoyOACVLfZtKNZCx8Erx9fl8zJPLQnj134LcIPJ/i3GK450IE8AWQk2
         sZzldoCpKcURVr/9R1xLQlrplM6nTh3LEurTV+9UplsOPwq22QgPp/2KwprRdS/8Pe
         MdcZDlbKEhjKQ==
Date:   Tue, 18 Oct 2022 17:02:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>,
        Jonathan McDowell <noodles@fb.com>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/9] ima: Move ima_file_free() into LSM
Message-ID: <20221018150213.7n4sv7rtsh6lshd5@wittgenstein>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013223654.659758-4-keescook@chromium.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 13, 2022 at 03:36:49PM -0700, Kees Cook wrote:
> The file_free_security hook already exists for managing notification of
> released files. Use the LSM hook instead of open-coded stacking.
> 
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Jonathan McDowell <noodles@fb.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/file_table.c                   | 1 -
>  include/linux/ima.h               | 6 ------
>  security/integrity/ima/ima_main.c | 3 ++-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 99c6796c9f28..fa707d221a43 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -311,7 +311,6 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> -	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
>  			file->f_op->fasync(-1, file, 0);
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6dc5143f89f2..9f18df366064 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -19,7 +19,6 @@ extern enum hash_algo ima_get_current_hash_algo(void);
>  extern int ima_file_check(struct file *file, int mask);
>  extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
>  				    struct inode *inode);
> -extern void ima_file_free(struct file *file);
>  extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
>  				struct dentry *dentry);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> @@ -56,11 +55,6 @@ static inline void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
>  {
>  }
>  
> -static inline void ima_file_free(struct file *file)
> -{
> -	return;
> -}
> -
>  static inline void ima_post_path_mknod(struct user_namespace *mnt_userns,
>  				       struct dentry *dentry)
>  {
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index b3b79d030a67..94379ba40b58 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -183,7 +183,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   *
>   * Flag files that changed, based on i_version
>   */
> -void ima_file_free(struct file *file)
> +static void ima_file_free(struct file *file)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint;
> @@ -1085,6 +1085,7 @@ static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
>  	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
>  	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
> +	LSM_HOOK_INIT(file_free_security, ima_file_free),

This doesn't work afaict. If the file is opened for writing ima may
update xattrs. But by the time security_file_free() is called
put_file_access() has already been called which will have given up write
access to the file's mount.

So you would have to - just one of the possibilities - have to move
security_file_free() out of file_free() and into the old ima_file_free()
location. But that might cause semantic changes for other LSMs.
