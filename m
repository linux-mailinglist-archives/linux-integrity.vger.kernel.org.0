Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7B74ACA4
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGGIR5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 04:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjGGIRy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 04:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D14E1BE9
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688717828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPaN5pqbomSOKx5xl3JROR9VsqVfGN0ANT/ZNiELBU8=;
        b=EgxBKNnyQfx6Lw8bnawKtB2iSqgq+xBoiydyXbfrhey3ItWOriUxBH/FmVtpoRtMEk6PjJ
        ZCykEsS5Z4SJ2351FolvgY670d8WV0nCDU4mP+3LZufQyCHQXwQpA2FDQrKIg/GIDcaorz
        TVS1Ru3+sZf73n/tLeYnqmo0J1S2n4o=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-RFlY0JXuO1au2VhAvbalgw-1; Fri, 07 Jul 2023 04:17:07 -0400
X-MC-Unique: RFlY0JXuO1au2VhAvbalgw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-34616cffaabso1547955ab.1
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jul 2023 01:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717826; x=1691309826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPaN5pqbomSOKx5xl3JROR9VsqVfGN0ANT/ZNiELBU8=;
        b=Br9IFVP31srsDq3pocwY503Nu9MTcjYlHEUQGVc25a152L7oZBUCyHYyaHUqgc2BAB
         fP8iExOpkyU21zHj4zQp+1wzXRss5klX7ePBZxYE6kVwjHQS3iTayiINF8GkKzo+FkxH
         8PzjVih7y12lcMYA5EU8Y6ivE0vJPFadgobKaYJ6hNp1JW7LhuNSELI+Fo26oq9LJ9Qr
         QJMRfd8XXj6f4OeYyJNhDeSR2TD4uKkS36y9ve2mOZx9XPTnONvqQNAP3cIEIOfynpDx
         Ujjkh8dhq11lvsefTuI5mSTZIdeQ8w2gVURF1WAALKxwIgS/83oQHUMUwsMUaqW+BKzY
         Slhw==
X-Gm-Message-State: ABy/qLadnwikoh6DG6sLMLiigw0Ap118yX4GpyOXFB3v+tZPwUlRdqD8
        D8CD425Ge7RAlpN1TSSnC7Lq5PNaqFhNDCX4xv0Cs9plQ5gcB4IEjSTlLbBWL00qS1e5xTd7P9T
        PCub4cR9gBGB0TCS9Gv+spaUxqiDtS4rpq3vLu5CMHqQl
X-Received: by 2002:a05:6e02:1a62:b0:346:1919:7cb1 with SMTP id w2-20020a056e021a6200b0034619197cb1mr6742330ilv.2.1688717826512;
        Fri, 07 Jul 2023 01:17:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLdSmS3qJJRQ35msI1TYAi+yBPPV4fvNEEnqy2IXhTRvWYiVXIjdoR/KlooxuKrMIls/Q5ivEzfqkjGa2k8uU=
X-Received: by 2002:a05:6e02:1a62:b0:346:1919:7cb1 with SMTP id
 w2-20020a056e021a6200b0034619197cb1mr6742316ilv.2.1688717826255; Fri, 07 Jul
 2023 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 7 Jul 2023 16:18:31 +0800
Message-ID: <CALu+AoSyhnw0Cz06Mmqh+7FcLUF1q0txY1qbWLxkHO8OD5---Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] ima: measure events between kexec load and execute
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Add Eric in cc]

On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
>
> The current Kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new Kernel after kexec 'execute'.
>
> Some devices can be configured to call kexec 'load' first, and followed
> by kexec 'execute' after some time. (as opposed to calling 'load' and
> 'execute' in one single kexec command).  In such scenario, if new IMA
> measurements are added between kexec 'load' and kexec 'execute', the
> TPM PCRs are extended with the IMA events between 'load' and 'execute';
> but those IMA events are not carried over to the new kernel after kexec
> soft reboot.  This results in mismatch between TPM PCR quotes and the
> actual IMA measurements list after the device boots into the new kexec
> image.  This mismatch results in the remote attestation failing for that
> device.
>
> This patch series proposes a solution to solve this problem by allocating
> the necessary buffer at kexec 'load' time, and populating the buffer
> with the IMA measurements at kexec 'execute' time.
>
> The solution includes:
>  - addition of new functionality to allocate a buffer to hold IMA
>    measurements at kexec 'load',
>
>  - ima functionality to suspend and resume measurements as needed during
>    buffer copy at kexec 'execute',
>
>  - ima functionality for mapping the measurement list from the current
>    Kernel to the subsequent one,
>
>  - necessary changes to the kexec_file_load syscall, enabling it to call
>    the ima functions
>
>  - registering a reboot notifier which gets called during kexec 'execute',
>
>  - and removal of deprecated functions.
>
> The modifications proposed in this series ensure the integrity of the ima
> measurements is preserved across kexec soft reboots, thus significantly
> improving the security of the Kernel post kexec soft reboots.
>
> There were previous attempts to fix this issue [1], [2], [3].  But they
> were not merged into the mainline Kernel.
>
> We took inspiration from the past work [1] and [2] while working on this
> patch series.
>
> References:
> -----------
>
> [1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
> https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/
>
> [2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
> https://lkml.org/lkml/2016/8/16/577
>
> [3] [PATCH 1/6] kexec_file: Add buffer hand-over support
> https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/
>
> Tushar Sugandhi (10):
>   ima: implement function to allocate buffer at kexec load
>   ima: implement function to populate buffer at kexec execute
>   ima: allocate buffer at kexec load to hold ima measurements
>   ima: implement functions to suspend and resume measurements
>   kexec: implement functions to map and unmap segment to kimage
>   ima: update buffer at kexec execute with ima measurements
>   ima: remove function ima_dump_measurement_list
>   ima: implement and register a reboot notifier function to update kexec
>     buffer
>   ima: suspend measurements while the kexec buffer is being copied
>   kexec: update kexec_file_load syscall to call ima_kexec_post_load
>
>  include/linux/ima.h                |   3 +
>  include/linux/kexec.h              |  13 ++
>  kernel/kexec_core.c                |  72 +++++++++-
>  kernel/kexec_file.c                |   7 +
>  kernel/kexec_internal.h            |   1 +
>  security/integrity/ima/ima.h       |   4 +
>  security/integrity/ima/ima_kexec.c | 211 +++++++++++++++++++++++------
>  security/integrity/ima/ima_queue.c |  32 +++++
>  8 files changed, 295 insertions(+), 48 deletions(-)
>
> --
> 2.25.1
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

