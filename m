Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41831D5538
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEOPzd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgEOPzb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 11:55:31 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B90C061A0C
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2020 08:55:30 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t12so3004912ile.9
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2020 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0xjdNILmqzRS0OoO8pCb/YOr4IsehWnqDX983vBgYIs=;
        b=EoquAB9iPewpta6TuUVi4h7qywZiPfBqcprnPjy3tazAS/3KyinRxhvZ2VAJ4y8qRf
         HNsizPrCb8TSun9rqrs9P1V8q784lgKwGBP3BbKLvWea3OI2SvyWLBH2TqSE8w642O4I
         BxQCLOh7uaSjsXfV69tLjZ/TBEwVHBeWIeNJLmlQjySuF7oMB//6VZnV5hGDijt9ZJ2l
         w9bu1DJLyZI/RrbLVdNRkfhV6cIaP2iZ4E22qKdlF21qGXuiA4ymLw5DX2kw/jxeJe8Y
         /ZrPUMh9yjgvi2s8m6psrbPY3UWMM55l7PmSsMiJ4NxPmrxpBofQLoDtFXx7wv3MnSHX
         o/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0xjdNILmqzRS0OoO8pCb/YOr4IsehWnqDX983vBgYIs=;
        b=ffFkApluOrNDNh7TmS6GMpor5Z6Fpu9dH0N7dGBBiPhTykKQFuwfFz5hx5CRhk1dwC
         N5DmmePNYPSnkJcJp2D8WG+VPUZO9N18PKx0LjRV4s/Vi7En7gxbkoDxLdrJ6sFSRyQG
         U+y3V/B9cxM3/5dNISYEALoXMPtyMEyXQPJa//anf4+6f7YnExT7ukqele/6ilqaVWHs
         Dui2J9SxsBdGjn9Q3O+m/xzoifQbrwEI72ezFWt8pJKaUxkp6b6dWpWGYzNKJvs5s2So
         ZqmJml10iKMNrn9l6HZaqS9au3HdGfieCjzIz1t5jj42qx4i/evt5rca1B3GiDtbPFvs
         2whQ==
X-Gm-Message-State: AOAM53324r94AqGuyLyTF40Nc9+qfJpH38WAEdUcT75cJv0v9t9KVXlh
        ihIBXByYcP/8Fo3cDfu6bvkN4n3kk/cae6GzWco=
X-Google-Smtp-Source: ABdhPJzX0FnU8IF19JNFRdCCKdFOk2cgz1jYAIg8mVAeHMZ1cwUsHuopnrZWPXznT9YlG6TQjmmJqWa7G7lFGt3bbjQ=
X-Received: by 2002:a92:3d03:: with SMTP id k3mr4026916ila.296.1589558129580;
 Fri, 15 May 2020 08:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com> <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
In-Reply-To: <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
From:   =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Date:   Fri, 15 May 2020 17:55:18 +0200
Message-ID: <CANMwUkhXYj03ppRej2j-w1f3--k5pM8sT+jTWEQ+hKZ_7Vo8PA@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le jeu. 14 mai 2020 =C3=A0 13:33, Javier Martinez Canillas
<javierm@redhat.com> a =C3=A9crit :
> I was thinking the same and wrote the following (untested) patch that sho=
uld
> expose the logs from this Final Events Table that is not following the sp=
ec.
> [...]
Thanks, I tried it, and added the missing early_memremap.
But I still got bad values, so I dumped the first 4KB of the table.
It seems to contain events, but they overlap : the last 16 bytes of an
event are overwritten by the following one.
So it seems the UEFI miscalculated the offsets when writing the table,
so gives us data which cannot be used.
