Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5856A61F
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiGGOso (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbiGGOsh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28062F381;
        Thu,  7 Jul 2022 07:48:34 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267Ej3eu029605;
        Thu, 7 Jul 2022 14:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=da9YK8IRyGicdrFyhTA8wGJBQi+TtBxpE5Udg1MmBBs=;
 b=qUsP9Z4jQCvVCybT8EzOceBff/xuNeocWTZ/gQq1e+CwlbOYZT8ThNe5btWwf/oFXCnd
 n7ZkCDMJn1fmQ28MANeHTo+/jnYQUtG1L79TE24s1OkgNSQ+c7fDklGIlkbPa60+5/uO
 zfpDy1AyhT5zeuETTrt1iiUAtunwKenFqEO6Ph8STQ5VQHtRSobW3gzpd4pT3ePk8xv7
 8SbMWmZmJFz/rTBOGYRa57Vj7fYYgveVYtJf7CWc9SV1sP08NHGVHtZgFjSjWj3XOtCc
 LMEnUcFIOpkZHguKvAgH2jANGNhwrpmBWlWYeye/lh+alh9i6hZHbNFu7Q2CcvUd/mBT Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61hb040j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:09 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EjH5R031209;
        Thu, 7 Jul 2022 14:48:08 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h61hb03y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EZPVA031729;
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3h4ud1uy01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em6le9896572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F5E6112062;
        Thu,  7 Jul 2022 14:48:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23EBE112063;
        Thu,  7 Jul 2022 14:48:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:06 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v13 15/26] ima: Implement ima_free_policy_rules() for freeing of an ima_namespace
Date:   Thu,  7 Jul 2022 10:47:49 -0400
Message-Id: <20220707144800.828288-16-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XRTHou1pak4Pe-ZUcZhhGC-V4MXky0b5
X-Proofpoint-GUID: RSSf9RTaH9kygnLcJeL4m-ZtIdXQPKmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement ima_free_policy_rules() to free the current custom IMA policy's
rules. This function will be called when an ima_namespace is freed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>

---
v10:
  - Not calling ima_delete_rules() anymore
  - Move access check from ima_delete_rules into very last patch

 v9:
  - Only reset temp_ima_appraise when using init_ima_ns.
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_policy.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e662641772fd..528d792c82c1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -333,6 +333,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
 ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
 void ima_delete_rules(struct ima_namespace *ns);
 int ima_check_policy(struct ima_namespace *ns);
+void ima_free_policy_rules(struct ima_namespace *ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4a7e1e57655d..f5997f5a8f5b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1967,6 +1967,20 @@ void ima_delete_rules(struct ima_namespace *ns)
 	}
 }
 
+/**
+ * ima_free_policy_rules - free all policy rules
+ * @ns: IMA namespace that has the policy
+ */
+void ima_free_policy_rules(struct ima_namespace *ns)
+{
+	struct ima_rule_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
+		list_del(&entry->list);
+		ima_free_rule(entry);
+	}
+}
+
 #define __ima_hook_stringify(func, str)	(#func),
 
 const char *const func_tokens[] = {
-- 
2.36.1

