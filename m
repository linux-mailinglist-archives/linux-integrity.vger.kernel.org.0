Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E101E323A
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbgEZWTh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 18:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbgEZWTg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 18:19:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABACC03E96D
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 15:19:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so10740749pgv.8
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=a5XHeXngMi4U8eBw5luwPmNRrNUYniKzbWyuK/cavbU=;
        b=CO/cb0lpNvKA/oLdu25dbFW0P9eTeGKEX6HW/ympFdniKYJynDxRLuclUm+a9rxOdO
         2r9B2gPJgdI6AEjSM7tARhIFs/vhhDrfeyOeQpo3El7dzaZwuSv/b5bAXMu5VJay74VP
         lYpEKyUR7+MFt8jQEotJVerXIbXq+uwkop4nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=a5XHeXngMi4U8eBw5luwPmNRrNUYniKzbWyuK/cavbU=;
        b=qq/MM6QVQGEEh3n3G1muc26CGykoPquswllpJakzPfdEh5qMEcedOd5sFEEcN9Kizx
         fyb4E0kA7kuNnbEoqU2+ZXUOP4bF1ziVneFmCusVo+f8j4UvcRiUopTJvxCv7egjwRDs
         B3htUOfpeoDUXDbJ6yRhUDlv9UHPwo5rGlWImEQInQ5g1+nEdpASljpcKvL8gcy0eQs4
         lOqtc1Hwsg6FLtE3wTlLunJ4wpIwnWWzuSb8yjc85rrIPf9vdhF3hy0pqpNccjtYFh46
         YDpUDjDVFwPy4Nlk2tUZWKw3Qiu07b/4XQKPjUNwGtVWCnSiERWG2HiufjwsF5TVl+Y0
         /6XA==
X-Gm-Message-State: AOAM533Pm0FEM7f1h3hIn6Ce5qaHK5TclmYfP+Q7X/QYevNc+ku7x8IS
        dDEbTQLti/HFicH42Hn59fg6BA==
X-Google-Smtp-Source: ABdhPJzXju3+PnWMx0+X/Gpcg8MAEncxZsMcwegsOmxsfS6mJWGG84G02h+1pXbnjv8HmoC0ZPvo/g==
X-Received: by 2002:a62:e801:: with SMTP id c1mr871313pfi.217.1590531576045;
        Tue, 26 May 2020 15:19:36 -0700 (PDT)
Received: from ?IPv6:2601:645:4000:ba:30d8:f462:8a0e:6cae? ([2601:645:4000:ba:30d8:f462:8a0e:6cae])
        by smtp.gmail.com with ESMTPSA id z16sm453922pfq.125.2020.05.26.15.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:19:34 -0700 (PDT)
