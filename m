Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17F5B7EFF
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiINCaZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiINCaV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D24456C
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:20 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2N9pe027474;
        Wed, 14 Sep 2022 02:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rYx+eMoMXrV5E44DACZM2X+Jbq59hAzPBtDTSrz0EQs=;
 b=g0hObpNQGYOHKb2or1FDrO3wE8zOngoV7DRmkM+WD4+/0Nw5R0voVQ+o+DClX7tq+KdY
 9D96oXdd3i8hFGdz7t1b/RIJbK4JZoa+z/fjF9upTbsIWvN9or+/CLysbcJhhocndLNx
 +kblsTMDkTgGN+xeAebQz/QKuq/bv72JwTIp4wz1n5IeE9fTg1p26d6JpLKpiaJmSjlq
 0RMnhFtOaSbFvjzRGiT6t+eo0x1H2qPc72nxWwo3oq4Dzwf47/Db/7/Dp6eR5aD8dPI+
 FKC2xA0ykk13kIT9bDEgPqeEl9TnjGLkfZ+A7qhNcMz73hYcXUqhQlHgwcW3pn5Vr22X RA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk64jr4bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:16 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2L6m7001677;
        Wed, 14 Sep 2022 02:30:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3jjy2n08wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2UBtr36045082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73D1BA404D;
        Wed, 14 Sep 2022 02:30:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27EFA4040;
        Wed, 14 Sep 2022 02:30:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 11/15] Limit configuring OpenSSL engine support
Date:   Tue, 13 Sep 2022 22:29:52 -0400
Message-Id: <20220914022956.1359218-12-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NIYCWCptoFc1Iu1AB2l8ikGzVE1lv0L7
X-Proofpoint-ORIG-GUID: NIYCWCptoFc1Iu1AB2l8ikGzVE1lv0L7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=926 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If either OPENSSL_NO_DYNAMIC_ENGINE or OPENSSL_NO_ENGINE is defined,
ima-evm-utils cannot be built with OpenSSL engine support. Disable
engine support.

Suggested-by: Vitaly Chikunov <vt@altlinux.org>
Fixes: 9e08e4495f24 ("Disable use of OpenSSL "engine" support")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/imaevm.h b/src/imaevm.h
index ebe8c20d566a..8114bd051514 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -52,6 +52,10 @@
 #include <openssl/engine.h>
 #endif
 
+#if defined(OPENSSL_NO_ENGINE) || defined(OPENSSL_NO_DYNAMIC_ENGINE)
+#undef CONFIG_ENGINE
+#endif
+
 #ifdef USE_FPRINTF
 #define do_log(level, fmt, args...)	\
 	({ if (level <= imaevm_params.verbose) fprintf(stderr, fmt, ##args); })
-- 
2.31.1

