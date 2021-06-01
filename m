Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F33971E2
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhFAKzF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 06:55:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230282AbhFAKzD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 06:55:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151AY1Qi134439;
        Tue, 1 Jun 2021 06:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6bdOwxmqLs8tqvRTEVNLYQUYNmHgFhy//nAudow78jg=;
 b=XDxfjjwoCE7adzCrdUCk6zHf9dXlwHQthLaR58VUKT53cIbC0IM9dEDYSVt6na99owOE
 4GxUO8Lqu/TK4mK8rj4Zigw4lKXSpDm/fhuYi8l2bIN6oxYW+Sfnhhfudcc44hTlEgC1
 //mG+VyhshyOSyvxanJILe5SgbBXqYJ+QMYbpkB1/XzyUnW9k1YL3VsRXN3kmLjR+2Dp
 SU3ArFC3rHQcxUoQAPHelEMYi9oghDrjEPFhC2XJ6oNq2SX7MB4DxiTtmMu32IBBkuRm
 wr4Ne/MKGgwntgI7rWlUvKllIYTlBmuuXtXjoAh3yN595TdwEN8a0/YnPA7i/leSY0DH Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38whgm3ef4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:53:18 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 151AY9UB135719;
        Tue, 1 Jun 2021 06:53:17 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38whgm3eey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:53:17 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151AbHpi002661;
        Tue, 1 Jun 2021 10:53:17 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 38ud88xane-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 10:53:17 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151ArG8t17432978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 10:53:16 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D54C124054;
        Tue,  1 Jun 2021 10:53:16 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84536124058;
        Tue,  1 Jun 2021 10:53:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 10:53:16 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 1/2] certs: Trigger creation of RSA module signing key if it's not an RSA key
Date:   Tue,  1 Jun 2021 06:52:44 -0400
Message-Id: <20210601105245.213767-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601105245.213767-1-stefanb@linux.ibm.com>
References: <20210601105245.213767-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vrrqEh-5TpUQaLWVb-QHrb4VIsKDhYpr
X-Proofpoint-ORIG-GUID: nzA2NzxTjVXI0es8G73kV7rU33k1wxdK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010071
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

