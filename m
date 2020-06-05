Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAC1EFE72
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgFERDP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 13:03:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgFERDP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 13:03:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055H26fP085618;
        Fri, 5 Jun 2020 13:03:14 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fr7rm0ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 13:03:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055GuUGY016067;
        Fri, 5 Jun 2020 17:03:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf484mx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 17:03:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055H39ma61735242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 17:03:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E96711C054;
        Fri,  5 Jun 2020 17:03:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC2AC11C05B;
        Fri,  5 Jun 2020 17:03:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.181.45])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 17:03:08 +0000 (GMT)
Message-ID: <1591376548.5816.14.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.8
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 05 Jun 2020 13:02:28 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_04:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 bulkscore=0 cotscore=-2147483648 suspectscore=2
 spamscore=0 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

The main changes are extending the TPM 2.0 PCR banks with bank
specific file hashes, calculating the "boot_aggregate" based on other
TPM PCR banks, using the default IMA hash algorithm, instead of SHA1,
as the basis for the cache hash table key, and preventing the mprotect
syscall to circumvent an IMA mmap appraise policy rule.

- In preparation for extending TPM 2.0 PCR banks with bank specific
digests, commit 0b6cf6b97b7e ("tpm: pass an array of tpm_extend_digest
structures to tpm_pcr_extend()") modified tpm_pcr_extend().  The
original SHA1 file digests were padded/truncated, before being
extended into the other TPM PCR banks.  This pull request calculates
and extends the TPM PCR banks with bank specific file hashes
completing the above change.

- The "boot_aggregate", the first IMA measurement list record, is the
"trusted boot" link between the pre-boot environment and the running
OS.  With TPM 2.0, the "boot_aggregate" record is not limited to being
based on the SHA1 TPM PCR bank, but can be calculated based on any
enabled bank, assuming the hash algorithm is also enabled in the
kernel.

Other changes include the following and five other bug fixes/code
clean up:
- supporting both a SHA1 and a larger "boot_aggregate" digest in a
custom template format containing both the the SHA1 ('d') and larger
digests ('d-ng') fields.
- Initial hash table key fix, but additional changes would be good.

thanks,

Mimi

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.8

for you to fetch changes up to 42413b49804b250ced70dac8815388af2d4ad872:

  ima: Directly free *entry in ima_alloc_init_template() if digests is NULL (2020-06-05 06:04:11 -0400)

----------------------------------------------------------------
integrity-v5.8

----------------------------------------------------------------
Krzysztof Struczynski (3):
      ima: Fix ima digest hash table key calculation
      ima: Remove redundant policy rule set in add_rules()
      ima: Set again build_ima_appraise variable

Mimi Zohar (1):
      ima: verify mprotect change is consistent with mmap policy

Roberto Sassu (11):
      ima: Switch to ima_hash_algo for boot aggregate
      ima: Evaluate error in init_ima()
      ima: Store template digest directly in ima_template_entry
      ima: Switch to dynamically allocated buffer for template digests
      ima: Allocate and initialize tfm for each PCR bank
      ima: Calculate and extend PCR with digests in ima_template_entry
      ima: Use ima_hash_algo for collision detection in the measurement list
      evm: Fix possible memory leak in evm_calc_hmac_or_hash()
      ima: Directly assign the ima_default_policy pointer to ima_rules
      ima: Call ima_calc_boot_aggregate() in ima_eventdigest_init()
      ima: Directly free *entry in ima_alloc_init_template() if digests is NULL

 include/linux/ima.h                       |   7 +
 security/integrity/evm/evm_crypto.c       |   2 +-
 security/integrity/ima/ima.h              |  20 ++-
 security/integrity/ima/ima_api.c          |  23 +--
 security/integrity/ima/ima_crypto.c       | 252 +++++++++++++++++++++++++-----
 security/integrity/ima/ima_fs.c           |   4 +-
 security/integrity/ima/ima_init.c         |  24 ++-
 security/integrity/ima/ima_main.c         |  54 +++++++
 security/integrity/ima/ima_policy.c       |  12 +-
 security/integrity/ima/ima_queue.c        |  36 +++--
 security/integrity/ima/ima_template.c     |  25 ++-
 security/integrity/ima/ima_template_lib.c |  18 +++
 security/security.c                       |   7 +-
 13 files changed, 397 insertions(+), 87 deletions(-)
