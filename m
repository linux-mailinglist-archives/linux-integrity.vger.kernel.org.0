Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9197370683
	for <lists+linux-integrity@lfdr.de>; Sat,  1 May 2021 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEAJC1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 05:02:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:55959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhEAJC0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 05:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619859683;
        bh=PBKnn869NbbFhapUKErGOasK17EN1C5xgem9fGghJpM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kPpBybbb3OesfHBkL+LWVhc38wAGpcuJfs/tWDm5As1P2aDw5xYYVrr5HZnVlxPju
         va/3hERzzxx+p989cqQk97F55qr6kcFSbab4ZNiiLxAdPJT07ujV27oAu+Iq8TZ2hW
         CVvUVZDg/psBh9DZI0h9ovSqdqQu6ymqh6a4scA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1lrwyI1YiX-00KBoQ; Sat, 01
 May 2021 11:01:23 +0200
Subject: Re: [PATCH v2 1/4] tpm: Use a threaded interrupt handler
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
 <YIikDCTBcMMxjots@kernel.org> <495e816a-afba-4ea0-560c-bc748df26337@gmx.de>
 <YIpZH5TtEDA071EE@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <024acf60-47cd-5558-93d8-dcea9f063b83@gmx.de>
Date:   Sat, 1 May 2021 11:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIpZH5TtEDA071EE@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Wh1ARpQ2IOq9+Qbk3nBaPUf61Y0lkijlQ5IVidZ+2VG7wdJCbu
 dxvSGiBqNzeaFs2CrwDveNsF5g9fyCe7dOqS5XJsWwQQId3qs6fJbyqw0z6u2C4j2hMe45n
 g6Nha5/R7t852ryZNVlrA2iP5XRV6EIEkc+SPApOPJb+tf0cH8VKjDcclVzwjeGoGDMNXEa
 6sZdnBLJoA2QPLQK2f5yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vGNUkOTiDT0=:sI+qlAr/5K1B76rdXjG/Gn
 nlA5ZSAlDemHKxwDJhODz8e9CDD6pITOmgQyZG7HdZQ1mNKOzK6UAPcz021GFYSjSqawtYU5l
 f1VojoLyEzrVyQ+uolw9ipeac6M10AzQIiIC7x616kg7++yNgF6uoBtbojWPbhUUDLw7SGvBo
 KzZFL00YIUtJVWQZsuTcMrddphiJgWHacLXJp+4bxB6q4aHVRNyFaK3tV5tD91ctMtuWSAaXB
 /AoUVJGnwzS967gxofOYB/vlXTtuvdhDca72THYfZR+M8Wk0jnPTKJZtueknoAMTpo2EhGzCb
 Xg7/E2Fs+XvBkyIpiknUhDM0KiJjrD0tr4ymVOerhQ8sZADSSFfKgPWTyCMD3xy1Mv6lMZKDV
 ahPEktdAGWG2rbN9kQsaRvOJkB6ry/Xd1NYU9YBAHUka/M4Tna0ckVTxJRhawXWxF17htZkt8
 fdLM8fu3YtuC6gTXMjmg7s3594podpefADTXeqXNXCFFFnCR/aOdrvNM8d5733PF1Qjhx0bOS
 zx8yTcjfDXx5SlAvUi6NMGwAxkQg8IGhyYLuwRdMJU0VYypIAcmxEXTHZqQBjopBeUHcurwtQ
 LesDvDcvJOcicmKsjI00DArADA3lZ026Z8GYfD9WFIzygqrscU/KEKnLds4tewkiyYsVc8fBM
 I2xz507dSKMAOidLMIye2lpZV6vrKkdsODQztQvY7fyU0ct6r+q3y+RVHTWVvinz9Ft4+FwEl
 N3jvA86PQ21Xk7K/4zo/d/XUCyK4CaIwqVUgOYNfvVJ2kH8LXY4HeLX3NxRPY8kOi9NRDMvPo
 CCiJCFGhNOqo2ksQy27ebT+NveqbMqUoy15ePEu8wb00KR9WndKAkvrWDjVTZUvHc+ks0V3El
 lgr6/WcANk/LB9Fa83ZQvPttITkQTgO4Nl8MPeyfbYIgUm7oIR6IxOA6a3hbTPx2AkyohHSxe
 HZj6Vq40GEyzb0NR6D23ztOinIrYVjdDzZH9EBFT9AdC6dXCJERlodnI1c3Bs6XivuHDIT6aO
 Ma25U1r48TadsGvpasmO7cvdLpGwA0AYBX3/+Hir06vQcZDQbcGRovahZ8vobN2uCBq/mFuTV
 XPY7K/1RpBxYAAUHlF4yakHU/rPJ3XyCb0vLQ+VCWuKCitR6P3ruJEzfKy+cd06MkQl2usE5E
 VVryZkO4i0EZ+GWniEs/F90fqWSsJNLPvDl8DHiSJ86uLFiS9WdwtOocSTlBNuH4oMjN6x1QG
 8ojDyv6QOtDpt+85U
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



Hi,


On 29.04.21 at 08:58, Jarkko Sakkinen wrote:
>
> This is a sentence that you should delete:
>
> "However over SPI those accesses require a sleepable context, since a
> mutex is used in the concerning functions.  "
>
> It neither explains anything who and why sort of stuff.
>
> Why don't you put intead something like
>
> "Inside tpm_int_handler(), tpm_tis_read32() and tpm_tis_write32() are
> invoked. The SPI subsystem requires mutex for I/O, which means that the
> calls ought not to be used inside interrupt context."
>
> (I did not check typos). Generally speaking, commit message is as, if no=
t
> more important than the code change.
>
> /Jarkko
>

ok, I will rephrase this in the next patch version.

Regards,
Lino
