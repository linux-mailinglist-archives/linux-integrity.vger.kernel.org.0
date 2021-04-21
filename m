Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC936739C
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbhDUToC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 15:44:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243368AbhDUToB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 15:44:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LJY7ld070501;
        Wed, 21 Apr 2021 15:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=13VxI2u/uzl1rsCou/jlybKaB3Fcj4Hk8iNuw0hp8ss=;
 b=OvJymb1xdNR4Kd+oMDKQ0Ip9w5nT0jKx3AYboEbCAjgXPxSlBbmBZcYvD/yZj9EKz2A/
 8tU50fJVqEjGPe3RAJbRVV65aZ9u55byUD086OY1W10/vB9gh0zd2p/rWUgVqPOQCtnA
 doovBfVkUr6l1Da1ycf+FOnuhSgWFTHgtG3nPXdGOTZhQM9R/u2/XlTQy5Krq7yfj9iB
 2R+4eVZdjdlUopYfVI7nTo469sEQJZDw57XwiJsmPNU9oplKT2OqIxORcEfxltctemSM
 JLU96l2bG9lEMRTBedA4cz4blbj3O3+aEkuOzkuKqle/Lw+EhMSuwzCLUhgln47Ooh1j Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382t5dre8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 15:43:26 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LJYA2I070778;
        Wed, 21 Apr 2021 15:43:26 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382t5dre82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 15:43:26 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LJgqIt000835;
        Wed, 21 Apr 2021 19:43:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 37yqaa4eea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 19:43:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LJhNBe35193192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 19:43:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C671078064;
        Wed, 21 Apr 2021 19:43:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11C477805E;
        Wed, 21 Apr 2021 19:43:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 19:43:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/2] certs: Trigger creation of RSA module signing key if it's not an RSA key
Date:   Wed, 21 Apr 2021 15:43:18 -0400
Message-Id: <20210421194319.1489291-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421194319.1489291-1-stefanb@linux.ibm.com>
References: <20210421194319.1489291-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LEuJPpd0w_snlpOkuyWEx9ZropaQLhKh
X-Proofpoint-ORIG-GUID: -beDMgqUMY5qK98S6rJi24SfJewbRKPC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210134
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address a kbuild issue where a developer created an ECDSA key for signing
kernel modules and then builds an older version of the kernel, when bi-
secting the kernel for example, that does not support ECDSA keys.

Trigger the creation of an RSA module signing key if it is not an RSA key.

Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 certs/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index e3185c57fbd8..f64bc89ccbf1 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -59,6 +59,11 @@ silent_redirect_openssl = 2>/dev/null
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
+
+X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+
+$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
 	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
-- 
2.29.2

