Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB33B44397D
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Nov 2021 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKBXUt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 19:20:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231721AbhKBXUt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 19:20:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Mpghc008803;
        Tue, 2 Nov 2021 23:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=RDJRwC+0vwi0IWPk8sxZOedXIfXYSvbpFvdGULY4QgA=;
 b=nI5qQUpkrg39mUpFNr7gKqFL9DCe63qyK82C6+a16aWp/PT5wVST88mjNgo6QRCRX4nd
 6/RGEEdjbu8ipgKpi8bAlAYgf+RPblT1lKwR7dYdEIhX4jzHyv5GJmJwQx1J/TG6iNZr
 hrAWJCIM7SAj7H3OT+7NRu6dlbQ97AMQm64SE0IYe0VtMWUs7MD1qJO7aIELHyejRkdK
 tK+Diy66JxuSExFCglm4QaxFDfphjWIFziYVWdt3rPKhsA4bR3C7MtwAOnAszXO/HBPM
 odEsJcDk0sIU6K4oYFyIXjtdqE7U/9AsbU3LUI5766DtV0m4uqv8cgpY2xJF2VdCkkLJ 2g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3eg9rd7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 23:18:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A2NDV3G019367;
        Tue, 2 Nov 2021 23:18:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3c0wp9qxe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 23:18:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A2NHxjf65863998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Nov 2021 23:17:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5468B4C04E;
        Tue,  2 Nov 2021 23:17:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAF4B4C040;
        Tue,  2 Nov 2021 23:17:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.38.118])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Nov 2021 23:17:58 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH ima-evm-utils] travis: use alt:sisyphus from docker.io
Date:   Tue,  2 Nov 2021 19:17:42 -0400
Message-Id: <20211102231742.191215-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TqSkybsqKva7BRu2zgcC72rc6nIClrKk
X-Proofpoint-ORIG-GUID: TqSkybsqKva7BRu2zgcC72rc6nIClrKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of returning an image, it prompts for a response.  Hardcode
to use docker.io.

 Please select an image:
  ▸ docker.io/library/alt:sisyphus
    quay.io/alt:sisyphus

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 42853e16bfee..3836befe0bae 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -68,7 +68,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
+          env: REPO="docker.io/library" DISTRO=${REPO}/alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
           compiler: gcc
 
 before_install:
@@ -92,6 +92,7 @@ before_install:
     - $CONTAINER build $CONTAINER_ARGS -t ima-evm-utils .
 
 script:
-    - INSTALL="${DISTRO%%:*}"
+    - INSTALL="${DISTRO#${REPO}/}"
+    - INSTALL="${INSTALL%%:*}"
     - INSTALL="${INSTALL%%/*}"
     - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ "$COMPILE_SSL" ]; then COMPILE_SSL="$COMPILE_SSL" ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
-- 
2.27.0

