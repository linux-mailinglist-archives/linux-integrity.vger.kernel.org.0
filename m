Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171154A65CE
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiBAUiI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbiBAUiI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JwVPa018706;
        Tue, 1 Feb 2022 20:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sKn3Zrhn5pU+AWVwEV5L2PFABRfRh7gUr7jWXdzpLN4=;
 b=PkU4zWG8b72gP4ac2M3k3r6r65aYy0AeY4dAwsy4Oc90ksF2sIdimaHh3Tv++UCdM4Wk
 NCF8qI95RCmKakzpBVaI8M8mQ6ZKgDidltAwk57lEjfzexg6tTLTj8k3YEPOi253ybPg
 cDiVCkG2KRtONTcYKf7sI5HL1QjxCsEzUC1bS9IcC/TuflYnghT6ub4zzjp6PVL2FNrR
 n7jBoStaP/b8+Ur/GMnvVEPiASlgUwNEA9r1z7QBjT53lywI2sJ7YAsoIeh8Yu8B/0kX
 9Ym7iQMAMpMtAlvf++wmTLMlMhRZ5XDpX9XJeNEr0OHYLT+gz82wx5Pxo+Nk3jXaeiHu Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dybg90pgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:52 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211K1TVZ002963;
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dybg90pg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:51 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWfmI027307;
        Tue, 1 Feb 2022 20:37:50 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3dvw7bq19e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:50 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Kbnsl32178664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A7D8B206B;
        Tue,  1 Feb 2022 20:37:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AF24B2068;
        Tue,  1 Feb 2022 20:37:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:49 +0000 (GMT)
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
Subject: [PATCH v10 03/27] ima: Return error code obtained from securityfs functions
Date:   Tue,  1 Feb 2022 15:37:11 -0500
Message-Id: <20220201203735.164593-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CgssiU8lR-FHeyyynfqn10q829_VQhKf
X-Proofpoint-GUID: Vm-GJPkiK-37AWsA0K8L-dX9uFynf8xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If an error occurs when creating a securityfs file, return the exact
error code to the caller.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_fs.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3ad8f7734208..cd1683dad3bf 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -452,47 +452,61 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int __init ima_fs_init(void)
 {
+	int ret;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
-		return -1;
+		return PTR_ERR(ima_dir);
 
 	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
 						NULL);
-	if (IS_ERR(ima_symlink))
+	if (IS_ERR(ima_symlink)) {
+		ret = PTR_ERR(ima_symlink);
 		goto out;
+	}
 
 	binary_runtime_measurements =
 	    securityfs_create_file("binary_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_ops);
-	if (IS_ERR(binary_runtime_measurements))
+	if (IS_ERR(binary_runtime_measurements)) {
+		ret = PTR_ERR(binary_runtime_measurements);
 		goto out;
+	}
 
 	ascii_runtime_measurements =
 	    securityfs_create_file("ascii_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_ascii_measurements_ops);
-	if (IS_ERR(ascii_runtime_measurements))
+	if (IS_ERR(ascii_runtime_measurements)) {
+		ret = PTR_ERR(ascii_runtime_measurements);
 		goto out;
+	}
 
 	runtime_measurements_count =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count))
+	if (IS_ERR(runtime_measurements_count)) {
+		ret = PTR_ERR(runtime_measurements_count);
 		goto out;
+	}
 
 	violations =
 	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
 				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations))
+	if (IS_ERR(violations)) {
+		ret = PTR_ERR(violations);
 		goto out;
+	}
 
 	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
+	if (IS_ERR(ima_policy)) {
+		ret = PTR_ERR(ima_policy);
 		goto out;
+	}
 
 	return 0;
 out:
@@ -503,5 +517,6 @@ int __init ima_fs_init(void)
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
-	return -1;
+
+	return ret;
 }
-- 
2.31.1

