Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BDA3695D2
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Apr 2021 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhDWPNe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Apr 2021 11:13:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242829AbhDWPNd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Apr 2021 11:13:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NF3nNB176430;
        Fri, 23 Apr 2021 11:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=LG6EJsspN0xFsaGsQWZaOBJblkgxt0683z6zahBn1As=;
 b=Vg3wdxbZPJATu36lQ+rc8Dfn9SRTRaNw+BiRCbOpKS//406+oNsUIwO+OcLGWiagrtHD
 z/OVBqVY7YGGW4pyjoQsio1NzbZ9/Kszkp4YMUjNZjmkRuRjvCZMX6NjJGs0IC4V3cc/
 TMGsvxDTNVT29IVvwSuKbKIKdwC+YoFU/Zz1tzy4ABZtQmfsvJNp0nxfzmhXbIYH1Tz2
 0j/bUwEsVViIKGeQI0lWev7S81yj5ZspeBFYRvE4om/2DTpRQkoJUk64RJRUyb806snJ
 KfXmiJE6QlIJPKMgiUlE1lqoLfTXoNuPmug9aD94iUY8VPi3H0U5i4fxpiVwQMfNfDfw nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3838hmdfxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 11:12:55 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13NF4BJ0177686;
        Fri, 23 Apr 2021 11:12:55 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3838hmdfx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 11:12:55 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13NF8vf9022737;
        Fri, 23 Apr 2021 15:12:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 37yqab608a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 15:12:53 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13NFCqQ149742162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 15:12:52 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02ACA6A047;
        Fri, 23 Apr 2021 15:12:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE3E6A054;
        Fri, 23 Apr 2021 15:12:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 23 Apr 2021 15:12:51 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 0/2] Add support for ECDSA-signed kernel modules
Date:   Fri, 23 Apr 2021 11:12:45 -0400
Message-Id: <20210423151247.1517808-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7G0SZ7zPPPMVkRFCz80gYPxP2DwOK-1v
X-Proofpoint-GUID: GoWDdKadZhkikM8HM_GKK1gFsB5YXfB4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series adds support for ECDSA-signed kernel modules. It also
attempts to address a kbuild issue where a developer created an ECDSA
key for signing kernel modules and then builds an older version of the
kernel, when bisecting the kernel for example, that does not support
ECDSA keys.

The first patch addresses the kbuild issue of needing to delete that
ECDSA key if it is in certs/signing_key.pem and trigger the creation
of an RSA key. However, for this to work this patch would have to be
backported to previous versions of the kernel but would also only work
for the developer if he/she used a stable version of the kernel to which
this patch was applied. So whether this patch actually achieves the
wanted effect is not always guaranteed.

The 2nd patch adds the support for the ECSDA-signed kernel modules.

This patch depends on the ECDSA support series currently queued here:
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc

  Stefan

v4:
  - extending 'depends on' with MODULES to (IMA_APPRAISE_MODSIG && MODULES)
  
v3:
  - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
  - added recommendation to use string hash to Kconfig help text

v2:
  - Adjustment to ECDSA key detector string in 2/2
  - Rephrased cover letter and patch descriptions with Mimi


Stefan Berger (2):
  certs: Trigger creation of RSA module signing key if it's not an RSA
    key
  certs: Add support for using elliptic curve keys for signing modules

 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 48 insertions(+)

-- 
2.29.2

