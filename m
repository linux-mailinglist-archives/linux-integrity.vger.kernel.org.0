Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9524730E5
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhLMPud (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 10:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhLMPud (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 10:50:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6DC061574;
        Mon, 13 Dec 2021 07:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B446115A;
        Mon, 13 Dec 2021 15:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B359C34603;
        Mon, 13 Dec 2021 15:50:26 +0000 (UTC)
Date:   Mon, 13 Dec 2021 16:50:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v5 13/16] ima: Move some IMA policy and filesystem
 related variables into ima_namespace
Message-ID: <20211213155020.pvadnomqnsub5vg2@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-14-stefanb@linux.ibm.com>
 <20211209191109.o3x7nynnm52zhygz@wittgenstein>
 <0ab33fbc-8438-27b6-ff4c-0321bfc73855@linux.ibm.com>
 <20211210113244.odv2ibrifz2jzft5@wittgenstein>
 <dca4e7c9-87a7-9a9e-b1f2-df16f1a45019@linux.ibm.com>
 <20211211095026.i2gvqjy4df3sxq42@wittgenstein>
 <85b75c98-6452-9706-7549-10b416350b7d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85b75c98-6452-9706-7549-10b416350b7d@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 13, 2021 at 10:33:40AM -0500, Stefan Berger wrote:
> 
> On 12/11/21 04:50, Christian Brauner wrote:
> > On Fri, Dec 10, 2021 at 08:57:11AM -0500, Stefan Berger wrote:
> > > 
> > > 
> > > there anything that would prevent us from setns()'ing to that target user
> > > namespace so that we would now see that of a user namespace that we are not
> > > allowed to see?
> > If you're really worried about someone being able to access a securityfs
> > instance whose userns doesn't match the userns the securityfs instance
> > was mounted in there are multiple ways to fix it. The one that I tend to
> > prefer is:
> > 
> >  From e0ff6a8dcc573763568e685dd70d1547efd68df9 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > Date: Fri, 10 Dec 2021 11:47:37 +0100
> > Subject: !!!! HERE BE DRAGONS - COMPLETELY UNTESTED !!!!
> > 
> > securityfs: only allow access to securityfs from within same namespace
> > 
> > Limit opening of securityfs files to callers located in the same namespace.
> > 
> > ---
> >   security/inode.c | 33 +++++++++++++++++++++++++++++++--
> >   1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/inode.c b/security/inode.c
> > index eaccba7017d9..9eaf757c08cb 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -80,6 +80,35 @@ static struct file_system_type fs_type = {
> >   	.fs_flags =	FS_USERNS_MOUNT,
> >   };
> > +static int securityfs_permission(struct user_namespace *mnt_userns,
> > +				 struct inode *inode, int mask)
> > +{
> > +	int err;
> > +
> > +	err = generic_permission(&init_user_ns, inode, mask);
> > +	if (!err) {
> > +		if (inode->i_sb->s_user_ns != current_user_ns())
> > +			err = -EACCES;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +const struct inode_operations securityfs_dir_inode_operations = {
> > +	.permission	= securityfs_permission,
> > +	.lookup		= simple_lookup,
> > +};
> > +
> > +const struct file_operations securityfs_dir_operations = {
> > +	.permission	= securityfs_permission,
> 
> 
> This interface function on file operations doesn't exist.

It's almost as if the subject line of this patch warned about its draft
character. That was supposed for regular files.

> 
> I'll use the inode_operations and also hook it to the root dentry of the
> super_block. Then there's no need to have this check on symlinks and
> files...

Don't special case the inode_operations for the root inode!
If a privileged process opens an fd refering to a struct file for the
root inode and leaks it to an unprivileged process by accident the
unprivileged process can open any file or directory beneath via openat()
and friends.

Symlinks don't need a .permission handler anyway because they just
contain the name of another file and that is checked for .permission
unless you have a separate .getlink handler where you want to restrict
link contents further.

But regular files need to have a .permission method see openat().
