Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F1723D69
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjFFJaV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjFFJaU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 05:30:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1FE69
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 02:30:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97458c97333so730438466b.2
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jun 2023 02:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686043817; x=1688635817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/b9eQD2U4JFecRonfIOzNQ915xdjwedMzqOKJvtv8I4=;
        b=OPfRD0ynWhQCsls7kIyUJwC/5VMb2UedOuW6bR2T+RBZUlwH55rkw0kEiJygNo4IiQ
         8QbTl+DwEnm7UUc3V5BFhyoWygd+nwyqnfrQ9sU7+JnaPoIDCE5ZFW+membQA72UFPGI
         wE/+tfiDDy6dAsvpUJJ7Riw5DjtmuloxWJ4Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043817; x=1688635817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b9eQD2U4JFecRonfIOzNQ915xdjwedMzqOKJvtv8I4=;
        b=PZL6+QP9gRvpkA9y/v2NwvvwHv56D8VaMHz9wJEGHrlO38ba+kKA5ca1s2PoOK0+Q7
         z8wK46p1fPFkJyp/QAJc1JX6LIyTUAV9mZmh/T/ax7Nhpv/czsCa+jRcmJ0c6G9f+BiH
         2KpbaAFpxScHVL3JlGHEXiQOrVb36LMM3GhWg1+1zUIz7hVNYIAN0UUqrDaibfkCueBQ
         /031ax0s3g0fmaDeZJOn55oT6VhJWkIFha42agf3nGJDF/TuhkQgjpQHCnMJSmVugthl
         Rt2Qiq8uAgd4+oDB18SZ84hWDxVnHnEw4q49hPrV/uRJrPvq4hy6LXrTAFLGN96N0ltA
         W2vg==
X-Gm-Message-State: AC+VfDwQ6KkU7JidbKxGqKBWBeNLlze0259q/L1XLs12RixYQpCtiq3p
        La0raFQqf+G8rp+nhW634/6XNvfZd//VeBZvUfldhw==
X-Google-Smtp-Source: ACHHUZ6jFPSGzornDfPU6sgAKh3VllTFRtDWCILyDWS95jF6HhT1IKdyJrivkYZPAMWj9/Vb9M/8Jpnk3Q8SYZAr3KU=
X-Received: by 2002:a17:907:940d:b0:96f:608c:5bdf with SMTP id
 dk13-20020a170907940d00b0096f608c5bdfmr1398910ejc.64.1686043817324; Tue, 06
 Jun 2023 02:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c5b77105b4c3546e@google.com>
In-Reply-To: <000000000000c5b77105b4c3546e@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 11:30:05 +0200
Message-ID: <CAJfpegv+SSns5oSn3ZJfpD9S1FrYHHcNWTMeK6kSr9_KmWH08Q@mail.gmail.com>
Subject: Re: possible deadlock in ovl_maybe_copy_up
To:     syzbot <syzbot+c18f2f6a7b08c51e3025@syzkaller.appspotmail.com>
Cc:     linux-unionfs@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
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

#syz dup: possible deadlock in mnt_want_write (2)
