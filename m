Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61989B3219
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2019 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfIOUwb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Sep 2019 16:52:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfIOUwb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Sep 2019 16:52:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8FKpsHG025745
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2019 16:52:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v1v600fy8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 15 Sep 2019 16:52:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 15 Sep 2019 21:52:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Sep 2019 21:52:24 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8FKqN7Z51773572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 20:52:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B189042042;
        Sun, 15 Sep 2019 20:52:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C51842041;
        Sun, 15 Sep 2019 20:52:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.212.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 15 Sep 2019 20:52:22 +0000 (GMT)
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Sun, 15 Sep 2019 16:52:22 -0400
In-Reply-To: <20190913140820.GC29755@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
         <1568157876.4991.3.camel@linux.ibm.com>
         <1568203240.5783.8.camel@linux.ibm.com>
         <20190913140820.GC29755@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091520-0020-0000-0000-0000036D236C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091520-0021-0000-0000-000021C2BEA7
Message-Id: <1568580742.5055.0.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909150229
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-13 at 15:08 +0100, Jarkko Sakkinen wrote:
> On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
> > On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
> > > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
> > > > Create, save and load trusted keys test
> > > 
> > > Creating trusted keys is failing with the following messages.  Any idea why?
> > > 
> > > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a send a command
> > > [  147.014678] trusted_key: srkseal failed (-1)
> > > [  147.014687] trusted_key: key_seal failed (-1)
> > 
> > This is a regression, that needs to be resolved.  The test works on
> > kernels prior to 5.1.
> 
> It breaks on 5.2?

No, the regression is in 5.1.

> 
> Can you bisect the failing commit?

git bisect start -- drivers/char/tpm/
git bisect bad
git bisect good v5.0 

# first bad commit: [412eb585587a1dc43c9622db79de9663b6c4c238] tpm:
use tpm_buf in tpm_transmit_cmd() as the IO parameter

Mimi

