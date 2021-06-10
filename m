Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAC3A2C28
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhFJM6f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 08:58:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230035AbhFJM6d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 08:58:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ACY9ce104269;
        Thu, 10 Jun 2021 08:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tGONxhLjDAYs/6zCGr4HYYX3fKu1/yEUWmmgvHLOcAg=;
 b=MVVTegJJfDTdpEcqvG1v3El7fOvUQL8ivjjx3n8RWH4a2TDbjzqVLShvAsgUDIhJcfDT
 ZVR7AKbziU4UDNqzRL14ejJSmJvHstdqrMjqvNtDFk5O+Y6vO8o90Kld0yX05JgTqv8z
 uqWQzPeTwGSPWCk5D2appNolri66yuvEIWriXbbj4Dq32hVnrXJXe27rDptIEHaoxdCY
 O2fmyi0rR5QIpaGlK7zDXRbA/oT2sunjld2H9m0P18g7UfgoqeMOsSW0XZsBkFHJ2yUn
 sKLgMmbmsYHnItr2O3NzngAcbWRjx9JjEJzOlQANMMbqcgQLGCzaksPpvA8T5HqfWiAu 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393j8f9tjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:32 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ACY9IB104320;
        Thu, 10 Jun 2021 08:56:31 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393j8f9tjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:31 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15ACg81g012813;
        Thu, 10 Jun 2021 12:56:30 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3900wa03kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 12:56:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ACuU0i27853252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:56:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35568112069;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A2A112070;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 2/4] certs: Check whether openssl tool is available
Date:   Thu, 10 Jun 2021 08:56:21 -0400
Message-Id: <20210610125623.1553792-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610125623.1553792-1-stefanb@linux.ibm.com>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q3E0JXCRfXGW-7q-3LucS9romAumJaId
X-Proofpoint-GUID: JLZgg1-yHBHmXOJ_hsqX8S54moshkIX9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To avoid a good key from being removed because the openssl tool is
not installed and 'openssl x509' is not returning the expected result,
run the openssl tool commands only if the openssl tool is available.

Fixes: 	ec739868f340 ("certs: Trigger creation of RSA module signing key if it's not an RSA key")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 certs/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/Makefile b/certs/Makefile
index e6f97c64aa99..72758684d254 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -57,15 +57,18 @@ endif
 redirect_openssl	= 2>&1
 quiet_redirect_openssl	= 2>&1
 silent_redirect_openssl = 2>/dev/null
+openssl_available       = $(shell openssl help 2>/dev/null && echo yes)
 
 # We do it this way rather than having a boolean option for enabling an
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
+ifeq ($(openssl_available),yes)
 X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
 
 $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
-- 
2.29.2

