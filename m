Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED87C14FB09
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Feb 2020 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBBATP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Feb 2020 19:19:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42452 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgBBATP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Feb 2020 19:19:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so10909750ljl.9
        for <linux-integrity@vger.kernel.org>; Sat, 01 Feb 2020 16:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=vb60b9fB1hi2breaQKh2O/9Swlzf9GYb2tT75kQEfaw=;
        b=XMxTWIy/k0UW5CwCevAleDrqFno+ELgfTgVOnRGaYqgSrrwok0fH46IepYIb31gRM3
         T7opIICxXYg73oXIiEq2w02Y1FifRlXqDNQrOzDOoZPs77862ge9RyUYK7wMP3Dje+hj
         yKm0iORmMAIBnTs7kcg9u9Vyb3+LYu4o9HUPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vb60b9fB1hi2breaQKh2O/9Swlzf9GYb2tT75kQEfaw=;
        b=NwmptAWDS4WNM59O0GQB/fh2Dp4zT14+NQPhYh4gy/YcQaUkwqiQT2ICM67PZMePMZ
         Ev7lSsG6oaK/oS4KR00iVxh3FTsGXQOc1WKnd5j1wn0y2YdhDlwJp34Tojo2Nv0p58xh
         UJYOIJoGfT9w61+BaXfxoNWafxxS/8yN0BdaPOsvW+1tB0U2fqCCP6efCl8KWDOVyAAJ
         ihaFKd8e07dHWIVv3bR4NxVnz36dTptbzDXAcyCEsU11rIECEgXpxDqA6YHNnlQljpts
         fY5vVI9dU2Btx/Y7KsY33EfDDciXkbgZclQzeyHhvAw8oNvkDtQE5YGDniitgFqEm3M0
         1f4Q==
X-Gm-Message-State: APjAAAXWnDuvv43EXbXbHStcgeyHRbmnS7Ydsr3khVgnH71kuqqjC1C5
        ovyd4YTllAJ1q5E/CDQ86+NzHzara7LnCb4LOrnPpaO7KFPpBQ==
X-Google-Smtp-Source: APXvYqyQCWMs/pZyt7sO00Vg+ucrqJkdslFH2CDzv26m15lk6F4ZtUdncjyG3O/ZvykegCrGMtIF2JWbjzpNGorJKDE=
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr9562407ljj.148.1580602751580;
 Sat, 01 Feb 2020 16:19:11 -0800 (PST)
MIME-Version: 1.0
From:   Alex Guzman <alex@guzman.io>
Date:   Sat, 1 Feb 2020 16:19:01 -0800
Message-ID: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
Subject: Debugging errors with Dell XPS 9560 TPM
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hey there! I reported a bug on the bug tracker a bit ago but haven't
seen any movement, so I figured I'd drop in here. My XPS 9560 has been
having issues with its TPM, and all commands will fail with error 1
when operating on the TPM device. I managed to bisect it back to
commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e (tpm: fix invalid
locking in NONBLOCKING mode) though it began failing with error 14
(bad address) at that point.

I reported the bug at
https://bugzilla.kernel.org/show_bug.cgi?id=206275 and attached some
dmesg logs from boot there. Does anyone have any suggestions for
additional debugging or such to figure out what's happening here?

- Alex
