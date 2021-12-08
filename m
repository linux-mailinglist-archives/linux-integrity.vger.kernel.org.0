Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB9146D6D9
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhLHPZw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 10:25:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36206 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbhLHPZv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 10:25:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 523FDB8217E;
        Wed,  8 Dec 2021 15:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19807C00446;
        Wed,  8 Dec 2021 15:22:10 +0000 (UTC)
Date:   Wed, 8 Dec 2021 16:22:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
Message-ID: <20211208152207.2uxfklsxom3moanz@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-17-stefanb@linux.ibm.com>
 <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
 <dd43783ae76ad3238d99f75d8aaf95e20ad28b79.camel@HansenPartnership.com>
 <20211208144634.rqwn3ccizrbzdq52@wittgenstein>
 <0654f5befe3daa4915ed70be82c512b958a25c9a.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0654f5befe3daa4915ed70be82c512b958a25c9a.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 10:04:55AM -0500, James Bottomley wrote:
> On Wed, 2021-12-08 at 15:46 +0100, Christian Brauner wrote:
> > On Wed, Dec 08, 2021 at 09:11:09AM -0500, James Bottomley wrote:
> > > On Wed, 2021-12-08 at 13:58 +0100, Christian Brauner wrote:
> > > > On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
> > > [...]
> > > > > @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct
> > > > > fs_context *fc)
> > > > >  
> > > > >  static void securityfs_kill_super(struct super_block *sb)
> > > > >  {
> > > > > +	struct user_namespace *ns = sb->s_fs_info;
> > > > > +
> > > > > +	if (ns != &init_user_ns)
> > > > > +		ima_fs_ns_free_dentries(ns);
> > > > 
> > > > Say securityfs is unmounted. Then all the inodes and dentries
> > > > become invalid. It's not allowed to hold on to any dentries or
> > > > inodes after the super_block is shut down. So I just want to be
> > > > sure that nothing in ima can access these dentries after
> > > > securityfs is unmounted.
> > > > 
> > > > To put it another way: why are they stored in struct
> > > > ima_namespace in the first place? If you don't pin a filesystem
> > > > when creating files or directories like you do for securityfs in
> > > > init_ima_ns then you don't need to hold on to them as they will
> > > > be automatically be wiped during umount.
> > > 
> > > For IMA this is true because IMA can't be a module.  However, a
> > > modular
> > 
> > This thread is about ima and its stashing of dentries in struct
> > ima_namespace. That things might be different for other consumers is
> > uninteresting for this specific case, I think.
> 
> Well, yes, but the patch series also includes namespacing securityfs. 
> We have to get that right for all consumers, including the modular
> ones.  So I think the way it works is we don't need a remove callback
> in kill_sb() if we don't raise the dentry refcount in create.  However,
> we still need to return the dentry to allow for stashing and we still
> need to be able to cope with remove being called for the namespaced
> entries ... for teardown on error in the IMA case and module
> removal+teardown on error in other cases.

This is a two-way street. Securityfs namespacing places requirements on
the callers as well. I won't bend generic vfs infrastucture to our will
because some users want to remove dentries at random points. It is on
the users to make sure that they don't cause UAFs when securityfs is
umounted. And that isn't that hard to do. You just need to guard removal
in .kill_sb() with a lock against a concurrent securityfs_remove() call
that some piece of code might want to issue and make sure that any
stashed stuff is properly invalidated.

The point is that we don't need all this right now since we only have
ima as user. I did not say that it cannot be done I said we don't need
to do it for ima. So I feel discussing this point further is deterring
the patches more than it helps them.
