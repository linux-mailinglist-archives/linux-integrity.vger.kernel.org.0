Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00A14CA651
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbiCBNvG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiCBNvE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537346F4A2;
        Wed,  2 Mar 2022 05:50:21 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222D6m3a009982;
        Wed, 2 Mar 2022 13:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dPifZdpI3YuNsXOLXWcvjFZZLnguUhHVXpYbxHrgndw=;
 b=oxmbKA03ALyF7hZI/qJvEyFZ7MFRxqm2DrxRvkVz/Zq9a0NyVKny05MsyLI/+uLbOkem
 WAMaA5EJV4oL9jk47GrJUKsZb11eLrJCO2Scl87IIxpiAN5BLC4fg29shpv6LNryqJWz
 kspsAVR7nCWmgfNLSE1ntp/iCbFA2Xg5Cb9rLa354ENo1hwceYaQn7VUW3yHscl6SyTw
 hc4vjEAsPqCutOFKgj6Kc/UhHCB1ZSNUbc/Z37a8y2s32ggzWJ7tRy8zclMCvcRafgEG
 4mEdZMzzWXy/ldZp/HOX3jED4PCgkfs6AUssSlxFA7j+Uo8XNaFcz4Gza97uq3UdmDgo 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej779vt7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DSI4a012130;
        Wed, 2 Mar 2022 13:50:02 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej779vt74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:02 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222DmUWP005334;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3efbuany3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Dnxno49545616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E4B811206F;
        Wed,  2 Mar 2022 13:49:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208A5112070;
        Wed,  2 Mar 2022 13:49:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:59 +0000 (GMT)
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
Subject: [PATCH v11 16/27] ima: Implement ima_free_policy_rules() for freeing of an ima_namespace
Date:   Wed,  2 Mar 2022 08:46:51 -0500
Message-Id: <20220302134703.1273041-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QJNsN2jiz2E9j4S9nrEaxPHYYFIPl-rq
X-Proofpoint-GUID: -jnPJj6E-rmidxrPss6wR9F0EsvzyoDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement ima_free_policy_rules() to free the current custom IMA policy's
rules. This function will be called when an ima_namespace is freed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

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
index 2775a6d89e6d..054b8f67be04 100644
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
index c30e1f4490ae..50c7bdec5109 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1906,6 +1906,20 @@ void ima_delete_rules(struct ima_namespace *ns)
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
2.31.1

