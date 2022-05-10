Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07352122B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiEJKaf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbiEJKae (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 06:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DCB1E250C;
        Tue, 10 May 2022 03:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D569561717;
        Tue, 10 May 2022 10:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F86C385C6;
        Tue, 10 May 2022 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652178396;
        bh=F7UCs6MY2v5gEg3OOGEyNsq6zFa48822pWX1xYsPpAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KE55aPGkw7dfdqaaR2oZ817K6C3dkPClEwJ3JeUvvOJmWZX4gCeduI9qV8eRTpXol
         KXG8kx/AHmcxSmbMjABfiauAOzG7NrBLtGGa4vidbKdX7yQJV49RY1KC479Jfg8rQW
         uxW1XxT4Ib8cyv18w/VrY48xQGyN3PtIYFhoFUUWHnN9WfJztQ8pnnJE6YEh2Y6c44
         jmxpXtKftWBsRTttyP+5qbCAge1vSDjFgHok7Z61R0emmGbtcKc3352ffBsfQzQHps
         72WHQlOYZ0PTdkHFjvE47D3nGDHy4wFV0oNoqe4kydgYEBTVkIuermvbJaTYYNGBKh
         /9Dk6cl+oMRVQ==
Date:   Tue, 10 May 2022 12:26:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v12 01/26] securityfs: rework dentry creation
Message-ID: <20220510102627.t7tzxkuigt7w7fyw@wittgenstein>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com>
 <20220509195414.GA30894@mail.hallyn.com>
 <20220509203618.GA31408@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509203618.GA31408@mail.hallyn.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 03:36:18PM -0500, Serge Hallyn wrote:
> On Mon, May 09, 2022 at 02:54:14PM -0500, Serge E. Hallyn wrote:
> > On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > > 
> > > When securityfs creates a new file or directory via
> > > securityfs_create_dentry() it will take an additional reference on the
> > > newly created dentry after it has attached the new inode to the new
> > > dentry and added it to the hashqueues.
> > > If we contrast this with debugfs which has the same underlying logic as
> > > securityfs. It uses a similar pairing as securityfs. Where securityfs
> > > has the securityfs_create_dentry() and securityfs_remove() pairing,
> > > debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> > > 
> > > In contrast to securityfs, debugfs doesn't take an additional reference
> > > on the newly created dentry in __debugfs_create_file() which would need
> > > to be put in debugfs_remove().
> > > 
> > > The additional dget() isn't a problem per se. In the current
> > > implementation of securityfs each created dentry pins the filesystem via
> > 
> > Is 'via' an extra word here or is there a missing word?
> > 
> > I'll delay the rest of my response as the missing word may answer my
> > remaining question :)
> > 
> > > until it is removed. Since it is virtually guaranteed that there is at
> > > least one user of securityfs that has created dentries the initial
> > > securityfs mount cannot go away until all dentries have been removed.
> > > 
> > > Since most of the users of the initial securityfs mount don't go away
> > > until the system is shutdown the initial securityfs won't go away when
> > > unmounted. Instead a mount will usually surface the same superblock as
> > > before. The additional dget() doesn't matter in this scenario since it
> > > is required that all dentries have been cleaned up by the respective
> > > users before the superblock can be destroyed, i.e. superblock shutdown
> > > is tied to the lifetime of the associated dentries.
> > > 
> > > However, in order to support ima namespaces we need to extend securityfs
> > > to support being mounted outside of the initial user namespace. For
> > > namespaced users the pinning logic doesn't make sense. Whereas in the
> > > initial namespace the securityfs instance and the associated data
> > > structures of its users can't go away for reason explained earlier users
> > > of non-initial securityfs instances do go away when the last users of
> > > the namespace are gone.
> > > 
> > > So for those users we neither want to duplicate the pinning logic nor
> > > make the global securityfs instance display different information based
> > > on the namespace. Both options would be really messy and hacky.
> > > 
> > > Instead we will simply give each namespace its own securityfs instance
> > > similar to how each ipc namespace has its own mqueue instance and all
> > > entries in there are cleaned up on umount or when the last user of the
> > > associated namespace is gone.
> > > 
> > > This means that the superblock's lifetime isn't tied to the dentries.
> > > Instead the last umount, without any fds kept open, will trigger a clean
> > > shutdown. But now the additional dget() gets in the way. Instead of
> > > being able to rely on the generic superblock shutdown logic we would
> > > need to drop the additional dentry reference during superblock shutdown
> > > for all associated users. That would force the use of a generic
> > > coordination mechanism for current and future users of securityfs which
> > > is unnecessary. Simply remove the additional dget() in
> > > securityfs_dentry_create().
> > > 
> > > In securityfs_remove() we will call dget() to take an additional
> > > reference on the dentry about to be removed. After simple_unlink() or
> > > simple_rmdir() have dropped the dentry refcount we can call d_delete()
> > > which will either turn the dentry into negative dentry if our earlier
> > > dget() is the only reference to the dentry, i.e. it has no other users,
> > > or remove it from the hashqueues in case there are additional users.
> > > 
> > > All of these changes should not have any effect on the userspace
> > > semantics of the initial securityfs mount.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > Cc: John Johansen <john.johansen@canonical.com>
> > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > Cc: Micah Morton <mortonm@chromium.org>
> > > Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  security/inode.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/inode.c b/security/inode.c
> > > index 6c326939750d..13e6780c4444 100644
> > > --- a/security/inode.c
> > > +++ b/security/inode.c
> > > @@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
> > >  		inode->i_fop = fops;
> > >  	}
> > >  	d_instantiate(dentry, inode);
> > > -	dget(dentry);
> > >  	inode_unlock(dir);
> > >  	return dentry;
> > >  
> > > @@ -302,10 +301,12 @@ void securityfs_remove(struct dentry *dentry)
> > >  	dir = d_inode(dentry->d_parent);
> > >  	inode_lock(dir);
> > >  	if (simple_positive(dentry)) {
> > > +		dget(dentry);
> > >  		if (d_is_dir(dentry))
> > >  			simple_rmdir(dir, dentry);
> 
> Hm, so I realize your patch isn't introducing this, but is the
> fact that we ignore the possible -ENOTEMPTY return value of
> simple_rmdir() not a problem?
> 
> > >  		else
> > >  			simple_unlink(dir, dentry);
> > > +		d_delete(dentry);
> 
> I'm mostly trying to convince myself that the fact that there is not
> a matching dput being removed (to match the dget being removed above)
> is ok.  I do think it is, but that belief seems to dictate that right
> now dentries must never be being released.
> 
> Otherwise, it seems like there must be cases where the next dput could
> be called on a dentry that has been freed.

I think that's answered by Amir in the next mail already. So I'm
skipping to that part of the thread.
