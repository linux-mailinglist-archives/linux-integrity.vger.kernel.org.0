Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89524D53CE
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Mar 2022 22:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbiCJVqk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Mar 2022 16:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiCJVqd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Mar 2022 16:46:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E3119416B;
        Thu, 10 Mar 2022 13:45:31 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AKVQNS022412;
        Thu, 10 Mar 2022 21:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kDQtasFnKBps0wyc7bSFbQi7VDcJ2zGDFYtS546BHZA=;
 b=giov0C5JLNIZzzOYMkBhjwHG+5ablblfClecU2TyLPAqaXh8jkrH3Q0O+glUp8WLk63r
 gXfrjCBnXSFvqEuL1kR/fY92FBlM3+y7hNHl4U4wDhiiQkki1rs8PqvlLONywRqhTUgS
 3iQC/FRIWqXewYSmNvEneOAJZ0NniGThkxjMgoBPMBW+v8jqRH3WOhABy8+16i0BuZw3
 DRFzzBYLMyWwOAwwYY8K6bwcyn6JHQmW1W+HJhRedpl/Z2oFoTjcrkTMVIWLV9HJG1y8
 5Qf+qCCEqgxF0R2OiliT9nQPwVtzI5cwyQNX1pDawHJ5b9OpG16VSNgcaY8uiW9/9PXI yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqgwhn69s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:45:27 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22ALTrYI013236;
        Thu, 10 Mar 2022 21:45:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eqgwhn69d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:45:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22ALi4oY006203;
        Thu, 10 Mar 2022 21:45:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3enqgnr65h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:45:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22ALjMej56426848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 21:45:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 148ADA4057;
        Thu, 10 Mar 2022 21:45:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03CC8A404D;
        Thu, 10 Mar 2022 21:45:18 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.53.50])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Mar 2022 21:45:17 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v11 2/4] integrity: make integrity_keyring_from_id() non-static
Date:   Thu, 10 Mar 2022 16:44:48 -0500
Message-Id: <20220310214450.676505-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310214450.676505-1-nayna@linux.ibm.com>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X493b1t33rVBa2LQ1ff13i3v_dTap19V
X-Proofpoint-ORIG-GUID: nVHSkJZguPeeMW-J-JFXm6N5CUVDjGSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100107
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

