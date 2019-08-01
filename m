Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE987D989
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfHAKkl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 06:40:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43669 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHAKkl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 06:40:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so49869251lfm.10;
        Thu, 01 Aug 2019 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isUGmEYOLpjEg3jfVYEfLLyDXZizpluoarkdQOeJEco=;
        b=e7zESjZM2/wzjwmiWWWbSAsTWhAV77ru/rCVx4JUymN/53sRSzBFQXud45X8Dr61zK
         sqmwE48x+NwYk2Cj06PSvNDR8EAL73UGkym1ZfUF++xJXuhNMPXz+ZbmblOckb2EDibR
         hn6TqYNEl4I925P779zb0qgrYlBYkGxknrNhHKo6jUgsDvnooc9DJ8mSJdetEzKQzfIu
         yGRZza/lQjKJDFIMW4HrtW4SNKRhMMEr9D67Icb79a0oMCaE2HtXRxR5M4RhrEn5SpKM
         a576UQfrDmvM2vsFwwi7Yxa0NJUzNBsNMxHNw41zLHW1yIPJgW5/e35MPiKmD1Qk/tSb
         zgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isUGmEYOLpjEg3jfVYEfLLyDXZizpluoarkdQOeJEco=;
        b=ocAW3vNpNejlf8c0y698MOcyJuojw2geujr5OI8EZf8JixVMH5BGYxyF12OwheKIUr
         FTkdTfoVZjrYAQL6lLfV8xkuHqGIc/iMpZpVLlt3/G8K2a8OuhouDCchfXqv1C8P+dsd
         Zet/ZJ0cIQSfEO8PU9iF47fqCK9jcvbKzlbzGLkdcrjgFbU5maowA9KThaHBi4VpCbGc
         2xh8w4QFQSqKfm0c1HP/Lse5r4w5kFs7HdDXpVRCMS31VWfrjBTkcGB8JxnURvRAvKP+
         QarxpIYxLhb/Bz+SMCtaKJqZ24UyvFuxi+VZcheCsLlaZmPr7uHMGqwUDCV2qchzCwIc
         chkg==
X-Gm-Message-State: APjAAAVpPfQFmrrocYYUn3tEzDYHhy5pR6AJwrLW++aj5K8MBLqchcvZ
        fLMKoKL1ZfUbOrA4QSy8DD5B9YmUQv4xYWyeyXU=
X-Google-Smtp-Source: APXvYqzBC9Gdh1FFxLOeL/OcODPMG8H50PClL/jL6/hOC+Ro8fVfZSKCPuosp/rXDAuw8uu1AiQV5PVAqbOPMwJCVac=
X-Received: by 2002:ac2:5181:: with SMTP id u1mr10511367lfi.42.1564656038513;
 Thu, 01 Aug 2019 03:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAE=NcrY7b8eTTovOszBhGhVbjfJAXoAYehiUJyPENGfwWoVcPw@mail.gmail.com>
 <CAFA6WYOEqe1a1DCyVYKA+oZaZ0n5hnjxdubstUnrwdUW1-4xHw@mail.gmail.com>
 <CAE=NcraDkm5cxE=ceq_9XkQz=NZ6KdVXkNUsdD4G2LrWz-bpDw@mail.gmail.com>
 <CAFA6WYMOXQbL5OeheFUFpTr8gte8XHHr-71-h8+qX0+R_sekDQ@mail.gmail.com>
 <CAE=Ncrae6pM+WBDu9eJ7Fw2Fkvf3_YqH5tj9Tt938D4RtWcdSQ@mail.gmail.com> <CAFA6WYOwcO5-cyaJf3tMMAdyVHJo=BzmCWtsjA3S8aj5g-GZxQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOwcO5-cyaJf3tMMAdyVHJo=BzmCWtsjA3S8aj5g-GZxQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 1 Aug 2019 13:40:26 +0300
Message-ID: <CAE=NcrY7zA1OkKwpVrPbPd+c0OymZeAgT2hp6xZ3HQOgbXaZjg@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 1, 2019 at 1:00 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> > > Here TEE isn't similar to a user-space crypto library. In our case TEE
> > > is based on ARM TrustZone which only allows TEE communications to be
> > > initiated from privileged mode. So why would you like to route
> > > communications via user-mode (which is less secure) when we have
> > > standardised TEE interface available in kernel?
> >
> > The physical access guards for reading/writing the involved critical
> > memory are identical as far as I know? Layered security is generally a
> > good thing, and the userspace pass actually adds a layer, so not sure
> > which is really safer?
>
> AFAIK, layered security is better in case we move from lower privilege
> level to higher privilege level rather than in reverse order.

You can look at this in many ways. Another way to look at it is that
the services should be provided with the least amount of permissions
required for the task. Further you can containerize something, the
better.

As for your PLATFORMS support: it is all nice, but there is no way to
convince op-tee or any other tee to be adopted by many real users.
Every serious user can and will do their own thing, or at very best,
buy it from someone who did their own thing and is trusted. There is
zero chance that samsung, huawei, apple, nsa, google, rambus, payment
system vendors, .. would actually share the tee (or probably even the
interfaces). It is just too vital and people do not trust each other
anymore :(

Anyway, enough about the topic from my side. I guess people will tell
what they want, I'm fine with any, and it is all progress from the
current state :)


--
Janne
