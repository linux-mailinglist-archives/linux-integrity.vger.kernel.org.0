Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C061530B
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKAUSi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKAUSg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EEB1C41F
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:34 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1IZAgP004475;
        Tue, 1 Nov 2022 20:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jRM5C1NeOZvP42k45v2YQGrwek8DhutKwpjEfEKWsOE=;
 b=nGx38y2z2jYy2xm65/ZClJfeWAxEEOfDlO+ZMNk0/qbbsIubDTuJA88E/IWeG8M0CNds
 fc5V/EjMlNr4IljQZnZQoEkhzUV1VmQ1Bso9if58gtlQbRxGSzlL+cOGmS6R4NvemHJR
 Hn0ozWpyfiH/zjYbCTTtlrtPZF7578c3B9Fw/40PuuKM7LFFLMnCw5+xHDz2MN8wmUEE
 /mbKO3n97pkZuQA8RoGb5x8n/OXJ9IAPitYVz0FfItIFtgjGYdT2YJyhvCE44mYpEvwd
 8vDadOe1RUa4blMoT5hnFu9voVJEXQ+pOH1moA90+OCDdqUJLw3KvxqiUXDuG+9qjjrS rg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtw3g4ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:29 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K6aZ9009317;
        Tue, 1 Nov 2022 20:18:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3kguejbx1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KCtsV46203376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:12:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C0A9A4054;
        Tue,  1 Nov 2022 20:18:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83476A405F;
        Tue,  1 Nov 2022 20:18:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:23 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 17/17] Fix d2i_x509_fp failure
Date:   Tue,  1 Nov 2022 16:18:03 -0400
Message-Id: <20221101201803.372652-18-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9HCeWilXEIbZ2M1irwh0q-OaQ1qkz9Hw
X-Proofpoint-GUID: 9HCeWilXEIbZ2M1irwh0q-OaQ1qkz9Hw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=943 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Before calling d2i_x509_fp(), make sure the keyfile is a regular file.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 8070ffd61a2c..e6fbec5bc17b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -250,6 +250,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
 	EVP_PKEY *pkey = NULL;
+	struct stat st;
 
 	if (!keyfile)
 		return NULL;
@@ -262,6 +263,16 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 	}
 
 	if (x509) {
+		if (fstat(fileno(fp), &st) == -1)
+			goto out;
+
+		if ((st.st_mode & S_IFMT) != S_IFREG) {
+			if (imaevm_params.verbose > LOG_INFO)
+				log_err("Keyfile is not regular file: %s\n",
+					 keyfile);
+			goto out;
+		}
+
 		X509 *crt = d2i_X509_fp(fp, NULL);
 
 		if (!crt) {
-- 
2.31.1

