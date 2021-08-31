Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27713FC7AC
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Aug 2021 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhHaM5Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Aug 2021 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHaM5Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Aug 2021 08:57:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1EC061575
        for <linux-integrity@vger.kernel.org>; Tue, 31 Aug 2021 05:56:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e16so14455291pfc.6
        for <linux-integrity@vger.kernel.org>; Tue, 31 Aug 2021 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=alZxIaoIDfxA+gB3N1wqbJA/fAEGksDbpqCRYJudRzo=;
        b=uP3LIlV7Ti14Ilm6Hh77TUy+WJ4Pg3CljRAeyizVIvPrSf/ChYb5qyIYlsWM5MXQ6Y
         wkGfi/VKI4GH6a/DEVJyJTfeyJ/gxE810xv7nvQ1300YQN5XpBOEA9rHgmPdCZnhVfjU
         HvNz6f+SOWEmU/bus4Ga0tU4hMQZPWImAqGuEml0D6BbQR9ka/5l0UB4D86xX9zHw/GB
         TmWq41NyDIT8z1sJ9eOK0m3/JfRkWf1nRwgE9rffWDdmaBjwsOL11ioSajjfWi7DWIbo
         AaO3hEJOGgYBM+C13nQzEwfXueH/eVGQ0VRmHN2KdOwWfiBlsZrwQEQ/RVZGAeGsKvO0
         05mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=alZxIaoIDfxA+gB3N1wqbJA/fAEGksDbpqCRYJudRzo=;
        b=lciE42ZbyqWEEaquVB7ualPWpeiqUo9HuUcv0ACe/ubxzFcyHIN8XYl6HnNgFLpBun
         C9Egk5Z00wYIihN1XIFk65tCT0aoodFkMOlysGajVWnFuhG9qzx35KNHOrPEoHV/plkI
         fJYvL/U1Zd9ph+GxWDQHtY8IXET5aLKzostgmK5raqAputsaVG7t9u7pe4H4VqXiwZ/R
         ffNzHdYNIYOHRgyxOIQX8vnMYrL1r9LaTeuDSb8aEOuyRvsKsfJokNljgJWJk+eVgQHC
         56cCEcc4n0+x4QxK8JH3jX9KnAOGOrzNbY+AEx7SzLxUIkSxAlCf0JkdEfev6HLyz7zd
         H75Q==
X-Gm-Message-State: AOAM532O78zMjl5Ur3yGdOn1Sk2l0D3PhVF7uRreqMT2lIFEat+mX5pF
        e9WrFyDTp/RfXwzQVDvRTfqKQCMrAgIvnfBlOPs=
X-Google-Smtp-Source: ABdhPJwsaBheRQduEx+jSx2QkFqIR5ASTMXm68D9HbJq1BBIaUHzZvqO+j76OY5Dhq94HXODGH+zP3Hcg2FCEySIMA8=
X-Received: by 2002:a62:8407:0:b029:39a:59dc:a237 with SMTP id
 k7-20020a6284070000b029039a59dca237mr28958198pfd.30.1630414580725; Tue, 31
 Aug 2021 05:56:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:261b:0:0:0:0 with HTTP; Tue, 31 Aug 2021 05:56:20
 -0700 (PDT)
Reply-To: wlsndvdsn@gmail.com
From:   Wilson Davidson <erickmapa007@gmail.com>
Date:   Tue, 31 Aug 2021 12:56:20 +0000
Message-ID: <CAE9Scd4G9BJQUkMCZ9EfjtfP3RX5iMB12nji9BgyOqmkc1PRDA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,Kindly be informed that this email that came to your mailbox is
not an error but was specifically addressed to you for your
consideration. I have a proposal of ($7.500.000.00) left by my late
client Engineer Carlos Rodrigo, who used to work and lived here in
Lom=C3=A9 Togo.  My late client and family were involved in a car accident
that took their lives. I am contacting you as the next of kin to the
deceased so you could receive the funds upon claims.I will give you
more details upon your reply
