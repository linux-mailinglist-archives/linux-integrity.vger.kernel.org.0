Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1490628C559
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgJLXo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 19:44:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbgJLXo3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:44:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CNWodM039011
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UCCkSJI+dNHyVJU5jhqco7sxHNn9Fg86LCneSDJ50mk=;
 b=jx5hMYCY/aoS/rPSEf46qha3mnLKTCKfBGydGqFSVLyJUYg0p7mZkb4GrJtaOu0AXBjk
 k3odFTOz7VGVg9BNaOS1gxWUcZ56s2hNSffCdH3O1jJBWx+dZE9JRXfnctOo1AWm8r+b
 RWmJltjfZrDnkROYSny1u46NN6meioGVNZw9Mt/9Vd4SVHeDKyRfyptsjHGaLjYTqm3s
 +3Lmx1Iwg6Gg4YTytReyaXoKaQMHVqaADYFk0gITtS3pgy1J2GOv2pK4RoU8oOkAMCY1
 VphnWcna643X7EPF/cmCpV05inPfB3azB/NHMQkR+krtpsS1MUXiGOkTmycV4nOILPAv TA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3450nygdnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:28 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CNgWmb021799
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:28 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3434k901bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CNiRXR14549768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 23:44:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA82B2065;
        Mon, 12 Oct 2020 23:44:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB474B205F;
        Mon, 12 Oct 2020 23:44:25 +0000 (GMT)
Received: from eve.home (unknown [9.85.142.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 23:44:25 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v2 1/5] ima-evm-utils: Change env variable TPM_SERVER_TYPE for tpm_server
Date:   Mon, 12 Oct 2020 19:44:12 -0400
Message-Id: <20201012234416.20995-2-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012234416.20995-1-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120171
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default value raw is appropriate for 'swtpm'.  tpm_server
uses the Microsoft packet encapsulation, so the env variable
must have the value mssim.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
 tests/boot_aggregate.test | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 1c7b1f2..b109a32 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -35,6 +35,7 @@ else
 	export TPM_COMMAND_PORT=2321
 	export TPM_PLATFORM_PORT=2322
 	export TPM_SERVER_NAME="localhost"
+	# swtpm uses the raw, unencapsulated packet format
 	export TPM_SERVER_TYPE="raw"
 
 fi
@@ -73,6 +74,8 @@ swtpm_start() {
 			SWTPM_PPID=$!
 		fi
 	elif [ -n "${swtpm}" ]; then
+	        # tpm_server uses the Microsoft simulator encapsulated packet format
+                export TPM_SERVER_TYPE="mssim"
 		pgrep swtpm
 		if [ $? -eq 0 ]; then
 			echo "INFO: Software TPM (tpm_server) already running"
-- 
2.25.1

