Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC348AD74
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 13:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiAKMRG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 07:17:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239606AbiAKMRF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 07:17:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BC2Z4s007863;
        Tue, 11 Jan 2022 12:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CXiUk4EYqETtUrjwj55OEO3KLhrpjQ5YmfBgvR7Me1M=;
 b=U1XJQU2HoLk32y0ldKIAc6V1TlqOSeeBfrBi81ZSDGhGNp8Zl6Rgxfk8GsEO58rZss8o
 WPYv8TAOCW2yB+SvmFsX3L/ET3dDb1U8d/M4vcSlt4ZH6paF8ksHet05DH+gKhQMjrdc
 3Yua930xKQbDnqdZ6JLg93eRy/DXaUueRznDmLCcyC7giZKSOghO1PB4MZEfEem910lP
 muZVI5xuy1/ay5NCgK7aFhMJtxzouHj8AvhPz7nqGVnaPd6b/+rMSXMYrJ6iFp2h6M6V
 D6stOtstFFGPQMbJ4u9KzyW2J/V4PRXVTjhadRL3XGU5QO0S3CH158QmFPdL+gZRC1XT yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm05d3eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 12:16:36 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20BCB73O003499;
        Tue, 11 Jan 2022 12:16:35 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm05d3dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 12:16:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BCCYEv006787;
        Tue, 11 Jan 2022 12:16:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3df1vjdk7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 12:16:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BCGUSU33227202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 12:16:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEEBDA4053;
        Tue, 11 Jan 2022 12:16:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A77A4070;
        Tue, 11 Jan 2022 12:16:26 +0000 (GMT)
Received: from sig-9-65-94-95.ibm.com (unknown [9.65.94.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 12:16:26 +0000 (GMT)
Message-ID: <d11458798496f2aed2fb31a7bb077f5938174083.camel@linux.ibm.com>
Subject: Re: [PATCH v8 01/19] securityfs: Extend securityfs with namespacing
 support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Tue, 11 Jan 2022 07:16:26 -0500
In-Reply-To: <20220105101815.ldsm4s5yx7pmuiil@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
         <20220104170416.1923685-2-stefanb@linux.vnet.ibm.com>
         <YdUXU3XIzhxFUfVB@zeniv-ca.linux.org.uk>
         <20220105101815.ldsm4s5yx7pmuiil@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cRSugpHShk13XAUsN-zZ1X8DHuqM-bnm
X-Proofpoint-ORIG-GUID: AuH4e7pJuunftabGYhcnCth7hWbd_yRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-05 at 11:18 +0100, Christian Brauner wrote:
> On Wed, Jan 05, 2022 at 03:58:11AM +0000, Al Viro wrote:
> > On Tue, Jan 04, 2022 at 12:03:58PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com> 

> > > Drop the additional dentry reference to enable simple cleanup of dentries
> > > upon umount. Now the dentries do not need to be explicitly freed anymore
> > > but we can just rely on d_genocide() and the dcache shrinker to do all
> > > the required work.
> 
> The "additional dentry reference" mentioned only relates to an afaict
> unnecessary dget() in securityfs_create_dentry() which I pointed out
> as part of earlier reviews. But the phrasing implies that there's a
> behavioral change for the initial securityfs instance based on the
> removal of this additional dget() when there really isn't.
> 
> After securityfs_create_dentry() has created a new dentry via
> lookup_one_len() and eventually called d_instantiate() it currently
> takes an additional reference on the newly created dentry via dget().
> This additional reference is then paired with an additional dput() in
> securityfs_remove(). I have not yet seen a reason why this is
> necessary maybe you can help there.
> 
> For example, contrast this with debugfs which has the same underlying
> logic as securityfs, i.e. any created dentry pins the whole filesystem
> via simple_pin_fs() until the dentry is released and simple_unpin_fs()
> is called. It uses a similar pairing as securityfs: where securityfs
> has the securityfs_create_dentry() and securityfs_remove() pairing,
> debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
> But debugfs doesn't take an additional reference on the just created
> dentry in __debugfs_create_file() which would need to be put in
> debugfs_remove().
> 
> So if we contrast the creation routines of securityfs and debugfs directly
> condensed to just the dentry references:
> 
> securityfs       |   debugfs
> ---------------- | ------------------
>                  |
> lookup_one_len() |   lookup_one_len()
> d_instantiate()  |   d_instantiate() 
> dget()           |
> 
> And I have not understood why securityfs would need that additional
> dget(). Not just intrinsically but also when contrasted with debugfs. So
> that additional dget() is removed as part of this patch.

Assuming it isn't needed, could removing it be a separate patch and
upstreamed independently of either the securityfs or IMA namespacing
changes?

thanks,

Mimi

> 
> But the explanation in the commit message isn't ideal as it implies
> the removal of the additional dget() would have any impact on the
> pinning logic for securityfs when it does not.
> 
> But the pinning logic doesn't make sense outside of the initial
> namespace which can never go away and there are security modules that
> have files or settings for the whole system that never go away and will
> always keep the filesystem around.
> 
> But for unprivileged/userns containers that mount their own securityfs
> instance we want the securityfs instance cleaned up when it is
> unmounted. There is no need to duplicate the pinning logic or make the
> global securityfs instance display different information based on the
> userns. Both options would be really messy and hacky.
> 
> Instead we can simply give each userns it's own securityfs instance
> similar to how each ipc ns has its own mqueue instance and all entries
> in there are cleaned up on umount or when the whole container is
> shutdown. After the container is shutdown all of the security module
> settings for the container go away with it anyway. So for that we don't
> want any filesystem pinning done in securityfs_create_dentry(). And we
> also really don't want the additional dget() that is currently taken in
> securityfs_create_dentry() as it would pointlessly require us to dput()
> during superblock shutdown afaict. None of this however should cause any
> behavioral changes for the initial securityfs instance.

