Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B585BA7
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 09:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfHHHem (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 03:34:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54175 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHHel (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 03:34:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so1332520wmp.3
        for <linux-integrity@vger.kernel.org>; Thu, 08 Aug 2019 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZztMG/WId919jTnSWPqaQ8ngVSTTsg3rnCihyAUBLYU=;
        b=WAECOLkuMEfFxjEgAS5aX8oEuBbe48s/RTMiAhVUwtDpqAo1G3eTD+2PH9Cpxgnlsq
         qG3htzG9oql+xOstQRPZWloPAR1Mn68yvpgWbfgqQc0s3YYPop0JXM3nqIBgRs9rSpRS
         EceAsn+y/9V7CN8PHMu1MCEWUerTqoLbg6DazSNK1/pu7LJw/OWCXyoCgx14ded9RbI+
         r0r1ML4L0kkZgqRa+/nVk/A1Pmu5EfvLFvYyJY3qoXZKqdj0ARnDPmlx8SQbtoIzA5Ke
         a/du7Yc18ou/Cf3Mq5uoWj07v3x9Myd8crOYIAWz+R3MKVRQhdyZFRPTXuZNGg3RiIi9
         BvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZztMG/WId919jTnSWPqaQ8ngVSTTsg3rnCihyAUBLYU=;
        b=p7orUDdHKY6DxlxwalE9quiTzQsXxzcUUxzkaJ1QM26v/qXAZstQe8Jll9g1OpQkWj
         kaKrFNL4Zs1nFpyfeSwlSPzyXtz5PukzNjPaD4RPPYiZzquJpUWybUyRBZKBDIl760Mo
         W2QdwCB9Oh8hH6vA79BhME6sX+IaUNzyUVpRTD9/Dw8p1l4k4WVd2+wg1hFdrd4JhJbo
         swQISwGMIGVfaxPGCbFnuqHQrc+ZRXqyU/wzjMTwdQ3N6Op1GJIjqkEngWhzI9g4i+Ve
         3BrDAKBfDtctX25VTzIy+zifG9jg87UfnZP1JcuuSVF95q/yH7zZ9qfeQ6BFvBdeQhhP
         XkUQ==
X-Gm-Message-State: APjAAAVGxMG9HeFhIE3Z1vuk4hBdq75wfYdSA2/nD53orH5v8GXUB7vU
        cGjI0WQwB9z77Rd45p2yteAonHvscAZkJyNfIKbF7g==
X-Google-Smtp-Source: APXvYqzeFUvts7/3WbfdjAqqfoqhyv1GU8TT929yDSLQeSOKiitCyuGWbC/q1hDjEvj4GjWhfhmruBny/4Radz51eeE=
X-Received: by 2002:a1c:f511:: with SMTP id t17mr2606801wmh.53.1565249679957;
 Thu, 08 Aug 2019 00:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190807215903.24990-1-hdegoede@redhat.com> <CACdnJutiu0kUreyECpNok=D1hPqCW-JDw1aEzMU9cMuTSiMTxw@mail.gmail.com>
In-Reply-To: <CACdnJutiu0kUreyECpNok=D1hPqCW-JDw1aEzMU9cMuTSiMTxw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 8 Aug 2019 10:34:29 +0300
Message-ID: <CAKv+Gu94yQea2kTohvACj107ia=RUGkk94Zj2Es4198GK=wK=Q@mail.gmail.com>
Subject: Re: [PATCH 5.3 regression fix] efi-stub: Fix get_efi_config_table on
 mixed-mode setups
To:     Matthew Garrett <mjg59@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 8 Aug 2019 at 02:03, Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Aug 7, 2019 at 2:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Fix get_efi_config_table using the wrong structs when booting a
> > 64 bit kernel on 32 bit firmware.
> >
> > Cc: Matthew Garrett <mjg59@google.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Fixes: 82d736ac56d7 ("Abstract out support for locating an EFI config table")
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-By: Matthew Garrett <mjg59@google.com>
>

Thanks for fixing this, Hans.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> Good catch. I think fixing this is preferable to reverting - the
> duplicate events are visible to userland, so there's a risk that apps
> will end up depending on them if there's a release that behaves that
> way.

Agreed, I will send this out as a fix.

> Presumably mixed mode isn't a thing on ARM?

Nope. I should have realised this when we made this routine generic,
but I failed to spot it. ARM is either strictly 32-bit or strictly
64-bit.
