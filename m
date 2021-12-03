Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25557467002
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhLCChC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:37:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34636 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350379AbhLCCgb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:36:31 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31lQlB012192;
        Fri, 3 Dec 2021 02:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D2FLJ+lRjtwJboYJ6XxWSGauauShUpqR6Vl+yR2VEdA=;
 b=VhysjOvepxBOXPV9xclUJWx8IB/bZOZrwL/nMjidyP3MKyoQUeQIJROxTOPTJ6KvgxOj
 K/viHnLilBQddWMlA+TT5gUa4ldcYIh9W7ayQfBcbFMLvtCHrOriEbRLr2fIhmji/yY+
 fFDHHMDt0bUNq+AcDRPdcdVkqf/ZncmgtYkfgoPiAgsA6O69AdIFCO5g60F2uC+MZht2
 Z/25A5S2B4Uiso+0UWQXrcQDEYvHPBm8BO8kAtVokPKxb+5nm0w2+t0UOWb2yH2mEeEA
 7VwCaZQUSrHsDbiHClCra8JGYD2g2/wUZ0OaJHfJ6k9hA4+SKo0TM4IdwIBQhvE4dl/U dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9vtrn06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:32:59 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B321Sjc024433;
        Fri, 3 Dec 2021 02:32:58 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9vtrn00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:32:58 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32REqi000839;
        Fri, 3 Dec 2021 02:32:57 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckcadbhv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:32:57 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32VmLI38863298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:48 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 585C16E056;
        Fri,  3 Dec 2021 02:31:48 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35A466E06E;
        Fri,  3 Dec 2021 02:31:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:47 +0000 (GMT)
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
Subject: [RFC v2 18/19] ima/userns: Define early teardown function for IMA namespace
Date:   Thu,  2 Dec 2021 21:31:17 -0500
Message-Id: <20211203023118.1447229-19-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DYvATug6x_-Y7slM5HF57KiqdlA5e-fl
X-Proofpoint-GUID: NYnnnepozcsBGNwlcQ21CZ8zXmvCkf8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Define an early teardown function ima_ns_userns_early_teardown() that
will be needed for early teardown of the namespaced SecurityFS used
by an IMA namespace since this holds one additional references to the
user namespace.

This function is not called yet since the refcount_teardown variable at
this point is always 0.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/user_namespace.h  | 8 ++++++--
 security/integrity/ima/ima_ns.c | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 505e3b3748b6..8f7870b37c73 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -158,14 +158,18 @@ static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 extern int create_user_ns(struct cred *new);
 extern int unshare_userns(unsigned long unshare_flags, struct cred **new_cred);
 extern void __put_user_ns(struct user_namespace *ns);
+extern void ima_ns_userns_early_teardown(struct ima_namespace *ns);
 
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
index debe863364fd..4260f96c4eca 100644
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

