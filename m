Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432751FECFB
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgFRH4U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgFRH4T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:56:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADEC06174E
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 00:56:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so2928175lfm.1
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9krHxDm9232DkZH73IfiKQDn78nhY5adj2UGMySsUag=;
        b=C0JO+OqUyzOIPzVhe0IKx5WiIHZGVLIjjF8TPiG06mccd1TI0Qcu4Z8e7q4ImmuvWC
         y/zNLAWSG6DGOwuj4XlorHkNxi0G6F/mXRLNYhYVUVTiSyEBK26ys7DSNG6a90kQAjuC
         oIPSY50dBh7S1WLtoJDf1JDy5g7zWJwC0uCEbfA/4kksWZDQU5m95QeW9tvVNk9PBjJm
         wbPoRxwcQFyRiP807OppItugR1cicnXpSfHpZY7shsPjFCva1FhO9KZ6WtXs9Ou8WrOD
         gDBwGOVmstHfGaW5MpoWs457chL7M/SCdEgJmd7uAMdZc178bvY+yIHqi1eCRxnGzIfH
         IBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9krHxDm9232DkZH73IfiKQDn78nhY5adj2UGMySsUag=;
        b=PK0N/MRDOxDSpmDQDYjvDK1Dt+VVjVWPxAw3lm7GmjoibNWqFd6WFa4nSMjIoEQYCr
         XY+lFfNcZEEFkkmeAb8u7LDsYdVMNQbtaBDBJUlMQD7gxYs2/OYWoPbOUxMMl6P0zyE1
         FQo5YOyrmIiOj3RPs5vTKSRtTwWcINFDoKTZ9aTy2MgLtcvpLl/FlxNTwu0oTCWYbjMK
         R3xjuqJHZDR3N78cwIqHidBaG+y40j1gmfRNl0c5lM4o9JUtdz3/Rnox17QFu8sobolX
         BdrW/8fn0hmzginTvJAa0ZZaGN3yji6QqeAzwksBufUgsFpfxNe1AeojlOrNxK1iR5UN
         neyg==
X-Gm-Message-State: AOAM531KOIyzVW+9J8LA+Gdx6P5BbuF3JQh+Sge7xLKhqqE7pkeujmUQ
        HUMYTFWXKhAq1AOEGFfSfP7P6Q==
X-Google-Smtp-Source: ABdhPJxI+czQ4wnj4ttlJ5Va+zsODJ2h7H00X3rtIM3suScO0bPx40diTMspq4kLSgr9XVn87noe3g==
X-Received: by 2002:ac2:5df2:: with SMTP id z18mr1652377lfq.151.1592466976306;
        Thu, 18 Jun 2020 00:56:16 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id e21sm526724ljb.135.2020.06.18.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 00:56:15 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:56:13 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200618075613.GA97184@jade>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616082907.GA2305431@jade>
 <20200617233755.GI62794@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617233755.GI62794@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 02:37:55AM +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 16, 2020 at 10:29:07AM +0200, Jens Wiklander wrote:
> > Hi Maxim and Jarkko,
> > 
> > On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > > ping.
> > > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > > were merged. These kernel patches look like they are hanging
> > > somewhere...
> > 
> > I'm almost OK with this patchset, except that
> > Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
> > for the new kernel version and TEE mailing list which we're changing right
> > now.
> > 
> > The last patch touches files I'm not maintainer of. That patch depends
> > on the previous patches so it makes sense to keep them together.  If a
> > TPM device driver maintainer would ack that patch I can take it via my
> > tree. Or we can do it the other way around (with a v9 patchset),
> > whichever is preferred.
> > 
> > Cheers,
> > Jens
> 
> Probably easier if you pick all three and I ack the one touching TPM.

Makes sense, let's do that.

Cheers,
Jens
