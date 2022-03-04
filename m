Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91BF4CDB61
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Mar 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiCDRzZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Mar 2022 12:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbiCDRzU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Mar 2022 12:55:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44F1BAF17;
        Fri,  4 Mar 2022 09:54:32 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224HITem032039;
        Fri, 4 Mar 2022 17:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kDQtasFnKBps0wyc7bSFbQi7VDcJ2zGDFYtS546BHZA=;
 b=QtjMG+EhzPZgdCmP1muWQTk/cyN0XOBWehwqc6Y76OeTHIsSuBdVcKguTP96Y9OOxIGu
 KUzVK/D7nPOOVvDXEy4JiU+xF1/wiuYoZjAkS6MpICrAjW5NB280Vs/B3NEa8SyOpY2C
 VZAEbcDCTC/GsTHzqKqDLtF/w/+JUXY3Zy7eNAj34GhvC2fIk/ppVvIBC7x4HsgCyAij
 OcplO4cgI1ZiIl6gfEtvI+U10Ck+S35PkAm9OowRKNfHykRYdM63jFiANdCqaZhI7srI
 mKjSr2TeSVKv+beqTwTSZ24J4INL8G6ohabXLEh475/bWWgAhsMBnvrfQkpv6ot9xlwv gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ekk3tx3fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 17:54:28 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224HWSAe013143;
        Fri, 4 Mar 2022 17:54:27 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ekk3tx3f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 17:54:27 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224HnCB0019053;
        Fri, 4 Mar 2022 17:54:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3ek4k3j2fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 17:54:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224HhMXF48955862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 17:43:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9178A4060;
        Fri,  4 Mar 2022 17:54:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41423A4054;
        Fri,  4 Mar 2022 17:54:20 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.34.89])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 17:54:20 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v9 2/3] integrity: make integrity_keyring_from_id() non-static
Date:   Fri,  4 Mar 2022 12:54:02 -0500
Message-Id: <20220304175403.20092-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304175403.20092-1-nayna@linux.ibm.com>
References: <20220304175403.20092-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FdnsJcbf4mM1zZcjs4DVHKwTIuqDV9hw
X-Proofpoint-ORIG-GUID: Xvn-qAYixl3wGmLmrSisW45JJvCUDjf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_07,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make integrity_keyring_from_id() non-static so that it is accessible
by other files in security/integrity.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 security/integrity/digsig.c    | 2 +-
 security/integrity/integrity.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index c8c8a4a4e7a0..9c3165c07935 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -39,7 +39,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 #define restrict_link_to_ima restrict_link_by_builtin_trusted
 #endif
 
-static struct key *integrity_keyring_from_id(const unsigned int id)
+struct key *integrity_keyring_from_id(const unsigned int id)
 {
 	if (id >= INTEGRITY_KEYRING_MAX)
 		return ERR_PTR(-EINVAL);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 2e214c761158..76e9a9515f99 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -168,6 +168,7 @@ int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
 			       const void *data, size_t len, key_perm_t perm);
+struct key *integrity_keyring_from_id(const unsigned int id);
 #else
 
 static inline int integrity_digsig_verify(const unsigned int id,
@@ -195,6 +196,11 @@ static inline int __init integrity_load_cert(const unsigned int id,
 {
 	return 0;
 }
+
+static inline struct key *integrity_keyring_from_id(const unsigned int id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
-- 
2.27.0

