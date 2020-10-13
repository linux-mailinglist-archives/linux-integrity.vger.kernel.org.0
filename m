Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70828D3A2
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgJMS3K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 14:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgJMS3K (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 14:29:10 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8262208D5
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602613749;
        bh=GHnOYj6TpkcZn96coahmNO0hILsEC4XKZh0raCMsDMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wHUHLqXbOtBdXZ9DxMN8R09zdttLeAtYlqhhtub8h2KvGzhhkBaE4MbmDM2ekP1bp
         1hG0KKZcm/snHY3YzAssKCjc5jMbFt5Z0JHnacdHxXKlJIXMOcdiSgY3xzFaBmxy7i
         6CKY94cDrIPocoetrvU+4HRe45h65ipnXcPYUlk0=
Received: by mail-ot1-f45.google.com with SMTP id 32so974645otm.3
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 11:29:09 -0700 (PDT)
X-Gm-Message-State: AOAM531BaBri5tSThXsa9jflMI6fmUhRGH44i5j5e1La86+0FtazeVtM
        pARCDPaRlAKagdAAlyJb+O0GvLijp9A01Q757O4=
X-Google-Smtp-Source: ABdhPJyJ8GMW4EHNrITJNioI2htmwHrqRgUFdGVQNrp+TbmOJMDPozuSb2EV2paafGbxOehXOcY/y46t9shSnQKKLFw=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr723324otr.108.1602613748994;
 Tue, 13 Oct 2020 11:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <202010140256.feiUaqBx-lkp@intel.com>
In-Reply-To: <202010140256.feiUaqBx-lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 13 Oct 2020 20:28:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH2tM5WD5Hg5ThZ5_v8MyztBCN=wQ0_H6We018jgg1RHw@mail.gmail.com>
Message-ID: <CAMj1kXH2tM5WD5Hg5ThZ5_v8MyztBCN=wQ0_H6We018jgg1RHw@mail.gmail.com>
Subject: Re: [integrity:next-integrity-testing 13/13] security/integrity/ima/ima_appraise.c:21:62:
 error: expected ')' before numeric constant
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 13 Oct 2020 at 20:09, kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
> head:   bfa46be051c194a941641c128f5e6f315f1ec232
> commit: bfa46be051c194a941641c128f5e6f315f1ec232 [13/13] ima: defer arch_ima_get_secureboot() call to IMA init time
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=bfa46be051c194a941641c128f5e6f315f1ec232
>         git remote add integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>         git fetch --no-tags integrity next-integrity-testing
>         git checkout bfa46be051c194a941641c128f5e6f315f1ec232
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> security/integrity/ima/ima_appraise.c:21:62: error: expected ')' before numeric constant
>       21 | core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
>          |                                                              ^~
>          |                                                              )
>
> vim +21 security/integrity/ima/ima_appraise.c
>
>     18
>     19  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>     20  static char *ima_appraise_cmdline_default __initdata;
>   > 21  core_param(ima_appraise, ima_appraise_cmdline_default, charp, 0);
>     22
>

The error message is a bit misleading here, but this can be fixed by adding

#include <linux/module.h>

at the top. Let me know if I need to respin for this.
