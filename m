Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3601A5BA
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2019 02:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEKAQ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 20:16:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35063 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfEKAQ2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 20:16:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so4042678pfa.2;
        Fri, 10 May 2019 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5x2tWauOasbmQygmVEvJr0U0PUarRPwShg51MdnJLjQ=;
        b=NYKrGaSy3oF5JiFyyguay0cqndzovy1Tn3SS3vaNjZwpXKRuQy0zWkWUd9u/d/HN6U
         5CMUK0MO/TDYq2oNKHyk8qs+w2PeD9GHwj3oa7nQ/WP3u6dY+axSPxqLmsCM+oSqz4Gu
         FdZJNC8E4a/27AHMcIVtRU7hPnoexyVQGJwC0+ILnA4VFpmrNR9JMVguBX6jUFOZ60gt
         rIOhzvyZlierHLXSR/qV7I9o4Vn5JUWaQqjyKazH+1/g6JEiDBI+CHocGIpZRfjDUHUe
         jmpP+Ol2NQHqb9A4AjGpq1Rq3dvzMi3GYCvUP0v7MbB8EjkmetHpjN4kGhb4MqkZn3g8
         cmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5x2tWauOasbmQygmVEvJr0U0PUarRPwShg51MdnJLjQ=;
        b=dndPiIzNyQSRVYhsXbcxrwJAbEdHoeyMokkfPFU28zj+JwurDQB89/to93OWeSBYnH
         67CuPdHojxROF/e1oxxzUy0alzzRwWUVIykozvaKRjTqrD6F8+DSxcjtF4W80cobVsg8
         BwJf1LGYm29pgFCsGwWjeGN6O/EJCLpghwyDaBG5myw34b1YHtEAmC/wNXPRNLfelXvg
         IcBB+o/Bb0g7Hz5gN5LZgWa+/LXwZddBX5G481vuS16sFLCr/HPXJBikhC1InGupwSCx
         zVVYzlgCRH5Y/ISXL9J7YJnbFvgdIjf8k+um5Czt0TbXMprHtnjdctQEG2hQUBIAMq2J
         o8+w==
X-Gm-Message-State: APjAAAU7TgSfFA5MoTtSkqmzAd7hwmsWRI9oQUG+GIdLKStI2aEIb0J3
        LoqQb+7TFP4+s6yKNyTFX6kJU9kjughTkbCEBF7KLLOyol0=
X-Google-Smtp-Source: APXvYqx1xKu0zJ3XE0Jwmh+BulASMoZnGAAwoGQNyC0SpKI616cDoMY6/HdpLNcr/L7AUE7av17Z1RAHQNfSMQmNW24=
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr17929164pfd.115.1557533787604;
 Fri, 10 May 2019 17:16:27 -0700 (PDT)
MIME-Version: 1.0
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Fri, 10 May 2019 17:16:16 -0700
Message-ID: <CAEFn8q+rT2_0TFb0fKA6ixOvC3H5R5KpR0zFiTOXa_4U-9HeUw@mail.gmail.com>
Subject: Carrying over the ima log during kexec_file_load
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org
Cc:     jmorris@namei.org, Mimi Zohar <zohar@linux.ibm.com>,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I am currently looking at carrying over the ima log from the current
kernel to the next kernel during soft reboot(kexec_file_load) for arm64
and x86_64.
During soft reboot(kexec_file_load) TPM boot PCR=E2=80=99s(PCRs 0 through 7=
)
are not reset or extended and thus the boot aggregate does not change,
leaving the new kernel with a sense of secure boot.
During kexec_file_load the kernel file signature is validated through PE
file signature validation.
The boot cmdline args will also be measured with
=E2=80=9Ckexec cmdline buffer measure=E2=80=9D change which is in progress.
https://lkml.org/lkml/2019/5/10/728

Looking at the powerpc implementation of kexec_file_load,  making
change to the kimage_arch as below seems most reasonable.

Struct kimage_arch {
                =E2=80=A6
                ima_log_buffer
                ima_log_buffer_size
};

Add respective entries in dtb/fdt and read the same in the next kernel.
No changes to the purgatory should be needed since no kernel segments
are changed.

Is anyone already looking at this?
If not, I want to understand what=E2=80=99s the best approach for this is?

Thanks,
Prakhar Srivastava
