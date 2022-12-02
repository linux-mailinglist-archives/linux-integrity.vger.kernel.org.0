Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B047640433
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Dec 2022 11:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiLBKKr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Dec 2022 05:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiLBKJv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Dec 2022 05:09:51 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C12CCFD8
        for <linux-integrity@vger.kernel.org>; Fri,  2 Dec 2022 02:09:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e141so5459263ybh.3
        for <linux-integrity@vger.kernel.org>; Fri, 02 Dec 2022 02:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE3RHUY4qDJsuTo1Mm2gm/Dk1gjThhPaW9LXX2ZWWSs=;
        b=EPaBrLkZ4fkUP8uopzdMzRKYOxEwG5iHDTNXIJo6PgmsZRA1iyJoLIYSxqm2silPbP
         newFWO815fXH4pW6+LlOBAbMLwouTSaU0vTKvV/sJOBzWqo/1G8v/STzmF56u1Exm+AH
         aZ4UVCOu7TgFAM2r+hlUrtQOfkRp1XnEYX7eup1XBXJBTTRKaVdrH3DhCWsat7R90TGX
         iwR7K7HI4vZO6bkWLbtvGlTxlexPWlM93Y+wuXspHHmMw1IM85Zj/OOx98p+NHHZkzw2
         1oPbxzYORPuHQ4AWyG0tLc20X8uOiDPg6uo8c+9OHrdpOdfYyxVhyJEWAFRcgMWL4ETz
         D8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE3RHUY4qDJsuTo1Mm2gm/Dk1gjThhPaW9LXX2ZWWSs=;
        b=z3sJeuFq3jRlf/XDcpzR2QR8+GmFAGGXbYz47P4Soh5OtRukPxat7sHZ+tXOfudzLp
         yUXVt7gauJzlKmw7giGCUTp166jp72smVGpulXIjpAzc1+QeeQlh9LHkq96Vno7AWFv0
         dT4Ntb0pxvIy9OQPekUP0wbBngyPKeR5OSfxCGQwiNA4HRvL5R8AYeGVM0yO6erAX8I9
         U+1chEPb41N5Ur4Ete1cD8XdD+6NuESat2XTL8lyRTSwbnB7Xom4kaccTTJuRQg0iTYL
         teL4Zfg91oimeT0CtfEYxfeazGL3bgFyU3O9cz/ONal5838XRWP+yYeukise1KotUCG5
         PZRA==
X-Gm-Message-State: ANoB5plc36uFtwCox0mITu25/sXgIHcuF8N/mOqEVj7fphsFxHA3v7i+
        t8RsU1c9sGE2AcwzVLQ/m7jmB2cKz3WY+d87ZU7f+w==
X-Google-Smtp-Source: AA0mqf4qrHnBmItNuN2Sb8T6ME/Nzligux3z6GGs7/pyfkazZNenMyaJVS5oU7yFwrZZj6rTT6rkfz5IGFlDRxsKREA=
X-Received: by 2002:a5b:505:0:b0:6e6:6f6e:95ff with SMTP id
 o5-20020a5b0505000000b006e66f6e95ffmr47433566ybp.582.1669975789182; Fri, 02
 Dec 2022 02:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20221128195651.322822-1-Jason@zx2c4.com> <9793c74f-2dd0-d510-d8b6-b475e34f3587@leemhuis.info>
 <Y4nJe+XMoNwTVjlh@zx2c4.com>
In-Reply-To: <Y4nJe+XMoNwTVjlh@zx2c4.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Fri, 2 Dec 2022 11:09:38 +0100
Message-ID: <CAOtMz3P0e=8bR2RsxPB0EfsbW0CrvtasHOPgCRb2xQrr+m9yYw@mail.gmail.com>
Subject: Re: [PATCH v3] char: tpm: Protect tpm_pm_suspend with locks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jason,

Thanks for taking care of this!

Re 2/3 and 3/3 as you mentioned earlier, will get back to this when I
have some bandwidth and send it separately.

Best Regards,
Jan


pt., 2 gru 2022 o 10:46 Jason A. Donenfeld <Jason@zx2c4.com> napisa=C5=82(a=
):
>
> Thanks for handling this, Thorsten. I had poked Jarkko about this
> earlier this week, but he didn't respond. So I'm glad you're on the case
> now getting this in somewhere. Probably this should make it to rc8, so
> there's still one week left of testing it.
>
> Jason
