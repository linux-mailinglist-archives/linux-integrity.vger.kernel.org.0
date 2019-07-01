Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE25BA61
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2019 13:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfGALJP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jul 2019 07:09:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727645AbfGALJP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jul 2019 07:09:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61B918W042768
        for <linux-integrity@vger.kernel.org>; Mon, 1 Jul 2019 07:09:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfg9hav95-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jul 2019 07:09:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 1 Jul 2019 12:08:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 12:08:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61B8qaN48627762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 11:08:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D2652051;
        Mon,  1 Jul 2019 11:08:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.66])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 87BAB5205F;
        Mon,  1 Jul 2019 11:08:51 +0000 (GMT)
Subject: Re: [PATCH] ima: fix freeing ongoing ahash_request
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-integrity@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 01 Jul 2019 07:08:40 -0400
In-Reply-To: <20190701072716.xo4xjo2nhjo4uhvq@pengutronix.de>
References: <20190628081449.22515-1-s.hauer@pengutronix.de>
         <1561935704.3985.55.camel@linux.ibm.com>
         <20190701072716.xo4xjo2nhjo4uhvq@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070111-0028-0000-0000-0000037F4E42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070111-0029-0000-0000-0000243F8374
Message-Id: <1561979320.4049.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-07-01 at 09:27 +0200, Sascha Hauer wrote:
> On Sun, Jun 30, 2019 at 07:01:44PM -0400, Mimi Zohar wrote:
> > Hi Sasha,
> > 
> > On Fri, 2019-06-28 at 10:14 +0200, Sascha Hauer wrote:
> > > integrity_kernel_read() can fail in which case we forward to call
> > > ahash_request_free() on a currently running request. We have to wait
> > > for its completion before we can free the request.
> > > 
> > > This was observed by interrupting a "find / -type f -xdev -print0 | xargs -0
> > > cat 1>/dev/null" with ctrl-c on an IMA enabled filesystem.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  security/integrity/ima/ima_crypto.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> > > index 16a4f45863b1..6a60bdb322b1 100644
> > > --- a/security/integrity/ima/ima_crypto.c
> > > +++ b/security/integrity/ima/ima_crypto.c
> > > @@ -271,8 +271,10 @@ static int ima_calc_file_hash_atfm(struct file *file,
> > >  		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
> > >  		rc = integrity_kernel_read(file, offset, rbuf[active],
> > >  					   rbuf_len);
> > > -		if (rc != rbuf_len)
> > > +		if (rc != rbuf_len) {
> > > +			ahash_wait(ahash_rc, &wait);
> > >  			goto out3;
> > > +		}
> > 
> > The normal case when "rc != rbuf_len" is when the last block of the
> > file data is read. 
> 
> When integrity_kernel_read() returns a value smaller than 0 then it's
> clearly an error and we want to bail out. The case when
> integrity_kernel_read() returns a short read though isn't properly
> handled. We have:
> 
> 		rc = integrity_kernel_read(file, offset, rbuf[active],
> 					   rbuf_len);
> 		if (rc != rbuf_len)
> 			goto out3;
> 
> 		...
> 
> out3:
> 	ima_free_pages(rbuf[0], rbuf_size[0]);
> 	ima_free_pages(rbuf[1], rbuf_size[1]);
> out2:
> 	if (!rc) {
> 		ahash_request_set_crypt(req, NULL, hash->digest, 0);
> 		rc = ahash_wait(crypto_ahash_final(req), &wait);
> 	}
> out1:
> 	ahash_request_free(req);
> 	return rc;
> 
> 
> So on a short read we never finish the ahash request and we return a
> positive number from this function which it seems isn't expected from
> the callers.
> 
> I'm not sure if we have to handle a short read, but currently it isn't
> handled. It seems we have to sort that out first.

Agreed.  For this code to work, which it does, it must be returning 0.
 So I would assume your code should differentiate between 0 and < 0.

> 
> > In that case the "ahash_wait" isn't needed.  Is
> > there a performance penalty for adding this wait?  Could you
> > differentiate between the last buffer and failure?
> > 
> > Immediately before "out3:" there's a call to ahash_wait().  There are
> > three "goto out3".  This is the only place that skips the call to
> > ahash_wait().  If we do need to add it, it would be better to move the
> > "out3:" definition and remove the other calls to ahash_wait().
> 
> The cases are different. Two times we call ahash_wait() and if that
> fails we jump to "out3:". In the case I handle here we are already in
> the error path and still have to call ahash_wait(). We also can't use
> the ahash_wait() after the loop because that would hide the error value
> we want to return (after the loop we have rc = ahash_wait(), we would
> return successfully if we'd jump there).

Thank you for the explanation.  The code should be documented,
otherwise someone is going to "clean" it up.

Mimi