Message-ID: <da3027a2aa9d1b7110a65de919e88f42ef2e13bb.camel@guzman.io>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   Alex Guzman <alex@guzman.io>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mario.Limonciello@dell.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Date:   Tue, 26 May 2020 15:19:32 -0700
In-Reply-To: <1590521924.15108.1.camel@HansenPartnership.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <1590521924.15108.1.camel@HansenPartnership.com>
Content-Type: multipart/mixed; boundary="=-0c7m6JvSmHlZf6X2co44"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--=-0c7m6JvSmHlZf6X2co44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-05-26 at 12:38 -0700, James Bottomley wrote:
> On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> > > On Tue, 2020-05-26 at 13:32 -0500, Mario Limonciello wrote:
> > > > This reverts commit d23d12484307b40eea549b8a858f5fffad913897.
> > > > 
> > > > This commit has caused regressions for the XPS 9560 containing
> > > > a Nuvoton TPM.
> > > 
> > > Presumably this is using the tis driver?
> > 
> > Correct.
> > 
> > > > As mentioned by the reporter all TPM2 commands are failing
> > > > with:
> > > >   ERROR:tcti:src/tss2-tcti/tcti-
> > > > device.c:290:tcti_device_receive()
> > > >   Failed to read response from fd 3, got errno 1: Operation not
> > > > permitted
> > > > 
> > > > The reporter bisected this issue back to this commit which was
> > > > backported to stable as commit 4d6ebc4.
> > > 
> > > I think the problem is request_locality ... for some inexplicable
> > > reason a failure there returns -1, which is EPERM to user space.
> > > 
> > > That seems to be a bug in the async code since everything else
> > > gives a ESPIPE error if tpm_try_get_ops fails ... at least no-one
> > > assumes it gives back a sensible return code.
> > > 
> > > What I think is happening is that with the patch the TPM goes
> > > through a quick sequence of request, relinquish, request,
> > > relinquish and it's the third request which is failing (likely
> > > timing out).  Without the patch, the patch there's only one
> > > request,relinquish cycle because the ops are held while the async
> > > work is executed.  I have a vague recollection that there is a
> > > problem with too many locality request in quick succession, but
> > > I'll defer to Jason, who I think understands the intricacies of
> > > localities better than I do.
> > 
> > Thanks, I don't pretend to understand the nuances of this
> > particular
> > code, but I was hoping that the request to revert got some
> > attention
> > since Alex's kernel Bugzilla and message a few months ago to linux
> > integrity weren't.
> > 
> > > If that's the problem, the solution looks simple enough: just
> > > move
> > > the ops get down because the priv state is already protected by
> > > the
> > > buffer mutex
> > 
> > Yeah, if that works for Alex's situation it certainly sounds like a
> > better solution than reverting this patch as this patch actually
> > does
> > fix a problem reported by Jeffrin originally.
> > 
> > Could you propose a specific patch that Alex and Jeffrin can
> > perhaps
> > both try?
> 
> Um, what's wrong with the one I originally attached and which you
> quote
> below?  It's only compile tested, but I think it will work, if the
> theory is correct.
> 
> James
> 
> > > James
> > > 
> > > ---
> > > 
> > > diff --git a/drivers/char/tpm/tpm-dev-common.c
> > > b/drivers/char/tpm/tpm-dev-
> > > common.c
> > > index 87f449340202..1784530b8387 100644
> > > --- a/drivers/char/tpm/tpm-dev-common.c
> > > +++ b/drivers/char/tpm/tpm-dev-common.c
> > > @@ -189,15 +189,6 @@ ssize_t tpm_common_write(struct file *file,
> > > const char
> > > __user *buf,
> > >  		goto out;
> > >  	}
> > > 
> > > -	/* atomic tpm command send and result receive. We only
> > > hold the ops
> > > -	 * lock during this period so that the tpm can be
> > > unregistered even if
> > > -	 * the char dev is held open.
> > > -	 */
> > > -	if (tpm_try_get_ops(priv->chip)) {
> > > -		ret = -EPIPE;
> > > -		goto out;
> > > -	}
> > > -
> > >  	priv->response_length = 0;
> > >  	priv->response_read = false;
> > >  	*off = 0;
> > > @@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file,
> > > const char
> > > __user *buf,
> > >  	if (file->f_flags & O_NONBLOCK) {
> > >  		priv->command_enqueued = true;
> > >  		queue_work(tpm_dev_wq, &priv->async_work);
> > > -		tpm_put_ops(priv->chip);
> > >  		mutex_unlock(&priv->buffer_mutex);
> > >  		return size;
> > >  	}
> > > 
> > > +	/* atomic tpm command send and result receive. We only
> > > hold the ops
> > > +	 * lock during this period so that the tpm can be
> > > unregistered even if
> > > +	 * the char dev is held open.
> > > +	 */
> > > +	if (tpm_try_get_ops(priv->chip)) {
> > > +		ret = -EPIPE;
> > > +		goto out;
> > > +	}
> > > +
> > >  	ret = tpm_dev_transmit(priv->chip, priv->space, priv-
> > > > data_buffer,
> > > 
> > >  			       sizeof(priv->data_buffer));
> > >  	tpm_put_ops(priv->chip);

When using your patch, I get a hang when trying to use tpm2_getcap, and
dmesg shows some info.



--=-0c7m6JvSmHlZf6X2co44
Content-Disposition: attachment; filename="buglog.txt"
Content-Transfer-Encoding: base64
Content-Type: text/plain; name="buglog.txt"; charset="UTF-8"

