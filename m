Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09D9243E9A
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMR66 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 13:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMR66 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 13:58:58 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E249C061757;
        Thu, 13 Aug 2020 10:58:58 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e11so5528554otk.4;
        Thu, 13 Aug 2020 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4q+Wr31o49gOBLsJFiOWZgVO2qtVCG5nZzCULshtek=;
        b=NICIimapC4xks9d1b1WGN9gFIbckG9/NSIarZxjqRA0Hk6P2HCPjk+f77hpXQrGn9q
         taEeHKuYlsZQbt9+ko31tELfwtj30a807GI96Vvu9V6r+K4uDZgW0J3yr1lPmjyWIayx
         HsSIR+xO+MX8O5wPWAUdxTy3GfbEtarqv0x2v08tMI5E4bM5l2e/C4L/1WtitHP4tC3U
         dKQkRlOoAWbg4VGsXfVKn9Owfdn9ZsUOIoYVU567XvlT68f+hmA+4zLAdt7OhdHKf/zQ
         ZAsa1uPeuAOvzm1lPs7CS/j+uQlj5ZQQLgy4GgwZbm3ZnfIPpWupaAPh81xQYx21rcG9
         ifew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4q+Wr31o49gOBLsJFiOWZgVO2qtVCG5nZzCULshtek=;
        b=opsZt2HLt/NCJBQxeSUku78nPcRcuJ7cPbV8opL/J57Yz4/W0nDgCElEFDAJIvDgh/
         RxjdwQ3+RlNB+GflToQ6PTqw2TY3hHeKjSrjqtQEll1Jyh+8e2pFwmn4uPYxkUhan3gR
         uw7qZVolODxJfk4IXpTUFt2/zjsxyDCrKr6uSCJp1ca5FcFEwh8SxjUWa3TzUjh1NCtO
         ZIb+MbxnV2f2rUDyoLiSuASLDf0qEJGO8ni4AS157+uSrm8zP6Bff1hi/Ev/O07hKI1l
         a5f/w5GWGLjON8bzgnn0iZC7dJTH8uX7b0VBW0Gtkk2HGZ7ZeRMxtUlSXtUMKkhpAI8w
         S7dw==
X-Gm-Message-State: AOAM533FIB66Sskj/JsaCNa0y6jm/9RaDhEgnUvLHIEchLF/vDYRbYZo
        W8XgZchnwMZ65s5bo74xxUH/lzn+o+SecYmmuEk=
X-Google-Smtp-Source: ABdhPJxB9IFGGJpCpA7o0FMlikVRIzRUmWUrrE6kAwcupxXeo+xO20t31/hfkgmbXGPY2ZeSxXOT7X3vjTGCp6vlk2U=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr5500387otn.162.1597341537454;
 Thu, 13 Aug 2020 10:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com> <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
 <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
In-Reply-To: <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 13 Aug 2020 13:58:46 -0400
Message-ID: <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 8/13/20 10:42 AM, Stephen Smalley wrote:
>
> >> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> >> new file mode 100644
> >> index 000000000000..f21b7de4e2ae
> >> --- /dev/null
> >> +++ b/security/selinux/measure.c
> >> @@ -0,0 +1,204 @@
> >> +static int selinux_hash_buffer(void *buf, size_t buf_len,
> >> +                   void **buf_hash, int *buf_hash_len)
> >> +{
> >> +    struct crypto_shash *tfm;
> >> +    struct shash_desc *desc = NULL;
> >> +    void *digest = NULL;
> >> +    int desc_size;
> >> +    int digest_size;
> >> +    int ret = 0;
> >> +
> >> +    tfm = crypto_alloc_shash("sha256", 0, 0);
> >> +    if (IS_ERR(tfm))
> >> +        return PTR_ERR(tfm);
> > Can we make the algorithm selectable via kernel parameter and/or writing
> > to a new selinuxfs node?
>
> I can add a kernel parameter to select this hash algorithm.

Also can we provide a Kconfig option for the default value like IMA does?
