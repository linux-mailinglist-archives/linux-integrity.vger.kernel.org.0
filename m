Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6012EB3B22
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 15:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfIPNRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 09:17:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41861 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfIPNRL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 09:17:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so1713191ljg.8
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aA+U7AmDCNWjq14jh2S68p2S74Unu27IayYKPois77U=;
        b=BC46gSZGC9YgbcyDwaeVukrsEkzRi9jVLF90m5TEoDfDfsW21Lvv95CH5EoKuOzG8S
         /wls581J4kPgw/3SUJaFftbmNoR7rrbmfiG55/EUwWkOx9FC7x4rL8e/iQtGIPDlihly
         pvqxbi54OfSeAuHAG8FJglBKUnF0QdahseXVvCFKWaPlHNbcja23koL2Z4jFY3FmtdHc
         m8P0h0cFsmjbNB14DPitPeJEpAIlRLw93w6cfneTL6sU4BZJYwqP5Xp5pt+l5Sn2P6CU
         BHiKQQKfqmdZSDDWrQIxCB2t9TE7BBRaqhg3kmbA4w8sbdv59WCOg0DZ2PxwC8ke4VgY
         dezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aA+U7AmDCNWjq14jh2S68p2S74Unu27IayYKPois77U=;
        b=EqQnVy3J9dBBoIdw4kt67VlvblHZZ+YrcCiYEDw7ORcla+joBdn/rrv6fYD8ejplaF
         op8QW/fKr060GyK3xxZbStJZ/Qc9xZtLX3yJy5DnWL2Xje3ZIzOs9uUK2oABe4CQ+oUJ
         ST0F7ZluZEUFhuFmRsUDOTYFm2vXr/8jxIertXu9eTDgwbM3NmzTMdOId/Tp+OfSylG5
         oJqLe/hR7kjozyiNvH/R/W07ACmc4ECM0jUNPTOMZwlJGCXg+oZecjsHGLeOrqWBxk1s
         QCIwXSuI9MrvLLxQJyMZroxTY4g0DJOk4NnR3zZ4T3qyBLOepfjy+BV6nNj8TEe03d0S
         RP4w==
X-Gm-Message-State: APjAAAVjnt527COzrkR30qnGF5WdF0Kms+bYMAAGf9Nf+yBmNAA7Tp37
        DvLqDQUVwSgwWghQeibj6V2wa31mtXQWvJV5VgkWlQ==
X-Google-Smtp-Source: APXvYqxoJ3Q6AMJzTvvzLQwNEDnXhEEvnpgR/ZKP/uugJ9uruSAELuNoVit0XgZ3AY7waHynnevVwN4KsAqxQKJs+Vg=
X-Received: by 2002:a2e:884c:: with SMTP id z12mr29597119ljj.92.1568639828352;
 Mon, 16 Sep 2019 06:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
In-Reply-To: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 16 Sep 2019 16:16:57 +0300
Message-ID: <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
Subject: Re: IMA on remote file systems
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 28, 2019 at 8:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:

> My thought was to use an ephemeral Merkle tree for NFS (and
> possibly other remote filesystems, like FUSE, until these
> filesystems support durable per-file Merkle trees). A tree would
> be constructed when the client measures a file, but it would not
> saved to the filesystem. Instead of a hash of the file's contents,
> the tree's root signature is stored as the IMA metadata.

So the attack you are trying to guard against is that the pages that
were evicted once and that are read back could still be integrity
verified?

Handling this properly would be awesome. I don't think we have
anything against this now, the pages that were once evicted are really
not checked when read back.


--
Janne
