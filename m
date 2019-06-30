Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5E5B249
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2019 01:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfF3XCC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Jun 2019 19:02:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbfF3XCC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Jun 2019 19:02:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5UN1KcT067219
        for <linux-integrity@vger.kernel.org>; Sun, 30 Jun 2019 19:02:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tf6bbg3wn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 30 Jun 2019 19:02:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 1 Jul 2019 00:01:58 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 00:01:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5UN1iT135455434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jun 2019 23:01:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5406CA4054;
        Sun, 30 Jun 2019 23:01:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C037DA405C;
        Sun, 30 Jun 2019 23:01:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 Jun 2019 23:01:54 +0000 (GMT)
Subject: Re: [PATCH] ima: fix freeing ongoing ahash_request
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-integrity@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Sun, 30 Jun 2019 19:01:44 -0400
In-Reply-To: <20190628081449.22515-1-s.hauer@pengutronix.de>
References: <20190628081449.22515-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19063023-0028-0000-0000-0000037F1F28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19063023-0029-0000-0000-0000243F5231
Message-Id: <1561935704.3985.55.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-30_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906300296
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sasha,

On Fri, 2019-06-28 at 10:14 +0200, Sascha Hauer wrote:
> integrity_kernel_read() can fail in which case we forward to call
> ahash_request_free() on a currently running request. We have to wait
> for its completion before we can free the request.
> 
> This was observed by interrupting a "find / -type f -xdev -print0 | xargs -0
> cat 1>/dev/null" with ctrl-c on an IMA enabled filesystem.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  security/integrity/ima/ima_crypto.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 16a4f45863b1..6a60bdb322b1 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -271,8 +271,10 @@ static int ima_calc_file_hash_atfm(struct file *file,
>  		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
>  		rc = integrity_kernel_read(file, offset, rbuf[active],
>  					   rbuf_len);
> -		if (rc != rbuf_len)
> +		if (rc != rbuf_len) {
> +			ahash_wait(ahash_rc, &wait);
>  			goto out3;
> +		}

The normal case when "rc != rbuf_len" is when the last block of the
file data is read.  In that case the "ahash_wait" isn't needed.  Is
there a performance penalty for adding this wait?  Could you
differentiate between the last buffer and failure?

Immediately before "out3:" there's a call to ahash_wait().  There are
three "goto out3".  This is the only place that skips the call to
ahash_wait().  If we do need to add it, it would be better to move the
"out3:" definition and remove the other calls to ahash_wait().

Mimi

>  
>  		if (rbuf[1] && offset) {
>  			/* Using two buffers, and it is not the first

