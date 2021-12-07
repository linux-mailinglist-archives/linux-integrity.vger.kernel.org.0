Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3113846BE81
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 15:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhLGPCp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhLGPCp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 10:02:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C5C061574;
        Tue,  7 Dec 2021 06:59:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39271B817E4;
        Tue,  7 Dec 2021 14:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4299C341C1;
        Tue,  7 Dec 2021 14:59:05 +0000 (UTC)
Date:   Tue, 7 Dec 2021 15:59:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
Message-ID: <20211207145901.awiibdgdidbshsbf@wittgenstein>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
 <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 06, 2021 at 04:14:15PM -0500, James Bottomley wrote:
> On Mon, 2021-12-06 at 12:25 -0500, Stefan Berger wrote:
> [...]
> > v3:
> >  - Further modifications to virtualized SecurityFS following James's
> > posted patch
> >  - Dropping of early teardown for user_namespaces since not needed
> > anymore
> 
> This is my incremental to this series that moves the namespaced
> securityfs away from using a vfsmount and on to a root dentry instead,
> meaning we can call the blocking notifier from fill_super as Christian
> requested (and thus can remove the securityfs_notifier_sent indicator
> since it's only called once).

Somehow b4 retrieves your patch out-of-band which makes it weird to
reply to so I'm copy-pasting it here and reply inline:

On Mon, Dec 06, 2021 at 08:27:00PM +0000, James Bottomley wrote:
> ---
>  include/linux/user_namespace.h |  3 +-
>  security/inode.c               | 55 +++++++++++++---------------------
>  2 files changed, 22 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 6b8bd060d8c4..03a0879376a0 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -104,8 +104,7 @@ struct user_namespace {
>  	struct ima_namespace	*ima_ns;
>  #endif
>  #ifdef CONFIG_SECURITYFS
> -	struct vfsmount		*securityfs_mount;
> -	bool			securityfs_notifier_sent;
> +	struct dentry		*securityfs_root;
>  #endif
>  } __randomize_layout;
>  
> diff --git a/security/inode.c b/security/inode.c
> index 45211845fc31..f8b6cb3dfb87 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -24,6 +24,7 @@
>  #include <linux/magic.h>
>  #include <linux/user_namespace.h>
>  
> +static struct vfsmount *securityfs_mount;
>  static int securityfs_mount_count;
>  
>  static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
> @@ -40,43 +41,24 @@ static const struct super_operations securityfs_super_operations = {
>  	.free_inode	= securityfs_free_inode,
>  };
>  
> -static struct file_system_type fs_type;
> -
> -static void securityfs_free_context(struct fs_context *fc)
> -{
> -	struct user_namespace *ns = fc->user_ns;
> -
> -	if (ns == &init_user_ns ||
> -	    ns->securityfs_notifier_sent)
> -		return;
> -
> -	ns->securityfs_notifier_sent = true;
> -
> -	ns->securityfs_mount = vfs_kern_mount(&fs_type, SB_KERNMOUNT,
> -					      fs_type.name, NULL);
> -	if (IS_ERR(ns->securityfs_mount)) {
> -		printk(KERN_ERR "kern mount on securityfs ERROR: %ld\n",
> -		       PTR_ERR(ns->securityfs_mount));
> -		ns->securityfs_mount = NULL;
> -		return;
> -	}
> -
> -	blocking_notifier_call_chain(&securityfs_ns_notifier,
> -				     SECURITYFS_NS_ADD, fc->user_ns);
> -	mntput(ns->securityfs_mount);
> -}
> -
>  static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	static const struct tree_descr files[] = {{""}};
>  	int error;
> +	struct user_namespace *ns = fc->user_ns;
>  
>  	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
>  	if (error)
>  		return error;
>  
> +	ns->securityfs_root = dget(sb->s_root);
> +
>  	sb->s_op = &securityfs_super_operations;
>  
> +	if (ns != &init_user_ns)
> +		blocking_notifier_call_chain(&securityfs_ns_notifier,
> +					     SECURITYFS_NS_ADD, ns);

I would propose not to use the notifier logic. While it might be nifty
it's over-engineered in my opinion. The dentry stashing in struct
user_namespace currently serves the purpose to make it retrievable in
ima_fs_ns_init(). That doesn't justify its existence imho.

There is one central place were all users of namespaced securityfs can
create the files that they need to and that is in
securityfs_fill_super(). (If you want to make that more obvious then give
it a subdirectory securityfs and move inode.c in there.)

We simply will expect users to add:

ima_init_securityfs()
mylsm_init_securityfs()

that are to be placed in fill_super

and

ima_kill_securityfs()
mylsm_kill_securityfs()

that get called in kill_super and the root dentry and other relevant
information should be passed explicitly into those functions. Then we
can remove the dentry stashing from struct user_namespace altogether and
the patch gets smaller too.
