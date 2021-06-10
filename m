Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8668B3A2C23
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFJM6f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 08:58:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38492 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhFJM6d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 08:58:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ACWvS3180187;
        Thu, 10 Jun 2021 08:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1wKWoo6cCENuRfrqIdk6WSaZZUuuY4Kp8L3U5x1UajQ=;
 b=L/B0c4CJHOoWxSNwmV/24eaGMFtaftr3hf7y40PFCIZytNAowwo7NhJC42vVAYJtLp88
 sVS+obP6A7YUgTf9aNU94H04PEBtyA9lUNzpp/q9bD6IvfW07i7sc7rOa3FooeZBh5wc
 yPGPHJ1D9NJsY4QMp4Bn9lDqifUZDT91f+M9/fTAqyut32i/yLBC+bHUfLa1b/GlmK+c
 aRPJJY5p/15vvlIRcrkOmtbDffbVvxgfjVsioPcBitCe3meXnfPF/YSsDTg+ljqZLJnR
 LonO7dcfcQ1xX9CnrF9hZ1w7hAiUHDe5yOop/75MKCLrkQsz+ykFWKUA4QPuvouckwyf Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393hsvappj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:32 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ACrfl7072425;
        Thu, 10 Jun 2021 08:56:31 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393hsvappa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:31 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15ACfYC9026623;
        Thu, 10 Jun 2021 12:56:30 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3900wa84r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 12:56:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ACuUJ333685914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:56:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25E90112063;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CCB3112069;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 1/4] certs: Trigger creation of RSA module signing key if it's not an RSA key
Date:   Thu, 10 Jun 2021 08:56:20 -0400
Message-Id: <20210610125623.1553792-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610125623.1553792-1-stefanb@linux.ibm.com>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gNRJPDoszee6fMk69DJPZAlRROoEpDGQ
X-Proofpoint-ORIG-GUID: JNz6klALm0oXri6Myg64lLg80PVM_tLI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address a kbuild issue where a developer created an ECDSA key for signing
kernel modules and then builds an older version of the kernel, when bi-
secting the kernel for example, that does not support ECDSA keys.

Trigger the creation of an RSA module signing key if it is not an RSA key.

Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 certs/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index 359239a0ee9e..e6f97c64aa99 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -62,6 +62,11 @@ silent_redirect_openssl = 2>/dev/null
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

