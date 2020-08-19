Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EF2249A3F
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHSKX0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 06:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgHSKXI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 06:23:08 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFB1207FF;
        Wed, 19 Aug 2020 10:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597832584;
        bh=oMYBEUfHSM2v9gpQsXXVTp2+Mxw0O8DXVBsLeWmVKDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ExYOqmJhj6UsXjvsK+ywMpDYRDLlU7zPM6GoHn3dQ6uQhbiwKftGVAiMF3TBNc9Da
         7PelrfvaG67iMUayh0Y5hOIT9y28l/4OcH+sfKVxsVaK+U/XPGEKYMbsTCQBrqD+5M
         X/NAyA8kx/fVB+vqVrYw1Z893P1XioEdXW7MFtP0=
Received: by mail-ot1-f44.google.com with SMTP id a65so18616411otc.8;
        Wed, 19 Aug 2020 03:23:04 -0700 (PDT)
X-Gm-Message-State: AOAM5305QPlcSJ7CAz7HNJlKzzaeeltan+Eh8HzOF8ycVNxPiUdYwq9O
        YwVyw5KOQlNYcy7ybnhfJLvyuthGUSJYL0IWqwY=
X-Google-Smtp-Source: ABdhPJwlbAJBtsIRDkgre//dLBcO99gXvk5YwUiRvc5nSnAoD+YC73rzW2NIO3G+3cJeUjxd9C2BYU4Rfv4gjUK3d0U=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr17101807otk.90.1597832583514;
 Wed, 19 Aug 2020 03:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200728031433.3370-1-masahisa.kojima@linaro.org>
 <20200728031433.3370-3-masahisa.kojima@linaro.org> <20200817211440.GB44714@linux.intel.com>
In-Reply-To: <20200817211440.GB44714@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Aug 2020 12:22:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG2h-yk_hw-HZvhAPfYRVHq=LgNp5FB1J4SmnN82Zm9jA@mail.gmail.com>
Message-ID: <CAMj1kXG2h-yk_hw-HZvhAPfYRVHq=LgNp5FB1J4SmnN82Zm9jA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial device
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 17 Aug 2020 at 23:14, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Jul 28, 2020 at 12:14:32PM +0900, Masahisa Kojima wrote:
> > Add a compatible string for the SynQuacer TPM to the binding for a
> > TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> > slightly differently on this hardware, so it requires its own
> > identifier.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>
> I applied these patches:
>
> http://git.infradead.org/users/jjs/linux-tpmdd.git/log/refs/heads/master
>

Thanks Jarkko
