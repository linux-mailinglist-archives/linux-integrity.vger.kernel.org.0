Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98F47159F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 20:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhLKTWZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 14:22:25 -0500
Received: from mail.hallyn.com ([178.63.66.53]:57166 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhLKTWZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 14:22:25 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 6D94C6B4; Sat, 11 Dec 2021 13:22:22 -0600 (CST)
Date:   Sat, 11 Dec 2021 13:22:22 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Subject: Re: [PATCH v6 15/17] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Message-ID: <20211211192222.GA27092@mail.hallyn.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-16-stefanb@linux.ibm.com>
 <20211211152901.GA25170@mail.hallyn.com>
 <95c32800ace37cf3115cf4eefeea4ff65651ee0e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c32800ace37cf3115cf4eefeea4ff65651ee0e.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 11, 2021 at 11:05:10AM -0500, James Bottomley wrote:
> On Sat, 2021-12-11 at 09:29 -0600, Serge E. Hallyn wrote:
> > On Fri, Dec 10, 2021 at 02:47:34PM -0500, Stefan Berger wrote:
> > > Use mac_admin_ns_capable() to check corresponding capability to
> > > allow
> > > read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.
> > > 
> > > Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >  include/linux/capability.h      | 6 ++++++
> > >  security/integrity/ima/ima_fs.c | 2 +-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/capability.h
> > > b/include/linux/capability.h
> > > index 65efb74c3585..991579178f32 100644
> > > --- a/include/linux/capability.h
> > > +++ b/include/linux/capability.h
> > > @@ -270,6 +270,12 @@ static inline bool
> > > checkpoint_restore_ns_capable(struct user_namespace *ns)
> > >  		ns_capable(ns, CAP_SYS_ADMIN);
> > >  }
> > >  
> > > +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
> > > +{
> > > +	return ns_capable(ns, CAP_MAC_ADMIN) ||
> > > +		ns_capable(ns, CAP_SYS_ADMIN);
> > > +}
> > > +
> > >  /* audit system wants to get cap info from files as well */
> > >  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
> > >  			   const struct dentry *dentry,
> > > diff --git a/security/integrity/ima/ima_fs.c
> > > b/security/integrity/ima/ima_fs.c
> > > index a136d14f29ec..090ee85bfa3a 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -440,7 +440,7 @@ static int ima_open_policy(struct inode *inode,
> > > struct file *filp)
> > >  #else
> > >  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
> > >  			return -EACCES;
> > > -		if (!capable(CAP_SYS_ADMIN))
> > > +		if (!mac_admin_ns_capable(user_ns))
> > 
> > Sorry if I'm missing something.  But I'm looking at your tree's
> > version of ima_update_policy() and failing to see where it adds
> > extra capability checks.  Note that any unprivileged user can
> > unshare a user namespace, map its hostuid to nsuid 0, and pass
> > ns_capable(CAP_MAC_ADMIN).
> > 
> > Likewise, a host uid 0 process which does not have CAP_MAC_ADMIN
> > can create a new user namespace, map hostuid 0 to nsuid 0, and
> > have CAP_MAC_ADMIN against the new userns.
> > 
> > Somewhere you need to be checking for privilege against either
> > the parent ns or the init_user_ns.  I'm not seeing where that's
> > being done.  Can you point me to it?
> 
> I think you're thinking of my patches, which used a single ima log for
> everything.  With Stefan's patches, each namespace gets its own log and
> starts out with and empty "do nothing" policy.  However, whatever
> policy was active in the parent namespace is still run for activities
> in  the child, so any activity the parent requires to be
> measured/audited/appraised etc still happens, but all entries are made
> in the parent.

Oh.  Stefan had previously said that one motivation was to do less logging
in the hostns, so I assumed that a child ns policy could make it so the
parent ns policy was no longer applied.  If that's not the case, and not
planned, then that makes this a lot simpler.
