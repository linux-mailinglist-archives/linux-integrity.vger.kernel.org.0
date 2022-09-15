Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B995BA18C
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 21:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIOTeM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiIOTd3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF89D8FF;
        Thu, 15 Sep 2022 12:33:16 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FJVErB001204;
        Thu, 15 Sep 2022 19:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=whl2GHMtNnzVs294V7Y+yivlxzZK4XMiEqwPy/cTN9Q=;
 b=EG1Pz18tDb7VvG9tnBIpkV1QOztUO3u+DctNcLNn9dz7CukXebqBQAIFz8fUrxwb/ZxL
 mUxKK3s8Yue3JkCY+zL/GxE2A/I1/fNN/lvTfWRMlUi5yhKDFymlsP40Gvui0ZjMEm6R
 fx+/5eDllNXfZUTeT+R9mDLUeh9hL1MH8Ka6hQq/j/YtTGkHC9bnoPu+AeEMmK2Pr9Ql
 p486AseIPJlFYEBc0iR25qSXBGGoxWUOlcfi0DU0k9/gyGX9pwzKt8t2tpbiO2RAH8hX
 UMROqxpxDX2OC8eoAwNDJi+THb2ZPl1ibfBxmO0/FFx/+1qjeyFnv0zPMc6fOZYFDmI0 Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jma9eg25c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:38 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJVjdB006410;
        Thu, 15 Sep 2022 19:32:37 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jma9eg23x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:37 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJKftU023899;
        Thu, 15 Sep 2022 19:32:36 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3jm9160ddr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWZ013736248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18036AE05C;
        Thu, 15 Sep 2022 19:32:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5CF9AE063;
        Thu, 15 Sep 2022 19:32:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:34 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v14 01/26] securityfs: rework dentry creation
Date:   Thu, 15 Sep 2022 15:31:56 -0400
Message-Id: <20220915193221.1728029-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tE6g5nFDFaXTZuujIDoCO8q_2Z7CVO2r
X-Proofpoint-ORIG-GUID: iUgp-spUYq-jKX2fy8SMbHKTv-fUU6eM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
If we contrast this with debugfs, which has the same underlying logic as
securityfs, it uses a similar pairing as securityfs. Where securityfs
has the securityfs_create_dentry() and securityfs_remove() pairing,
debugfs has the __debugfs_create_file() and debugfs_remove() pairing.

In contrast to securityfs, debugfs doesn't take an additional reference
on the newly created dentry in __debugfs_create_file() which would need
to be put in debugfs_remove().

The additional dget() isn't a problem per se. In the current
implementation of securityfs each created dentry pins the filesystem via
securityfs_create_dentry() until it is removed. Since it is virtually
guaranteed that there is at least one user of securityfs that has created
dentries the initial securityfs mount cannot go away until all dentries
have been removed.

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
Reviewed-by: Serge Hallyn <serge@hallyn.com>

---
v13:
  - Slight improvements in 1st paragraph of commit message
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
2.36.1

