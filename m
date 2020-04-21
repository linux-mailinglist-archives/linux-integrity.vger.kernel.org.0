Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EEF1B328E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 00:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDUWRU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 18:17:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgDUWRU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 18:17:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LM3FMo063167
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 18:17:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gfec1edu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 18:17:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 21 Apr 2020 23:16:31 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 23:16:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LMHCXp2621870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 22:17:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BF304204C;
        Tue, 21 Apr 2020 22:17:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E88A4203F;
        Tue, 21 Apr 2020 22:17:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.238.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 22:17:11 +0000 (GMT)
Subject: Re: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Benoit HOUYERE <benoit.houyere@st.com>,
        Omar Sandoval <osandov@osandov.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Date:   Tue, 21 Apr 2020 18:17:10 -0400
In-Reply-To: <3766ead79aa4415198bc5a8324f02f6e@SFHDAG3NODE3.st.com>
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
         <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
         <20200416190249.GC701157@vader> <1587476664.5149.14.camel@linux.ibm.com>
         <3766ead79aa4415198bc5a8324f02f6e@SFHDAG3NODE3.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042122-0016-0000-0000-00000308D887
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042122-0017-0000-0000-0000336CF183
Message-Id: <1587507430.5053.16.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_09:2020-04-21,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-21 at 20:56 +0000, Benoit HOUYERE wrote:

> Issue occurs on several legacy models and corrected on latest TPM
> versions. Several corrections are possible. Omar's proposal is quite
> simple, short and efficient. Penalty time is only condition check
> but for all TPM_status access.
> 
> Other possibility  is to check status register validity (bit 5 is
> always at 0) at the first reading and modify wait_for_stat function
> (already inserted for I2C patch).

Benoit, thank you for the explanation.

It sounds like by "already inserted for I2C patch", you mean that this
proposed solution is part of the i2c patch set.  If that is the case,
to simplify backporting, the fix should be the first patch in the i2c
patch set.

Mimi

