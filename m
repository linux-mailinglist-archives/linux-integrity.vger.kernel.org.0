Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6DBFC82E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Nov 2019 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfKNNzr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Nov 2019 08:55:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfKNNzr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Nov 2019 08:55:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEDqtkw006323;
        Thu, 14 Nov 2019 08:55:40 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w976htusu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 08:55:39 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAEDpdeP005289;
        Thu, 14 Nov 2019 13:55:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 2w5n36hk4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 13:55:38 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEDtZvE43909560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 13:55:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FE57B2064;
        Thu, 14 Nov 2019 13:55:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B046B205F;
        Thu, 14 Nov 2019 13:55:35 +0000 (GMT)
Received: from oc3746452103.endicott.ibm.com (unknown [9.60.73.196])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 13:55:35 +0000 (GMT)
Message-ID: <abdf66fb39d4c8ee08e0b52c34fb81b93bd33006.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
From:   Patrick Callaghan <patrickc@linux.vnet.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Date:   Thu, 14 Nov 2019 08:55:34 -0500
In-Reply-To: <1573582344.17949.67.camel@linux.ibm.com>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
         <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
         <1573578841.17949.48.camel@linux.ibm.com>
         <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
         <1573582344.17949.67.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=844 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-11-12 at 13:12 -0500, Mimi Zohar wrote:
> On Tue, 2019-11-12 at 09:33 -0800, Lakshmi Ramasubramanian wrote:
> > On 11/12/2019 9:14 AM, Mimi Zohar wrote:
> > 
> > > On Mon, 2019-11-11 at 14:29 -0800, Lakshmi Ramasubramanian wrote:
> > > > On 11/11/19 11:23 AM, Patrick Callaghan wrote:
> > > > 
> > > > > -		if (rbuf_len == 0)
> > > > > +		if (rbuf_len == 0) {	/* unexpected EOF */
> > > > > +			rc = -EINVAL;
> > > > >    			break;
> > > > > +		}
> > > > >    		offset += rbuf_len;
> > > > 
> > > > Should there be an additional check to validate that (offset +
> > > > rbuf_len)
> > > > is less than i_size before calling cypto_shash_update (since
> > > > rbuf_len is
> > > > one of the parameters for this call)?
> > > 
> > > The "while" statement enforces that.
> > > 
> > > Mimi
> > 
> > Yes - but that check happens after the call to
> > crypto_shash_update().
> > 
> > Perhaps integrity_kernel_read() will never return (rbuf_len) that
> > will
> >   => violate the check in the "while" statement.
> >   => number of bytes read that is greater than the memory allocated
> > for 
> > rbuf even in error conditions.
> > 
> > Just making sure.
> 
> integrity_kernel_read() returns an error (< 0) or the number of bytes
> read.  The while statement ensures that there is more data to read,
> so
> returning 0 is always an error.
> 
> Mimi
Hello Laks,
You suggested that the if statement of the patch change to the
following:

if ((rbuf_len == 0) || (offset + rbuf_len >= i_size)) {

Unless the file size changed between the time that i_size was set in
ima_calc_file_hash_tfm() and an i_size_read() call was subsequently
issued in a function downstream of the integrity_kernel_read() call,
the rbuf_len returned on the integrity_kernel_read() call will not be
more than i_size - offset. I do not think that it is possible for the
file size to change during this window but nonetheless, if it can, this
would be a different problem and I would not want to include this in my
patch. That said, I do appreciate you taking time to review this patch.

