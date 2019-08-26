Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD279D51F
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfHZRkj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 13:40:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46191 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbfHZRki (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 13:40:38 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so39165110iog.13
        for <linux-integrity@vger.kernel.org>; Mon, 26 Aug 2019 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07FbLzlU1Ecz43EkldpfmQ01c+welin2T9Ux9RN+VOA=;
        b=jUktPM/+OKebsv6P/ehphnW7txXBARqsKU0ruH32PE1OiNAW7yGvUkyq4+ekbKnfoJ
         18QQJJJ0+ms68LlNYQJyAwMDc0wrtDZn0oZLbAcZGMdhLqJq1DWNt159dVv1RGCYGbZp
         4Cv8usiDzHIi6fraaFOJtNw2wQAGBDlbgdOs2kD5USWeBiv1vh7d3eDQ/z3VHHDMfcKY
         kmNp1wOZna+Ll+lQTmfx06KtrFNjR9AdjQ/TmSbd9IHGlY+g1WnWfUOtMSjlYvoNq3ZD
         ssgcOGtDlKDQBjLxRqnAjffKFcmGA1bDuGNwzkBERb3jVo6YvYKWaqX6j7+NoqjHNg0R
         i4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07FbLzlU1Ecz43EkldpfmQ01c+welin2T9Ux9RN+VOA=;
        b=t/yTDREtU7m9bP9EjwcyFQkXjK0LP8SbWGfOpu4kLkpdk+1sKezL8iV5utf9nBEDgG
         K48s7Rkq4WYXBPbZlUxHQePHPcm1ihWzeYm0pK7ho/fvYoABBHYBD7dK67gWSj0xetSB
         d14jAYtYW/UcNNRuczRqAxnNURh4hnIIpvNCCiVZauk8HcVtx8qveFP58mldzvZkgqrc
         exSCkh4yAnvKtzPUbhkhYqXCVa/dBvC7X+c0YgxZ4E0o7dBp4u9Comaw4juvKePORNy1
         QlxVwLB0UQnE8GcLIXx8Fd0YyyQ5S8JESX4ZDT5Ly6//AoGwXOmd2AC8kxYd8glq/ivj
         t+qQ==
X-Gm-Message-State: APjAAAWeFY1lQ4RC2Yn2qSTLfrCI48r0ql5uAkT7rpog9khGU71TTXYj
        /oPxC7uUlAQ/RlYExQDUwZ2y3wXmsETU5zXsTs5NPA==
X-Google-Smtp-Source: APXvYqww5diAuNUdEkTEcBBDnreTmON4tALCdYa3hUfAPKmUmf9O2eXoldlz14FrKT+I0D8//8NJYLuMJIA0RpfUjGI=
X-Received: by 2002:a6b:bcc4:: with SMTP id m187mr13841450iof.16.1566841237601;
 Mon, 26 Aug 2019 10:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com>
In-Reply-To: <20190826081752.57258-1-kkamagui@gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 26 Aug 2019 10:40:25 -0700
Message-ID: <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 26, 2019 at 1:18 AM Seunghun Han <kkamagui@gmail.com> wrote:
> To support AMD's fTPM, I removed the busy bit from the ACPI NVS area like
> the reserved area so that AMD's fTPM regions could be assigned in it.

drivers/acpi/nvs.c saves and restores the contents of NVS regions, and
if other drivers use these regions without any awareness of this then
things may break. I'm reluctant to say that just unilaterally marking
these regions as available is a good thing, but it's clearly what's
expected by AMD's implementation. One approach would be to have a
callback into the nvs code to indicate that a certain region should be
handed off to a driver, which would ensure that we can handle this on
a case by case basis?
