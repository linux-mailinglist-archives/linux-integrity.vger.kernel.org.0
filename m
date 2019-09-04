Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD28A8116
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2019 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDLbI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Sep 2019 07:31:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbfIDLbI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Sep 2019 07:31:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84BS0M6141677
        for <linux-integrity@vger.kernel.org>; Wed, 4 Sep 2019 07:31:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ut9q8p4s1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Sep 2019 07:31:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 4 Sep 2019 12:31:04 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 12:31:00 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x84BUxkv40239168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 11:30:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD11E42042;
        Wed,  4 Sep 2019 11:30:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9F4E42047;
        Wed,  4 Sep 2019 11:30:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.171.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 11:30:58 +0000 (GMT)
Subject: Re: TPM 2.0 Linux sysfs interface
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jordan Hand <jorhand@linux.microsoft.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed, 04 Sep 2019 07:30:58 -0400
In-Reply-To: <20190904055829.GA3936@ziepe.ca>
References: <20190827010559.GA31752@ziepe.ca>
         <1567007592.6115.58.camel@linux.ibm.com> <20190828161502.GC933@ziepe.ca>
         <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
         <20190902192632.GB5393@ziepe.ca> <1567460118.10024.316.camel@linux.ibm.com>
         <20190903055523.GA4500@ziepe.ca>
         <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
         <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
         <1567553383.4937.29.camel@linux.ibm.com> <20190904055829.GA3936@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090411-0008-0000-0000-00000310ECDB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090411-0009-0000-0000-00004A2F4215
Message-Id: <1567596658.4937.40.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040117
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-04 at 02:58 -0300, Jason Gunthorpe wrote:
> On Tue, Sep 03, 2019 at 07:29:43PM -0400, Mimi Zohar wrote:
> 
> > This discussion is going around in circles.  There are enough people
> > asking that the kernel provide at least the TPM version (eg. TPM 1.2
> > or TPM 2.0).  Userspace applications/regression tests shouldn't have
> > to figure out the TPM version by sending a TPM command and seeing if
> > it fails.  That really isn't asking a lot.
> 
> A single version number could be appropriate for sysfs
>  
> > I would also prefer not having to be dependent on a userspace
> > application to read the TPM PCRs in order to verify the IMA
> > measurement list.
> 
> Why?

Being dependent on a userspace application implies a level of trust,
that might not be warranted, depending on the system's configuration.

Mimi

