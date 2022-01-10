Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5048A242
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jan 2022 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiAJWCM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 17:02:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbiAJWCL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 17:02:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AKK4vH032508;
        Mon, 10 Jan 2022 22:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=ZimozMTB7scDCoA+g9ix770IWUghSN5d/1b2wWBEsF4=;
 b=AY3+boBU7EMI3sriJJcYZ1yWun8yGWCIOOOs9ZItTwiX2s4mfw2oXu6vwz11T5YzRra7
 18Mi9u6iHgzlfyYQv/TKKl+JqXKqD5NrJMP3QBkuYdUuylvqylRLZTrzZiL5dmOILVuU
 89TRY6yrCpFDTLXKLshdoaVvHdSpSJWJgXxtpkXxjKMquc9XJWqi5CqZXKHZvb+STTKS
 jjaiX/eTMQLfm/em6lOjL6QXfokW7TV3CAYUHMc1POQsTlF9fQiUy5zGxERFCnHWKwyZ
 XOyc5kDSHMa9gTrvTfxouqBC48b5PotiZl4t4qA7hSfMU8miNZzveK8Ffg3Nc7eN7ki+ 4w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3vvqmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 22:02:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20ALvtrf007323;
        Mon, 10 Jan 2022 22:02:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vhrsne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 22:02:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20AM23St41419078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 22:02:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BA6B52051;
        Mon, 10 Jan 2022 22:02:03 +0000 (GMT)
Received: from sig-9-65-93-173.ibm.com (unknown [9.65.93.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 99B755205F;
        Mon, 10 Jan 2022 22:02:02 +0000 (GMT)
Message-ID: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.17
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Jan 2022 17:02:02 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 60Pkw2xZq5eV53gis3jdKLqZ-PFG5QnZ
X-Proofpoint-GUID: 60Pkw2xZq5eV53gis3jdKLqZ-PFG5QnZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

The few changes are all kexec related:

- The MOK keys are loaded onto the .platform keyring in order to verify
the kexec kernel image signature.  However, the MOK keys should only be
trusted when secure boot is enable.  Before loading the MOK keys onto
the .platform keyring, make sure the system is booted in secure boot
mode.

- When carrying the IMA measurement list across kexec, limit dumping
the measurement list to when dynamic debug or CONFIG_DEBUG is enabled.

- kselftest: add kexec_file_load selftest support for PowerNV and other
cleanup.

thanks,

Mimi


The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17

for you to fetch changes up to 65e38e32a959dbbb0bf5cf1ae699789f81759be6:

  selftests/kexec: Enable secureboot tests for PowerPC (2022-01-05 11:44:57 -0500)

----------------------------------------------------------------
integrity-v5.17

----------------------------------------------------------------
Bruno Meneguele (1):
      ima: silence measurement list hexdump during kexec

Lee, Chun-Yi (1):
      integrity: Do not load MOK and MOKx when secure boot be disabled

Mimi Zohar (2):
      selftest/kexec: fix "ignored null byte in input" warning
      selftests/kexec: update searching for the Kconfig

Nageswara R Sastry (1):
      selftests/kexec: Enable secureboot tests for PowerPC

Takashi Iwai (1):
      ima: Fix undefined arch_ima_get_secureboot() and co

 include/linux/ima.h                                | 30 ++++++-------
 security/integrity/ima/ima_kexec.c                 |  6 +--
 security/integrity/platform_certs/load_uefi.c      |  5 +++
 tools/testing/selftests/kexec/Makefile             |  2 +-
 tools/testing/selftests/kexec/kexec_common_lib.sh  | 51 +++++++++++++++++-----
 .../selftests/kexec/test_kexec_file_load.sh        | 13 ++++--
 6 files changed, 74 insertions(+), 33 deletions(-)

