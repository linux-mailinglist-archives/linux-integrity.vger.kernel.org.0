Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1079F1FA3B8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 00:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgFOWvh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOWvg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 18:51:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477FC061A0E
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 15:51:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so19275221ejr.9
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGExwC1aIDo5/1NE6vpBPs1NX4b+lnmovMgwaKLnO7A=;
        b=l/RMEuarijoX6QMHuCLRhoXP2m/8ECyX5qkJWulEPvmaBNqkJmtgVhU9oh9XxT0kD8
         ZGdGOhP8t5yCqKriDN+RcugCjQOpY4mugGL+wCtKQY04mKd5xFALSrdTBbpZtZd1aM5O
         XSPP/jC0I9loWrWofou4mTrW26jQzHcJr4ua6HmPieov8/I5Vx1/oM/LufaKhE8EzwsF
         f1JGgeY5bwBqH+flT2PO4oS3DyKGffbP+DWivck0nKtIuk50QQruQ3NwPwjCdaBx+n+U
         +jWlogpMo7eyj67zpKT42v8WoD8KM0ngA1qans4gH2lrDVCPm8SDXnTFVzkF04xuVGtO
         nvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGExwC1aIDo5/1NE6vpBPs1NX4b+lnmovMgwaKLnO7A=;
        b=JUQ3jn3+YKteuYDmjux/01vsZtcncEyeaTmTWs61+Ars6YdJ+enaP1jmUx/3mEZUkT
         dHvlB4SJS4E7MyFfLVTMfoZ3cR2i6lm1DMhGldDkStypollcCNshHgcfp9S5n4gOFztD
         qV/PTj2O9+Dqy9zmUg0l0mj7TEqVBPJur1OTA4DJgxgYXfPKZ+ZoyGbG1DXoRJSsKskH
         97gcyZECOMN4UAEls7hKSZ92y7gLi56tzC7EKCc84Uzx4b7xhgqEw2rwAAxMhb7vP9zN
         whCjkDj8343DSnRvK8QAx6oAACWrNmzMbaIw5tm00EDCyNYe6VWFbphgjkxgs6jjBla1
         3FSQ==
X-Gm-Message-State: AOAM5323j+U+S9GXb0kO+824vIuGs1ltzEMt9I7grXwAH5x5KKE2gCJx
        jS7LcAFsFQJ+RW4PF6ZODERN4geyGGA0Xl8V0xdi
X-Google-Smtp-Source: ABdhPJwx1DRTehCMO5F4dqY47teRIjLqnY3HxSm5d2M5fUhGXkw5h1uYR4YVOM7dFC5GGztogb3hEIyikdfe0ETfuBk=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr67681ejg.488.1592261493251;
 Mon, 15 Jun 2020 15:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200613022633.3129-1-nramas@linux.microsoft.com>
In-Reply-To: <20200613022633.3129-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Jun 2020 18:51:22 -0400
Message-ID: <CAHC9VhTmShh8ggdjLKf_ciL6fDt3ZH59BXaXMAgd8LFzqVj6rQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] integrity: Add result field in audit message
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, sgrubb@redhat.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 12, 2020 at 10:26 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> Result code is not included in the audit messages logged by
> the integrity subsystem. Add "result" field in the audit messages
> logged by the integrity subsystem and set the value to the result code
> passed to integrity_audit_msg() in the "result" parameter.
>
> Sample audit message:
>
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0 result=-12
>
> [    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 result=0
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/integrity_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If we can't use "res=" to carry more than 0/1 then this seems reasonable.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..84002d3d5a95 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
>                 audit_log_format(ab, " ino=%lu", inode->i_ino);
>         }
> -       audit_log_format(ab, " res=%d", !result);
> +       audit_log_format(ab, " res=%d result=%d", !result, result);
>         audit_log_end(ab);
>  }
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
