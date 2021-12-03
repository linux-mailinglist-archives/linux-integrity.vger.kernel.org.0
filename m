Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD0466FF4
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378206AbhLCCgC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:36:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378208AbhLCCfX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31qlJx008772;
        Fri, 3 Dec 2021 02:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=lGwNHCJCYs+XuGS6svOUrR9B9L2FrXF0CRsXbHhmFHU=;
 b=ABCTXnKFzx925KqfiBlgwiLsy92yd4zTkNS2uvXmeX63vRpuwhnlDX3lWaPI2zlwBk6l
 /GlaUTEF5Wd/ZSeUOXUqUf1Hq2623K4Rm/IlGSOy/7BtIWx1uprT5+9IuivIOt2mvBWb
 xradyabX+CqjlcZ0hPwkcP/0u2iw3hlt2u353gya3fafyxF42RY0zPsfxphuBjsLq3h6
 JRSc8/53NrO7wiVI8itMdRWr/0abvAflmDZHIG/De6CCkFdgoGLU3rhylcalbGmkznXI
 8dT+f7NwVTGOoxAstOmUEqy4L/KBtxjLY9Zwy5oVUnygImnXeu9EOTJoRoo1oEye4+by 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9y40h3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:48 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B31t3JS011976;
        Fri, 3 Dec 2021 02:31:47 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9y40h3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:47 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32RXaR011922;
        Fri, 3 Dec 2021 02:31:46 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcacuh11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:46 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32VicD28508638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:44 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FFCA6E052;
        Fri,  3 Dec 2021 02:31:44 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567526E078;
        Fri,  3 Dec 2021 02:31:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:43 +0000 (GMT)
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
        Denis Semakin <denis.semakin@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC v2 15/19] capabilities: Introduce CAP_INTEGRITY_ADMIN
Date:   Thu,  2 Dec 2021 21:31:14 -0500
Message-Id: <20211203023118.1447229-16-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WC-K7BIIuqtcr8DYRMbpLbpdTp8-slSf
X-Proofpoint-GUID: IjQfCacyIhRsLtm4Qn1sSv7A7DPuimjb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Denis Semakin <denis.semakin@huawei.com>

This patch introduces CAP_INTEGRITY_ADMIN, a new capability that allows
to setup IMA (Integrity Measurement Architecture) policies per container
for non-root users.

The main purpose of this new capability is discribed in this document:
https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
It is said: "setting the policy should be possibly without the powerful
CAP_SYS_ADMIN and there should be the opportunity to gate this with a new
capability CAP_INTEGRITY_ADMIN that allows a user to set the IMA policy
during container runtime.."

In other words it should be possible to setup IMA policies while not
giving too many privilges to the user, therefore splitting the
CAP_INTEGRITY_ADMIN off from CAP_SYS_ADMIN.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/capability.h          | 6 ++++++
 include/uapi/linux/capability.h     | 7 ++++++-
 security/selinux/include/classmap.h | 4 ++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..ea6d58acb95e 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -278,4 +278,10 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
+static inline bool integrity_admin_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable(ns, CAP_INTEGRITY_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 463d1ba2232a..48b08e4b3895 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -417,7 +417,12 @@ struct vfs_ns_cap_data {
 
 #define CAP_CHECKPOINT_RESTORE	40
 
-#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
+/* Allow setup IMA policy per container independently */
+/* No necessary to be superuser */
+
+#define CAP_INTEGRITY_ADMIN	41
+
+#define CAP_LAST_CAP		CAP_INTEGRITY_ADMIN
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35aac62a662e..7ff532b90f09 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -28,9 +28,9 @@
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
 		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
-		"checkpoint_restore"
+		"checkpoint_restore", "integrity_admin"
 
-#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
+#if CAP_LAST_CAP > CAP_INTEGRITY_ADMIN
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.31.1

