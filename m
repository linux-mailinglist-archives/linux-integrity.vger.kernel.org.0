Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7A461530A
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiKAUSd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKAUSb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B113F28
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:31 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1J0Pmp018968;
        Tue, 1 Nov 2022 20:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=06xxS+0mkUWYwuTg+FX2TvF2vVdBzvO5EaGFsX/SdVw=;
 b=ZioQFHrpfOwAA4zaxsskhVYkEGVLDP4uxqTtIf2aJl7/lGl8rJLu3ba+qussKrpRxo2n
 tNnhgl55Ph29g35y+9xDf2N6uL9Ha/u5Y4YJlVhTYeN5XQn7w7KCbi7Syw63/OLAEHtD
 K/vs5Z+l3ZLbya1WyfFNI+BjgH1WOTKDv2SSTNHWC/SZcJ+aEW2mzf/OoeICqf8mCD96
 uZOFIGsMF0W9eWwnCdD7fgqf2uaUTZlUUkP4Begf/JBoOrXfJLl3GRbloxmmyP2Kc3I/
 W5ufbEh2dT41opChgwVRlpYWTmUGoyFxeNwl8/+08wvZTY8S+1dWVOYxeyjHfDmaaeCX yg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjvbhd7x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:26 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K6aZ8009317;
        Tue, 1 Nov 2022 20:18:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3kguejbx1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KILqK6423102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CA00A4060;
        Tue,  1 Nov 2022 20:18:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7E8BA4054;
        Tue,  1 Nov 2022 20:18:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:20 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 14/17] Base sm2/sm3 test on openssl version installed
Date:   Tue,  1 Nov 2022 16:18:00 -0400
Message-Id: <20221101201803.372652-15-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cxDkxJc4PrVA1ZSGmYLC1CGrpH0s81Pv
X-Proofpoint-ORIG-GUID: cxDkxJc4PrVA1ZSGmYLC1CGrpH0s81Pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 3e9548e1aeb7..ed95f6955dc1 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -416,8 +416,8 @@ sign_verify  prime256v1 sha384 0x030205:K:004[345678]
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

