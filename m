Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1842C46BF0E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhLGPU2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 10:20:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234669AbhLGPU0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 10:20:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Dqmhp028670;
        Tue, 7 Dec 2021 15:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=toJAy0OQGL+OaVk5nFYvoGc5J/TnjLww8aKlm8nR5TM=;
 b=WiCPKeywVRskhlXjMrR5G0FyWIZMN5n7uIfjlQLwOpcwPovXXcchxxr/+O1ZXsUT4ZAi
 Lt0x/iRylt93H/P/bMVihFfufZgphgf5HRJK+G/W6t22CPRjPKGID7PfMU7G1YE6Rv+l
 4nnEibxjzZNX46KV6zZFbC0mgsLOTXKV3PENDe0ofD0fvA8kZl8aDMwg9Qg2Zt13TSWM
 lLpvp9oTjHa9Y5t2L3NOW+1KQ1XbwE7tKxGE6EY3yAFnmMH33OO5gmkxr0KTIMNxM4Kz
 6/BfqhBvtGMYlv3ZebzYBNB9AfIW08pmZxFl5VAipvGZWw2wAyW3aAcHge8mdthoq2JA Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct8vshxn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:16:34 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7F5lpS032394;
        Tue, 7 Dec 2021 15:16:33 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct8vshxmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:16:33 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FDogL031341;
        Tue, 7 Dec 2021 15:16:32 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyyauak8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:16:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7FGULQ42729904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 15:16:30 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502F878063;
        Tue,  7 Dec 2021 15:16:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E27D37806E;
        Tue,  7 Dec 2021 15:16:27 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 15:16:27 +0000 (GMT)
Message-ID: <10fa531054c3b9e2a02ceb3dc007fa50e1bae1ff.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/16] ima: Namespace IMA with audit support in IMA-ns
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Tue, 07 Dec 2021 10:16:26 -0500
In-Reply-To: <20211207145901.awiibdgdidbshsbf@wittgenstein>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
         <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
         <20211207145901.awiibdgdidbshsbf@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sU_bG34L_6L6SCdAPUn4zMnfP8liL0sl
