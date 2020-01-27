Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B948314ABA6
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 22:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0Vbr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 16:31:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgA0Vbr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 16:31:47 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RLFAdY032384
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 16:31:46 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjj1hfes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 16:31:46 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 21:31:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 21:31:41 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RLVevM30605340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 21:31:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B427C11C052;
        Mon, 27 Jan 2020 21:31:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239DE11C04A;
        Mon, 27 Jan 2020 21:31:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 21:31:40 +0000 (GMT)
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Jan 2020 16:31:39 -0500
In-Reply-To: <20200127204941.2ewman4y5nzvkjqe@cantor>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <20200127204941.2ewman4y5nzvkjqe@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012721-0016-0000-0000-000002E13180
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012721-0017-0000-0000-00003343EFBE
Message-Id: <1580160699.5088.64.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_07:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270168
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-27 at 13:49 -0700, Jerry Snitselaar wrote:
> On Mon Jan 27 20, Mimi Zohar wrote:
> >The boot aggregate is a cumulative SHA1 hash over TPM registers 0 - 7.
> >NIST has depreciated the usage of SHA1 in most instances.  Instead of
> >continuing to use SHA1 to calculate the boot_aggregate, use the
> >configured IMA default hash algorithm.
> >
> >Although the IMA measurement list boot_aggregate template data contains
> >the hash algorithm followed by the digest, allowing verifiers (e.g.
> >attesttaion servers) to calculate and verify the boot_aggregate, the
> >verifiers might not have the knowledge of what constitutes a good value
> >based on a different hash algorithm.
> >
> >Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >---
> > security/integrity/ima/ima_init.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >
> >diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> >index 195cb4079b2b..b1b334fe0db5 100644
> >--- a/security/integrity/ima/ima_init.c
> >+++ b/security/integrity/ima/ima_init.c
> >@@ -27,7 +27,7 @@ struct tpm_chip *ima_tpm_chip;
> > /* Add the boot aggregate to the IMA measurement list and extend
> >  * the PCR register.
> >  *
> >- * Calculate the boot aggregate, a SHA1 over tpm registers 0-7,
> >+ * Calculate the boot aggregate, a hash over tpm registers 0-7,
> >  * assuming a TPM chip exists, and zeroes if the TPM chip does not
> >  * exist.  Add the boot aggregate measurement to the measurement
> >  * list and extend the PCR register.
> >@@ -51,14 +51,14 @@ static int __init ima_add_boot_aggregate(void)
> > 	int violation = 0;
> > 	struct {
> > 		struct ima_digest_data hdr;
> >-		char digest[TPM_DIGEST_SIZE];
> >+		char digest[TPM_MAX_DIGEST_SIZE];
> > 	} hash;
> >
> > 	memset(iint, 0, sizeof(*iint));
> > 	memset(&hash, 0, sizeof(hash));
> > 	iint->ima_hash = &hash.hdr;
> >-	iint->ima_hash->algo = HASH_ALGO_SHA1;
> >-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
> >+	iint->ima_hash->algo = ima_hash_algo;
> >+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
> >
> > 	if (ima_tpm_chip) {
> > 		result = ima_calc_boot_aggregate(&hash.hdr);
> >-- 
> >2.7.5
> >
> 
> Tested the patches on the Dell and no longer spits out the error messages on boot.
> /sys/kernel/security/ima/ascii_runtime_measurements shows the boot aggregate.
> 
> Is there something else I should look at to verify it is functioning properly?

The original LTP ima_boot_aggregate.c test needed to be updated to
support TPM 2.0 before this change.  For TPM 2.0, the PCRs are not
exported.  With this change, the kernel could be reading PCRs from a
TPM bank other than SHA1 and calculating the boot_aggregate based on a
different hash algorithm as well.  I'm not sure how a remote verifier
would know which TPM bank was read, when calculating the boot-
aggregate.

At the moment, the only test would be to make sure that the LTP test
still works for TPM 1.2 properly.

Mimi

