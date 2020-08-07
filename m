Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4080723E511
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHGAWr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Aug 2020 20:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHGAWn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Aug 2020 20:22:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19377C061575
        for <linux-integrity@vger.kernel.org>; Thu,  6 Aug 2020 17:22:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so7583644wmd.1
        for <linux-integrity@vger.kernel.org>; Thu, 06 Aug 2020 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrwX/wfFzmOB6yLRhb7qEWgDu6TEjOMw7c5SuWROcuA=;
        b=JpfLO58DHRpIaearkFKOnrfvqBCUl0RamhydiUAyJKHTIjLYcYkw7jHOswLhEnvlz+
         42rMjdrWtq1srri4CwkYJOOZqz9/+yBOurDBNaTXbUNL7sGwOZSau9gPNwqlyl1D/7TE
         o5VG1NlGwBD81xYZqfeyR2hIsZ7Qv7Lk4Sk5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrwX/wfFzmOB6yLRhb7qEWgDu6TEjOMw7c5SuWROcuA=;
        b=HzrDLZVaJi7v9x7lrKpU5FuJ4zrA/w1Om4lT+J8lH17+jKNSf2eJBZPgxnZ42aQg3c
         5QMH5FNW7fjk3fbU8VXLA3ikPlPmlSRUxz+/O9HpDy4Wqhb6vm31Z/PtPTIMRjwTjmuK
         0dm9KeO9EOtY+unGp2/Tv4qbcSlAhHIvPiZr44yf3P8GsPl7d+vh653JEvMcyOI6ON1M
         nebVBOLN00BEdYqqIkwE7Bwp+jrZzfIDjX5qmO6eI/pYaOwY7OSsiuhAh/3fSZwL3u9U
         EzQusWtC5u6YJZU+3P62c1TzA+jCGfg4H6yFxpoYdPR669AQlA+ps/+zd7GqBkBjWuPy
         UBrg==
X-Gm-Message-State: AOAM532hmuCA1MkmmA6xXbFezXbieouAiSjexrIaD5gwF8+1P/qiJkee
        IarpLaw1x4paaIIUKDRCvqVTbaWaw62RC7869qLeVg==
X-Google-Smtp-Source: ABdhPJz2CSFYHBHps5lsYSSXi4LmfIaF9F6g3gv7J9WuzjjQKkuYj3RGkVMthT3YMgBgze8VgIBd8JCNOrPtY+ZUvC4=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr10198939wmj.56.1596759760832;
 Thu, 06 Aug 2020 17:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175845.1745471-1-keescook@chromium.org>
 <20200729175845.1745471-12-keescook@chromium.org> <20200805145342.GA22100@linux-8ccs>
In-Reply-To: <20200805145342.GA22100@linux-8ccs>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 7 Aug 2020 02:22:30 +0200
Message-ID: <CACYkzJ6dbUPydbg+HVt3toAPhgZAFut5Wt5OVckWMrKuPZ0ibw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        linux-efi@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 5, 2020 at 4:53 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Kees Cook [29/07/20 10:58 -0700]:
> >Now that there is an API for checking loaded contents for modules
> >loaded without a file, call into the LSM hooks.
> >
> >Cc: Jessica Yu <jeyu@kernel.org>
> >Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

Reviewed-by: KP Singh <kpsingh@google.com>
