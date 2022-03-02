Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE74CA66A
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiCBNvc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242382AbiCBNvI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3166CC55A1;
        Wed,  2 Mar 2022 05:50:25 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Bm7Lw007634;
        Wed, 2 Mar 2022 13:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DfUt7CUSXuxdJceegAgR/IDVY5F54an8OwIpQOK5YCo=;
 b=VIfhoyor2mLa0T9xB9NJd5U9yv251Hg0grlhssc4oQkSP2p8F+Vcgnif37P+IVp0M56H
 I3/8TmqVNii9kflUn4l8+o/6aQt0h/VsLVU9JuKEdzcMIosXYhsncJUBSkf+2cYEo3c9
 cNrvru9u6hDgoSiSCDup8jPItsZJuTJ/ndz4Fb5cXOXi6Vt0BPkhcNtDMHvr2lcrGlhn
 LK6WrDNXrlSKkUDXwunzDQVIbU9T/p0y/F/jO42Q2aYuplT5r0VZLA1PgSiNdkMcwBtE
 /v09ZR5v90sAdR1o+v+PCrhfjbt0l2j18H6amD+3uZ06iutOK0sznxcChm3Pam/sB9a3 EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej81ctg9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222Dl4OM028772;
        Wed, 2 Mar 2022 13:50:01 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej81ctg8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222DmUWO005334;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3efbuany38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:49:59 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Dnvbt34406862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F367911206B;
        Wed,  2 Mar 2022 13:49:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6712112072;
        Wed,  2 Mar 2022 13:49:56 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v11 01/27] ima: Return error code obtained from securityfs functions
Date:   Wed,  2 Mar 2022 08:46:36 -0500
Message-Id: <20220302134703.1273041-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZA7KyhWiC5plxNC9yEeSGwyxqR9gUeuZ
X-Proofpoint-ORIG-GUID: HZUET_dK2ZcyAN__v1fPs-2tr8DE_TCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If an error occurs when creating a securityfs file, return the exact
error code to the caller.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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

