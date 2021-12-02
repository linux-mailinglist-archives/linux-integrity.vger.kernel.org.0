Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B48466434
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 14:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhLBNEp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 08:04:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39970 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhLBNEp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 08:04:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 36D44CE22BD;
        Thu,  2 Dec 2021 13:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4157FC00446;
        Thu,  2 Dec 2021 13:01:14 +0000 (UTC)
Date:   Thu, 2 Dec 2021 14:01:10 +0100
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
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [RFC 17/20] ima: Use integrity_admin_ns_capable() to check
 corresponding capability
Message-ID: <20211202130110.ij5h3o6mcbqscjqh@wittgenstein>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
 <20211130160654.1418231-18-stefanb@linux.ibm.com>
 <7c751783b28766412f158e5ca074748ed18070bd.camel@linux.ibm.com>
 <34085058-ff5f-c28e-c716-6f4fa71747a3@linux.ibm.com>
 <4b12309289c6a51991c5062fed0fde03e0a6f703.camel@linux.ibm.com>
 <20211202125955.qcmmnblit3nmatdo@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202125955.qcmmnblit3nmatdo@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 02, 2021 at 01:59:55PM +0100, Christian Brauner wrote:
> On Wed, Dec 01, 2021 at 02:29:09PM -0500, James Bottomley wrote:
> > On Wed, 2021-12-01 at 12:35 -0500, Stefan Berger wrote:
> > > On 12/1/21 11:58, James Bottomley wrote:
> > > > On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
> > > > > From: Denis Semakin <denis.semakin@huawei.com>
> > > > > 
> > > > > Use integrity_admin_ns_capable() to check corresponding
> > > > > capability to allow read/write IMA policy without CAP_SYS_ADMIN
> > > > > but with CAP_INTEGRITY_ADMIN.
> > > > > 
> > > > > Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> > > > > ---
> > > > >   security/integrity/ima/ima_fs.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/security/integrity/ima/ima_fs.c
> > > > > b/security/integrity/ima/ima_fs.c
> > > > > index fd2798f2d224..6766bb8262f2 100644
> > > > > --- a/security/integrity/ima/ima_fs.c
> > > > > +++ b/security/integrity/ima/ima_fs.c
> > > > > @@ -393,7 +393,7 @@ static int ima_open_policy(struct inode
> > > > > *inode,
> > > > > struct file *filp)
> > > > >   #else
> > > > >   		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
> > > > >   			return -EACCES;
> > > > > -		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
> > > > > +		if (!integrity_admin_ns_capable(ns->user_ns))
> > > > so this one is basically replacing what you did in RFC 16/20, which
> > > > seems a little redundant.
> > > > 
> > > > The question I'd like to ask is: is there still a reason for
> > > > needing CAP_INTEGRITY_ADMIN?  My thinking is that now IMA is pretty
> > > > much tied to requiring a user (and a mount, because of
> > > > securityfs_ns) namespace, there might not be a pressing need for an
> > > > admin capability separated from CAP_SYS_ADMIN because the owner of
> > > > the user namespace passes the ns_capable(..., CAP_SYS_ADMIN)
> > > > check.  The rationale in
> > > 
> > > Casey suggested using CAP_MAC_ADMIN, which I think would also work.
> > > 
> > >      CAP_MAC_ADMIN (since Linux 2.6.25)
> > >                Allow MAC configuration or state changes. Implemented
> > > for
> > >                the Smack Linux Security Module (LSM).
> > > 
> > > 
> > > Down the road I think we should cover setting file extended
> > > attributes with the same capability as well for when a user signs
> > > files or installs packages with file signatures.  A container runtime
> > > could hold CAP_SYS_ADMIN while setting up a container and mounting
> > > filesystems and drop it for the first process started there. Since we
> > > are using the user namespace to spawn an IMA namespace, we would then
> > > require CAP_SYSTEM_ADMIN to be left available so that the user can do
> > > IMA related stuff in the container (set or append to the policy,
> > > write file signatures). I am not sure whether that should be the case
> > > or rather give the user something finer grained, such as
> > > CAP_MAC_ADMIN. So, it's about granularity...
> > 
> > It's possible ... any orchestration system that doesn't enter a user
> > namespace has to strictly regulate capabilities.   I'm probably biased
> > because I always use a user_ns so I never really had to mess with
> > capabilities.
> > 
> > > > https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
> > > > 
> > > > Is effectively "because CAP_SYS_ADMIN is too powerful" but that's
> > > > no longer true of the user namespace owner.  It only passes the
> > > > ns_capable() check not the capable() one, so while it does get
> > > > CAP_SYS_ADMIN, it can only use it in a few situations which
> > > > represent quite a power reduction already.
> > > 
> > > At least docker containers drop CAP_SYS_ADMIN.
> > 
> > Well docker doesn't use the user_ns.  But even given that,
> > CAP_SYS_ADMIN is always dropped for most container systems.  What
> > happens when you enter a user namespace is the ns_capable( ...,
> > CAP_SYS_ADMIN) check returns true if you're the owner of the user_ns,
> > in the same way it would for root.  So effectively entering a user
> > namespace without CAP_SYS_ADMIN but mapping the owner id to 0 (what
> > unshare -r --user does) gives you back a form of CAP_SYS_ADMIN that
> > responds only in the places in the kernel that have a ns_capable()
> > check instead of a capable() one (most of the places you list below). 
> > This is the principle of how unprivileged containers actually work ...
> > and the source of some of our security problems if you get back an
> > ability to do something you shouldn't be allowed to do as an
> > unprivileged user.
> > 
> > >  I am not sure what the decision was based on but probably they don't
> > > want to give the user what is not absolutely necessary, but usage of
> > > user namespaces (with IMA namespaces) would kind of force it to be
> > > available then to do IMA-related stuff ...
> > > 
> > > Following this man page here 
> > > https://man7.org/linux/man-pages/man7/user_namespaces.7.html
> > > 
> > > CAP_SYS_ADMIN in a user namespace is about
> > > 
> > > - bind-mounting filesystems
> > > 
> > > - mounting /proc filesystems
> > > 
> > > - creating nested user namespaces
> > > 
> > > - configuring UTS namespace
> > > 
> > > - configuring whether setgroups() can be used
> > > 
> > > - usage of setns()
> > > 
> > > 
> > > Do we want to add '- only way of *setting up* IMA related stuff' to
> > > this list?
> > 
> > I don't see why not, but other container people should weigh in
> > because, as I said, I mostly use the user namespace and unprivileged
> > containers and don't bother with capabilities.
> 
> There are very few scenarios where dropping capabilities in an
> unprivileged container makes sense. In a lot of other scenarios it is
> just a misunderstanding of the meaning of capabilities and their
> relationship to user namespaces. Usually, granting a full set of
> capabilities to the payload of an unprivigileged container is the right
> thing to do. All things that are properly namespaced will check
> capabilities in the relevant user namespace. Those that aren't will
> check them against the initial user namespaces.
> 
> But I do think the question of whether or not ima should go into
> cap_sys_admin is more a question of capability semantics then it is in
> how exactly ima is namespaced. We do have agreed before that overloading
> cap_sys_admin further isn't ideal. Often we end up rectifying that
> mistake later. For example, how we moved stuff like criu, bpf, and perf
> to their own capability. Now we're left with stuff like:
> 
> static inline bool perfmon_capable(void)
> {
> 	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> }
> 
> static inline bool bpf_capable(void)
> {
> 	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
> }
> 
> static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
> {
> 	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
> 		ns_capable(ns, CAP_SYS_ADMIN);
> }
> 
> for the sake of adhering to legacy behavior. I think we can skip over
> that mistake and introduce cap_sys_integrity.

(Or under CAP_MAC_ADMIN as suggested elsewhere in the thread as I saw
just now.)
