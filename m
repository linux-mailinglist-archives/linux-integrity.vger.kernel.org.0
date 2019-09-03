Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A1A778E
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2019 01:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfICX3v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 19:29:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfICX3v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 19:29:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83NQoTS058850
        for <linux-integrity@vger.kernel.org>; Tue, 3 Sep 2019 19:29:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ut0mcsug1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 19:29:49 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 4 Sep 2019 00:29:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 00:29:45 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83NTjqP49741886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 23:29:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC488A405C;
        Tue,  3 Sep 2019 23:29:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF82A4054;
        Tue,  3 Sep 2019 23:29:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.35])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 23:29:43 +0000 (GMT)
Subject: Re: TPM 2.0 Linux sysfs interface
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue, 03 Sep 2019 19:29:43 -0400
In-Reply-To: <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
         <20190827010559.GA31752@ziepe.ca> <1567007592.6115.58.camel@linux.ibm.com>
         <20190828161502.GC933@ziepe.ca>
         <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
         <20190902192632.GB5393@ziepe.ca> <1567460118.10024.316.camel@linux.ibm.com>
         <20190903055523.GA4500@ziepe.ca>
         <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
         <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090323-0008-0000-0000-00000310A84C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090323-0009-0000-0000-00004A2EFB99
Message-Id: <1567553383.4937.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030236
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

(Cc'ing Alexy)

On Tue, 2019-09-03 at 15:40 -0700, Jordan Hand wrote:
> On 9/3/19 9:23 AM, Tadeusz Struk wrote:
> > On 9/2/19 10:55 PM, Jason Gunthorpe wrote:
> >> On Mon, Sep 02, 2019 at 05:35:18PM -0400, Mimi Zohar wrote:
> >>> On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
> >>>> On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> >>>>> On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> >>>>>>>> So exposing PCRs and things through sysfs is not going to happen.
> >>>>>>>>
> >>>>>>>> If you had some very narrowly defined things like version, then
> >>>>>>>> *maybe* but I think a well defined use case is needed for why this
> >>>>>>>> needs to be sysfs and can't be done in C as Jarkko explained.
> >>>>>>> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> >>>>>>> TPM 2.0 is a reasonable request and probably could be implemented on
> >>>>>>> TPM registration.
> >>>>>>>
> >>>>>>> If exposing the PCRs through sysfs is not acceptable, then perhaps
> >>>>>>> suggest an alternative.
> >>>>>> Use the char dev, this is exactly what is is for.
> >>>>>
> >>>>> What about a new /proc entry?
> >>>>> Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> >>>>> What about adding a new /proc/tpminfo that would print info like
> >>>>> version, number of enabled PCR banks, physical interface [tis|crb],
> >>>>> vendor, etc.
> >>>>
> >>>> I thought we were not really doing new proc entries?
> >>>>
> >>>> Why this focus on making some textual output?
> >>>
> >>> I don't really care if we define procfs, sysfs, or securityfs file(s)
> >>> or whether those files are ascii or binary.  Whatever is defined,
> >>> should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).
> >>
> >> Use an ioctl on the char dev?
> > 
> > The advantage of /proc/tpminfo would be that it can be a first
> > entry point on a system, that would give general overview of the
> > system TPM configuration, without the need of poking /dev/tpm<N>
> > files, only to find out that the TPM doesn't understand the
> > command, because it implements different version of TCG spec.
> > It would be a single point of information in case of multiple TPMs.
> > It can have some predefined format that could be read by a human
> > as well as a machine, e.g.
> > 
> > tpm0:
> >    version: 2.0
> >    physical interface: CRB
> >    supported PCR banks: SHA1, SHA256
> >    ...
> >    vendor: <Vendor Name>
> >    vendor specific: <Vendor specific output>

Agreed, but Alexey, the "proc" maintainer, and Jarrko need to agree. 

> >
> To me it still feels trivial write an application to do this same thing
> in userspace with ioctls to the char device (figure out what interface
> the TPM is using, get basic capabilities, etc.). There isn't anything
> here that the kernel can do that can't be done from userspace that I can
> see. Is this not true? Maybe its less code in the kernel but I don't
> know that that's a great reason.
> 
> I don't see a clear advantage to putting the code in the kernel, but I
> do see disadvantages. Interfaces between kernel and userspace need to be
> more rigid to avoid breakage.

This discussion is going around in circles.  There are enough people
asking that the kernel provide at least the TPM version (eg. TPM 1.2
or TPM 2.0).  Userspace applications/regression tests shouldn't have
to figure out the TPM version by sending a TPM command and seeing if
it fails.  That really isn't asking a lot.

I would also prefer not having to be dependent on a userspace
application to read the TPM PCRs in order to verify the IMA
measurement list.

Mimi

