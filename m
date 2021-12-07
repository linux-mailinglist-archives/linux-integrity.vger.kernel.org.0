Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C4E46BFA8
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 16:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhLGPoy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 10:44:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16032 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233215AbhLGPoy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 10:44:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7EqVfu018140;
        Tue, 7 Dec 2021 15:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=BIfbpC/D5BpovGMZzHG5tMi7Si+mH45W95CAsHXsAIE=;
 b=NsAhg01CPMdfqXVjcdEK5Shi/7DqjK2pFGDJJ+ygj8e/36e0+/7qyR2jTFYJLoU00oVn
 vjcYaQ4tKGO930Wg2NH22JlWfUghgxTuh0JXu293OGuynwBv1EYHp1uRg/GIZBGth2eN
 mrQui/A1x3YNOxsk0Fz8/yaoKh0skPmAFltRECTPrJkM5AZcW+KiiUNIDaPXKfh79OSR
 fu3p7cQzIJIz+D+g5ItRPdaylWXwwksQdJWoOxUbz3M8y0ATOjLg4rc/rmocjiHvxSLN
 xdtpkhGRJ+UBwdD7q72rPBOTKGmDCglwd5mvnwtxIePgVrWuuBPGmXo19K06TH/XsvN3 Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct9ru14p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:41:01 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7EqYuB018217;
        Tue, 7 Dec 2021 15:41:00 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct9ru14np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:41:00 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FbkR6029200;
        Tue, 7 Dec 2021 15:40:59 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3cqyyaes14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:40:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7Fews433161688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 15:40:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E983D7807A;
        Tue,  7 Dec 2021 15:40:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C99B78064;
        Tue,  7 Dec 2021 15:40:55 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 15:40:55 +0000 (GMT)
Message-ID: <8491f76d5c8923f35216f55c030a68f478a0325a.camel@linux.ibm.com>
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
Date:   Tue, 07 Dec 2021 10:40:54 -0500
In-Reply-To: <10fa531054c3b9e2a02ceb3dc007fa50e1bae1ff.camel@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
         <97ca7651b7ae9a0b6dce4d23c76af266fbd5642f.camel@linux.ibm.com>
         <20211207145901.awiibdgdidbshsbf@wittgenstein>
         <10fa531054c3b9e2a02ceb3dc007fa50e1bae1ff.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Py0io_LEeHoIMiWajJJ2Vwz7yR8xyXGh
X-Proofpoint-GUID: 6lgf8hXoUrGGMka3HjIzIQUByJqlw462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-07 at 10:16 -0500, James Bottomley wrote:
> On Tue, 2021-12-07 at 15:59 +0100, Christian Brauner wrote:
> > On Mon, Dec 06, 2021 at 04:14:15PM -0500, James Bottomley wrote:
[...]
> > >  static int securityfs_fill_super(struct super_block *sb, struct
> > > fs_context *fc)
> > >  {
> > >  	static const struct tree_descr files[] = {{""}};
> > >  	int error;
> > > +	struct user_namespace *ns = fc->user_ns;
> > >  
> > >  	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> > >  	if (error)
> > >  		return error;
> > >  
> > > +	ns->securityfs_root = dget(sb->s_root);
> > > +
> > >  	sb->s_op = &securityfs_super_operations;
> > >  
> > > +	if (ns != &init_user_ns)
> > > +		blocking_notifier_call_chain(&securityfs_ns_notifier,
> > > +					     SECURITYFS_NS_ADD, ns);
> > 
> > I would propose not to use the notifier logic. While it might be
> > nifty it's over-engineered in my opinion.
> 
> The reason for a notifier is that this current patch set only
> namespaces ima, but we also have integrity and evm to do.  Plus, as
> Casey said, we might get apparmour and selinux.  Since each of those
> will also want to add entries in fill_super, the notifier mechanism
> seemed fairly tailor made for this.  The alternative is to have a
> load of 
> 
> #if CONFIG_securityfeature
> callback()
> #endif
> 
> Inside securityfs_fill_super which is a bit inelegant.
> 
> >  The dentry stashing in struct user_namespace currently serves the
> > purpose to make it retrievable in ima_fs_ns_init(). That doesn't
> > justify its existence imho.
> 
> I can thread the root as part of the callback.  I think I can still
> use the standard securityfs calls because the only reason for the
> dentry in the namespace is so the callee can pass NULL and have the
> dentry created at the top level.  We can insist in the namespaced use
> case that the callee always pass in the dentry, even for the top
> level.
> 
> > There is one central place were all users of namespaced securityfs
> > can create the files that they need to and that is in
> > securityfs_fill_super(). (If you want to make that more obvious
> > then give it a subdirectory securityfs and move inode.c in there.)
> 
> Right, that's what the patch does.
> 
> > We simply will expect users to add:
> > 
> > ima_init_securityfs()
> > mylsm_init_securityfs()
> 
> Yes, plus all the #ifdefs because securityfs can exist independently
> of each of the features.  We can hide the ifdefs in the header files
> and make the functions static do nothing if not defined, but the
> ifdeffery has to live somewhere.

Actually, I've got a much better reason: securityfs is a bool; all the
other LSMs and IMA are tristates.  We can't call module init functions
from core code, it has to be done by something like a notifier.

James