WyAgNTcwLjkxMzc3OV0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJl
c3M6IGZmZmZiMjAwMDEyNDcwMDAKWyAgNTcwLjkxMzc4Ml0gI1BGOiBzdXBlcnZpc29yIHdyaXRl
IGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpbICA1NzAuOTEzNzgzXSAjUEY6IGVycm9yX2NvZGUoMHgw
MDAyKSAtIG5vdC1wcmVzZW50IHBhZ2UKWyAgNTcwLjkxMzc4NF0gUEdEIDAgUDREIDAgClsgIDU3
MC45MTM3ODVdIE9vcHM6IDAwMDIgWyMzXSBTTVAgUFRJClsgIDU3MC45MTM3ODddIENQVTogNiBQ
SUQ6IDI0NzQ0IENvbW06IHRwbTJfZ2V0Y2FwIFRhaW50ZWQ6IEcgICAgIFVEICAgICAgICAgICA1
LjcuMC1yYzcrICMzMQpbICA1NzAuOTEzNzg4XSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gWFBT
IDE1IDk1NjAvMDVGRkROLCBCSU9TIDEuMTguMCAxMS8xNy8yMDE5ClsgIDU3MC45MTM3OTFdIFJJ
UDogMDAxMDppb3dyaXRlOCsweDkvMHg1MApbICA1NzAuOTEzNzkyXSBDb2RlOiA0OCBjNyBjMiA0
MCA0MyA5ZiA5OSA0OCA4OSAwNCAyNCBlOCAxNCBhNyA5MCBmZiAwZiAwYiA0OCA4YiAwNCAyNCA0
OCA4MyBjNCAwOCBjMyA2NiAwZiAxZiA0NCAwMCAwMCA0OCA4MSBmZSBmZiBmZiAwMyAwMCA3NiAw
NCA8NDA+IDg4IDNlIGMzIDQ4IDgxIGZlIDAwIDAwIDAxIDAwIDc2IDA3IDBmIGI3IGQ2IDg5IGY4
IGVlIGMzIDhiIDA1ClsgIDU3MC45MTM3OTNdIFJTUDogMDAxODpmZmZmYjFmZjA0OWQ3ZGIwIEVG
TEFHUzogMDAwMTAyOTIKWyAgNTcwLjkxMzc5NF0gUkFYOiBmZmZmZmZmZjk4MWJmNTIwIFJCWDog
ZmZmZmIxZmYwNDlkN2RmOSBSQ1g6IGZmZmZiMWZmMDQ5ZDdkZjgKWyAgNTcwLjkxMzc5NV0gUkRY
OiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogZmZmZmIyMDAwMTI0NzAwMCBSREk6IDAwMDAwMDAwMDAw
MDAwMjAKWyAgNTcwLjkxMzc5Nl0gUkJQOiBmZmZmYjFmZjA0OWQ3ZGY5IFIwODogMDAwMDAwMDAw
MDAwMDAwMCBSMDk6IGZmZmY4YjgwZGU1MzcwZjAKWyAgNTcwLjkxMzc5N10gUjEwOiAwMDAwMDAw
MDAwYjcxYjAwIFIxMTogMDAwMDAwMDAwMDAwMDI4ZiBSMTI6IGZmZmY4YjgwYjE0OGNkYTgKWyAg
NTcwLjkxMzc5N10gUjEzOiAwMDAwMDAwMGZmZmZmMDAwIFIxNDogZmZmZjhiODBiMTQ4Y2RhOCBS
MTU6IGZmZmY4YjgwY2I0NGEwYmEKWyAgNTcwLjkxMzc5OV0gRlM6ICAwMDAwN2Y3OGY3Y2QwZDgw
KDAwMDApIEdTOmZmZmY4YjgwZGU1MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApb
ICA1NzAuOTEzNzk5XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgw
MDUwMDMzClsgIDU3MC45MTM4MDBdIENSMjogZmZmZmIyMDAwMTI0NzAwMCBDUjM6IDAwMDAwMDA3
OTU2MTgwMDEgQ1I0OiAwMDAwMDAwMDAwMzYwNmUwClsgIDU3MC45MTM4MDFdIENhbGwgVHJhY2U6
ClsgIDU3MC45MTM4MDNdICB0cG1fdGNnX3dyaXRlX2J5dGVzKzB4MmYvMHg0MApbICA1NzAuOTEz
ODA1XSAgcmVsZWFzZV9sb2NhbGl0eSsweDQ5LzB4MjIwClsgIDU3MC45MTM4MDddICB0cG1fcmVs
aW5xdWlzaF9sb2NhbGl0eSsweDFmLzB4NDAKWyAgNTcwLjkxMzgwOF0gIHRwbV9jaGlwX3N0b3Ar
MHgyMS8weDQwClsgIDU3MC45MTM4MTBdICB0cG1fcHV0X29wcysweDkvMHgzMApbICA1NzAuOTEz
ODExXSAgdHBtX2NvbW1vbl93cml0ZSsweDE3OS8weDE5MApbICA1NzAuOTEzODEzXSAgdmZzX3dy
aXRlKzB4YjEvMHgxYTAKWyAgNTcwLjkxMzgxNV0gIGtzeXNfd3JpdGUrMHg1YS8weGQwClsgIDU3
MC45MTM4MTZdICBkb19zeXNjYWxsXzY0KzB4NDMvMHgxMzAKWyAgNTcwLjkxMzgxOV0gIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkKWyAgNTcwLjkxMzgyMF0gUklQOiAw
MDMzOjB4N2Y3OGY3ZTAwMTIzClsgIDU3MC45MTM4MjFdIENvZGU6IDBjIDAwIGY3IGQ4IDY0IDg5
IDAyIDQ4IGM3IGMwIGZmIGZmIGZmIGZmIGViIGJiIDBmIDFmIDgwIDAwIDAwIDAwIDAwIDY0IDhi
IDA0IDI1IDE4IDAwIDAwIDAwIDg1IGMwIDc1IDE0IGI4IDAxIDAwIDAwIDAwIDBmIDA1IDw0OD4g
M2QgMDAgZjAgZmYgZmYgNzcgNTUgYzMgMGYgMWYgNDAgMDAgNDggODMgZWMgMjggNDggODkgNTQg
MjQgMTgKWyAgNTcwLjkxMzgyMl0gUlNQOiAwMDJiOjAwMDA3ZmZmNzI0ZThjNjggRUZMQUdTOiAw
MDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAwMQpbICA1NzAuOTEzODIzXSBSQVg6IGZm
ZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDAwMDAzIFJDWDogMDAwMDdmNzhmN2UwMDEy
MwpbICA1NzAuOTEzODI0XSBSRFg6IDAwMDAwMDAwMDAwMDAwMTYgUlNJOiAwMDAwNTY0Y2YyNGE3
MjIwIFJESTogMDAwMDAwMDAwMDAwMDAwMwpbICA1NzAuOTEzODI1XSBSQlA6IDAwMDAwMDAwMDAw
MDAwMTYgUjA4OiAwMDAwN2Y3OGY3Y2NjNzg1IFIwOTogMDAwMDdmNzhmN2NjY2E0MApbICA1NzAu
OTEzODI2XSBSMTA6IDAwMDA3ZmZmNzI0ZThiMTAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjog
MDAwMDU2NGNmMjRhNzIyMApbICA1NzAuOTEzODI2XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0
OiAwMDAwMDAwMDAwMDAwMDE2IFIxNTogMDAwMDdmNzhmN2NjYzg5MApbICA1NzAuOTEzODI3XSBN
b2R1bGVzIGxpbmtlZCBpbjogc3F1YXNoZnMgcnRzeF9wY2lfc2RtbWMgeDg2X3BrZ190ZW1wX3Ro
ZXJtYWwgY29yZXRlbXAgcnRzeF9wY2kgbWZkX2NvcmUKWyAgNTcwLjkxMzgzMV0gQ1IyOiBmZmZm
YjIwMDAxMjQ3MDAwClsgIDU3MC45MTM4MzJdIC0tLVsgZW5kIHRyYWNlIGM4NDQzN2IwMGYwZDAx
YTAgXS0tLQpbICA1NzAuOTEzODMzXSBSSVA6IDAwMTA6aW93cml0ZTgrMHg5LzB4NTAKWyAgNTcw
LjkxMzgzNF0gQ29kZTogNDggYzcgYzIgNDAgNDMgOWYgOTkgNDggODkgMDQgMjQgZTggMTQgYTcg
OTAgZmYgMGYgMGIgNDggOGIgMDQgMjQgNDggODMgYzQgMDggYzMgNjYgMGYgMWYgNDQgMDAgMDAg
NDggODEgZmUgZmYgZmYgMDMgMDAgNzYgMDQgPDQwPiA4OCAzZSBjMyA0OCA4MSBmZSAwMCAwMCAw
MSAwMCA3NiAwNyAwZiBiNyBkNiA4OSBmOCBlZSBjMyA4YiAwNQpbICA1NzAuOTEzODM1XSBSU1A6
IDAwMTg6ZmZmZmIxZmYwMzBiN2RiMCBFRkxBR1M6IDAwMDEwMjkyClsgIDU3MC45MTM4MzZdIFJB
WDogZmZmZmZmZmY5ODFiZjUyMCBSQlg6IGZmZmZiMWZmMDMwYjdkZjkgUkNYOiBmZmZmYjFmZjAz
MGI3ZGY4ClsgIDU3MC45MTM4MzddIFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IGZmZmZiMjAw
MDEyNDcwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDIwClsgIDU3MC45MTM4MzddIFJCUDogZmZmZmIx
ZmYwMzBiN2RmOSBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGI4MGRlMjM3MGYwClsg
IDU3MC45MTM4MzhdIFIxMDogMDAwMDAwMDAwMGI3MWIwMCBSMTE6IDAwMDAwMDAwMDAwMDAxOWMg
UjEyOiBmZmZmOGI4MGIxNDhjZGE4ClsgIDU3MC45MTM4MzldIFIxMzogMDAwMDAwMDBmZmZmZjAw
MCBSMTQ6IGZmZmY4YjgwYjE0OGNkYTggUjE1OiBmZmZmOGI4MGM0Y2ZjMGJhClsgIDU3MC45MTM4
NDBdIEZTOiAgMDAwMDdmNzhmN2NkMGQ4MCgwMDAwKSBHUzpmZmZmOGI4MGRlNTAwMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgNTcwLjkxMzg0MF0gQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICA1NzAuOTEzODQxXSBDUjI6IGZmZmZi
MjAwMDEyNDcwMDAgQ1IzOiAwMDAwMDAwNzk1NjE4MDAxIENSNDogMDAwMDAwMDAwMDM2MDZlMAo=


--=-0c7m6JvSmHlZf6X2co44--

