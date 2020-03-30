Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9727E198220
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgC3RVz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 13:21:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45824 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgC3RVy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 13:21:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so22641605wrw.12
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WElMqt9XeRNNodbxZJ9+lOH5NPD0UEnupQHtkJA+Poc=;
        b=ujdU8xTsc1a2M6tpVeTxIim93BpeI4pZnLAd1UMPlVhMq2q9f6zd9vsQbB3ij2RELu
         SRDimp9NIz94KUaSRrOsYmJQ0Hwt6YI6HJ6/SAjHSNN8skxkgMeoW/vObvCXGkgWBsOB
         RvhKiYnh52yIadxHuBm0/VmUheZnjSOAff9MWy/fIxdGucOxyMVHmvnAkDxHgYkj2bYG
         8OJSitNrDinWSTuaBQyFKFXIGVcqINBkglLKuIFM8hi6YO2qAU9S7+mvV0m1D7MOZghH
         9p37tsgFfpc142KQwSiFJfDHa82dA2dUqzAmKpNjbLrqywrNjmga3GR3ksfYVG4knJw8
         1U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WElMqt9XeRNNodbxZJ9+lOH5NPD0UEnupQHtkJA+Poc=;
        b=NsKhQIoKzoY2Hg6uiDusJi3qlBSd4SD78fjGm2TdrodNnJIU4v5p4m5+1BdyxWawai
         0WbZ7xlTFthyQOQTxbjJmHnGyOa8fQXi92JkggFqxbDsgcOE1d0V5XdSOWHbuyEe4o9l
         bg+8aIUtfGZWncRZ8VnJFPfPOSKVmgy6qgN0ZyRpjlULr6TrZO4tg5oVEE/nCUw6WiQB
         mjuzQBBTb18SPs4QZ5NFAIaQYgvQMSuyChEa1OSEft/MpCjQ9yTvCkFeMgBenNYPUgGy
         TH1MOtl2Nmj3s0q/Mn7URPgMwWOxHg4NXXAqtMGLJdTwC3k+YjzlkUGCNPa6y80NLE1G
         CR7A==
X-Gm-Message-State: ANhLgQ0dOjmCOO16ojZwUodIOVanijLuIVorYPJpZtkx5J8MdZx3TcvL
        fIo27u9wLVpf+kxE327Ph5x/1M/YSgWWwcYJJck=
X-Google-Smtp-Source: ADFU+vv2DGv5AGHK/bLpKmTIExonswXcG9e8nHAK1w9aR0bn6019+HctXxFVDgzAvqTgvt+uou8qvW+QBZpQ81ePGZY=
X-Received: by 2002:adf:aac5:: with SMTP id i5mr14622188wrc.285.1585588911371;
 Mon, 30 Mar 2020 10:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200330122434.GB28214@kl> <1244b6bcc384413581da33c9b92743b8@huawei.com>
In-Reply-To: <1244b6bcc384413581da33c9b92743b8@huawei.com>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Mon, 30 Mar 2020 20:21:40 +0300
Message-ID: <CAP22eLGbwcXzBDpc2QbMOGtjrdYsufUf-8vq4uHt8jjPoQanKQ@mail.gmail.com>
Subject: Re: [PATCH] integrity ima_policy : Select files by suffix
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@us.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I already answered to Mimi Zohar that applications expect file name in
open() syscall.
So there is no need to protect file name otherwise applications just
stop to work.
Even now when ima hash is not correct application stops to work.
Put aside scripts for a second. A lot of programs are configured in
.ini or .conf files.
The suffix is a very convenient way to provide these files would be measured.

Now I returning to scripts.
It is very hard to enforce IMA checks in interpreters. And thinks
about perl scrips. awk. python scripts. etc
The proposed suffix rule is easy and lightweight.
I once had programmed BRM hook of LSM
I had a very hard time trying to figure out whether shell is opening a
script or data , how to get filename to check its signature.
Sometimes script file does not have shebang or does not have
executable permission.

I hope I convinced you.

On Mon, Mar 30, 2020 at 7:45 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Lev Olshvang
> > Sent: Monday, March 30, 2020 2:28 PM
> > To: linux-integrity@vger.kernel.org; Mimi Zohar <zohar@us.ibm.com>
> > Subject: [PATCH] integrity ima_policy : Select files by suffix
> >
> > From: Lev Olshvang <levonshe@gmail.com>
> > Date: Fri, 27 Mar 2020 20:50:01 +0300
> > Reply-To:
> > Subject: [PATCH] integrity ima_policy : Select files by suffix
> >
> > IMA policy rule allows to select files based on uid, gid, fsuid. etc.
> > One tremendously useful selector(IMHO) is the file suffix.
> >
> > I think of systemd service files, configurution files, etc.
> >
> > But the real goal of the patch is the ability to validate shell scripts.
> > Shell provides too many different ways to run the script:
> > input redirrection, pipe, command line parameters.
>
> Given that file name is not protected, I would suggest to look instead at
> the execution permission of the file. This information is protected by EVM.
>
> In a second time, we could consider to enforce the policy in the interpreters
> that every script must be executable, as suggested here:
>
> https://lkml.org/lkml/2019/4/15/825
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Li Jian, Shi Yanli
