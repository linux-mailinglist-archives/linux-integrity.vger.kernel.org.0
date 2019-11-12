Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D787F96D1
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLROP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:14:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfKLROJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:14:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACGvhSc143050
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:14:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7yxujnru-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:14:09 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 17:14:07 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 17:14:03 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACHE3bi61603880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 17:14:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D26CA4040;
        Tue, 12 Nov 2019 17:14:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52906A404D;
        Tue, 12 Nov 2019 17:14:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 17:14:02 +0000 (GMT)
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue, 12 Nov 2019 12:14:01 -0500
In-Reply-To: <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
         <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111217-0008-0000-0000-0000032E6E21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111217-0009-0000-0000-00004A4D747C
Message-Id: <1573578841.17949.48.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-11-11 at 14:29 -0800, Lakshmi Ramasubramanian wrote:
> On 11/11/19 11:23 AM, Patrick Callaghan wrote:
> 
> > -		if (rbuf_len == 0)
> > +		if (rbuf_len == 0) {	/* unexpected EOF */
> > +			rc = -EINVAL;
> >   			break;
> > +		}
> >   		offset += rbuf_len;
> 
> Should there be an additional check to validate that (offset + rbuf_len) 
> is less than i_size before calling cypto_shash_update (since rbuf_len is 
> one of the parameters for this call)?

The "while" statement enforces that.

Mimi

> 
>                 if ((rbuf_len == 0) || (offset + rbuf_len >= i_size)) {
>                          rc = -EINVAL;
>                          break;
>                 }
>                 offset += rbuf_len;
> 
> >   	       rc = crypto_shash_update(shash, rbuf, rbuf_len);
> 
>   -lakshmi
> 

