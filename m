Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1742F15498D
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBFQpp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 11:45:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38498 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgBFQpp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 11:45:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016GdFQS031978;
        Thu, 6 Feb 2020 16:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=rS7kfd+W+sxO4zQDEcEFqOFt8LYF0NN3PbNF2JF29cQ=;
 b=fPG9sOG4qc4YjrdSxixjfK7R1nQQlJTWDLjlTUrBLnOcdYgvzE8pzA0vrlQXFtL9mix6
 cgC3pQjG/OFfi61LXUz6NrO64rQuJDu31f5muBFzxf8hQhtP13AwuIeX4NHBDLTHdqXl
 XekORvMvPMPc1UdoFLexuHD0d3wmAOzDfViSPpYvlWSQoZg4l43lm4Q6AcimmSqeYo3y
 ATLqqnAIbJFMlcDacyygwKrGb0qio95Cq2Rc2KiNrphVHVP33jlWD8Sd8dl68AtWXy+f
 NXEC0RjoiRAsO/jzz8wfHGjAMdEcmuwlqey4FrrP6qCFMB6rCZDbxJAUUwVehFOOMdNP MQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=rS7kfd+W+sxO4zQDEcEFqOFt8LYF0NN3PbNF2JF29cQ=;
 b=R59kAgEZ8fr8djLyCAi4G2ysbpvi2c3CTKkUyPVTqFtLWLqdPfLIGHmTpD+J9x6EXc8F
 0GWC+zSBu++m/SgeruI0mgO31jNGyQCtdJP15TRbWgnY0Uv3A9M7Q9xo8UpqpwwHevhQ
 5Lpq0WtiGdrLRxRXBTTpU2HKw2kJ5PjSPsKjOyaVi3OLUO/6Tw/Uw+1yWVA0pLAa1GtM
 knowgtLA3zf2CsaAEj0WbZhqSIbwwSSPoORKqxqz3BflO1YMwM5eiCXoOKbx1XmELNRr
 td0vCHwlzZ4EaJjamqoLGzhLxTzWHzyQ/assVZMcO68XBBJuXbzKLLMcRb3mq0T3dFSc Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbpax3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 16:42:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016GdL9C045670;
        Thu, 6 Feb 2020 16:42:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y0mjucpjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 16:42:45 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016Ggd1A008328;
        Thu, 6 Feb 2020 16:42:39 GMT
Received: from localhost.us.oracle.com (/10.147.27.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 08:42:38 -0800
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        eric.snowberg@oracle.com, tglx@linutronix.de,
        bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] ima: Implement support for uncompressed module appended signatures
Date:   Thu,  6 Feb 2020 11:42:25 -0500
Message-Id: <20200206164226.24875-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200206164226.24875-1-eric.snowberg@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently IMA can validate compressed modules containing appended
signatures.  This adds the ability to also validate uncompressed
modules when appraise_type=imasig|modsig.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/digsig.c           | 9 +++++++--
 security/integrity/ima/ima_appraise.c | 3 +++
 security/integrity/integrity.h        | 3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index ea1aae3d07b3..5e0c4d04ab9d 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -15,6 +15,7 @@
 #include <linux/key-type.h>
 #include <linux/digsig.h>
 #include <linux/vmalloc.h>
+#include <linux/verification.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
 
@@ -31,6 +32,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".builtin_trusted_keys",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
@@ -45,8 +47,11 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
 		return ERR_PTR(-EINVAL);
 
 	if (!keyring[id]) {
-		keyring[id] =
-			request_key(&key_type_keyring, keyring_name[id], NULL);
+		if (id == INTEGRITY_KEYRING_KERNEL)
+			keyring[id] = VERIFY_USE_SECONDARY_KEYRING;
+		else
+			keyring[id] = request_key(&key_type_keyring,
+						  keyring_name[id], NULL);
 		if (IS_ERR(keyring[id])) {
 			int err = PTR_ERR(keyring[id]);
 			pr_err("no %s keyring: %d\n", keyring_name[id], err);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 300c8d2943c5..4c009c55d620 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -294,6 +294,9 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
 	    func == KEXEC_KERNEL_CHECK)
 		rc = integrity_modsig_verify(INTEGRITY_KEYRING_PLATFORM,
 					     modsig);
+	if (rc && func == MODULE_CHECK)
+		rc = integrity_modsig_verify(INTEGRITY_KEYRING_KERNEL, modsig);
+
 	if (rc) {
 		*cause = "invalid-signature";
 		*status = INTEGRITY_FAIL;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 73fc286834d7..63f0e6bff0e0 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -145,7 +145,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_KERNEL	3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
-- 
2.18.1

