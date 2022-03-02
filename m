Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE04CA67E
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbiCBNvj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbiCBNv2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9578AC55B7;
        Wed,  2 Mar 2022 05:50:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222Cs7hX032107;
        Wed, 2 Mar 2022 13:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j1r7osoqU6dlwV/a3+fTgpXyksu5n+ZXK8i5h+MfQQk=;
 b=AsbHT7QgHeQXaDAdb64wW5co88QM7Qrb8jwEnxnKipK1wBrKiIuk7bnYx54Fg4I5xo1g
 xhOR8HTPQaS97a8QHWezd7+pjQN/tN8eyOz57XW09qcUlqVdfzpeD6CozRIqkd+6WMKY
 03Ris0puFGrqlU4m+mmCiiYUkUA2t2EsxfI6tTDQ5xKuab0UwqzS/KGMzFSYKphLJMV3
 Ra9yKfG69Ho3Cx+mrj2g/AGBtYCpCO8hoocAiiinVb/NnKzETVUZNWdTiIF7/HUYvcsc
 RgwHpoLxBZomiq7CeX+JN1KiB3K04b9U7TEK4FmumvJkytgDUJ+p8DnhDN/xis5Tygoz VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej90as4ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:02 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DklVk016114;
        Wed, 2 Mar 2022 13:50:01 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej90as4jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222DmUck005327;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3efbuany3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222DnwRK40042818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C86E411206B;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABEB311206F;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v11 13/27] ima: Only accept AUDIT rules for non-init_ima_ns namespaces for now
Date:   Wed,  2 Mar 2022 08:46:48 -0500
Message-Id: <20220302134703.1273041-14-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9WGlNG_3L4vhYybQq1tljZ2I-trSatwA
X-Proofpoint-GUID: H5baiJxsRGKi8by01NJfHEoZrYEKEGVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Only accept AUDIT rules for non-init_ima_ns namespaces for now. Reject
all rules that require support for measuring, appraisal, and hashing.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

---
v9:
  - Jump to err_audit when unsupported rules are detected
---
 security/integrity/ima/ima_policy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 060d45cf35a7..c30e1f4490ae 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1813,6 +1813,17 @@ static int ima_parse_rule(struct ima_namespace *ns,
 			result = -EINVAL;
 			break;
 		}
+
+		/* IMA namespace only accepts AUDIT rules */
+		if (ns != &init_ima_ns && result == 0) {
+			switch (entry->action) {
+			case MEASURE:
+			case APPRAISE:
+			case HASH:
+				result = -EINVAL;
+				goto err_audit;
+			}
+		}
 	}
 	if (!result && !ima_validate_rule(entry))
 		result = -EINVAL;
@@ -1825,6 +1836,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 		check_template_modsig(template_desc);
 	}
 
+err_audit:
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.31.1

