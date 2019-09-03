Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE2A695A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfICNHR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 09:07:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37796 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfICNHR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 09:07:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id r195so1912986wme.2
        for <linux-integrity@vger.kernel.org>; Tue, 03 Sep 2019 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HBfpn3Dk4pwV3EUM6GvIPj65ceFrv51XFV5NZ2IJ2bo=;
        b=HGA4uSZXXMc1sp1mcXNa9MvyEVfjUtZ4wrTpUgt+R6IgqrlfCVlsbhFgrdY6LqHH3I
         9ky1tTFd+HJ3kD4k7MPEYk2kK7mdzRhRbpj1i2+ky2G+daffJizphjphfY1G7VWun2IU
         A8PtHitPeZGGsShi/P08Mo3ouL9mTrMsVswnQdfqJZ1cq3hGCbVslyurnRgVqUDXNJGj
         qFbcAATO+c48a3OFiJC/6DUzGirNiR58lyi9u5asezZR2aRcYSVAv8Rzqy1gnqiOzQd4
         YoFwJjNCsCroCP6tpseurRTe+mab4XcmLKnlcvqb9tiZyQ4TP9eG32Kj0yvkRivdXXeU
         appQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HBfpn3Dk4pwV3EUM6GvIPj65ceFrv51XFV5NZ2IJ2bo=;
        b=BNe46m6+aM68KswVXZRgizAZL9H1kQx6r4cXO4/xtYm9JqJbE2unwD2pIDGscK+Tp0
         nFzCB0UnDQLUkbb2pffTVVUz/3GQnXSbpjXivC4nP/KhbgP8XsHoYXpoU2zsx7P0/N5x
         Da14dr0BZJz4Rymm2oLW6dSs6YsnQcuamzfnZPVVTkVV87ofLyckHb2HWPZQwzOdkrqp
         1OtLNikBB2mOmOGm8eiVT/1njbNaMlzS9WB4ikhSDZukr2SkMyjucD4WYMQE8SFX0/0V
         wQ5qzjoXRRxJZxmtbx8wJ25+pE8uwHZJ1N0x4lf8cWqMUUqTY2meU2+Z/ppT/kr8A/j1
         b5fQ==
X-Gm-Message-State: APjAAAXXTNsZU3W1Ct3wnhRXlJGaPTkWjTIQslp7deJYTlWEoVoW5XUh
        e5OzXVsDvw0JP6WWqUB5Voiwkf+ouVU=
X-Google-Smtp-Source: APXvYqzm15M0rBTDRPw/Kfyy1TcLpuWq6Z6T1DLHWLujr6AvmTjAfEoGsSXlEbelY/xPpBgSKuqPPg==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr20022664wmz.88.1567516035434;
        Tue, 03 Sep 2019 06:07:15 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 39sm42367745wrc.45.2019.09.03.06.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 06:07:14 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i58Wf-0001XH-Ou; Tue, 03 Sep 2019 10:07:13 -0300
Date:   Tue, 3 Sep 2019 10:07:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190903130713.GA5851@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <20190827010559.GA31752@ziepe.ca>
 <1567007592.6115.58.camel@linux.ibm.com>
 <20190828161502.GC933@ziepe.ca>
 <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
 <20190902192632.GB5393@ziepe.ca>
 <1567460118.10024.316.camel@linux.ibm.com>
 <20190903055523.GA4500@ziepe.ca>
 <1567511346.10024.365.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567511346.10024.365.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 03, 2019 at 07:49:06AM -0400, Mimi Zohar wrote:
> On Tue, 2019-09-03 at 02:55 -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 02, 2019 at 05:35:18PM -0400, Mimi Zohar wrote:
> > > On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
> > > > On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> > > > > On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> > > > > >>> So exposing PCRs and things through sysfs is not going to happen.
> > > > > >>>
> > > > > >>> If you had some very narrowly defined things like version, then
> > > > > >>> *maybe* but I think a well defined use case is needed for why this
> > > > > >>> needs to be sysfs and can't be done in C as Jarkko explained.
> > > > > >> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> > > > > >> TPM 2.0 is a reasonable request and probably could be implemented on
> > > > > >> TPM registration.
> > > > > >>
> > > > > >> If exposing the PCRs through sysfs is not acceptable, then perhaps
> > > > > >> suggest an alternative.
> > > > > > Use the char dev, this is exactly what is is for.
> > > > > 
> > > > > What about a new /proc entry?
> > > > > Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> > > > > What about adding a new /proc/tpminfo that would print info like
> > > > > version, number of enabled PCR banks, physical interface [tis|crb],
> > > > > vendor, etc.
> > > > 
> > > > I thought we were not really doing new proc entries?
> > > > 
> > > > Why this focus on making some textual output?
> > > 
> > > I don't really care if we define procfs, sysfs, or securityfs file(s)
> > > or whether those files are ascii or binary.  Whatever is defined,
> > > should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).
> > 
> > Use an ioctl on the char dev?
> 
> Both TPM 1.2 and TPM 2.0 export the TPM event log as
> security/tpmX/binary_bios_measurements.  Wouldn't it make more sense
> to group the TPM information together, exporting other TPM information
> as securityfs files?

I don't know anything about security_fs, sorry

Jason
