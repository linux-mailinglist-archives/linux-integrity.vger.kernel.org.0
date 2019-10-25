Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91A9E4BF4
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfJYNW2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 09:22:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394578AbfJYNW2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 09:22:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PDKYWi004196
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 09:22:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv0aek7mw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 09:22:24 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 14:22:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 14:22:18 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PDMHfP33226838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 13:22:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66D4711C04C;
        Fri, 25 Oct 2019 13:22:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 244EA11C054;
        Fri, 25 Oct 2019 13:22:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.164.225])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 13:22:16 +0000 (GMT)
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri, 25 Oct 2019 09:22:15 -0400
In-Reply-To: <20191025125202.GA1966@mail.hallyn.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
         <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
         <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
         <20191024172023.GA7948@linux.intel.com>
         <20191024213842.c6cl4tlnsi56pgcy@cantor>
         <1571964420.5173.12.camel@linux.ibm.com>
         <20191025021159.dt7ifgnebnke6ca7@cantor> <20191025085617.GA13329@x230>
         <20191025125202.GA1966@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102513-4275-0000-0000-000003778B3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102513-4276-0000-0000-0000388AB934
Message-Id: <1572009735.4532.17.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=975 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-25 at 07:52 -0500, Serge E. Hallyn wrote:
> On Fri, Oct 25, 2019 at 10:56:17AM +0200, Petr Vorel wrote:
> > Hi,
> > 
> > > /sys/kernel/security/tpmX/major_version (on fedora and rhel at
> least, is it elsewhere on other distros?)

This patch doesn't define a securityfs file.  It must be a soft link
to the actual file.

> > > versus
> > 
> > > /sys/class/tpm/tpmX/major_version

This is a softlink to the TPM device (eg.
/sys/devices/xxxx/.../tpm/tpm0).

> > 
> > Is it more HW related (/sys/class/tpm/tpmX) or LSM related
> > (/sys/kernel/security/tpmX)?
> > I guess /sys/kernel/security/tpmX might be better.
> 
> This is purely about whether the phsyical TPM chip is 1.2 or 2.,
> right?  /sys/class/tpm/tpmX is where I would expect to find that.
> 
> > Thanks for implementing this, I'll try to test it soon.
> 
> Yes, it's been a pain point, and someone (..., I) should have done this years
> ago - thanks!

+1

