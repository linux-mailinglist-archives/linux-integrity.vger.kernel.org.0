Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C535144439
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfFMQfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:35:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39933 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfFMHkF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 03:40:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so14263616lfo.6;
        Thu, 13 Jun 2019 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTsD8abM/BznGbeu6LC524n36oJnvXsBau6ddYNQFVs=;
        b=FowXToWA8YxlffZOsYV7t4zYkKbdH3oH8iGXGNkSggI2fKZQy1EZaVQPTBbY7IYWUl
         rAaPUPgyWnrQN/bdrbPRKm3H2O9fXOxaQJCBtWfsQ+6gE+FjjEC8/C3rId5Q1Qq3CQTP
         6H54AxI5G5bpkLc8yjgMJsdBX6XPzm6V6sxk3NsA2msgXZOWYtU6+3/sjw6y+4X7fcya
         oNyBnW46XcOhz5eijXQVTR3LwnrI2rw7dXlzqcnomWZ8hpUqYOc3BFFZIM7jEirL5zHH
         DCH6MJ7m4UmyFcBvD7/I0fTCTQurZyI6ya32MvRNeLHsCglSR+e1XQqISIJQ9gDwjRJT
         iE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTsD8abM/BznGbeu6LC524n36oJnvXsBau6ddYNQFVs=;
        b=hh5IHYSnFoX3XZO6PRz6BNQdJtB6CzGaJdUED5VEA8/kzbu8EQABUQKBu5LvVp9FKP
         3b/UBkFDcT8+zlL6RGqgBU8TXoUlT5O2lJ5PaZY+G8x6SYkcnKEhwMH7Ev3doC9PD99Q
         xv9dySeOExc0zs1mi+6EVoN1gEuCkuEKYGN7Kl0hD3Wex/Ce7c5ogV8/Uwd+pyr8A57q
         vAWtD/vW5cy3R0o6Fx9aiMnhjfxXC1Q/wbL11/RelQHvtFObgA2SCiZ7MtzphME3NcZ9
         ZABSaGLEx/3I8APCVrCIYm/8Tfbz2WTpTk9cGe4B80ypIlalnPMmzTT6DwBd429i9722
         F9QA==
X-Gm-Message-State: APjAAAVBwe1zmy5I85Og27oP4nS0uHvl+pJBIv/NhkgtJDQo64y6lZbO
        sPPXqXjvENnI34W28VtoGvoNN4APhoA9Y84ulvo=
X-Google-Smtp-Source: APXvYqz4GgdrjdGT9/K7kMmA5P6nsh11JOXIR3551eUE7KBUU6Btf3kgcAPOzaxsKhk12cqCRJKVi/YOUgpwqWQLdkY=
X-Received: by 2002:ac2:4904:: with SMTP id n4mr2442222lfi.53.1560411603398;
 Thu, 13 Jun 2019 00:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
 <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com> <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
 <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com> <CAE=NcrZiyWjZUuxdLgA9Bq89Cpt1W6MLAzPkLHVgfOqSo2i1hQ@mail.gmail.com>
 <144bf319-ea0c-f6b6-5737-0aac34f37186@huawei.com>
In-Reply-To: <144bf319-ea0c-f6b6-5737-0aac34f37186@huawei.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 13 Jun 2019 10:39:51 +0300
Message-ID: <CAE=NcrZgQSENPOtRdU=u1y6kqy0ouaaj-gioKHaUxZUcbUHwqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@huawei.com,
        mjg59@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 13, 2019 at 9:57 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:

> > Ok, I see the use case. Now, if you pull a urandom key that early on
> > during the boot, the state of the system entropy is at all time low,
> > and you are not really protecting against any sort of offline attack
> > since the file is created during that boot cycle. Is there really use
> > for using such key? Wouldn't it be possible to create a new config
> > option, say IMA_ALLOW_EARLY_WRITERS, that would hold the NEW_FILE flag
> > until the persistent key becomes available? In other words, it would
> > start the measuring at the point when the key becomes online?
>
> I also thought about similar solutions. Another is for example to keep
> the appraisal flags at file close, if security.ima is successfully
> added to the file.
>
> Initializing EVM with a key is not a trivial change, but it seemed
> better to me as it does not introduce exceptions in the IMA behavior.

Would the appraise actually need any changes, just keep the
IMA_NEW_FILE in ima_check_last_writer()? Of course it's not that easy
(it never is) as the iint could go away and things like that, but with
some tweaks?


--
Janne
