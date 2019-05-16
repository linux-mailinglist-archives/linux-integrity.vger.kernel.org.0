Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8873421074
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 00:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEPWLI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 18:11:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbfEPWLI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 18:11:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GLv9qw112452
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 18:11:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shdrrwyms-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 18:11:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 May 2019 23:11:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 23:11:02 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GMB1Pg31064128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 22:11:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D71DA4053;
        Thu, 16 May 2019 22:11:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 565DDA405B;
        Thu, 16 May 2019 22:11:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.98])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 May 2019 22:11:00 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Thu, 16 May 2019 18:10:49 -0400
In-Reply-To: <20190515120853.GA22992@dell5510>
References: <20190405165225.27216-1-pvorel@suse.cz>
         <20190514121213.GA28655@dell5510> <1557889279.4581.14.camel@linux.ibm.com>
         <20190515120853.GA22992@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051622-0008-0000-0000-000002E77CF2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051622-0009-0000-0000-00002254245D
Message-Id: <1558044649.4507.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Wed, 2019-05-15 at 14:08 +0200, Petr Vorel wrote:
> > evm_overlay 1 TINFO: overwrite file in overlay
> > tst_rod: Failed to open '(null)' for writing: Operation not permitted
> > evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly

> I've fixed '(null)' [1], with that one applied it should be 'mntpoint/merged/foo1.txt'

Thanks!

> But what is strange to me is that it continues to execute second line. return 1 [2]
> should cause ROD() to quit with TBROK [3].
> Maybe that ROD in test1() should be replaced EXPECT_PASS.

With just the first patch of Ignaz's path set [1] and the TPM 2.0 test
[2], there aren't any errors.  Without [1], it's now failing with the
correct name.  I'm now seeing:

evm_overlay 1 TINFO: $TMPDIR is on tmpfs => run on loop device
evm_overlay 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
evm_overlay 1 TINFO: overwrite file in overlay
tst_rod: Failed to open 'mntpoint/merged/foo1.txt' for writing: Permission denied
evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly

Mimi

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://lore.kernel.org/linux-integrity/1558041162.3971.2.camel@linux.ibm.com/T/#u

