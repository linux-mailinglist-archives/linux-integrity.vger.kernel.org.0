Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97E71D0A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfGWQls (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 12:41:48 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33322 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGWQls (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 12:41:48 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D4BE872CCDE;
        Tue, 23 Jul 2019 19:41:45 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B7EFE4A4AE8;
        Tue, 23 Jul 2019 19:41:45 +0300 (MSK)
Date:   Tue, 23 Jul 2019 19:41:44 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190723164144.ewrcvrod7m6rahkg@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
References: <1563893743-4586-1-git-send-email-zohar@linux.ibm.com>
 <20190723154759.GB16649@glitch>
 <1563897190.14396.144.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563897190.14396.144.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 23, 2019 at 11:53:10AM -0400, Mimi Zohar wrote:
> On Tue, 2019-07-23 at 12:47 -0300, Bruno E. O. Meneguele wrote:
> 
> > > @@ -1402,6 +1400,41 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
> > >  	return result;
> > >  }
> > >  
> > > +#ifdef HAVE_TSSPCRREAD
> > > +static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
> > > +{
> > > +	FILE *fp;
> > > +	char pcr[100];	/* may contain an error */
> > > +	char cmd[50];
> > > +	int ret;
> > > +
> > > +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
> > > +	fp = popen(cmd, "r");
> > > +	if (!fp) {
> > > +		snprintf(pcr, sizeof(pcr), "popen failed: %s", strerror(errno));
> > > +		*errmsg = strdup("popen failed:");
> > 
> > Should it have been 
> > 
> > *errmsg = strdup(pcr);
> > 
> Yes, of course.

Or better to use asprintf(3).

Thanks,

