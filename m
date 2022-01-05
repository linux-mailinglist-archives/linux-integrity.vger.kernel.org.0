Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40F4850FD
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 11:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiAEKS3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jan 2022 05:18:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45592 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiAEKS1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jan 2022 05:18:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFB1615C4;
        Wed,  5 Jan 2022 10:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D77DC36AEB;
        Wed,  5 Jan 2022 10:18:18 +0000 (UTC)
Date:   Wed, 5 Jan 2022 11:18:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v8 01/19] securityfs: Extend securityfs with namespacing
 support
Message-ID: <20220105101815.ldsm4s5yx7pmuiil@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-2-stefanb@linux.vnet.ibm.com>
 <YdUXU3XIzhxFUfVB@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdUXU3XIzhxFUfVB@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 05, 2022 at 03:58:11AM +0000, Al Viro wrote:
> On Tue, Jan 04, 2022 at 12:03:58PM -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > To prepare for virtualization of SecurityFS, use simple_pin_fs and
> > simpe_release_fs only when init_user_ns is active.
> > 
> > Extend 'securityfs' for support of IMA namespacing so that each
> > IMA (user) namespace can have its own front-end for showing the currently
> > active policy, the measurement list, number of violations and so on.
> > 
> > Enable multiple instances of securityfs by keying each instance with a
> > pointer to the user namespace it belongs to.
> > 
> > Drop the additional dentry reference to enable simple cleanup of dentries
> > upon umount. Now the dentries do not need to be explicitly freed anymore
> > but we can just rely on d_genocide() and the dcache shrinker to do all
> > the required work.
> 
> Looks brittle...  What are the new rules for securityfs_remove()?  Is it
> still paired with securityfs_create_...()?  When is removal done?  On
> securityfs instance shutdown?  What about the underlying data structures, BTW?
> When can they be freed?
> 
> That kind of commit message is asking for trouble down the road; please,
> document the rules properly.

Yeah, it's not explaining it in detail. I've asked for that as well. My
explanations below are what I expressed it should look like in prior
reviews. I haven't reviewed this version yet so this as I would expect
it to go.

For the initial securityfs, i.e. the one mounted in the host userns
mount nothing changes.
The rules for securityfs_remove() are as before and it is still paired
with securityfs_create(). Specifically, a file created via
securityfs_create_dentry() in the initial securityfs mount still needs
to be removed by a call to securityfs_remove().
Creating a new dentry in the initial securityfs mount still pins the
filesytem like it always did. Consequently, the initial securityfs
mount is not destroyed on umount/shutdown as long as at least one user
of it still has dentries that it hasn't removed with a call to
securityfs_remove().

This specific part of the commit message you responded to is not
giving enough details, I think:

> > Drop the additional dentry reference to enable simple cleanup of dentries
> > upon umount. Now the dentries do not need to be explicitly freed anymore
> > but we can just rely on d_genocide() and the dcache shrinker to do all
> > the required work.

The "additional dentry reference" mentioned only relates to an afaict
unnecessary dget() in securityfs_create_dentry() which I pointed out
as part of earlier reviews. But the phrasing implies that there's a
behavioral change for the initial securityfs instance based on the
removal of this additional dget() when there really isn't.

After securityfs_create_dentry() has created a new dentry via
lookup_one_len() and eventually called d_instantiate() it currently
takes an additional reference on the newly created dentry via dget().
This additional reference is then paired with an additional dput() in
securityfs_remove(). I have not yet seen a reason why this is
necessary maybe you can help there.

For example, contrast this with debugfs which has the same underlying
logic as securityfs, i.e. any created dentry pins the whole filesystem
via simple_pin_fs() until the dentry is released and simple_unpin_fs()
is called. It uses a similar pairing as securityfs: where securityfs
has the securityfs_create_dentry() and securityfs_remove() pairing,
debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
But debugfs doesn't take an additional reference on the just created
dentry in __debugfs_create_file() which would need to be put in
debugfs_remove().

So if we contrast the creation routines of securityfs and debugfs directly
condensed to just the dentry references:

securityfs       |   debugfs
---------------- | ------------------
                 |
lookup_one_len() |   lookup_one_len()
d_instantiate()  |   d_instantiate() 
dget()           |

And I have not understood why securityfs would need that additional
dget(). Not just intrinsically but also when contrasted with debugfs. So
that additional dget() is removed as part of this patch.

But the explanation in the commit message isn't ideal as it implies
the removal of the additional dget() would have any impact on the
pinning logic for securityfs when it does not.

But the pinning logic doesn't make sense outside of the initial
namespace which can never go away and there are security modules that
have files or settings for the whole system that never go away and will
always keep the filesystem around.

But for unprivileged/userns containers that mount their own securityfs
instance we want the securityfs instance cleaned up when it is
unmounted. There is no need to duplicate the pinning logic or make the
global securityfs instance display different information based on the
userns. Both options would be really messy and hacky.

Instead we can simply give each userns it's own securityfs instance
similar to how each ipc ns has its own mqueue instance and all entries
in there are cleaned up on umount or when the whole container is
shutdown. After the container is shutdown all of the security module
settings for the container go away with it anyway. So for that we don't
want any filesystem pinning done in securityfs_create_dentry(). And we
also really don't want the additional dget() that is currently taken in
securityfs_create_dentry() as it would pointlessly require us to dput()
during superblock shutdown afaict. None of this however should cause any
behavioral changes for the initial securityfs instance.

> 
> Incidentally, what happens if you open a file, pass it to somebody in a
> different userns and try to shut the opener's userns down?

I'm not exactly sure what you mean by "shutting down" and whether that's
a generic question or specific to this patch. I assume that you just
mean what happens when the last task for a userns exits and the userns
isn't pinned by e.g. a bind-mount of it to somewhere.

If you're just asking about the generic case then the opener's creds are
pinned by ->f_cred including the caller's userns at open-time. So it
will be released once that file has been closed. 

If you're asking about what happens to the userns the
securityfs/tmpfs/mqueue/devpts etc. instance was mounted in it will be
pinned by the superblock which in turn is pinned by the open file.

Does that answer your question or did you have something else in mind?
