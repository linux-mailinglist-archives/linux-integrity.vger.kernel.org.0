Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9E368868
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 23:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbhDVVEU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbhDVVEU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 17:04:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1CC061756
        for <linux-integrity@vger.kernel.org>; Thu, 22 Apr 2021 14:03:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a36so42625959ljq.8
        for <linux-integrity@vger.kernel.org>; Thu, 22 Apr 2021 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aAJ3wIqxiqvlLWO7wV14Gxdne6FOxL4p89moI9+JwaM=;
        b=Le2cwmRFqg0tNhBF8yyb98ti3+8Tx7DQ6AIZX+DqlqrvIOehpmd6KTW+o2YLvfmuIU
         HOWDpiEc9I7ZQR/qRq1IKWF1K8GAIFf5CtTKfR+sIs3GPl+8qla1Im8VX2+G8Ym6xJ9W
         jbFaNVnKN3/ziZLkZKOfJD/vRDjJPcHXcM284=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aAJ3wIqxiqvlLWO7wV14Gxdne6FOxL4p89moI9+JwaM=;
        b=Z8sZrGws2dmpS459t1buAUjKaCV86ZjeCYO0EodRLfwU4cgcSyIOOjv118dwsuBqHS
         NlQsaAZ7IOITOBgKEL9CBq61IgTul6jURz5gFv1PsIWGrs41yWUBJ2pTQAi35X/oAXyj
         +3gfCMxqmp6GnGoof4q4H1SO/Lh3kHjJQqn7HSRtR/Za8b3d6s8ajMztvHPia4xiXaXS
         J1+JFHFlKluTi5GQ1B1mi560BFdmYTEuJMW1cZ2QL3iMcQois+W4xIKA/T23WFdvPA0T
         abmXBtIJigTjdZy24kruuJE0jTiOlk9NvisFtAWvBIM0INcgm+sTARxN75aIjO9SyprM
         waSg==
X-Gm-Message-State: AOAM533vDY2vOteJO9eDqDB50P+5rWgyaF/cIxsqPhO1sYiLIiDMpEwR
        RqNTLe0wEXOvwBOTvCgqlDaoKO0ma/OpFsIh
X-Google-Smtp-Source: ABdhPJwVPxaG8LL/fFrLcwi/R10FDjSKWxNS6heq3QyiKFZ9GjFCmZbL4LjvlMkF5d20qHxLMFEPsw==
X-Received: by 2002:a2e:b165:: with SMTP id a5mr528175ljm.172.1619125421686;
        Thu, 22 Apr 2021 14:03:41 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u4sm376678lji.95.2021.04.22.14.03.40
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 14:03:40 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h36so20133032lfv.7
        for <linux-integrity@vger.kernel.org>; Thu, 22 Apr 2021 14:03:40 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr178740lft.487.1619125419929;
 Thu, 22 Apr 2021 14:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <3315246e429b385bbd08c8a509843e99dcc829e3.camel@HansenPartnership.com>
In-Reply-To: <3315246e429b385bbd08c8a509843e99dcc829e3.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Apr 2021 14:03:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLnjAaiXfbdNLtJYYyNLyp-Sz2_4XbfjTzKW7M8jzb3Q@mail.gmail.com>
Message-ID: <CAHk-=wjLnjAaiXfbdNLtJYYyNLyp-Sz2_4XbfjTzKW7M8jzb3Q@mail.gmail.com>
Subject: Re: [GIT PULL] KEYS: trusted fixes for 5.12-rc7
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 22, 2021 at 1:26 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I'm sending this in agreement with Mimi (as joint maintainers of
> trusted keys) because Jarkko is off communing with the Reindeer or
> whatever it is Finns do when on holiday.

"Communing with Reindeer" is unlikely except possibly as a euphemism
for "drinking".

The traditional Finnish thing would be to go to a small cottage by a
lake ("m=C3=B6kki") and relax while fishing, going to the sauna, and just
getting away from it all.

But whether that's what Jarkko does, who knows? It's not quite the
season for lake cottages yet - April in Finland is not generally the
most pleasant weather...

Pulled.

          Linus
