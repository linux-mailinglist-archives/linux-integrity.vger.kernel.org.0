Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75A23BB3F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jun 2019 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfFJRqr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jun 2019 13:46:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42560 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbfFJRqr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jun 2019 13:46:47 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so7562490ior.9
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jun 2019 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmxGys1dpUHh1BpCwFFwU7PWrMRyDun5SlRjJ8jtEeo=;
        b=FsoZgAHLJxKqdelh9pIxk3sLhOSNQzTayeZmoZe0SdBjHXiRKfW0cGJTbWh3QcponO
         CSRwRQCPi0VyZgMQ7Nfq0LWYQvH/7/u5rr9t5m6GeqwTYF8aJEc+1/htf8SgV8sioa5p
         9RcQDkdj6nX7ZmVUk96sT+ozhE94g3+hxDtoB5hw7sOARM06xz+z08VWUM7LTDl6plfO
         7NBLHM8/JNXQtQmsse7sDgQqrsnl0/smFVjJRpoUk25fq7B9slGk+FU79OuD9DtRY8Yv
         ErQn6BnGFLK7B5dseJFFbiAStam9SdaxjClZ3gmsv9A6DEZ64knuuuTcT2D8fOkw2Mv4
         n6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmxGys1dpUHh1BpCwFFwU7PWrMRyDun5SlRjJ8jtEeo=;
        b=mWaDNDhdPsdYyRGqEk+pe2e6r/kR5GNa+iVVzjekaUP2i3dK9h3xIssSNFq/6dXdFx
         J0hudmFd6/d5Y6gPzYG+0U3Mwejjs1vk5DC2udcXy4DSla5DBuKtdEzZVJTdCIWcbUwg
         1kFlRpB8YXxyTmTkAB7AlqPs7hv7S3I/OSwJuCj1jyYcD9ZD2Wrp1CgIiX/XHNi6zWaX
         kgKgblqq7rd92oynsJO2MUIMzEfZdMrHnIuh3SF4/pm7OUykSlT0zinUmTL/rmM8j8N2
         SbQw7aw6B5N1goOTqsMmCqfi85HJf4mmJuKZnmeusCXszipwT53EN72ni/qXNhVYdnPW
         YoxA==
X-Gm-Message-State: APjAAAUq3nkiZsGlK84z0XgshlxuGQsMhHc0wkqm5pD11QaD2iwvqB2g
        WNVi8y5CMwaI0YzkXm38GF7vk5RCRDp/bI9sRZgJSQ==
X-Google-Smtp-Source: APXvYqxBJ9oE7++plitE+MmrgGGgNstDTqsBXLF7YahD+dCmjvdOJT+zyBg6iOuJXUPFx4NMyvNPa/RGhf/Fi/mqdac=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr17074640ios.84.1560188806028;
 Mon, 10 Jun 2019 10:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190607205147.102904-1-matthewgarrett@google.com> <20190610165819.GA10114@linux.intel.com>
In-Reply-To: <20190610165819.GA10114@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 10 Jun 2019 10:46:35 -0700
Message-ID: <CACdnJusZQeKTGDs5c-TG9Yrv1ShN8Twgf6R=TmAdDNjLMnaRNg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] Abstract out support for locating an EFI config table
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 10, 2019 at 9:58 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jun 07, 2019 at 01:51:46PM -0700, Matthew Garrett wrote:
> > We want to grab a pointer to the TPM final events table, so abstract out
> > the existing code for finding an FDT table and make it generic.
> >
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
>
> Just to clarify are these extensions to what you did before and not
> something that needs be squashed your commits pipelined for v5.3?

Correct - they handle a corner case. Ideally they'd hit 5.3 as well,
but if you'd prefer I'm ok waiting.
