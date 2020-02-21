Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925BA1686CE
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgBUSju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgBUSju (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:50 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIdkuW088309
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:48 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yac0uar8d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:47 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:06 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LId5jO53412070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACC07AE055;
        Fri, 21 Feb 2020 18:39:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A197FAE04D;
        Fri, 21 Feb 2020 18:39:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 0/8] ima-evm-utils: calculate per TPM bank template digest 
Date:   Fri, 21 Feb 2020 13:38:50 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 20022118-4275-0000-0000-000003A443FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-4276-0000-0000-000038B853E9
Message-Id: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=1
 mlxlogscore=777 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002210141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA currently extends the different TPM banks by padding/truncating the
SHA1 template digest.  Although the IMA measurement list only includes
the SHA1 template digest, the template digest could be re-calculated
properly for each bank.  Roberto Sassu's proposed "ima: support stronger
algorithms for attestation" kernel patch set makes this change.

In order to test the proposed kernel change, this patch set walks the
IMA measurement list, re-calculating the per TPM bank template digest
and extending the TPM bank PCR with the bank specific digest.  The last
step, after walking the measurement list, is comparing the the resulting
TPM per bank PCR values with the actual TPM per bank PCR values.

(Verifying the non SHA1 TPM banks depends on a kernel built with
Roberto's "ima: support stronger algorithms for attestation" patch set.)

Mimi

Mimi Zohar (8):
  ima-evm-utils: treat unallocated banks as an error
  ima-evm-utils: increase the size of "zero" and "fox" variables
  ima-evm-utils: calculate the digests for multiple TPM banks
  ima-evm-utils: add support in tpm2_read_pcrs to read different TPM
    banks
  ima-evm-utils: read the PCRs for the requested TPM banks
  ima-evm-utils: compare re-calculated PCRs with the TPM values
  ima-evm-utils: use a common bank variable for TPM 1.2 and TPM 2.0
  ima-evm-utils: remove TPM 1.2 specific code

 src/evmctl.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 284 insertions(+), 65 deletions(-)

-- 
2.7.5

