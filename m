Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFBE603039
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJRPxV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJRPxT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 11:53:19 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D8C97EA;
        Tue, 18 Oct 2022 08:53:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MsHls6RwJz9xrpj;
        Tue, 18 Oct 2022 23:27:05 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3fgUbx05jE5UGAA--.19528S2;
        Tue, 18 Oct 2022 16:32:53 +0100 (CET)
Message-ID: <1b41c633bbd31b82b02fdbae718f2f11ac862181.camel@huaweicloud.com>
Subject: Re: [PATCH 4/9] ima: Move ima_file_free() into LSM
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>,
        Jonathan McDowell <noodles@fb.com>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 18 Oct 2022 17:32:40 +0200
In-Reply-To: <20221018150213.7n4sv7rtsh6lshd5@wittgenstein>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-4-keescook@chromium.org>
         <20221018150213.7n4sv7rtsh6lshd5@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwD3fgUbx05jE5UGAA--.19528S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1ktw18Kr1rJr43Gr4UJwb_yoWrAr43pF
        s3t3W5Crn3Jryjgr97Canrua4Fg39agryxuFyrW348tFnxtFyvvFy3Cr1Y9F4UJry0krWx
        tF4UKry5Z3WjyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4BjMQACsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-18 at 17:02 +0200, Christian Brauner wrote:
> On Thu, Oct 13, 2022 at 03:36:49PM -0700, Kees Cook wrote:
> > The file_free_security hook already exists for managing
> > notification of
> > released files. Use the LSM hook instead of open-coded stacking.
> > 
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Petr Vorel <pvorel@suse.cz>
> > Cc: Jonathan McDowell <noodles@fb.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/file_table.c                   | 1 -
> >  include/linux/ima.h               | 6 ------
> >  security/integrity/ima/ima_main.c | 3 ++-
> >  3 files changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 99c6796c9f28..fa707d221a43 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -311,7 +311,6 @@ static void __fput(struct file *file)
> >  	eventpoll_release(file);
> >  	locks_remove_file(file);
> >  
> > -	ima_file_free(file);
> >  	if (unlikely(file->f_flags & FASYNC)) {
> >  		if (file->f_op->fasync)
> >  			file->f_op->fasync(-1, file, 0);
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 6dc5143f89f2..9f18df366064 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -19,7 +19,6 @@ extern enum hash_algo
> > ima_get_current_hash_algo(void);
> >  extern int ima_file_check(struct file *file, int mask);
> >  extern void ima_post_create_tmpfile(struct user_namespace
> > *mnt_userns,
> >  				    struct inode *inode);
> > -extern void ima_file_free(struct file *file);
> >  extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
> >  				struct dentry *dentry);
> >  extern int ima_file_hash(struct file *file, char *buf, size_t
> > buf_size);
> > @@ -56,11 +55,6 @@ static inline void
> > ima_post_create_tmpfile(struct user_namespace *mnt_userns,
> >  {
> >  }
> >  
> > -static inline void ima_file_free(struct file *file)
> > -{
> > -	return;
> > -}
> > -
> >  static inline void ima_post_path_mknod(struct user_namespace
> > *mnt_userns,
> >  				       struct dentry *dentry)
> >  {
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index b3b79d030a67..94379ba40b58 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -183,7 +183,7 @@ static void ima_check_last_writer(struct
> > integrity_iint_cache *iint,
> >   *
> >   * Flag files that changed, based on i_version
> >   */
> > -void ima_file_free(struct file *file)
> > +static void ima_file_free(struct file *file)
> >  {
> >  	struct inode *inode = file_inode(file);
> >  	struct integrity_iint_cache *iint;
> > @@ -1085,6 +1085,7 @@ static struct security_hook_list ima_hooks[]
> > __lsm_ro_after_init = {
> >  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> >  	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
> >  	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
> > +	LSM_HOOK_INIT(file_free_security, ima_file_free),
> 
> This doesn't work afaict. If the file is opened for writing ima may
> update xattrs. But by the time security_file_free() is called
> put_file_access() has already been called which will have given up
> write
> access to the file's mount.
> 
> So you would have to - just one of the possibilities - have to move
> security_file_free() out of file_free() and into the old
> ima_file_free()
> location. But that might cause semantic changes for other LSMs.

Hi

I also did this work before. In my implementation, I created a new
security hook called security_file_pre_free().

https://github.com/robertosassu/linux/commit/692c9d36fff865435b23b3cb765d31f3584f6263

If useful, the whole patch set is available at:

https://github.com/robertosassu/linux/commits/ima-evm-lsm-v1-devel-v3

Roberto

