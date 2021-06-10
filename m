Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEA3A2C1E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJM6d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 08:58:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230130AbhFJM6d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 08:58:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ACWr2o020400;
        Thu, 10 Jun 2021 08:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6hcqpZmbqGkh/Wbu9IyTP+ZdD6XtxPx/JI0/Ns9bKB0=;
 b=S8UPzLyKB7mKM/sa1lLQJa9Hpjw05T7JBszjxAZbJfVX6y2D5dNJBxA1XxeTu+W+6iEI
 mH+rsvenH0s1oTzGS4UfHh7l/TAyOJ29e1IK3AeLIjQwj/q9lew0MrOmPEkIyduNe9Zz
 b6U6DU1aVCvCk0uf+5Y+R6cQEl7wkVbHAYUVhhMH1oP5f86fUt2yQ2V5ktHmHibDGPmu
 yvrG8+TNpWjpd4MaVA1FuUrPra2wnyyvF1oDyBx2XnUSipDagv5S6BsxGpqKOSbS+M5g
 0RaEkafKPHL4Pi9jYjAdudGFxhYaj1kTVr0sB+oaikFAG+p8lbnJtr0Umc1xLOOvmC/F dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393c0j4upf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ACXDMH021395;
        Thu, 10 Jun 2021 08:56:32 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 393c0j4unt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:32 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15ACh4bj018730;
        Thu, 10 Jun 2021 12:56:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3900w9g3aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 12:56:31 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ACuUO634668986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:56:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D7A5112061;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502DE112076;
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
Subject: [PATCH v6 4/4] certs: Adjustment due to 'Check whether openssl tool is available'
Date:   Thu, 10 Jun 2021 08:56:23 -0400
Message-Id: <20210610125623.1553792-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610125623.1553792-1-stefanb@linux.ibm.com>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZjGQh3ZNuWiQW_XywyZqXzyFatjVnO6c
X-Proofpoint-ORIG-GUID: CHkVhbHIO1G37qwAf6c9Jyt7aEvwU0Zn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adjust the previous patch due to fixes applied to the first patch
in the series.

Fixes: 46449892e6e5 ("certs: Add support for using elliptic curve keys for signing modules")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 certs/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index dc9f354dd5f8..4eb69bdadc79 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -66,16 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
 ifeq ($(openssl_available),yes)
 X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+endif
 
 # Support user changing key type
 ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
 keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
+ifeq ($(openssl_available),yes)
 $(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
 endif
+endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
 
 ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
+ifeq ($(openssl_available),yes)
 $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
 endif
+endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
-- 
2.29.2

