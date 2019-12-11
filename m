Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99DF11A50E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfLKH0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 02:26:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43150 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKH0m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 02:26:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so22818961ljm.10
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 23:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wk0Zpxd6MStBetz9tFjIjy0awxDbhjDXm0IrI89SlMw=;
        b=byyfEesc/GLVoGQQdXxaTveW/wRp4eJLTjIteH8/xLXTWBaoTWsERc3Lx+/JjMyK1f
         INQXEEHjf4fC9LnUW/uNynQTzWjzbMNtruZdPdtrY6ceR8jFrXDAiAQDn7iSBN5qx0re
         3SNRsErh038ympfhyHXlLmwGFIbZCMiKfVhMS004sDIwyQ6EMh0ZUwwetbuD0VwxrsXO
         ni4wkXy3u7mK3vEe3oYlARZUnMTzud0G4wiM4parHOp3p1oa24n13g0ox8w3vw3BbqeW
         e+CC65YcLuZhCBiZIJw0B3Mq9GICUpQav+QfIqtCVa+wIzu6/bBGfdXcQr4D7Phn9owQ
         R8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wk0Zpxd6MStBetz9tFjIjy0awxDbhjDXm0IrI89SlMw=;
        b=W1PPb30zIk3uNLG+T/u2ZSAb+wfYpqBJRj70qp2i5//511TjMiPPUPtRzEK6fUkcGA
         TJVD/waowoIxlwkI9B+I8P83Y7XGBO4XxOFi4sHuuhgJa1c256i2zTWlvg/C1iuv1OsX
         yGqXyB17R0xZbUm5EXaOzNy9z+0bKYmAMsMqEjDbtB/tEgsBJQgyuKAEHANXSs8FkVvw
         sP95+I1tqwfVbOW3IutYSemdt38r9qGywhqEtMuczbAGV9gRZoXXOgd8a/0wNR7TEzi4
         b8JrNroTd/rwP/EXzs2pf5uLa4+oddnKlK6tr5cgmO89V2hrueIOl7nd2a28NdoFFyjJ
         GoBg==
X-Gm-Message-State: APjAAAViDovNVnAIIEXhk2R0r/+YNa5akCfggxkUdeZThf0wX4iWK/Gt
        15WuddpzWWR9EmD8gYIET3YTdCbLagaPcerWn1c=
X-Google-Smtp-Source: APXvYqw0bq5SmpevQDjm4MwfmQ77zbVeDkZ81QkMIu4kfboi95aHrTKs81QYyfx+En0QHnaCew9ntNoCMn2/OTRkP54=
X-Received: by 2002:a2e:2e0e:: with SMTP id u14mr995411lju.106.1576049200776;
 Tue, 10 Dec 2019 23:26:40 -0800 (PST)
MIME-Version: 1.0
References: <CAE=Ncrb-kMDRgALnvXtKukSVLEw81rqxGv6+XXxg487Q_qLKGA@mail.gmail.com>
 <f48371ec-3754-05b8-3b31-da6842f9d486@linux.microsoft.com>
In-Reply-To: <f48371ec-3754-05b8-3b31-da6842f9d486@linux.microsoft.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 11 Dec 2019 09:26:29 +0200
Message-ID: <CAE=NcrZyFRkK7hQohZq5y5wANfbehJRrvs-3BeCOTg9SF=-X=g@mail.gmail.com>
Subject: Re: forever growing ima measurement list
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Elaine R Palmer <erpalmer@us.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 11, 2019 at 4:05 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:

> > existing in-kernel measurement that is kept secure. In other words,
> > each exported list would have a measurement of the earlier generation
> > list and we would build a simple list chain.
>
> Do we need to keep multiple on-disk lists? Can the measurement entries
> be written to one on-disk file - say, when the current in-memory buffer
> reaches a certain threshold?

Ok, one way is to append indeed. Maybe this would be simpler since
every new boot could just overwrite the old file.


> A remote attestation of the system would then read the on-disk file and
> the current in-memory buffer to perform the validation.
>
> I am assuming one of the reasons for keeping the measurement list in
> memory is for better performance. If buffered file I/O is supported in
> Linux, can that be leveraged for improved file I/O performance?

AFAIK Linux only does buffered io (with LRU) unless sync is being
explicitly asked. Exporting the file would be a rare event, so it will
not hopefully be a performance sensitive operation by any means.


--
Janne
