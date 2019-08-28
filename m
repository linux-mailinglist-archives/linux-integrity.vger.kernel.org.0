Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E915A0709
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfH1QPF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 12:15:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42529 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1QPF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 12:15:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so121548qtp.9
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Cac+BcblhjGCO9RrpyF1Iolw9i767Kpb2g+OL0172NE=;
        b=ib2buGCBlhlyVC+U8cYjRWSZE+vkybB6BCcMzRZkHyatsOL5kx2185pfzIT7SttJz7
         fp63cqnrA3YqX6Q5K8eyk/aKf4QjkH4IyznMBDQdh1/UmzdPg9is8ERb4QGj4xjC9SQZ
         I8DxPj/4QOgAPPbUXqOJsIKRfvKGBwPoXAByiIU8MzXXxSihpvWWtMNo7bHX1DiDrrXV
         pm0sOaYx/Tu+HXgqrcj7Ti+FIM6tr8Md1qkJSxfHyNSwOFSpMYWZId10r16X0vR1IjkP
         qadXFKi3CId4+0uTelPIwUlzO6uCfcfEq21Gb/iv7l8vOt3tIEr2qes+9eLuK3/6UXI/
         P/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Cac+BcblhjGCO9RrpyF1Iolw9i767Kpb2g+OL0172NE=;
        b=F2EtmoYaBZ/a4FrTF5KNC5iIPc+tUbrEcvtzW97KT4XGy310HCqwQgh19RcsWbbKim
         BVL0gfi1ghbcJMd89sXNYDjJzYy8ha8P16s1mOF7GP9yik/wmS1nQIdJ52RVtdLfdYr1
         6SKQP7vxwTGowODA39HjQdnZFpWgwz1pbT+6U0Zg1KL+D5uue08kKqdGtV0f0MgcxWG3
         Z4i516asQw5jxhQkILeqxSzKWHGn/n3CCdpmgQIPiCHITsNCasoVHoFPyCV3b7optEh+
         KpaIVNkDyMY1/LuAVMmHs+kOggBvW6LPWEjZ7GQ/1YuNWCkECO9HMLlT+tAGuutUQMxm
         6nag==
X-Gm-Message-State: APjAAAXeUV+WGzYfV5tseoAF4CA/46d7Fo+cAJdVJ0Ei+LTCaAhWuVhi
        7//sNUEPztybcqOinuaDEYMcrkG1x2I=
X-Google-Smtp-Source: APXvYqz6mfGTk+HcpACXRiBSX/A1ZZsFcuMedcNea7/oVrhB5RSSKR0Tz47gf7qUXtPGwsvWUR/kMQ==
X-Received: by 2002:aed:2a86:: with SMTP id t6mr4940270qtd.391.1567008903933;
        Wed, 28 Aug 2019 09:15:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id z187sm1487442qke.99.2019.08.28.09.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 09:15:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i30b8-0004pK-Qu; Wed, 28 Aug 2019 13:15:02 -0300
Date:   Wed, 28 Aug 2019 13:15:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190828161502.GC933@ziepe.ca>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <20190827010559.GA31752@ziepe.ca>
 <1567007592.6115.58.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567007592.6115.58.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 28, 2019 at 11:53:12AM -0400, Mimi Zohar wrote:
> On Mon, 2019-08-26 at 22:05 -0300, Jason Gunthorpe wrote:
> > The sysfs is not done, fundamentally, because the sysfs structure of
> > the existing TPM1 stuff is grandfathered in, and doing anything like
> > it for TPM2 is a complete NAK for not following the normal sysfs
> > interface design rules, particularly of one value per file. This is a
> > big part of why it was dropped for TPM2.
> 
> The original TPM 2.0 support was missing a lot of TPM 1.2
> functionality, including exporting the TPM event log.  So it wasn't
> clear that leaving out the sysfs support was intentional or simply a
> question of someone needing to implement it.

It was intentional.

> > So exposing PCRs and things through sysfs is not going to happen.
> > 
> > If you had some very narrowly defined things like version, then
> > *maybe* but I think a well defined use case is needed for why this
> > needs to be sysfs and can't be done in C as Jarkko explained.
> 
> Piotr's request for a sysfs file to differentiate between TPM 1.2 and
> TPM 2.0 is a reasonable request and probably could be implemented on
> TPM registration.
> 
> If exposing the PCRs through sysfs is not acceptable, then perhaps
> suggest an alternative.

Use the char dev, this is exactly what is is for.

Jason
