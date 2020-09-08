Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899352612E6
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIHOpe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 10:45:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26130 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729851AbgIHO0K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599575163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=UVj/plKG6DRifmHMZTlUgfPoWrlDhO5hOcL37nFebFZBjBM2JajOpeMRZwFLK+9BMikk/E
        5xOawuMqdp4K0Kvxlk6KUe90Wou8YCbVFBJto0jBU9M58+ZkDLwBXaDZobqWA2E/hG1gpA
        gfUCoROtvep9rDbQpy5FpHT/R5xDupI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-ZsNtI8nUPyCquL483KHJIA-1; Tue, 08 Sep 2020 09:03:15 -0400
X-MC-Unique: ZsNtI8nUPyCquL483KHJIA-1
Received: by mail-lf1-f69.google.com with SMTP id 140so1974938lfb.4
        for <linux-integrity@vger.kernel.org>; Tue, 08 Sep 2020 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=KBtiXUSvNTiqY96S/BcF0qy5HiaJhUrauCIGVwL+KcoYOGtvnKNY9azOCTTTUdBRWE
         tqMYm42P9zPzbZ9Oku58TNLYxVLN7PMURAl1UHw4XIQlEEp18To7Iygn/r05qPXTwzFQ
         Ad6tZipJAHCfJ9dkBheNA2oJ4Se19g7D7lZCK7+6GEZZk0j/W6K/tPjUaPDZ+xuazZEW
         II3msOiDQdpoMqudopSx1LTItOVMFZdmU8i7yALK4TbLayggj0Ed6gW46NTDe8GgrICF
         v4YrOePrLxyvL1k3PgRcMLkG+oJsWRgQ7UKvmQCxUnAVb0WItXERMlV6p5V2CQb+/Cfl
         P1tw==
X-Gm-Message-State: AOAM530lI60kYzRf1OIcFFRjkQqdr0YcG1j/8xAhrx+Di7X0v7ioDgWd
        Oq3UJ/de2hpbDo2OeZPseaY8ZjwigZfqoQSTkJ/uvrbIhsMCtNgUyRYkDJMc8P4m/XRE5b+/UE+
        jyKInVhoLaOVsMhecNbNlpZMjcq53lg60LqZfxVAiqCzF
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002426ljb.337.1599570193916;
        Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3OiZVrw0QoBLOoEdLIlQNVVb0O6eJMGa3bo/IK9ijWF8Ck46zu6UhG+8IzfVZdlckAAhTWm3SSIT9nd2q7U=
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002409ljb.337.1599570193556;
 Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com> <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Sep 2020 15:03:02 +0200
Message-ID: <CAFqZXNtEywSumid=FHLysV8jaSPXDO--3YJC6DfuGwRRZLQ58g@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 8, 2020 at 2:37 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 7, 2020 at 5:39 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
<snip>
> > diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> > new file mode 100644
> > index 000000000000..caf9107937d9
> > --- /dev/null
> > +++ b/security/selinux/measure.c
> <snip>
> > +static int read_selinux_state(char **state_str, int *state_str_len,
> > +                             struct selinux_state *state)
> > +{
> > +       char *buf, *str_fmt = "%s=%d;";
> > +       int i, buf_len, curr;
> <snip>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               buf_len += snprintf(NULL, 0, str_fmt,
> > +                                   selinux_policycap_names[i],
> > +                                   state->policycap[i]);
> > +       }
>
> This will need to be converted to use
> security_policycap_supported(state, i) rather than state->policycap[i]
> since the latter is going to be removed by Ondrej's patches I think.

Based on my testing so far, even with just moving the array under
struct selinux_policy, the RCU accessing still brings a significant
overhead (relative to the whole syscalls it is probably negligible,
but relative to the rest of the simpler hooks it is about 30%), so I
don't think it is necessary to adapt other patches to it yet. It will
be my responsibility to adapt to the newly added code when/if I rebase
and respin my patch.

>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
> > +                                selinux_policycap_names[i],
> > +                                state->policycap[i]);
>
> Ditto.
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

