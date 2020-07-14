Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7121F667
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGNPsv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNPsv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 11:48:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5AC061794
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 08:48:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so17707775edq.8
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2020 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geWoHm0dGyB50Rmo0gHBfcDLwCZECBkcejM8K8k30DQ=;
        b=XxgHUC2I3sDfRkOff33DVWFGlsDneOECTpImGtuyGsGtO0nGaNLhSMPKfl5P22aGeG
         TLVZGuaiHQwXMQb46pJmGUWWfzbMQb6vl0+JJBB2ZAWXonJOV180ui8YM9H54B9qO/v0
         9jbY2VQ2cueS9HveKggZsF7i7NEJPQUfQgolZuaYVXlAqRdyW1JJrAwNi3MG/8CCn7cs
         4KVww/VHimVN4gxPkQZYoYrnqLOOgDxzUTcktukP3c6IuQOShciXd+3JnsumWHJTakP1
         d4Rw0zG5CUIvzggFksUfup3hfCKWDPDlRpJXgrCPxEzkhj5NHVOif4DHRBV3VF/3yL/q
         mz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geWoHm0dGyB50Rmo0gHBfcDLwCZECBkcejM8K8k30DQ=;
        b=YY0nfrM5HMOPSxOMH+fCTR+uWJryfQ3BGKwD84RG7SXaSQjCfQGsrbN0wDUehwJOJ2
         MHDxCAalJ1bndCjRrnEwakktzX/9+p3uNUKqJOxgFs/YEjxWe/BMEcmQEporyMViYSCm
         v9BaI0JsXH8TdnPFwsH8htYge1UhtkNXp8m5oDcbeHOCl7lwEg7YtPwhuCT71v77OZhw
         xGadYM8do2wIfoF6Kg/GgpWsoWpnpga8fyTTR6uooQeoBszycWMSrvIRTf9My5vVCX7S
         FG+moaji/ZEP0A1pRhIBhNJdD3yj/Z61oAmRbGjgwBW66RT1ei/2jLx/S+88s2rA8PNJ
         LhCg==
X-Gm-Message-State: AOAM530NhIG5dbeOtGTycyx2wtX7n1/3X5X+kA9JxCBaoTz2Sx1gEZHW
        YJAo9ISkcoaPvlW/+elIEqni9OWUE/d7hxejjbK/yQ==
X-Google-Smtp-Source: ABdhPJyfSdzSTluvaFbGmnt3BZHPPUXVEh/wqplhH7kzckPA8BqWzWVcQmFn8u+H3NMap7hAORZdKRYwRfF6ymXh6d8=
X-Received: by 2002:a50:ed15:: with SMTP id j21mr5401524eds.246.1594741729082;
 Tue, 14 Jul 2020 08:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com> <20200714113205.GA1461506@linux.intel.com>
In-Reply-To: <20200714113205.GA1461506@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 14 Jul 2020 08:48:38 -0700
Message-ID: <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 14, 2020 at 4:32 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > > Why does not tpm_del_char_device need this?
> >
> > "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> > need the fix. When tpm_class_shutdown is called it sets chip->ops to
> > NULL. If tpm_del_char_device is called after that, it doesn't check if
> > chip->ops is NULL (normal kernel API and char device API calls go
> > through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> > call tpm2_shutdown(), which tries sending the command and dereferences
> > chip->ops.
>
> It's a typo, yes. Sorry about that.
>
> tpm_class_shutdown() is essentially tail of tpm_del_char_device().
>
> To clean things up, I'd suggest dropping tpm_del_char_device() and
> call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
> coding things that prepend it in tpm_del_char_device().
>

Personally I would have preferred two separate patches, one to fix the
immediate problem (with Cc: stable) and one for the cleanup, but I
guess merging both into one is ok as long as it is marked for stable.

Thanks,
Guenter
