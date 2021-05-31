Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2739584A
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhEaJnO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEaJnN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 05:43:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753EC061574
        for <linux-integrity@vger.kernel.org>; Mon, 31 May 2021 02:41:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 124so10638400qkh.10
        for <linux-integrity@vger.kernel.org>; Mon, 31 May 2021 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d6FnDde8mtpbI6NdmPUvVeRnAcIFTzGEaVOzfim07kA=;
        b=TY8pSKQ5y+HZXJxPJJ/0bJWPqjNfofmPGkR+P0Yy3VXUzG3lCQUwYQHzPLGhSWBK1L
         CfB3LipIu/8p72AmEWwKN1TsbpYiCXVasy8HASW9yNSnyofoGtzv0AQi3XVGoQWjY75a
         StoVdIlAwesIbpaJuwvcPKiTYiDaPIvhLzi8Ym9YBB3pBip/cBoBF5z8WAgdXdOxP88P
         sLVebCSWBu9j1X9dbvV4fyH0/iOndU5wktlCNuO9JAv4s9czNk0JNUfaea6gQwuyZod5
         iNnPZeudm0JbmXTAq7TpO1TcPXI0On40+cOoRcgM7xjo5mOGECcRX1+m6uDjjEKshOZ2
         N+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d6FnDde8mtpbI6NdmPUvVeRnAcIFTzGEaVOzfim07kA=;
        b=oP7Cho3Jwq2NOrh/fo5cpbzWcPsFDn+x+lPf7xdZVPb4fFdKAZZ5CbBs/AcNCwMuh3
         3LApcFiy5u66/ThgpqOjilXJJdCSWGgl9rGlodQKOjLAqPxZZi27YLrzChXwELFs43SU
         ffZop6nWK4SNP7GTeqINFBTvdTbj3ION0glQ+GFZDmmJXnsR+Pfanomz2y4nZ9eu/ZYp
         T8eVcbw2WnBwzDA2dcSEI/B7wZZJPwJIPfPLg4qmsKOQifTMvJADmdBpgcD+qVSTuxiO
         hX75FvOboRWmVGmpg5bZDSz4lUE7LBFuK1dz4oRdfYRgY+7ydkB/ypdrts+loQgkuRzV
         wdpQ==
X-Gm-Message-State: AOAM531UxPJFq8iLnac1eLcWr6dMLeifIJeRXe8NqEfiWhf7rY2Xqwz8
        ZRWaq07a75xZwmnfj1l9xZJFt7KLGtZox0xk40gndNgbIsdjqquMOzg=
X-Google-Smtp-Source: ABdhPJxnOhUZAQO6UmMAgW6oKXx1dj5T3+PTlTgpNysHOZd8DkTWyF0imU13M4x/gU+X6Kl7rQGLA9WDtDEb2/3iDw0=
X-Received: by 2002:a37:a7d2:: with SMTP id q201mr15164440qke.16.1622454091846;
 Mon, 31 May 2021 02:41:31 -0700 (PDT)
MIME-Version: 1.0
From:   Denis Semakin <0xsemakin@gmail.com>
Date:   Mon, 31 May 2021 12:41:21 +0300
Message-ID: <CABtpKGWEjmM+jkt0CMPkHjLKyg0Rt+9B3CnqmSVXhs2t5dVmbA@mail.gmail.com>
Subject: Good tests for IMA/EVM
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello.
Could somebody advise a good tests for IMA/EVM subsistem? I know there
are a number tests for kernel, e. g self-tests and LTP project. Is
there something for IMA/EVM in these projects? What does community use
to test it?

Thanks in advance.

Br,
Denis
