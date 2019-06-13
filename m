Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1733443EB
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392405AbfFMQdX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:33:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbfFMIE4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 04:04:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so14321046lfo.6;
        Thu, 13 Jun 2019 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gCtDdvLdjyjyNKWUbR6wJnuv7FUPOS+6IB7ZzcAz+c=;
        b=U4fL/N9ZGw9VRhYABC3i5p+yhIoeqDoXD2dlRNdbtYQMVAriywhfiy/dhojyMwZGpz
         K0Zm9IPWQMF8SSxxoJ6HdyQEpyc1bG6E2fT2HfAKI+gdj6GAyxcn+hr8RCpEbHFUrgvn
         CpepaTYBiLXhFL+qjoXlWPVBqKme+mcUZZ17WtFNADuNoX5a9KzXiz3BOlCEaxHArB4F
         KIAODZ9tmJluheumianLexQpmvuCtvKKv5wmNMAObItduzvVgrk7nfrm4G+e7/1V6WKD
         BF1LyXH8Gj+VIxrAtOA1Az6i+DMT3s5dBANNB1PDPMFzL8WcBaETL+7kNPFZRN8sefC5
         hVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gCtDdvLdjyjyNKWUbR6wJnuv7FUPOS+6IB7ZzcAz+c=;
        b=LJvyGmAyL8TVAw/goqhtprcXERXx1FM1TwfqoPyHGEkTNXN6Y3uyBzQHBFX2KXfjLw
         6BzCqmpVM8BFwvelljN4eRz5o4GzOvIR1GsLCbLjhlwMKrkDoXNuobbvJdGa5S/5oMCx
         GCIAtRxN12OsupxGDldzqTp4FbzHiZM6oEu9SKFpjMp4dKORjMEOOUOKy/850wruAzPZ
         bSjWQjHOOZP3fW8DRF9XkWvy1XITwsMk90F51Izf3/dR0ccLBuK7pHROS2euj92XS5xu
         b78FVj0Q4xO/Kry+KyOSzvwEeIGiViUSRzr9OWD7yjFK9nG2BrMFgnRfSQmGHCl+8/2B
         vr2Q==
X-Gm-Message-State: APjAAAWiR4BW5dsIaMATDaXwyA1mc0otYkEhTagq38QXZQgKYQZOXBkn
        k6xcVWKeT8PxGB+4XKf5kVqRMLBg+hETZX99uxE=
X-Google-Smtp-Source: APXvYqzLFzk7NtOJfG+b8M/+CHlqJrPv2SBKrcKCiijuq/epieEq72ItLujZgsxOrthT3MLYDvVmlniZeVtoqSurorY=
X-Received: by 2002:a19:ae01:: with SMTP id f1mr43031184lfc.29.1560413093746;
 Thu, 13 Jun 2019 01:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
 <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com> <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
 <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com> <CAE=NcrZiyWjZUuxdLgA9Bq89Cpt1W6MLAzPkLHVgfOqSo2i1hQ@mail.gmail.com>
 <144bf319-ea0c-f6b6-5737-0aac34f37186@huawei.com> <CAE=NcrZgQSENPOtRdU=u1y6kqy0ouaaj-gioKHaUxZUcbUHwqA@mail.gmail.com>
 <3911846b-f836-592a-81e1-a2fd25470d98@huawei.com>
In-Reply-To: <3911846b-f836-592a-81e1-a2fd25470d98@huawei.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 13 Jun 2019 11:04:42 +0300
Message-ID: <CAE=NcraD_DcSqog8XbisA+0YdNqwj0v_jZhzjR2Na0eZ-2XgJQ@mail.gmail.com>
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

On Thu, Jun 13, 2019 at 10:50 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:

> > Would the appraise actually need any changes, just keep the
> > IMA_NEW_FILE in ima_check_last_writer()? Of course it's not that easy
> > (it never is) as the iint could go away and things like that, but with
> > some tweaks?
>
> I think the problem would be that the code that sets the status to
> INTEGRITY_PASS is not executed, because the file gets security.ima after
> the first write.

We have a patchset coming shortly that starts tracking the inode
changes as we go, so first time we fix it is when the file is created
before it has any content (!);

diff --git a/security/integrity/ima/ima_appraise.c
b/security/integrity/ima/ima_appraise.c
index 5fb7127bbe68..da4f0afe0348 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -236,8 +236,10 @@ int ima_appraise_measurement(enum ima_hooks func,
                        iint->flags |= IMA_NEW_FILE;
                if ((iint->flags & IMA_NEW_FILE) &&
                    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
-                    (inode->i_size == 0)))
+                    (inode->i_size == 0))) {
+                       ima_fix_xattr(dentry, iint);
                        status = INTEGRITY_PASS;
+               }
                goto out;
        }



--
Janne
