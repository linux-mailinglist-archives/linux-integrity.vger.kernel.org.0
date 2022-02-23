Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5426F4C075F
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 02:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiBWBt4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Feb 2022 20:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBWBt4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Feb 2022 20:49:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2653E3E;
        Tue, 22 Feb 2022 17:49:30 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21N0igvx013877;
        Wed, 23 Feb 2022 01:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iKFpQ9kbhqeLxy4HC18HZD9+9bhlB13TyDv7gJ8L99I=;
 b=GODOdtDrT93RlhyWG7kiXyUIkCAL9vNjG01G/T4V+jLAwIghchepcZfHpDW8LEzK7cXl
 tbiTfFhsLyECnoWqRd3RICuWm0fE5bt3wYVXIZYLLC4Wea1p+FGsDg87CoZ9HEuIyoek
 nVYZUBnISssH3a7Pji4F5outRClNKokKwBfQTL3r8IF73MXMvwiCNz1w/86HEtAfDJtU
 sCzJeqUKxA2ajNgNyBKynE4SperV/y5aVRaL/i37MixusuDV+Z8Ht4kKIc0/s6ufJDad
 2wQHKkhPkhbTW3YnsGjzqFD2A4J+WIblvIYoKQGqIlJZ+ShPnD3rg4BuoZvyZiPTNG5h Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed8gfaw1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 01:48:58 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21N1mwkP008738;
        Wed, 23 Feb 2022 01:48:58 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed8gfaw16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 01:48:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21N1lnRL021504;
        Wed, 23 Feb 2022 01:48:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3eaqtjn85h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 01:48:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21N1mojV38404432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 01:48:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF90EA4054;
        Wed, 23 Feb 2022 01:48:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9166CA405C;
        Wed, 23 Feb 2022 01:48:48 +0000 (GMT)
Received: from sig-9-65-81-84.ibm.com (unknown [9.65.81.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 01:48:48 +0000 (GMT)
Message-ID: <177baf827c4dbf9a225b14552725360066af6471.camel@linux.ibm.com>
Subject: Re: [PATCH v10 22/27] securityfs: Extend securityfs with
 namespacing support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Tue, 22 Feb 2022 20:48:47 -0500
In-Reply-To: <20220201203735.164593-23-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-23-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7V62I64nn7OkWARNIC9G2e67EqS6lT0Q
X-Proofpoint-GUID: y6sEF0FKWWD0DP0ofnsaya5WQhmV79Mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_08,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230004
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> Enable multiple instances of securityfs by keying each instance with a
> pointer to the user namespace it belongs to.
> 
> Since we do not need the pinning of the filesystem for the virtualization

^namespacing case

> case, limit the usage of simple_pin_fs() and simpe_release_fs() to the

^simple_release_fs

> case when the init_user_ns is active. This simplifies the cleanup for the
> virtualization case where usage of securityfs_remove() to free dentries

^namespacing 

> is therefore not needed anymore.
> 
> For the initial securityfs, i.e. the one mounted in the host userns mount,
> nothing changes. The rules for securityfs_remove() are as before and it is
> still paired with securityfs_create(). Specifically, a file created via
> securityfs_create_dentry() in the initial securityfs mount still needs to
> be removed by a call to securityfs_remove(). Creating a new dentry in the
> initial securityfs mount still pins the filesystem like it always did.
> Consequently, the initial securityfs mount is not destroyed on
> umount/shutdown as long as at least one user of it still has dentries that
> it hasn't removed with a call to securityfs_remove().
> 
> Prevent mounting of an instance of securityfs in another user namespace
> than it belongs to. Also, prevent accesses to files and directories by
> a user namespace that is neither the user namespace it belongs to
> nor an ancestor of the user namespace that the instance of securityfs
> belongs to. Do not prevent access if securityfs was bind-mounted and
> therefore the init_user_ns is the owning user namespace.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Christian, I understand that "[PATCH v10 23/27] ima: Setup securityfs
for IMA namespace" needs to be deferred, but is there a reason for
deferring  "[PATCH v10 22/27] securityfs: Extend securityfs with
namespacing support"?   As the securityfs patches are really
independent of IMA namespacing, I would have thought  "[PATCH v10
04/27] securityfs: rework dentry creation" and this patch should be co-
located at the beginning of the patch set.

-- 
thanks,

Mimi

