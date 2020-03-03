Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCFC1784E7
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 22:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgCCVbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 16:31:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:7808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbgCCVbZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 16:31:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 13:31:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="243731638"
Received: from fkuchars-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.4.236])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2020 13:31:21 -0800
Date:   Tue, 3 Mar 2020 23:31:20 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 1/6] lib: add ASN.1 encoder
Message-ID: <20200303213120.GC110353@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-2-James.Bottomley@HansenPartnership.com>
 <20200303192208.GA5775@linux.intel.com>
 <1583268570.3638.15.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583268570.3638.15.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 03, 2020 at 03:49:30PM -0500, James Bottomley wrote:
> On Tue, 2020-03-03 at 21:22 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 02, 2020 at 07:27:54AM -0500, James Bottomley wrote:
> [...]
> > > diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> > > new file mode 100644
> > > index 000000000000..c7493667656e
> > > --- /dev/null
> > > +++ b/lib/asn1_encoder.c
> > > @@ -0,0 +1,431 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Simple encoder primitives for ASN.1 BER/DER/CER
> > > + *
> > > + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> > > + */
> > > +
> > > +#include <linux/asn1_encoder.h>
> > > +#include <linux/bug.h>
> > > +#include <linux/string.h>
> > > +#include <linux/module.h>
> > > +
> > > +/**
> > > + * asn1_encode_integer() - encode positive integer to ASN.1
> > > + * @data:	pointer to the pointer to the data
> > > + * @end_data:	end of data pointer, points one beyond last
> > > usable byte in @data
> > > + * @integer:	integer to be encoded
> > > + *
> > > + * This is a simplified encoder: it only currently does
> > > + * positive integers, but it should be simple enough to add the
> > > + * negative case if a use comes along.
> > > + */
> > > +unsigned char *
> > > +asn1_encode_integer(unsigned char *data, const unsigned char
> > > *end_data,
> > > +		    s64 integer)
> > > +{
> > > +	unsigned char *d = &data[2];
> > 
> > So what magic does index 2 contain?
> 
> ASN.1 has the form <tag> <length> <content> so a small integer has one
> byte for the _tag(UNIV, PRIM, INT), one byte for the length, which must
> be between 1 and 4, so the actual integer itself starts at 2.

OK cool.

> > > +	int i;
> > > +	bool found = false;
> > > +	int data_len = end_data - data;
> > 
> > I'd reorder these:
> > 
> > int data_len = end_data - data;
> > unsigned char *d = &data[2];
> > bool found = false;
> > int i;
> 
> Ah, reverse Christmas tree ... I can do that.

Always prefer it.

/Jarkko
