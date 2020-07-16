Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4503F222C1B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgGPTqD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgGPTqC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 15:46:02 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1760C061755;
        Thu, 16 Jul 2020 12:46:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w17so5174546otl.4;
        Thu, 16 Jul 2020 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6OA+KYTtTYhrznY+FK8Gsea2GSLV6mncL4lzWwEYIo=;
        b=HQXSTgtTxBOArnfn8NLuUGwGAggi0yMFvAGFoKqHGVJplD0Vw0pUQxjSeScUYmwXLT
         uXtUxNOz2hBH2oCVd2CwsousrwIK5LMsjv1uiV8JL4xLVJRt1KK+4UGpziiEgIIqYkPz
         YJr91j6UjnLe0lRwUgq2/IRLj86L6wKdqvJRadpk682Z+jKHSkuD65HlrC0n9qj/1JTA
         BKRTt7vIn8F06WYPBIfJ5bN8sXkmyp1M4sxvD4mdddwi0CVJBuHgvzqAWTSA73etWnEk
         mlCoIUWYD08GePjEHRKTyI89FEkrvcpVczFcuLnWSO0Bga7XXAavGy0/8WEH59pn7TY6
         wueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6OA+KYTtTYhrznY+FK8Gsea2GSLV6mncL4lzWwEYIo=;
        b=PkMVylyUPHCBV9Fvw4RA5XAraY73mlV6W+s0DWOvgyJ1HvQ4jG6DJ2cS6l9Y8DznCC
         Xx7XEz0MyeXCR8PfRp4MA3WOLm+aERpUcSJ+ep1mds5QA0llRpHQYQv2RpRHYTYOEhP0
         rOBqn7a57Gh83PIR9FNPSMWJU28jG8ke1oOjodOcsNo1VX7FIp36LNz20gTVKlGZD7dH
         SFaZfmKzhvAnBbWayhPWJsj3j6T0ECx7e3dQfkakpDL9omDSPXHzQraJLiPJLwRmCaAB
         tCbSW4gI271TPW5J0FAzoAgEx+dZ68Vgd5Mgl55/rP/bWhmdhjKFsO75IrOhKuRnPQzw
         jfqA==
X-Gm-Message-State: AOAM532LSwAdEin1lEsSh2Gv/rGNVgNUMSZ5OX/rdNu2ud1wjbRFNLPe
        EHvgpyvK46hPeZx9JwlmXLYoqVg9ocSCw8m5ejAYAA==
X-Google-Smtp-Source: ABdhPJw5KCHbUoFGz/oan+dqeFuV4tkua1xyOZlXVHrVDuSocUN9DJP6AjxPd/TUYmHyBmz/FUSWhKgx0eB966ZwcE4=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr6150730oto.135.1594928762258;
 Thu, 16 Jul 2020 12:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200716174351.20128-1-nramas@linux.microsoft.com>
 <20200716174351.20128-5-nramas@linux.microsoft.com> <CAEjxPJ43eXK0xgrE=gDxZVg2SDTz4bkd7N4otjk-cvxf3fKL-g@mail.gmail.com>
 <9478ddca-8298-5170-836d-8cbc7a070df2@linux.microsoft.com>
In-Reply-To: <9478ddca-8298-5170-836d-8cbc7a070df2@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 16 Jul 2020 15:45:51 -0400
Message-ID: <CAEjxPJ5p_T+C1NDz3iF7fvQzQAURpAcipvQfQXLZTfLP4Wiqbg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Thu, Jul 16, 2020 at 3:13 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 7/16/20 11:54 AM, Stephen Smalley wrote:
> > Not sure about this error handling approach (silent, proceeding as if
> > the length was zero and then later failing with ENOMEM on every
> > attempt?). I'd be more inclined to panic/BUG here but I know Linus
> > doesn't like that.
> I am not sure if failing (kernel panic/BUG) to "measure" LSM data under
> memory pressure conditions is the right thing. But I am open to treating
> this error as a fatal error. Please let me know.

Let's at least log an error message since it otherwise silently
disables all measuring of security state.
Also not sure why we bother returning errors from
selinux_measure_data() since nothing appears to check or use the
result.
Don't know if integrity/IMA has any equivalent to the audit
subsystem's concept of audit_failure settings to control whether
errors that prevent auditing (measuring) are handled silently, with a
log message, or via a panic.  If not, I guess that can be explored
separately.
