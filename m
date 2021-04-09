Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F7359A14
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhDIJz6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 05:55:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:33415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233483AbhDIJz2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 05:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617962105;
        bh=NaXATgTlSvZYeQCNcC5dpiVSGZEVmP6jxVk1PkPfcQc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YrX9h8ylb1wBf3aKE73Ua6016HX35JQF3cStRtF46tamqVy81bPMJudhmGnHkMbfE
         Jdj5/viaWNHwqsBFS04pc5aBVtxAn28/0e4b5qfOiV9DICjTNEZMOGEIt4A3TM5ISM
         9LMxReTBGgvtT5aRumjl37TtIjmPFMWJr8iypEcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.130.101.138] ([87.130.101.138]) by web-mail.gmx.net
 (3c-app-gmx-bs15.server.lan [172.19.170.67]) (via HTTP); Fri, 9 Apr 2021
 11:55:05 +0200
MIME-Version: 1.0
Message-ID: <trinity-7c4b1b78-7c33-480e-a8bd-0536a4c67599-1617962105587@3c-app-gmx-bs15>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Cc:     Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, jsnitsel@redhat.com
Subject: Aw: Re: Bug: TPM returned invalid status
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 9 Apr 2021 11:55:05 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <5e48c9ad-9e53-c079-83d1-7fea50412142@elloe.vision>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
 <YBGpranyEwXaqAUg@kernel.org> <YBGqWp5FqKQJK1is@kernel.org>
 <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
 <202103291901.F15EA83FB6@keescook>
 <5e48c9ad-9e53-c079-83d1-7fea50412142@elloe.vision>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:hi+WRi5d9iXr3Pa9zekE/nBw4Rgt7B7Frf8UNpHtEaHBsICqejmcUmziC67telgcwOYbS
 8ptHnvawEZWAt0MjVWZwrZlZk8pgewQk6LOMUQWubcmYcEbec9kndg1/x/7Pr2CB851XlOloMquI
 IO4D8Wvt4ITHDi7qBqZsNIn++NTzsRE67geLxo5mNkH7YVnPBbWoHnwsg1RYzWoLi8fIHnkVwVL+
 HDChucLLlEIt56nAnfUDHxZ4tmwxH0uQjMsPodUgCHIOmNLASPGnwXxUjKNl/My/rVBKpZYS0+BU
 lY=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SrNh8/bNofs=:0JhxFKWHLf73WCEuErMSoW
 ZwSg0PsIoDaM+Ln5VjcorLKHoYhy+kAitE212NrXpG0zAHHAhQVR078yJKpZphGonhJu47WKJ
 M1LPNJMntGfzS4zBAeLh/0u1t3lXVez2sxKSUm0olK9ua4mJKOPnQ1yU9pMiZL2jjIt6+B4EK
 Gd1KEHSFUzOl9hMVcEcWQI6L9MFbWWItpJrYJXkmZB/uddLzfvae/gfyOFYEyatRTcehYhums
 APhFSsAY5Vdv0BV+iB/gLIPpDRuIV1tOAVAwuu0jQcf2GZWksJ/CQOwUf3E3z793NUjeU2sdS
 Z2BTloGHqoQRiBRjRM88i5A5J0/PqiKuJYlsTVLZFpiJiiSZX02crBh9QrulJeJQ+4aM64+pL
 UeBaUE76J13QMx1Kn1Du3PfBJtTbgUpM+GDtTJpZbNxAS9PvHEqpwKXsXd+qxjLyeF1bxatEU
 wfbW/W34Ga5h4T3TFqNaEQm/SqePJejApyy3HhDCZZzW2TYdM2Cjc9/pr/WEDiEkA4UeASj67
 FMYPGXq/KK+oKaIuOrF3gG3M4NSRmCJ/wLUZEYOMYAur/pEaKB3ahXJN2gcSgvH1CQmO2AT1p
 7LkW80JwI9tgos9KTmz/UjZTKSH71vaMNzJEOe8OA73XTJ7qyhYujBKpcYSbMfa1sMUCPDIJd
 RwY8HCyqXUCMK+83b9ED/ZCGz9hLt8A3+ZgYgOP9GeYxRbJ/5cBVj9HR/kYosM8uULgUQ+ifn
 1xzrVpvcl4DkCFkbdJ52S1jc/d3YKSvqTXwCBiXGsngwLwJQAiKYxg01SCrcdTyFQgAMmdrp7
 t6WGkTQamPUwVsO7MwOj1V6fWnkcae3y5pWKKDPeZurZGX7JnZaaEsDa3RMHp4UR8/vLjffLw
 nr6v05FZUCQqW1xZUmRDPuIE9oL7DjND3QOkc1YFmwX3yIvkNeYx/sdlMxCbZOpLjukCokdBA
 wlaLelq0xaA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

>
> On 30/03/2021 03:04, Kees Cook wrote:
> >
> > Does this series solve the issue too?
> >
> > https://lore.kernel.org/linux-integrity/1613955394-13152-1-git-send-em=
ail-LinoSanfilippo@gmx.de/
> >
> > (I haven't had a chance to test either series with my TPM, but I see t=
he
> > same "TPM returned invalid status" errors recently.)
> >
>
> Unfortunately no. I tested it immediately but forgot to let you know.
>
>
> kernel: Linux version 5.12.0-rc5tpm-fix+ (tj@elloe000) (gcc (Ubuntu
> 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #29
> SMP PREEMPT Tue Mar 30 09:05:15 BST 2021
> ...

Well you tested the series with 5.12-rc5 while it was based on 5.11. Patch=
 2
in the series is supposed to fix the "invalid status" warning by making su=
re
that the required locality has been requested before.
To avoid such issues at all and to simplify the whole locality handling (a=
nd
also to be prepared for interrupt handling which also requires locality ma=
nagement)
that patch furthermore ensures that the locality is requested only once at=
 driver
startup and not released until driver shutdown.

However between 5.11 and 5.12-rc5 there have been at least two patches tha=
t
again introduced a locality request/release combo (d53a6adfb553 "tpm, tpm_=
tis:
Decorate tpm_tis_gen_interrupt() with request_locality()" and a5665ec2affd
"tpm, tpm_tis: Decorate tpm_get_timeouts() with request_locality()").

The latter results in the locality being released again before tpm_tis_sta=
tus()
is called and thus reintroduced the issue patch 2 fixed.

I will prepare another series based on the latest kernel but at least for =
5.11
the series should fix the issue (and also make interrupts working).

Best regards,
Lino

