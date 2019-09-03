Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B2EA67C6
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfICLtO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 07:49:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbfICLtO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 07:49:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83BlOA3010573
        for <linux-integrity@vger.kernel.org>; Tue, 3 Sep 2019 07:49:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usnv9brxj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 07:49:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Sep 2019 12:49:10 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 12:49:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83Bmik239649566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 11:48:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC70A5204E;
        Tue,  3 Sep 2019 11:49:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.181.32])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0ECF35204F;
        Tue,  3 Sep 2019 11:49:06 +0000 (GMT)
Subject: Re: TPM 2.0 Linux sysfs interface
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 03 Sep 2019 07:49:06 -0400
In-Reply-To: <20190903055523.GA4500@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
         <20190827010559.GA31752@ziepe.ca> <1567007592.6115.58.camel@linux.ibm.com>
         <20190828161502.GC933@ziepe.ca>
         <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
         <20190902192632.GB5393@ziepe.ca> <1567460118.10024.316.camel@linux.ibm.com>
         <20190903055523.GA4500@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090311-0020-0000-0000-0000036717B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090311-0021-0000-0000-000021BC80D8
Message-Id: <1567511346.10024.365.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-03 at 02:55 -0300, Jason Gunthorpe wrote:
> On Mon, Sep 02, 2019 at 05:35:18PM -0400, Mimi Zohar wrote:
> > On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> > > > On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> > > > >>> So exposing PCRs and things through sysfs is not going to happen.
> > > > >>>
> > > > >>> If you had some very narrowly defined things like version, then
> > > > >>> *maybe* but I think a well defined use case is needed for why this
> > > > >>> needs to be sysfs and can't be done in C as Jarkko explained.
> > > > >> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> > > > >> TPM 2.0 is a reasonable request and probably could be implemented on
> > > > >> TPM registration.
> > > > >>
> > > > >> If exposing the PCRs through sysfs is not acceptable, then perhaps
> > > > >> suggest an alternative.
> > > > > Use the char dev, this is exactly what is is for.
> > > > 
> > > > What about a new /proc entry?
> > > > Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> > > > What about adding a new /proc/tpminfo that would print info like
> > > > version, number of enabled PCR banks, physical interface [tis|crb],
> > > > vendor, etc.
> > > 
> > > I thought we were not really doing new proc entries?
> > > 
> > > Why this focus on making some textual output?
> > 
> > I don't really care if we define procfs, sysfs, or securityfs file(s)
> > or whether those files are ascii or binary.  Whatever is defined,
> > should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).
> 
> Use an ioctl on the char dev?

Both TPM 1.2 and TPM 2.0 export the TPM event log as
security/tpmX/binary_bios_measurements.  Wouldn't it make more sense
to group the TPM information together, exporting other TPM information
as securityfs files?

Mimi

