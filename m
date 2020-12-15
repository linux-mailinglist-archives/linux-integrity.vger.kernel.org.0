Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1CB2DAD6D
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Dec 2020 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLOMqP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Dec 2020 07:46:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbgLOMqP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Dec 2020 07:46:15 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BFCWWVi180926;
        Tue, 15 Dec 2020 07:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=n7uDpeokGZ+dAfGQJNp3tTusSHjI7NCE3+fLK4oiBq8=;
 b=GpAkp1ri2CgVP0eNuX5OcZ4pcv8UOLlYkjYHfjzvssjhbNBqUwY16QwQ0JEfQ6+4YV+W
 2EfQSW3H19HZ39hWUUxCAg5envrepdzC8CO0RtR9KPLfboGDbZeEHppxS9vLxheVtGeQ
 HsSMXP6ve+jjwowcJT3b3ZGCmwnFg1cReTSENENDA7CdjO2fFVWu60RU70dQaGWdFK9F
 YHLN7IGXJ2zqhE2/74x0MWT5+T3s4guocCdxXKi6SyA3VOV9MGs481uhUhSclFl5Q6le
 MHkW3USwQPt9lm+9JWcqreXTX7x1Cj6UaJoMVvelokbm2mblPvCs+sBQugtj4rEe4a9B WQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35eumx39w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:45:33 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BFCY3YY029296;
        Tue, 15 Dec 2020 12:45:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 35d3109d95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 12:45:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BFCjTAr34079006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 12:45:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 347C6AE053;
        Tue, 15 Dec 2020 12:45:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E252AE045;
        Tue, 15 Dec 2020 12:45:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.21.236])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Dec 2020 12:45:27 +0000 (GMT)
Message-ID: <1d4caa0d060caa9249d97acf5d8a9a0fe944076b.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.11
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Dec 2020 07:45:27 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_10:2020-12-14,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Included in this pull request are just 3 patches.  Other integrity
changes are being upstreamed via EFI (defines a common EFI secure and
trusted boot IMA policy) and BPF LSM (exporting the IMA file cache hash
info based on inode).

The 3 patches included in this pull request:
- bug fix: fail calculating the file hash, when a file not opened for
read and the attempt to re-open it for read fails.
- defer processing the "ima_appraise" boot command line option to avoid
enabling different modes (e.g. fix, log) to when the secure boot flag
is available on arm.
- defines "ima-buf" as the default IMA buffer measurement template in
preparation for the builtin integrity "critical data" policy.

thanks,

Mimi


The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.11

for you to fetch changes up to 207cdd565dfc95a0a5185263a567817b7ebf5467:

  ima: Don't modify file descriptor mode on the fly (2020-11-29 07:02:53 -0500)

----------------------------------------------------------------
integrity-v5.11

----------------------------------------------------------------
Ard Biesheuvel (1):
      ima: defer arch_ima_get_secureboot() call to IMA init time

Lakshmi Ramasubramanian (1):
      ima: select ima-buf template for buffer measurement

Roberto Sassu (1):
      ima: Don't modify file descriptor mode on the fly

 include/linux/ima.h                   |  6 ++++++
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_appraise.c | 17 +++++++++++------
 security/integrity/ima/ima_crypto.c   | 20 +++++---------------
 security/integrity/ima/ima_main.c     | 25 ++++++++++---------------
 security/integrity/ima/ima_policy.c   |  2 +-
 security/integrity/ima/ima_template.c | 26 ++++++++++++++++++++++++++
 7 files changed, 60 insertions(+), 37 deletions(-)

