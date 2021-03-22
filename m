Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC9345151
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhCVVCF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 17:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhCVVBX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 17:01:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD7C061756
        for <linux-integrity@vger.kernel.org>; Mon, 22 Mar 2021 14:01:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so5607071ejo.13
        for <linux-integrity@vger.kernel.org>; Mon, 22 Mar 2021 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lUBeViwY4puqOiiihs5kvZT9Ntf6WJDisEmVoNCxiaQ=;
        b=ZQZPasAvRYi43vi26qkJ9JFk6wNADOGbzbgCIyeQjlerF+A5KJmxm58S4G+FxbnsrR
         yustYrQEzXjtmkmC+rH4mSbBGiWh8JQkPesRqy6pwxOY6I/QRWvC6pptgHgFmyddOcDj
         kyzmetBjDEPi7OEUAGCk/XHledOpdvGNbJIe2vYDZ2jjO50Gm2eZEyv//gJOci9+OFja
         X9jscjMJZo4w94nB+T38zC8KA0GljzaQzlj2r5rZYe2lM3+uhbm3QqL7Rj64nyK4ooqR
         9tgOA8SFFzRI2rGYOToaFSSZXwSoLNBkgE1hIxZeKjs8A8kk9obenCIMSjpreTxz2J0t
         IZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lUBeViwY4puqOiiihs5kvZT9Ntf6WJDisEmVoNCxiaQ=;
        b=pVfDw4SARPD6kiwCobHIXc8eUxKjPRx883i8Lw/X8yW6VgxDk7CMxU2PkVCCy/o6Kd
         gD+1ZHFy0L/3oAaWC5dND0GLbeYV5o9ookTidt51nBrvPKMFgczkNzlGPV5A8dcdpE7J
         JAoKEhrCUyLWY29B6FIJAzQJxtvLpQy96cD/Zdkzt2cdvgdhEbDjIzo27FTtxi1BoQRd
         EKqLSdk3kHqkJzaGboL6HklSggUB/fPAST5Wdes21JEaiDXpgorYbtvEv1q8HnDXZuZ/
         iVHJlNZJZELD8khKba/hRLv/tKOzEDo15pUSs2r5OH3iM4ng+VMB/bdh8n4zYLp8212s
         QBlA==
X-Gm-Message-State: AOAM533Fpkfrh/+W2DwVDROJjyJvwYRnhHdN77WbyABqngyLdf9qvyHA
        qJTKOwQbmlihCooANXEKYoHbU9NJCVzZCkldzmb52tYy
X-Google-Smtp-Source: ABdhPJyY+5VZ0jDxpwpl94zdQMI44AtrR2c1pkL70kmhHgwI6Pb2PIA0oABBZX3F7giSs1TwTN5/AZUPJic82dTDZ7E=
X-Received: by 2002:a17:906:b318:: with SMTP id n24mr1605184ejz.372.1616446881352;
 Mon, 22 Mar 2021 14:01:21 -0700 (PDT)
MIME-Version: 1.0
References: CAEjsYA5ipyJsyDMk=HO+V8c-8Cfu2+yfKaJbmaq4moF4BAA8xQ@mail.gmail.com <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
In-Reply-To: <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
From:   Paul Enuta <paulenuta@gmail.com>
Date:   Mon, 22 Mar 2021 23:01:09 +0200
Message-ID: <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com>
Subject: 5.10.y Kernel Panic while poweroff and reboot - Null Pointer
 Exception - with TPM-Module SLB 9670
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear all,

As described in the issue here:
 https://github.com/raspberrypi/linux/issues/4228
and here:
 https://www.raspberrypi.org/forums/viewtopic.php?f=75&t=303564&p=1817702#p1839351
starting with kernel 5.10.XX we encounter a system hang with kernel
panic at poweroff or reboot if we have dtoverlay=tpm-slb9670 loaded.
Applying the patch proposed here:
https://github.com/raspberrypi/linux/issues/4228#issuecomment-804081079
and rebuilding the kernel solves the issue.

Please review the issue and provide guidance finding the cause and solving.

Kind regards,
Paul Enuta
