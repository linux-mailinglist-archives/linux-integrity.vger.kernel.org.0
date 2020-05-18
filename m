Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4832F1D7D49
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgERPti (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 11:49:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbgERPti (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 11:49:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IFXR0E108670;
        Mon, 18 May 2020 11:49:36 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312c63f5ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 11:49:36 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IFeoxh021224;
        Mon, 18 May 2020 15:49:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3127t5hthp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 15:49:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IFnWRS62324914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 15:49:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3829052050;
        Mon, 18 May 2020 15:49:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.145.145])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B351C52052;
        Mon, 18 May 2020 15:49:31 +0000 (GMT)
Message-ID: <1589816971.5111.113.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem fixes for v5.7
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 18 May 2020 11:49:31 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 cotscore=-2147483648
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Here are a couple of miscellaneous bug fixes for the integrity
subsystem:

IMA:
- Properly modify the open flags in order to calculate the file hash.
- On systems requiring the IMA policy to be signed, the policy is
loaded differently.  Don't differentiate between "enforce" and either
"log" or "fix" modes how the policy is loaded.

EVM:
- (2 patches) Fix an EVM race condition, normally the result of
attempting to load an unsupported hash algorithm.
- Use the lockless RCU version for walking an append only list.

Mimi

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.fixes

for you to fetch changes up to 8433856947217ebb5697a8ff9c4c9cad4639a2cf:

  evm: Fix a small race in init_desc() (2020-05-14 19:55:54 -0400)

----------------------------------------------------------------
Dan Carpenter (1):
      evm: Fix a small race in init_desc()

Madhuparna Bhowmik (1):
      evm: Fix RCU list related warnings

Roberto Sassu (3):
      ima: Set file->f_mode instead of file->f_flags in ima_calc_file_hash()
      evm: Check also if *tfm is an error pointer in init_desc()
      ima: Fix return value of ima_write_policy()

 security/integrity/evm/evm_crypto.c | 46 ++++++++++++++++++-------------------
 security/integrity/evm/evm_main.c   |  4 ++--
 security/integrity/evm/evm_secfs.c  |  9 +++++++-
 security/integrity/ima/ima_crypto.c | 12 +++++-----
 security/integrity/ima/ima_fs.c     |  3 +--
 5 files changed, 40 insertions(+), 34 deletions(-)
