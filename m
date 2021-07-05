Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6C3BC379
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhGEUwt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 16:52:49 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56980 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhGEUws (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 16:52:48 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 87D6B72C8B4;
        Mon,  5 Jul 2021 23:50:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 101A34A46ED;
        Mon,  5 Jul 2021 23:50:09 +0300 (MSK)
Date:   Mon, 5 Jul 2021 23:50:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
Message-ID: <20210705205008.olof3kyfh32atgjc@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
 <20210701011323.2377251-3-vt@altlinux.org>
 <e80ebe2bfb2e5bd9bf83153789ad9bbcfe5cf916.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <e80ebe2bfb2e5bd9bf83153789ad9bbcfe5cf916.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 05, 2021 at 03:59:02PM -0400, Mimi Zohar wrote:
> On Thu, 2021-07-01 at 04:13 +0300, Vitaly Chikunov wrote:
> 
> > @@ -2805,6 +2811,14 @@ int main(int argc, char *argv[])
> >  			}
> >  			imaevm_params.keyid = keyid;
> >  			break;
> > +		case 145:
> > +			keyid = imaevm_read_keyid(optarg);
> > +			if (keyid == 0) {
> 
> The function comment indicates zero is returned on error, which is
> normally true, but -1 is returned to indicate reading the cert failed. 

Ah, bug.

Thanks!

> 
> > +				log_err("Error reading keyid.\n");
> > +				exit(1);
> > +			}
> > +			imaevm_params.keyid = keyid;
> 
> As a result, imaevm_params.keyid is set to -1, which the "--keyid="
> case would detect, but isn't detected here.
> 
> > +			break;
> >  		case '?':
> >  			exit(1);
> >  			break;
> > diff --git a/src/imaevm.h b/src/imaevm.h
> > index fe244f1..491f136 100644
> > --- a/src/imaevm.h
> > +++ b/src/imaevm.h
> > 
> > +/**
> 
> kernel doc?  :)
> 
> > + * imaevm_read_keyid() - Read 32-bit keyid from the cert file
> > + * @certfile:	File with certificate in PEM or DER form.
> > + *
> > + * Try to read keyid from Subject Key Identifier (SKID) of x509 certificate.
> > + * Autodetect if cert is in PEM (tried first) or DER encoding.
> > + *
> > + * Return: 0 on error, logged error message;
> > + *         32-bit keyid in host order.
> 
> As mentioned above, -1 could be returned.
> 
> > + */
> > +uint32_t imaevm_read_keyid(const char *certfile)
> > +{
> > +	uint32_t keyid_be = 0;
> > +	X509 *x;
> > +
> > +	/* true: to load in DER form too. */
> > +	if (!(x = read_cert(certfile, true)))
> > +		return -1;
> > +	extract_keyid(&keyid_be, x, certfile);
> > +	/* On error keyid_be will not be set, returning 0. */
> 
> Ok
> 
> thanks,
> 
> Mimi
> 
> > +	X509_free(x);
> > +	return ntohl(keyid_be);
> > +}
> > +
> >  static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
> >  {
> >  	FILE *fp;
