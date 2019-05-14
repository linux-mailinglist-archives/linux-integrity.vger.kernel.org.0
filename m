Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374071C1B2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 07:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENFG4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 01:06:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39621 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfENFG4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 01:06:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so7957825pgi.6;
        Mon, 13 May 2019 22:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7ivzidNqiF6L5Pdt29c2H0Kj0g0EzNa6q9k46tNNOA=;
        b=XTnawXYqf3R9HsqS96E5qSl06en1GGyJWROir0uXJ4H3z/SYsSv0byyYFtn97lRKqs
         qQYfpVXf3tM7x/Kivn0rIX1mNhYKE+8imiCpmMVNw5iU5VVgEywypIlUlL2Mkt/pD+8F
         NUHgoobnCSE3qLigkRuIUg4NF6UktCoJSU8XNtI8V/e6fa1cMtEqnVx3+rC8o7HI2mDd
         O1NmT2yytRMubHtdZk1HtBBV25qlF1KO4xhoIosFCwIg51FS2JDCP4T7szBFsmoh14mZ
         mw8+fMsNI2CDyMfIc66Ei1NyrpTK/sfcRk3SUTcuYbx2Pz6QIOkGL8n54CuRu7V+zdni
         2oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7ivzidNqiF6L5Pdt29c2H0Kj0g0EzNa6q9k46tNNOA=;
        b=VVw1lYZmEHiAKuZG5MYCLxjZdnPHUmB/zhCBvyeiIa2WOz1jHRaOQ0mIIS8Qn6ktzu
         51xY6K9ZVXvL27xNnbmUXHfLtPXbO88icegkF7B7i9RGFeor82K7IR1fWVXDYtwCEdyP
         2cpINagHxyZITmUUOLtzO+XuBReL1669De59E1kC894lFtby5TvgK3n2MxqXeL5peJnm
         umP7Hzgtb1xlbojFgayE2YwzcGH75phaTcmmft1oC7DWsfaZdEHT0Ljd4Mr0zrNB0pGb
         QqfGQf2hSoxkI5u2Zi28ozXR3Z8NMwOKM0MVbJ83x53UobU74LYqJKGD7V9f+q334tiq
         Q4lg==
X-Gm-Message-State: APjAAAXZd8Zffqu72vIduI7QFQFHF0jppBUwmkuW1y6PtcrbLEiw4R+q
        Yu2XPX9G4Lo7JVNTPLI7Jm6sRD1jTQfTKNFv2MM=
X-Google-Smtp-Source: APXvYqylm3Vo+xJz4QY3Vv3T0tWftZToA2Edue5y3F4dBxuubEGEUZN6SgAVhnE7T2minpfzzHISkVgBpJKYNY+xIWs=
X-Received: by 2002:a62:ed1a:: with SMTP id u26mr31636146pfh.229.1557810415272;
 Mon, 13 May 2019 22:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223744.10154-1-prsriva02@gmail.com> <20190510223744.10154-3-prsriva02@gmail.com>
 <45344b2f-d9ea-f7df-e45f-18037e2ba5ca@huawei.com>
In-Reply-To: <45344b2f-d9ea-f7df-e45f-18037e2ba5ca@huawei.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Mon, 13 May 2019 22:07:08 -0700
Message-ID: <CAEFn8qJVvNivP6Lmx+nVewPcHjH=V2OrR_HyHR6nOeuVQW0A4w@mail.gmail.com>
Subject: Re: [PATCH 2/3 v5] add a new template field buf to contain the buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com,
        vgoyal@redhat.com, Prakhar Srivastava <prsriva@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 13, 2019 at 6:48 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> On 5/11/2019 12:37 AM, Prakhar Srivastava wrote:
> > From: Prakhar Srivastava <prsriva02@gmail.com>
> >
> > The buffer(cmdline args) added to the ima log cannot be attested
> > without having the actual buffer. Thus to make the measured buffer
> > available to store/read a new ima template (buf) is added.
>
> Hi Prakhar
>
> please fix the typos. More comments below.
>
>
> > +     buffer_event_data->type = IMA_XATTR_BUFFER;
> > +     buffer_event_data->buf_length = size;
> > +     memcpy(buffer_event_data->buf, buf, size);
> > +
> > +     event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
> > +     event_data.xattr_len = alloc_length;
>
> I would prefer that you introduce two new fields in the ima_event_data
> structure. You can initialize them directly with the parameters of
> process_buffer_measurement().
I will make the edits, this will definitely save the kzalloc in this code
path.
>
> ima_write_template_field_data() will make
> a copy.
>
Since event_data->type is used to distinguish what the template field
 should contain.
Removing the type and subsequent check in the template_init,
 buf template fmt will result in the whole event_Data structure
being added to the log, which is not the expected output.
For buffer entries, the buf templet fmt will contains the buffer itself.

>
> > +      .field_show = ima_show_template_buf},
>
> Please update Documentation/security/IMA-templates.rst
Will update the documentation.

Thanks,
Prakhar Srivastava
>
> Thanks
>
> Roberto
