Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06A162C26
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2019 00:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfGHWxZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 18:53:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37438 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfGHWxZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 18:53:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so14626773qkl.4
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0m3NEjwvz2dxO9bQhFlPhZbVrX0uYb3It/HKmn2RbMY=;
        b=JeKYvjEHv0d4lyie/kiBQRbHspieZhhHk1xlxebuNCuhUGu2Ujj2J5Hn94dfSTuN5U
         ib5PxKy6G0Fdrb8Kf9ZgN46yBcwla5TU9ZmG2/D+e81sTwZio+uWzaJAYYn6t99E6fno
         HZfkywo1Z3Y+s5YbXpcAAhsdJMHg7y81D9tjheXnlxscc6Y0jHCY1EmbsmteXyTI+F0g
         vZaVU90UeK6qQBW4YH523XTj9x4L3JVIFaq9mSiXf478G+zEYS7E6QoXBHxc8xOLnQh+
         s6UjLSgZgRdsU1nZlZA9ZjPbJAueUs8VveDaz+i6ViBZwsNp9BacpUNiDce5RoXVLNln
         V29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0m3NEjwvz2dxO9bQhFlPhZbVrX0uYb3It/HKmn2RbMY=;
        b=apcMxBdDOufyxVUJSADEUXlUs9LosN5V+Kx4VS/1Uwko4BZvV4lcmaJA7hfOSXYttv
         0MlRIAIUJ45RhK/4HxZdlFnkxo1361iJn4tAGK4gpc7bmb3K/O7l2fIN9dTaZuxA17Q0
         NGinbp9NCXt0IAQpiaL+Eb7tTGfd3Acsze9LG9gwRcmQB8oJaQb7SLzsGzy7gRVx+7vA
         kIbdcxXub9K606Ro+VEbXmcdWRLh2QK00X30SgK4dQa7THBtmETHlw2qwNu413zgTAHE
         IEbha7V9nb5a1rvC5BTxBtmF4ZO1vT+dF5jKN8bMv8dLf9wzf0LuHGmFTTnXvzGK/kQ2
         xyJQ==
X-Gm-Message-State: APjAAAXdEOSI4b7GAEdyWr6fy/aGbmKswWAXO6e2sLex4mE2Ai3ZMVOB
        WuGFAVDA3eRK1UStLyTCrGUuwQ==
X-Google-Smtp-Source: APXvYqyFDUHN3AlkoWFUd96BfJL00iwdanUkLj+AoJmRBkQWg8dkdiXjQmnE8o1TBO3LPzxpRgT1Kw==
X-Received: by 2002:a37:4a04:: with SMTP id x4mr16546587qka.408.1562626404157;
        Mon, 08 Jul 2019 15:53:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n18sm7889774qtr.28.2019.07.08.15.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 15:53:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkcVf-000384-Ac; Mon, 08 Jul 2019 19:53:23 -0300
Date:   Mon, 8 Jul 2019 19:53:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
Message-ID: <20190708225323.GG23996@ziepe.ca>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
 <586c629b6d3c718f0c1585d77fe175fe007b27b1.camel@linux.intel.com>
 <1562624644.11461.66.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562624644.11461.66.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 08, 2019 at 06:24:04PM -0400, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Mon, 2019-07-08 at 18:11 +0300, Jarkko Sakkinen wrote:
> > On Sat, 2019-07-06 at 20:18 -0400, Nayna Jain wrote:
> > > +/*
> > > + * tpm_get_pcr_allocation() - initialize the chip allocated banks for PCRs
> > > + * @chip: TPM chip to use.
> > > + */
> > > +static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > > +		rc = tpm2_get_pcr_allocation(chip);
> > > +	else
> > > +		rc = tpm1_get_pcr_allocation(chip);
> > > +
> > > +	return rc;
> > > +}
> > 
> > It is just a trivial static function, which means that kdoc comment is
> > not required and neither it is useful. Please remove that. I would
> > rewrite the function like:
> > 
> > static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > {
> > 	int rc;
> > 
> > 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> >      	     tpm2_get_pcr_allocation(chip) :
> >      	     tpm1_get_pcr_allocation(chip);
> 
> > 
> > 	return rc > 0 ? -ENODEV : rc;
> > }
> > 
> > This addresses the issue that Stefan also pointed out. You have to
> > deal with the TPM error codes.
> 
> Hm, in the past I was told by Christoph not to use the ternary
> operator.  Have things changed?  Other than removing the comment, the
> only other difference is the return.

I also dislike most use of ternary expressions..

Also, it is not so nice that TPM error codes and errno are multiplexed
on the same 'int' type - very hard to get this right. I'm not sure
anything actually needs the tpm error, and if it does maybe we should
be mapping those special cases to errno instead.

Jason
