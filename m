Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2E4CEDCC
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Mar 2022 21:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiCFUwL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Mar 2022 15:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCFUwL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Mar 2022 15:52:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB91FA41;
        Sun,  6 Mar 2022 12:51:18 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 226GKDpW018727;
        Sun, 6 Mar 2022 20:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kA114Qk/KFG1ESmDdeVocI3m7q4zE5+k1hNnVUg6sxU=;
 b=snYaA+RqTou47nwUNhMz1RZaa35MbyLacvW2kpbB6vcpQPBsZmBACp791QQQNK5bTIPb
 iqwumFnAeByOthKOtxmukpRTgm/YA3NBXQ/OmwH2yIZhcR6I3vbP+DcfTemJ5MKnCtF4
 cB96x9FYtgjZQA1Jm/bZAQHQ8k+SiA6uEEtDJSYaz5eUEMZcU784blyu3cnjIeyyWS54
 8/0jEyZ3tZRca2HVBL/U9Sbq6wMS/1HaKMwqLes6iviIZWX6rXhMt0GA0zjAlmADZKXX
 3NFp2ZOxgtmzn6+TwhalSTi1MRwobIs6dqtZ4r+lLqGudl2eBI87D+n8z2Ga/jT2aAnd WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3emtmw6gmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:13 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 226KpCOJ001160;
        Sun, 6 Mar 2022 20:51:12 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3emtmw6gmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 226KhgEj000631;
        Sun, 6 Mar 2022 20:51:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3eky4j2njb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Mar 2022 20:51:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 226Kp7Kw23593338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Mar 2022 20:51:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E4811C054;
        Sun,  6 Mar 2022 20:51:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E710411C04C;
        Sun,  6 Mar 2022 20:51:04 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.113.126])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Mar 2022 20:51:04 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v10 0/3] integrity: support including firmware ".platform" keys at build time 
Date:   Sun,  6 Mar 2022 15:50:57 -0500
Message-Id: <20220306205100.651878-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FGfm_l4yQIhY2NP4VovyYVj_xlZ-s6Q-
X-Proofpoint-ORIG-GUID: 4OL7R87XGttIP4hr4-2qdvdr-bXdcoxr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-06_08,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203060140
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v10:
* Fixed the externs warning for Patch 3.

v9:
* Rebased on Jarkko's repo - 
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

v8:
* Includes Jarkko's feedback on patch description and removed Reported-by
for Patch 1.

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
 certs/common.h                                |  9 --------
 certs/system_keyring.c                        |  1 -
 include/keys/system_keyring.h                 |  6 +++++
 security/integrity/Kconfig                    | 10 ++++++++
 security/integrity/Makefile                   | 15 +++++++++++-
 security/integrity/digsig.c                   |  2 +-
 security/integrity/integrity.h                |  9 ++++++++
 .../integrity/platform_certs/platform_cert.S  | 23 +++++++++++++++++++
 .../platform_certs/platform_keyring.c         | 23 +++++++++++++++++++
 12 files changed, 90 insertions(+), 16 deletions(-)
 delete mode 100644 certs/common.h
 create mode 100644 security/integrity/platform_certs/platform_cert.S


base-commit: c9e54f38976a1c0ec69c0a6208b3fd55fceb01d1
-- 
2.27.0
