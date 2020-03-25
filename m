Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3DA1933BF
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYW13 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 18:27:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgCYW13 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 18:27:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PM38H0042278
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywfeaartu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 22:27:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 22:27:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02PMRMDY50397274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:27:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 700464C04E;
        Wed, 25 Mar 2020 22:27:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EF4A4C044;
        Wed, 25 Mar 2020 22:27:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 22:27:21 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 0/3] boot aggregate test
Date:   Wed, 25 Mar 2020 18:26:14 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 20032522-0016-0000-0000-000002F81E7B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032522-0017-0000-0000-0000335BC40C
Message-Id: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_13:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=1 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250168
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "boot_aggregate" contained in the IMA measurement list has always been
a SHA1 hash.  With Roberto's "ima: support stronger algorithms for
attestation" patch set, the hash algorithm used to calculate the
"boot_aggregate" will either be the IMA default hash algorithm or fall
back to using SHA1 for TPM 1.2 or SHA256 for TPM 2.0, assuming a SHA256
TPM bank exists.

This test may be used to verify the "boot_aggregate" based on a physical
TPM or a software TPM.  If a software TPM is not running on the system,
one is started and initialized by walking a sample
binary_bios_measurements log and extending the software TPM with those
values.  The "boot_aggregate" is then calculated and compared against the
sample ascii_runtime_measurements record.

This test depends on Vitaly's "ima-evm-utils: Add some tests for evmctl"
patch being upstreamed.  I would appreciate some review on both his patch
and on this patch set.  To help facilitate this review, I've pushed out a
next-testing topic branch.  Included in this topic branch is Patrick
Uiterwijk's support for reading the TPM PCRs using Intel's TSS2.

Thanks!

Mimi

Mimi Zohar (3):
  ima-evm-utils: tests: verify boot_aggregate
  ima-evm-utils: tests: verify the last "boot_aggregate" record
  ima_evm_utils: tests: color boot_aggregate.test tty output

 tests/Makefile.am                     |   2 +-
 tests/boot_aggregate.test             | 150 ++++++++++++++++++++++++++++++++++
 tests/test_ascii_runtime_measurements |   3 +
 tests/test_binary_bios_measurements   | Bin 0 -> 23248 bytes
 4 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100755 tests/boot_aggregate.test
 create mode 100644 tests/test_ascii_runtime_measurements
 create mode 100644 tests/test_binary_bios_measurements

-- 
2.7.5

