Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171AA1CDF1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfENR2B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 13:28:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38926 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfENR2B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 13:28:01 -0400
Received: by mail-it1-f196.google.com with SMTP id 9so74888itf.4
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4i/GfwYocR2/h6tdfoUE0F7syQf1P0LjuLXxtwtP3o=;
        b=u/A+mSJrb+oVXP3Y7eZLK9mBLNbY3jp7svhJhW+o+gdAbQJHHsutvNm1/vhuGaBHWT
         QXpkdrjGjRuyajkIxjGrhTBU3CN8jBZvQ/M/8q9rSTXTSXc0tS3ezkSxg+G68JNB8Clo
         EtkP8o14SnGdn7nOkaM2CAgF9RfcKD8c8wXbh1x/PrImmlzWZpkTCK86hjNs8DtzqNF+
         aRDA3BZubGjTCHxvio8IMeiBUxWceRMnJwitZlv5EY7dcKT17tDPdAj5gEoqSL8Pyl0T
         FufqsQeosRA+0ijK85BwLAdGStJkOLTNNZaKd5tBaIGyTsOeM+zrTyTvSOR8SN8ivpyw
         jTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4i/GfwYocR2/h6tdfoUE0F7syQf1P0LjuLXxtwtP3o=;
        b=riEI0tJNSm3fZHOEC+V6TAoVl2oYgXljRJaXAPCD4DlrgoP8tSh04gPRvl2ix1ZE8l
         wX3ZM3zH+mBAefR/uiFf6UcjKCHKlP9CbeR+cnc7HpAhsI+OMCPV8Q3KW1Mh7vR3o7m6
         pSh92aqdACFydu4rZLMFJrb/7XowtFtTgYDHW/mK9gtKf6kqmD2z7gGaXP4ukcv9bNnW
         RzxTXG412505LeKjW2QOGJuB6W655FRePS18zOcpB+cq86RdYI9MNPsXhQrXkAIyMKNw
         obxu93iEh0PFU+rn+s67xWGcAf/Amkc7DJe5Xa9kS374iZKGTtW+VQf8tf1feMv0Y9Rn
         5OlA==
X-Gm-Message-State: APjAAAUE3rm2S+kP4ZFEzOXqBtjOn6DFEUK2ChY0kvu0p7tkr8kMvryW
        GJuYe/0txKHibT4zHiACNZDK7BG3mxYYwxSD7VE=
X-Google-Smtp-Source: APXvYqzVnmjGM8v4iTl2MQXaKczfj4Epkmjsx9X5GEQGh8/Bk6/GKM2FLQtwSJdVgAHeqbonRan/jSRSQnnzY8fkbq4=
X-Received: by 2002:a02:63c7:: with SMTP id j190mr24269848jac.143.1557854880226;
 Tue, 14 May 2019 10:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAL8qiskDtYJ0NY3u+zV3YBMR4Qs_YcHSHZ61per5jwZ3n54r8A@mail.gmail.com>
 <c4adc9d7-9244-1cbe-693c-2f090851d804@huawei.com>
In-Reply-To: <c4adc9d7-9244-1cbe-693c-2f090851d804@huawei.com>
From:   m3hm00d <f.m3hm00d@gmail.com>
Date:   Tue, 14 May 2019 17:27:48 +0000
Message-ID: <CAL8qis=yNGkogCVFZwNYCG-Y8ErPdQYf+Ffpbba4QOZNMBUn2Q@mail.gmail.com>
Subject: Re: Whitelisting with IMA
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 13, 2019 at 9:09 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> On 5/12/2019 11:37 AM, m3hm00d wrote:
> > tldr: Is there some way to ask IMA not to open (execute) unknown binaries
> >
> > Hi all,
> >
> > I saw some comments on RFC for WhiteEgret LSM. Someone on the same
> > thread said that IMA could be used for whitelisting as well. Based on
> > a couple of hours with IMA, it seems to me that IMA can only stop
> > execution of (altered) binaries whose hash/sign was earlier measured.
>
> Hi
>
> I'm developing an extension (IMA Digest Lists) to allow access to files
> depending on a white list (for example digests in RPM headers). I will
> publish a new version soon. For the concept, please have a look at:
>
> https://github.com/euleros/linux/wiki/IMA-Digest-Lists-Extension
> https://github.com/euleros/digest-list-tools/wiki/Architecture
>

Hi there,

Interesting idea. Will definitely look it over.

> > If a user installs a new (unknown) application, it seems like IMA is
> > going to allow that application to run since IMA can't find any
> > integrity loss since IMA doesn't have any 'good' value against the new
> > application. Is this correct? Or is there some other option to ask IMA
> > not to execute any unknown binary?
>
> If appraisal is enabled, and the application has no signature/HMAC,
> access would be denied. If the application is installed by a package
> manager, probably files will have a HMAC and access would be granted
> unless the IMA policy requires signatures.
>

Turns out I was passing `ima_policy=tcb` to kernel. That's (probably)
why no appraisal was happening and even new (unknown) scripts kept
running. After some reading, I changed it to `ima_policy=appraise_tcb`
but the system won't allow me to login now (error saying 'Incorrect
login' or something like that). The best sources of info on IMA for me
were gentoo wiki and project page on soureforge. Could you please
guide me to a more thorough documentation meant for
users/administrators and other people wanting to learn more about
IMA/EVM?


> Roberto

Kind regards,
m3hm00d
