Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1571C88EF
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfJBMl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 08:41:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfJBMl4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 08:41:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92CdXRv118903
        for <linux-integrity@vger.kernel.org>; Wed, 2 Oct 2019 08:41:55 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vcshc4x1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 08:41:55 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 2 Oct 2019 13:41:52 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 13:41:48 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x92Cfl5p46006340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 12:41:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F5E4C04E;
        Wed,  2 Oct 2019 12:41:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E05BA4C044;
        Wed,  2 Oct 2019 12:41:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.231])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Oct 2019 12:41:45 +0000 (GMT)
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Oct 2019 08:41:45 -0400
In-Reply-To: <20190927130657.GA5556@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
         <1569420226.3642.24.camel@HansenPartnership.com>
         <20190927130657.GA5556@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100212-0008-0000-0000-0000031D5493
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100212-0009-0000-0000-00004A3C57B4
Message-Id: <1570020105.4999.106.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-27 at 16:06 +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 25, 2019 at 10:03:46AM -0400, James Bottomley wrote:
> > On Wed, 2019-09-25 at 16:48 +0300, Jarkko Sakkinen wrote:
> > [...]
> > > +	data_page = alloc_page(GFP_HIGHUSER);
> > > +	if (!data_page)
> > > +		return -ENOMEM;
> > > +
> > > +	data_ptr = kmap(data_page);
> > 
> > I don't think this is such a good idea.  On 64 bit it's no different
> > from GFP_KERNEL and on 32 bit where we do have highmem, kmap space is
> > at a premium, so doing a highmem allocation + kmap is more wasteful of
> > resources than simply doing GFP_KERNEL.  In general, you should only do
> > GFP_HIGHMEM if the page is going to be mostly used by userspace, which
> > really isn't the case here.
> 
> Changing that in this commit would be wrong even if you are right.
> After this commit has been applied it is somewhat easier to make
> best choices for allocation in each call site (probably most will
> end up using stack).

Agreed, but it could be a separate patch, prior to this one.  Why
duplicate the problem all over only to change it later?

Mimi

