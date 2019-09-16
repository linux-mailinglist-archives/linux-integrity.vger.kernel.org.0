Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD407B41FF
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 22:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfIPUij (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 16:38:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43796 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733115AbfIPUij (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 16:38:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so1002620lfl.10
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me/tNrvpc38oLBmNgQpuGD2wwLksgIc0n84g04Pq6UM=;
        b=hFnsr4SQxJjjqereCuTP+xGrGqVFwwB7+2ShWDl5Qp8pLxb4+MV1NinHIOPm4UaO/I
         66LHrIpJRtRLDqw3UxiqboGbOYFJm3hraDsxkxsG2zVzCjIxcW00JkhtL3B0fbXwayOw
         0lnLYFaWHXA2YaW+8dkcHiVuHzVd/UG+TSCPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me/tNrvpc38oLBmNgQpuGD2wwLksgIc0n84g04Pq6UM=;
        b=goI1UlA4k8499t10I25yAUz05dBXqYehPksBxnzkzuBIW00nHo4wMHm73E4yNVvOn4
         I9EpFjWWGOKs2u1uQQEMkX5aH7MlDK6MMvglLBnrzYLrKdL80R7vStOprs0ZyCIF7Jlh
         cl2hjrZz7kWE+8krh6PTyhSB9bVBGNK63Rv1yRqQxrmEta8dj8c6fjTRFZ2JDlLhD9qK
         0rHQI5zAobzi4Rl3aAug+KHx6k4I6nQpSlWJ2Wbp6PIJ+2Nu9Uw7btQbohhPUNOur4S5
         Se7hIsctRqGj0niv0qlGNV3wLq5dBYoo3G3pflVkmuw4pVx3V/XtxK4KBbu2laiSXDpz
         1QCA==
X-Gm-Message-State: APjAAAUL0VaQIYDDv+x/oJHIdBbDPtDF3ar4EOsg8xC7lM7pgVjjUkZo
        0imcHRl/tVPj8ZdSKpvGr/bqnfz0TPU=
X-Google-Smtp-Source: APXvYqyeDkHyalfPtxpK2dTr7Ud2oO7znZRXVVnTT3TB8YaNcU1hXYshdlR4BbA+il7XiAYPinKhNg==
X-Received: by 2002:a19:7413:: with SMTP id v19mr45964lfe.176.1568666317367;
        Mon, 16 Sep 2019 13:38:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c4sm9116130lfm.4.2019.09.16.13.38.36
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m7so570638lji.2
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr801701lje.90.1568666316121;
 Mon, 16 Sep 2019 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <1568237365.5783.39.camel@linux.ibm.com>
In-Reply-To: <1568237365.5783.39.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 13:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Message-ID: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 11, 2019 at 2:29 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> The major feature in this pull request is IMA support for measuring
> and appraising appended file signatures.  In addition are a couple of
> bug fixes and code cleanup to use struct_size().

How is the file signature any different from (and/or better than) the
fs-verity support?

The fs-verity support got fairly extensively discussed, and is
apparently going to actually be widely used by Android, and it an
independent feature of any security model.

What does the IMA version bring to the table?

             Linus
