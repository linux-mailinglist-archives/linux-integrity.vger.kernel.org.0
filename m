Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD895B7F00
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiINCa1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiINCaW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C145057
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:21 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E1qitf006698;
        Wed, 14 Sep 2022 02:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1B+UvNZ3diN79woVNl/H/fdOz1YLNIgz4tJ2otKm5MY=;
 b=pn+99wx2tewkw0zZS57+XITxywa2XG66R82aZGrtlKFpqCNkneXTisjOFSi8LAKQ45OS
 kJeH1wHvtdXlSD7Dulm0UyAZEuAxKfRC0hQ7RJUA9QxblODZibCcaJwoZOZfI9QVEHqY
 1L4Qd+fsncBuAu8raHOUrfoGUIn7E7ekxfD6VIa/eoVBCfYCUkfZOE8C2wvBrhFGz9Rn
 kzwc/GfcTIWiNO9ia9mGp/fKU6wVZJ/Q1ZAGaBSGNOm4Mepxlhfvn9ZhNHjWtOoCTWyv
 FXpt2uz/1pS18hSd6nKbgfV60L2crCiVBz61uu2Oykpv2Cy/TKJcNidEGJKgGgTiLAr2 ng== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk5pa0x1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2KgRO025255;
        Wed, 14 Sep 2022 02:30:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3jjy95rbv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2UCYL41091336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6378AA4051;
        Wed, 14 Sep 2022 02:30:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A25F1A4040;
        Wed, 14 Sep 2022 02:30:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 12/15] Base sm2/sm3 test on openssl version installed
Date:   Tue, 13 Sep 2022 22:29:53 -0400
Message-Id: <20220914022956.1359218-13-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b3rPJ_dSsJrKRMkHAUZGY-Zsc7jCAKD6
X-Proofpoint-ORIG-GUID: b3rPJ_dSsJrKRMkHAUZGY-Zsc7jCAKD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
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

Since the distros are now shipping with OpenSSL 3, no need
to build it.  Limit the sm2/sm3 test to OpenSSL 3.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/sign_verify.test | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 6839896aa04b..3b3c9d792311 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -414,8 +414,8 @@ sign_verify  prime256v1 sha384 0x030205:K:004[345678]
 sign_verify  prime256v1 sha512 0x030206:K:004[345678]
 
 # If openssl 3.0 is installed, test the SM2/3 algorithm combination
-if [ -x /opt/openssl3/bin/openssl ]; then
-  PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib \
+ssl_version=$(openssl version | sed -e 's/^OpenSSL //' | sed -e 's/ .*//')
+if test "${ssl_version::1}" = "3"; then
     sign_verify  sm2    sm3    0x030211:K:004[345678]
 fi
 
-- 
2.31.1

