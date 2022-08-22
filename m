Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E459C0C7
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Aug 2022 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiHVNmG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Aug 2022 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiHVNmF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Aug 2022 09:42:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACA118E1B
        for <linux-integrity@vger.kernel.org>; Mon, 22 Aug 2022 06:42:01 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MDSTXd021880;
        Mon, 22 Aug 2022 13:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=R8ZarQPB03+5CbP0CXy5SM3pkcBx2L71OrTt452Cx5Q=;
 b=LNzb+SN6CazGbKwqNV7H4J3ncdQcLD4eRX+COuVjHWf5O23spTpXw2l+h4wCfGyKH/zS
 RUf8OvAzDzTNU9aDHCYcHKGVL6uOwcI2RZzke7JFVkutw4+vnd6M/I5wuWGGYefGRfMl
 ctvlF6Bb+OaXN9/ZeC4EbwxqrRWyvEB3LN/hoRcRXmGB0DxpGkmTfnG347IK/vvLRDpv
 KNpQckdvUAntn/ura2l2obnsu7QHIiJr5s+lT6JQ46Lb06gUMokm4THTqqQSCfPBoEw4
 OFIYKIe7KSUIFn/AiF1IKpcZCW/TkdaloCJiu50SEp9FPHmR0HKzsUM/Ds6oWrXyLt9t UA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4aqe8e8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 13:41:42 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MDehet030657;
        Mon, 22 Aug 2022 13:41:40 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3j2q891tkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 13:41:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MDfbS328574010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 13:41:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C97A404D;
        Mon, 22 Aug 2022 13:41:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E4EBA4040;
        Mon, 22 Aug 2022 13:41:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.163.20.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Aug 2022 13:41:36 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Simon Thoby <simon.thoby@viveris.fr>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] ima: fix blocking of security.ima xattrs of unsupported algorithms
Date:   Mon, 22 Aug 2022 09:41:24 -0400
Message-Id: <20220822134124.1090472-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5I_CdPrebQdMCJCqnTRFO4OHGC54dxda
X-Proofpoint-ORIG-GUID: 5I_CdPrebQdMCJCqnTRFO4OHGC54dxda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Limit validating the hash algorithm to just security.ima xattr, not
the security.evm xattr or any of the protected EVM security xattrs,
nor posix acls.

Fixes: 50f742dd9147 ("IMA: block writes of the security.ima xattr with unsupported algorithms")
Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index bde74fcecee3..3e0fbbd99534 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -750,22 +750,26 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	const struct evm_ima_xattr_data *xvalue = xattr_value;
 	int digsig = 0;
 	int result;
+	int err;
 
 	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
 				   xattr_value_len);
 	if (result == 1) {
 		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
 			return -EINVAL;
+
+		err = validate_hash_algo(dentry, xvalue, xattr_value_len);
+		if (err)
+			return err;
+
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		result = validate_hash_algo(dentry, xvalue, xattr_value_len);
-		if (result)
-			return result;
-
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
+		if (result == 1)
+			result = 0;
 	}
 	return result;
 }
-- 
2.31.1

