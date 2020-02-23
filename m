Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED35D16928D
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Feb 2020 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBWBMw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 Feb 2020 20:12:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgBWBMv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 Feb 2020 20:12:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01N1AEJl101022
        for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2020 20:12:50 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb0g1w21r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2020 20:12:50 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 23 Feb 2020 01:12:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Feb 2020 01:12:44 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01N1ChZ458261572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 01:12:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5679AE051;
        Sun, 23 Feb 2020 01:12:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD58AE045;
        Sun, 23 Feb 2020 01:12:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.201.132])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 Feb 2020 01:12:42 +0000 (GMT)
Subject: Re: [RFC PATCH 0/8] ima-evm-utils: calculate per TPM bank template
 digest
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Sat, 22 Feb 2020 20:12:42 -0500
In-Reply-To: <ed6849bf-0988-3807-1b8f-151871f702d1@linux.microsoft.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
         <ed6849bf-0988-3807-1b8f-151871f702d1@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022301-0012-0000-0000-0000038962D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022301-0013-0000-0000-000021C5FEFE
Message-Id: <1582420362.10443.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_08:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002230006
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-21 at 16:11 -0800, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
> > IMA currently extends the different TPM banks by padding/truncating the
> > SHA1 template digest.  Although the IMA measurement list only includes
> > the SHA1 template digest, the template digest could be re-calculated
> > properly for each bank.  Roberto Sassu's proposed "ima: support stronger
> > algorithms for attestation" kernel patch set makes this change.
> > 
> > In order to test the proposed kernel change, this patch set walks the
> > IMA measurement list, re-calculating the per TPM bank template digest
> > and extending the TPM bank PCR with the bank specific digest.  The last
> > step, after walking the measurement list, is comparing the the resulting
> > TPM per bank PCR values with the actual TPM per bank PCR values.
> 
> I have built the kernel with Roberto's patch set and also built evmctl 
> with your patch set.
> 
> Could you please include an example for how evmctl can be used to test 
> Roberto's change?

There are two aspects to Roberto's changes - extending the TPM banks
with the bank specific template digest and verifying the boot
aggregate.  This patch set only addresses the first aspect.

Assuming both the sha1 and sha256 TPM banks are enabled,

# tssgetcapability -cap 5
2 PCR selections
    hash TPM_ALG_SHA1
    TPMS
_PCR_SELECTION length 3
    ff ff ff 
    hash TPM_ALG_SHA256
    TPMS_PC
R_SELECTION length 3
    ff ff ff 

the output would look like:
 
# evmctl ima_measurement -v --list
/sys/kernel/security/integrity/ima/binary_runtime_measurements

sha1: PCRAgg  10: 7723f6d980725507e5d0eb643dc179aae0efb719
sha1: TPM PCR-10: 7723f6d980725507e5d0eb643dc179aae0efb719
sha1 PCR-10: succeed

sha256: PCRAgg  10:
5254d6dce62765f884dc67dac8d59a8721ae14495ae4a0cb73426d0c013a82b2
sha256: TPM PCR-10:
5254d6dce62765f884dc67dac8d59a8721ae14495ae4a0cb73426d0c013a82b2
sha256 PCR-10: succeed

Mimi

