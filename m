Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13281F5F9D
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKBqE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Jun 2020 21:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKBqD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jun 2020 21:46:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8984DC08C5C2
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jun 2020 18:46:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so4748898ejc.3
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jun 2020 18:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEHCpF8ZKQcSmRp+P4kQatevjs0uu/nGZLZrcoIwtHQ=;
        b=C9SRsieomg7I2Hje13ggvgYK9Bx+nO/t2i90fDMzIC2Dx7WlKprXZdpbbgXSZw4kbh
         pOGc2aQrvC20sdyMZE+YLCbjggzSpUfH9xW1gJAu9883j4EdRY+Q9hEhTB3z2ns8GJZY
         aPhfHx4q9v4FXp8iDxt8m1MavGz/ObZ4eRX5fOaMSNNQbxypwzVDfpch0ZUx+u6IxFmX
         XdmbziqHB5V/KNydZtPTWpd5kKpEmxLu+9MXUOvpI35uGXOfakM7qd+wngGXkhlMteEz
         nL1qVq6lFQRXlGXAwKbTuFIxflP4K2CI0LEMlDJvQ1WjSYa9O6IrLAl2gkUWFYuT2MBt
         43CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEHCpF8ZKQcSmRp+P4kQatevjs0uu/nGZLZrcoIwtHQ=;
        b=fx4UbqFtRw+t69WpYN4x0PrHozje+NVtefWXgAK7PvIQzT5SVUR/N2OCwRZq/WEs0O
         x5BalfHzkjCAiTMPRL1Cf0LjTCN883bXWlJC/hn5X3tHziagbR5sKqhBitjZJu6lmxHf
         g5izw3BHw0iAaGkkI8+2R3CC72XNrDu72/KgkIw3yFRxmOy2mQF08Fno5LNJv9i4ucd8
         MlT1Zhu32kD+W+owqxpt9QDEef707HX314523UuTc7lxHlLmgRmGqiUEbBW+T/nyMLHL
         c5kJM5Nz6y9mvxxkTS+sxp5AztuRnMxcIe3DuCbUCEH5bmQBDfUJFUXFaPsCFo93sqkJ
         R65w==
X-Gm-Message-State: AOAM531/IRW/H+VDjrmsMoixpCNfzKrT86ou1PwsCgUgdrSB05tWItu0
        cRg0z6fuaaaMlO2PJ16i9YLXA8VzL9JrW+3YPWI0
X-Google-Smtp-Source: ABdhPJycVLpo0VWLE6JHhJuZOgmlhZARe6uwX9dyxxNulxXzwt/RSBw8W5r9ZVz4dWJkx6MaaESuYp9LOSP8ywyUBuM=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr5919376ejb.91.1591839962038;
 Wed, 10 Jun 2020 18:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
In-Reply-To: <20200611000400.3771-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Jun 2020 21:45:50 -0400
Message-ID: <CAHC9VhTZb_evUcdygs6MHP73Bi_r3esxV6+Ko6VDpncfmLYEZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, sgrubb@redhat.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 10, 2020 at 8:04 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Error code is not included in the audit messages logged by
> the integrity subsystem. Add a new field namely "errno" in
> the audit message and set the value to the error code passed
> to integrity_audit_msg() in the "result" parameter.
>
> Sample audit message:
>
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry errno=-12 comm="swapper/0" name="boot_aggregate" res=0
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/integrity_audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..8cbf415bb977 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -42,7 +42,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                          from_kuid(&init_user_ns, audit_get_loginuid(current)),
>                          audit_get_sessionid(current));
>         audit_log_task_context(ab);
> -       audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
> +       audit_log_format(ab, " op=%s cause=%s errno=%d comm=",
> +                        op, cause, result);

Hi Lakshmi,

I'm sorry I didn't get a chance to mention this before you posted this
patch, but for the past several years we have been sticking with a
policy of only adding new fields to the end of existing records;
please adjust this patch accordingly.  Otherwise, this looks fine to
me.

>         audit_log_untrustedstring(ab, get_task_comm(name, current));
>         if (fname) {
>                 audit_log_format(ab, " name=");
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
