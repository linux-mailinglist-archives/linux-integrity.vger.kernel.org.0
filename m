Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2821BA32
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJQBS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgGJQBR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFXKTQ192874;
        Fri, 10 Jul 2020 12:01:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpr7e98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFXicF193534;
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpr7e60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AG17Jj003481;
        Fri, 10 Jul 2020 16:01:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 326bc30rk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG15Cs65601838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7651B42042;
        Fri, 10 Jul 2020 16:01:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7AE242041;
        Fri, 10 Jul 2020 16:01:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 0/8] additional "ima-measurement" support
Date:   Fri, 10 Jul 2020 12:00:51 -0400
Message-Id: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=1 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"evmctl ima_measurement" walks the IMA measurement list re-calculating
the TPM PCR banks.

- Support the original method of extending the TPM 2.0 banks with the
  padded SHA1 digest.
- Instead of reading the hardware or software TPM PCRs, support
  providing the TPM 1.2 PCRs as a file.
- Limit the number of messages being emitted while verifying the
  measurement list.
- Reading the TPM PCRs before walking the measurement list guarantees
  the measurement list contains all the records, maybe too many.
- Rename "--list" to "--verify-sig", and update the README. 

Changelog v2:
- limit number of messages
- read PCRs before walking the measurement list
- and other miscellaneous cleanup

Mimi Zohar (8):
  ima-evm-utils: improve reading TPM 1.2 PCRs
  ima_evm_utils: support extending TPM 2.0 banks w/original SHA1 padded
    digest
  ima-evm-utils: support providing the TPM 1.2 PCRs as a file
  ima-evm-utils: emit "ima_measurement" messages based on log level
  ima-evm-utils: guarantee the measurement list contains all the records
  ima-evm-utils: the IMA measurement list may have too many measurements
  ima-evm-utils: optionally verify the template data file signature
  ima-evm-utils: update README to reflect "--pcrs", "--verify" and
    "--validate"

 README       |   6 ++-
 src/evmctl.c | 172 +++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 132 insertions(+), 46 deletions(-)

-- 
2.7.5

