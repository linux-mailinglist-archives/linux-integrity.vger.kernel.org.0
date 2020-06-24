Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969DE2068C9
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 02:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgFXAH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbgFXAH0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 20:07:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8AC061573
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jun 2020 17:07:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so138029edb.3
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jun 2020 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYef0IlAA5cnvfvaD0Ws/jCKLqqDtLAVNioagh3fxFo=;
        b=t5sN2GgB6Vwi68B+oh29pa7pkMP4cZNgHjmADZPfF23wYRyavKOWBHEcL5ZtKvnGMN
         D0gsG07XLLr6RcEq1i+IusZ880iwgHJVt6zNq3yfL1xQXd1ji+IkRbTaWVXaKreilrBU
         T0T+/jcUySEfnlKYR1xW6pRMoIn61kJtnV6YBtcIrw/Wv/G0gpeN3jTnwI3jMfCF2Pju
         NtzFQBPyy2jQUttqO9n6yxiqn56vAwZ1IiByNO4vuGf/qa9bqndjoQCuaWmgqj3EZKar
         lOOLEjpBCETVEO2uSMlfhdUrjCp0WRs89LLvFfGTiOGG15dUpV8OkiPdACmTudaFOt8J
         kjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYef0IlAA5cnvfvaD0Ws/jCKLqqDtLAVNioagh3fxFo=;
        b=fTyzDApkpEj99vaomJrFrs4q+4svsJQnI/QHtPS/+m4HFiPPcNXG21Ck/oIti2R/s1
         t0YG+h/gZ4DhX52w40rBBZ5fpoCzBKmF+thlrwBk5baJIqcAy3ymy9HMs/jYAQwVn4VP
         Lwam7kXTPHn95vIsHxcx5xrf83kHAFnFHMqfcqSdLgNV2FTcRLOI9QbAj1MqdbGgUkij
         dxJmPZDKKLQpGWG/8knS6tR1DBfoX0J+FGJ40oNRWoZEBL0hc42ysWjvNgbm2CMyHGkh
         qqGJVzuSi1GJqCryJZeZ7km7NIE9rv9sxnh/MYjFnQAeRH6631yedA9JG79ujsGKwipR
         10Tg==
X-Gm-Message-State: AOAM530YQsaPKt+YZWPDgN+xaFD8GNSfz3WlmVjaNpiw+1Jhft9nPNvb
        uogzeDf2svvjDr4GEt/pB3IXVqyzdZri/Zqs0xnc
X-Google-Smtp-Source: ABdhPJxm2K+GHRjbkAJL7JkYWCiCsE49AHvZ3AgzIC+2MhsncYMq9OfsaBZK3cyOIwmZUZDbN96x/rMx2egaXaIUw38=
X-Received: by 2002:aa7:de08:: with SMTP id h8mr23618936edv.164.1592957244179;
 Tue, 23 Jun 2020 17:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200618211012.2823-1-nramas@linux.microsoft.com>
In-Reply-To: <20200618211012.2823-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Jun 2020 20:07:13 -0400
Message-ID: <CAHC9VhTW-M7e7BK3d-UKi6KuPo3=8wNzAU1hN3HDsw=B-CGxFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] integrity: Add errno field in audit message
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, sgrubb@redhat.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 18, 2020 at 5:10 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Error code is not included in the audit messages logged by
> the integrity subsystem.
>
> Define a new function integrity_audit_message() that takes error code
> in the "errno" parameter. Add "errno" field in the audit messages logged
> by the integrity subsystem and set the value passed in the "errno"
> parameter.
>
> [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=measuring_key cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0 errno=-12
>
> [    7.987647] audit: type=1802 audit(1592506283.312:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 errno=0
>
> [    8.019432] audit: type=1804 audit(1592506283.344:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=measuring_kexec_cmdline cause=hashing_error comm="systemd" name="kexec-cmdline" res=0 errno=-22
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/integrity.h       | 13 +++++++++++++
>  security/integrity/integrity_audit.c | 11 ++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)

The audit record changes look good to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 16c1894c29bb..413c803c5208 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -239,6 +239,11 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                          const unsigned char *fname, const char *op,
>                          const char *cause, int result, int info);
>
> +void integrity_audit_message(int audit_msgno, struct inode *inode,
> +                            const unsigned char *fname, const char *op,
> +                            const char *cause, int result, int info,
> +                            int errno);
> +
>  static inline struct audit_buffer *
>  integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
>  {
> @@ -253,6 +258,14 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
>  {
>  }
>
> +static inline void integrity_audit_message(int audit_msgno,
> +                                          struct inode *inode,
> +                                          const unsigned char *fname,
> +                                          const char *op, const char *cause,
> +                                          int result, int info, int errno)
> +{
> +}
> +
>  static inline struct audit_buffer *
>  integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
>  {
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..f25e7df099c8 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -28,6 +28,15 @@ __setup("integrity_audit=", integrity_audit_setup);
>  void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                          const unsigned char *fname, const char *op,
>                          const char *cause, int result, int audit_info)
> +{
> +       integrity_audit_message(audit_msgno, inode, fname, op, cause,
> +                               result, audit_info, 0);
> +}
> +
> +void integrity_audit_message(int audit_msgno, struct inode *inode,
> +                            const unsigned char *fname, const char *op,
> +                            const char *cause, int result, int audit_info,
> +                            int errno)
>  {
>         struct audit_buffer *ab;
>         char name[TASK_COMM_LEN];
> @@ -53,6 +62,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
>                 audit_log_format(ab, " ino=%lu", inode->i_ino);
>         }
> -       audit_log_format(ab, " res=%d", !result);
> +       audit_log_format(ab, " res=%d errno=%d", !result, errno);
>         audit_log_end(ab);
>  }
> --
> 2.27.0
>


-- 
paul moore
www.paul-moore.com
