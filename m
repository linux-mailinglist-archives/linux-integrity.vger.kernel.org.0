Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3642746EB3E
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhLIPed (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 10:34:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19740 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234403AbhLIPec (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 10:34:32 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9F3063011238;
        Thu, 9 Dec 2021 15:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=yqVn+lhNImBksvpnWMd9fbWlmqIWaa4Tvo7Orr2Zfs0=;
 b=CjEJoX2uN9UfnC/rE6GLllx+truwUMK8VE1fYPSiSZWAnzXuZtiuG5xggW0gtbG3fKYc
 anRFfmYlRf/dVKgthhdFrPat9LwXYVzDjpt3Vb0SvONY+gPu+5brAJsNBsHPeucdnBLb
 7KYeOUbUjzGEplgp9CKGVxuTxMOGYl8+KLHzerZ2aXWJkBMHLBJy22D4sBYVE0xA3ZeY
 5RUi258jHG8Ih5YGOOHE9YYcI9HFdr7Foa2XhKrrqWOo5fPcw5BeN0tbfVTArvDyOeTY
 gKGDRx6o4oHbL+K5z9aNFTaminYdLeZ2rPgwEz+2ptNGYb705P6mdRG7Ukredx8x5EkE sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cujwqth2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 15:30:32 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9F4tx2019445;
        Thu, 9 Dec 2021 15:30:31 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cujwqth2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 15:30:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9FCQOM024541;
        Thu, 9 Dec 2021 15:30:30 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3cqyy92x8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 15:30:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9FUTHQ57999660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 15:30:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA3578081;
        Thu,  9 Dec 2021 15:30:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A01EB7806A;
        Thu,  9 Dec 2021 15:30:26 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 15:30:26 +0000 (GMT)
Message-ID: <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Thu, 09 Dec 2021 10:30:25 -0500
In-Reply-To: <20211209143749.wk4agkynfqdzftbl@wittgenstein>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-16-stefanb@linux.ibm.com>
         <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
         <20211209143749.wk4agkynfqdzftbl@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n9lfUq4FyoEkwJvR1lmrx71TH37cVJ05
X-Proofpoint-GUID: 8UFpVoAst13q_Z54f8rGfj5DDtIUiSDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_06,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-09 at 15:37 +0100, Christian Brauner wrote:
> On Thu, Dec 09, 2021 at 03:34:28PM +0100, Christian Brauner wrote:
> > On Wed, Dec 08, 2021 at 05:18:17PM -0500, Stefan Berger wrote:
> > > Move the dentries into the ima_namespace for reuse by virtualized
> > > SecurityFS. Implement function freeing the dentries in order of
> > > files and symlinks before directories.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > 
> > This doesn't work as implemented, I think.
> > 
> > What I would have preferred and what I tried to explain in the
> > earlier review was:
> > Keep the dentry stashing global since it is only needed for
> > init_ima_ns.
> > Then struct ima_namespace becomes way smaller and simpler.
> > If you do that then it makes sense to remove the additional dget()
> > in securityfs_create_dentry() for non-init_ima_ns.
> > Then you can rely on auto-cleanup in .kill_sb() or on
> > ima_securityfs_init() failure and you only need to call
> > ima_fs_ns_free_dentries() if ns != init_ima_ns.
> > 
> > IIuc, it seems you're currently doing one dput() too many since
> > you're calling securityfs_remove() in the error path for non-
> > init_ima_ns which relies on the previous increased dget() which we
> > removed.
> 
> If you really want to move the dentry stashing into struct
> ima_namespace even though it's really unnecessary then you may as
> well not care about the auto-cleanup and keep that additional
> ima_fs_ns_free_dentries(ns) call in .kill_sb(). But I really think
> not dragging dentry stashing into struct ima_namespace is the correct
> way to go about this.

We, unfortunately, do have one case we can't avoid stashing for the
policy file.  It's this code in ima_release_policy:

> #if !defined(CONFIG_IMA_WRITE_POLICY) &&
> !defined(CONFIG_IMA_READ_POLICY)
> 	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
> 	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
> 

What it does is that in certain config options, the policy file entry
gets removed from the securityfs ima directory after you write to it.

James


