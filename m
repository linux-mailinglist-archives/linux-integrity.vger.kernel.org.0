Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED928C558
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 01:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgJLXo2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 19:44:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63102 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbgJLXo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:44:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CNV1Sh139459
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=csejHsL5C85/lrlGXGSad4mn3Na8Q4K37Sd//UggGX4=;
 b=HCxytCmajz35IGIpnKZXqlMTihsyYA1Sh7GeIo5bvKdYOA3fpzqnlkCMvyDAVB2EWTeU
 +P65BucYc4wPAhBtbszH9B/hgcQb24woychlL4V+7UAyX1wibGjimnUKWGOQKM85WSEh
 s4LoRLQjaQlwRWpF0zyxrpf+QKzlcnA/ADaCj1sz4OOsTcbpgJR5q/CBVi5M18aLn0oT
 7vqlT+agucFuZzvW1oXqLn4i7Q/KoDgcBSo9/PT3fcPMvP12S6Rb1I7uZ3X7EP/AUIWC
 4OlQa1+TVfllGPk8LSL09OxAWX0xku9lzOjW10HjtBuAuy7rwBIV1H3LRh8PvhqQDQ42 fA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344xdc3f55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:27 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CNgTfS021746
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:26 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3434k901bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CNiPJl19464522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 23:44:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A9DAB2065;
        Mon, 12 Oct 2020 23:44:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF97B2067;
        Mon, 12 Oct 2020 23:44:24 +0000 (GMT)
Received: from eve.home (unknown [9.85.142.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 23:44:23 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v2 0/5] Updates to use IBM TSS C API rather than command line tools
Date:   Mon, 12 Oct 2020 19:44:11 -0400
Message-Id: <20201012234416.20995-1-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=771 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120167
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set replaces calls to command line tools with C code.  This
should be more stable and easier to maintain.  INSTALL instructions
are updated.

While the code is being touched, it changes the PCR handle from
a signed int to a uint32_t, removing the need for error checking.

Finally, it fixes an environment variable issue and some spelling
errors.

Ken Goldman (5):
  ima-evm-utils: Change env variable TPM_SERVER_TYPE for tpm_server
  ima-evm-utils: Change PCR iterater from int to uint32_t
  ima-evm-utils: Change tpm2_pcr_read() to use C code
  ima-evm-utils: Correct spelling errors
  ima-evm-utils: Expand the INSTALL instructions.

 INSTALL                   |  25 +++++-
 src/Makefile.am           |   1 +
 src/evmctl.c              |   9 ++-
 src/pcr.h                 |   2 +-
 src/pcr_tss.c             |   4 +-
 src/pcr_tsspcrread.c      | 156 +++++++++++++++++++++++++++++---------
 tests/boot_aggregate.test |   7 +-
 7 files changed, 159 insertions(+), 45 deletions(-)

-- 
2.25.1

