Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFD469571
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbhLFMM1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 07:12:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54076 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242776AbhLFMM1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 07:12:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FECCB8105C;
        Mon,  6 Dec 2021 12:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B880C341C2;
        Mon,  6 Dec 2021 12:08:50 +0000 (UTC)
Date:   Mon, 6 Dec 2021 13:08:47 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     jejb@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Message-ID: <20211206120847.ayr3zycigld6rf4j@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 03, 2021 at 11:37:14AM -0800, Casey Schaufler wrote:
> On 12/3/2021 10:50 AM, James Bottomley wrote:
> > On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
> > > On 12/3/21 12:03, James Bottomley wrote:
> > > > On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
> > > > [...]
> > > > >    static int securityfs_init_fs_context(struct fs_context *fc)
> > > > >    {
> > > > > +	int rc;
> > > > > +
> > > > > +	if (fc->user_ns->ima_ns->late_fs_init) {
> > > > > +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
> > > > > +		if (rc)
> > > > > +			return rc;
> > > > > +	}
> > > > >    	fc->ops = &securityfs_context_ops;
> > > > >    	return 0;
> > > > >    }
> > > > I know I suggested this, but to get this to work in general, it's
> > > > going to have to not be specific to IMA, so it's going to have to
> > > > become something generic like a notifier chain.  The other problem
> > > > is it's only working still by accident:
> > > I had thought about this also but the rationale was:
> > > 
> > > securityfs is compiled due to CONFIG_IMA_NS and the user namespace
> > > exists there and that has a pointer now to ima_namespace, which can
> > > have that callback. I assumed that other namespaced subsystems could
> > > also be  reached then via such a callback, but I don't know.
> > Well securityfs is supposed to exist for LSMs.  At some point each of
> > those is going to need to be namespaced, which may eventually be quite
> > a pile of callbacks, which is why I thought of a notifier.
> 
> While AppArmor, lockdown and the integrity family use securityfs,
> SELinux and Smack do not. They have their own independent filesystems.
> Implementations of namespacing for each of SELinux and Smack have been
> proposed, but nothing has been adopted. It would be really handy to
> namespace the infrastructure rather than each individual LSM, but I
> fear that's a bigger project than anyone will be taking on any time
> soon. It's likely to encounter many of the same issues that I've been
> dealing with for module stacking.

The main thing that bothers me is that it uses simple_pin_fs() and
simple_unpin_fs() which I would try hard to get rid of if possible. The
existence of this global pinning logic makes namespacing it properly
more difficult then it needs to be and it creates imho wonky semantics
where the last unmount doesn't really destroy the superblock. Instead
subsequents mounts resurface the same superblock. There might be an
inherent design reason why this needs to be this way but I would advise
against these semantics for anything that wants to be namespaced.
Probably the first securityfs mount in init_user_ns can follow these
semantics but ones tied to a non-initial user namespace should not as
the userns can go away. In that case the pinning logic seems strange as
conceptually the userns pins the securityfs mount as evidenced by the
fact that we key by it in get_tree_keyed().

