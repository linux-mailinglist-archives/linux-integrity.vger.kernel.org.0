Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA33732B3
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 01:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEDXV5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 19:21:57 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39808 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhEDXV5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 19:21:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 06F8072C8B5;
        Wed,  5 May 2021 02:21:01 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B7CA54A46E8;
        Wed,  5 May 2021 02:21:00 +0300 (MSK)
Date:   Wed, 5 May 2021 02:21:00 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Elvira Khabirova <lineprinter0@gmail.com>
Subject: Re: [PATCH v2 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
Message-ID: <20210504232100.rj36uskbjiktmmyw@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-3-vt@altlinux.org>
 <2702b9ca-d20a-8348-2fc5-4e36ec6b45bf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2702b9ca-d20a-8348-2fc5-4e36ec6b45bf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Tue, May 04, 2021 at 09:04:44AM -0400, Stefan Berger wrote:
> 
> On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> > Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
> > SKID of the certificate file. PEM or DER format is auto-detected.
> > 
> > `--keyid' option is reused instead of adding a new option (like possible
> > `--cert') to signify to the user it's only keyid extraction and nothing
> > more.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >   README                 |  1 +
> >   src/evmctl.c           | 82 +++++++++++++++++++++++++++++++++++++++++++++++---
> >   tests/sign_verify.test |  1 +
> >   3 files changed, 79 insertions(+), 5 deletions(-)
> > 
> > @@ -2567,12 +2571,71 @@ static char *get_password(void)
> > +/* Extract keyid from SKID of the cert. No return on error. */
> > +static unsigned long int extract_keyid(const char *certfile)
> > +{
> > +	uint32_t keyid_raw;
> > +	const ASN1_OCTET_STRING *skid;
> > +	int skid_len;
> > +	X509 *x = NULL;
> > +	int pem;
> > +	FILE *in;
> > +
> > +	if (!(in = fopen(certfile, "r"))) {
> > +		log_err("Cannot open cert file %s: %s\n", certfile,
> > +			strerror(errno));
> > +		exit(1);
> > +	}
> > +	if ((pem = is_encoding_pem(in)))
> 
> 
> I think you should not try to detect PEM by '-----' at the beginning since
> it typically allows other text at the beginning of the file as well, such as
> a text dump of the cert. Instead search for '-----BEGIN CERTIFICATE-----' in
> the whole file or just

> try to read it as PEM first and then fall back to DER decoding if PEM failed.

This is a good idea. I will do it in v3.

Thanks,

