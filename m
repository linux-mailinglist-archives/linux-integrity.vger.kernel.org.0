Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70CF74FCB3
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGLB1v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 21:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGLB1u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 21:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646A127
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 18:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689125224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocNLmvGR7kxVxI6dJrp51pqGUF67GQOJCx01vsa/B+E=;
        b=UF7lMLpvKD9+OXSZ69KZuvcBYNWc9nm62pF3/eTneIl3kqRXH7JvrlxvaB7I+ZbytVlxOO
        6TmSCpIofcSzRYEOgyRILQ1t3Ri9PZ7b3MJwAZwluyoLYA/gN8QnDoOyz/mx3hdghiI13b
        Qq9EsrtuHvPXIuYCF0S/B9qMY3aU254=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-4OuPyNpcMXqMDF3ZYUjLeA-1; Tue, 11 Jul 2023 21:27:03 -0400
X-MC-Unique: 4OuPyNpcMXqMDF3ZYUjLeA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7835d8b1122so74260039f.0
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 18:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689125223; x=1689730023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocNLmvGR7kxVxI6dJrp51pqGUF67GQOJCx01vsa/B+E=;
        b=iCQ599VIDIHtkCwN6VEP3EjIJAVvhe6wQ+lkoayHpmtIUNtZHoOReRou0CcCOV7ac8
         sYCiglI8smJorrUhQo+ibmyG/XQlvb/BXKHi/SgUxHkrzsHUpPE8ijnkCN546rEW4ZSG
         RaaH6VzhIgu6eQbEWvLp6Re2pPCtiAAsDG6NWA1ATvqcFwEvxwDeLKaw2quCYaxvGVDP
         1u0JbZ46WO9HQ9V4M2fc5+8tJNYLfsK3WKwwzvC/o4gOCuHWxqMjzIx6m8Q136+4ck9B
         /jS9+Hw8P0WtkBxKojrghftxUCQfq4Zm3jE/TfdCT75yjSjnNiOA7ZEDMjkHSDCez1Es
         ekQQ==
X-Gm-Message-State: ABy/qLa8OvseQLoVLwejNR7uXRxu3Kze4/SK8/Eau3ke+seBvJrmZ+VG
        z410KTiskbaZNkLBTBv+xe43xRKRMJ2lw6DB/I0MoS1RwXsox60aEdzohnZ42AeGmnFAf3X5sDU
        01oZVlduMSffJ/+/5MLgRIoVv2VafNn2yospVPvlmBSP0
X-Received: by 2002:a05:6e02:932:b0:346:10c5:2949 with SMTP id o18-20020a056e02093200b0034610c52949mr13794769ilt.1.1689125222785;
        Tue, 11 Jul 2023 18:27:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlxdigAm+vrY+sQ9k08ownvSzVq2tBlBZb5YstpZDFEDJvAsu8IRjZ3+TTbxGF96c1r8l5QAxulq55I+ZKIOI=
X-Received: by 2002:a05:6e02:932:b0:346:10c5:2949 with SMTP id
 o18-20020a056e02093200b0034610c52949mr13794752ilt.1.1689125222485; Tue, 11
 Jul 2023 18:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-11-tusharsu@linux.microsoft.com> <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
 <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
In-Reply-To: <b4047d8d-2c7c-e357-1c1f-cc55978fd963@linux.microsoft.com>
From:   RuiRui Yang <ruyang@redhat.com>
Date:   Wed, 12 Jul 2023 09:28:33 +0800
Message-ID: <CALu+AoSWcEU7PfHvejYAuFWMEO6uGEWPnJMXuW2kNG-MUshFsw@mail.gmail.com>
Subject: Re: [PATCH 10/10] kexec: update kexec_file_load syscall to call ima_kexec_post_load
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 12 Jul 2023 at 03:15, Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
>
>
> On 7/7/23 01:20, RuiRui Yang wrote:
> > On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
> > <tusharsu@linux.microsoft.com> wrote:
> >> The kexec_file_load syscall is used to load a new kernel for kexec.
> >> The syscall needs to update its function to call ima_kexec_post_load, which
> >> was implemented in a previous patch.  ima_kexec_post_load takes care of
> >> mapping the measurement list for the next kernel and registering a reboot
> >> notifier if it's not already registered.
> >>
> >> Modify the kexec_file_load syscall to call ima_kexec_post_load after the
> >> image has been loaded and prepared for kexec.  This ensures that the IMA
> >> measurement list will be available to the next kernel after a kexec reboot.
> >> This also ensures the measurements taken in the window between kexec load
> >> and execute are captured and passed to the next kernel.
> >>
> >> Declare the kimage_file_post_load function in the kernel/kexec_internal.h,
> >> so it can be properly used in the syscall.
> >>
> >> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >> ---
> >>   kernel/kexec_file.c     | 7 +++++++
> >>   kernel/kexec_internal.h | 1 +
> >>   2 files changed, 8 insertions(+)
> >>
> >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> >> index f989f5f1933b..efe28e77280c 100644
> >> --- a/kernel/kexec_file.c
> >> +++ b/kernel/kexec_file.c
> >> @@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
> >>   }
> >>   #endif
> >>
> >> +void kimage_file_post_load(struct kimage *image)
> >> +{
> >> +       ima_kexec_post_load(image);
> >> +}
> >> +
> >>   /*
> >>    * In file mode list of segments is prepared by kernel. Copy relevant
> >>    * data from user space, do error checking, prepare segment list
> >> @@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >>
> >>          kimage_terminate(image);
> >>
> >> +       kimage_file_post_load(image);
> > I think it should be only done for the reboot case,  please just
> > exclude the kdump case here..
> >
> Thanks for the feedback RuiRui.  Appreciate it.
>
> Conceptually I agree with you that this needs to be done only for reboot.
> I need to figure out how to do it implementation wise.
>
> If you can give me pointers/suggestions, that would help.

Hi Tushar,

You can check the flags argument in the function
if (flags & KEXEC_FILE_ON_CRASH) is true then this is a kdump kernel
loading, just skip the kimage_file_post_load in that case?

>
> ~Tushar
> >> +
> >>          ret = machine_kexec_post_load(image);
> >>          if (ret)
> >>                  goto out;
> >> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> >> index 74da1409cd14..98dd5fcafaf0 100644
> >> --- a/kernel/kexec_internal.h
> >> +++ b/kernel/kexec_internal.h
> >> @@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
> >>
> >>   #ifdef CONFIG_KEXEC_FILE
> >>   #include <linux/purgatory.h>
> >> +void kimage_file_post_load(struct kimage *image);
> >>   void kimage_file_post_load_cleanup(struct kimage *image);
> >>   extern char kexec_purgatory[];
> >>   extern size_t kexec_purgatory_size;
> >> --
> >> 2.25.1
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >>
>

