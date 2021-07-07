Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64D53BEBB6
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhGGQBI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhGGQBH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 12:01:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84FC061574
        for <linux-integrity@vger.kernel.org>; Wed,  7 Jul 2021 08:58:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t3so4002110edt.12
        for <linux-integrity@vger.kernel.org>; Wed, 07 Jul 2021 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=YnxQJdOpmnt3qPbZaEDpOYhd2SkaH/r7ZwyDDdxcl0hFBhbg0MeWuLSWZFZKHNysGv
         xOfd7gAkE6HFx+ZKKD7RPR3UXuLhGnQIBFHDhS3PcByY+BoKYy94qI9nkNhc/HGi0pR7
         f1usEjq9bIHvHSW09yOyzKdcqjKIuzPFqYONOQwQl9dekmcvwm0gWstUdWU0eCe3cxu/
         850+0n5W5qsuMeFxXLHRNEbvr6YM+EV0Cf1kuBuxHxU0VDjBgrZWkL3Z6d1vErKUkuBJ
         IYfpekWzudbricIlWrilsjRiO20LMt04XTZk/ltBIFPErdAqa/fRIpNVkqYvpqGnl6ER
         vdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=RpgabxJPhfAIO/NOeCXwL875mkSowcMv59ztX2R//mQVv/cNmOs1dRtSCBoxVpkTHc
         WdCcYhM62igZvdvAirFWuwNntl59eLjJeKC0+/0yQjJRXTMkEImol/4817e1b5OAC12C
         T0NkJNaUwVluk+gEkUMxiKbNGJInYhyRXjQAdtK6G09DRZdnz820Pmr29PsUDCYX1+Il
         U3H/1DM+C2UT26t5IbYp+hei9ukUkyDPtz1vJjJf4Jj3/uYKlA7P+nUsHLFZVyShCgdM
         G414nGl/4vDSwYLwbN7l7/20xI+hX74nJg3RaJMT/oGAqBzylh6BFLGrj7fQZHXYP6pS
         RK4w==
X-Gm-Message-State: AOAM532+QkD8lZCQgN8Z9goaHIDx56DO5fEa6ZMC9q9cMMngnATK9R0z
        UMcv2vUH7VCRN5hjWzab9pCGawLYd9LIj02mUGw=
X-Google-Smtp-Source: ABdhPJwGEtK5+t5Wa5e/qyzgyVdeqbn5rG2l3N34TCH9/8Kz4+KOTLRUFk/qYWcNDdWwvQxpSsXmP939vjHBj42UUIE=
X-Received: by 2002:a05:6402:3082:: with SMTP id de2mr29205991edb.9.1625673506128;
 Wed, 07 Jul 2021 08:58:26 -0700 (PDT)
MIME-Version: 1.0
Sender: thiernodione63@gmail.com
Received: by 2002:ab4:a269:0:0:0:0:0 with HTTP; Wed, 7 Jul 2021 08:58:25 -0700 (PDT)
In-Reply-To: <CAP9xYRcJvaL8Qe2hz-9qnb8ujRZFAN+GhxQFRqO2tAiBnjyNdg@mail.gmail.com>
References: <CAP9xYRcJvaL8Qe2hz-9qnb8ujRZFAN+GhxQFRqO2tAiBnjyNdg@mail.gmail.com>
From:   zahra omar <hassanomarzahra@gmail.com>
Date:   Wed, 7 Jul 2021 16:58:25 +0100
X-Google-Sender-Auth: hfm_qg-mCUYeG8_Hdpz_9QVgYlM
Message-ID: <CAP9xYReH6a_cBY-Jp2dfCsvnwknQU-3ZWLmWzkPhbwNLLii2Jw@mail.gmail.com>
Subject: Re: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


