Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF9533290
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 22:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiEXUqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiEXUqS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 16:46:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922811D0EF;
        Tue, 24 May 2022 13:46:17 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OKfl3T023555;
        Tue, 24 May 2022 20:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=kH0Eo06/kOo+BFgEy06WUnmU7pV7b9nWWZ0T3lV3sls=;
 b=s93vvosrGYeHDwUb3VX0O+PQsOHNmICHPUtLkuLs776pl7tUuWCSESaQdF+1hwRXrhI3
 BRmracdPuq0eLTyHQvpRsh+Kl9UE9GQhh2E40zfEK63I2qcfVScdJDXswx6B2VNN58Mc
 Pu8iNre24W8luPlFvB20gitu2MzwQ8AW15wyHQ4TgFrUGjQKZ7MooWOZPVi+qVDv8ogk
 VkByd3c7uO2xgrU/F2CekoOhMkfW2eK6Z+UBVNbe0F0OHnTJn2ayY7p9khNvML4FOWqk
 r9npnHwheFUrZD80fJe+nqKRFjvj7UrlhMcwLPCOMkZGDMuERwMWS22ITeEH20a4/J13 sQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g96mdg26b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 20:46:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OKaIwY006216;
        Tue, 24 May 2022 20:46:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3g93wdr45x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 20:46:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OKkBLA43778366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 20:46:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 944CDAE055;
        Tue, 24 May 2022 20:46:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03894AE053;
        Tue, 24 May 2022 20:46:11 +0000 (GMT)
Received: from sig-9-65-93-242.ibm.com (unknown [9.65.93.242])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 20:46:10 +0000 (GMT)
Message-ID: <223e46039b44b2f31814be02a3c2b75e84af3823.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.19
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 24 May 2022 16:46:10 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HT1jKMLOd69V4MaiH8x-Aywe2VI48iIR
X-Proofpoint-ORIG-GUID: HT1jKMLOd69V4MaiH8x-Aywe2VI48iIR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_10,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205240101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

New is IMA support for including fs-verity file digests and signatures
in the IMA
measurement list as well as verifying the fs-verity file digest based
signatures, both based on policy.

In addition, are two bug fixes:
- avoid reading UEFI variables, which cause a page fault, on Apple Macs
with T2 chips.
- remove the original "ima" template Kconfig option to address a boot
command line ordering issue.

The rest is a mixture of code/documentation cleanup.

thanks,

Mimi

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.19

for you to fetch changes up to 048ae41bb0806cde340f4e5d5030398037ab0be8:

  integrity: Fix sparse warnings in keyring_handler (2022-05-16 17:06:16 -0400)

----------------------------------------------------------------
integrity-v5.19

----------------------------------------------------------------
Aditya Garg (1):
      efi: Do not import certificates from UEFI Secure Boot for T2 Macs

Colin Ian King (1):
      ima: remove redundant initialization of pointer 'file'.

GUO Zihua (1):
      ima: remove the IMA_TEMPLATE Kconfig option

Mimi Zohar (8):
      ima: fix 'd-ng' comments and documentation
      ima: use IMA default hash algorithm for integrity violations
      fs-verity: define a function to return the integrity protected file digest
      ima: define a new template field named 'd-ngv2' and templates
      ima: permit fsverity's file digests in the IMA measurement list
      ima: support fs-verity file digest based version 3 signatures
      fsverity: update the documentation
      Merge branch 'next-integrity.fsverity-v9' into next-integrity

Stefan Berger (3):
      evm: Return INTEGRITY_PASS for enum integrity_status value '0'
      evm: Clean up some variables
      integrity: Fix sparse warnings in keyring_handler

 Documentation/ABI/testing/ima_policy               |  45 +++++++-
 Documentation/admin-guide/kernel-parameters.txt    |   3 +-
 Documentation/filesystems/fsverity.rst             |  35 ++++---
 Documentation/security/IMA-templates.rst           |  11 +-
 fs/verity/Kconfig                                  |   1 +
 fs/verity/fsverity_private.h                       |   7 --
 fs/verity/measure.c                                |  43 ++++++++
 include/linux/fsverity.h                           |  18 ++++
 security/integrity/digsig.c                        |   3 +-
 security/integrity/evm/evm.h                       |   3 -
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/evm/evm_main.c                  |   2 +-
 security/integrity/ima/Kconfig                     |  14 ++-
 security/integrity/ima/ima_api.c                   |  47 ++++++++-
 security/integrity/ima/ima_appraise.c              | 114 ++++++++++++++++++++-
 security/integrity/ima/ima_main.c                  |   4 +-
 security/integrity/ima/ima_policy.c                |  82 +++++++++++++--
 security/integrity/ima/ima_template.c              |   4 +
 security/integrity/ima/ima_template_lib.c          |  94 ++++++++++++++---
 security/integrity/ima/ima_template_lib.h          |   4 +
 security/integrity/integrity.h                     |  27 ++++-
 .../integrity/platform_certs/keyring_handler.c     |   6 +-
 .../integrity/platform_certs/keyring_handler.h     |   8 ++
 security/integrity/platform_certs/load_uefi.c      |  33 ++++++
 24 files changed, 531 insertions(+), 79 deletions(-)

