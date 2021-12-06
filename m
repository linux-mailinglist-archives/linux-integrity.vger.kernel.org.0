Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85432469863
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbhLFORk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 09:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbhLFORj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 09:17:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B1C061746;
        Mon,  6 Dec 2021 06:14:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EE7AB810E8;
        Mon,  6 Dec 2021 14:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D707AC341D9;
        Mon,  6 Dec 2021 14:14:02 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:13:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Message-ID: <20211206141359.van3yjqxwp47rviw@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <ed654d0f-6194-ce29-a854-3d9128d81b7a@schaufler-ca.com>
 <20211206120847.ayr3zycigld6rf4j@wittgenstein>
 <36c97ac9821dfc03aa7b370648c8be423979cc5a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36c97ac9821dfc03aa7b370648c8be423979cc5a.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 06, 2021 at 08:38:29AM -0500, James Bottomley wrote:
> On Mon, 2021-12-06 at 13:08 +0100, Christian Brauner wrote:
> > On Fri, Dec 03, 2021 at 11:37:14AM -0800, Casey Schaufler wrote:
> > > On 12/3/2021 10:50 AM, James Bottomley wrote:
> > > > On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
> > > > > On 12/3/21 12:03, James Bottomley wrote:
> > > > > > On Thu, 2021-12-02 at 21:31 -0500, Stefan Berger wrote:
> > > > > > [...]
> > > > > > >    static int securityfs_init_fs_context(struct fs_context
> > > > > > > *fc)
> > > > > > >    {
> > > > > > > +	int rc;
> > > > > > > +
> > > > > > > +	if (fc->user_ns->ima_ns->late_fs_init) {
> > > > > > > +		rc = fc->user_ns->ima_ns->late_fs_init(fc-
> > > > > > > >user_ns);
> > > > > > > +		if (rc)
> > > > > > > +			return rc;
> > > > > > > +	}
> > > > > > >    	fc->ops = &securityfs_context_ops;
> > > > > > >    	return 0;
> > > > > > >    }
> > > > > > I know I suggested this, but to get this to work in general,
> > > > > > it's going to have to not be specific to IMA, so it's going
> > > > > > to have to become something generic like a notifier
> > > > > > chain.  The other problem is it's only working still by
> > > > > > accident:
> > > > >  
> > > > > I had thought about this also but the rationale was:
> > > > > 
> > > > > securityfs is compiled due to CONFIG_IMA_NS and the user
> > > > > namespace exists there and that has a pointer now to
> > > > > ima_namespace, which can have that callback. I assumed that
> > > > > other namespaced subsystems could also be  reached then via
> > > > > such a callback, but I don't know.
> > > >  
> > > > Well securityfs is supposed to exist for LSMs.  At some point
> > > > each of those is going to need to be namespaced, which may
> > > > eventually be quite a pile of callbacks, which is why I thought
> > > > of a notifier.
> > > 
> > > While AppArmor, lockdown and the integrity family use securityfs,
> > > SELinux and Smack do not. They have their own independent
> > > filesystems. Implementations of namespacing for each of SELinux and
> > > Smack have been proposed, but nothing has been adopted. It would be
> > > really handy to namespace the infrastructure rather than each
> > > individual LSM, but I fear that's a bigger project than anyone will
> > > be taking on any time soon. It's likely to encounter many of the
> > > same issues that I've been dealing with for module stacking.
> > 
> > The main thing that bothers me is that it uses simple_pin_fs() and
> > simple_unpin_fs() which I would try hard to get rid of if possible.
> > The existence of this global pinning logic makes namespacing it
> > properly more difficult then it needs to be and it creates imho wonky
> > semantics where the last unmount doesn't really destroy the
> > superblock.
> 
> So in the notifier sketch I posted, I got rid of the pinning but only
> for the non root user namespace use case ... which basically means only
> for converted consumers of securityfs.  The last unmount of securityfs
> inside the namespace now does destroy the superblock ... I checked.

Yeah, I saw. I'm struggling to follow the series but I pulled Stefan's
branch and put your patch on top of it so I peruse it.

> 
> The same isn't true for the last unmount of the root namespace, but
> that has to be so to keep the current semantics.
> 
> >  Instead subsequents mounts resurface the same superblock. There
> > might be an inherent design reason why this needs to be this way but
> > I would advise against these semantics for anything that wants to be
> > namespaced. Probably the first securityfs mount in init_user_ns can
> > follow these semantics but ones tied to a non-initial user namespace
> > should not as the userns can go away. In that case the pinning logic
> > seems strange as conceptually the userns pins the securityfs mount as
> > evidenced by the fact that we key by it in get_tree_keyed().
> 
> Yes, that's basically what I did: pin if ns == &init_user_ns but don't
> pin if not.  However, I'm still not sure I got the triggers right.  We
> have to trigger the notifier call (which adds the namespaced file
> entries) from context free, because that's the first place the
> superblock mount is fully set up ... I can't do it in fill_super
> because the mount isn't fully initialized (and the locking prevents
> it).  I did manage to get the notifier for teardown triggered from
> kill_super, though.

Once Stefan answer my questions about fill_super I _might_ have an idea
how to improve this.
