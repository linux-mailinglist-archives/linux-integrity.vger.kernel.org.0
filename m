Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1157BFA8A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Oct 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJJMAJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Oct 2023 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJJMAD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7CC10E
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 04:59:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so924508366b.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2023 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696939193; x=1697543993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wLQsQuOsWejoU0OnrXi9mSD8MpURT7HqfTQjNz0yMO8=;
        b=frprtuXLSULbwGZLMrH92NuTOvW1SJRtIKKthHmBNWMtxPbX6XC4pfHIOllfwhEewv
         6X31752vTuXWZ32L5EMUdSY+PMTB93duQQ79I6NpTt60vXTppOzRRIXyb4LjJzV8kg/J
         XcjENQdmltGiJ5ZZd/ScsnvmFSNsFoeAW6Grw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939193; x=1697543993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLQsQuOsWejoU0OnrXi9mSD8MpURT7HqfTQjNz0yMO8=;
        b=gSIkXUjFafAmOIvROEVSbgRfBZkjESgUtLqcvYG2EcfcRzt5MJtyogIBI/LvroRoZf
         L1Je3mNjYB6QtjFqDxFRGfzdSSM5D2s75lNT4QcCf+bHthNYKNspui+Ex02r4f2+l3Vg
         7hOibJKJXbjJCUdMoJhN51YSHhFwcdaUON64EpTtXk8IpNjsdBx7MHNVaMIFK1V/a/i1
         7AF/q7keLbQ70GEpm8IcUNvdKDYZe8vVYsIR4oCagqkCdJ+RcYp2ypU6U8pNkcsWrMHw
         kNNqyfbJw1cebTB2qCT+1AuwAprF/aCoocghKbtvubtp0iXbzdI4MRDxIoNubLn5NrZk
         2dew==
X-Gm-Message-State: AOJu0YwMkQMIEJfH189q55bYpRExHFxFP8wVd6GzDym5nH+aHTdKOPIo
        oJNlEyDD70cAiMi/PAiaH3ohE9BnkonOeRmlOLGyAQ==
X-Google-Smtp-Source: AGHT+IHuPQMXvx41pjFlEOEJcQh0r2acSYASqorJEhhRFR3294C8jolKTvIf3FuZCDAP872XQzr3xhS13RvSz1m8JyM=
X-Received: by 2002:a17:906:3050:b0:9a1:f10d:9746 with SMTP id
 d16-20020a170906305000b009a1f10d9746mr15703509ejd.20.1696939192671; Tue, 10
 Oct 2023 04:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
In-Reply-To: <20231009153712.1566422-4-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 13:59:41 +0200
Message-ID: <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 9 Oct 2023 at 17:37, Amir Goldstein <amir73il@gmail.com> wrote:

>  static inline void put_file_access(struct file *file)
> diff --git a/fs/open.c b/fs/open.c
> index fe63e236da22..02dc608d40d8 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -881,7 +881,7 @@ static inline int file_get_write_access(struct file *f)
>         if (unlikely(error))
>                 goto cleanup_inode;
>         if (unlikely(f->f_mode & FMODE_BACKING)) {
> -               error = mnt_get_write_access(backing_file_real_path(f)->mnt);
> +               error = mnt_get_write_access(backing_file_user_path(f)->mnt);
>                 if (unlikely(error))
>                         goto cleanup_mnt;
>         }

Do we really need write access on the overlay mount?

If so, should the order of getting write access not be the other way
round (overlay first, backing second)?

Thanks,
Miklos
