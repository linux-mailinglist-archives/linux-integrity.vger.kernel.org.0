Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A474C1D90B2
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2020 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgESHKK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 May 2020 03:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgESHKH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 May 2020 03:10:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D41C05BD09
        for <linux-integrity@vger.kernel.org>; Tue, 19 May 2020 00:10:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y22so13618156qki.3
        for <linux-integrity@vger.kernel.org>; Tue, 19 May 2020 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOdUPiJQ4WMqd6TPu6I+f5NnqoqhJlnMM8IsOlYOcQM=;
        b=wuRONm/bmI6Xof3evItK3OQkI85RpeckZCfeMrVvpIWPGdlygwUVgDf/H++0PqYKzb
         DwEmBVzYh0S3suh0WysnWyan/jKgqFLUTyIG/pZ6SofXgyXvQdblJbqWtR/Gizaz8BjJ
         l9iRzqJCoI67rHe8+nobhO/SHuMRnuWqoS04k69mc/UClmtY7GIUdCgTg9MCWmoQ8ZFI
         lDrJV+qu4yicaWnZvVNSom5E7i66XAJuPStMZhQWqGEAsOVtr0kE0I9IWpfVGm/7D3VH
         kfRoMjEmOWUkhnC56/TtBBPVbZ967i5BFEOi5dFq7PDvTzMPmi/EKUU4ra6OgNWMUx2g
         ObDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOdUPiJQ4WMqd6TPu6I+f5NnqoqhJlnMM8IsOlYOcQM=;
        b=FrgXADdwIRspB53Ad/5Zmi1uV4NxSb2r2rGYu8TRnJhtWdlKe0K7zxyk6r4gj0iIvK
         Z5ppLuqUKMGOLpXAQcdE0rqp1BXMgKu3XqsvGtAo+9yJu81JZ1IRZAJ8JCekSdHinXIo
         /ixeeD6ntXwXItCEG53VLQVzfybP8AtOQwrg/qKdqKasZwzoDf6y+rdl28QTMx4aNHJ3
         +7iP4ZoD6CbKHcSk8xEeeZImsYAlpGUYvmPfgNXI9J/a6LbW9l2txFI81xgNXvNDVIUq
         5VnOphq6RqJnhpUa9Ghtgy8UxQ8Fek6cAUqT3e+ZSjhAQLpSudOk3TprBd/vRSNcTOJa
         7ITQ==
X-Gm-Message-State: AOAM5310mIeBPigN9J8faJ9hHwhqrXVixou2slBnwoZ6RolhS61+dff2
        dEdLgf5+iJQcErDp1EFdbB15t8Zd66IrEMB0uhYyrQ==
X-Google-Smtp-Source: ABdhPJxNzWQXkolQlTKJQWuG+a8ny2E36b0nRIXkHwT3uWPnIdVF2upQrgI4ZZ3t9j/23d/3d5MC9QWo/vFaTrDI8is=
X-Received: by 2002:a25:bd10:: with SMTP id f16mr28718795ybk.125.1589872205139;
 Tue, 19 May 2020 00:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200518133459.28019-1-maxim.uvarov@linaro.org>
 <20200518133459.28019-3-maxim.uvarov@linaro.org> <e886d85baa24c09a6b571dd993e7450d5b16d48c.camel@linux.intel.com>
In-Reply-To: <e886d85baa24c09a6b571dd993e7450d5b16d48c.camel@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Tue, 19 May 2020 10:09:54 +0300
Message-ID: <CAD8XO3YBUT0tOz+zZMT+wsXG_HgsEm+kOe9tqjdgxCUKdMv9qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm_ftpm_tee: register driver on tee bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 18 May 2020 at 22:38, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, 2020-05-18 at 16:34 +0300, Maxim Uvarov wrote:
> > Register driver on tee bus. module tee registers bus,
> > and module optee calls optee_enumerate_devices() to scan
> > all devices on the bus. This TA can be Early TA's ( can be
> > compiled into optee-os). In that case it will be on optee
> > bus before linux booting. Also optee-suplicant application
> > is needed to be loaded between optee module and ftpm module to
> > to maintain functionality for ftpm driver.
>
> Please use proper casing in the commit message e.g. tee to TEE
> and so forth.

Ok. Will do in v2.

> What is TA?

TA there is Trusted Application. I.e. application which runs in a
secure world (arm trust zone.).
This also fixes the Microsoft ftpm driver which has a corresponding
application for secure world.

Maxim.

>
> /Jarkko
>
