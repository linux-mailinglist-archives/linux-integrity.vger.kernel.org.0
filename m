Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58E23B67BA
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhF1RhL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhF1RhL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 13:37:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0160BC061574
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 10:34:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q16so19839451lfr.4
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJDbCx+qi4xW555r0qRFKAgiEIbkRlABSN+3WwDGl3k=;
        b=Q6k+QvZ0eciuIKA/C8b0AX6T6lJtu9hoWk6TJBvASBRaCclEZBY9DzvAkNdv8DtHxA
         9nUE5g6ZRWzitkvPxQhbeN114x21BfWIDIM3OCz3wmqOhePIIq/qJHoERvi5s1IATprq
         hAb1fofRdlQMGhGRb4hfi96qWpWlCMpkOvsco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJDbCx+qi4xW555r0qRFKAgiEIbkRlABSN+3WwDGl3k=;
        b=MfV3E4NDXGg2x+2y9vgsC409Bjunk9NfR+qVsDZAje8ZDTTH5FT1asCoJMvQpOscTO
         npoc6vhb1tl+ZH2tjDr8Bg4KUGNEyahpScEIt00BE7+gJzhUsYdMCxEwPZuIKVYwzQIe
         zt49iEubQoNL61ZcArJ1DHQOJBgWOqMGoRP2Q7wcCIFqM/JVfpXLWNFpuI/TrOwM98iO
         xjII8aH1yzz8p12qZ4EK4EDjsrqwHx33ND6heydVKsIuTCw92X0yjJ2oxCAXIWsGhDAf
         9MogRYOzL/fQPveqbUN94IJzcJj1IHXROf9n34Lgi+r6IYwPAz/y645bY4ZE0ZDw4Gm1
         2jUw==
X-Gm-Message-State: AOAM53313VrOnS0R2RQIhKCsNQrXRxQ6ZBuYPMKXCaGXKkAEq/f2PScH
        ifbgRDDpUsmVp5fKbZoVf9k9MTA0Br7BdkuG
X-Google-Smtp-Source: ABdhPJy09ODYdO2JQ7Wf58C7H1HP6RXstNHL2sVYEmzHvxMLxXVlCb+Th2GlY+kKTUk5BoW3Y+ApVw==
X-Received: by 2002:a05:6512:3b98:: with SMTP id g24mr3978886lfv.659.1624901683104;
        Mon, 28 Jun 2021 10:34:43 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y33sm182995lje.19.2021.06.28.10.34.42
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:34:42 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a15so26176829lfr.6
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 10:34:42 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr19235333lfs.377.1624901682120;
 Mon, 28 Jun 2021 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210623135600.n343aglmvu272fsg@kernel.org>
In-Reply-To: <20210623135600.n343aglmvu272fsg@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 10:34:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
Message-ID: <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 23, 2021 at 6:56 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Contains bug fixes for TPM, and support for signing modules using elliptic
> curve keys, which I promised to pick up to my tree.

I pulled this, but then I looked at the key type changes, and that
made me so scared that I unpulled it again.

In particular, that code will do

    shell rm -f $(CONFIG_MODULE_SIG_KEY)

from the Makefile if some config options have changed.

That just seems too broken for words. Maybe I misunderstand this, but
this really seems like an easy mistake might cause the kernel build to
actively start removing some random user key files that the user
pointed at previously.

                  Linus
