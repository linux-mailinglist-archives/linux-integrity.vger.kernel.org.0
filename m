Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2241A8452
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbgDNQOK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 12:14:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389580AbgDNQOD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 12:14:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EGCniM053909
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 12:14:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30bad8wqk4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 12:14:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 Apr 2020 17:10:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 17:10:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EGBEau45023442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 16:11:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70C7A4C044;
        Tue, 14 Apr 2020 16:11:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18EF94C040;
        Tue, 14 Apr 2020 16:11:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.236.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 16:11:12 +0000 (GMT)
Subject: Re: [PATCH] ima: optimize ima_pcr_extend function by asynchronous
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        zhangliguang@linux.alibaba.com, zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kenneth Goldman <kgoldman@us.ibm.com>,
        Monty Wiseman <monty.wiseman@ge.com>,
        David Safford <david.safford@gmail.com>
Date:   Tue, 14 Apr 2020 12:11:12 -0400
In-Reply-To: <20200414115020.99288-1-tianjia.zhang@linux.alibaba.com>
References: <20200414115020.99288-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041416-0016-0000-0000-000003047557
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041416-0017-0000-0000-000033686DEB
Message-Id: <1586880672.7311.212.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_07:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Ken Goldman, Monty Wiseman, and Dave Safford]

On Tue, 2020-04-14 at 19:50 +0800, Tianjia Zhang wrote:
> Because ima_pcr_extend() to operate the TPM chip, this process is
> very time-consuming, for IMA, this is a blocking action, especially
> when the TPM is in self test state, this process will block for up
> to ten seconds.
> 
> Because the return result of ima_pcr_extend() is of no concern to IMA,
> it only affects the audit of IMA, so this patch use async_schedule()
> to asynchronously perform the ima_pcr_extend() operation and do an
> audit operation at the end.
> 
> In a vtpm scenario, I added the measure policy of BPRM and MMAP to
> compare the efficiency before and after applying the patch. The results
> show that the overall startup efficiency of conventional processes can
> be increased by 5% to 10%. I believe this efficiency increase It will
> be more obvious on real hardware tpm.

Yes, we're fully aware that extending the TPM PCR takes a long time.
 That is the reason for a lot of Nayna Jain's and my work on improving
the TPM performance.

At one point, I implemented queueing the measurements without waiting
for the measurements to extend the TPM.  The performance was
absolutely amazing, but not waiting for the TPM extend to complete
violates the trusted boot principle of measuring and extending the TPM
PCR before use.

Secondly, the IMA measurement list order and the order in which the
measurements extend the TPM is really important in order to be able to
validate the IMA measurement list against the TPM PCR quote.

One solution that we've considered is batching the measurements, so
that the TPM PCR is extended with the hash of the batched
measurements, instead of each measurement.  The IMA measurement list
would continue to contain the individual measurements, but would also
need to indicate start/stop of the batched measurement group.  None of
this is trivial.

Mimi

