Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092A846D75B
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhLHPxJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 10:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhLHPxI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 10:53:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD4C061746;
        Wed,  8 Dec 2021 07:49:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7AE4CE1FAC;
        Wed,  8 Dec 2021 15:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74168C00446;
        Wed,  8 Dec 2021 15:49:27 +0000 (UTC)
Date:   Wed, 8 Dec 2021 16:49:23 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
Message-ID: <20211208154923.7bhratd754o4vobu@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-17-stefanb@linux.ibm.com>
 <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
 <711ce320-25c7-5ace-a026-89a55dc7c068@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <711ce320-25c7-5ace-a026-89a55dc7c068@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 10:39:48AM -0500, Stefan Berger wrote:
> 
> On 12/8/21 07:58, Christian Brauner wrote:
> > On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
> > >   #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> > > diff --git a/security/inode.c b/security/inode.c
> > > index 121ac1874dde..10ee20917f42 100644
> > > --- a/security/inode.c
> > > +++ b/security/inode.c
> > > @@ -16,6 +16,7 @@
> > >   #include <linux/fs_context.h>
> > >   #include <linux/mount.h>
> > >   #include <linux/pagemap.h>
> > > +#include <linux/ima.h>
> > >   #include <linux/init.h>
> > >   #include <linux/namei.h>
> > >   #include <linux/security.h>
> > > @@ -41,6 +42,7 @@ static const struct super_operations securityfs_super_operations = {
> > >   static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >   {
> > >   	static const struct tree_descr files[] = {{""}};
> > > +	struct user_namespace *ns = fc->user_ns;
> > >   	int error;
> > >   	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> > > @@ -49,7 +51,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >   	sb->s_op = &securityfs_super_operations;
> > > -	return 0;
> > > +	if (ns != &init_user_ns)
> > > +		error = ima_fs_ns_init(ns, sb->s_root);
> > > +
> > > +	return error;
> > >   }
> > >   static int securityfs_get_tree(struct fs_context *fc)
> > > @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct fs_context *fc)
> > >   static void securityfs_kill_super(struct super_block *sb)
> > >   {
> > > +	struct user_namespace *ns = sb->s_fs_info;
> > > +
> > > +	if (ns != &init_user_ns)
> > > +		ima_fs_ns_free_dentries(ns);
> > Say securityfs is unmounted. Then all the inodes and dentries become
> > invalid. It's not allowed to hold on to any dentries or inodes after the
> > super_block is shut down. So I just want to be sure that nothing in ima
> > can access these dentries after securityfs is unmounted.
> 
> > To put it another way: why are they stored in struct ima_namespace in
> > the first place? If you don't pin a filesystem when creating files or
> > directories like you do for securityfs in init_ima_ns then you don't
> > need to hold on to them as they will be automatically be wiped during
> > umount.
> 
> 
> The reason was so that securityfs for init_ima_ns and IMA namespaces could
> share the code assigning to dentries to keep around and can clean up if an
> error occurs while creating a dentry.
> 
> What about this: We keep the dentries in the ima_namespace, modify the code
> creating the dentries in securityfs_create_dentry() to only take the
> additional reference in case of init_user_ns (I suppose this is what you
> suggest) and then keep 'static void ima_fs_ns_free_dentries()' only for
> removing the dentries for the error case and never call it from
> securityfs_kill_super()? Would that be acceptable?

If you create a range of dentries in fill_super post sb->s_root is
properly allocated and you fail in the middle you can simply return from
fill_super without bothering to clean them up as the vfs will
automatically clean those up when the dcache shrinker runs (If you've
increased the refcount as these functions do currently you need to
decrease it of course.).
