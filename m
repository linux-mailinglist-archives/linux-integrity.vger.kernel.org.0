Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5BA9275
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2019 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfIDTnw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Sep 2019 15:43:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42391 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDTnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Sep 2019 15:43:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id q14so45546wrm.9
        for <linux-integrity@vger.kernel.org>; Wed, 04 Sep 2019 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G2c0v8uzA/VUi3dzJfJE5h4Y91tjEfm/rzTOCcvvjdw=;
        b=cUI2PCouIYK+EkG8Vz6Xj/8iIQ2HusMbh7rlPasV/A84Sn/NF6L/hbjyu4JvGy/lNS
         zxgQXv7CoDCOtJV/GdVszDrYQ/kpVrqg/1hOb+kb7pJ0OfJH9bV9o7GiTGoJWMO/zifG
         0Nc7ClnudemwCJzcc3prhgThNOUrGmf/Fq5CNMBct50djifh3FKmYpzMby2nSOgJYacf
         L6S1fJk5nU+En+Tm5vZ9uZb7VpyT3zrxnGgsBj1z+y/gv0q+RoHN786PQvQIP78tRAqW
         CztMeLwmLOU1jEvAUpmNowkrvji0sdsGzId2U0auZnV6WEUZm4qWa44vSK2L8f4dZKFr
         k3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G2c0v8uzA/VUi3dzJfJE5h4Y91tjEfm/rzTOCcvvjdw=;
        b=PaEPZISJ95SptBaF+hcy+E5WzxIWJ5MdvBZbR2kkBTAUSFN4BTm2O+m+oUh6L/yZuD
         BHuVbte6i4Qs+tDzfi/WrzsXQpM+gpONGQQ88AkOnkyEnT+m51RSV9ywnBX3mVnqMSIG
         0ugb4cdRRRiQWAeEQCvgqr1/c0KUhG8MBtbZ7vsb45KNj69Rre62nESaj8KurR3WDNQg
         8crr3MSn0yS8HNwacRAdqFhcHBE3ecEYOKIUqQy5R1mXOX+2lQGDbvrJnaYwy2r7VolG
         6M4yLoB9T2Epn7GynpQ2uI57nZItZG44+KMXidmhet28rkaulwG8Au99TOKeEw6sgyyp
         MmEQ==
X-Gm-Message-State: APjAAAX/OmwMS1yZ87Jt0fwFi6hoiFWyHpSJVNL+UbPA0I8j5ZbbRulO
        uz8BPMaihyVf5do+lHjf9+HJEA==
X-Google-Smtp-Source: APXvYqwH7og/RliMoJ3yrdWQNKqI4kYTopRsB8VF8wL+zs+mzoq4QuhdgwX1j/OcBLhACwtZhQ/BAg==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr10208380wrt.154.1567626230636;
        Wed, 04 Sep 2019 12:43:50 -0700 (PDT)
Received: from ziepe.ca (bzq-164-168-31-202.red.bezeqint.net. [31.168.164.202])
        by smtp.gmail.com with ESMTPSA id o22sm19978333wra.96.2019.09.04.12.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 12:43:50 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i5bC0-00016Y-Tx; Wed, 04 Sep 2019 16:43:48 -0300
Date:   Wed, 4 Sep 2019 16:43:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jordan Hand <jorhand@linux.microsoft.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190904194348.GA3757@ziepe.ca>
References: <20190828161502.GC933@ziepe.ca>
 <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
 <20190902192632.GB5393@ziepe.ca>
 <1567460118.10024.316.camel@linux.ibm.com>
 <20190903055523.GA4500@ziepe.ca>
 <bc9ab35e-997c-b107-3073-d5150de063d0@intel.com>
 <fe908209-3752-19b2-2652-79fb75f69e2b@linux.microsoft.com>
 <1567553383.4937.29.camel@linux.ibm.com>
 <20190904055829.GA3936@ziepe.ca>
 <1567596658.4937.40.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567596658.4937.40.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 04, 2019 at 07:30:58AM -0400, Mimi Zohar wrote:
> On Wed, 2019-09-04 at 02:58 -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 03, 2019 at 07:29:43PM -0400, Mimi Zohar wrote:
> > 
> > > This discussion is going around in circles.  There are enough people
> > > asking that the kernel provide at least the TPM version (eg. TPM 1.2
> > > or TPM 2.0).  Userspace applications/regression tests shouldn't have
> > > to figure out the TPM version by sending a TPM command and seeing if
> > > it fails.  That really isn't asking a lot.
> > 
> > A single version number could be appropriate for sysfs
> >  
> > > I would also prefer not having to be dependent on a userspace
> > > application to read the TPM PCRs in order to verify the IMA
> > > measurement list.
> > 
> > Why?
> 
> Being dependent on a userspace application implies a level of trust,
> that might not be warranted, depending on the system's
> configuration.

Surely if you can trust 'cat' you can trust something that does ioctl?

Jason
