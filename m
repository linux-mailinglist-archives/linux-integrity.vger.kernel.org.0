Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF0646993C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbhLFOqS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhLFOqR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 09:46:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6854C061746;
        Mon,  6 Dec 2021 06:42:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A356B80FAC;
        Mon,  6 Dec 2021 14:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4074C341C1;
        Mon,  6 Dec 2021 14:42:39 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:42:36 +0100
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
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Message-ID: <20211206144236.r3pml6bwswmnjlfo@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <20211206141108.evjrqsmmgpjp3ias@wittgenstein>
 <5650aa13ef875e70d8a87696c4e871f8a4d574a1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5650aa13ef875e70d8a87696c4e871f8a4d574a1.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 06, 2021 at 09:21:15AM -0500, James Bottomley wrote:
> On Mon, 2021-12-06 at 15:11 +0100, Christian Brauner wrote:
> > On Fri, Dec 03, 2021 at 01:06:13PM -0500, Stefan Berger wrote:
> > > On 12/3/21 12:03, James Bottomley wrote:
> [...]
> > > > > +int ima_fs_ns_init(struct ima_namespace *ns)
> > > > > +{
> > > > > +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
> > > >  
> > > > This actually triggers on the call to securityfs_init_fs_context,
> > > > but nothing happens because the callback is null.  Every
> > > > subsequent use of fscontext will trigger this.  The point of a
> > > > keyed supeblock is that fill_super is only called once per key,
> > > > that's the place we should be doing this.   It should also
> > > > probably be a blocking notifier so any consumer of securityfs can
> > > > be namespaced by registering for this notifier.
> > > 
> > > What I don't like about the fill_super is that it gets called too
> > > early:
> > > 
> > > [   67.058611] securityfs_ns_create_mount @ 102 target user_ns:
> > > ffff95c010698c80; nr_extents: 0
> > > [   67.059836] securityfs_fill_super @ 47  user_ns:
> > > ffff95c010698c80;
> > > nr_extents: 0
> > > 
> > > We are switching to the target user namespace in
> > > securityfs_ns_create_mount.  The expected nr_extents at this point
> > > is 0, since user_ns hasn't been configured, yet. But then
> > > security_fill_super is also called with nr_extents 0. We cannot use
> > > that, it's too early!
> > 
> > So the problem is that someone could mount securityfs before any
> > idmappings are setup or what?
> 
> Yes, not exactly: we put a call to initialize IMA in create_user_ns()
> but it's too early to have the mappings, so we can't create the
> securityfs entries in that call.  We need the inode to pick up the root
> owner from the s_user_ns mappings, so we can't create the dentries for
> the IMA securityfs entries until those mappings exist.
> 
> I'm assuming that by the time someone tries to mount securityfs inside
> the namespace, the mappings are set up, which is why triggering the
> notifier to add the files on first mount seems like the best place to
> put it.
> 
> >  How does moving the setup to a later stage help at all? I'm
> > struggling to make sense of this.
> 
> It's not moving all the setup, just the creation of the securityfs
> entries.
> 
> >  When or even if idmappings are written isn't under imas control.
> > Someone could mount securityfs without any idmappings setup. In that
> > case they should get what they deserve, everything owner by
> > overflowuid/overflowgid, no?
> 
> Right, in the current scheme of doing things, if they still haven't
> written the mappings by the time they do the mount, they're just going
> to get nobody/nogroup as uid/gid, but that's their own fault.
> 
> > Or you can require in fill_super that kuid 0 and kgid 0 are mapped
> > and fail if they aren't.
> 
> We can't create the securityfs entries in fill_super ... I already
> tried and the locking just won't allow it.  And if we create them ahead

What is the locking issue there exactly?

I'm looking at ima_fs_ns_late_init() and there's nothing there that
would cause obvious issues. You might not be able to use
securityfs_create_*() in there for some reason but that just means you
need to add a simple helper. Nearly every filesystem that needs to
pre-create files does it in fill_super. So I really fail to see what the
issue is currently. I mist just miss something obvious.
