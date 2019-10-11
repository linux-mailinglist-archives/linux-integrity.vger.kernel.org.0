Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5988FD44ED
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJKQEC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 12:04:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbfJKQEC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 12:04:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9BG2ZCh111730;
        Fri, 11 Oct 2019 12:03:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vjtbx77bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 12:03:56 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9BG3tNG116134;
        Fri, 11 Oct 2019 12:03:55 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vjtbx77av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 12:03:55 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9BG1Ysf005873;
        Fri, 11 Oct 2019 16:03:56 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 2vejt7msfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 16:03:56 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9BG3rF339387416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 16:03:53 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79425C605F;
        Fri, 11 Oct 2019 16:03:53 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6AFCC6057;
        Fri, 11 Oct 2019 16:03:51 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.184.117])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 11 Oct 2019 16:03:51 +0000 (GMT)
Message-ID: <1570809830.24157.2.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
From:   James Bottomley <jejb@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Oct 2019 09:03:50 -0700
In-Reply-To: <20191009213559.GA30044@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
         <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
         <1570148716.10818.19.camel@linux.ibm.com>
         <20191006095005.GA7660@linux.intel.com>
         <1570475528.4242.2.camel@linux.ibm.com>
         <20191009213559.GA30044@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=727 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910110145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-10-10 at 00:36 +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 07, 2019 at 12:12:08PM -0700, James Bottomley wrote:
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Subject: [PATCH] tpm: use GFP kernel for tpm_buf allocations
> > 
> > The current code uses GFP_HIGHMEM, which is wrong because
> > GFP_HIGHMEM (on 32 bit systems) is memory ordinarily inaccessible
> > to the kernel and should only be used for allocations affecting
> > userspace.  In order to make highmem visible to the kernel on 32
> > bit it has to be kmapped, which consumes valuable entries in the
> > kmap region.  Since the tpm_buf is only ever used in the kernel,
> > switch to using a GFP_KERNEL allocation so as not to waste kmap
> > space on 32 bits.
> > 
> > Fixes: a74f8b36352e (tpm: introduce tpm_buf)
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> Pushed to master branch.

Thanks.  0day spotted a problem with the use of free_page() so I've
sent a v2.

James

