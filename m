Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3B1FD6D9
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgFQVP2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFQVP1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 17:15:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD06C06174E
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 14:15:26 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so4143866eju.2
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2020 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aF2QFHszBUveBEYuZ4El0wMTZ2oyuOvfLY0YCwJErgY=;
        b=WlXbj9ju55dGjHRzLb5C+A8WJ5rU77z376DVpc11si+Mfk0mgl/SUv0GjXDMTXTPU8
         fkUT4YuEl24pt0ed8H2rwHxZmwl+0En+63ihMhy6iz1uo1YOJOvbn2kgp6I+oeDe0cL+
         vrKCnZo8IFvhrHmrIOp3beUH7vYfUsZg+zPRk/xHGsG5Ltlg73jB9l3leAp6Gazgra1G
         Q1l8GejBcNKrpCet0IlhxN5hE1ntYGvElCeF9qBiPymC/Yyp7XGcu+jhviej5TLXWwTK
         bCtFSc518u83smtBb6UwaDe8klytUX6DaGAmo/MTPVi3nU+F3w9WqyVROlmEw7jPu7/b
         VCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aF2QFHszBUveBEYuZ4El0wMTZ2oyuOvfLY0YCwJErgY=;
        b=iixUBjZ4+SDXal1ssBrKDu33v/mXuCfXxwL6pbs77GUwKYCORVYJLjQo+XXYw57pGu
         eHT703cDUaGAUoVPnfhXeZg9bDyK7E88ICLY2b1Tg/GUt4oEhZ+0Vp0X5+0Upq6HmsuT
         0tuc6u55BiA/o9q7OpZrzR95nwVn8dw2ZIUxv9h54i+0pjJNQ1eVAmi5FZc0X4yuJ8fn
         XVFmJ2qNOo9tlcGh5vn2qSre+MyV7I3uyIs8dJsa7u+zwLa22FC9queywZGLiI9ygBqg
         pHZtDzny5S0bOFSQMVNRvVr11bbnhMzzbdXQC1UIUaVBUbL4ypLzSU4mVJVO4083JtRQ
         cOeA==
X-Gm-Message-State: AOAM530DYWflJD7rNHgh34Ux6IbUt87mdXq3Q5GS8HHbGsu07/mKOuNU
        ciRyS96cvfQtItGBH2Uo27r9icbII2o6ETKkd26p
X-Google-Smtp-Source: ABdhPJwpQGCuUs9iFPAHM5LwSxMut1A4ihpgUz0qV9wJycHjByfPFJfNofYDt/VmT8F/+Bwr1wIS1cgTIhYY6STDwXU=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr1003538ejb.91.1592428525325;
 Wed, 17 Jun 2020 14:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200617204436.2226-1-nramas@linux.microsoft.com> <20200617204436.2226-2-nramas@linux.microsoft.com>
In-Reply-To: <20200617204436.2226-2-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jun 2020 17:15:14 -0400
Message-ID: <CAHC9VhTUd1N_W3Axr4PRt2qe56YfxeRiX17hqTnGJrJPVYNRWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] integrity: Add errno field in audit message
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, nayna@linux.ibm.com,
        sgrubb@redhat.com, rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 17, 2020 at 4:44 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Error code is not included in the audit messages logged by
> the integrity subsystem. Add "errno" field in the audit messages
> logged by the integrity subsystem and set the value to the error code
> passed to integrity_audit_msg() in the "result" parameter.
>
> Sample audit messages:
>
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0 errno=-12
>
> [    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 errno=0
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/integrity_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..a265024f82f3 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
>                 audit_log_format(ab, " ino=%lu", inode->i_ino);
>         }
> -       audit_log_format(ab, " res=%d", !result);
> +       audit_log_format(ab, " res=%d errno=%d", !result, result);
>         audit_log_end(ab);
>  }
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
