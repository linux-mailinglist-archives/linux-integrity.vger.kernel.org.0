Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA1AE435
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfIJHFH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 03:05:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39982 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfIJHFG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 03:05:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id w18so646011lfk.7;
        Tue, 10 Sep 2019 00:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DozwmUHwj3k2SEoSTTzpSe/D0hTydvpHRMjDyd8vPuA=;
        b=lAi7DV+BNuqvg25v5XsQCJO5S8QiXZvZkSuoSs2U68BKHCzQM0o9qMWIdQqkSXCk3g
         dEh04utjhe4CEOk9udh1fJlL/L395nobKw6BYunahGbX5dUKH9U6alypvLCdFo7gJ2wM
         g9akrlRq4pGN8otw8b2NbJa1n6JVNnMdPG2JnqGhdS2nMR6an/B/ZjzEqMNk09hneAQ/
         PXhj3enJtyWalEuVEq/GQQgOetj6SfQBY+LUKP6oxeubFlSeFZpxBDxogBodwgRauln8
         y/TruqX2F/KIe1S6gxjsQ8HSOJ6Sqa8PP1hcZmoLvM2iBHXfS6+xaOs/IFIeCk2zq68p
         jxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DozwmUHwj3k2SEoSTTzpSe/D0hTydvpHRMjDyd8vPuA=;
        b=ZBpVOIXocGyKFAR65epjIP1sC0f/0rHaoVSn346rWn64Xbv2glyRQoL6qIgZ8G8X7I
         W6gok/Tzvwi8BDMwBMcULLwbA4Jpyex8A1PQuU8Eawq0FfdFgXGBwsv1L+TQmvebaQwR
         c9GJ+Qj0dFC/8pZ1nqwiFJ1kXpHkeOJyvAU2HnqqG5HU8RMWtlRfxcb7OGUDPpQVmm0m
         d4OHeJeTSneNpxK+niRptVlgdh3CaqULtam1pT9tpr9BrFWfRR1aXAn7ybmZ0rGMhTob
         Viev/RBbmZ7V3shvue2YpGFsTYVFzbJ+PoIUCs5HIiL6P7ahZwZzXZoTD5r1z9aCfnee
         mByA==
X-Gm-Message-State: APjAAAV3R9Qt8xt2zYNVsWNJ7G55uqjioCxjLGjsxqm+ekaof3HjThWW
        mIJ0bqDoDgDZBN7sUFrFRHR4qIeJbiwCp9ctKV0=
X-Google-Smtp-Source: APXvYqyca1SH9H5DaRx8OiIKHA6rL3hTD1AqM+2vgGminaPlWP06PPODcpw0VTaopULzgbXjfkmUz2/0N+cTcywUsIc=
X-Received: by 2002:a19:ac0c:: with SMTP id g12mr19380686lfc.128.1568099104597;
 Tue, 10 Sep 2019 00:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190902094540.12786-1-janne.karhunen@gmail.com> <20190909213938.GA105935@gmail.com>
In-Reply-To: <20190909213938.GA105935@gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 10 Sep 2019 10:04:53 +0300
Message-ID: <CAE=NcraXOhGcPHh3cPxfaNjFXtPyDdSFa9hSrUSPfpFUmsxyMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: keep the integrity state of open files up to date
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 10, 2019 at 12:39 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > Core file operations (open, close, sync, msync, truncate) are
> > now allowed to update the measurement immediately. In order
> > to maintain sufficient write performance for writes, add a
> > latency tunable delayed work workqueue for computing the
> > measurements.
>
> This still doesn't make it crash-safe.  So why is it okay?

If Android is the load, this makes it crash safe 99% of the time and
that is considerably better than 0% of the time.

That said, we have now a patch draft forming up that pushes the update
to the ext4 journal. With this patch on top we should reach the
magical 100% given data=journal mount. One step at a time.


--
Janne
