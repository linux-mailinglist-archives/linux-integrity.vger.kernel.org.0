Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215A2A60DA
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfICFz2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 01:55:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfICFz2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 01:55:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so15981138wrt.4
        for <linux-integrity@vger.kernel.org>; Mon, 02 Sep 2019 22:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qs1zOUIDKmoVBr3Xp78rpcg5lChZyelbkdgsIEkY4UA=;
        b=DATnU2eu0YeV44/Y9F6ccXu8iwK+FO3SPE37W2q/wOeJdMhEZQuFKyyGb8IWfTrV1f
         HGpHrWO+6XDy1H3qOZ6HI7kD0fUWO1ZQJbFKapRMb3PPLvMnfTw1dZOBsMvQ6WNI97ms
         nWQTV7qK3rJRAgLSSKyBWQTab9V0j1Yl3iz/UF0ICAUcLSFQpgGWhhEuFj2wFkXCbPSf
         xlj1TDvPf3jfJvqAjXSgn9F5lAqgFRFYb+G2e5KMOmobX7Izh253AReIYruvJWjBMaQn
         6SjjibXeeu+shpJk4NcQb6pC85H81pxzYIc9AJK8FZrsHzxdPdJbcmtnNz1Xio3HvYQA
         LmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qs1zOUIDKmoVBr3Xp78rpcg5lChZyelbkdgsIEkY4UA=;
        b=c+Zufum3lFIvUAllGMImgnDvxj2ULkU1sCPfBaf799ATbO4e/wtlsXz6POHQP+zlbs
         AFHStq7EfFXNLbrBz8imgr1+YgWZ+L1BmMtVnf0ruxHeSZPO2kh+LlFBltqGuqfcUBta
         OKQ/8wwG1L+lewn1b6Zqu7gIZ+dlcXI6CEaSH7/UaDkysKHhuk2V2Fjv/Ky6iIwKZmgL
         RpAgLPM+QGsr2Jx1u83tegKPjwALO9FiMGY9OnLy0+Wr4hzoFhMmVhsx6gA4/d4prb2U
         h3vcauXYlZHykzQiLRiEzKDpGKTGaDDs/Qxkl2nw0gqiBpeGKWiJjzkCp/5K53eqm8c3
         grYw==
X-Gm-Message-State: APjAAAUObZGqIz8InW2HOwrvedtjYW1yfGs9hB71XhuMLs86sBvwaQBr
        KDzrCrmDd8IS7y8GFn9A5IQPe6hhuqk=
X-Google-Smtp-Source: APXvYqwHLMPIZnB41RjbJJVs5tbG/L1g3dq+FfcG63C0WnVjuADzslqzJmnjtnNukypbX/fjuiSamg==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr11964787wrq.328.1567490126196;
        Mon, 02 Sep 2019 22:55:26 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id w12sm2372369wrg.47.2019.09.02.22.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 22:55:25 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i51ml-0001Ax-V7; Tue, 03 Sep 2019 02:55:23 -0300
Date:   Tue, 3 Sep 2019 02:55:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190903055523.GA4500@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <20190827010559.GA31752@ziepe.ca>
 <1567007592.6115.58.camel@linux.ibm.com>
 <20190828161502.GC933@ziepe.ca>
 <f7e1f25a-8b2d-1e0e-e784-0908161c3c99@intel.com>
 <20190902192632.GB5393@ziepe.ca>
 <1567460118.10024.316.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567460118.10024.316.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 02, 2019 at 05:35:18PM -0400, Mimi Zohar wrote:
> On Mon, 2019-09-02 at 16:26 -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 30, 2019 at 02:20:54PM -0700, Tadeusz Struk wrote:
> > > On 8/28/19 9:15 AM, Jason Gunthorpe wrote:
> > > >>> So exposing PCRs and things through sysfs is not going to happen.
> > > >>>
> > > >>> If you had some very narrowly defined things like version, then
> > > >>> *maybe* but I think a well defined use case is needed for why this
> > > >>> needs to be sysfs and can't be done in C as Jarkko explained.
> > > >> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> > > >> TPM 2.0 is a reasonable request and probably could be implemented on
> > > >> TPM registration.
> > > >>
> > > >> If exposing the PCRs through sysfs is not acceptable, then perhaps
> > > >> suggest an alternative.
> > > > Use the char dev, this is exactly what is is for.
> > > 
> > > What about a new /proc entry?
> > > Currently there are /proc/cpuinfo, /proc/meminfo, /proc/slabinfo...
> > > What about adding a new /proc/tpminfo that would print info like
> > > version, number of enabled PCR banks, physical interface [tis|crb],
> > > vendor, etc.
> > 
> > I thought we were not really doing new proc entries?
> > 
> > Why this focus on making some textual output?
> 
> I don't really care if we define procfs, sysfs, or securityfs file(s)
> or whether those files are ascii or binary.  Whatever is defined,
> should be defined for both TPM 1.2 and TPM 2.0 (eg. TPM version).

Use an ioctl on the char dev?

Jason
