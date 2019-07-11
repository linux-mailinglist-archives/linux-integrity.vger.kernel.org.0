Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED246500B
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGKB71 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Jul 2019 21:59:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37969 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfGKB71 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jul 2019 21:59:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so4061117ljg.5
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jul 2019 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=MQOzZI79mvoiVs1sgBWHfqE+YJM9b7M05jQpHMpAAyRFe0Cs7GZ1SKjYmbrPj6ztHM
         B7Jmo2E1tOKxmtYLHAeJfiv0Yw5iWNpJ6su3Aywbxq++FWe46hRTt1FaTYFdrs51gDai
         Fc+1NUhQh/izklmNT0WE5mkHqoWlVg+hybjs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=JLtA5sor3rvMfKml1Hh/VGuPJVKw+1d4yCgsi3XnFzExBrAFQ+PNwQaIoepBRB7ZPO
         TngGrZieuQuL0qtgZgzPxBdZfIF8hK10mwgR0zJYVDqmBJ6SIBIR8EukfKjrl73l1a2R
         6CvhnbERh7OHiOHP32v3xqYCHGRBLavUBcqR9an5bfc/66QvziWdHkqVbLkPqW8lAJLo
         CADxsKs4zi0QIBNm8un96H1mVsm+DQZz6S3pb5N/oiy+krwrUPtECCYggBwTLRMne3A6
         UKtHN6gmYoD5RcziiX8eyqaigjs2TIgYEA5RnbyH9RmMqZCjXPOVeFCCGVIp21RvYTiW
         FRhA==
X-Gm-Message-State: APjAAAUUxcoe4ixtOyo/xdY6YKDWKNDalv+Nm4gwYJ2mhLcNmMyqRFnQ
        LyZQw/zQH6VqMT4U1Tvg3B0kUnAVdoc=
X-Google-Smtp-Source: APXvYqxM4f0SBg685LL4uiUbLM/gEuTQSdzm/7IXpWGhTzG6VSMI1/yOfKgZ1lNSOOy9pY2kdpyxWw==
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr757348ljj.129.1562810363624;
        Wed, 10 Jul 2019 18:59:23 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p87sm729550ljp.50.2019.07.10.18.59.21
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 18:59:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c19so2909235lfm.10
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr355474lft.79.1562810361547;
 Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <28477.1562362239@warthog.procyon.org.uk> <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
 <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com>
In-Reply-To: <20190710201552.GB83443@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 18:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 10, 2019 at 1:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Also worth noting that the key ACL patches were only in linux-next for 9 days
> before the pull request was sent.

Yes. I was not entirely happy with the whole key subsystem situation.
See my concerns in

  https://lore.kernel.org/lkml/CAHk-=wjEowdfG7v_4ttu3xhf9gqopj1+q1nGG86+mGfGDTEBBg@mail.gmail.com/

for more. That was before I realized it was buggy.

So it really would be good to have more people involved, and more
structure to the keys development (and, I suspect, much else under
security/)

Anyway, since it does seem like David is offline, I've just reverted
this from my tree, and will be continuing my normal merge window pull
requests (the other issues I have seen have fixes in their respective
trees).

                 Linus
