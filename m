Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84A3B432A
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhFYMbq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:31:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhFYMbn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:31:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCSbxq076036;
        Fri, 25 Jun 2021 08:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LgyT2UuERz+HsfYh6EJHEvZy771wAlhJKm1SJL+zg1c=;
 b=L9ix6Dego4ie/wIyEvDsfWYna4BTt5sBtvKac+Ciqmxinmb7YqGuRGQg2F2ijtpxHhvH
 qiyUVbeinXs1pm4cX8Afx/iR5IRvXTvI5MePQBonD5dzQXtzE4n10a4N8/b+czYpkxpx
 RJm9CmBXgcFBuYwAqWi2wxpwfCCClFYftKnOpyc06PvHs61rE/O1xxrCG4b08FklhaEZ
 EDRuRIK6Pyo+Kvaw9T54Yiey0lYABWf3JDkx8zUXJa8wpB9rtBOswszqgj3zsoY7WM1o
 MIlhhUGdQm3JblS1AIajs5ZO4OwtmAcx6EQfByRac3gD+byh3392GKc5N94i9WSS3OIX Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39dd1mvp35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:29:15 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PCTEDl078551;
        Fri, 25 Jun 2021 08:29:14 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39dd1mvp2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:29:14 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PCSh4K012512;
        Fri, 25 Jun 2021 12:29:13 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 39987a1qac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 12:29:13 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PCTCaA10486284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:29:12 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E701C6A054;
        Fri, 25 Jun 2021 12:29:11 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 359066A047;
        Fri, 25 Jun 2021 12:29:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 12:29:11 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, jeyu@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, Stefan Berger <stefanb@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] certs: Redirect openssl error message to null device
Date:   Fri, 25 Jun 2021 08:29:02 -0400
Message-Id: <20210625122902.4058783-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VcgJQX-aW_DkG0U2fP9QLrHKiAN8uoZg
X-Proofpoint-ORIG-GUID: HB9c8oRq-miZzOpg4R1fG1GMsaoGnoUr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_04:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Address the following issue detected by the kernel test robot when
there's no certificate file at the time when checking for the type
of key in the cert:

Can't open certs/signing_key.pem for reading, No such file or directory

The simplest solution is to redirect openssl's stderr output to /dev/null.

Fixes: 28d62d945ded ("certs: Trigger creation of RSA module signing key if it's not an RSA key")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 certs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Makefile b/certs/Makefile
index 72758684d254..e7ae3bd3be4a 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -65,7 +65,7 @@ openssl_available       = $(shell openssl help 2>/dev/null && echo yes)
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
 ifeq ($(openssl_available),yes)
-X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text 2>/dev/null)
 
 $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
 endif
-- 
2.31.1

