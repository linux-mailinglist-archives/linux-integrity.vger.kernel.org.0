Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB0467D85
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 19:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382714AbhLCSyn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 13:54:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231605AbhLCSyn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 13:54:43 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3IkINr022600;
        Fri, 3 Dec 2021 18:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=CeqDmYVcHZKTTCv8hx7p20HEo4XinK/+V4PT0rTIPQs=;
 b=mP1h5n+oXKrdger+9qxg6m/lwWgWGCUH1KnWZF9cDqJEG4qvDqIT5+uSCa8lPoR31iol
 llVKcv3X95FoQ/YseHGQ9ivsIrUwXh2w/EeWxVMbzaf1VQl4jYCcwtNO12zVaFlIt+fI
 att7NS8H50DHKZDL1QoX1TmdH/Tjdeh/7YqcEF52CQB8oPU7cGumBj8NFjq9aWvmdUwD
 3n7WCZPLhV70Q3XGfd5UVFlxMJeqy4ZrMYkYrJ0x3UNpdEDjY4v15V2eQO0xsR8c7tTo
 ZevP8rS1QNwXQopJKFe2yFI4DOUhwD/eifgrdZPRk7WN7grtr7raLXyQR7mUYie5zoJ9 PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqrte02qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 18:51:02 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B3InxVi002415;
        Fri, 3 Dec 2021 18:51:01 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqrte02qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 18:51:01 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3IkxLW010396;
        Fri, 3 Dec 2021 18:51:01 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3cn5f1xdgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 18:51:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3Ioxe956426974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 18:50:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 369E578064;
        Fri,  3 Dec 2021 18:50:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DB778060;
        Fri,  3 Dec 2021 18:50:50 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 18:50:50 +0000 (GMT)
Message-ID: <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 03 Dec 2021 13:50:49 -0500
In-Reply-To: <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
         <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
         <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vWCj3NGAJe7hWcTddG7p0UD3l0VofSYo
X-Proofpoint-ORIG-GUID: j204tRZAMpl2_A2FaR9kURtBhTuIcMyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
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
> > I know I suggested this, but to get this to work in general, it's
> > going to have to not be specific to IMA, so it's going to have to
> > become something generic like a notifier chain.  The other problem
> > is it's only working still by accident:
> 
> I had thought about this also but the rationale was:
> 
> securityfs is compiled due to CONFIG_IMA_NS and the user namespace 
> exists there and that has a pointer now to ima_namespace, which can
> have that callback. I assumed that other namespaced subsystems could
> also be  reached then via such a callback, but I don't know.

Well securityfs is supposed to exist for LSMs.  At some point each of
those is going to need to be namespaced, which may eventually be quite
a pile of callbacks, which is why I thought of a notifier.

> I suppose any late filesystem init callchain would have to be
> connected to the user_namespace somehow?

I don't think so; I think just moving some securityfs entries into the
user_namespace and managing the notifier chain from within securityfs
will do for now.  [although I'd have to spec this out in code before I
knew for sure].

> > > +int ima_fs_ns_init(struct ima_namespace *ns)
> > > +{
> > > +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
> > This actually triggers on the call to securityfs_init_fs_context,
> > but nothing happens because the callback is null.  Every subsequent
> > use of fscontext will trigger this.  The point of a keyed supeblock
> > is that fill_super is only called once per key, that's the place we
> > should be doing this.   It should also probably be a blocking
> > notifier so anyconsumer of securityfs can be namespaced by
> > registering for this notifier.
> 
> What I don't like about the fill_super is that it gets called too
> early:
> 
> [   67.058611] securityfs_ns_create_mount @ 102 target user_ns: 
> ffff95c010698c80; nr_extents: 0
> [   67.059836] securityfs_fill_super @ 47  user_ns:
> ffff95c010698c80; 
> nr_extents: 0

Right, it's being activated by securityfs_ns_create_mount which is
called as soon as the user_ns is created.

> We are switching to the target user namespace in 
> securityfs_ns_create_mount. The expected nr_extents at this point is
> 0, since user_ns hasn't been configured, yet. But then
> security_fill_super is also called with nr_extents 0. We cannot use
> that, it's too early!

Exactly, so I was thinking of not having a securityfs_ns_create_mount
at all.  All the securityfs_ns_create.. calls would be in the notifier
call chain. This means there's nothing to fill the superblock until an
actual mount on it is called.

> > > +	if (IS_ERR(ns->mount)) {
> > > +		ns->mount = NULL;
> > > +		return -1;
> > > +	}
> > > +	ns->mount_count = 1;
> > This is a bit nasty, too: we're spilling the guts of mount count
> > tracking into IMA instead of encapsulating it inside securityfs.
> 
> Ok, I can make this disappear.
> 
> 
> > > +
> > > +	/* Adjust the trigger for user namespace's early teardown of
> > > dependent
> > > +	 * namespaces. Due to the filesystem there's an additional
> > > reference
> > > +	 * to the user namespace.
> > > +	 */
> > > +	ns->user_ns->refcount_teardown += 1;
> > > +
> > > +	ns->late_fs_init = ima_fs_ns_late_init;
> > > +
> > > +	return 0;
> > > +}
> > I think what should be happening is that we shouldn't so the
> > simple_pin_fs, which creates the inodes, ahead of time; we should
> > do it inside fill_super using a notifier, meaning it gets called
> > once per
> 
> fill_super would only work for the init_user_ns from what I can see.
> 
> 
> > key, creates the root dentry then triggers the notifier which
> > instantiates all the namespaced entries.  We can still use
> > simple_pin_fs for this because there's no locking across
> > fill_super.
> > This would mean fill_super would be called the first time the
> > securityfs is mounted inside the namespace.
> 
> I guess I would need to know how fill_super would work or how it
> could be called late/delayed as well.

So it would be called early in the init_user_ns by non-namespaced
consumers of securityfs, like it is now.

Namespaced consumers wouldn't call any securityfs_ns_create callbacks
to create dentries until they were notified from the fill_super
notifier, which would now only be triggered on first mount of
securityfs inside the namespace.

> > If we do it this way, we can now make securityfs have its own mount
> > and mount_count inside the user namespace, which it uses internally
> > to the securityfs code, thus avoiding exposing them to ima or any
> > other namespaced consumer.
> > 
> > I also think we now don't need the securityfs_ns_ duplicated
> > functions because the callback via the notifier chain now ensures
> > we can usethe namespace they were created in to distinguish between
> > non namespaced and namespaced entries.
> 
> Is there then no need to pass a separate vfsmount * in anymore? 

I don't think so no.  It could be entirely managed internally to
securityfs.

> Where would the vfsmount pointer reside? For now it's in
> ima_namespace, but it sounds like it should be in a more centralized
> place? Should it also be  connected to the user_namespace so we can
> pick it up using get_user_ns()?

exactly.  I think struct user_namespace should have two elements gated
by a #ifdef CONFIG_SECURITYFS which are the vfsmount and the
mount_count for passing into simple_pin_fs.


James


