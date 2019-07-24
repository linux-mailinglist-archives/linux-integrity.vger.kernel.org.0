Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2173060
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfGXN6i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 09:58:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbfGXN6i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 09:58:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ODwFtm052322
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 09:58:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2txqnqu9f3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jul 2019 09:58:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 24 Jul 2019 14:56:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Jul 2019 14:56:54 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ODur7w43843748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 13:56:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D031AE057;
        Wed, 24 Jul 2019 13:56:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D974AE056;
        Wed, 24 Jul 2019 13:56:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.178])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jul 2019 13:56:52 +0000 (GMT)
Subject: Exposing the tpm 2.0 PCRs?  (renamed subject)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Wed, 24 Jul 2019 09:56:41 -0400
In-Reply-To: <20190724072420.GA21901@dell5510>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
         <20190723071545.GA26973@x230> <1563894876.14396.120.camel@linux.ibm.com>
         <20190724072420.GA21901@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072413-0028-0000-0000-0000038763B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072413-0029-0000-0000-000024479FBB
Message-Id: <1563976601.4245.32.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=899 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Jarkko]

On Wed, 2019-07-24 at 09:24 +0200, Petr Vorel wrote:
> > > > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > > > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > > > application is required to read PCRs.
> > > OT: anyone aware why TPM 2.0 does not expose PCR banks to userspace via sysfs?
> 
> > TPM 2.0 support is slowly being upstreamed in stages.  Initially the
> > TPM 2.0 event log was not exported.  Assuming that support for
> > exposing the TPM 2.0 PCRs is upstreamed, it doesn't necessarily
> > guarantee that it will be backported to stable.

> Thanks for info. I'm glad it's being addressed :).
> IMHO it'd be backporting it (once upstreamed), let's see.

Clarification, I'm not working on exposing the TPM 2.0 PCRs.  Too much
else to do.

Jarkko, in case you missed this thread, is there any reason why the
TPM 2.0 PCRs can not be exposed to userspace?

thanks,

Mimi

