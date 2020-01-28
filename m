Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9B14C16E
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2020 21:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1UJx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jan 2020 15:09:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33258 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgA1UJx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jan 2020 15:09:53 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SK8gpK185517
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jan 2020 15:09:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrvw854cb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 Jan 2020 15:09:51 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 28 Jan 2020 20:09:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 20:09:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SK9mgh58851500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 20:09:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AAE711C04C;
        Tue, 28 Jan 2020 20:09:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31BDD11C04A;
        Tue, 28 Jan 2020 20:09:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.227.61])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 20:09:47 +0000 (GMT)
Subject: [GIT PULL] integrity subsystem updates for v5.6
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jan 2020 15:09:46 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012820-4275-0000-0000-0000039BC873
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012820-4276-0000-0000-000038AFE1B0
Message-Id: <1580242186.5088.96.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_07:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Two new features - measuring certificates and querying IMA for a file
hash - and three bug fixes are included in this pull request.

- Measuring certificates is like the rest of IMA, based on policy, but
requires loading a custom policy.  Certificates loaded onto a keyring,
for example during early boot, before a custom policy has been loaded,
are queued and only processed after loading the custom policy.

- IMA calculates and caches files hashes.  Other kernel subsystems,
and possibly kernel modules, are interested in accessing these cached
file hashes.  

The bug fixes prevents classifying a file short read (e.g. shutdown)
as an invalid file signature, adds a missing blank when displaying the
securityfs policy rules containing LSM labels, and, lastly, fixes the
handling of the IMA policy information for unknown LSM labels.

thanks,

Mimi

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to d54e17b4066612d88c4ef3e5fb3115f12733763d:

  Merge branch 'next-integrity.defer-measuring-keys' into next-integrity (2020-01-23 17:24:35 -0500)

----------------------------------------------------------------
Clay Chang (1):
      ima: Add a space after printing LSM rules for readability

Florent Revest (1):
      ima: add the ability to query the cached hash of a given file

Janne Karhunen (1):
      ima: ima/lsm policy rule loading logic bug fixes

Lakshmi Ramasubramanian (11):
      IMA: Check IMA policy flag
      IMA: Add KEY_CHECK func to measure keys
      IMA: Define an IMA hook to measure keys
      KEYS: Call the IMA hook to measure keys
      IMA: Add support to limit measuring keys
      IMA: Read keyrings= option from the IMA policy
      IMA: fix measuring asymmetric keys Kconfig
      IMA: pre-allocate buffer to hold keyrings string
      IMA: Define workqueue for early boot key measurements
      IMA: Call workqueue functions to measure queued keys
      IMA: Defined delayed workqueue to free the queued keys

Mimi Zohar (2):
      Merge branch 'next-integrity.measure-keys' into next-integrity
      Merge branch 'next-integrity.defer-measuring-keys' into next-integrity

Patrick Callaghan (1):
      ima: avoid appraise error for hash calc interrupt

 Documentation/ABI/testing/ima_policy         |  16 ++-
 include/linux/ima.h                          |  20 ++++
 security/integrity/ima/Kconfig               |  12 ++
 security/integrity/ima/Makefile              |   2 +
 security/integrity/ima/ima.h                 |  33 +++++-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   4 +-
 security/integrity/ima/ima_asymmetric_keys.c |  66 +++++++++++
 security/integrity/ima/ima_crypto.c          |   4 +-
 security/integrity/ima/ima_init.c            |   8 +-
 security/integrity/ima/ima_main.c            |  61 +++++++++-
 security/integrity/ima/ima_policy.c          | 165 ++++++++++++++++++++++----
 security/integrity/ima/ima_queue_keys.c      | 171 +++++++++++++++++++++++++++
 security/keys/key.c                          |  10 ++
 14 files changed, 540 insertions(+), 40 deletions(-)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c
 create mode 100644 security/integrity/ima/ima_queue_keys.c

