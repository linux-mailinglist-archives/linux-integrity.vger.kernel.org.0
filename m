Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1A333580
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 06:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhCJFm3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 00:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhCJFmG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 00:42:06 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D3C06174A
        for <linux-integrity@vger.kernel.org>; Tue,  9 Mar 2021 21:42:06 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id g46so93945ooi.9
        for <linux-integrity@vger.kernel.org>; Tue, 09 Mar 2021 21:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NIgMGChfP/x70HD15gunZAo4jVx7zs/elFhLqWFFB6I=;
        b=m6/REgQSyxC8rI6ekkzTKQgnhHmS8S5V+uPGx/a+MGc2RSLc8rpTQM9KlcBBxRbRmM
         m1YEofMnEq3dXcu/IS5Vcj+BimsoK4hdBHcAmisFzuYeVg+1mDz8+RfqOxqWnj81/XlO
         LoiwAMLTBN/ZMQ/FFZ+Thos9+iHLvIolTRRNPrJXNRM/pE7oW/13RmRpz+DRbS421KyE
         zKoMWeERsPVKW9G1xG4HJ/UBP3IzBduxxKSy4PgXbJyPXhB9jYuJxWz4IBM/AN9e4UEF
         tnhBLGuT10NIAm3OUzt3hsT6rIijOiYY3BLG3qfQgwpJK+wpWhL6gd4FGM9zHFf14kbU
         Dcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NIgMGChfP/x70HD15gunZAo4jVx7zs/elFhLqWFFB6I=;
        b=HRKDD2uLlqlUOWryBIHlkMYolg6NlbInb9HU5WjAsIF2D5h2tDv5+6CdX9TWk3fJCc
         Mjx4bqF07D+hWfF2IE/cP0Hn3ol5U8/rS/l/PBMFq+kG6T0UyYEh0i7hO/F8j+K8WdfL
         f3L+4SYZmK+m+uuYzh3i8cpIkLqGGeIlNqecvj3VuWq+xxC4uM35NJdxCcmsTdQpaOeg
         fTZfzHE2j62uqZL4pJJkvYFbzDgb4e9UUqjw0SJD/3dHXha92ptb0xumIAgRdEOq2OKX
         b0uUzm1fiZM0MfeCPbtvmI0ZFftKQ1o+tIjrL00ggQmdu62BN89KW7KPIjXC2OGzhW9F
         GN7A==
X-Gm-Message-State: AOAM533ureLxBUDvUbrp5YUIVy+3Q3Z+yGnPuuhTwYAgG6EEF0an6J1t
        mFSKbMCu+eHgWddlOA9Di9qWch+lOZUXIlQ46anw1txh8Elpwg==
X-Google-Smtp-Source: ABdhPJxwR/ZywT88EE+7utfTfbTtsB2tZ0Oe9frCj7aQHALaRtAmX2BtGVuk/+Mi4SCje3cJKVBYuiU1XOqVtopFluc=
X-Received: by 2002:a4a:a105:: with SMTP id i5mr1099541ool.54.1615354926074;
 Tue, 09 Mar 2021 21:42:06 -0800 (PST)
MIME-Version: 1.0
References: <CA+dP_Q1Siy7CEMABgEtUAVnbWxiQ8DLc2LkgVY+W29QEcC1YDA@mail.gmail.com>
In-Reply-To: <CA+dP_Q1Siy7CEMABgEtUAVnbWxiQ8DLc2LkgVY+W29QEcC1YDA@mail.gmail.com>
From:   Andrew James <ajames3254@gmail.com>
Date:   Wed, 10 Mar 2021 16:41:54 +1100
Message-ID: <CA+dP_Q3o8r-0h5W1dVOppeEFoyfz2F4A9Ve_-zOB9hWWQSS7ng@mail.gmail.com>
Subject: Fwd: TPM unaligned memory accesses
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi everyone,

I noticed the following potential unaligned memory access in
tpm-interface.c, and I was wondering how it would be handled on
architectures that don't support unaligned accesses.  Is this TPM code
expected to work on all architectures?

ssize_t tpm_transmit_cmd(...)
{
    const struct tpm_header *header = (struct tpm_header *)buf->data;
    int err;
    ssize_t len;

     len = tpm_transmit(chip, buf->data, PAGE_SIZE);
     if (len <  0)
         return len;

     err = be32_to_cpu(header->return_code);
        ...
}

I'm referring to the line at the bottom, before the ellipsis where we
read 'return_code'.

struct tpm_header has a __be16 tag followed by a __be32 return code.
If we are reading 'return_code', is this an unaligned access?
Similarly this would apply to the 'length' member too?

Documentation/unaligned-memory-access.txt recommends going through the
kernel API get_unaligned() and put_unaligned() in <asm/unaligned.h> to
avoid unaligned accesses, but I don't see this anywhere in the TPM
code.  I'm just trying to wrap my head around this.

Thanks!.
Andrew
