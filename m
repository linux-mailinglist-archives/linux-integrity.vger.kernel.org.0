Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331116152FE
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKAUSZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAUSX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E96D111F
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:22 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1K6Lar007939;
        Tue, 1 Nov 2022 20:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Y//fm9Dgzbk+PFjbKzqhMOboUHD60qTJUUpmKo88SPU=;
 b=Hve4fS/j1WF/6KP6zJSqNW3GEjIYAfkeK2ge3UYhDxM3ulVg/m3bBzOdVlPmWKoVtfg9
 8BjNl2B/BwAXjdh+b35bt/7y4e/GCvGJXkN+8I6K6DcWmn+ohQfSWCBHz12/8y0t29rQ
 WDdjZYqtkG5PwPsvgLXZN1LscFoqFW4OTe6wUyJn8hCaDygngkrYfN42Yy5znW+R1Gvd
 NqG4/eOwulQDpPRrSQ7AxLzVjlbY1R7s3x7c5aCGPlbYoo/ufCwPFdx5uOf4HFgAzxL1
 Ul5Ntr+BB9ML1ccFOFLnK/f1Swf3dCJBqQ9JRNzLZqrLBIW65g0UKqDlVSb7EaTVc5xr Xw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjufh6rfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:17 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K6dvZ009325;
        Tue, 1 Nov 2022 20:18:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3kguejbx0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KIBvo4326110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD132A405B;
        Tue,  1 Nov 2022 20:18:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0388CA4054;
        Tue,  1 Nov 2022 20:18:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 04/17] travis: update dist=focal
Date:   Tue,  1 Nov 2022 16:17:50 -0400
Message-Id: <20221101201803.372652-5-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8viia0eN4Y2jN-4wQwTD2kg-hJPQzXpz
X-Proofpoint-ORIG-GUID: 8viia0eN4Y2jN-4wQwTD2kg-hJPQzXpz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Although Github Actions is available on Github Enterprise Server 3.x
single server edition, as well as the unpaid version, it is not
available in Github Enterprise Server 3.x cluster edition[1].

Continue updating travis.yml.

[1] https://docs.github.com/en/enterprise-server@3.0/admin/release-notes#github-packages

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5741116e418a..edd2a21b83d3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,6 +1,6 @@
 # Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
 
-dist: bionic
+dist: focal
 language: C
 services:
     - docker
-- 
2.31.1

