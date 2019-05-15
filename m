Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB41E701
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEODBi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 23:01:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbfEODBi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 23:01:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4F2pbnJ087797
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 23:01:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sg5r22921-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 23:01:37 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 15 May 2019 04:01:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 04:01:32 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4F31VZY48824410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 03:01:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C849F11C064;
        Wed, 15 May 2019 03:01:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B32E111C04C;
        Wed, 15 May 2019 03:01:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 03:01:30 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>
Cc:     Fabian Vogt <FVogt@suse.com>, Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Tue, 14 May 2019 23:01:19 -0400
In-Reply-To: <20190514121213.GA28655@dell5510>
References: <20190405165225.27216-1-pvorel@suse.cz>
         <20190514121213.GA28655@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051503-4275-0000-0000-00000334D944
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051503-4276-0000-0000-000038445B38
Message-Id: <1557889279.4581.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150015
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-05-14 at 14:12 +0200, Petr Vorel wrote:
> Hi Mimi, Ignaz,
> 
> Mimi, could you please have a second look on this [4] patchset? We've had a
> discussion about second patch [5], I can drop it if you don't like it, but
> that's not a main concern about this test. More important is whether the
> testcase looks valid for you. It's about overlayfs broken in IMA+EVM,
> which is currently broken on mainline.

The first two patches are fine.  From the test, I'm seeing the
following results:

evm_overlay 1 TINFO: overwrite file in overlay
tst_rod: Failed to open '(null)' for writing: Operation not permitted
evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly
evm_overlay 2 TINFO: append file in overlay: mntpoint/lower/foo2.txt
evm_overlay 2 TPASS: echo overlay >> mntpoint/merged/foo2.txt passed as expected
evm_overlay 3 TINFO: create a new file in overlay
evm_overlay 3 TPASS: echo overlay > mntpoint/merged/foo3.txt passed as expected
evm_overlay 4 TINFO: read all created files
evm_overlay 4 TFAIL: cat mntpoint/merged/foo1.txt > /dev/null 2> /dev/null failed unexpectedly
evm_overlay 4 TFAIL: cat mntpoint/merged/foo2.txt > /dev/null 2> /dev/null failed unexpectedly
evm_overlay 4 TFAIL: cat mntpoint/merged/foo3.txt > /dev/null 2> /dev/null failed unexpectedly
evm_overlay 5 TINFO: SELinux enabled in enforcing mode, this may affect test results
evm_overlay 5 TINFO: You can try to disable it with TST_DISABLE_SELINUX=1 (requires super/root)
evm_overlay 5 TINFO: loaded SELinux profiles: none

With "evm: instead of using the overlayfs i_ino, use the real i_ino"
patch, I'm only seeing the first failure.

Mimi


> There is different reproducer (C code) for a slightly different scenario,
> but I'm not going to port it before this got merged.
> 
> Ignaz, could you please test this patchset? Could you, please, share your setup?
> ima_policy=appraise_tcb kernel parameter and loading IMA and EVM keys over
> dracut-ima scripts? (IMA appraisal and EVM using digital signatures? I guess
> using hashes for IMA appraisal would work as well).
> 
> Kind regards,
> Petr
> 
> > this is a second version of patch demonstrating a bug on overlayfs when
> > combining IMA with EVM. There is ongoing work made by Ignaz Forster and
> > Fabian Vogt [1] [2], IMA only behavior was already fixed [3].
> 
> > Main patch is the last one (previous are just a cleanup and not changed).
> 
> > [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> > [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> > [3] https://patchwork.kernel.org/patch/10776231/
> 
> [4] https://patchwork.ozlabs.org/project/ltp/list/?series=101213&state=*
> [5] https://patchwork.ozlabs.org/patch/1078553/
> 

