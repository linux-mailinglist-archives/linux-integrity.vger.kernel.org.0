Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3BB5734
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 22:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfIQUyS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 16:54:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQUyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 16:54:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12so4602463eds.6;
        Tue, 17 Sep 2019 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TB55ogVb7L8Rnu3J7GOd1CTL9DFPAcCA1b2WA++LLLI=;
        b=eXL7i/wN7GH6Vg8CmKxQzNRZqwTGKPKReKUXNjbUDxJBsbaoKuTv2WhQj5LHhHJpXm
         oautn+efA3gz0kSro5bUCcJVZQVBLUyLxb4YCuWmAzRzrnBA5MJZsem6hlUSZVWup6a/
         Xvf+SgcqbOGD2PwUX6hzZN80jtJYz35lyc6BeP/7YTPTcRoJ888Y6II9fuYR+tj+KonK
         C2uTpTrcHKeOpqpjfWBqbzbnGojiJdArPYR41YbhBDpXniyg7vdT3iuaMzjOsf1hsvlb
         mlojdKbD+hLueWkALJGurBh6/X17j9NQAxEpUCYwgTZIHI2G1N9CsY55cso3hXb7ttqf
         hZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TB55ogVb7L8Rnu3J7GOd1CTL9DFPAcCA1b2WA++LLLI=;
        b=LSkG27rZWs3XlZG6Y9pgkusPkvgFY+MgN76BgD8I6tw/ULA4Fjgep7N9lDSu4MRXoO
         N+bENX+vGvgIeHd62RSyvj8dJsBJSbJqaGM/qyVV8hjmvs9xsSQeSfeEGV7alz3+1xau
         5IQYV/OhnSH2tCNZ0LP1jC6g4QEuvpGT78jCRI7ZYhzItUqecDTb1jB5vWdpjV/L/zH5
         Y9oRD+Xs1WXAW5N0CdJDnSf3Ul4jX8aPk/hM6n+RQB9yAnyU+E6Ko0NBdrs0t+PEbpAU
         2Y1Yp9c4fDGH62Vhd+4XCwP1/ziltR6lLLzH+7e6ezTBj0jsiFd6CI1Ky60DHbPx0EEv
         jIOQ==
X-Gm-Message-State: APjAAAWSN0ycK/CxWW0bWqv8VKs5IZusLRIS1pD5CuaAj6rnuwqxo9TW
        FKmE0/5XEm571qGe79d4/Z8=
X-Google-Smtp-Source: APXvYqwvE6X1EVnGhC9HVkhxDzcqBzkxXBlXuu8iArgUgF2V6xspFM36gdqHu0QLdhUXF8/RxV0Wsg==
X-Received: by 2002:a17:906:6dd4:: with SMTP id j20mr6585951ejt.173.1568753656032;
        Tue, 17 Sep 2019 13:54:16 -0700 (PDT)
Received: from hv-1.home ([5.3.191.207])
        by smtp.gmail.com with ESMTPSA id h3sm407037ejp.77.2019.09.17.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:54:15 -0700 (PDT)
Date:   Tue, 17 Sep 2019 23:54:03 +0300
From:   Vanya Lazeev <ivan.lazeev@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20190917205402.GA2500@hv-1.home>
References: <20190914171743.22786-1-ivan.lazeev@gmail.com>
 <20190916055130.GA7925@linux.intel.com>
 <20190916200029.GA27567@hv-1.home>
 <20190917190950.GG10244@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917190950.GG10244@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 17, 2019 at 10:10:13PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 16, 2019 at 11:00:30PM +0300, Vanya Lazeev wrote:
> > On Mon, Sep 16, 2019 at 08:51:30AM +0300, Jarkko Sakkinen wrote:
> > > On Sat, Sep 14, 2019 at 08:17:44PM +0300, ivan.lazeev@gmail.com wrote:
> > > > +	struct list_head acpi_resources, crb_resources;
> > > 
> > > Please do not create crb_resources. I said this already last time.
> > 
> > But then, if I'm not mistaken, it will be impossible to track pointers
> > to multiple remaped regions. In this particular case, it
> > doesn't matter, because both buffers are in different ACPI regions,
> > and using acpi_resources only to fix buffer will be enough.
> > However, this creates incosistency between single- and
> > multiple-region cases: in the latter iobase field of struct crb_priv
> > doesn't make any difference. Am I understanding the situation correctly?
> > Will such fix be ok?
> 
> So why you need to track pointers other than in initialization as devm
> will take care of freeing them. Just trying to understand the problem.
>

We need to know, which ioremap'ed address assign to control area, command
and response buffer, based on which ACPI region contains each of them.
Is there any method of getting remapped address for the raw one after
resouce containing it has been allocated?
And what do you mean by initialization? crb_resources lives only in
crb_map_io, which seems to run only once.
