Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39947883B
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Dec 2021 10:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhLQJzW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 04:55:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56542 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbhLQJzW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 04:55:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AE062070;
        Fri, 17 Dec 2021 09:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25DCC36AE8;
        Fri, 17 Dec 2021 09:55:16 +0000 (UTC)
Date:   Fri, 17 Dec 2021 10:55:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v7 01/14] ima: Add IMA namespace support
Message-ID: <20211217095513.bzlkwboq3y6yqeyx@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216054323.1707384-2-stefanb@linux.vnet.ibm.com>
 <20211216140806.hi4jxw54yvbu5cox@wittgenstein>
 <f408c42b74e28d90fce262abd50fc8a3079c0fa3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f408c42b74e28d90fce262abd50fc8a3079c0fa3.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 04:52:47PM -0500, James Bottomley wrote:
> On Thu, 2021-12-16 at 15:08 +0100, Christian Brauner wrote:
> > On Thu, Dec 16, 2021 at 12:43:10AM -0500, Stefan Berger wrote:
> [...]
> > > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > > index 6b2e3ca7ee99..6fa01323aac9 100644
> > > --- a/kernel/user_namespace.c
> > > +++ b/kernel/user_namespace.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/fs_struct.h>
> > >  #include <linux/bsearch.h>
> > >  #include <linux/sort.h>
> > > +#include <linux/ima.h>
> > >  
> > >  static struct kmem_cache *user_ns_cachep __read_mostly;
> > >  static DEFINE_MUTEX(userns_state_mutex);
> > > @@ -141,8 +142,14 @@ int create_user_ns(struct cred *new)
> > >  	if (!setup_userns_sysctls(ns))
> > >  		goto fail_keyring;
> > >  
> > > +	ret = create_ima_ns(ns);
> > 
> > Instead of greedily allocating a new ima namespace for each new user
> > namespace creation and wasting memory that is likely wasted since
> > most containers won't use ima (for a long time at least) have you
> > considered lazily allocating it like I suggested in one of my first
> > reviews?
> > 
> > So under the assumption that the only way for a container to get its
> > own ima policy it needs to have mounted a new securityfs instance you
> > can move the ima namespace allocation into
> > fill_super/ima_fs_ns_init():
> 
> The current patch set has the ima namespace born with an empty policy,
> meaning it can never do anything until a new policy is inserted via a
> write to the securityfs, and therefore the IMA namespace could be
> lazily allocated.  However, that's not quite how the initial IMA
> namespace behaves because a policy can be passed in on the kernel
> command line (or built into the kernel).  If the ima NS were born with
> a default policy (say taken from the initial IMA default policy, or
> simply inherited from the parent at creation time) then we wouldn't be
> able to do lazy allocation.  Before we tie ourselves to never being
> able to have a default policy for an IMA namespace, perhaps we should
> discuss if this is the correct behaviour we want to nail into the
> system.

If ima in the future decides to do policy inheritance it can simply
switch from delayed allocation at mount time to allocation at userns
creation time. So we can proceed with lazy allocation without much
problem for now.

In addition what is happening now is in effect policy inheritance, i.e.
each container is bound by the parent ima_ns policy until it decides to
setup its own.

Aside from that the container manager can and should be responsible for
the default ima policy to apply to containers. The default ima policy
can be passed through the spec file, configuration file, or - for the
hardcore people - compiled into the container manager itself. This is
not different from LSMs (e.g. AppArmor, seccomp) where the policy for
each container is generated from a fixed template that was built into
the container manager binary and then written via
/proc/<pid>/attr/current during container setup.

During container setup the process that ultimately calls exec to execute
the payload does all of the required setup work. The setup process
should not be automatically bound by a default policy that gets created
when the userns is created. That will just cause problems during
container setup.
Until the setup process has decided that all preliminary setup steps are
done only the ancestor policy should restrict it.
This is exactly the same for all LSMs and seccomp. They all are usually
setup closely before calling exec. I see no reason for ima to diverge
from this model.
