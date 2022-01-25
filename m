Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C349BEFC
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 23:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiAYWrp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234211AbiAYWr2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:28 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PM6BvZ002670;
        Tue, 25 Jan 2022 22:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M5GQfvz2hg5dXcQWST/28zSIctIm71dQ5WYSoFeXAhs=;
 b=VWxNOfolrB0QlqzeoUOYgEAjpZug8j/L7jbeSZ/RCHOmLJcj0DjstlzG++E8acIN6pFh
 OJOkIC98Hy5itm20sY9iYi/IDzFG0yALcEn9mzmPrzALn40MuSAZx+2PxAvwrQ4SHC9d
 0TZ6Kfh43vToQrWbRi8dirPV3+MYV6xCZ4lvqTdTxy6LnQ8Q8FhBQHnDZZm4QAL8Hhgb
 5Oo97fknf9FXlOoEgaYlBTwEcLbuENNiTaLiI8XyFK+yPE0nvBXr70mFN7W44EQKFQ1B
 lKfE3VdIB8f9fWCwG8nh4wMcaASGTlBX13oOogRQ2cB1s+xWYtCGa+XV3yMlq6LvK0R8 rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtryw1cbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:02 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMYtBw032167;
        Tue, 25 Jan 2022 22:47:01 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtryw1cbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:01 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMh3Mn011257;
        Tue, 25 Jan 2022 22:47:00 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3dt1x9rg89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:00 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkwwj32440780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5068AAC062;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34A0DAC05E;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
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
Subject: [PATCH v9 13/23] ima: Only accept AUDIT rules for non-init_ima_ns namespaces for now
Date:   Tue, 25 Jan 2022 17:46:35 -0500
Message-Id: <20220125224645.79319-14-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0R-m_-LSTiCmPTt-rdxHe7bfEikHdTKu
X-Proofpoint-ORIG-GUID: YZAPGAFh1pgH6Nns4KRVs7SkuIirmbZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Only accept AUDIT rules for non-init_ima_ns namespaces rejecting all rules
that require support for measuring, appraisal, and hashing.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
  - Jump to err_audit when unsupported rules are detected
---
 security/integrity/ima/ima_policy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3b754b9f5ef7..e8140e73d80b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1794,6 +1794,17 @@ static int ima_parse_rule(struct ima_namespace *ns,
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
@@ -1806,6 +1817,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 		check_template_modsig(template_desc);
 	}
 
+err_audit:
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.31.1

