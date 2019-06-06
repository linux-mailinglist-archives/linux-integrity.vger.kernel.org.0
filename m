Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A237B0C
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfFFR2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 13:28:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45084 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfFFR2e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 13:28:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so2791196lje.12
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jun 2019 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=GXSY8IkFrWa7J8B6PJEPqJ0gkrWF9aF2wuVJ0wQ40ziAUSXofomBUgMg2tSIClx+89
         +trdK2/MhDj4EjpP2yv3Xn8pX3rA48qk6bQhrjbIVV9fY3W5uHsxoW6S3hiV1u6bue1h
         +WQ8hOkagCs/4IfWuZtcPZAZi6BK/PN2CpG1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSh9JeAYZqEFU07GFlcm4g2RwNfVCw5VkJKLPgvFgpM=;
        b=DuwKWESa2tf2mUZECM6rfT7jiIiLvXeSU2VqOagtPao/MC3uxVzFPItW4TaK1H3/6I
         gMTgX3aO/2cs28K+I4bW4u/JI6VHfOWWT0/Q3J5kwPczBz88KmdErhButYYCcMeqzWdn
         Tchw+6KV1USSjxPjk63utspqulXoAvSmo1itMhMMWn1K+UGGt4q7XbOzmzbZzZq871zn
         QDfe5Z4hQIsTraw3CMUvPLgi7SNsPuRgnAZ0jkK6Ko497J/zhvjmJzj1/fnb2urW5nI5
         TlyPtucjO+o1jrDye3KNpFsD86V1F+vjykDBCDfHDxCM24IApyGJ/iTHoZRNG1C9YEtq
         Y5kA==
X-Gm-Message-State: APjAAAXL8IL0DfwCbQ7a8WZWD2bBNvFNSYG/7CuO+bCUADjgYKqbZI6p
        KIfKSyhytzc8/zKst9cLEnEpdAA394w=
X-Google-Smtp-Source: APXvYqxLTgHJa41msH896VBOtaMOeh8MbBndjYtFoOqo3D2rtjxienowDh4u4nw0D+VNGazAAHy6NQ==
X-Received: by 2002:a2e:3912:: with SMTP id g18mr16995222lja.38.1559842111963;
        Thu, 06 Jun 2019 10:28:31 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f30sm386363lfa.48.2019.06.06.10.28.31
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:28:31 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v29so2829753ljv.0
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jun 2019 10:28:31 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr26100221ljj.147.1559841687851;
 Thu, 06 Jun 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190606155205.2872-1-ebiggers@kernel.org>
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jun 2019 10:21:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Message-ID: <CAHk-=wgSzRzoro8ATO5xb6OFxN1A0fjUCQSAHfGuEPbEu+zWvA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] fs-verity: read-only file-based authenticity protection
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 6, 2019 at 8:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This is a redesigned version of the fs-verity patchset, implementing
> Ted's suggestion to build the Merkle tree in the kernel
> (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).
> This greatly simplifies the UAPI, since the verity metadata no longer
> needs to be transferred to the kernel.

Interfaces look sane to me. My only real concern is whether it would
make sense to make the FS_IOC_ENABLE_VERITY ioctl be something that
could be done incrementally, since the way it is done now it looks
like any random user could create a big file and then do the
FS_IOC_ENABLE_VERITY to make the kernel do a _very_ expensive
operation.

Yes, I see the

+               if (fatal_signal_pending(current))
+                       return -EINTR;
+               cond_resched();

in there, so it's not like it's some entirely unkillable thing, and
maybe we don't care as a result. But maybe the ioctl interface could
be fundamentally restartable?

If that was already considered and people just went "too complex", never mind.

               Linus
