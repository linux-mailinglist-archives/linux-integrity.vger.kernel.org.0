Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A511CF382
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELLkW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELLkW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 07:40:22 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32562C061A0C
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 04:40:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e18so644985iog.9
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6I2nBaTdCMDd3hvG+KBjRfJdt5k5+1ubGaOtAwQk5k=;
        b=UdV18JUOBzhIMLSq2GVOGaUO7lpT4eaCx8zQDU2lJHSfb0U+A+FcptsDC+rzCQPXIa
         0KWhfObyGcaVoU61owIF+jvAzTkNEdiuD4N2mR42iICEKeiP2kK0I88TNGPCK8KmNu8N
         j8GXzlzthG89Nd4RDxvq/rHrjmu+0W/JnuP74cZ8v/vonFUJN8s3wNBOZV0xKwm/YBzO
         1t7Pbgz51JwYuUYkBB82Zgwc8+/cg6TdmAy/YUv2KjSHiBy8AnOzFo2ez99dK0Yfvm6r
         OlhPx7RQ5yazCrWIrBQk8/cvxyhg6imLRavkx0XP1oFo1/rkr9nAZGERjx69XDMjhe1z
         9RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6I2nBaTdCMDd3hvG+KBjRfJdt5k5+1ubGaOtAwQk5k=;
        b=Hz2ICtRWAR7t/BX4adDslu4WQFKs+y2Mb8W4/50yh4SBnNGYVOpcOXiOsJcCvs7iNy
         aElCvPiAamjVzdK8wRUnSU5ttCg0VGy6M7pxYtorPHsHJVOKbNkbxwmSEXmPID59gawV
         jQwMlKf4bxEyOBgQ2WPMDP0TxdO7+ZkEsG5MkXHxgZMqxIZj4eLbbsWXh6cTMW2Fpqdn
         Ivozgj17aRIIngCm9TCEHQzbQkr02BNOcPbbI9K6N/EswRDd9cuMii32c3aF1eC4QMq9
         HXM2ugI5PQlf6E7n9I5V0IV704Z5XiXTptAXjNSDCzjO6Pe5my1E+MzMxb+CPtFkvlCa
         j7mQ==
X-Gm-Message-State: AGi0PuZ3ubYrJKXGVzWlitfBko8/WSdtocur8VpA+oaOP6yqurLpqDmy
        kIVZ3V5jAH8p/Fe2Pj8S1xAkMPuVgkdGtEBhjuI=
X-Google-Smtp-Source: APiQypJrzFtnXhFOkFi0kUmpKg3B/1oVZ4dO4nu4CAnrn7h56jeyC5S0MJWuJG0mCBSNHv8+ikE2Vc+nDEQmDEUg+nY=
X-Received: by 2002:a5e:9703:: with SMTP id w3mr20412697ioj.111.1589283621510;
 Tue, 12 May 2020 04:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
In-Reply-To: <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
From:   =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Date:   Tue, 12 May 2020 13:40:10 +0200
Message-ID: <CANMwUkg+2O2nK8z38HZw6z0NdLUPwj40m4DPKmn1sf9oDqG7Pw@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        javierm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le mar. 12 mai 2020 =C3=A0 08:45, Ard Biesheuvel <ardb@kernel.org> a =C3=A9=
crit :
> So what functionality do we lose here? Can we still make meaningful
> use of the event log without the final log? I thought one was
> incomplete without the other?
The char driver (drivers/char/tpm/eventlog/efi.c), already ignores
efi.tpm_final_log
if the event log version isn't EFI_TCG2_EVENT_LOG_FORMAT_TCG_2.
So there currently no code making use of the final log contents on
those machines,
besides the two cases I patched which only try to determine its size.

I don't know if the table contains bad data, or just doesn't follow
the specification
and uses the older SHA-1 log format. If this is the case, perhaps we
could try to
support it, and modify the code to allow returning the additional
events it might
contain to the userspace.
