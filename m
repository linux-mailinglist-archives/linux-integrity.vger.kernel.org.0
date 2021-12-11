Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54E64714A0
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhLKQFr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 11:05:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231411AbhLKQFq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 11:05:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBERnBF011263;
        Sat, 11 Dec 2021 16:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=t9UwhCucNIuTw4rfnv0gM6PMmJ6i5Z93ILFUAxMPUVE=;
 b=dTk620WfBajRCEQqcLnhTCAJbPQ2vFKU7EJHVv9B0RSW9fpitxAgByypadnDxrBhhUfv
 EYmkWbK4oj2ZqcVEUySzaxhHZC8l6OQw0ydsIK+uomDJoyZYbFnHx8r8EeKTalUQYXjV
 78N8Mz3chlA7CnIuMNp++0ldqPtHaCh1lvB5Xa2JT+ZzlJz5TgoKR8+Bj5UGYAPz/MbI
 12tfqE+zX4geHiiVdjnoUG4I81zcR585LoduqFk7HmY5XdrX884iFp9CrVn1QPProulz
 PMrV8cXYmioOukW8QEgiNdOTvvcu2235CwlaGG1SSJoe+QePkBxFt/Y0h3zyypJ8Kvi+ Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvws78yxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 16:05:19 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BBFrJJt025961;
        Sat, 11 Dec 2021 16:05:18 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvws78yx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 16:05:18 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BBG2C3h017127;
        Sat, 11 Dec 2021 16:05:17 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkm97jes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 16:05:17 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BBG5Gp449021346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 16:05:16 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E670D7805F;
        Sat, 11 Dec 2021 16:05:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBDD37805C;
        Sat, 11 Dec 2021 16:05:11 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.97.102])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 11 Dec 2021 16:05:11 +0000 (GMT)
Message-ID: <95c32800ace37cf3115cf4eefeea4ff65651ee0e.camel@linux.ibm.com>
Subject: Re: [PATCH v6 15/17] ima: Use mac_admin_ns_capable() to check
 corresponding capability
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
Date:   Sat, 11 Dec 2021 11:05:10 -0500
In-Reply-To: <20211211152901.GA25170@mail.hallyn.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-16-stefanb@linux.ibm.com>
         <20211211152901.GA25170@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LvvUvU63hKlUCB1NKh0Aqae_jrJg_P9m
X-Proofpoint-ORIG-GUID: _Hjiq4DWmczMHEL2Vn9CFXI2wZCflIez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_06,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-12-11 at 09:29 -0600, Serge E. Hallyn wrote:
> On Fri, Dec 10, 2021 at 02:47:34PM -0500, Stefan Berger wrote:
> > Use mac_admin_ns_capable() to check corresponding capability to
> > allow
> > read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.
> > 
> > Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  include/linux/capability.h      | 6 ++++++
> >  security/integrity/ima/ima_fs.c | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/capability.h
> > b/include/linux/capability.h
> > index 65efb74c3585..991579178f32 100644
> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > @@ -270,6 +270,12 @@ static inline bool
> > checkpoint_restore_ns_capable(struct user_namespace *ns)
> >  		ns_capable(ns, CAP_SYS_ADMIN);
> >  }
> >  
> > +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
> > +{
> > +	return ns_capable(ns, CAP_MAC_ADMIN) ||
> > +		ns_capable(ns, CAP_SYS_ADMIN);
> > +}
> > +
> >  /* audit system wants to get cap info from files as well */
> >  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
> >  			   const struct dentry *dentry,
> > diff --git a/security/integrity/ima/ima_fs.c
> > b/security/integrity/ima/ima_fs.c
> > index a136d14f29ec..090ee85bfa3a 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -440,7 +440,7 @@ static int ima_open_policy(struct inode *inode,
> > struct file *filp)
> >  #else
> >  		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
> >  			return -EACCES;
> > -		if (!capable(CAP_SYS_ADMIN))
> > +		if (!mac_admin_ns_capable(user_ns))
> 
> Sorry if I'm missing something.  But I'm looking at your tree's
> version of ima_update_policy() and failing to see where it adds
> extra capability checks.  Note that any unprivileged user can
> unshare a user namespace, map its hostuid to nsuid 0, and pass
> ns_capable(CAP_MAC_ADMIN).
> 
> Likewise, a host uid 0 process which does not have CAP_MAC_ADMIN
> can create a new user namespace, map hostuid 0 to nsuid 0, and
> have CAP_MAC_ADMIN against the new userns.
> 
> Somewhere you need to be checking for privilege against either
> the parent ns or the init_user_ns.  I'm not seeing where that's
> being done.  Can you point me to it?

I think you're thinking of my patches, which used a single ima log for
everything.  With Stefan's patches, each namespace gets its own log and
starts out with and empty "do nothing" policy.  However, whatever
policy was active in the parent namespace is still run for activities
in  the child, so any activity the parent requires to be
measured/audited/appraised etc still happens, but all entries are made
in the parent.

James


