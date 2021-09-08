Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF8403FC4
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbhIHTY4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233179AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J3XhR170657
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K08/ckWpEcHHVwgjIjT9MU57Sag0QIPYH2OWnCjJWUU=;
 b=VZ9MX59BjGmAn7xjWQhHReH5bK0DunpNDiFMdp2xL8NhOGelfEOBvhJSAa8Y8y6oU5Kt
 /ouho8C4Y+GZKuUszy5+FRIO06mBVguLcBqyIp1Mh7oYJVZwO/KlneFIHYnZJxBgcjLv
 iVAtNLSdGuLbnzzot7FFfF0M+0UHiOo7eJCOGme8iwkdJY7W2kI4XB4nESTA/x7sNn3X
 oEDKYS2quagN8MFimR9LxyE8BBr8azN8kJQX85MpksGHXeO4GjDal/qh8/p7NiJFv1mE
 nPxirOosGVprnac1RY1e+59jmfP3z1jQB/Or6f0rq4PAQlMuyvLnJz4ftDju/NunwG+v pQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3axyvc5nkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI616022347
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3axcnnbfmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjxp8389502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E358112066;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A3011206F;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 5/9] evmctl: use the pkcs11 engine for pkcs11: prefixed URIs
Date:   Wed,  8 Sep 2021 15:23:39 -0400
Message-Id: <20210908192343.4147739-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IgT_kHOL_Enu5pFx1tW4w8uARLF4VyXl
X-Proofpoint-GUID: IgT_kHOL_Enu5pFx1tW4w8uARLF4VyXl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=635
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

If the key has the pkcs11: URI prefix then setup the pkcs11 engine
if the user hasn't chosen a specific engine already.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 625a511..5178643 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2827,6 +2827,14 @@ int main(int argc, char *argv[])
 	if (!imaevm_params.keypass)
 		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
 
+	if (imaevm_params.keyfile != NULL &&
+	    imaevm_params.eng == NULL &&
+	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
+		imaevm_params.eng = setup_engine("pkcs11");
+		if (!imaevm_params.eng)
+			goto error;
+	}
+
 	if (argv[optind] == NULL)
 		usage();
 	else
-- 
2.31.1

