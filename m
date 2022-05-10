Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEEC521DD3
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiEJPRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbiEJPQM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 11:16:12 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C329B1A2;
        Tue, 10 May 2022 07:51:35 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 712D514B7; Tue, 10 May 2022 09:51:34 -0500 (CDT)
Date:   Tue, 10 May 2022 09:51:34 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux.dev,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, jpenumak@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v12 01/26] securityfs: rework dentry creation
Message-ID: <20220510145134.GA7974@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com>
 <20220509195414.GA30894@mail.hallyn.com>
 <20220509203618.GA31408@mail.hallyn.com>
 <CAOQ4uxjJJVRHrsiOqFokR=zFCV46U+tZJJ74cn9vriucbCHRkA@mail.gmail.com>
 <20220510103817.jalhkw4a2oyqhxhm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510103817.jalhkw4a2oyqhxhm@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 10, 2022 at 12:38:17PM +0200, Christian Brauner wrote:
> On Tue, May 10, 2022 at 11:43:13AM +0300, Amir Goldstein wrote:
> > On Mon, May 9, 2022 at 11:36 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > >
> > > On Mon, May 09, 2022 at 02:54:14PM -0500, Serge E. Hallyn wrote:
> > > > On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
> > > > > From: Christian Brauner <brauner@kernel.org>
> > > > >
> > > > > When securityfs creates a new file or directory via
> > > > > securityfs_create_dentry() it will take an additional reference on the
> > > > > newly created dentry after it has attached the new inode to the new
> > > > > dentry and added it to the hashqueues.
> > > > > If we contrast this with debugfs which has the same underlying logic as
> > > > > securityfs. It uses a similar pairing as securityfs. Where securityfs
> > > > > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > > > > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > > > >
> > > > > In contrast to securityfs, debugfs doesn't take an additional reference
> > > > > on the newly created dentry in __debugfs_create_file() which would need
> > > > > to be put in debugfs_remove().
> > > > >
> > > > > The additional dget() isn't a problem per se. In the current
> > > > > implementation of securityfs each created dentry pins the filesystem via
> > > >
> > > > Is 'via' an extra word here or is there a missing word?
> > > >
> > > > I'll delay the rest of my response as the missing word may answer my
> > > > remaining question :)
> > > >
> > > > > until it is removed. Since it is virtually guaranteed that there is at
> > > > > least one user of securityfs that has created dentries the initial
> > > > > securityfs mount cannot go away until all dentries have been removed.
> > > > >
> > > > > Since most of the users of the initial securityfs mount don't go away
> > > > > until the system is shutdown the initial securityfs won't go away when
> > > > > unmounted. Instead a mount will usually surface the same superblock as
> > > > > before. The additional dget() doesn't matter in this scenario since it
> > > > > is required that all dentries have been cleaned up by the respective
> > > > > users before the superblock can be destroyed, i.e. superblock shutdown
> > > > > is tied to the lifetime of the associated dentries.
> > > > >
> > > > > However, in order to support ima namespaces we need to extend securityfs
> > > > > to support being mounted outside of the initial user namespace. For
> > > > > namespaced users the pinning logic doesn't make sense. Whereas in the
> > > > > initial namespace the securityfs instance and the associated data
> > > > > structures of its users can't go away for reason explained earlier users
> > > > > of non-initial securityfs instances do go away when the last users of
> > > > > the namespace are gone.
> > > > >
> > > > > So for those users we neither want to duplicate the pinning logic nor
> > > > > make the global securityfs instance display different information based
> > > > > on the namespace. Both options would be really messy and hacky.
> > > > >
> > > > > Instead we will simply give each namespace its own securityfs instance
> > > > > similar to how each ipc namespace has its own mqueue instance and all
> > > > > entries in there are cleaned up on umount or when the last user of the
> > > > > associated namespace is gone.
> > > > >
> > > > > This means that the superblock's lifetime isn't tied to the dentries.
> > > > > Instead the last umount, without any fds kept open, will trigger a clean
> > > > > shutdown. But now the additional dget() gets in the way. Instead of
> > > > > being able to rely on the generic superblock shutdown logic we would
> > > > > need to drop the additional dentry reference during superblock shutdown
> > > > > for all associated users. That would force the use of a generic
> > > > > coordination mechanism for current and future users of securityfs which
> > > > > is unnecessary. Simply remove the additional dget() in
> > > > > securityfs_dentry_create().
> > > > >
> > > > > In securityfs_remove() we will call dget() to take an additional
> > > > > reference on the dentry about to be removed. After simple_unlink() or
> > > > > simple_rmdir() have dropped the dentry refcount we can call d_delete()
> > > > > which will either turn the dentry into negative dentry if our earlier
> > > > > dget() is the only reference to the dentry, i.e. it has no other users,
> > > > > or remove it from the hashqueues in case there are additional users.
> > > > >
> > 
> > The first case (turn negative) cannot happen because the function is
> > entered with at least 1 refcount and increments it by 1.
> > So you can follow commit 46c46f8df9aa ("devpts_pty_kill(): don't bother
> > with d_delete()") and use d_drop() instead.
> > 
> > > > > All of these changes should not have any effect on the userspace
> > > > > semantics of the initial securityfs mount.
> > > > >
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > Cc: John Johansen <john.johansen@canonical.com>
> > > > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > > Cc: Micah Morton <mortonm@chromium.org>
> > > > > Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> > > > > Cc: James Morris <jmorris@namei.org>
> > > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > ---
> > > > >  security/inode.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/security/inode.c b/security/inode.c
> > > > > index 6c326939750d..13e6780c4444 100644
> > > > > --- a/security/inode.c
> > > > > +++ b/security/inode.c
> > > > > @@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
> > > > >             inode->i_fop = fops;
> > > > >     }
> > > > >     d_instantiate(dentry, inode);
> > > > > -   dget(dentry);
> > > > >     inode_unlock(dir);
> > > > >     return dentry;
> > > > >
> > > > > @@ -302,10 +301,12 @@ void securityfs_remove(struct dentry *dentry)
> > > > >     dir = d_inode(dentry->d_parent);
> > > > >     inode_lock(dir);
> > > > >     if (simple_positive(dentry)) {
> > > > > +           dget(dentry);
> > > > >             if (d_is_dir(dentry))
> > > > >                     simple_rmdir(dir, dentry);
> > >
> > > Hm, so I realize your patch isn't introducing this, but is the
> > > fact that we ignore the possible -ENOTEMPTY return value of
> > > simple_rmdir() not a problem?
> > 
> > As long as we are using debugfs as a reference code, wouldn't
> > securityfs need to use simple_recursive_removal()?
> > Can we guaranty that modules always cleanup all entries in
> > correct order?
> 
> We could but that seems like a separate cleanup patch.

Yes, I'm not saying this set should fix it, just something that
caught my eye.  Thanks.

> This patch became part of the series because we want non-initial ima
> namespaces to guarantee cleanup on securityfs umount. That's different
> for the initial securityfs mount which is alwasy going to be around. The
> patch is intended to this a little cleaner to implement.
