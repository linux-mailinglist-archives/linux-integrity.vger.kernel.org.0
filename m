Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D395EB3985
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfIPLg5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 07:36:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbfIPLg4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 07:36:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8GBWD0h050354
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 07:36:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v29kw84ug-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 07:36:55 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 16 Sep 2019 12:36:53 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Sep 2019 12:36:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8GBanJ545285602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 11:36:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 459124204B;
        Mon, 16 Sep 2019 11:36:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CE8042042;
        Mon, 16 Sep 2019 11:36:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.178])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Sep 2019 11:36:48 +0000 (GMT)
Subject: Re: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Mon, 16 Sep 2019 07:36:48 -0400
In-Reply-To: <20190916074805.GA26608@linux.intel.com>
References: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
         <1568157876.4991.3.camel@linux.ibm.com>
         <1568203240.5783.8.camel@linux.ibm.com>
         <20190913140820.GC29755@linux.intel.com>
         <1568580742.5055.0.camel@linux.ibm.com>
         <1568604471.4975.8.camel@linux.ibm.com>
         <20190916073552.GD4859@linux.intel.com>
         <20190916074805.GA26608@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091611-0016-0000-0000-000002AC9112
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091611-0017-0000-0000-0000330D2EFC
Message-Id: <1568633808.4975.19.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-09-16 at 10:48 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 16, 2019 at 10:35:52AM +0300, Jarkko Sakkinen wrote:
> > On Sun, Sep 15, 2019 at 11:27:51PM -0400, Mimi Zohar wrote:
> > > On Sun, 2019-09-15 at 16:52 -0400, Mimi Zohar wrote:
> > > > On Fri, 2019-09-13 at 15:08 +0100, Jarkko Sakkinen wrote:
> > > > > On Wed, Sep 11, 2019 at 08:00:40AM -0400, Mimi Zohar wrote:
> > > > > > On Tue, 2019-09-10 at 19:24 -0400, Mimi Zohar wrote:
> > > > > > > On Tue, 2019-09-10 at 19:18 -0400, Mimi Zohar wrote:
> > > > > > > > Create, save and load trusted keys test
> > > > > > > 
> > > > > > > Creating trusted keys is failing with the following messages.  Any idea why?
> > > > > > > 
> > > > > > > [  147.014653] tpm tpm0: A TPM error (34) occurred attempting to a send a command
> > > > > > > [  147.014678] trusted_key: srkseal failed (-1)
> > > > > > > [  147.014687] trusted_key: key_seal failed (-1)
> > > > > > 
> > > > > > This is a regression, that needs to be resolved.  The test works on
> > > > > > kernels prior to 5.1.
> > > > > 
> > > > > It breaks on 5.2?
> > > > 
> > > > No, the regression is in 5.1.
> > > > 
> > > > > 
> > > > > Can you bisect the failing commit?
> > > > 
> > > > git bisect start -- drivers/char/tpm/
> > > > git bisect bad
> > > > git bisect good v5.0 
> > > > 
> > > > # first bad commit: [412eb585587a1dc43c9622db79de9663b6c4c238] tpm:
> > > > use tpm_buf in tpm_transmit_cmd() as the IO parameter
> > > 
> > > In tpm_send(), setting buf.data directly to cmd, instead of calling
> > > tpm_buf_init() fixes the problem.
> > 
> > I see. Obviously memcpy() does not tpm_buf length. The implementation is
> > kind of clunky but the point is to move building the tpm_buf to the
> > caller (which is soon possible thanks to Sumit's patches).
> > 
> > I sent a fix candidate.
> 
> Ugh. Sorry about the "fix candidate". Your fix is the way it should be
> done. I'll put background to it once I've slept a bit.

After trying different approaches that didn't work, I was about to
give up .  It was late, but at the last second, I tried this.  Glad it
works.

thanks,

Mimi

