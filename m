Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC13398D2C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jun 2021 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFBOhz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Jun 2021 10:37:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230246AbhFBOht (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Jun 2021 10:37:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152EYRKN180000;
        Wed, 2 Jun 2021 10:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yzKYYNpLgG6WmVN4s1YaU80LkoAUSa953OPh2XdLe3o=;
 b=pKC924DBY6ItA5zT30vrxs989JmgQ4ZoM76kZeNUs9fQA7ayj0FX4m+wK6IkDV3j74Iy
 JrMWxybNP2zsRYynNmXONLLBnTUCodFIsUm6SlQCooJGNF+GvWzVLnIrNmpwKYU9C4jz
 Khdue9+CaPl684EWQDZ5pp530phMSEhPbxcBfxLHk9yODSUTuVuZ261XtrTTn1oUo3gu
 hrQ04p6ZAtzhLNqnxbnXhtZMoQN12Ph9KgJpIlT7PFUihM3lLyGqSHY8vgZdmlzl3+Bf
 8kFq2Trqon4X6Lp0EEajdEaplSra4McWD4H1WFCPaQ6dEGz1DrFU2zO1DSPdja4Q4j9N 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38xbpdgcm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 10:35:56 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 152EYVGE180733;
        Wed, 2 Jun 2021 10:35:55 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38xbpdgckr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 10:35:55 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152EWjXt028477;
        Wed, 2 Jun 2021 14:35:55 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 38ud89r65f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 14:35:55 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152EZsDK6554052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 14:35:54 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9277E124052;
        Wed,  2 Jun 2021 14:35:54 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8373312405B;
        Wed,  2 Jun 2021 14:35:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 14:35:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 1/2] certs: Trigger creation of RSA module signing key if it's not an RSA key
Date:   Wed,  2 Jun 2021 10:35:36 -0400
Message-Id: <20210602143537.545132-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143537.545132-1-stefanb@linux.ibm.com>
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4VDGT5O215iy2H-2IdxaSy1f5KpVy-lN
X-Proofpoint-GUID: fonAFhyLmM8nqiBDPD27yIE5sMjaIEHD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_07:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106020095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address a kbuild issue where a developer created an ECDSA key for signing
kernel modules and then builds an older version of the kernel, when bi-
secting the kernel for example, that does not support ECDSA keys.

If openssl is installed, trigger the creation of an RSA module signing
key if it is not an RSA key.

Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 certs/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index 359239a0ee9e..72758684d254 100644
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
+X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+
+$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
+
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
 	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
-- 
2.29.2

