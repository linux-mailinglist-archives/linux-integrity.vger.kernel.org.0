Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919E945CE5D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 21:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhKXUut (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Nov 2021 15:50:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235709AbhKXUur (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Nov 2021 15:50:47 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOKOpeg017746;
        Wed, 24 Nov 2021 20:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=A9bqNV1Jy3zIemg25SOA8ivP5X6E17/v2bKeKAuwHlM=;
 b=E/Aog28GYCWBW/Z+CXRAVgFW5JuMzck15BRE3ABOhqKVH2Z6hKi9b/QM8dCyJbVaW50G
 sUiIzVDpS6e3h0otQPA8xFTKnHJ1vkiwAI7PKXuZwpQ0je7BLGR4wWj/tTymDbjS3p8r
 DxeNmKnbvOeVPOeF9kZzZp8up2DsGZdL/eKodFfJ5YpZSyQ4QR1HArAW1A8j+qXAuX1C
 qxTCNMZIDPS4y5jy4pMMX7zeDi/1/DqB3O63ooG+wEczqjCiIwoJmR8AruoKDCnSvEU1
 kqmwOeP/Gf/UsqZkj+4o4Fot7J3n01jUiGYoyrS+d+Y5ZGa+Pik8pJxMSvqIb/O81epe oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chu00242k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 20:47:32 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AOKXEbi033083;
        Wed, 24 Nov 2021 20:47:32 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chu002423-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 20:47:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOKd1nV032104;
        Wed, 24 Nov 2021 20:47:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3cernadamt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 20:47:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOKlQX619464544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 20:47:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29FD552052;
        Wed, 24 Nov 2021 20:47:26 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.59.116])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF7075204F;
        Wed, 24 Nov 2021 20:47:22 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Seth Forshee <seth@forshee.me>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v5 0/2] integrity: support including firmware ".platform" keys at build time 
Date:   Wed, 24 Nov 2021 15:47:12 -0500
Message-Id: <20211124204714.82514-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bLgZ8gi3qI0QiBF3sOZZsJojyrtQw9a2
X-Proofpoint-GUID: vfQycDDeUUbr_gXLI41Z43iN6NcxGoEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some firmware support secure boot by embedding static keys to verify the
Linux kernel during boot. However, these firmware do not expose an
interface for the kernel to load firmware keys onto the ".platform"
keyring, preventing the kernel from verifying the kexec kernel image
signature.

This patchset exports load_certificate_list() and defines a new function
load_builtin_platform_cert() to load compiled in certificates onto the
".platform" keyring.

Changelog:

v5:
* Renamed load_builtin_platform_cert() to load_platform_certificate_list()
and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
suggested by Mimi Zohar.

v4:
* Split into two patches as per Mimi Zohar and Dimitri John Ledkov
recommendation.

v3:
* Included Jarkko's feedback
 ** updated patch description to include approach.
 ** removed extern for function declaration in the .h file.
* Included load_certificate_list() within #ifdef CONFIG_KEYS condition.

v2:
* Fixed the error reported by kernel test robot
* Updated patch description based on Jarkko's feedback.

Nayna Jain (2):
  certs: export load_certificate_list() to be used outside certs/
  integrity: support including firmware ".platform" keys at build time

 certs/Makefile                                |  5 ++--
 certs/blacklist.c                             |  1 -
 certs/common.c                                |  2 +-
 certs/common.h                                |  9 -------
 certs/system_keyring.c                        |  1 -
 include/keys/system_keyring.h                 |  6 +++++
 security/integrity/Kconfig                    | 10 +++++++
 security/integrity/Makefile                   | 17 +++++++++++-
 security/integrity/digsig.c                   |  2 +-
 security/integrity/integrity.h                |  6 +++++
 .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
 .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
 12 files changed, 92 insertions(+), 16 deletions(-)
 delete mode 100644 certs/common.h
 create mode 100644 security/integrity/platform_certs/platform_cert.S

-- 
2.27.0
