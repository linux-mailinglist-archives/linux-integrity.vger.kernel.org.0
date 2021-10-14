Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18E42D9AA
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhJNNDt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Oct 2021 09:03:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58269 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhJNNDs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Oct 2021 09:03:48 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ECpWBc008814;
        Thu, 14 Oct 2021 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=UA1kmBYZNSZFLMxUcvWpCjz4k7dlKYSlZ3+y5G1nDJQ=;
 b=aGaHln61iYM7f+ztu6FeoAitk9UnQ3BkGTqKzw+NHUIIwAHv27tii2RgSXRR8334k2gi
 8JNafo0dw5J1BKYHcDPQEIQyc3Ae8BUNgWtbkFmo5rdfJ9UmiXWc3pSeJU1ttlg7XSMY
 5plQW90y9RsxtrJ2ewnxmLVw5ujnhDvDTblx9jO7y/nZXNyhi3AUlLILYDEcEZEMJoN/
 aOHPxg5KQsRpwM+dz+If6f61b6Qjy2+ZST+X8FPbHrTa6sfCh+gwtCSpG72xVHbKd3mH
 3JlcEHrg1QfasIvG9l8a1gGP1IjL/gCXnWmXYrUVwXP0fn0h6HUDQ0MPy2+FKkAVCjnT 8w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpf49fp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 09:01:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19ECpf7N027922;
        Thu, 14 Oct 2021 13:01:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qancyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:01:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19ED1YMx62783848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 13:01:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BC36A4040;
        Thu, 14 Oct 2021 13:01:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA63EA4055;
        Thu, 14 Oct 2021 13:01:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.55.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 13:01:32 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v1 3/3] security: define a trusted_for hook
Date:   Thu, 14 Oct 2021 09:01:25 -0400
Message-Id: <20211014130125.6991-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211014130125.6991-1-zohar@linux.ibm.com>
References: <20211014130125.6991-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0GJHVo6txvxQZZ0d_-W2ilKy9rJC_3JI
X-Proofpoint-ORIG-GUID: 0GJHVo6txvxQZZ0d_-W2ilKy9rJC_3JI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_07,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110140084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend the trusted_for syscall to call the security_trusted_for hook,
which calls registered LSMs and IMA, instead of calling IMA directly.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Mickaël, Casey, assuming there is a need...

 fs/open.c                     |  2 +-
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/lsm_hooks.h     |  6 ++++++
 include/linux/security.h      | 12 ++++++++++++
 security/security.c           | 10 ++++++++++
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 4d54e2a727e1..75336ca7020d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -586,7 +586,7 @@ SYSCALL_DEFINE3(trusted_for, const int, fd, const enum trusted_for_usage, usage,
 			mask | MAY_ACCESS);
 
 	if (!err)
-		err = ima_trusted_for(f.file, usage);
+		err = security_trusted_for(f.file, usage);
 
 out_fd:
 	fdput(f);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2adeea44c0d5..f847fc0fd030 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -402,3 +402,6 @@ LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
 LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
+
+LSM_HOOK(int, 0, trusted_for, struct file *file,
+	 const enum trusted_for_usage usage)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c4c5c0602cb..88e4f08f01ca 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1557,6 +1557,12 @@
  * 	Read perf_event security info if allowed.
  * @perf_event_write:
  * 	Write perf_event security info if allowed.
+ *
+ * Security hooks for trusted applications (e.g. interpreters)
+ *
+ * @trusted_for:
+ *	Return kernel file integrity status to trusted application
+ *
  */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b7288521300..b067e22c8903 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <uapi/linux/trusted-for.h>
 
 struct linux_binprm;
 struct cred;
@@ -2038,4 +2039,15 @@ static inline int security_perf_event_write(struct perf_event *event)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_PERF_EVENTS */
 
+#ifdef CONFIG_SECURITY
+extern int security_trusted_for(struct file *file,
+				const enum trusted_for_usage usage);
+#else
+static int security_trusted_for(struct file *file,
+				const enum trusted_for_usage usage)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY */
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/security/security.c b/security/security.c
index 9ffa9e9c5c55..f8e2a131d5cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2625,3 +2625,13 @@ int security_perf_event_write(struct perf_event *event)
 	return call_int_hook(perf_event_write, 0, event);
 }
 #endif /* CONFIG_PERF_EVENTS */
+
+int security_trusted_for(struct file *file, const enum trusted_for_usage usage)
+{
+	int ret;
+
+	ret = call_int_hook(trusted_for, 0, file, usage);
+	if (ret)
+		return ret;
+	return ima_trusted_for(file, usage);
+}
-- 
2.27.0

