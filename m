Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B37220BB
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2019 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEQXcs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 19:32:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEQXcr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 19:32:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so4010762plt.8;
        Fri, 17 May 2019 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awtvMvpzZhsaTZUbEfHRJE4Vbfvc7fc0pIJD8NnJozs=;
        b=HN4Hs2kLz7PmjXNIeyWPid/KV5LSQeemV3ykbNHLA+pyXaVFJvmO1q8/Jry7ro8Bbz
         26lB/uPzGX4TTL/NAgLs7YQqPI3eDV6W/fP3r+jpaTPuMQmHDTbD2UIepgS4sm5SutqG
         fqB+j7oVREHQYd2Q57EAHKIqgmgkb8twzRSk4P8neMzFT8j7W+QjCDgrsQbizuvSpm1j
         q5N+mszjAJpjEcdEt9iGBSl3I1HSssXcYPkjF2FiV4z+olaktv+qI60CxTBjOCtO/trO
         g7zkmy+06JS9D/fbI+N9SnPsRJzYd2cQPtXfwqSvrMePHjGD3jpgXvNRLKQdZczsvlkV
         wXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awtvMvpzZhsaTZUbEfHRJE4Vbfvc7fc0pIJD8NnJozs=;
        b=G3nDratVo4I3ZSwSZi9wtpL2AiX3ej471cr5LazaZSw/66hCq0MLSmqQIo21Pvj33H
         kuYdCxuTx7ParBdJYXkPx/Os/X4NQaPwRsyGaHoCdFIWP8wvSCM9VDHPxM4Z+W+ZiuKJ
         72ojTfvVGurejR9B+alGhuMT9VdJyBq5NrwAXt+Ig9rEUQtqtnUyXjkrWwWsUqty+96P
         EarohVgsNLIJM19hBpqiglaRNxv+Qz3txDtlrhq4/n+MCPRbOX/EpdGH0TFIO/HytE1n
         qznM4V7J1exjQFGzlUXTU5w0032ZJprOmv71LoTycf2yjeX1+qqLYiDJKcGHQ9Z7baLE
         WnBg==
X-Gm-Message-State: APjAAAUkmZwg2grVWpIDZxeojk5wD+m9rCGD2Y7iOORM4azRYh5x8V4v
        rQx/zWusm/s1OO/M9xAt37CP2O+KCc4f9HcNj38=
X-Google-Smtp-Source: APXvYqy7E9jBDRwnw+HbDOS8UC8KzgTl9AzoRrCpdXsoBctksnXrT2KgZgkfiL19AAYeCBKYI9PtZ+r7b8cb0voUgBc=
X-Received: by 2002:a17:902:112b:: with SMTP id d40mr59939401pla.31.1558135967232;
 Fri, 17 May 2019 16:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223744.10154-1-prsriva02@gmail.com> <20190510223744.10154-3-prsriva02@gmail.com>
 <45344b2f-d9ea-f7df-e45f-18037e2ba5ca@huawei.com> <CAEFn8qJVvNivP6Lmx+nVewPcHjH=V2OrR_HyHR6nOeuVQW0A4w@mail.gmail.com>
 <ec8ee6f7-3a1d-6498-e009-f85e677b448a@huawei.com>
In-Reply-To: <ec8ee6f7-3a1d-6498-e009-f85e677b448a@huawei.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Fri, 17 May 2019 16:32:36 -0700
Message-ID: <CAEFn8qKgH5FMLaudqTH6W0k7NpSoWV_NHbmiVduaQPbUNF_4Lg@mail.gmail.com>
Subject: Re: [PATCH 2/3 v5] add a new template field buf to contain the buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com,
        vgoyal@redhat.com, Prakhar Srivastava <prsriva@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 14, 2019 at 6:22 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> On 5/14/2019 7:07 AM, prakhar srivastava wrote:
> > On Mon, May 13, 2019 at 6:48 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >>
> >> On 5/11/2019 12:37 AM, Prakhar Srivastava wrote:
> >>> From: Prakhar Srivastava <prsriva02@gmail.com>
> >>>
> >>> The buffer(cmdline args) added to the ima log cannot be attested
> >>> without having the actual buffer. Thus to make the measured buffer
> >>> available to store/read a new ima template (buf) is added.
> >>
> >> Hi Prakhar
> >>
> >> please fix the typos. More comments below.
> >>
> >>
> >>> +     buffer_event_data->type = IMA_XATTR_BUFFER;
> >>> +     buffer_event_data->buf_length = size;
> >>> +     memcpy(buffer_event_data->buf, buf, size);
> >>> +
> >>> +     event_data.xattr_value = (struct evm_ima_xattr_data *)buffer_event_data;
> >>> +     event_data.xattr_len = alloc_length;
> >>
> >> I would prefer that you introduce two new fields in the ima_event_data
> >> structure. You can initialize them directly with the parameters of
> >> process_buffer_measurement().
> > I will make the edits, this will definitely save the kzalloc in this code
> > path.
> >>
> >> ima_write_template_field_data() will make
> >> a copy.
> >>
> > Since event_data->type is used to distinguish what the template field
> >   should contain.
> > Removing the type and subsequent check in the template_init,
> >   buf template fmt will result in the whole event_Data structure
> > being added to the log, which is not the expected output.
> > For buffer entries, the buf template fmt will contains the buffer itself.

>
> The purpose of ima_event_data is to pass data to the init method of
> template fields. Each method takes the data it needs.
>
> If you pass event_data->buf and event_data->buf_len to
> ima_write_template_field_data() this should be fine.

Hi Roberto,
I did some testing after making the needed code changes,
the output is as expected the buf template field only contains
the buf when the ima_event_data.buf is set.

However i just want to double check if adding two new fields to
the struct ima_event_data is approach you want me to take?
Mimi any concerns?

what all tests do i need to run to confirm i am not
in-inadvertently breaking some thing else?

Thanks,
Prakhar Srivastava
>
> Roberto
>
>
> >>> +      .field_show = ima_show_template_buf},
> >>
> >> Please update Documentation/security/IMA-templates.rst
> > Will update the documentation.
> >
> > Thanks,
> > Prakhar Srivastava
> >>
> >> Thanks
> >>
> >> Roberto
>
> --
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI
