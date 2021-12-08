Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EECD46D338
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhLHM1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 07:27:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33448 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHM1X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 07:27:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B904B81F37;
        Wed,  8 Dec 2021 12:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F7FC00446;
        Wed,  8 Dec 2021 12:23:43 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:23:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 10/16] ima: Implement hierarchical processing of file
 accesses
Message-ID: <20211208122339.vkqtuckl74ywg3s5@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-11-stefanb@linux.ibm.com>
 <20211208120954.nnawb6d2bpp54yll@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208120954.nnawb6d2bpp54yll@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 08, 2021 at 01:09:54PM +0100, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 03:21:21PM -0500, Stefan Berger wrote:
> > Implement hierarchical processing of file accesses in IMA namespaces by
> > walking the list of IMA namespaces towards the init_ima_ns. This way
> > file accesses can be audited in an IMA namespace and also be evaluated
> > against the IMA policies of parent IMA namespaces.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_main.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2121a831f38a..e9fa46eedd27 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
> >  	ima_check_last_writer(iint, inode, file);
> >  }
> >  
> > -static int process_measurement(struct ima_namespace *ns,
> > -			       struct file *file, const struct cred *cred,
> > -			       u32 secid, char *buf, loff_t size, int mask,
> > -			       enum ima_hooks func)
> > +static int _process_measurement(struct ima_namespace *ns,
> 
> Hm, it's much more common to use double underscores then single
> underscores to
> 
> __process_measurement()
> 
> reads a lot more natural to people perusing kernel code quite often.
> 
> > +				struct file *file, const struct cred *cred,
> > +				u32 secid, char *buf, loff_t size, int mask,
> > +				enum ima_hooks func)
> >  {
> >  	struct inode *inode = file_inode(file);
> >  	struct integrity_iint_cache *iint = NULL;
> > @@ -405,6 +405,27 @@ static int process_measurement(struct ima_namespace *ns,
> >  	return 0;
> >  }
> >  
> > +static int process_measurement(struct ima_namespace *ns,
> > +			       struct file *file, const struct cred *cred,
> > +			       u32 secid, char *buf, loff_t size, int mask,
> > +			       enum ima_hooks func)
> > +{
> > +	int ret = 0;
> > +	struct user_namespace *user_ns;
> > +
> > +	do {
> > +		ret = _process_measurement(ns, file, cred, secid, buf, size, mask, func);
> > +		if (ret)
> > +			break;
> > +		user_ns = ns->user_ns->parent;
> > +		if (!user_ns)
> > +			break;
> > +		ns = user_ns->ima_ns;
> > +	} while (1);
> 
> I'd rather write this as:
> 
> 	struct user_namespace *user_ns = ns->user_ns;
> 
> 	while (user_ns) {
> 		ns = user_ns->ima_ns;
> 
>    		ret = __process_measurement(ns, file, cred, secid, buf, size, mask, func);
>    		if (ret)
>    			break;
> 		user_ns = user_ns->parent;
> 		
> 	}
> 
> because the hierarchy is only an implicit property inherited by ima
> namespaces from the implementation of user namespaces. In other words,
> we're only indirectly walking a hierarchy of ima namespaces because
> we're walking a hierarchy of user namespaces. So the ima ns actually
> just gives us the entrypoint into the userns hierarchy which the double
> deref writing it with a while() makes obvious.

Which brings me to another point.

Technically nothing seems to prevent an ima_ns to survive the
destruction of its associated userns in ima_ns->user_ns?

One thread does get_ima_ns() and mucks around with it while another one
does put_user_ns().

Assume it's the last reference to the userns which is now -
asynchronously - cleaned up from ->work. So at some point you're ending
with a dangling pointer in ima_ns->user_ns eventually causing a UAF.

If I'm thinking correct than you need to fix this. I can think of two
ways right now where one of them I'm not sure how well that would work:
1. ima_ns takes a reference count to userns at creation. Here you need
   to make very sure that you're not ending up with reference counting
   cycles where the two structs keep each other alive.
2. rcu trickery. That's the one I'm not sure how well that would work
   where you'd need rcu_read_lock()/rcu_read_unlock() with a
   get_user_ns() in the middle whenever you're trying to get a ref to
   the userns from an ima_ns and handle the case where the userns is
   gone.

Or maybe I'me missing something in the patch series that makes this all
a non-issue.
