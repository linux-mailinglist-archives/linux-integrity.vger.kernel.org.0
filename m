Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB314AC1
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfEFNR7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 09:17:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39364 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfEFNR6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 09:17:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id z124so2978627lfd.6
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QVT5o2K6/T5zLL35om1EwXW18M/KI6lG6aQFJ/qM2gA=;
        b=VPsNkqKNiVylTtcTcopQKxzFBPEbn51Gf6/pFeguiezsIzKcUpDaf3f/g1bt8lvtAl
         GjFQNCH7yj1d31t60n3pcBFNblNMtRiGxQfwmZ3MHsJUohM94mevTMJ5IuyEFBHw6ESg
         KAmep8KLr2b2f1h9naKG4J35UIPYfwQNnaTK/0rMPDBs6Vh569uYzQWaZVgjekwaTkKI
         O5Gs2TSA8QfpPz0FJJcNknCXrk+53GNTCcTxudcCulgVWwpwKuQgeoA/lpt9KeiaFTbk
         pZme4awbRDuWEV8RalGYt1au5fviJPzMqMf+9F27qOos0Z6Pe57nkNvsB0IyuSIJ38nA
         svVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QVT5o2K6/T5zLL35om1EwXW18M/KI6lG6aQFJ/qM2gA=;
        b=ODs+xnkIvu53k5TBT6imG5KfHbrc2FGDuRKXHJ7wyDx+UMMgSgM9PFi0peFvUfSHZ2
         kWfk77fIvPQlXmb4Vh7aSU0fMKdP/Iuk9xxduCmW+tfnjHY/uiWF/9n5vtcdmBwjakZT
         Kq2UwTriyfXq8lf/iNbhfjk4W1EZFKeuKWlkiEJdNIuPuKf64zztwwQcAUn4Ho7VNGnF
         4WwxaGBi1kGqvP2hZjerlGlCO5cwfYvbNC/5JLK1iyUbcYrQedgkFAPJGTK3HQeXmrWX
         /H3xrAijiy7+ednOCaLdtdHQ2NLDhi8Dn4TmAmQUxI3n3zyQ0B2yOyepwM/9WzyaRdLp
         H9wA==
X-Gm-Message-State: APjAAAW+/ifcf5UkD+kG9p3hyl1HjmA6t7I9aN34imIZlzxCab9VrBe9
        flv9ORyA47WRN1xxMVo0wL9kUGkm0G69sHGl6/c=
X-Google-Smtp-Source: APXvYqxpF5YhWukRzprxiPxJVyQDgchQwhcq0FucV8Api0+yuNQ06cSJc2rCYGrkNBEDuPhVKtRhYFGRqsVFQE8dpNU=
X-Received: by 2002:a19:6a18:: with SMTP id u24mr8216440lfu.165.1557148676798;
 Mon, 06 May 2019 06:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
 <1554987784.7843.40.camel@linux.ibm.com> <CAE=NcrY_nwjdPoD+hk90CW93LTDattY_g-qQcqFQa=Xb7M+wPA@mail.gmail.com>
 <CAE=NcraxAJum=Uk77BoPXVkBDk3rwmXh80mLxy6pxrtUW_hpQg@mail.gmail.com>
 <1556805843.4134.15.camel@linux.ibm.com> <CAE=Ncrb4unTxeU=2jLb-KTqKXpK98vGFbrOxdcnjdfD_Ddk8ug@mail.gmail.com>
 <1556884105.4754.18.camel@linux.ibm.com>
In-Reply-To: <1556884105.4754.18.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 6 May 2019 16:17:45 +0300
Message-ID: <CAE=Ncrbjq4MEZL5b6A6n8q2REsb_vG-TFMh54A+dgpQ8an4tyQ@mail.gmail.com>
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 3, 2019 at 2:48 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > > [1] f02a9ad1f15d ("fs: handle inode->i_version more efficiently")
> >
> > Thank you. I wasn't aware of this and it makes sense,
>
> The question is whether this impacts your current set of patches?  We
> really need to take this discussion back to the mailing list.  I've
> responded to my original post with this info.

Hmm, if we add the iversion query as you suggested the function can be
added as a polling point just about anywhere. I added it in there now.

I sent the current state of the upstream port as a new patch with a
proper topic. The mm page scanning code is so rough that it is still
omitted, let's continue the discussion from the core plumbing first. I
did not adopt to your function naming changes yet as the scope of the
work is now much wider, plain 'ima_file_sync' may be misleading as we
also follow the data as it's being written.

Before you ask, the reason why it now does the periodic measurements
of the files as they are written instead of doing 'mod_delayed_work'
timer kicking is that the 'mod_delayed_work' seems quite heavy. Now
there is almost no added latency to the 'write()' loop, just random
measurements with freely definable intervals.


--
Janne
