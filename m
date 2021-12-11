Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80CA47160F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 21:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhLKUNf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 15:13:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhLKUNd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 15:13:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBJwdoD015240;
        Sat, 11 Dec 2021 20:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=g/Bx+RifImwnrt8Fv6tk5ozdgiei2ykWeAUpvcL4+aw=;
 b=N0PF6c7yh8AbTVKS5lyUnFVy9KtzjVIcKuFAXHT+H9RAHF7Juwa3NjGIgB/yFuv4B7wc
 qwQiFQwMRiFcNuDgHL8jmE4vHFIToA7DDT0EweUmnSw+hTclE3cxb3O1FTBYarmJWVFV
 ItuA+VANXNpS8o7UvVSW5nbj16j40YTTKE/3NBmWEOF4bAPugYFI7Z6YFQEyX9HnxY9D
 xatti3MIxMpb8orD6lGbMc7tvck2mwmfZ810bSzdTVkW8sugqGteO0JDWUw9calzTeNE
 exwRSv143B0TLPM5QwK8s23/YP7QFCZmz7V/jztkWQCw3zBx7kTSsM/D2/hH7Tyil4gk GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw2m784v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 20:13:07 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BBKCEkg019324;
        Sat, 11 Dec 2021 20:13:06 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw2m784uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 20:13:06 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BBK6fFg014554;
        Sat, 11 Dec 2021 20:13:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3cvkm8sscx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 20:13:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BBKD31412321468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 20:13:03 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A724C7805C;
        Sat, 11 Dec 2021 20:13:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5721978060;
        Sat, 11 Dec 2021 20:12:59 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.97.102])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 11 Dec 2021 20:12:59 +0000 (GMT)
Message-ID: <15de0c8d4521aa7ab15ab34f642fd5b860b9b59f.camel@linux.ibm.com>
Subject: Re: [PATCH v6 15/17] ima: Use mac_admin_ns_capable() to check
 corresponding capability
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Date:   Sat, 11 Dec 2021 15:12:57 -0500
In-Reply-To: <20211211192222.GA27092@mail.hallyn.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-16-stefanb@linux.ibm.com>
         <20211211152901.GA25170@mail.hallyn.com>
         <95c32800ace37cf3115cf4eefeea4ff65651ee0e.camel@linux.ibm.com>
         <20211211192222.GA27092@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6IlV-pxVYrFLgl40ca1cXCS5tGnL8V5h
X-Proofpoint-ORIG-GUID: aw22wbCd0r5M2dKGk9G2YkC7qVrdVjno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_09,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-12-11 at 13:22 -0600, Serge E. Hallyn wrote:
> On Sat, Dec 11, 2021 at 11:05:10AM -0500, James Bottomley wrote:
> > On Sat, 2021-12-11 at 09:29 -0600, Serge E. Hallyn wrote:
> > > On Fri, Dec 10, 2021 at 02:47:34PM -0500, Stefan Berger wrote:
> > > > Use mac_admin_ns_capable() to check corresponding capability to
> > > > allow
> > > > read/write IMA policy without CAP_SYS_ADMIN but with
> > > > CAP_MAC_ADMIN.
> > > > 
> > > > Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > ---
> > > >  include/linux/capability.h      | 6 ++++++
> > > >  security/integrity/ima/ima_fs.c | 2 +-
> > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/capability.h
> > > > b/include/linux/capability.h
> > > > index 65efb74c3585..991579178f32 100644
> > > > --- a/include/linux/capability.h
> > > > +++ b/include/linux/capability.h
> > > > @@ -270,6 +270,12 @@ static inline bool
> > > > checkpoint_restore_ns_capable(struct user_namespace *ns)
> > > >  		ns_capable(ns, CAP_SYS_ADMIN);
> > > >  }
> > > >  
> > > > +static inline bool mac_admin_ns_capable(struct user_namespace
> > > > *ns)
> > > > +{
> > > > +	return ns_capable(ns, CAP_MAC_ADMIN) ||
> > > > +		ns_capable(ns, CAP_SYS_ADMIN);
> > > > +}
> > > > +
> > > >  /* audit system wants to get cap info from files as well */
> > > >  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
> > > >  			   const struct dentry *dentry,
> > > > diff --git a/security/integrity/ima/ima_fs.c
> > > > b/security/integrity/ima/ima_fs.c
> > > > index a136d14f29ec..090ee85bfa3a 100644
> > > > --- a/security/integrity/ima/ima_fs.c
> > > > +++ b/security/integrity/ima/ima_fs.c
> > > > @@ -440,7 +440,7 @@ static int ima_open_policy(struct inode
> > > > *inode,
> > > > struct file *filp)
> > > >  #else
> > > >  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
> > > >  			return -EACCES;
> > > > -		if (!capable(CAP_SYS_ADMIN))
> > > > +		if (!mac_admin_ns_capable(user_ns))
> > > 
> > > Sorry if I'm missing something.  But I'm looking at your tree's
> > > version of ima_update_policy() and failing to see where it adds
> > > extra capability checks.  Note that any unprivileged user can
> > > unshare a user namespace, map its hostuid to nsuid 0, and pass
> > > ns_capable(CAP_MAC_ADMIN).
> > > 
> > > Likewise, a host uid 0 process which does not have CAP_MAC_ADMIN
> > > can create a new user namespace, map hostuid 0 to nsuid 0, and
> > > have CAP_MAC_ADMIN against the new userns.
> > > 
> > > Somewhere you need to be checking for privilege against either
> > > the parent ns or the init_user_ns.  I'm not seeing where that's
> > > being done.  Can you point me to it?
> > 
> > I think you're thinking of my patches, which used a single ima log
> > for everything.  With Stefan's patches, each namespace gets its own
> > log and starts out with and empty "do nothing" policy.  However,
> > whatever policy was active in the parent namespace is still run for
> > activities in  the child, so any activity the parent requires to be
> > measured/audited/appraised etc still happens, but all entries are
> > made in the parent.
> 
> Oh.  Stefan had previously said that one motivation was to do less
> logging in the hostns, so I assumed that a child ns policy could make
> it so the parent ns policy was no longer applied.

Well, the default policy even for the init_user_ns is don't log
anything, so you can keep that if you don't care.  However, if you do
care you can log all the containers.  If the containers install a
logging policy, that log will disappear when the namespace is reaped,
so if the hostns has a no log policy, all the log space the child used
will be freed.

James


>   If that's not the case, and not planned, then that makes this a lot
> simpler.
> 


