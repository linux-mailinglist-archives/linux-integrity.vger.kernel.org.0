Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4B48BB23
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jan 2022 00:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbiAKXBk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 18:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiAKXBk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 18:01:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A8C061748
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jan 2022 15:01:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so2300923edd.12
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jan 2022 15:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8xGwb6bxapB0UXlu0Xx56F1dpfAwDFJuxyurOCX0cA=;
        b=JGMJ95jpmcSfIGK4Ik68I9qPG4WOvyoHle2cDu5D+sBMPOclHTWYJhYgCVJNpTZL0O
         UKEWG6fogcYshkz/N0H89Q/tUVZ2ETmWSNLDIuCAT8ILRHNJ6nf+JuXgIX3c5YHjt9b/
         CxZl6Pg/fswspoktujTtplKUdN2ZRtQ/sEw5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8xGwb6bxapB0UXlu0Xx56F1dpfAwDFJuxyurOCX0cA=;
        b=EVuNIsP6ym5Yy5ckrEXX3mjWoYunhYyooSGi7wDWVuzIR9ZmoM/zhlCtH8W8e2/mfB
         BfSZmi9i4B4VPtU8PGv3ld8GmUQwzuTExhie7ITtI9W6B6wZsHANaI0hdQdgH/b1Skcu
         7hvk6E1o4TejZYVhhel0vX4SFy3aUYZkZSaeKA/bt4t3kvkDNnHjoW5XlJxLsFY/b9hL
         a347gGKH+EzdiyVafU8yjlaV50LSMgzHQoM8LX+g3Q+T2usoW29tX1OipisNPNb7D4RF
         1icYUD9+MeUtYV+hQujk43uz7EHXvJPtp6RxEbkPS8Jr1wy744Y+d/+mP9o1VHaUWlAn
         /Q5Q==
X-Gm-Message-State: AOAM531q61Nl75u8brpBhegAv1fkPaa4fIVfhFbLB8hh/l2j/rt1R78t
        g3U7afliYL330I3pzLteJDcs7nHSSshRSe6w2bs=
X-Google-Smtp-Source: ABdhPJzZI9mzT969nZBdbgSiUs27SK4qoSmVm2eNY+n8WnWM0sBaAM/MGnKXrmKYLVJCk/AcP9oCVA==
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr6283604edy.367.1641942098567;
        Tue, 11 Jan 2022 15:01:38 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 17sm3628832ejo.27.2022.01.11.15.01.37
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 15:01:38 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso485635wme.1
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jan 2022 15:01:37 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr4251032wmq.8.1641942097293;
 Tue, 11 Jan 2022 15:01:37 -0800 (PST)
MIME-Version: 1.0
References: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
 <CAHk-=wi6O9cpRxWEnYMXjeMis47456UrVCksV6K_WCgjUmYEXQ@mail.gmail.com> <e645dbdcd74699ff92242c51f743cffe0ea3ae14.camel@linux.ibm.com>
In-Reply-To: <e645dbdcd74699ff92242c51f743cffe0ea3ae14.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 15:01:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFGZp3YFb4xd9UErmnJYhOzOKZVpdyV959e_3=_d8iww@mail.gmail.com>
Message-ID: <CAHk-=wgFGZp3YFb4xd9UErmnJYhOzOKZVpdyV959e_3=_d8iww@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.17
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 2:55 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Yes, I received the Nitrokey Start and followed the maintainer-pgp-
> guide (and Nitrokey) directions at the time.  It was hard finding a
> working gpg server, but I finally found one, at least I thought I found
> one.

You probably _did_ find a working pgp server, but with all the pgp
poisoning, the replication of the keys doesn't tend to work very well
any more.

So if I don't then happen to use the same server, I won't get the key updates.

Oh well. It's not like pgp wasn't always a UI disaster. It's just that
key replication _used_ to work fairly well.

               Linus
