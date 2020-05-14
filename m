Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6D1D2E46
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENL23 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENL23 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:28:29 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50691C061A0C
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 04:28:29 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w18so2886616ilm.13
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+IdqknttVh5/K1Sdf3ytc/NygnuBZXyGJs6YURDEGek=;
        b=hL5fV5rZ3xSKvUN8t2pQUV+QP2gL5hRwR2Bt1EkcNoBe8qRMlEObs0cb6TolXQCPQE
         G1czOvsiMRRw1pUi+ZcEcLgd2PvjKbGPwD4zbVSBvCTkXFuADP4ZxOdbsACUixh2qR+6
         UtY7uQ4yj0chkHBfYPCFhv49J1QjyPtJUAuTJwMSqnxZ3MXlFsBaYN6e/KDVTKBozVGO
         SggdmNWEqP0TzB4P/jvjZcVDLSp5xIHXljqtK4KE8xoakeDz9moBTTQ6Tn/Cdb8IJMwf
         RqiZKJwV8zjD1/JDO/C5KfgwhaNhL6GtViiDJsHwjJLI4fDDu0Jr/DGNvsjggC8ywJKE
         OrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+IdqknttVh5/K1Sdf3ytc/NygnuBZXyGJs6YURDEGek=;
        b=iwcE3QB5xHh+jqlBIHtyMaJBa20Yc9E5tIJ9WJTNAgSMWFGntjASqtIR1thof+AH1q
         +XzsYpZzU7mbKUlCg++db5/acqT0x95XNd19Zn/j1QJI2TOcKZ2KZc6hcrxStFYOy2aR
         9qp7PMylsn0ybauBeDVGfnnBQKxMad6tlWkzHw97wrRiHbEuk30F85SpgXVlUVYMRcC4
         258EDoygQtTkpbw86g7KxdQRgtWuP4rlns3DABF2cUsbBHfswJBxhZo47jGBL6fCnGyw
         AUTtnrysZYT9IHnKGxWqzGpEqkVIWjnyaVAIhGhJ6J2HpmFsiHqrPl83u9CKGALv38OZ
         0Vhw==
X-Gm-Message-State: AOAM530yJVy6v7VLoHBdwwJpxaxvXIma6eAqOA6P5u90kTOTO0C1/q8y
        lnQRteIYZhMx2P0Hfndd/V1EmoSiCpeGgI5nc5o=
X-Google-Smtp-Source: ABdhPJyIvmOPRf0Z/gYMetcCIknefxd1zlTaiKSYf2LbWqDLMKOqGBeB/k3Mqifq87XbTUkq1gg7q88H+okKV6QRbP4=
X-Received: by 2002:a92:3a81:: with SMTP id i1mr785232ilf.234.1589455708679;
 Thu, 14 May 2020 04:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
In-Reply-To: <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
From:   =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Date:   Thu, 14 May 2020 13:28:16 +0200
Message-ID: <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le jeu. 14 mai 2020 =C3=A0 12:54, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> a =C3=A9crit :
> So it is clear that "pr_warn(FW_BUG ..." would be a sane to have there.
So only to tell the UEFI might have logged events the kernel can't read ?
There is no warning if the table is missing, which would have the same resu=
lt.

I can try to dump it, perhaps it is using the SHA-1 log format.
If so, would a patch to support this non-standard behavior be accepted ?
