Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF55B5B7
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2019 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfGAH1T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jul 2019 03:27:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52853 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfGAH1T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jul 2019 03:27:19 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hhqib-0001ik-R6; Mon, 01 Jul 2019 09:27:17 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hhqia-0001bk-SN; Mon, 01 Jul 2019 09:27:16 +0200
Date:   Mon, 1 Jul 2019 09:27:16 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] ima: fix freeing ongoing ahash_request
Message-ID: <20190701072716.xo4xjo2nhjo4uhvq@pengutronix.de>
References: <20190628081449.22515-1-s.hauer@pengutronix.de>
 <1561935704.3985.55.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561935704.3985.55.camel@linux.ibm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:11:06 up 44 days, 13:29, 70 users,  load average: 0.34, 0.19,
 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 30, 2019 at 07:01:44PM -0400, Mimi Zohar wrote:
> Hi Sasha,
> 
> On Fri, 2019-06-28 at 10:14 +0200, Sascha Hauer wrote:
> > integrity_kernel_read() can fail in which case we forward to call
> > ahash_request_free() on a currently running request. We have to wait
> > for its completion before we can free the request.
> > 
> > This was observed by interrupting a "find / -type f -xdev -print0 | xargs -0
> > cat 1>/dev/null" with ctrl-c on an IMA enabled filesystem.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  security/integrity/ima/ima_crypto.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> > index 16a4f45863b1..6a60bdb322b1 100644
> > --- a/security/integrity/ima/ima_crypto.c
> > +++ b/security/integrity/ima/ima_crypto.c
> > @@ -271,8 +271,10 @@ static int ima_calc_file_hash_atfm(struct file *file,
> >  		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
> >  		rc = integrity_kernel_read(file, offset, rbuf[active],
> >  					   rbuf_len);
> > -		if (rc != rbuf_len)
> > +		if (rc != rbuf_len) {
> > +			ahash_wait(ahash_rc, &wait);
> >  			goto out3;
> > +		}
> 
> The normal case when "rc != rbuf_len" is when the last block of the
> file data is read. 

When integrity_kernel_read() returns a value smaller than 0 then it's
clearly an error and we want to bail out. The case when
integrity_kernel_read() returns a short read though isn't properly
handled. We have:

		rc = integrity_kernel_read(file, offset, rbuf[active],
					   rbuf_len);
		if (rc != rbuf_len)
			goto out3;

		...

out3:
	ima_free_pages(rbuf[0], rbuf_size[0]);
	ima_free_pages(rbuf[1], rbuf_size[1]);
out2:
	if (!rc) {
		ahash_request_set_crypt(req, NULL, hash->digest, 0);
		rc = ahash_wait(crypto_ahash_final(req), &wait);
	}
out1:
	ahash_request_free(req);
	return rc;


So on a short read we never finish the ahash request and we return a
positive number from this function which it seems isn't expected from
the callers.

I'm not sure if we have to handle a short read, but currently it isn't
handled. It seems we have to sort that out first.

> In that case the "ahash_wait" isn't needed.  Is
> there a performance penalty for adding this wait?  Could you
> differentiate between the last buffer and failure?
> 
> Immediately before "out3:" there's a call to ahash_wait().  There are
> three "goto out3".  This is the only place that skips the call to
> ahash_wait().  If we do need to add it, it would be better to move the
> "out3:" definition and remove the other calls to ahash_wait().

The cases are different. Two times we call ahash_wait() and if that
fails we jump to "out3:". In the case I handle here we are already in
the error path and still have to call ahash_wait(). We also can't use
the ahash_wait() after the loop because that would hide the error value
we want to return (after the loop we have rc = ahash_wait(), we would
return successfully if we'd jump there).

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
