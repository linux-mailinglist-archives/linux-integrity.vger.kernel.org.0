Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25432E6A03
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 00:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfJ0XBL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Oct 2019 19:01:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46808 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfJ0XBK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Oct 2019 19:01:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so11920027qtq.13
        for <linux-integrity@vger.kernel.org>; Sun, 27 Oct 2019 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AwrnCk33OKRxa26glgi+iRF9d8YrVAmHFL04ybB9rB8=;
        b=TbBh1/Z/9/SbYwLKwU+beCIrux7qplvlOuNsleSyxV55/iBzDBRUS07BA5aBHmLF1U
         yM3AwJ96V0P15wsZ1HWZ3Hy20fB986J1ddjDuOdenJnh/sIR7Rn1aFINWBmI2AkioVZc
         M3/FX9i0eX38Plcd/dEOn9ergcpC9Dg/9IvEIkwhMq3Qshe/dYfyzC+Gz21gfvAIxMI3
         mhVdt8xu7aGgtr0h3aiModVEgqMmaSmvao/C3k2ShifTXk9Qmyoaq3UC70IJtnJcgc/9
         SANwu5yGYPoJ1y9QkTBMS1Pftmy/pG/Q1uoql32FD8Zx9sqfMVj9MToE7VQLGu8tlfIR
         NJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AwrnCk33OKRxa26glgi+iRF9d8YrVAmHFL04ybB9rB8=;
        b=Dkjp32jskFOAeooBEx++9fRCBo3VTZDOTRCEHkdQKvfR4KyXEqio1Q57x6r0KahzpR
         OzJtUBuVd1s8X70Z4Z9dApRZPJ9Qes/+qhGokpBjB9SUEbcQlWJMErRqPKJ+lGUpgiab
         ZXyJsqQnnRXWuVLloG2zsCza6wTyDJbztajaGu/eHiKarjik+GxLMkBKm/dR06EU6kw+
         q/h+UXcqssdXEz5uKraD6jtfJdlnabfY0npcByR1OIQKRnu5WUBxB8tHClz3y1NDH2SD
         tCBafBJH9hETLaQLDGBfZGXt+zwwnNRJ5sERJb/5WI0qAfIme9UulmFe7Q6HaEGNVC2w
         a11g==
X-Gm-Message-State: APjAAAWfGHoZ2+FTel0BA8hKoyN1Anb/zwNhtUL3N6ppOItSdLINxl11
        mfG4Ha+B2uk3YntihTE3thFT9Q==
X-Google-Smtp-Source: APXvYqyGf9PFRActmzbyn0Z6XSmTBjkBRZniZGllMFbOhlp4zSMyW5uv/ERR5NhQx1S06O+A9zGKrA==
X-Received: by 2002:ac8:682:: with SMTP id f2mr14655008qth.149.1572217269836;
        Sun, 27 Oct 2019 16:01:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v137sm4947654qka.64.2019.10.27.16.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2019 16:01:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iOrX2-0006D2-SD; Sun, 27 Oct 2019 20:01:08 -0300
Date:   Sun, 27 Oct 2019 20:01:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191027230108.GK23952@ziepe.ca>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
 <1572027516.4532.41.camel@linux.ibm.com>
 <20191025184522.5txabdikcrn2dgvj@cantor>
 <20191025193243.GI23952@ziepe.ca>
 <1572032562.4532.74.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572032562.4532.74.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 25, 2019 at 03:42:42PM -0400, Mimi Zohar wrote:
> On Fri, 2019-10-25 at 16:32 -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 25, 2019 at 11:45:22AM -0700, Jerry Snitselaar wrote:
> > > On Fri Oct 25 19, Mimi Zohar wrote:
> > > Yes, there should be an entry added to
> > > Documentation/ABI/stable/sysfs-class-tpm.
> > > I will fix that up and the TCG not being uppercase in a v2.
> > > 
> > > Should Documentation/ABI/stable/sysfs-class-tpm updated in
> > > some way to reflect that those are all links under device
> > > now and not actually there.
> > 
> > Applications should not use the link version, that path was a
> > mistake. The link is for compatability with old userspace.
> 
> Are you suggesting that userspace has to search for the device info? 
> That makes no sense.

Why would it have to search?

Jason
