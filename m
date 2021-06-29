Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8163B79EB
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhF2VhC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 17:37:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232997AbhF2VhB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 17:37:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TLYOiv085598;
        Tue, 29 Jun 2021 17:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zbIbzd8RSo5WOCO+UKbyaOeZQjs55ydSigpFHVyniHI=;
 b=a7MOy8k+NQ2VgFw8aIb1u8le868Od8nUj3azw6kPhjW5psEPgtiLHD1rZgGK5pJe+I6X
 ClCktWykjeqpGXof1ZBOVMx6094fkDhAndzGFlYHcj2blzRnzsiH+KU851kQNsYIg5N6
 urXf1aH4YwmL6vXA+3BE3KO/yqQhBOeykq5BK5ALjUCP2oR4hr8FYUB6iwZYKkg9PxHp
 pKYx/ksjBRYM4ViTfEdJxWbqlcnYLTJjlcWICnYQkF+Rq1kOEFiNAon1EHtzdIK0Ukyy
 5eMr/iGSD1NQ+aZLh+rF/mND28lqF16RxkIpjzkcnhrZ1zux8gz+nqeLCCR2cOebhBj8 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g88xd9jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:34:29 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TLYSG3085819;
        Tue, 29 Jun 2021 17:34:28 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g88xd9j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:34:28 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TLWUvR001514;
        Tue, 29 Jun 2021 21:34:27 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 39ejyye84u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 21:34:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TLYQIl39059782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 21:34:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAD21AC05B;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B15AC062;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 1/2] certs: Trigger creation of RSA module signing key if it's not an RSA key
Date:   Tue, 29 Jun 2021 17:34:20 -0400
Message-Id: <20210629213421.60320-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0dt8q5lR_zXzVg-QxDX2DgwVovdyGv0p
X-Proofpoint-ORIG-GUID: A4NkySaQ4YmB52qxDvZOtyEkJAZVOmar
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_14:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Address a kbuild issue where a developer created an ECDSA key for signing
kernel modules and then builds an older version of the kernel, when bi-
secting the kernel for example, that does not support ECDSA keys.

If openssl is installed, trigger the creation of an RSA module signing
key if it is not an RSA key.

Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 certs/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index 359239a0ee9e..f9344e52ecda 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -57,11 +57,19 @@ endif
 redirect_openssl	= 2>&1
 quiet_redirect_openssl	= 2>&1
 silent_redirect_openssl = 2>/dev/null
+openssl_available       = $(shell openssl help 2>/dev/null && echo yes)
 
 # We do it this way rather than having a boolean option for enabling an
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
+
+ifeq ($(openssl_available),yes)
+X509TEXT=$(shell openssl x509 -in "certs/signing_key.pem" -text 2>/dev/null)
+
+$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
+endif
+
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
 	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
-- 
2.31.1

