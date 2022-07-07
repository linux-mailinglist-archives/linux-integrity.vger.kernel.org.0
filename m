Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6556A5E2
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jul 2022 16:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiGGOsi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jul 2022 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiGGOsb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jul 2022 10:48:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EB55581;
        Thu,  7 Jul 2022 07:48:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EMpDU024927;
        Thu, 7 Jul 2022 14:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O//a5zlLvQZ6XagKc13b+xL++Fbux04O3vgdHrK3Hdk=;
 b=gM05ZhVmEzsFS6IEmTZ1WDee4cdd86+vyIc7kA7yX1pz88VKSyzsU6933/JzFl7fqesU
 lzalWallr1a4tN6oZaMVXEdjRi6Uu0Y1ncx5zXZDQFj/w+XC9VFQx+bXvwquE+CoSl5t
 wATtC4hMsWSYM9AEA0YuQRp6iccQEmwmHfqBO56JRV/qRhElvHZlGa3Utklzjkrh7EgP
 DxoW84hhHGcKmvphTVKwg56WLbKLdqLCRkS6oF3N6ndvfkg2HEFjWvRjD3DPBS5Z0g/8
 VS9xR3DhT703gobBcIaw9p3r6gMj5BQyXtHoHhQGqytfuqmMxt4zy60JMU4UBF4Ccu83 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60qp2540-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:08 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267EN1Ex026267;
        Thu, 7 Jul 2022 14:48:07 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h60qp253j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:07 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267EacLO006769;
        Thu, 7 Jul 2022 14:48:06 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3h4ucnuyca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 14:48:06 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267Em5w533489304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 14:48:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC0AB112062;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC3A112061;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 14:48:05 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v13 12/26] ima: Only accept AUDIT rules for non-init_ima_ns namespaces for now
Date:   Thu,  7 Jul 2022 10:47:46 -0400
Message-Id: <20220707144800.828288-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707144800.828288-1-stefanb@linux.ibm.com>
References: <20220707144800.828288-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VuwqG02sLf5rHJV8jeZml0OLWT2VqrnE
X-Proofpoint-GUID: klyM1Frv1fDm3BTkgEfdqh9kBddn81rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For non-init_ima_ns namespaces, only accept AUDIT rules for now. Reject
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
index de335dd97309..4a7e1e57655d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1865,6 +1865,17 @@ static int ima_parse_rule(struct ima_namespace *ns,
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
@@ -1886,6 +1897,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 				     "verity rules should include d-ngv2");
 	}
 
+err_audit:
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.36.1