> 
> > 
> > > I suppose any late filesystem init callchain would have to be
> > > connected to the user_namespace somehow?
> > I don't think so; I think just moving some securityfs entries into the
> > user_namespace and managing the notifier chain from within securityfs
> > will do for now.  [although I'd have to spec this out in code before I
> > knew for sure].
> > 
> > > > > +int ima_fs_ns_init(struct ima_namespace *ns)
> > > > > +{
> > > > > +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
> > > > This actually triggers on the call to securityfs_init_fs_context,
> > > > but nothing happens because the callback is null.  Every subsequent
> > > > use of fscontext will trigger this.  The point of a keyed supeblock
> > > > is that fill_super is only called once per key, that's the place we
> > > > should be doing this.   It should also probably be a blocking
> > > > notifier so anyconsumer of securityfs can be namespaced by
> > > > registering for this notifier.
> > > What I don't like about the fill_super is that it gets called too
> > > early:
> > > 
> > > [   67.058611] securityfs_ns_create_mount @ 102 target user_ns:
> > > ffff95c010698c80; nr_extents: 0
> > > [   67.059836] securityfs_fill_super @ 47  user_ns:
> > > ffff95c010698c80;
> > > nr_extents: 0
> > Right, it's being activated by securityfs_ns_create_mount which is
> > called as soon as the user_ns is created.
> > 
> > > We are switching to the target user namespace in
> > > securityfs_ns_create_mount. The expected nr_extents at this point is
> > > 0, since user_ns hasn't been configured, yet. But then
> > > security_fill_super is also called with nr_extents 0. We cannot use
> > > that, it's too early!
> > Exactly, so I was thinking of not having a securityfs_ns_create_mount
> > at all.  All the securityfs_ns_create.. calls would be in the notifier
> > call chain. This means there's nothing to fill the superblock until an
> > actual mount on it is called.
> > 
> > > > > +	if (IS_ERR(ns->mount)) {
> > > > > +		ns->mount = NULL;
> > > > > +		return -1;
> > > > > +	}
> > > > > +	ns->mount_count = 1;
> > > > This is a bit nasty, too: we're spilling the guts of mount count
> > > > tracking into IMA instead of encapsulating it inside securityfs.
> > > Ok, I can make this disappear.
> > > 
> > > 
> > > > > +
> > > > > +	/* Adjust the trigger for user namespace's early teardown of
> > > > > dependent
> > > > > +	 * namespaces. Due to the filesystem there's an additional
> > > > > reference
> > > > > +	 * to the user namespace.
> > > > > +	 */
> > > > > +	ns->user_ns->refcount_teardown += 1;
> > > > > +
> > > > > +	ns->late_fs_init = ima_fs_ns_late_init;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > I think what should be happening is that we shouldn't so the
> > > > simple_pin_fs, which creates the inodes, ahead of time; we should
> > > > do it inside fill_super using a notifier, meaning it gets called
> > > > once per
> > > fill_super would only work for the init_user_ns from what I can see.
> > > 
> > > 
> > > > key, creates the root dentry then triggers the notifier which
> > > > instantiates all the namespaced entries.  We can still use
> > > > simple_pin_fs for this because there's no locking across
> > > > fill_super.
> > > > This would mean fill_super would be called the first time the
> > > > securityfs is mounted inside the namespace.
> > > I guess I would need to know how fill_super would work or how it
> > > could be called late/delayed as well.
> > So it would be called early in the init_user_ns by non-namespaced
> > consumers of securityfs, like it is now.
> > 
> > Namespaced consumers wouldn't call any securityfs_ns_create callbacks
> > to create dentries until they were notified from the fill_super
> > notifier, which would now only be triggered on first mount of
> > securityfs inside the namespace.
> > 
> > > > If we do it this way, we can now make securityfs have its own mount
> > > > and mount_count inside the user namespace, which it uses internally
> > > > to the securityfs code, thus avoiding exposing them to ima or any
> > > > other namespaced consumer.
> > > > 
> > > > I also think we now don't need the securityfs_ns_ duplicated
> > > > functions because the callback via the notifier chain now ensures
> > > > we can usethe namespace they were created in to distinguish between
> > > > non namespaced and namespaced entries.
> > > Is there then no need to pass a separate vfsmount * in anymore?
> > I don't think so no.  It could be entirely managed internally to
> > securityfs.
> > 
> > > Where would the vfsmount pointer reside? For now it's in
> > > ima_namespace, but it sounds like it should be in a more centralized
> > > place? Should it also be  connected to the user_namespace so we can
> > > pick it up using get_user_ns()?
> > exactly.  I think struct user_namespace should have two elements gated
> > by a #ifdef CONFIG_SECURITYFS which are the vfsmount and the
> > mount_count for passing into simple_pin_fs.
> > 
> > 
> > James
> > 
> > 
> 
