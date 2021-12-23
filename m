Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E3E47DD6E
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Dec 2021 02:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbhLWBjk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 20:39:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242095AbhLWBji (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 20:39:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMNb7D7024770;
        Thu, 23 Dec 2021 01:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xmez9vIukIT3xSUgxdOg9p5new2fmcimfFopeG/z/vE=;
 b=PzqBef816UfZ5QFDEGzMlQoQQflAJZgXE2U17hSF7AVsdWsJ48Bx9bM4iVkzXjy2jlVl
 /Se2ydzDV8Cgum+NYQw17WHfZKjHdbYUS4Ogqcg6xvrIB0Ew/PIUtm1Rjvzf6WqjSk4P
 lSi4x57nzMkJ+2h+fRgDH0ZPE7POgb2uwYghlTt4E0Y6YRpx70EnSJ8PfbxbUQ6X2MTo
 +ozQVQKeK1OvB2ANmc+e0xB7KzmtL+HZyi0wi0qnvLUcb0xIYheyeMD6O0n/bC4bfbo7
 wQXmpwFE+5jqnQO6GGmzVWxgychjE3nar+oPE/SP9zMw2HoIUQRB62LDo1uGPv9yNqOm nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d4add5734-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 01:39:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BN1YOLi000924;
        Thu, 23 Dec 2021 01:39:34 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d4add572n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 01:39:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BN1cEiE015698;
        Thu, 23 Dec 2021 01:39:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3d16wk2x6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 01:39:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BN1dS3i37028160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 01:39:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF5A74C04E;
        Thu, 23 Dec 2021 01:39:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8BE34C040;
        Thu, 23 Dec 2021 01:39:26 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.41.75])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Dec 2021 01:39:26 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v6 0/3] integrity: support including firmware ".platform" keys at build time 
Date:   Wed, 22 Dec 2021 20:39:16 -0500
Message-Id: <20211223013919.206273-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pFDgdL-2tIWDeGK9PvG6FJ0Mx4RM8iE7
X-Proofpoint-ORIG-GUID: 7cu8xxeqC88KUhYUEh2Mi4s3g_w8Gq-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230005
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
