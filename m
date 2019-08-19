Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A169238C
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHSMf0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 08:35:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbfHSMf0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 08:35:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JCYQbx098333
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 08:35:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufuw2r1pb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2019 08:35:24 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Mon, 19 Aug 2019 13:35:22 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 13:35:19 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JCYvPq27525584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 12:34:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB5111C05B;
        Mon, 19 Aug 2019 12:35:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 467BA11C058;
        Mon, 19 Aug 2019 12:35:15 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.231.242])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 12:35:15 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v5 0/2] powerpc: Enabling IMA arch specific secure boot policies
Date:   Mon, 19 Aug 2019 08:35:06 -0400
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19081912-0008-0000-0000-0000030AB4F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081912-0009-0000-0000-00004A28D83A
Message-Id: <1566218108-12705-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA subsystem supports custom, built-in, arch-specific policies to define
the files to be measured and appraised. These policies are honored based
on the priority where arch-specific policies is the highest and custom
is the lowest.

OpenPOWER systems rely on IMA for signature verification of the kernel.
This patchset adds support for powerpc specific arch policies that are
defined based on system's OS secureboot state. The OS secureboot state
of the system is determined via device-tree entry.

Changelog:
v5:
* secureboot state is now read via device tree entry rather than OPAL
secure variables
* ima arch policies are updated to use policy based template for
measurement rules

v4:
* Fixed the build issue as reported by Satheesh Rajendran.

v3:
* OPAL APIs in Patch 1 are updated to provide generic interface based on
key/keylen. This patchset updates kernel OPAL APIs to be compatible with
generic interface.
* Patch 2 is cleaned up to use new OPAL APIs.
* Since OPAL can support different types of backend which can vary in the
variable interpretation, the Patch 2 is updated to add a check for the
backend version
* OPAL API now expects consumer to first check the supported backend version
before calling other secvar OPAL APIs. This check is now added in patch 2.
* IMA policies in Patch 3 is updated to specify appended signature and
per policy template.
* The patches now are free of any EFIisms.

v2:

* Removed Patch 1: powerpc/include: Override unneeded early ioremap
functions
* Updated Subject line and patch description of the Patch 1 of this series
* Removed dependency of OPAL_SECVAR on EFI, CPU_BIG_ENDIAN and UCS2_STRING
* Changed OPAL APIs from static to non-static. Added opal-secvar.h for the
same
* Removed EFI hooks from opal_secvar.c
* Removed opal_secvar_get_next(), opal_secvar_enqueue() and
opal_query_variable_info() function
* get_powerpc_sb_mode() in secboot.c now directly calls OPAL Runtime API
rather than via EFI hooks.
* Fixed log messages in get_powerpc_sb_mode() function.
* Added dependency for PPC_SECURE_BOOT on configs PPC64 and OPAL_SECVAR
* Replaced obj-$(CONFIG_IMA) with obj-$(CONFIG_PPC_SECURE_BOOT) in
arch/powerpc/kernel/Makefile

Nayna Jain (2):
  powerpc: detect the secure boot mode of the system
  powerpc: Add support to initialize ima policy rules

 arch/powerpc/Kconfig               | 13 ++++++
 arch/powerpc/include/asm/secboot.h | 27 ++++++++++++
 arch/powerpc/kernel/Makefile       |  2 +
 arch/powerpc/kernel/ima_arch.c     | 50 +++++++++++++++++++++
 arch/powerpc/kernel/secboot.c      | 71 ++++++++++++++++++++++++++++++
 include/linux/ima.h                |  3 +-
 6 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/secboot.h
 create mode 100644 arch/powerpc/kernel/ima_arch.c
 create mode 100644 arch/powerpc/kernel/secboot.c

-- 
2.20.1

