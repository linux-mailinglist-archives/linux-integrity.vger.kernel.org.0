Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB323E1D9
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Aug 2020 21:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHFTHB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Aug 2020 15:07:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726577AbgHFTHA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Aug 2020 15:07:00 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076J1bFf129766;
        Thu, 6 Aug 2020 15:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0kBx8mKgQMAGofaT4ZYg7HMnKFqzEX064Flb9GCDQvo=;
 b=Uv5aFUxwmMwhIIdjTcoXUyKeF9ozCz3CdzChKkMu/+NHjUe8TWVG1TqtuHZlXlrxhKni
 adnaPnG57N2hdbW/o8xjWOeO4/ICOaqG78NF7KztCGMu7jjmhVUAMwEaxS2HaoLB5nNs
 WVzyNVkENeLCdwQrpziQ0EL4gglF2/enlCtTL2cStegzIsBiDeP4YEjKEJ9HyPbtmeG6
 BtczFX1tUC2eFPkE6fueMcXJPv1fNgfixIYVE5nGpf9C5/rzIPAVsFeGWhMIrlyhCoLT
 JdmiSJbO7jX1MUVATRXaVxevZrFw5l6ThzYrBFTyRhDluTGTxBydNGRPu3VdaGcO/EBg uw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rg3nn8j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 15:06:58 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076J0Cfj017511;
        Thu, 6 Aug 2020 19:06:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32n017uhb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 19:06:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076J6sPD20906352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 19:06:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4461611C054;
        Thu,  6 Aug 2020 19:06:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F8E11C04C;
        Thu,  6 Aug 2020 19:06:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Aug 2020 19:06:53 +0000 (GMT)
Message-ID: <221392a7698a16d1844ba2b6f80669e635babf7a.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.9
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 06 Aug 2020 15:06:51 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_14:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=2
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

The nicest change is the IMA policy rule checking.  The other changes
include allowing the kexec boot cmdline line measure policy rules to be
defined in terms of the inode associated with the kexec kernel image,
making the IMA_APPRAISE_BOOTPARAM, which governs the IMA appraise mode
(log, fix, enforce), a runtime decision based on the secure boot mode
of the system, and including errno in the audit log.

thanks,

Mimi


The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.9

for you to fetch changes up to 3db0d0c276a752af39beb5ca7424cb659aa005bb:

  integrity: remove redundant initialization of variable ret (2020-07-27 16:52:09 -0400)

----------------------------------------------------------------
integrity-v5.9

----------------------------------------------------------------
Bruno Meneguele (1):
      ima: move APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime

Colin Ian King (1):
      integrity: remove redundant initialization of variable ret

Lakshmi Ramasubramanian (2):
      integrity: Add errno field in audit message
      IMA: Add audit log for failure conditions

Maurizio Drocco (1):
      ima: extend boot_aggregate with kernel measurements

Mimi Zohar (1):
      Merge branch 'validate-policy-rules' into next-integrity

Tyler Hicks (14):
      ima: Have the LSM free its audit rule
      ima: Free the entire rule when deleting a list of rules
      ima: Free the entire rule if it fails to parse
      ima: Fail rule parsing when buffer hook functions have an invalid action
      ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an invalid cond
      ima: Fail rule parsing when the KEY_CHECK hook is combined with an invalid cond
      ima: Fail rule parsing when appraise_flag=blacklist is unsupportable
      ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
      ima: Use correct type for the args_p member of ima_rule_entry.lsm elements
      ima: Move comprehensive rule validation checks out of the token parser
      ima: Use the common function to detect LSM conditionals in a rule
      ima: Support additional conditionals in the KEXEC_CMDLINE hook function
      ima: Rename internal filter rule functions
      ima: AppArmor satisfies the audit rule requirements

 include/linux/ima.h                          |   4 +-
 kernel/kexec_file.c                          |   2 +-
 security/integrity/digsig_asymmetric.c       |   2 +-
 security/integrity/ima/Kconfig               |   4 +-
 security/integrity/ima/ima.h                 |  75 +++++----
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_appraise.c        |   8 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_crypto.c          |  15 +-
 security/integrity/ima/ima_main.c            |  41 +++--
 security/integrity/ima/ima_modsig.c          |  20 ---
 security/integrity/ima/ima_policy.c          | 240 +++++++++++++++++++--------
 security/integrity/ima/ima_queue_keys.c      |   7 +-
 security/integrity/integrity.h               |  13 ++
 security/integrity/integrity_audit.c         |  11 +-
 15 files changed, 301 insertions(+), 145 deletions(-)

