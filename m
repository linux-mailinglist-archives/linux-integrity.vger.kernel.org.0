Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6066BEE
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 13:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfGLL6M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 07:58:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34879 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLL6M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 07:58:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so6171855qke.2
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RqRy3ex0kg0EzOgSloUclGJOSPqC0vewvlzV5LfMXp8=;
        b=LT998PEi/w78gh0eEzS778lX5zHjWCRa0vQcxBycPEyrXroL82Qeul9Zo1h/bn6T73
         hnca7bAEC6HQpuoOzvZ2mEtzr749H+mQQEsNZgk4C//ANI7ztx2Adh3SWWhw/roqx69g
         Gn3uzaBAJT0dNZl5o03WLFhhtTeKfWVbbiq9L47wwJtrLVEGB5D54y5xzy6VsfQrLAM/
         JD7AUS2a1/+2Oeq8DR/Vf9+kS7W7to+a4CmVsORW55nVe4bM1A5GpVRLZ2QP299Nh2ha
         KkYBthqX6OhYfO8Ai9BFRTh3Tj2hy/MNybmt8oUpL7hybGfXsKEqDUcPkPeAKi09x8MQ
         YhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RqRy3ex0kg0EzOgSloUclGJOSPqC0vewvlzV5LfMXp8=;
        b=TOLyflKJTqTZOa+Aly45GQeHb/kHpCOy1hpGR1omU0sPwgmbk2/SyrfRQyPYkwAs8N
         1KTc8fSCAMI6bQVJzhCP+dd4n3cuYmsbqc00hq4fO+070Kqqg1kGeXHbnvorBkSUPdUy
         tHlxiCAEs0lFXw4S77fvlxQjiz6zA6MTy6jdEiIwECNlQ6YOULQ592jYj9maJtTx3tSA
         xqrY8qfJrsb2IHZa62ghD4OLlK+nSlLAMw8l4uvCrgq+5SLY4Yk0O5lOBX9hoUeJqJF4
         zfJqoRm6Qc6PNYmuQF+SkkUMiwN+xTvO/waa6XY2VI6MY9Itqa75JmTPRfau4ejH/hfq
         Rj/Q==
X-Gm-Message-State: APjAAAUCZsnxa38ws+W9FRx/+rFkIZxFZBmcdBGfaTdgAFXT72itlBuV
        FudHltGh2Akezjzn5t0sEy05OQ==
X-Google-Smtp-Source: APXvYqyKvqjfx8L7GmIfUnw6VhpzkL8Lz6tyD5fb9RnPX6kifoSR8YnzphO/uLMPMJVvXtow4lEJcw==
X-Received: by 2002:a37:63c1:: with SMTP id x184mr5941081qkb.6.1562932691410;
        Fri, 12 Jul 2019 04:58:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j19sm3065179qtq.94.2019.07.12.04.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 04:58:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hluBm-0007Av-Bc; Fri, 12 Jul 2019 08:58:10 -0300
Date:   Fri, 12 Jul 2019 08:58:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org,
        groeck@chromium.org, gregkh@linuxfoundation.org,
        sukhomlinov@google.com, Arnd Bergmann <arnd@arndb.de>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM
 operations
Message-ID: <20190712115810.GA27512@ziepe.ca>
References: <20190711162919.23813-1-dianders@chromium.org>
 <20190711163915.GD25807@ziepe.ca>
 <20190711183533.lypj2gwffwheq3qu@linux.intel.com>
 <20190711194313.3w6gkbayq7yifvgg@linux.intel.com>
 <20190711194626.GI25807@ziepe.ca>
 <20190712033138.tonhpqy4yfdlkvs4@linux.intel.com>
 <20190712033556.4pze65z7cxga5tdu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712033556.4pze65z7cxga5tdu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 12, 2019 at 06:35:56AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jul 12, 2019 at 06:31:38AM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 11, 2019 at 04:46:26PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 11, 2019 at 10:43:13PM +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Jul 11, 2019 at 09:35:33PM +0300, Jarkko Sakkinen wrote:
> > > > > > Careful with this, you can't backport this to any kernels that don't
> > > > > > have the sysfs ops locking changes or they will crash in sysfs code.
> > > > > 
> > > > > Oops, I was way too fast! Thanks Jason.
> > > > 
> > > > Hmm... hold on a second.
> > > > 
> > > > How would the crash realize? I mean this is at the point when user space
> > > > should not be active. 
> > > 
> > > Not strictly, AFAIK
> > > 
> > > > Secondly, why the crash would not realize with
> > > > TPM2? The only thing the fix is doing is to do the same thing with TPM1
> > > > essentially.
> > > 
> > > TPM2 doesn't use the unlocked sysfs path
> > 
> > Gah, sorry :-) I should have known that.
> > 
> > I can go through the patches needed when I come back from my leave after
> > two weeks.
> 
> It might require a number of patches but maybe it makes also overally sense
> to fix the racy sysfs code in stable kernels.

The sysfs isn't racy, it justs used a different locking scheme

Jason
