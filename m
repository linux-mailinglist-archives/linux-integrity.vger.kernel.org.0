Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B604A469825
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 15:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbhLFOOt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 09:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245682AbhLFOOr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 09:14:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0869C061746;
        Mon,  6 Dec 2021 06:11:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F6C3612C2;
        Mon,  6 Dec 2021 14:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20560C341C1;
        Mon,  6 Dec 2021 14:11:11 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:11:08 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Message-ID: <20211206141108.evjrqsmmgpjp3ias@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 03, 2021 at 01:06:13PM -0500, Stefan Berger wrote:
> 
> On 12/3/21 12:03, James Bottomley wrote:
> > On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
> > [...]
> > >   static int securityfs_init_fs_context(struct fs_context *fc)
> > >   {
> > > +	int rc;
> > > +
> > > +	if (fc->user_ns->ima_ns->late_fs_init) {
> > > +		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > >   	fc->ops = &securityfs_context_ops;
> > >   	return 0;
> > >   }
> > I know I suggested this, but to get this to work in general, it's going
> > to have to not be specific to IMA, so it's going to have to become
> > something generic like a notifier chain.  The other problem is it's
> > only working still by accident:
> 
> I had thought about this also but the rationale was:
> 
> securityfs is compiled due to CONFIG_IMA_NS and the user namespace exists
> there and that has a pointer now to ima_namespace, which can have that
> callback. I assumed that other namespaced subsystems could also be reached
> then via such a callback, but I don't know.
> 
> I suppose any late filesystem init callchain would have to be connected to
> the user_namespace somehow?
> 
> 
> > 
> > > +int ima_fs_ns_init(struct ima_namespace *ns)
> > > +{
> > > +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
> > This actually triggers on the call to securityfs_init_fs_context, but
> > nothing happens because the callback is null.  Every subsequent use of
> > fscontext will trigger this.  The point of a keyed supeblock is that
> > fill_super is only called once per key, that's the place we should be
> > doing this.   It should also probably be a blocking notifier so any
> > consumer of securityfs can be namespaced by registering for this
> > notifier.
> 
> 
> What I don't like about the fill_super is that it gets called too early:
> 
> [   67.058611] securityfs_ns_create_mount @ 102 target user_ns:
> ffff95c010698c80; nr_extents: 0
> [   67.059836] securityfs_fill_super @ 47  user_ns: ffff95c010698c80;
> nr_extents: 0
> 
> We are switching to the target user namespace in securityfs_ns_create_mount.
> The expected nr_extents at this point is 0, since user_ns hasn't been
> configured, yet. But then security_fill_super is also called with nr_extents
> 0. We cannot use that, it's too early!

So the problem is that someone could mount securityfs before any
idmappings are setup or what? How does moving the setup to a later stage
help at all? I'm struggling to make sense of this. When or even if
idmappings are written isn't under imas control. Someone could mount
securityfs without any idmappings setup. In that case they should get
what they deserve, everything owner by overflowuid/overflowgid, no? Or
you can require in fill_super that kuid 0 and kgid 0 are mapped and fail
if they aren't.
