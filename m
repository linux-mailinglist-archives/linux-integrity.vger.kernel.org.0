Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED737321A
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhEDV6K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhEDV6I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 17:58:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4DC061574
        for <linux-integrity@vger.kernel.org>; Tue,  4 May 2021 14:57:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i81so304001oif.6
        for <linux-integrity@vger.kernel.org>; Tue, 04 May 2021 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6nDWrO9L8CxbAXjtDgqv4B1xC4L9HAr7ltSEuwJLk8=;
        b=lp8Ds+q4uHoTq/2xNdc6nB8zMv9+EVRduoGZhmPcTiX40X3BRyVq20/wmbznOaJKXk
         48InIae6D+ySRAWfUzgcwxVE0xLGPx4ZpJGtdte6bTc/hYHkp3FD8UDSB6B4obl0gPal
         6Anx4jvxkyiRcU36eEj3cO21HPg5+rRJm7jyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6nDWrO9L8CxbAXjtDgqv4B1xC4L9HAr7ltSEuwJLk8=;
        b=svJCrRCltsF4iZeHRQ/2LLRWsremlBF2AxLjTKe2UGrsjWCIvZ11JqNTvpkzp1cNde
         TNPrX9LPOiiuWBf+QZLkE9072fLoOfVlvjRDMpQgBkUoT7nzKfd52MWyvxCClbJreX5Q
         bme1NNzgbpR4wHt4qQU2vkYabbgLzTv9HA039Hp6OxlP5Vy+NbPoIaE1IuMXJI39eQ1p
         WW72hdVNewNrzoIs9P5/H57sk36r+FSC/bJeXXdYxb9lWjEE1O6zRNeaWn7qJXx6v2DG
         mGpIdRKY8FraxNYcqmaRd735DCiZs/LrTvaZeD9koLpOFX1MPa97XoA5K0oWf72hDo39
         GI4g==
X-Gm-Message-State: AOAM5331Q9cZoTVWh7x9tERctwetiRXIxl6yJgQBYHiiVTSRSL2IiUCF
        kGip61XE3z7+UxUQ/NUyrnqGoLyie5E14uFv
X-Google-Smtp-Source: ABdhPJxjTEuEZ5mv+BE61rtfvEtE59iJGF6eq3LRTIb9+CEumkQVKLs4Di5Wr3nfRKnFVWMeNAn7Ew==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr9446217oie.7.1620165432687;
        Tue, 04 May 2021 14:57:12 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id q1sm1129677otc.21.2021.05.04.14.57.11
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:57:12 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso2921761otg.9
        for <linux-integrity@vger.kernel.org>; Tue, 04 May 2021 14:57:11 -0700 (PDT)
X-Received: by 2002:a05:6830:a:: with SMTP id c10mr21052802otp.21.1620165431621;
 Tue, 04 May 2021 14:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 May 2021 14:56:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Message-ID: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable hibernation when Lockdown is enabled
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jarkko@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Does anyone know if this series is abandoned, or is Matthew planning
to do another spin? Email to matthewgarrett@google.com bounces.

-Evan
