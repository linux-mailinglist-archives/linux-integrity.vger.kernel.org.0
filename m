Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1A74ACAD
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGGITw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjGGITv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 04:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF41BE9
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688717949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDsBTISbzBTDLjmus2cmCAKpmg00PLgnL3XexDug1Tk=;
        b=DnGwFFdeFuzZJk3IreCUbSzEzyp1WTNbNnbB5bVhmnj9Fo2YjCxlC+RdKPUlqSh98l9hnK
        t16CA1pV5HcpUiczh6puWwzPMtP6k+fKYswDvVvlwdBVBm/nv81ZjMEDSgMo3jP+5s8IuS
        viqK2sLJSARoLux5R2dX10n18FNO3+s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-jXm09Y41MTmdNbrQjOfpuA-1; Fri, 07 Jul 2023 04:19:08 -0400
X-MC-Unique: jXm09Y41MTmdNbrQjOfpuA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-783339b6c88so26658039f.0
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jul 2023 01:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717947; x=1691309947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDsBTISbzBTDLjmus2cmCAKpmg00PLgnL3XexDug1Tk=;
        b=lqcYquhtRrdkiNtGcUWtC0Ck7mc32VqgSi9nGOoZ4eqehS6LxQ6IcU1L7pgR/fxsNF
         FRoPwqsJMMMJI5sVzWVnn3yxqAI2KUotSEYRvGlc3LNzKxXo+RJSyljubjvufcdE7yoM
         XeTw4uLMV0OiHBkwOOcJl3uuhLCBlI8HKk3TAd5EgjV1Ok1vvy76qffNTApQz6oiIpBr
         tBF2fRZVWeOL8Y4F0txtWm8k13IPLu6u1+jXXBTn+27Auc4ZLNZOM+xD26JkI3PJKD6t
         b1e4UL0J65yyf2fTJjMp29GS09ZC6n3lHpxeX8S1vB9xsFImAK7LoY9RzCuJhrV0r2w4
         V4Gw==
X-Gm-Message-State: ABy/qLaswbNflYiJzrQXF6i5iWdzi3b7JU1zTjKMxwksmZlwOYivOnR8
        HozF2xE3R4atjhXdOEVKGN7bxtWnyN75ysptYR9aT6RN9Mxe+L31ikwvhOqFbAvO3whH+OdIzKO
        6IXf7tkPug2nJILIGHSobmo4LCuss6DmCtIJ7qnEpV5iH
X-Received: by 2002:a05:6e02:e04:b0:345:e438:7381 with SMTP id a4-20020a056e020e0400b00345e4387381mr4590736ilk.2.1688717947620;
        Fri, 07 Jul 2023 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmmO9KnWk1OmpKCwnkO7ACUqSxF9xZ4r8DsWs9KsNMtByt1/3EtUImi4KmVM+CqLQ/jkRSYBt6LhkIH/6JgZ0=
X-Received: by 2002:a05:6e02:e04:b0:345:e438:7381 with SMTP id
 a4-20020a056e020e0400b00345e4387381mr4590728ilk.2.1688717947397; Fri, 07 Jul
 2023 01:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com> <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
In-Reply-To: <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
From:   RuiRui Yang <ruyang@redhat.com>
Date:   Fri, 7 Jul 2023 16:20:33 +0800
Message-ID: <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] kexec: update kexec_file_load syscall to call ima_kexec_post_load
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
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

On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
>
> The kexec_file_load syscall is used to load a new kernel for kexec.
> The syscall needs to update its function to call ima_kexec_post_load, which
> was implemented in a previous patch.  ima_kexec_post_load takes care of
> mapping the measurement list for the next kernel and registering a reboot
> notifier if it's not already registered.
>
> Modify the kexec_file_load syscall to call ima_kexec_post_load after the
> image has been loaded and prepared for kexec.  This ensures that the IMA
> measurement list will be available to the next kernel after a kexec reboot.
> This also ensures the measurements taken in the window between kexec load
> and execute are captured and passed to the next kernel.
>
> Declare the kimage_file_post_load function in the kernel/kexec_internal.h,
> so it can be properly used in the syscall.
>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  kernel/kexec_file.c     | 7 +++++++
>  kernel/kexec_internal.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f989f5f1933b..efe28e77280c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
>  }
>  #endif
>
> +void kimage_file_post_load(struct kimage *image)
> +{
> +       ima_kexec_post_load(image);
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> @@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>
>         kimage_terminate(image);
>
> +       kimage_file_post_load(image);

I think it should be only done for the reboot case,  please just
exclude the kdump case here..

> +
>         ret = machine_kexec_post_load(image);
>         if (ret)
>                 goto out;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 74da1409cd14..98dd5fcafaf0 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
>
>  #ifdef CONFIG_KEXEC_FILE
>  #include <linux/purgatory.h>
> +void kimage_file_post_load(struct kimage *image);
>  void kimage_file_post_load_cleanup(struct kimage *image);
>  extern char kexec_purgatory[];
>  extern size_t kexec_purgatory_size;
> --
> 2.25.1
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

