Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77F1D2E5C
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENLbq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 07:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgENLbq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 07:31:46 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8DF206A5
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589455905;
        bh=PuzTH6CqhLggZ8jZbx8qtWT/CeRl5Dq+4vHb6iz0WfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WZGfAWRxyoS06JCg7Ou0G6BLDFrugLP4LCq/NSFak79u+9k5TUddwq0m50vr2ihbx
         m8tUpNzc1ZNaf/gIqx3ffvCoNJi7EW8nd1NSMv3DzLoTeUhneFMVixOzLeSpoDc5oe
         CqfC7iRj4W31vTTKB2wYKK5piKHyd3yrbtoVtqoA=
Received: by mail-io1-f42.google.com with SMTP id f3so2633949ioj.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 04:31:45 -0700 (PDT)
X-Gm-Message-State: AOAM531Z6oE0Rp6oK9/StAadliTrgNiKgsnSFKBj9UWhWMKdhbtejjie
        rvIarkodYPueXeDRzP+iEYZU6lMv9OJaajYr7eI=
X-Google-Smtp-Source: ABdhPJwy0miA6l+83er/64OnU+6cQdypzxrSsrfA+kNjqkksdvlk9+KbN0kw4ozZO5XFwhLAE3AUJSMjM0mjo7ic/7M=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr3628751iom.171.1589455905082;
 Thu, 14 May 2020 04:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com> <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
In-Reply-To: <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 May 2020 13:31:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEUTdmudiB5aKeDAkYhv5jbwzBQ4cOrxK8VOt8O8Xjk=Q@mail.gmail.com>
Message-ID: <CAMj1kXEUTdmudiB5aKeDAkYhv5jbwzBQ4cOrxK8VOt8O8Xjk=Q@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 14 May 2020 at 13:28, Lo=C3=AFc Yhuel <loic.yhuel@gmail.com> wrote:
>
> Le jeu. 14 mai 2020 =C3=A0 12:54, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> a =C3=A9crit :
> > So it is clear that "pr_warn(FW_BUG ..." would be a sane to have there.
> So only to tell the UEFI might have logged events the kernel can't read ?
> There is no warning if the table is missing, which would have the same re=
sult.
>
> I can try to dump it, perhaps it is using the SHA-1 log format.
> If so, would a patch to support this non-standard behavior be accepted ?

That is why I was asking the question: what exact condition should we
warn about? And at which point?
