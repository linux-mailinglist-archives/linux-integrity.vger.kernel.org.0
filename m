Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213BE288D43
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbgJIPsV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 11:48:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45128 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389144AbgJIPsU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 11:48:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099FWvFD177550
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 11:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=RyO5badgUT3UQu8cVOS8+mYAL7AEGFr+3sUqf7O3mzM=;
 b=YQuQ/mQO9sxbfEsWRHNl9nD4zAqgfqAqOWfpfHI2ZfVa7S+E/wQK/dX4bLd4kGJ8FTX4
 AyIM8QPtStEiFt1fKctkEoslBXEpiCa8POwWDyQA2lXNkgZG/sibqxp76/werzGbDLGt
 1Cyx9sSy0jwzWqbhaNm8veXveODSRGCc+tW1gyNl+jU8R4HOs9H2ZR3vuya4bV9pAbe1
 klHE6RE6nSMMt55qFSTmLcktuz8/Tg4VV/b3yW6+u+zYVcyruP9q6WvHgkuI891NXrls
 QAWLAR1Yirp84TNA5H+bQpHkf4hpmY9DyWcpQYRi6tFAfEVtP+gIYyMb32HQMo4rgJZG ww== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342smfas4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 11:48:18 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099FgRFv011275
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:48:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 3429j36cn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 15:48:18 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099FmHcR15728988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:48:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81547C6057
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:48:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56B81C605A
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:48:17 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:48:17 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 0/5] Updates to use IBM TSS C API rather than command line
 tools
Message-ID: <ef2ecc38-46d0-a969-9945-a7868564739d@linux.ibm.com>
Date:   Fri, 9 Oct 2020 11:48:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=876
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set replaces calls to command line tools with C code.  This
should be more stable and easier to maintain.  INSTALL instructions
are updated.

While the code is being touched, it changes the PCR handle from
a signed int to a uint32_t, removing the need for error checking.

Finally, it fixes an environment variable issue and some spelling
errors.

Ken Goldman (5):
   ima-evm-utils: Change env variable TPM_SERVER_TYPE for tpm_server
   ima-evm-utils: Change PCR iterator from int to uint32_t
   ima-evm-utils: Change tpm2_pcr_read() to use C code
   ima-evm-utils: Correct spelling errors
   ima-evm-utils: Expand the INSTALL instructions.

  INSTALL                   |  25 +++++-
  src/Makefile.am           |   1 +
  src/evmctl.c              |   9 ++-
  src/pcr.h                 |   2 +-
  src/pcr_tss.c             |   4 +-
  src/pcr_tsspcrread.c      | 156 +++++++++++++++++++++++++++++---------
  tests/boot_aggregate.test |   7 +-
  7 files changed, 159 insertions(+), 45 deletions(-)

-- 
2.25.1
