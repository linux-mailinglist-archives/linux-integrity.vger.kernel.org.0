Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C37A0F74
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Sep 2023 23:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjINVFb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Sep 2023 17:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjINVFa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Sep 2023 17:05:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC132700
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 14:05:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso24074361fa.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694725524; x=1695330324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi4VUf4gJCA6NveynZh2FFW5elFrdjQW2bjMwJLkbzQ=;
        b=ey/GtXJ3Yxkr5e4iNZ9BQW4/bv+umESZXuIPtXGsD5YEcuraeY+O75RoJelFkqViJr
         jPfZIaReTkFElezODBuC1KydwK5ayTpuM5tazwLWrY5CrutUyhmUUOH0oNMauObHhDpp
         IpRrphtMC2KC649obRKX/n34D/xrlcrFnl1es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725524; x=1695330324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mi4VUf4gJCA6NveynZh2FFW5elFrdjQW2bjMwJLkbzQ=;
        b=SB19NQlFay184TDYMtF3kGNeyq3I+yFeEqCdgyYupSF6bzTdo4ltwVVpHuwNg4bJTa
         kOnmZ2M2RBYkadazy9IWXeVg0ihaAAqwJy7JgyGqJLSBhXVfiNv3qpfHQFeO6fJs6Asf
         psqEDxGBg5Aw3Lh0nu/DnPwiWonP3CxrnemnI6OvaPGakcmO+y5EN4XJlSdqZlJg1gUS
         A5DWyWRpDnE6MOqBia9DFpJbGNDFfsNvW4JFjLkAgei3HIajYteBrrFNbAtTKlh/bp6T
         aIMfoIrJXXM52BaHtLd06xFrLSDk1bfZMGAjp6aCg5b+EaqwpJjjEKk++6dZJGZXBmQy
         Gs+w==
X-Gm-Message-State: AOJu0Yz+bp1e0bYlroF26YEtvXVrVOXeZTTfS5tVJ4RY1xtjZm9pnEpO
        mTF59fC6gIHNYQ53Ij8Pe7SBzXJN/FxJdN7ckgO0xx6G
X-Google-Smtp-Source: AGHT+IFFkGOLOjwSKpL2YGJQMt6i3XMFMY7SAkXsvctiK9hmkNB2kDVwngBTY+Y3wZ/MS5qkHzK6Tw==
X-Received: by 2002:ac2:5559:0:b0:4fb:9469:d659 with SMTP id l25-20020ac25559000000b004fb9469d659mr4538863lfk.23.1694725523915;
        Thu, 14 Sep 2023 14:05:23 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d8-20020ac25448000000b004fe1d770527sm404022lfn.309.2023.09.14.14.05.22
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 14:05:22 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-502e6d632b6so1987313e87.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 14:05:22 -0700 (PDT)
X-Received: by 2002:a05:6512:3703:b0:4fb:8f79:631 with SMTP id
 z3-20020a056512370300b004fb8f790631mr4518877lfr.46.1694725522393; Thu, 14 Sep
 2023 14:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912201102.1012306-1-jarkko@kernel.org> <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
 <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero> <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
In-Reply-To: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Thu, 14 Sep 2023 16:05:10 -0500
X-Gmail-Original-Message-ID: <CAFbkSA1vh+PS7HxhdZ2jLer4ZPQJWTsSU5NEAwJW2Rp8CZwzZQ@mail.gmail.com>
Message-ID: <CAFbkSA1vh+PS7HxhdZ2jLer4ZPQJWTsSU5NEAwJW2Rp8CZwzZQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 14, 2023 at 4:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 13 Sept 2023 at 12:32, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Ok, I'll make something more reasonable.
>
> Well, I took the pull already, just saying "tpm fix".
>
> I assume the only thing the typo actually causes is printk's with a
> typo in it. Maybe some sysfs name will be wrong?
>
> That's the kind of information I would have _liked_ to see in the
> merge message, but I didn't then delve into just where the class names
> might actually be used.

Sorry, I should have been more clear. The typo causes misnamed sysfs
files, which breaks some userspace tools.

Justin

>                Linus
>
