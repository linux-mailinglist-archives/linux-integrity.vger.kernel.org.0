Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C364B31FE
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2019 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfIOUYg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Sep 2019 16:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfIOUYf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Sep 2019 16:24:35 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125AD214AF;
        Sun, 15 Sep 2019 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568579075;
        bh=LCVK2aMgwTZJzb8J63CkOjhrW0RaVm+XZQ9QcWk8u64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LromhxrgzgBiWiRCWifYke78su7FoAeFk4hbabgMD3j1OY6I9lhHsv4j7lLe+hR8F
         IKDuRV1fnXI2+eGX1ZZ9vk4p1Uh1DSEbxGugPzhHZiCDEVAGazw+dCaOy9n9lxcf8I
         uSQcy/lO1NXYFgdb7hVEa77AxizYUGFADjSSyKTM=
Date:   Sun, 15 Sep 2019 13:24:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: Re: [PATCH 1/3] ima: keep the integrity state of open files up to
 date
Message-ID: <20190915202433.GC1704@sol.localdomain>
Mail-Followup-To: Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
References: <20190902094540.12786-1-janne.karhunen@gmail.com>
 <20190909213938.GA105935@gmail.com>
 <CAE=NcraXOhGcPHh3cPxfaNjFXtPyDdSFa9hSrUSPfpFUmsxyMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=NcraXOhGcPHh3cPxfaNjFXtPyDdSFa9hSrUSPfpFUmsxyMA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 10, 2019 at 10:04:53AM +0300, Janne Karhunen wrote:
> On Tue, Sep 10, 2019 at 12:39 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > Core file operations (open, close, sync, msync, truncate) are
> > > now allowed to update the measurement immediately. In order
> > > to maintain sufficient write performance for writes, add a
> > > latency tunable delayed work workqueue for computing the
> > > measurements.
> >
> > This still doesn't make it crash-safe.  So why is it okay?
> 
> If Android is the load, this makes it crash safe 99% of the time and
> that is considerably better than 0% of the time.
> 

Who will use it if it isn't 100% safe?

- Eric
