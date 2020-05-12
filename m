Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A121CF45F
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgELMah (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 08:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgELMag (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 08:30:36 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E028206F5
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589286636;
        bh=J3dCJ8ubzx0/h11Me5hEiE/dLV/HBQNq47FFE6myQYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIeLOogVJwtCQyhlqBPFq5HJvWUpJRyaibS4Mluqtzy5Vcn43CugA4gePgdZMuhQe
         B/EzUmTU6Bz3z4+TYyAX+RdjCNmRWti9fIM6C4+ZeQWBpUASXxksUJNVFm7GlSbjlE
         Djd+wDwXHrAHtLMWUAHxdAgYQ8bqVV5TjOJ1+Bm8=
Received: by mail-io1-f46.google.com with SMTP id i19so13632432ioh.12
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 05:30:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuZvid7jJq5gefOlMBAARn2kYuz1WZJz3BtYmeelCPkI8BMA7jCQ
        fGk45XVlL28+6vQIUsgJrHv+8bJpNxKc9pgf4wc=
X-Google-Smtp-Source: APiQypLuYgpL+sZ3x5KoQ/eLalULDNGCbngRq9Pk8CHwSeG+fqpBv/4gSUl1val8Y70Ee2N2VCyJJEVv6wfWoPXWP0k=
X-Received: by 2002:a5e:8705:: with SMTP id y5mr7771528ioj.142.1589286635753;
 Tue, 12 May 2020 05:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
 <CANMwUkg+2O2nK8z38HZw6z0NdLUPwj40m4DPKmn1sf9oDqG7Pw@mail.gmail.com>
In-Reply-To: <CANMwUkg+2O2nK8z38HZw6z0NdLUPwj40m4DPKmn1sf9oDqG7Pw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 May 2020 14:30:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPt4eSDCC61paWhyfOaEeWUgUQSnczwZJ7Eny8t7ow5g@mail.gmail.com>
Message-ID: <CAMj1kXFPt4eSDCC61paWhyfOaEeWUgUQSnczwZJ7Eny8t7ow5g@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        javierm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 12 May 2020 at 13:40, Lo=C3=AFc Yhuel <loic.yhuel@gmail.com> wrote:
>
> Le mar. 12 mai 2020 =C3=A0 08:45, Ard Biesheuvel <ardb@kernel.org> a =C3=
=A9crit :
> > So what functionality do we lose here? Can we still make meaningful
> > use of the event log without the final log? I thought one was
> > incomplete without the other?
> The char driver (drivers/char/tpm/eventlog/efi.c), already ignores
> efi.tpm_final_log
> if the event log version isn't EFI_TCG2_EVENT_LOG_FORMAT_TCG_2.
> So there currently no code making use of the final log contents on
> those machines,
> besides the two cases I patched which only try to determine its size.
>

Ah ok, thanks for clarifying. If we never consume it anyway, then I
agree this is the correct fix.



> I don't know if the table contains bad data, or just doesn't follow
> the specification
> and uses the older SHA-1 log format. If this is the case, perhaps we
> could try to
> support it, and modify the code to allow returning the additional
> events it might
> contain to the userspace.
