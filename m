Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D748AF35
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 15:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiAKOMh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 09:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiAKOMg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 09:12:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E0C06173F;
        Tue, 11 Jan 2022 06:12:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3195C614C5;
        Tue, 11 Jan 2022 14:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44306C36AEB;
        Tue, 11 Jan 2022 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641910355;
        bh=39gsf/zi5FwfVpRQ7qXWhjiEz5h+LSXUb6QfZmEYPWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXtYONf8inAFnV/Pgm0SkIEhw+f4XV2MIqoNW66nD1n4hBbyIFSYyTXy9CTX73yTR
         85qowFyGhmfiGST8+1cBJP0/CoFu0Ssex1g6P91e01r/mNnObkUOGj8S8EtmkxPt3l
         zQHGG0qY5MFUxrWVVJwx+31DVD0NOiDINuoISJwahn44npaxO2nhq6ElGBqN9jAWpr
         yvvKQjGM3StP9sejuUdgIJObRri4pwG+pvDmu6t+z1Jf21tG3ytb2fxTMihr/cPQUk
         cukE5xlYUf7k7IZhPGgFOzwkwCE1FNqgRMqlILcgP/3M1LTfO7fCWreKfdgtoVPmld
         7myFHqjQME1aQ==
Date:   Tue, 11 Jan 2022 15:12:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v8 01/19] securityfs: Extend securityfs with namespacing
 support
Message-ID: <20220111141227.27upfpzhqwyob3ev@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-2-stefanb@linux.vnet.ibm.com>
 <YdUXU3XIzhxFUfVB@zeniv-ca.linux.org.uk>
 <20220105101815.ldsm4s5yx7pmuiil@wittgenstein>
 <d11458798496f2aed2fb31a7bb077f5938174083.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d11458798496f2aed2fb31a7bb077f5938174083.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 07:16:26AM -0500, Mimi Zohar wrote:
> On Wed, 2022-01-05 at 11:18 +0100, Christian Brauner wrote:
> > On Wed, Jan 05, 2022 at 03:58:11AM +0000, Al Viro wrote:
> > > On Tue, Jan 04, 2022 at 12:03:58PM -0500, Stefan Berger wrote:
> > > > From: Stefan Berger <stefanb@linux.ibm.com> 
> 
> > > > Drop the additional dentry reference to enable simple cleanup of dentries
> > > > upon umount. Now the dentries do not need to be explicitly freed anymore
> > > > but we can just rely on d_genocide() and the dcache shrinker to do all
> > > > the required work.
> > 
> > The "additional dentry reference" mentioned only relates to an afaict
> > unnecessary dget() in securityfs_create_dentry() which I pointed out
> > as part of earlier reviews. But the phrasing implies that there's a
> > behavioral change for the initial securityfs instance based on the
> > removal of this additional dget() when there really isn't.
> > 
> > After securityfs_create_dentry() has created a new dentry via
> > lookup_one_len() and eventually called d_instantiate() it currently
> > takes an additional reference on the newly created dentry via dget().
> > This additional reference is then paired with an additional dput() in
> > securityfs_remove(). I have not yet seen a reason why this is
> > necessary maybe you can help there.
> > 
> > For example, contrast this with debugfs which has the same underlying
> > logic as securityfs, i.e. any created dentry pins the whole filesystem
> > via simple_pin_fs() until the dentry is released and simple_unpin_fs()
> > is called. It uses a similar pairing as securityfs: where securityfs
> > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > But debugfs doesn't take an additional reference on the just created
> > dentry in __debugfs_create_file() which would need to be put in
> > debugfs_remove().
> > 
> > So if we contrast the creation routines of securityfs and debugfs directly
> > condensed to just the dentry references:
> > 
> > securityfs       |   debugfs
> > ---------------- | ------------------
> >                  |
> > lookup_one_len() |   lookup_one_len()
> > d_instantiate()  |   d_instantiate() 
> > dget()           |
> > 
> > And I have not understood why securityfs would need that additional
> > dget(). Not just intrinsically but also when contrasted with debugfs. So
> > that additional dget() is removed as part of this patch.
> 
> Assuming it isn't needed, could removing it be a separate patch and
> upstreamed independently of either the securityfs or IMA namespacing
> changes?

Yeah, if the security tree wants to take it. So sm like:

From 478e96d1da24960e50897e6752f410b3d0833570 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Jan 2022 14:04:11 +0100
Subject: [PATCH] securityfs: rework dentry creation

When securityfs creates a new file or directory via
securityfs_create_dentry() it will take an additional reference on the
newly created dentry after it has attached the new inode to the new
dentry and added it to the hashqueues.
If we contrast this with debugfs which has the same underlying logic as
securityfs. It uses a similar pairing as securityfs. Where securityfs
has the securityfs_create_dentry() and securityfs_remove() pairing,
debugfs has the __debugfs_create_file() and debugfs_remove() pairing.

In contrast to securityfs, debugfs doesn't take an additional reference
on the newly created dentry in __debugfs_create_file() which would need
to be put in debugfs_remove().

The additional dget() isn't a problem per se. In the current
implementation of securityfs each created dentry pins the filesystem via
until it is removed. Since it is virtually guaranteed that there is at
least one user of securityfs that has created dentries the initial
securityfs mount cannot go away until all dentries have been removed.

Since most of the users of the initial securityfs mount don't go away
until the system is shutdown the initial securityfs won't go away when
unmounted. Instead a mount will usually surface the same superblock as
before. The additional dget() doesn't matter in this scenario since it
is required that all dentries have been cleaned up by the respective
users before the superblock can be destroyed, i.e. superblock shutdown
is tied to the lifetime of the associated dentries.

However, in order to support ima namespaces we need to extend securityfs
to support being mounted outside of the initial user namespace. For
namespaced users the pinning logic doesn't make sense. Whereas in the
initial namespace the securityfs instance and the associated data
structures of its users can't go away for reason explained earlier users
of non-initial securityfs instances do go away when the last users of
the namespace are gone.

So for those users we neither want to duplicate the pinning logic nor
make the global securityfs instance display different information based
on the namespace. Both options would be really messy and hacky.

Instead we will simply give each namespace its own securityfs instance
similar to how each ipc namespace has its own mqueue instance and all
entries in there are cleaned up on umount or when the last user of the
associated namespace is gone.

This means that the superblock's lifetime isn't tied to the dentries.
Instead the last umount, without any fds kept open, will trigger a clean
shutdown. But now the additional dget() gets in the way. Instead of
being able to rely on the generic superblock shutdown logic we would
need to drop the additional dentry reference during superblock shutdown
for all associated users. That would force the use of a generic
coordination mechanism for current and future users of securityfs which
is unnecessary. Simply remove the additional dget() in
securityfs_dentry_create().

In securityfs_remove() we will call dget() to take an additional
reference on the dentry about to be removed. After simple_unlink() or
simple_rmdir() have dropped the dentry refcount we can call d_delete()
which will either turn the dentry into negative dentry if our earlier
dget() is the only reference to the dentry, i.e. it has no other users,
or remove it from the hashqueues in case there are additional users.

All of these changes should not have any effect on the userspace
semantics of the initial securityfs mount.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 security/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..13e6780c4444 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -302,10 +301,12 @@ void securityfs_remove(struct dentry *dentry)
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
+		dget(dentry);
 		if (d_is_dir(dentry))
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.32.0

