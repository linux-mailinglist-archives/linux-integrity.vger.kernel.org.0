Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C9C723CBC
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjFFJOH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjFFJNu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 05:13:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150CE7D
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 02:13:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9745ba45cd1so731389766b.1
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jun 2023 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686042819; x=1688634819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/09YTa8tEcJwJTMpIH6M+tZT3IBJvAj9v+wpVe650k=;
        b=ZIYbKwYf4fG/ucLfaj3THNnjwZUxrgo+Srnk+9+rBk0CRFNwAtZw4hjG6K4p7Bbhp8
         Djs6Noh9VbDKG1qN2s4+ONprYk2kT30Qi2JWKabiVGu7cqXOzgJQbQvi2Xi0cSJfSb7s
         stnhvpC8tgmsk/SP99zWYcIm9TAX92jxvTLeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042819; x=1688634819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/09YTa8tEcJwJTMpIH6M+tZT3IBJvAj9v+wpVe650k=;
        b=lnAPtDC8LRNhsGM0zzY3c77/8LLs9wdUV08eGJ2ZPpH6iEEq9U6hmPowqJI89sKiQ7
         wA4Z834CNLtKDQufhr1qMS2CxMToRoXPwwrmJlZD+zlRtIrjChsR2eIOO5gVVBXGTQnz
         WcYm/pDfZ2PrEAHSFXR4aU7LwIppOnVcwgvHi/OM/vHTwoQnogxbYgO0Vu8HtpxtsR9i
         nLxASHhD0DclQCcTQlZtbGiNDNtzSFtKvzshURIhlsvfsShkyTMe/w49S7hBIq+GolFX
         wdUrR19/oW9CDa3HDuL7nm7OovXPqlUYGZc8i5XMZ5bSlEcb7gPrfRFkfEYFwKXM8mLe
         VceQ==
X-Gm-Message-State: AC+VfDw92b5XNA/8AZTS7KxhS/BarsSeoncHUOBmu2JzYQSdGASJu5Nl
        Zzfv9fI2y1QnkxRhOmMjKGzojaaVxHljVHAG5wILvg==
X-Google-Smtp-Source: ACHHUZ4vPzst/oCRoU4YoFhlm/1DWVKqEkFpcNkc6lS7e2xnXC1wXYrpZDXM97TMUEU9m7Y2OTbiyc0y1qBLlGN+UvM=
X-Received: by 2002:a17:907:60d4:b0:96f:5747:a0de with SMTP id
 hv20-20020a17090760d400b0096f5747a0demr1545860ejc.6.1686042819365; Tue, 06
 Jun 2023 02:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtzZnzW506AHyw_5Bqn-thhrd3-_t-qJ5OJBzP-z3O6Fg@mail.gmail.com>
 <00000000000090dbc405fd726b57@google.com>
In-Reply-To: <00000000000090dbc405fd726b57@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 11:13:27 +0200
Message-ID: <CAJfpegtFrY9oq9ZSB_ZJenDcVLoOqVKxZY71gi+1f295zsmzyQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
To:     syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

#syz set subsystems: integrity, overlayfs


On Tue, 6 Jun 2023 at 11:12, syzbot
<syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
>
> > #syz set subsystems: intergrity, overlayfs
>
> The specified label value is incorrect.
> "intergrity" is not among the allowed values.
> Please use one of the supported label values.
>
> The following labels are suported:
> missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
> The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true
>