X-Proofpoint-ORIG-GUID: c-N7LCYmRle5dcL5ajTaqzmVaj4PmtqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-07 at 15:59 +0100, Christian Brauner wrote:
> On Mon, Dec 06, 2021 at 04:14:15PM -0500, James Bottomley wrote:
> > On Mon, 2021-12-06 at 12:25 -0500, Stefan Berger wrote:
> > [...]
> > > v3:
> > >  - Further modifications to virtualized SecurityFS following
> > > James's posted patch
> > >  - Dropping of early teardown for user_namespaces since not
> > > needed anymore
> > 
> > This is my incremental to this series that moves the namespaced
> > securityfs away from using a vfsmount and on to a root dentry
> > instead, meaning we can call the blocking notifier from fill_super
> > as Christian requested (and thus can remove the
> > securityfs_notifier_sent indicator since it's only called once).
> 
> Somehow b4 retrieves your patch out-of-band which makes it weird to
> reply to so I'm copy-pasting it here and reply inline:
> 
> On Mon, Dec 06, 2021 at 08:27:00PM +0000, James Bottomley wrote:
> > ---
> >  include/linux/user_namespace.h |  3 +-
> >  security/inode.c               | 55 +++++++++++++-----------------
> > ----
> >  2 files changed, 22 insertions(+), 36 deletions(-)
> > 
> > diff --git a/include/linux/user_namespace.h
> > b/include/linux/user_namespace.h
> > index 6b8bd060d8c4..03a0879376a0 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -104,8 +104,7 @@ struct user_namespace {
> >  	struct ima_namespace	*ima_ns;
> >  #endif
> >  #ifdef CONFIG_SECURITYFS
> > -	struct vfsmount		*securityfs_mount;
> > -	bool			securityfs_notifier_sent;
> > +	struct dentry		*securityfs_root;
> >  #endif
> >  } __randomize_layout;
> >  
> > diff --git a/security/inode.c b/security/inode.c
> > index 45211845fc31..f8b6cb3dfb87 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/magic.h>
> >  #include <linux/user_namespace.h>
> >  
> > +static struct vfsmount *securityfs_mount;
> >  static int securityfs_mount_count;
> >  
> >  static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
> > @@ -40,43 +41,24 @@ static const struct super_operations
> > securityfs_super_operations = {
> >  	.free_inode	= securityfs_free_inode,
> >  };
> >  
> > -static struct file_system_type fs_type;
> > -
> > -static void securityfs_free_context(struct fs_context *fc)
> > -{
> > -	struct user_namespace *ns = fc->user_ns;
> > -
> > -	if (ns == &init_user_ns ||
> > -	    ns->securityfs_notifier_sent)
> > -		return;
> > -
> > -	ns->securityfs_notifier_sent = true;
> > -
> > -	ns->securityfs_mount = vfs_kern_mount(&fs_type, SB_KERNMOUNT,
> > -					      fs_type.name, NULL);
> > -	if (IS_ERR(ns->securityfs_mount)) {
> > -		printk(KERN_ERR "kern mount on securityfs ERROR:
> > %ld\n",
> > -		       PTR_ERR(ns->securityfs_mount));
> > -		ns->securityfs_mount = NULL;
> > -		return;
> > -	}
> > -
> > -	blocking_notifier_call_chain(&securityfs_ns_notifier,
> > -				     SECURITYFS_NS_ADD, fc->user_ns);
> > -	mntput(ns->securityfs_mount);
> > -}
> > -
> >  static int securityfs_fill_super(struct super_block *sb, struct
> > fs_context *fc)
> >  {
> >  	static const struct tree_descr files[] = {{""}};
> >  	int error;
> > +	struct user_namespace *ns = fc->user_ns;
> >  
> >  	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> >  	if (error)
> >  		return error;
> >  
> > +	ns->securityfs_root = dget(sb->s_root);
> > +
> >  	sb->s_op = &securityfs_super_operations;
> >  
> > +	if (ns != &init_user_ns)
> > +		blocking_notifier_call_chain(&securityfs_ns_notifier,
> > +					     SECURITYFS_NS_ADD, ns);
> 
> I would propose not to use the notifier logic. While it might be
> nifty it's over-engineered in my opinion.

The reason for a notifier is that this current patch set only
namespaces ima, but we also have integrity and evm to do.  Plus, as
Casey said, we might get apparmour and selinux.  Since each of those
will also want to add entries in fill_super, the notifier mechanism
seemed fairly tailor made for this.  The alternative is to have a load
of 

#if CONFIG_securityfeature
callback()
#endif

Inside securityfs_fill_super which is a bit inelegant.

>  The dentry stashing in struct user_namespace currently serves the
> purpose to make it retrievable in ima_fs_ns_init(). That doesn't
> justify its existence imho.

I can thread the root as part of the callback.  I think I can still use
the standard securityfs calls because the only reason for the dentry in
the namespace is so the callee can pass NULL and have the dentry
created at the top level.  We can insist in the namespaced use case
that the callee always pass in the dentry, even for the top level.

> There is one central place were all users of namespaced securityfs
> can create the files that they need to and that is in
> securityfs_fill_super(). (If you want to make that more obvious then
> give it a subdirectory securityfs and move inode.c in there.)

Right, that's what the patch does.

> We simply will expect users to add:
> 
> ima_init_securityfs()
> mylsm_init_securityfs()

Yes, plus all the #ifdefs because securityfs can exist independently of
each of the features.  We can hide the ifdefs in the header files and
make the functions static do nothing if not defined, but the ifdeffery
has to live somewhere.

> that are to be placed in fill_super
> 
> and
> 
> ima_kill_securityfs()
> mylsm_kill_securityfs()
> 
> that get called in kill_super and the root dentry and other relevant
> information should be passed explicitly into those functions. Then we
> can remove the dentry stashing from struct user_namespace altogether
> and the patch gets smaller too.

Removing dentry stashing can be done independently of removing the
notifier because the dentry can thread through the notifier (or the
callback, of course).

Let me have a look at doing the recoding.

James


