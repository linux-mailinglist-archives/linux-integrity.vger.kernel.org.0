Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6949AFAB47
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 08:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfKMHwj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 02:52:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38445 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfKMHwj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 02:52:39 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iUnSA-0000Cf-8X; Wed, 13 Nov 2019 08:52:38 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iUnS9-0000KE-Ma; Wed, 13 Nov 2019 08:52:37 +0100
Date:   Wed, 13 Nov 2019 08:52:37 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Patrick Callaghan <patrickc@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
Message-ID: <20191113075237.falq46vnmbtd5pa7@pengutronix.de>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111192348.30535-1-patrickc@linux.ibm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:48:41 up 128 days, 13:58, 130 users,  load average: 0.01, 0.08,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 11, 2019 at 02:23:48PM -0500, Patrick Callaghan wrote:
> The integrity_kernel_read() call in ima_calc_file_hash_tfm() can return
> a value of 0 before all bytes of the file are read. A value of 0 would
> normally indicate an EOF. This has been observed if a user process is
> causing a file appraisal and is terminated with a SIGTERM signal. The
> most common occurrence of seeing the problem is if a shutdown or systemd
> reload is initiated while files are being appraised.
> 
> The problem is similar to commit <f5e1040196db> (ima: always return
> negative code for error) that fixed the problem in
> ima_calc_file_hash_atfm().
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Patrick Callaghan <patrickc@linux.ibm.com>
> ---
>  security/integrity/ima/ima_crypto.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 73044fc..7967a69 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -362,8 +362,10 @@ static int ima_calc_file_hash_tfm(struct file *file,
>  			rc = rbuf_len;
>  			break;
>  		}
> -		if (rbuf_len == 0)
> +		if (rbuf_len == 0) {	/* unexpected EOF */
> +			rc = -EINVAL;
>  			break;
> +		}

There's no point in calling crypto_shash_final() on incomplete data, so
setting rc to an error to avoid that seems the right thing to do to me,
so:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
