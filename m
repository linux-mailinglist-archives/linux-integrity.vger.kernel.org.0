Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950BF48B947
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 22:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiAKVVg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 16:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiAKVVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 16:21:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7A1C061748
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jan 2022 13:21:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so1409644edd.12
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jan 2022 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdOfm3oPlGh19dzqAJYBO4S3+yHXYpy159zfhu1tu/M=;
        b=iEuN7OSrSlPXO1/T3FWIH+dXgc1QOB1q/rtwqkL7v/zMKfsCXInPxxj/UtDiw5n5gK
         lHAmbC7gHkjIWV1c9Fo50BRtGzMCXA9WZ05VUd0ZP347IWsav8ynEkkm6HxKRt5qv94G
         OT/74Z5Zay8FL4wb8BnuNbthorXNDX/1sAMyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdOfm3oPlGh19dzqAJYBO4S3+yHXYpy159zfhu1tu/M=;
        b=PAH6XuZHTTtiHnEuoOjaxqRXVaNIFz9Ilvakp1bRZ1mGQ6w2sGX/8EBd9VE6orGpdy
         Pc7NPqH2AwGU2iuPJtmv4xYY6vkm6C7O0tpqpX2KzW2eMF4O+xUv4pzrhnBhb8WEeHBt
         k6rOWJ/nw+P9Q/ImvjM7xUV+66WWOVicL8YPFrpe7jFN909uPMVLSDfsIO0Bxn5bBpMA
         pePpp8QzPW2LM5p+OpKOd5VEZy8ORa236rLsXU2lbm4BgBAgY2SpdgRnNdePjT/c4vfR
         vCwRPpq+KrbWBUZc86MMjb9TTxevLPE9KrlA/3HhDHSnobqUHkhz97Rb/ZTcGaU3LcB1
         lCwA==
X-Gm-Message-State: AOAM531EAcF44Uhi266slQOWzBb7ETSOPEkzXqWh4+VRm46Ld606HN6q
        vbVYENA/7um2pWLtmGQzmGWSCeHrAzIiZAejfbM=
X-Google-Smtp-Source: ABdhPJx316sHxakVb4rvkKrJ/ycSnDSbkCW7MWwQ9bUvp1YsPARyfi4T7tKwaHWjMz5PBeKgW2Hppw==
X-Received: by 2002:a17:907:3d88:: with SMTP id he8mr5374306ejc.239.1641936093906;
        Tue, 11 Jan 2022 13:21:33 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id u11sm4705540edt.97.2022.01.11.13.21.33
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 13:21:33 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so354331wmf.3
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jan 2022 13:21:33 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr4045381wmp.26.1641936093050;
 Tue, 11 Jan 2022 13:21:33 -0800 (PST)
MIME-Version: 1.0
References: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
In-Reply-To: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 13:21:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6O9cpRxWEnYMXjeMis47456UrVCksV6K_WCgjUmYEXQ@mail.gmail.com>
Message-ID: <CAHk-=wi6O9cpRxWEnYMXjeMis47456UrVCksV6K_WCgjUmYEXQ@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.17
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 10, 2022 at 2:02 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17

Side note: I can't find the key you're using for the tag signing anywhere.

This isn't new, and I've seen this key before, and I suspect it's just
another new key update that the complete breakdown of all the pgp
keyservers makes hard to get out.

You used to use RSA key 8D2302082EFE723A379ECCD26B792466B03E715A,
which I have, the last few pulls you've been using EDDSA key
1D5D554518DE57A8AAF51E3ECBC19CD1B02AE7E5 that I can't actually find.

It also isn't in the kernel.org pgpkeys repo.

You could try submitting it there:

  https://korg.docs.kernel.org/pgpkeys.html#submitting-keys-to-the-keyring

Oh, how I hate pgp. I thought that having git wrap all the key
verification would make it usable (counter-example: the incredible
garbage that is pgp signed email), but then the keyservers stopped
working, and so the keys themselves end up being a problem.

              Linus
