Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A542484668
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiADRFC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235659AbiADRE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204FERQw021380;
        Tue, 4 Jan 2022 17:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TTKTG4dOY60Xnfg8hK5WvhKZeYG4kJcaEKkmvVmq+QA=;
 b=nBfODIsjxSCJQJ/EWm4K2QkzIbyZh9+xjtUwb/oRiqDDTvYVkc9SWbaN+1Kylu2zf2ND
 fxLBtfMh+Ac2AfYZHaJrWFoXNju4nzmct/q6SxA14ZrhVAlEP45e4hrPNEyAeuTOzXCT
 vKBfswxSnqxAFs30f02KNjJqiJjp1ePdn6tv5qYajpep6EQZlmGdS5PKUb6+KEcr3lPo
 qBODyd33jAFtU1C5f5v3bBcw3sy8Gzur2DNtJ2jhWUXHcaVHho+4yT4JL3VD5JCY/F4/
 WAl6ZbDB5zEj88+kJD1UR44OQr6gqx6tkENhYH1TG8t63uR7HtFPcmRl/7I4A7J3+WsT AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxsg11y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204GpOOa029880;
        Tue, 4 Jan 2022 17:04:32 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxsg11k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:32 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H4BPM005125;
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3daekajer0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4Ual42664216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5004EAC062;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DF8FAC05F;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
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
Subject: [PATCH v8 10/19] ima: Implement hierarchical processing of file accesses
Date:   Tue,  4 Jan 2022 12:04:07 -0500
Message-Id: <20220104170416.1923685-11-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jl1zOuLfExGTWpJ6UqsnhgB4u8_UBjQK
X-Proofpoint-ORIG-GUID: cE-ICLKJHLPb6PN6Zn4ziIz7ePwwWy3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Implement hierarchical processing of file accesses in IMA namespaces by
walking the list of user namespaces towards the root. This way file
accesses can be audited in an IMA namespace and also be evaluated against
the IMA policies of parent IMA namespaces.

__process_measurement() returns either 0 or -EACCES. For hierarchical
processing remember the -EACCES returned by this function but continue
to the parent user namespace. At the end either return 0 or -EACCES
if an error occurred in one of the IMA namespaces.

Currently the ima_ns pointer of the user_namespace is always NULL except
at the init_user_ns, so test ima_ns for NULL pointer and skip the call to
__process_measurement() if it is NULL. Once IMA namespacing is fully
enabled, the pointer may also be NULL due to late initialization of the
IMA namespace.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h               |  6 +++++
 security/integrity/ima/ima_main.c | 37 +++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..fcee2a51bb87 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -65,6 +65,12 @@ static inline const char * const *arch_get_ima_policy(void)
 }
 #endif
 
+static inline struct user_namespace
+*ima_ns_to_user_ns(struct ima_namespace *ns)
+{
+	return current_user_ns();
+}
+
 #else
 static inline enum hash_algo ima_get_current_hash_algo(void)
 {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 621685d4eb95..51b0ef1cebbe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -200,10 +200,10 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
-static int process_measurement(struct ima_namespace *ns,
-			       struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+static int __process_measurement(struct ima_namespace *ns,
+				 struct file *file, const struct cred *cred,
+				 u32 secid, char *buf, loff_t size, int mask,
+				 enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -395,6 +395,35 @@ static int process_measurement(struct ima_namespace *ns,
 	return 0;
 }
 
+static int process_measurement(struct ima_namespace *ns,
+			       struct file *file, const struct cred *cred,
+			       u32 secid, char *buf, loff_t size, int mask,
+			       enum ima_hooks func)
+{
+	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
+	int ret = 0;
+
+	while (user_ns) {
+		ns = ima_ns_from_user_ns(user_ns);
+		if (ns) {
+			int rc;
+
+			rc = __process_measurement(ns, file, cred, secid, buf,
+						   size, mask, func);
+			switch (rc) {
+			case -EACCES:
+				/* return this error at the end but continue */
+				ret = -EACCES;
+				break;
+			}
+		}
+
+		user_ns = user_ns->parent;
+	};
+
+	return ret;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
-- 
2.31.1

