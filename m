Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E54CA687
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiCBNvp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbiCBNv3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C61BC5DAB;
        Wed,  2 Mar 2022 05:50:33 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222BSfua031088;
        Wed, 2 Mar 2022 13:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cUJtAy4PX1MvoaW5WNjcTOGS64qH4Yh6n8vvHnHPMnE=;
 b=Jx8HcJZzuw2LkWn2v9LqATQaSyQIqjoBEF2LnjJlSbtKNA99TLcuxfTWvBiIbwqxmE7S
 NqrWx39JEIsoo8TCwAYDaLVvlHIXBGmgIDU5UXMv6UlrWYcq8DXdPsc792jzhwPUPkr9
 tGZHrUt968ZqigIUhqfXURcsji0v+TWd+dH8n9DRFFz4LJmcYdByV6mjNLxQcE0N36Op
 jci9VWlgAVPszEZhWA3oRm8ZUyrB8Q2Tsb8cCMStDFiTHDuu5V3rk+N8qXOhnrvB884B
 RNJRgHcAO6Nw6+LQozCKHrV+NTpGcZLd7bd9VurrLTHQQd0G9xnvP9TlRM8SjDkDGfSN eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej5ccf5ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DarBv036610;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej5ccf5wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:49:59 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222Dn40K026692;
        Wed, 2 Mar 2022 13:49:58 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3egfsscpng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:49:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222DnvOu34537746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2506811206B;
        Wed,  2 Mar 2022 13:49:57 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05B6F112070;
        Wed,  2 Mar 2022 13:49:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:56 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v11 02/27] securityfs: rework dentry creation
Date:   Wed,  2 Mar 2022 08:46:37 -0500
Message-Id: <20220302134703.1273041-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7iHcLZnClTqAWEiwtj0xPtzpQCLZumEL
X-Proofpoint-GUID: nsPHtg-QajQ9hhoSY61B64-fLdXhOpSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

When securityfs creates a new file or directory via
securityfs_create_dentry() it will take an additional reference on the
newly created dentry after it has attached the new inode to the new
dentry and added it to the hashqueues.
If we contrast this with debugfs which has the same underlying logic as
securityfs. It uses a similar pairing as securityfs. Where securityfs
has the securityfs_create_dentry() and securityfs_remove() pairing,
debugfs has the __debugfs_create_file() and debugfs_remove() pairing.

In contrast to securityfs, debugfs doesn't take an additional reference
on the newly created dentry in __debugfs_create_file() which would need
to be put in debugfs_remove().

The additional dget() isn't a problem per se. In the current
implementation of securityfs each created dentry pins the filesystem via
until it is removed. Since it is virtually guaranteed that there is at
least one user of securityfs that has created dentries the initial
securityfs mount cannot go away until all dentries have been removed.

Since most of the users of the initial securityfs mount don't go away
until the system is shutdown the initial securityfs won't go away when
unmounted. Instead a mount will usually surface the same superblock as
before. The additional dget() doesn't matter in this scenario since it
is required that all dentries have been cleaned up by the respective
users before the superblock can be destroyed, i.e. superblock shutdown
is tied to the lifetime of the associated dentries.

However, in order to support ima namespaces we need to extend securityfs
to support being mounted outside of the initial user namespace. For
namespaced users the pinning logic doesn't make sense. Whereas in the
initial namespace the securityfs instance and the associated data
structures of its users can't go away for reason explained earlier users
of non-initial securityfs instances do go away when the last users of
the namespace are gone.

So for those users we neither want to duplicate the pinning logic nor
make the global securityfs instance display different information based
on the namespace. Both options would be really messy and hacky.

Instead we will simply give each namespace its own securityfs instance
similar to how each ipc namespace has its own mqueue instance and all
entries in there are cleaned up on umount or when the last user of the
associated namespace is gone.

This means that the superblock's lifetime isn't tied to the dentries.
Instead the last umount, without any fds kept open, will trigger a clean
shutdown. But now the additional dget() gets in the way. Instead of
being able to rely on the generic superblock shutdown logic we would
need to drop the additional dentry reference during superblock shutdown
for all associated users. That would force the use of a generic
coordination mechanism for current and future users of securityfs which
is unnecessary. Simply remove the additional dget() in
securityfs_dentry_create().

In securityfs_remove() we will call dget() to take an additional
reference on the dentry about to be removed. After simple_unlink() or
simple_rmdir() have dropped the dentry refcount we can call d_delete()
which will either turn the dentry into negative dentry if our earlier
dget() is the only reference to the dentry, i.e. it has no other users,
or remove it from the hashqueues in case there are additional users.

All of these changes should not have any effect on the userspace
semantics of the initial securityfs mount.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Micah Morton <mortonm@chromium.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..13e6780c4444 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -302,10 +301,12 @@ void securityfs_remove(struct dentry *dentry)
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
+		dget(dentry);
 		if (d_is_dir(dentry))
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.31.1

