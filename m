Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0D4C9ED7
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 14:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfJCMvG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 08:51:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbfJCMvG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 08:51:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x93ClGKP084803
        for <linux-integrity@vger.kernel.org>; Thu, 3 Oct 2019 08:51:05 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vdgfr242v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 03 Oct 2019 08:51:05 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 3 Oct 2019 13:51:03 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Oct 2019 13:50:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x93CovpO59375778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Oct 2019 12:50:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70CC1AE04D;
        Thu,  3 Oct 2019 12:50:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A59AE045;
        Thu,  3 Oct 2019 12:50:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.158])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Oct 2019 12:50:55 +0000 (GMT)
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Oct 2019 08:50:54 -0400
In-Reply-To: <20191003113506.GE8933@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
         <1569420226.3642.24.camel@HansenPartnership.com>
         <20190927130657.GA5556@linux.intel.com>
         <1570020105.4999.106.camel@linux.ibm.com>
         <20191003113506.GE8933@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100312-0016-0000-0000-000002B3AE87
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100312-0017-0000-0000-00003314B8A6
Message-Id: <1570107054.4421.174.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910030119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-03 at 14:35 +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 02, 2019 at 08:41:45AM -0400, Mimi Zohar wrote:
> > On Fri, 2019-09-27 at 16:06 +0300, Jarkko Sakkinen wrote:
> > > On Wed, Sep 25, 2019 at 10:03:46AM -0400, James Bottomley wrote:
> > > > On Wed, 2019-09-25 at 16:48 +0300, Jarkko Sakkinen wrote:
> > > > [...]
> > > > > +	data_page = alloc_page(GFP_HIGHUSER);
> > > > > +	if (!data_page)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	data_ptr = kmap(data_page);
> > > > 
> > > > I don't think this is such a good idea.  On 64 bit it's no different
> > > > from GFP_KERNEL and on 32 bit where we do have highmem, kmap space is
> > > > at a premium, so doing a highmem allocation + kmap is more wasteful of
> > > > resources than simply doing GFP_KERNEL.  In general, you should only do
> > > > GFP_HIGHMEM if the page is going to be mostly used by userspace, which
> > > > really isn't the case here.
> > > 
> > > Changing that in this commit would be wrong even if you are right.
> > > After this commit has been applied it is somewhat easier to make
> > > best choices for allocation in each call site (probably most will
> > > end up using stack).
> > 
> > Agreed, but it could be a separate patch, prior to this one.  Why
> > duplicate the problem all over only to change it later?
> 
> What problem exactly it is duplicating? The existing allocation
> scheme here works correctly.

In the current code "alloc_page(GFP_HIGHUSER)" exists in a single
function.  With this patch, "alloc_page(GFP_HIGHUSER)" is duplicated
24 times.  If it is incorrect and we shouldn't be using GFP_HIGHUSER,
as James said, then why duplicate it 24 times?  Fix it as a separate
patch first, that could be backported if needed, and then make the
change.

Mimi

