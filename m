Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D6A2B7271
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Nov 2020 00:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKQXaT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Nov 2020 18:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgKQXaT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Nov 2020 18:30:19 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C07C0617A6
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2020 15:30:18 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so224501ljg.13
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2020 15:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Em64QPCkGCLXZWoLObSIBhUC3x5oAVxDwnh90HcLMak=;
        b=HeuQ3NoSPHMV5vKQqErsUpbPU0jCzVO1YYw049IBFq1aeufNNpzqJb5qaTS2ZHfFe+
         WcUWdn6RMYtlbpqWvhE+FKQgR+SjxTvXaBlD3AxqZuA+NUcWqZcWsAHAfKnyuWsrg+Kw
         I+44mfRUd+9oWmJWHMV2sPLHW/pUwKHciZkoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Em64QPCkGCLXZWoLObSIBhUC3x5oAVxDwnh90HcLMak=;
        b=ghEiNeu8pcOJEcCZeOapBhmEMXMczVBxAi5I6Ay4w/kh/eGNIGKIEv/QH2zBOncJMX
         h8jLq4iEk0nq2GbYv6HyhYpB1BfvfLpUPzBlWL0++mf7z0Vi+X4AzE3IphjKRkI0tSRt
         qD7B16GbNw8PtvPI7OhDbQNDM5oGMYRLOisNAhNQFlfhK7fGWBr4RrtI4XkFyGFCmAhT
         +tfoprXkhtgOgqecVRxpraq9xXqExxcifkIKTav0ESLH43A2L1I2HC9loF+4kzthCOpE
         ksn/QRFIjp6prouGu5jtBAKlFBqtZ0YRgkIsqqj5nKqGrQ+4BRdfFqx0YDEJAlgusfwJ
         wCzQ==
X-Gm-Message-State: AOAM531VpaQdwlanV1H7BGwLUqk+APBWVjsAdYbEZ8qFG7AiL2LVPWmP
        zu/O/31HvaCkQBTvyM+EoP8pZ8BDpI/Ovg==
X-Google-Smtp-Source: ABdhPJxVc53N/sq4nbVahtMz1NOKx0MrWma6SUCgk2JuWKXHWCS6wvzlVu96MlSiRE5ucqGerKg+fQ==
X-Received: by 2002:a2e:58a:: with SMTP id 132mr2830501ljf.77.1605655816802;
        Tue, 17 Nov 2020 15:30:16 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b79sm3332349lfg.243.2020.11.17.15.30.11
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:30:11 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 142so239749ljj.10
        for <linux-integrity@vger.kernel.org>; Tue, 17 Nov 2020 15:30:11 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr2679618lji.314.1605655810863;
 Tue, 17 Nov 2020 15:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
 <20201116174127.GA4578@infradead.org> <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
 <3f8cc7c9462353ac2eef58e39beee079bdd9c7b4.camel@linux.ibm.com>
 <CAHk-=wih-ibNUxeiKpuKrw3Rd2=QEAZ8zgRWt_CORAjbZykRWQ@mail.gmail.com> <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com>
In-Reply-To: <5d8fa26d376999f703aac9103166a572fc0df437.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:29:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
Message-ID: <CAHk-=wiPfWZYsAqhQry=mhAbKei8bHZDyVPJS0XHZz_FH9Jymw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 17, 2020 at 3:24 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> I really wish it wasn't needed.

Seriously, I get the feeling that IMA is completely mis-designed, and
is doing actively bad things.

Who uses this "feature", and who cares? Because I would suggest you
just change the policy and be done with it.

            Linus
