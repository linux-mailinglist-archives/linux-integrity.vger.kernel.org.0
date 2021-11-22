Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C233645956F
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Nov 2021 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhKVTVL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Nov 2021 14:21:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239730AbhKVTVK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Nov 2021 14:21:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMIH9bL026325;
        Mon, 22 Nov 2021 19:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SGpyo9KQRUkAVvdoPUbJFFK7McZLWuEkYP7m+13pdN0=;
 b=YFidDhWHYRxjN2n3eyyfhd9pM/ve8+liSryd+lBIIVBAR2rRPcaKiDBNo7Y6XyF0oz0q
 u5KpqQhtL/4gZiYgC4zofaaccsTuy7lOdOxga0fXLqC2rM9lhtAofnJBrxxbnPT6yMZX
 Qz2hsFO0YFkbGRJboL4x+lCvF6HJfHVgxNBYunybwugQSN3KKAi5yWbWLS4llsewUteX
 eaYOvb8Mt2trx6BEpxDdLqRJdHeOdVeRrgnltBDXeN/H9i1h0KEe1dDvyujEYzNcoRSo
 VXWxYzxtz/vCkStvl83H2lRHgYvAn3NJp83DEIHjf5kISAUHnbExPgGhxjhwg7UkJVNr Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cggbrs1u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:18:01 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMIiR1F010937;
        Mon, 22 Nov 2021 19:18:01 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cggbrs1tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:18:01 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJCtpj014352;
        Mon, 22 Nov 2021 19:18:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3cerna536y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 19:18:00 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMJI0qW22217050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 19:18:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED31DBE058;
        Mon, 22 Nov 2021 19:17:59 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ECD3BE053;
        Mon, 22 Nov 2021 19:17:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Nov 2021 19:17:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/2] selftests: tpm2: Reset the dictionary attack lock
Date:   Mon, 22 Nov 2021 14:17:52 -0500
Message-Id: <20211122191752.1308953-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211122191752.1308953-1-stefanb@linux.ibm.com>
References: <20211122191752.1308953-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JoV6qdOV9B40XdwoP-OlfE4ICAXh9yDQ
X-Proofpoint-ORIG-GUID: 0OYzvuZlZP6CS4yZQmkQFAJrtqbGt6F2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reset the dictionary attack lock to avoid the following types of test
failures after running the test 2 times:

======================================================================
ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_tests.py", line 105, in test_unseal_with_wrong_policy
    blob = self.client.seal(self.root_key, data, auth, policy_dig)
  File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 620, in seal
    rsp = self.send_cmd(cmd)
  File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py", line 397, in send_cmd
    raise ProtocolError(cc, rc)
tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=0x00000153, rc=0x00000921

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index a569c8d0db08..109ffd736c73 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -100,6 +100,7 @@ class SmokeTest(unittest.TestCase):
             policy_dig = self.client.get_policy_digest(handle)
         finally:
             self.client.flush_context(handle)
+            self.client.reset_da_lock()
 
         blob = self.client.seal(self.root_key, data, auth, policy_dig)
 
-- 
2.31.1

