Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133144D6A1F
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Mar 2022 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiCKXBr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 18:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiCKXBj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 18:01:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F32CD4CAF;
        Fri, 11 Mar 2022 14:54:06 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BKJfOq013012;
        Fri, 11 Mar 2022 21:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=AMfTQPWUKvQIp3nGKr1gvqWa8g4OU+tTTF1NxO5iCBw=;
 b=quf1nfXdI9fv3YZig4FtVW3NetDo+gTB0baRqAESMexUEBwK//ED/7yl6TJgwg3UwiWq
 8VJs6HOk/IybdvCrfv+433ukp3q4rZZ7GeDP+MaS4OYP46HvzRIJc9kBDcNObF0PFGMc
 zvUwXV6JmVgGwMUpKG2xGoneRSEv5xoricxvsjlaJczedrMr1ikb2PJPxPQGheJJ8WVJ
 Qn4KexsvLsqErWxR/VnzzIHG/5jR84OpueX6Ufu3wZQehe/uJ8gV5r3HxWCVckR52N8E
 C9GqvUQjBjlN9IgyxztBynas/c4fXeIeyJOpRI0VgLcaNvDT1fTl0OsDPvbwjsmslcw3 fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqfxgv0hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:03:59 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22BKtLBA002633;
        Fri, 11 Mar 2022 21:03:58 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eqfxgv0gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:03:58 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22BL3caM025881;
        Fri, 11 Mar 2022 21:03:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3ekyg8njt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 21:03:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22BL3qIc48169228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 21:03:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 889094C040;
        Fri, 11 Mar 2022 21:03:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA544C04E;
        Fri, 11 Mar 2022 21:03:48 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.110.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Mar 2022 21:03:48 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com, masahiroy@kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v12 0/4] integrity: support including firmware ".platform" keys at build time 
Date:   Fri, 11 Mar 2022 16:03:40 -0500
Message-Id: <20220311210344.102396-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vFj6BitYF0x-cbuTSlcAlvP41isWo2s8
X-Proofpoint-ORIG-GUID: 29tSgp1oZs-enh7p1uMj0CP5vo99aQgQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-11_08,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
v12:
* Replace Patch 3/4 with reverting of the commit as suggested by
Masahiro Yamada.

v11:
* Added a new patch to conditionally build extract-cert if
PLATFORM_KEYRING is enabled.

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

Nayna Jain (4):
  certs: export load_certificate_list() to be used outside certs/
  integrity: make integrity_keyring_from_id() non-static
  Revert "certs: move scripts/extract-cert to certs/"
  integrity: support including firmware ".platform" keys at build time

 MAINTAINERS                                   |  1 +
 certs/.gitignore                              |  1 -
 certs/Makefile                                | 18 ++++++---------
 certs/blacklist.c                             |  1 -
 certs/common.c                                |  2 +-
 certs/common.h                                |  9 --------
 certs/system_keyring.c                        |  1 -
 include/keys/system_keyring.h                 |  6 +++++
 scripts/.gitignore                            |  1 +
 scripts/Makefile                              | 12 ++++++++--
 {certs => scripts}/extract-cert.c             |  2 +-
 scripts/remove-stale-files                    |  2 --
 security/integrity/Kconfig                    | 10 ++++++++
 security/integrity/Makefile                   | 15 +++++++++++-
 security/integrity/digsig.c                   |  2 +-
 security/integrity/integrity.h                |  9 ++++++++
 .../integrity/platform_certs/platform_cert.S  | 23 +++++++++++++++++++
 .../platform_certs/platform_keyring.c         | 23 +++++++++++++++++++
 18 files changed, 107 insertions(+), 31 deletions(-)
 delete mode 100644 certs/common.h
 rename {certs => scripts}/extract-cert.c (98%)
 create mode 100644 security/integrity/platform_certs/platform_cert.S


base-commit: fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9
-- 
2.34.1
