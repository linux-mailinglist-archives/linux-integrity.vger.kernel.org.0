Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9363E5C14
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbhHJNqZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240192AbhHJNqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADYXnb023533
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K08/ckWpEcHHVwgjIjT9MU57Sag0QIPYH2OWnCjJWUU=;
 b=pC1fGSmKCTf9F9x2BiBeKkY96OM8VEZovzF5GKmjQWgShdg0dzYNOj+pS0KWy+a0yqLc
 AGJLER1znPbAqNOdCS1kq15PmV5KccIjgW5QG1SRia2wRxJCgpHAdNfnq2SYoJECH4wy
 Ije8+Gmtv8EW33mbzhLyMJvRNM3YO8CsD2rJGkezEJt6LGf3VIBWNoAez1hTSm6ZDgeA
 yb762w7/DJnAgiUXX4mZoJa5IWdK3b5jfhX361rGiv5zeMzLxp3MWFv+xQl7TiYJyz1F
 SeoN7dGivvtUputETrARa7NC404V2HbT0POmi9AoVa1SqRRl6HEIKJHWj4wUxwStNgtS ug== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abtf20bxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADhMxs030226
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3aapja1tfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxsF41943496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DD3FB2073;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EAA6B2081;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 5/8] evmctl: Setup the pkcs11 engine if key has pkcs11: prefix
Date:   Tue, 10 Aug 2021 09:45:54 -0400
Message-Id: <20210810134557.2444863-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lKpc6i7zbnjME401pxUF_oRKMhmRW9Xu
X-Proofpoint-ORIG-GUID: lKpc6i7zbnjME401pxUF_oRKMhmRW9Xu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=774
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100087
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

