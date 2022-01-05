Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900E24857B5
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 18:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiAERyk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jan 2022 12:54:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242575AbiAERye (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jan 2022 12:54:34 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205Gdfbm001184;
        Wed, 5 Jan 2022 17:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=a/hNyN174JDvdNNm/i87MV7ShBYIpTBhS4It78lqvIc=;
 b=jo0L6m6CansbM71w+v8yXyYkAISYzTwyp0KGFDgmxp1iC/bki9crOoIB8A2FHsxVLGFO
 UM7KOqfw9PS+hbN+Wr9I0+7KVW1dIqZUOWTZwECXBDRy+eFyJy7VAXE5KI8t6ruAer1X
 PPXh2xly903qxSA2vPEmNjYI8YsK1cAlWsIT3EXtWzyqxVyGa1jBoK+E/02iXdRgOwYa
 aJzZz+Phbj41iJjzPLG9tKcJj4KGYJD+qebagZvqNzcnOWNhdM+XvcjYOvBrMKhxIm0Z
 c8NjywiCz8N6WhbCj9Bq85M6kB3yEcgjfBhnKYoYdy4XdQWnHo0c+QG4N6jM6/Edeycd 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcq0s3stx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 17:54:29 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 205GAqv3009846;
        Wed, 5 Jan 2022 17:54:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcq0s3st8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 17:54:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 205Hm5x6021359;
        Wed, 5 Jan 2022 17:54:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dae7k3wqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 17:54:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 205HsNVW27984216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 17:54:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 055ED4204D;
        Wed,  5 Jan 2022 17:54:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8981D4204C;
        Wed,  5 Jan 2022 17:54:20 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.129.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 17:54:20 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v7 0/3] integrity: support including firmware ".platform" keys at build time 
Date:   Wed,  5 Jan 2022 12:54:07 -0500
Message-Id: <20220105175410.554444-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q1MknRTnjF1ZnyS4KjnINjuq5udcdStZ
X-Proofpoint-ORIG-GUID: XXkfOg9bfQ9nJOj3tCk0Qnj2l7w0DOYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_05,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050116
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

Note: It seems last time my patches didn't go through mailing list. My
apologies to those who are receiving it twice.

Changelog:

v7:
* Incldues Jarkko's feedback on patch description for Patch 1 and 3.

v6:
* Includes Jarkko's feedback:
 * Split Patch 2 into two.
 * Update Patch description.

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

Nayna Jain (3):
  certs: export load_certificate_list() to be used outside certs/
  integrity: make integrity_keyring_from_id() non-static
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
