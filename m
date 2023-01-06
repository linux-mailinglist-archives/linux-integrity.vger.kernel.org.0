Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B716608CB
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jan 2023 22:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjAFVWV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Jan 2023 16:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbjAFVVp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jan 2023 16:21:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35EB840BE
        for <linux-integrity@vger.kernel.org>; Fri,  6 Jan 2023 13:21:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x26so1987176pfq.10
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jan 2023 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nscYWIrRbImg5p/QoRk2LSGrqlyTf2VI1IplInec8Wc=;
        b=OFMqJwDh4LPlA8Zz0KkW+6L0lbDp5CBZT442htKuEMpSYVMwigNk/wZNJ/o4hBuaFh
         ajmV8QQVjaoo5threYy36tdtqt1EhF9E/zt71sO8JeN61VKNPFhixgkgl/eltSBtaFkD
         mjk3bqGc5Nnb4VCF32DJ5EmUwQsprMpdIsTJAq/GAIcvAHfhhxqBaVHcLN4YHWNHJc87
         PIIbKEX/IeSAMbdHXkLSrbhTALuSspTTs/2+rG7mOYc1S/yOB4NR2FKJyMTm/L1S5sMG
         rgT4LlTO+ZI8onf3a0CGKwe9b5KovL+jO7iWAPBiZaG82cAt3hksehXJrTae7Gp6bFnj
         HioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nscYWIrRbImg5p/QoRk2LSGrqlyTf2VI1IplInec8Wc=;
        b=b0XioMv/2Af9OZzUeQiWQWk0UNLemd5dFFBfioaM9dczVU18x3R948DFZ3kdGLQKLF
         KHtVH0Sy3bgGFH1CSkDadFRfrwQtT6ezllaE2TOGQTMNrzop69rJi6TEl/Y6hWJ63xfj
         9lrO8YdwMu80hu1QdhGKNX8VvUw8Xa/ftOLISI9d6LCcsNse2mK8v85WkLfhGjySrHE7
         hGu5j/vkUBmuGWTfxf1wF8jaDx8HDoWgsrTHfuejgiF0F6jic9DLrJwT4YXULHTd0fqO
         tFyS9WRFtmh4C8hyiGra1om8jK+UBUaqkVjDFM5PFFrfvAA4wB46gRiFWVSGrkoZrruY
         CFEA==
X-Gm-Message-State: AFqh2krWpRTWQrDtIt//rNl48iPGqkANywbosbwt0gVtxCA8g0Beu3xK
        /0MGj8XzQhGEhHG7iAWJW5mJj3uh9fSgaUY7sv8n
X-Google-Smtp-Source: AMrXdXvkkuKmNAQAxLd52KKekhGg5ivFAYkK2Xs/NEmo0uPlOMRrJOs8uvswb1oxToVMHYh+Nap64bsEhlypn23a1Vw=
X-Received: by 2002:a63:db51:0:b0:477:96e2:9065 with SMTP id
 x17-20020a63db51000000b0047796e29065mr3301051pgi.533.1673040096986; Fri, 06
 Jan 2023 13:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20230102204525.4399-1-rdunlap@infradead.org>
In-Reply-To: <20230102204525.4399-1-rdunlap@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Jan 2023 16:21:25 -0500
Message-ID: <CAHC9VhSGTKKbQkhjQcpfYxsh=9z-TzrWaiiGmNWqt8jAgD8xKg@mail.gmail.com>
Subject: Re: [PATCH] ima: fix ima_delete_rules() kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 2, 2023 at 3:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use correct kernel-doc syntax in the function description to
> prevent a kernel-doc warning:
>
> security/integrity/ima/ima_policy.c:1964: warning: expecting prototype for ima_delete_rules() called to cleanup invalid in(). Prototype was for ima_delete_rules() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  security/integrity/ima/ima_policy.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff -- a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1955,7 +1955,8 @@ ssize_t ima_parse_add_rule(char *rule)
>  }
>
>  /**
> - * ima_delete_rules() called to cleanup invalid in-flight policy.
> + * ima_delete_rules() - called to cleanup invalid in-flight policy.
> + *
>   * We don't need locking as we operate on the temp list, which is
>   * different from the active one.  There is also only one user of
>   * ima_delete_rules() at a time.

-- 
paul-moore.com
