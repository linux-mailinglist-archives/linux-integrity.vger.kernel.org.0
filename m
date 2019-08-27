Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECDA9EFCA
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfH0QK6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 12:10:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33303 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfH0QK5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 12:10:57 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so47657894iog.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2019 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAZSFhrkNg8EdOkX7+bIojO3qOZTJEurdw0nzGyP6oc=;
        b=c7Qmh9V0mJfsmJ0EtwOBmGCFdov/0upZx5p7QsvvjmGhxRJqV+e8Z3ZHDER41CuEts
         K9cPQ1cOAheQbiqZ2SmTXQ1ZGiBiSjya9NaJFFWjm/BXZM++XyBrYhgHB5v1k5v2rd8e
         EAgsk1PetLvEQljYTJ1wKgeWp/Rr+wCQvCS20bG9aYWDplPJq+R6g3sqy/l0AmyBoSso
         f5VcH+pNgnuxyy9+HJXmprUUDNDHbFzyQ3WeemOF5F5fYMTMwHeB/sbcNgkq6WDiCtf+
         yWdYD1L2ttJF8xjf2NNWIWCP/dzG/kIBLeUXWrR/aCXcTjQDkKfJ1eSIKLOvamky62TS
         rvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAZSFhrkNg8EdOkX7+bIojO3qOZTJEurdw0nzGyP6oc=;
        b=pnTUYIsCeDU9bea9qbolZzersuMZim7ArcMrXvaVCaAYYKtVbF3NexjR5InWMp3ULi
         J019me+HtWkAEkhdyi8XXtBhwxBm2eCEloe9yc16fHZkvS7j9PIcLwKjoNW1oFOEUVGD
         TcLcYlv957kAWgwZKqDpGhFbq6llXV6Bo2mRBkLiHIYJ6RxTdQkDRG1cpvWyev80tYS1
         3h8Khm4nNdeWhCM3t3yOwWE8JU3diQy+ts1PWr32oCvm1Ur2U3KF6W+Pd2BITDDb6PV/
         dY5YpBoxTh7OioCkWAe8A3rgFLaX8PjLuav6NwEoxqCwBIx7fzZNzV/7LS9hE9PDe0+o
         uGPQ==
X-Gm-Message-State: APjAAAX8oja43h8/D1s/tUrOsufpHyVILDQPiMO9pfC0tIXEohgg6Zic
        TXULn0ZvQ4tcgLPw92DAo8xV1Q7GekaPB0ypp630og==
X-Google-Smtp-Source: APXvYqwQmXQ63LGIFbQMm/5m/D+YgrCWN32dRNivv1cpTg5pdioaBPmvKsRxmwCw4WeZ2O8Zi4kZOW+1RuNO/TuK42M=
X-Received: by 2002:a02:cc8f:: with SMTP id s15mr23773601jap.53.1566922256653;
 Tue, 27 Aug 2019 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
In-Reply-To: <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 27 Aug 2019 09:10:45 -0700
Message-ID: <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 27, 2019 at 1:23 AM Seunghun Han <kkamagui@gmail.com> wrote:
> If the regions allocated in the NVS region need to be handled by a
> driver, the callback mechanism is good for it. However, this case
> doesn't need it because the regions allocated in NVS are just I/O
> regions.
>
> In my opinion, if the driver wants to handle the region in the NVS
> while suspending or hibernating, it has to use register_pm_notifier()
> function and handle the event. We already had the mechanism that could
> ensure that the cases you worried about would be handled, so it seems
> to me that removing the busy bit from the NVS region is fine.

No. The NVS regions are regions that need to be saved and restored
over hibernation, but which aren't otherwise handled by a driver -
that's why the NVS code exists. If drivers are allowed to bind to NVS
regions without explicit handling, they risk conflicting with that.
