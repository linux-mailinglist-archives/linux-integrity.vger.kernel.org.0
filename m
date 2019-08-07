Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7285644
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 01:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfHGXDQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Aug 2019 19:03:16 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42076 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfHGXDQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Aug 2019 19:03:16 -0400
Received: by mail-ua1-f67.google.com with SMTP id a97so35632969uaa.9
        for <linux-integrity@vger.kernel.org>; Wed, 07 Aug 2019 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3wiUZTjk/4U/E4pi4Y2n0i/U7m5LkR3wRuzR1Bth2Y=;
        b=c+/0SXYFPNw46NRsWE6P91sFVLXR191WhfFGez4Z3L6n/kCMfju/P3OvTcDT7nRng3
         0DuVP6bypyJOpVZ3IQ958+wa5TcdHu5wj3SXO68gguTLGCfdkE0N6fNDDCH/C0C/icTu
         zMDbE1BFA0vpE0vWfBFgXLw8BErTXhA0SqRtCFfj57LGnKIkmn+s28lYbL3tKpB1m/bc
         Fh4mZMRGRnoyPRvGpfK7PTLyHYUab/HWZS3QPrtEDHb03rSBrsm0OAiqd5hIbEvE5n3V
         qIwGH13ycXp5Mu2bO8eNOtQ8CdnqT8j0Ypz3UyKmcb66GGUmdvsdjg1umBh/5bge05XR
         O+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3wiUZTjk/4U/E4pi4Y2n0i/U7m5LkR3wRuzR1Bth2Y=;
        b=U86SYIbxEEONDAojzyFxolOaELH/9X2Uc8eFaOCzO+7iSmdqrJUGTPm+EWqYMvKba+
         OdIYPgiD+bHF3QbALUTPBnJXEDzk2dIKk6NsWTTsjBIqKv3s0mQAhtH5W54tTmrXP0MA
         lxG9DtQrmlTi/iCSaOtThzhCUlZZG2Ps2cO6QPw4enKR2NCyJ+UTXa344QuESl+R9Q1X
         FDCxwZREMH2dJ7ldAWD1Z6GBPv3/v12U4TKl9Rd5lA9bbV9r86xHkqlijVmYgNcjDlO8
         uTdiWH0clD3h29J0sC30hNw1AzgP9DVoB6y2lQg/xQJdnoQN4fQJK/fsTc4ndJz95xSN
         QxEg==
X-Gm-Message-State: APjAAAV7AkT8jYPgGwWhrr3vGxbvIBdeJ9REz4ei3ZRhiq/ihjQ4RXc3
        E0L4jnyXk1M1g4fcsqk27rF82vppBWetGViaivT2wQ==
X-Google-Smtp-Source: APXvYqxCbzuMBWT5K3b2HgUi+Q5hTzul8JsyZgTT6hLJtDr97u7KeHt/RxokKus6SftJ2PcCZHaoSSck3FX5mjKavTU=
X-Received: by 2002:a9f:3806:: with SMTP id p6mr4441649uad.21.1565218994663;
 Wed, 07 Aug 2019 16:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190807215903.24990-1-hdegoede@redhat.com>
In-Reply-To: <20190807215903.24990-1-hdegoede@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 7 Aug 2019 16:03:03 -0700
Message-ID: <CACdnJutiu0kUreyECpNok=D1hPqCW-JDw1aEzMU9cMuTSiMTxw@mail.gmail.com>
Subject: Re: [PATCH 5.3 regression fix] efi-stub: Fix get_efi_config_table on
 mixed-mode setups
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 7, 2019 at 2:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Fix get_efi_config_table using the wrong structs when booting a
> 64 bit kernel on 32 bit firmware.
>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Fixes: 82d736ac56d7 ("Abstract out support for locating an EFI config table")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-By: Matthew Garrett <mjg59@google.com>

Good catch. I think fixing this is preferable to reverting - the
duplicate events are visible to userland, so there's a risk that apps
will end up depending on them if there's a release that behaves that
way. Presumably mixed mode isn't a thing on ARM?
