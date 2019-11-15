Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208E6FE124
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2019 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKOP0G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Nov 2019 10:26:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727504AbfKOP0G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Nov 2019 10:26:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFFMsZ2048126;
        Fri, 15 Nov 2019 10:25:59 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsdmd3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 10:25:59 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAFFNGQt025551;
        Fri, 15 Nov 2019 15:25:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 2w9gy3wpqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 15:25:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAFFPvDQ17957122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 15:25:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B771B112062;
        Fri, 15 Nov 2019 15:25:57 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DC13112061;
        Fri, 15 Nov 2019 15:25:57 +0000 (GMT)
Received: from oc3746452103.endicott.ibm.com (unknown [9.60.73.196])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Nov 2019 15:25:57 +0000 (GMT)
Message-ID: <ffb1ec9d8cf12f6366fb4eb022a5442a8edae53c.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
From:   Patrick Callaghan <patrickc@linux.vnet.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Date:   Fri, 15 Nov 2019 10:25:57 -0500
In-Reply-To: <4e1c0c6b-a5e1-a95a-8a0b-c5a7f0a253cf@linux.microsoft.com>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
         <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
         <1573578841.17949.48.camel@linux.ibm.com>
         <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
         <1573582344.17949.67.camel@linux.ibm.com>
         <abdf66fb39d4c8ee08e0b52c34fb81b93bd33006.camel@linux.vnet.ibm.com>
         <4e1c0c6b-a5e1-a95a-8a0b-c5a7f0a253cf@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-11-14 at 10:45 -0800, Lakshmi Ramasubramanian wrote:
> On 11/14/19 5:55 AM, Patrick Callaghan wrote:
> 
> Hi Patrick,
> 
> > Hello Laks,
> > You suggested that the if statement of the patch change to the
> > following:
> > 
> > if ((rbuf_len == 0) || (offset + rbuf_len >= i_size)) {
> > 
> > Unless the file size changed between the time that i_size was set
> > in
> > ima_calc_file_hash_tfm() and an i_size_read() call was subsequently
> > issued in a function downstream of the integrity_kernel_read()
> > call,
> > the rbuf_len returned on the integrity_kernel_read() call will not
> > be
> > more than i_size - offset. I do not think that it is possible for
> > the
> > file size to change during this window but nonetheless, if it can,
> > this
> > would be a different problem and I would not want to include this
> > in my
> > patch. That said, I do appreciate you taking time to review this
> > patch.
> 
> You are right - unless the file size changes between the calls this 
> problem would not occur. I agree - that issue, even if it can occur, 
> should be addressed separately.
> 
> Another one (again - am not saying this needs to be addressed in
> this 
> patch, but just wanted to point out)
> 
> 	rbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> 	...
> 	rbuf_len = integrity_kernel_read(file, offset, rbuf,
> PAGE_SIZE);
> 	...
> 	rc = crypto_shash_update(shash, rbuf, rbuf_len);
> 
> rbuf is of size PAGE_SIZE, but rbuf_len, returned by 
> integrity_kernel_read() is passed as buffer size to 
> crypto_shash_update() without any validation (rbuf_len <= PAGE_SIZE)
> 
> It is assumed here that integrity_kernel_read() would not return a 
> length greater than rbuf size and hence crypto_shash_update() would 
> never access beyond the given buffer.
> 
> thanks,
>   -lakshmi
> 
> 
Hello Laks,
Agreed. The assumption is that integrity_kernel_read() function does
not return a value greater than the fourth parameter passed to it (i.e.
does not read more bytes from the file than the size of the buffer
passed to it). I tried to validate that this assumption was true by
following the code but felt I could not prove it with my current
knowledge of the code. If this assumption is not true then I believe
that any code change for this problem should go into a different
patch. 

Thank you.

