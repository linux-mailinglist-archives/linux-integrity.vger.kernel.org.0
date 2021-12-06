Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133D3469979
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhLFOze (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 09:55:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233659AbhLFOzb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 09:55:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Em9wD009711;
        Mon, 6 Dec 2021 14:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=zWWWtJEsy25mUyiPfXS0RUmmxbNgP/3msh3/02ZVm3I=;
 b=XoYRCPe2hBd1J4nEZGF7h61OVYKBw8QlmvruelC7G9eXX8+/kTxI0RV9HOy0sTopBZUp
 8G2V8e3rl7gbSlIEVwF5AhshxBGWomkjL/+lHRsqVW3GFinIYiSP8pxzJKpWbBEd98WW
 f9WSrGnDD+xs8EEuKe1fQDgJUkqRkYFzcNzIqT2+E3NRyUi6ZHJnB8XXBaYlivCvhIvl
 MFTxCBBFKtTJcwiObsYOntLwry6SQ80y4Lf6ndOipqDidhlaGaDLjdXdARZjtTe8b9sH
 9pOEJsvFBktvIbAj4IN0xMw0z799sNhKTLPMRgIgnqGeFAk3X4r0fK3Qv0kZum831t2r wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csmkjr1db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:51:50 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6En2Ie011266;
        Mon, 6 Dec 2021 14:51:49 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csmkjr1d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:51:49 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6ElkdW005897;
        Mon, 6 Dec 2021 14:51:48 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3cqyy9qba9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:51:48 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6Epktd19923428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 14:51:46 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B972778069;
        Mon,  6 Dec 2021 14:51:46 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57B8578064;
        Mon,  6 Dec 2021 14:51:44 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 14:51:44 +0000 (GMT)
Message-ID: <c1a5bf94c3688465847263031f3016b3296df694.camel@linux.ibm.com>
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
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
Date:   Mon, 06 Dec 2021 09:51:43 -0500
In-Reply-To: <20211206144236.r3pml6bwswmnjlfo@wittgenstein>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
         <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
         <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
         <20211206141108.evjrqsmmgpjp3ias@wittgenstein>
         <5650aa13ef875e70d8a87696c4e871f8a4d574a1.camel@linux.ibm.com>
         <20211206144236.r3pml6bwswmnjlfo@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: syRBhcFCRsS6m3AS-0Gewg_S6rLZG1OU
X-Proofpoint-GUID: kCFJPd36d53vVpZIN9CzreyoEEMo-Tn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-06 at 15:42 +0100, Christian Brauner wrote:
> On Mon, Dec 06, 2021 at 09:21:15AM -0500, James Bottomley wrote:
> > On Mon, 2021-12-06 at 15:11 +0100, Christian Brauner wrote:
> > > On Fri, Dec 03, 2021 at 01:06:13PM -0500, Stefan Berger wrote:
> > > > On 12/3/21 12:03, James Bottomley wrote:
> > [...]
> > > > > > +int ima_fs_ns_init(struct ima_namespace *ns)
> > > > > > +{
> > > > > > +	ns->mount = securityfs_ns_create_mount(ns->user_ns);
> > > > >  
> > > > > This actually triggers on the call to
> > > > > securityfs_init_fs_context,
> > > > > but nothing happens because the callback is null.  Every
> > > > > subsequent use of fscontext will trigger this.  The point of
> > > > > a
> > > > > keyed supeblock is that fill_super is only called once per
> > > > > key,
> > > > > that's the place we should be doing this.   It should also
> > > > > probably be a blocking notifier so any consumer of securityfs
> > > > > can
> > > > > be namespaced by registering for this notifier.
> > > > 
> > > > What I don't like about the fill_super is that it gets called
> > > > too
> > > > early:
> > > > 
> > > > [   67.058611] securityfs_ns_create_mount @ 102 target user_ns:
> > > > ffff95c010698c80; nr_extents: 0
> > > > [   67.059836] securityfs_fill_super @ 47  user_ns:
> > > > ffff95c010698c80;
> > > > nr_extents: 0
> > > > 
> > > > We are switching to the target user namespace in
> > > > securityfs_ns_create_mount.  The expected nr_extents at this
> > > > point
> > > > is 0, since user_ns hasn't been configured, yet. But then
> > > > security_fill_super is also called with nr_extents 0. We cannot
> > > > use
> > > > that, it's too early!
> > > 
> > > So the problem is that someone could mount securityfs before any
> > > idmappings are setup or what?
> > 
> > Yes, not exactly: we put a call to initialize IMA in
> > create_user_ns()
> > but it's too early to have the mappings, so we can't create the
> > securityfs entries in that call.  We need the inode to pick up the
> > root
> > owner from the s_user_ns mappings, so we can't create the dentries
> > for
> > the IMA securityfs entries until those mappings exist.
> > 
> > I'm assuming that by the time someone tries to mount securityfs
> > inside
> > the namespace, the mappings are set up, which is why triggering the
> > notifier to add the files on first mount seems like the best place
> > to
> > put it.
> > 
> > >  How does moving the setup to a later stage help at all? I'm
> > > struggling to make sense of this.
> > 
> > It's not moving all the setup, just the creation of the securityfs
> > entries.
> > 
> > >  When or even if idmappings are written isn't under imas control.
> > > Someone could mount securityfs without any idmappings setup. In
> > > that
> > > case they should get what they deserve, everything owner by
> > > overflowuid/overflowgid, no?
> > 
> > Right, in the current scheme of doing things, if they still haven't
> > written the mappings by the time they do the mount, they're just
> > going
> > to get nobody/nogroup as uid/gid, but that's their own fault.
> > 
> > > Or you can require in fill_super that kuid 0 and kgid 0 are
> > > mapped
> > > and fail if they aren't.
> > 
> > We can't create the securityfs entries in fill_super ... I already
> > tried and the locking just won't allow it.  And if we create them
> > ahead
> 
> What is the locking issue there exactly?

The main problem is we have no vfsmount and we can't create one in
there because the fill super is triggered by the vfsmount creation for
the actual mount.  It's all done under the sb->s_umount semaphore.

> I'm looking at ima_fs_ns_late_init() and there's nothing there that
> would cause obvious issues. You might not be able to use
> securityfs_create_*() in there for some reason but that just means
> you need to add a simple helper. Nearly every filesystem that needs
> to pre-create files does it in fill_super. So I really fail to see
> what the issue is currently. I mist just miss something obvious.

I think we might get it to work if we keep the root dentry in the
securityfs namespace entries instead of the vfsmount; I'll investigate.

James



