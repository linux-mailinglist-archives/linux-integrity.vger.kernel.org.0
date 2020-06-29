Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1460420D2CD
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2020 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgF2SwQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 14:52:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727854AbgF2SwP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TF3Y9n183022;
        Mon, 29 Jun 2020 11:27:19 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycj95mkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:27:18 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TFG1Mf006442;
        Mon, 29 Jun 2020 15:27:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 31wwr7s67s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 15:27:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TFRE9647186124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 15:27:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEEE7A4055;
        Mon, 29 Jun 2020 15:27:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07673A4040;
        Mon, 29 Jun 2020 15:27:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.137.220])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 15:27:13 +0000 (GMT)
Message-ID: <1593444433.5085.15.camel@linux.ibm.com>
Subject: [GIT PULL] integrity additional change v5.8 (#2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Mon, 29 Jun 2020 11:27:13 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_15:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 cotscore=-2147483648 bulkscore=0 clxscore=1011 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290103
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Prior to Linux 5.8 the SHA1 "boot_aggregate" value was padded with 0's
and extended into the other TPM 2.0 banks.  Included in the Linux 5.8
open window, TPM 2.0 PCR bank specific "boot_aggregate" values (PCRs 0
- 7) are calculated and extended into the TPM banks.

Distro releases are now shipping grub2 with TPM support, which extend
PCRs 8 & 9.  I'd like for PCRs 8 & 9 to be included in the new
"boot_aggregate" calculations.  For backwards compatibility, PCRs 8 &
9 are not included in the SHA1 TPM bank "boot_aggregate" calculation.

I'd appreciate your merging this additional change.

thanks,

Mimi

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.8-fix-2

for you to fetch changes up to 20c59ce010f84300f6c655d32db2610d3433f85c:

  ima: extend boot_aggregate with kernel measurements (2020-06-24 20:47:24 -0400)

----------------------------------------------------------------
Include PCRs 8 & 9 in per TPM 2.0 bank boot_aggregate calculation

----------------------------------------------------------------
Maurizio Drocco (1):
      ima: extend boot_aggregate with kernel measurements

 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)
