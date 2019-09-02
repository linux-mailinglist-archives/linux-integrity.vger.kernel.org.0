Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23C7A5D95
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 23:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfIBVf0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 17:35:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbfIBVfZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 17:35:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x82LW4fA028398
        for <linux-integrity@vger.kernel.org>; Mon, 2 Sep 2019 17:35:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2us5ynfnye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Sep 2019 17:35:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Sep 2019 22:35:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Sep 2019 22:35:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x82LZKsL38731980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Sep 2019 21:35:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2CE211C04C;
        Mon,  2 Sep 2019 21:35:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520C011C04A;
        Mon,  2 Sep 2019 21:35:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.123])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Sep 2019 21:35:19 +0000 (GMT)
Subject: Re: TPM 2.0 Linux sysfs interface
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 02 Sep 2019 17:35:18 -0400
In-Reply-To: <20190902192632.GB5393@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
         <20190827010559.GA31752@ziepe.ca> <1567007592.6115.58.camel@linux.ibm.com>
         <20190828161502.GC933@ziepe.ca>
         <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
         <20190902192632.GB5393@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090221-0016-0000-0000-000002A5D648
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090221-0017-0000-0000-000033063A65
Message-Id: <1567460118.10024.316.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909020242
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> > On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> > >>> So exposing PCRs and things through sysfs is not going to happen.
> > >>>
> > >>> If you had some very narrowly defined things like version, then
> > >>> *maybe* but I think a well defined use case is needed for why this
> > >>> needs to be sysfs and can't be done in C as Jarkko explained.
> > >> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> > >> TPM 2.0 is a reasonable request and probably could be implemented on
> > >> TPM registration.
> > >>
> > >> If exposing the PCRs through sysfs is not acceptable, then perhaps
> > >> suggest an alternative.
> > > Use the char dev, this is exactly what is is for.
> > 
> > What about a new /proc entry?
> > Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> > What about adding a new /proc/tpminfo that would print info like
> > version, number of enabled PCR banks, physical interface [tis|crb],
> > vendor, etc.
> 
> I thought we were not really doing new proc entries?
> 
> Why this focus on making some textual output?

I don't really care if we define procfs, sysfs, or securityfs file(s)
or whether those files are ascii or binary.  Whatever is defined,
should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).

Mimi

