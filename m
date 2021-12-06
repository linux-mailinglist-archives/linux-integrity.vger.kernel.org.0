Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711F6469828
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 15:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbhLFOO4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 09:14:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245733AbhLFOOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 09:14:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DLMnm003567;
        Mon, 6 Dec 2021 14:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=1QPaJrlwtQeqIPOHIzh0iXT8hAIyKucPE904SYtCY20=;
 b=ZbBSSQTO89BJAPDSMnYDLgYtiSfcKR1a9zpQXCe6GXPMHjxXcnadP2XXHTjX/KLtNCUN
 EcjgsKlwsCI+6e1+C1smT57JN0bHWcmadVx7sHWO8Pdc1SHNq62IyzVp/rNwuu5tFe1i
 G120rdGlrA+TkjyNRUlip+2LFT8NvhNI4/lJNM03Pgq6WeQCv2MulXGA+dHwUjUqEJbj
 RUapUT63cmRL6QKh80Uw5ipILLoP9+cUmbLr7UHyoJbD0QWuK2u4g/5y7v7JhrUN/vxa
 Ey4mGQFDSzvykrJYDxiPtJzP9AY6n3qqgb+ko2Sf1o7eCG9RGdFfSirPh+bkh1aGh6Kr 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cskb391an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:11:13 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6DLU8j003734;
        Mon, 6 Dec 2021 14:11:12 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cskb391a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:11:12 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6E7icp009425;
        Mon, 6 Dec 2021 14:11:11 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 3cqyy9ph2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 14:11:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6EBAUg23920918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 14:11:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5E5978064;
        Mon,  6 Dec 2021 14:11:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E4DD78074;
        Mon,  6 Dec 2021 14:11:07 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 14:11:07 +0000 (GMT)
Message-ID: <915b3be92544f6572f214f360a592708f46ad7e6.camel@linux.ibm.com>
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
Date:   Mon, 06 Dec 2021 09:11:06 -0500
In-Reply-To: <e4134d4f-5134-ade8-6428-3510ac940757@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
         <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
         <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
         <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
         <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
         <084e6522e1e778408cf6b3581d75f7349d336006.camel@linux.ibm.com>
         <e4134d4f-5134-ade8-6428-3510ac940757@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uc4g4o-19uwJGt1phd7bCFDu49jwUHIE
X-Proofpoint-GUID: JSLGpoRReW_oyHmf8nqTBIKPlcvGVgsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-06 at 09:03 -0500, Stefan Berger wrote:
> On 12/5/21 23:27, James Bottomley wrote:
> > On Fri, 2021-12-03 at 14:11 -0500, Stefan Berger wrote:
> > > On 12/3/21 13:50, James Bottomley wrote:
> > > > On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
> > [...]
> > > > > I suppose any late filesystem init callchain would have to be
> > > > > connected to the user_namespace somehow?
> > > >   
> > > > I don't think so; I think just moving some securityfs entries
> > > > into
> > > > the user_namespace and managing the notifier chain from within
> > > > securityfs will do for now.  [although I'd have to spec this
> > > > out in
> > > > code before I knew for sure].
> > > It doesn't have to be right in the user_namespace. The IMA
> > > namespace
> > > is  connected to the user namespace and holds the dentries now...
> > > 
> > > Please spec it out...
> > OK, this is what I have.  fill_super turned out to be a locking
> > nightmare, so I triggered it from free context instead (which
> > doesn't
> > have the once per keyed superblock property, so I added a flag in
> > the
> > user namespace).  I've got it to the point where the event is
> > triggered
> > on mount and unmount, so all the entries for the namespace are
> > added
> > when the filesystem is mounted and remove when it's
> > unmounted.  This
> > style of addition no longer needs the simple_pin_fs, because the
> > add/remove callbacks substitute (plus, if we pinned, the free_super
> > wouldn't trigger on unmount).  The default behaviour still does
> > pinning
> > and unpinning, but that can be keyed off the current
> > user_namespace.
> > 
> > This is all on top of your current series ... some of the functions
> > should probably be renamed, but I kept them to show how the code
> > was
> > migrating in this sketch.
> > 
> > James
> > 
> > ---
> > 
> >  From 59c45daa8698c66c3bcebfb194123977d548a9a6 Mon Sep 17 00:00:00
> > 2001
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date: Sat, 4 Dec 2021 16:38:37 +0000
> > Subject: [PATCH] rework securityfs
> > 
> > ---
> > 
> > -
> > -static void _securityfs_remove(struct dentry *dentry,
> > -			       struct vfsmount **mount, int
> > *mount_count)
> > +void securityfs_remove(struct dentry *dentry)
> >   {
> >   	struct inode *dir;
> > +	struct user_namespace *ns = current_user_ns();
> 
> I had problems with this in this place. So I had to use use
> 
> struct user_namespace *user_ns = dentry->d_sb->s_user_ns;

Yes, I think that works ... the owner in the parent namespace could
actually unmount it, so keying off the user namespace it was mounted on
is definitely the correct form.

> I'll try to split up your patch and post a v3 with then. Or is it too
> early?

It's never too early to see what the series is shaping up as.  However,
I'm still not sure I got the right trigger for the SECURITYFS_NS_ADD
notifier, so that may still have to move ... or even that there isn't
some locking subtlety I missed in triggering SECURITY_NS_REMOVE from
kill_sb.

I also suspect Christian will want a pointer to the securityfs pieces
in struct user_namespace rather than discrete elements added directly.

James




