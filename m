Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B357A2B4D8A
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Nov 2020 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgKPRig (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Nov 2020 12:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387490AbgKPRhy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:54 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A98C0613D1
        for <linux-integrity@vger.kernel.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id e139so6813735lfd.1
        for <linux-integrity@vger.kernel.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=HKbDpA8RbHc7R9WeYnYhMYC3gxw9weFs3lMu3SDaX0XkAID5B1sf9E42rWBynbT+Sx
         yT3uEIqvHZJzSY1G2ko5rQ9hLa877Siaz6/opPHEMxfi0DtcEJEuWQQNCPcD356BV5kx
         d7ODwPPcAS09cbveKqn/VdCocdxDt/vjlquyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=HLDemt22gPepgajLIuVPCuTCLtC5iGw61R+LRKgsqFhKqbeGlP4EKqELbHOnyZjBgd
         O60Hy89dG5b5pc7ixF7FofOr17g10ZvYysd9I2Q3EE16JKLAMBT+BiKFyylsQqZxiWiK
         885sZtawc+hCsvOf23LS5ZyZvN11O/3HavnZt2GA7Gi8WwSLvLHovVlochbsKKf5ef57
         VrMWUSmP5+Sy1JftCih93QNcWzWWcKQq9aCOk2bBS94LdXo5G4wgNbsejVOHNbJZHMNj
         AZFIbAJS93luRT1XOPSc0AUHYUUth8vUCdjv8sfPLvOKtATlGzQ9arMROeU83SjLTNQQ
         BfbA==
X-Gm-Message-State: AOAM532jQ134fnv0bkd61kXWRQZw5enCK0EYMBETFO0jYw8P62h0knJC
        jYJ1X+Vp0cD9Hu90+zKwokoe8hsOUINIQA==
X-Google-Smtp-Source: ABdhPJxSQIfxYuOFcmAfUErBunfB6iHxU1FlPusVJhYfFNY5YpAqtNXqE9+/ce6oguDi2Y8qy9AESw==
X-Received: by 2002:a19:bce:: with SMTP id 197mr189579lfl.468.1605548271334;
        Mon, 16 Nov 2020 09:37:51 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r27sm676564lfn.290.2020.11.16.09.37.48
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:37:49 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id o24so21069326ljj.6
        for <linux-integrity@vger.kernel.org>; Mon, 16 Nov 2020 09:37:48 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr153620ljo.371.1605548268341;
 Mon, 16 Nov 2020 09:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
In-Reply-To: <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 09:37:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 16, 2020 at 8:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> This discussion seems to be going down the path of requiring an IMA
> filesystem hook for reading the file, again.  That solution was
> rejected, not by me.  What is new this time?

You can't read a non-read-opened file. Not even IMA can.

So don't do that then.

IMA is doing something wrong. Why would you ever read a file that can't be read?

Fix whatever "open" function instead of trying to work around the fact
that you opened it wrong.

             Linus
