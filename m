Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8151D864E
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgERRrp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgERRro (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 13:47:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F23C061A0C
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 10:47:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so10809032ljl.6
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilFS0djlykVy1P5eI7mmIHkWUV2TLGO3S4u/3xid4pg=;
        b=f+uZ9XMvjcg7Pj2CajPFupJFIDSr9ddFhQhrxBb0RA/bsuI7ZzuATo0+/ylZltsOVJ
         R22A7vytwMouhLrIf/3AATPF8b9+0quvf7roPc6/setO6Sv4SVM72UAdlF/UGkInI0XA
         1uTfX87HNlIdTTPW3uw5dFcty9O5kBfWhOOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilFS0djlykVy1P5eI7mmIHkWUV2TLGO3S4u/3xid4pg=;
        b=Z7zpGV36VwxadmHBNnkmKq7WiqrCmDcjNyGViIhvDSWMmKiwcsVARU9AbdIYutRBpK
         Un+ElbBUds6S1WpuoY8OmBhDBMnmZLxVbwEj1otnyl1ydrII96lkbzTKeXpTxXl7NQ4X
         aEMBWGSHcR+r1Oxjm8hb4JsJmRzhKF3pmFYDd8llmfIDX2W+SoZMHs8NJ0jmlls3A8qm
         id9gZGt++JZ07qbABv5LGc4drdhOsDAYsR2pUSvFOlWzGZrCtLwpDI9uhRCyY4sYFjhJ
         E44lRf0H0KzkRSaetrskJhgFioxMUDWRO7JcSbSGrtT3gIxSbnuREb25a3CM/VZARylk
         6+3A==
X-Gm-Message-State: AOAM533QenWyr44Bk+2zX3oWgPKL5KmjHguxjHwgTtzlIfZnd5z6QV0S
        jQvj+yJYDLEHmYeLdbx9xLC2Nbm6ajA=
X-Google-Smtp-Source: ABdhPJxrbDThm60CSlViitBqAZDfuO4n11SvbtZh8zXJVS/U8XTv1PT/U/+eifHJwSZqrl0AKAC5dg==
X-Received: by 2002:a05:651c:3ce:: with SMTP id f14mr2786786ljp.232.1589824061941;
        Mon, 18 May 2020 10:47:41 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h3sm7380985lfk.3.2020.05.18.10.47.40
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:47:41 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id v5so8819275lfp.13
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 10:47:40 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr11576675lfn.125.1589824060570;
 Mon, 18 May 2020 10:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <1589816971.5111.113.camel@linux.ibm.com>
In-Reply-To: <1589816971.5111.113.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 May 2020 10:47:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_Zw7ug+iMALAKfQkdyVAUWC0UB0bfRRPMOCC7U5uTFQ@mail.gmail.com>
Message-ID: <CAHk-=wh_Zw7ug+iMALAKfQkdyVAUWC0UB0bfRRPMOCC7U5uTFQ@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem fixes for v5.7
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 18, 2020 at 8:49 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.fixes

No such head.

It looks like the plain 'fixes' branch has the same commit ID, but
there's no next-integrity.fixes.

Btw, any chance you could start using signed tags? I've been
encouraging people to do that even on kernel.org, and we've got fairly
high coverage these days..

             Linus
