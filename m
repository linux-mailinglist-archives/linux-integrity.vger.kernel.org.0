Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E53649B6
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbhDSSTj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 14:19:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240833AbhDSSTh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 14:19:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JI389x035353;
        Mon, 19 Apr 2021 14:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=WOCU0v2Lu57O0GygzD6lMGDf/Be48O4MFk0JkmNA+yE=;
 b=doTVfzWrPi/CtJdv8IYZRu0iS51onFTWUMgKSCv+mDmDIuxkhrzdd5m2XJxSBQPVaZIc
 RWpKnWmy15beFyhtUyAzKQCyjfZyXGdaPlk2d55BuDudfBcnQfYLpd4vrUq87Nc0mdai
 Q0T3dZYmJS2kjk76OdE3R2rgUMNEhYsja8qGQeIzib9fRoSIBT1Dv8BbNOSqR4U3bjns
 4FEX5UAWJ5qQK3/2DGvAgfDW+JtyacYxXMeSr7WyY0UYEUwEUCzQTkJggrC1HnEqWsgL
 5kSIhQa/wjd/x7DX1VVVg2ikdtW6Ic4AsJlFBkYfJckJRkFiXdgzqp2WZFoOzfCbIZCd Lg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 380d7dsuub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 14:19:05 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JI7fH5026138;
        Mon, 19 Apr 2021 18:19:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 37yqa88p4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 18:19:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JIJ0Tu58065302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 18:19:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C24E242054;
        Mon, 19 Apr 2021 18:19:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34AA742042;
        Mon, 19 Apr 2021 18:18:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.211.122.203])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 18:18:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: [RFC PATCH] integrity: fix null ptr dereference in integrity_inode_free()
Date:   Mon, 19 Apr 2021 14:18:50 -0400
Message-Id: <20210419181850.885349-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Imfql3XVQtZw4maZDDPUQhG93XocMYDK
X-Proofpoint-GUID: Imfql3XVQtZw4maZDDPUQhG93XocMYDK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

__destroy_inode() -> security_inode_free() should only be called once to
free an inode.  With the provided ecryptfs test.sh script the same inode
is freed twice.

With some debugging info and dump_stack():
[  417.586522][T13423] integrity_inode_get: pid=13423 ppid=13404 ino:7221545
	count: 1 write:0 read:1
[  417.724446][T13428] integrity_inode_get: pid=13428 ppid=13404 ino:7221545
	count: 2 write:0 read:1
[  417.796269][T13430] integrity_inode_free: pid=13430 ppid=13404 ino:7221545
	count: 0 write:0 read:0
[  417.799101][T13430] integrity_inode_free: pid=13430 ppid=13404 ino:7221545
	count: 0 write:0 read:0

But only when executing both the provided ecryptfs test.sh and test2.sh
scripts, causes the null pointer dereferencing.

[  420.896059][T13532] integrity_inode_get: pid=13532 ppid=13514 ino:7604534
	count: 1 write:0 read:1
[  421.020910][T13541] integrity_inode_get: pid=13541 ppid=13514 ino:7604534
	count: 2 write:0 read:1
[  421.055163][T13543] integrity_inode_free: pid=13543 ppid=13514 ino:7604534
	count: 0 write:0 read:0
[  421.056274][T13543] integrity_inode_free null: pid=13543 ppid=13514 ino:7604534
	count: 0 write:0 read:0
[  421.058096][T13543] CPU: 3 PID: 13543 Comm: rm Not tainted 5.12.0-rc6+ #47
[  421.059039][T13543] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[  421.060277][T13543] Call Trace:
[  421.060645][T13543]  dump_stack+0x141/0x1d7
[  421.061156][T13543]  integrity_inode_free+0x3e7/0xa70
[  421.061726][T13543]  security_inode_free+0x1e/0xc0
[  421.062245][T13543]  __destroy_inode+0x22f/0x700
[  421.062807][T13543]  destroy_inode+0x91/0x1b0
[  421.063301][T13543]  iput.part.0+0x57e/0x810
[  421.063749][T13543]  iput+0x58/0x70
[  421.064123][T13543]  do_unlinkat+0x431/0x690
[  421.064553][T13543]  ? __ia32_sys_rmdir+0x100/0x100
[  421.065066][T13543]  ? getname_flags.part.0+0x1dd/0x4f0
[  421.065765][T13543]  __x64_sys_unlinkat+0xbd/0x130
[  421.066412][T13543]  do_syscall_64+0x2d/0x70
[  421.067082][T13543]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  421.068065][T13543] RIP: 0033:0x7fdaaaa0d17b
[  421.068590][T13543] Code: 73 01 c3 48 8b 0d fd fc 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd fc 0c 00 f7 d8 64 89 01 48
[  421.071401][T13543] RSP: 002b:00007ffdc00e5948 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
[  421.072321][T13543] RAX: ffffffffffffffda RBX: 0000562e27c0e820 RCX: 00007fdaaaa0d17b
[  421.073211][T13543] RDX: 0000000000000000 RSI: 0000562e27c0e920 RDI: 0000000000000004
[  421.074083][T13543] RBP: 0000562e27c0d440 R08: 0000000000000000 R09: 0000000000000000
[  421.074973][T13543] R10: 0000000000000231 R11: 0000000000000246 R12: 0000000000000000
[  421.075854][T13543] R13: 00007ffdc00e5a60 R14: 0000562e25ddca80 R15: 0000000000000002

Before accessing the "iint", make sure it hasn't already been freed.

Link: https://lore.kernel.org/linux-integrity/630cc0a27a0db8fd790a767300ae0a7f2540bdc2.camel@linux.ibm.com/
Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/iint.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index fca8a9409e4a..f2af4afbd94b 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -152,9 +152,13 @@ void integrity_inode_free(struct inode *inode)
 
 	write_lock(&integrity_iint_lock);
 	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
+	if (iint)
+		rb_erase(&iint->rb_node, &integrity_iint_tree);
 	write_unlock(&integrity_iint_lock);
 
+	if (!iint)
+		return;
+
 	iint_free(iint);
 }
 
-- 
2.27.0

