Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9928E53C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgJNRTj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 13:19:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgJNRTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 13:19:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EHGtvC081400;
        Wed, 14 Oct 2020 13:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a64pXVUhT/TgbYZWTiVZCYeTe9kTEZ7WJQiYDLNnV1w=;
 b=OL0Vo1BgKxG0aCG4dOx+CI7O4D1YQIV4HndT4XPlH09wpNgTHQx8jbacHcCtNzer+bic
 tquW5qy5THwVqRANzgl4jUQWtZ2Fe9yHzujAeyUhXRtWQ6+mBDPytPuVpWgKTSTjn6H+
 PVk2S2lQk0QumfApyN1LtVN84RqerByfhZi8NKn8CBLww4KyaUKpOkqChImoqIohFAGy
 AFAWF2SwujG3mAaNeVVoTcPRloEF5sMad+F/jZxHE89t6gj7Y2wFkMtlVVFX3OUMzOMW
 VeNEPAv0e/5IvG2FQzwIyazTj8riYqWJcWc1oBnvvj11Sgf/rv8pSsmBOQdtft6r4yBJ 6g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3465kh01a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 13:19:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09EHISau013289;
        Wed, 14 Oct 2020 17:19:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3434k84d1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 17:19:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09EHJXIq28508598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 17:19:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 541ABA404D;
        Wed, 14 Oct 2020 17:19:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE8FA4040;
        Wed, 14 Oct 2020 17:19:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.12.97])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Oct 2020 17:19:31 +0000 (GMT)
Message-ID: <1bd027b4212db6f3630b8344efde4678fcd90088.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.10
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 14 Oct 2020 13:19:31 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_09:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,
  
The changes include continuation of the IMA policy rule cleanup and
validation in particular for measuring keys, adding/removing/updating
informational and error messages (e.g. "ima_appraise" boot command line
option), and other bug fixes (e.g. minimal data size validation before
use, return code and NULL pointer checking).

thanks,

Mimi

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.10

for you to fetch changes up to aa662fc04f5b290b3979332588bf8d812b189962:

  ima: Fix NULL pointer dereference in ima_file_hash (2020-09-16 17:43:02 -0400)

----------------------------------------------------------------
integrity-v5.10

----------------------------------------------------------------
Alex Dewar (1):
      ima: Use kmemdup rather than kmalloc+memcpy

Bruno Meneguele (4):
      ima: add check for enforced appraise option
      integrity: invalid kernel parameters feedback
      ima: limit secure boot feedback scope for appraise
      integrity: include keyring name for unknown key request

Denis Efremov (1):
      integrity: Use current_uid() in integrity_audit_message()

KP Singh (1):
      ima: Fix NULL pointer dereference in ima_file_hash

Roberto Sassu (3):
      ima: Don't ignore errors from crypto_shash_update()
      ima: Remove semicolon at the end of ima_get_binary_runtime_size()
      evm: Check size of security.evm before using it

Tyler Hicks (2):
      ima: Pre-parse the list of keyrings in a KEY_CHECK rule
      ima: Fail rule parsing when asymmetric key measurement isn't supportable

 security/integrity/digsig_asymmetric.c |  10 ++-
 security/integrity/evm/evm_main.c      |   9 ++
 security/integrity/ima/ima_appraise.c  |  27 ++++--
 security/integrity/ima/ima_crypto.c    |   2 +
 security/integrity/ima/ima_main.c      |  23 ++++-
 security/integrity/ima/ima_policy.c    | 153 ++++++++++++++++++++++-----------
 security/integrity/ima/ima_queue.c     |   2 +-
 security/integrity/integrity_audit.c   |   2 +-
 8 files changed, 161 insertions(+), 67 deletions(-)

