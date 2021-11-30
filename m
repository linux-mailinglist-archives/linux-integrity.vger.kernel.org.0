Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD6463B2F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhK3QLb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:11:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243483AbhK3QLC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:11:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFQDQA010483;
        Tue, 30 Nov 2021 16:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pOKE3jw6FW1nbqXSMnOvb0qVChrphXK9yGRylQbzf1o=;
 b=rcJygH5K9F1B8CiunH9rfhrY6k83zU25NYua+zkhNjxOKG5I1RxjX42o516IxeX18V66
 DzDuH7Fz5h7L2TKQ2fZ7704nZZ9RBDKv4ZRTfIB6VJ20fsJ3wEquD3CISjpLJOz/duaA
 4ZehfQU2D4LSNj7eohp+YvfEFDbvR9BcW/wkGYqLtMbeBSfIfSZp8PWfOb2CbOpR/ZVu
 5VbQclkxn1fyqdd9GBR7V+NkX13rCbE2P85dzG04wqopTYVWPh/0dLp0QFMvsGQmAXZI
 ZZIntKna53f/bON5tQqOTFmAwMtcyeXhFdu3BXOF7s4DdD/G84kVRYFQCRo0jwfY1B6Q zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnphjs56e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:18 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFWomQ007114;
        Tue, 30 Nov 2021 16:07:17 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnphjs55c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:17 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG4NYv023600;
        Tue, 30 Nov 2021 16:07:16 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3cn5ey284d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7EcG45482326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8431B20A9;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86ABDB20A4;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC 19/20] ima/userns: Define early teardown function for IMA namespace
Date:   Tue, 30 Nov 2021 11:06:53 -0500
Message-Id: <20211130160654.1418231-20-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8r1ZOwdnP5ax1q4U2L1x7dJ4yLRf-Dc5
X-Proofpoint-ORIG-GUID: iFTy7kgl22Fhz3FoI5r_im2kwAfCdG1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Define an early teardown function ima_ns_userns_early_teardown() that
will be needed for early teardown of the securityfs_ns of an IMA name-
space since this holds one additional references to the user namespace.

This function is not called yet since the refcount_teardown variable at
this point is always 0.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/user_namespace.h  | 8 ++++++--
 security/integrity/ima/ima_ns.c | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 505e3b3748b6..6bc178d4c6e2 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -158,14 +158,18 @@ static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 extern int create_user_ns(struct cred *new);
 extern int unshare_userns(unsigned long unshare_flags, struct cred **new_cred);
 extern void __put_user_ns(struct user_namespace *ns);
+extern void ima_ns_userns_early_teardown(struct ima_namespace *ima_ns);
 
 static inline void put_user_ns(struct user_namespace *ns)
 {
 	if (ns) {
 		if (refcount_dec_and_test(&ns->ns.count))
 			__put_user_ns(ns);
-		else if (refcount_read(&ns->ns.count) == ns->refcount_teardown)
-			;
+		else if (refcount_read(&ns->ns.count) == ns->refcount_teardown) {
+#ifdef CONFIG_IMA_NS
+			ima_ns_userns_early_teardown(ns->ima_ns);
+#endif
+		}
 	}
 }
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index e4f4cf84a6b5..e7ad52b79f99 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -16,6 +16,7 @@
 #include <linux/mount.h>
 #include <linux/proc_ns.h>
 #include <linux/lsm_hooks.h>
+#include <linux/user_namespace.h>
 
 #include "ima.h"
 
@@ -64,6 +65,11 @@ struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
 	return create_ima_ns(user_ns);
 }
 
+void ima_ns_userns_early_teardown(struct ima_namespace *ns)
+{
+}
+EXPORT_SYMBOL(ima_ns_userns_early_teardown);
+
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
-- 
2.31.1

