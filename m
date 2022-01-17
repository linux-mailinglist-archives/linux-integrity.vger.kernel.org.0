Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7949121C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 00:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiAQXDG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jan 2022 18:03:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbiAQXDG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jan 2022 18:03:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HKTEGj010709;
        Mon, 17 Jan 2022 23:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=M7BMP24y1cQ28K7PlH8TJ6wkIn7xRBvGLBDOYJ3A/m0=;
 b=I4GTfaboWlND4IHEFCKiX+teaqPmKiOnvtCU9fEJ3m2Zn3s7B13FJKun56NBvySEsbG4
 saecKj5vpcVRMWzvJoOwn7TtCT+78moQ8NEUiccXKBNHn8v8Qp0OKF317UJQbXJgifO9
 53jvh6rNXJCNTIJ0Yi+ATi1w0MmsknllwLb2tAof+VNHl2zxtjo/W7WetM+3n3BX50YE
 9ozlrCO8HZFrl2+I33vzGSu8FajP1nsLwh06uL3K+PFP1dHOG+s+H2quSwW/a4pLSjVw
 duv4+VJov0ctPDjjwXBwEjLsC+6K+ZR7ul5ZAHZR8TlBkn5YevZCmZpGz+K0m+ysxonD pw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnfhe2phr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 23:03:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HMvLsw014269;
        Mon, 17 Jan 2022 23:03:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhj7hb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 23:03:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HN2wTD45351420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 23:02:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D30FFA406B;
        Mon, 17 Jan 2022 23:02:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08282A4067;
        Mon, 17 Jan 2022 23:02:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.85.218])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 23:02:57 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add missing "security/integrity" directory
Date:   Mon, 17 Jan 2022 18:02:29 -0500
Message-Id: <20220117230229.16475-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6xPCtEPtag_9tqrfPy5id-62z4Dor_tX
X-Proofpoint-ORIG-GUID: 6xPCtEPtag_9tqrfPy5id-62z4Dor_tX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=839 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update the IMA and EVM records to include the "security/integrity"
directory.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5250298d2817..a9973d0991e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7181,6 +7181,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 F:	security/integrity/evm/
+F:	security/integrity
 
 EXTENSIBLE FIRMWARE INTERFACE (EFI)
 M:	Ard Biesheuvel <ardb@kernel.org>
@@ -9419,6 +9420,7 @@ L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	security/integrity/ima/
+F:	security/integrity
 
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
-- 
2.27.0

