Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12F45956D
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Nov 2021 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhKVTVK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Nov 2021 14:21:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhKVTVJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Nov 2021 14:21:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMIMFCu023328;
        Mon, 22 Nov 2021 19:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=63b4NoVv1BbhmTPYET9cbUEWIa1ETC6rn4rqKbew5T4=;
 b=J91i6UXbZp2MGgOhUwmdqbaodJIbTVkBQ4MotohQZZNofo579cErulAe3f+aeHGtjL4z
 txtHBaAELIj6dbWqTv6uZIRH93K5+cAu8K44EY8JR9bcNA9B7+UmOFf+B2zHCT7j53DU
 M4pm7FBoWmV2X3zXpwiOlqqLmwszTUKKnKAfJ5xpghA+8TmLdXhLoakmQpoW3fhtqwoh
 S64oVtKHYTQhtWY4AsAzQTvZzVkraqrT9DSjp19KBQ9zshcM8I2XadWa8owgp1bN15hE
 soVqSDpCkSWQHCWiDGmLNUt3QBD3mLanE1CCVz0TTvt9Usex45UHGuYRyyS5W6JhIAFJ kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgge50x24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:18:01 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMJ7K8I012826;
        Mon, 22 Nov 2021 19:18:01 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgge50x1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:18:01 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJCWxL014863;
        Mon, 22 Nov 2021 19:18:00 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3cernaxmep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:18:00 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMJHxYg45482408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 19:17:59 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28044BE051;
        Mon, 22 Nov 2021 19:17:59 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52813BE04F;
        Mon, 22 Nov 2021 19:17:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Nov 2021 19:17:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/2] selftests: tpm: Probe for available PCR bank
Date:   Mon, 22 Nov 2021 14:17:51 -0500
Message-Id: <20211122191752.1308953-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211122191752.1308953-1-stefanb@linux.ibm.com>
References: <20211122191752.1308953-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ppox8UKmfqMce1MPn0fV1lzd73jfTi-H
X-Proofpoint-ORIG-GUID: eHOA7KEBaBKFNtUIrw8FL2Jr2mTAV8Fg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Probe for an available PCR bank to accommodate devices that do not have a
SHA-1 PCR bank or whose SHA-1 bank is deactivated.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 9d764306887b..a569c8d0db08 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -27,7 +27,21 @@ class SmokeTest(unittest.TestCase):
         result = self.client.unseal(self.root_key, blob, auth, None)
         self.assertEqual(data, result)
 
+    def determine_bank_alg(self):
+        # Probe for available PCR bank
+        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
+            try:
+                handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
+                self.client.policy_pcr(handle, [17], bank_alg=bank_alg)
+                break
+            except tpm2.UnknownPCRBankError:
+                pass
+            finally:
+                self.client.flush_context(handle)
+        return bank_alg
+
     def test_seal_with_policy(self):
+        bank_alg = self.determine_bank_alg()
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
         data = ('X' * 64).encode()
@@ -35,7 +49,7 @@ class SmokeTest(unittest.TestCase):
         pcrs = [16]
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             policy_dig = self.client.get_policy_digest(handle)
@@ -47,7 +61,7 @@ class SmokeTest(unittest.TestCase):
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
@@ -72,6 +86,7 @@ class SmokeTest(unittest.TestCase):
         self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
 
     def test_unseal_with_wrong_policy(self):
+        bank_alg = self.determine_bank_alg()
         handle = self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
 
         data = ('X' * 64).encode()
@@ -79,7 +94,7 @@ class SmokeTest(unittest.TestCase):
         pcrs = [16]
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             policy_dig = self.client.get_policy_digest(handle)
@@ -91,13 +106,13 @@ class SmokeTest(unittest.TestCase):
         # Extend first a PCR that is not part of the policy and try to unseal.
         # This should succeed.
 
-        ds = tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
-        self.client.extend_pcr(1, ('X' * ds).encode())
+        ds = tpm2.get_digest_size(bank_alg)
+        self.client.extend_pcr(1, ('X' * ds).encode(), bank_alg=bank_alg)
 
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
@@ -109,14 +124,14 @@ class SmokeTest(unittest.TestCase):
 
         # Then, extend a PCR that is part of the policy and try to unseal.
         # This should fail.
-        self.client.extend_pcr(16, ('X' * ds).encode())
+        self.client.extend_pcr(16, ('X' * ds).encode(), bank_alg=bank_alg)
 
         handle = self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
 
         rc = 0
 
         try:
-            self.client.policy_pcr(handle, pcrs)
+            self.client.policy_pcr(handle, pcrs, bank_alg=bank_alg)
             self.client.policy_password(handle)
 
             result = self.client.unseal(self.root_key, blob, auth, handle)
-- 
2.31.1

