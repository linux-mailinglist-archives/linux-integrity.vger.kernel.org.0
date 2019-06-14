Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E41453D5
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 07:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNFNi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 01:13:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45960 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNFNh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 01:13:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so975205lje.12
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEcwvzDbZgh36sf0IDCKh8szy53wV/GjfhuFB+x9+B0=;
        b=s2taeimw3XvFPIL11YwD/5Yw5TcIPVUvT8+tgj8+2Zyh6SVTrHyyk/EJ/JCRhF//fw
         A+2S86fznNpPTwxq6Z0Bo5GwbrLr1ETUBE+fCUiWfHDy1ry0/FU40X1JPxwHJSHuXyNs
         cBnVNupPUiBNNCRN3y+IPUsKOnnTSZktQaPAjCRCitcR6kesm+/CYpQuV2lCmEz7xVus
         44bJ1huXCH/7TA4XaXN41ZX5NREeKaKbP5Kc0dvkrvA+KzT3qyTQbm4k5yQVfqsl5URy
         v4i22cjKfuvWrpRAt8la5w1JBjqVB2nGrhkF+DHEv6AlOQgyvmJ3+axF4XxaBBvqGaIR
         4wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEcwvzDbZgh36sf0IDCKh8szy53wV/GjfhuFB+x9+B0=;
        b=H3BZfDQjfgP6RW3edthmGmebY/fVmOc6B7BDomvKoqLb411A4jNig0EmM9Yxdpp0eP
         RbvTKvr/xur6MtsljBTmik651UXU7bStbmI4dOfpjhlJBU4NnMKhZCYxNqJvHfeNjxSR
         eFu9LwdGCBeRIfkcy/NhurIFNXk96wXEDfHyCu5Y9DJd6wn8m8lC3dJoG/6CWlowTLy0
         6kc9D6mnWMWyDGpw8Nbmz3/mnIPNpFc5JTkpOhcfZTynsSFLGEZRMF9jmwFab4MTGHOQ
         X4z75w4DTsjbquQ2NfmtEuHx/vhAZhe5j7hBPHjDuuItH8ghNTY1+Bz1WTpBJoxS8tql
         dcPQ==
X-Gm-Message-State: APjAAAXWsJrKsVAcjFQM2TzqkCeUEkvWEuuMVvcIqIjW8lR+T5iu22wN
        vGB887RTvKgzFQD4Ry+qfbjJxlvJxL56StU3TDRICQ==
X-Google-Smtp-Source: APXvYqyMLEhKd1WWY+BA07+pXv1UfARrC4yw3pAYgqbxqGyINCZlSFS8u3RnkH7fTLodB4y6NuAlY19vyYH/44JgWfg=
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr14940805ljj.142.1560489215802;
 Thu, 13 Jun 2019 22:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-3-git-send-email-sumit.garg@linaro.org> <20190613152003.GE18488@linux.intel.com>
In-Reply-To: <20190613152003.GE18488@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Jun 2019 10:43:24 +0530
Message-ID: <CAFA6WYOqMaLDBZSY5GYUc=p2GqtpujLfHo4OjqX83q-0aGD1bw@mail.gmail.com>
Subject: Re: [RFC 2/7] tee: enable support to register kernel memory
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 13 Jun 2019 at 20:50, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 13, 2019 at 04:00:28PM +0530, Sumit Garg wrote:
> > Enable support to register kernel memory reference with TEE. This change
> > will allow TEE bus drivers to register memory references.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks.

-Sumit

> /Jarkko
