Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24E8226CD7
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgGTRGe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgGTRGd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 13:06:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882AAC061794;
        Mon, 20 Jul 2020 10:06:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h13so12784196otr.0;
        Mon, 20 Jul 2020 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ROcn/4oxIrk78fd7/QkF3w9hSG9pMZjyTBMvHwDSbjo=;
        b=KG/VGjb0jwqjCy5BWXom+BzCKDylx31g2oc2zPL17A0I6EEhvCfdtX6wMuTfvrjbYk
         UxISHlnAeUiXE1WIY286PhO+s0s8qm7TX0mwjEG7JPK4e7oL6hl0l/YfFIvTsL7pI5iy
         g93oiqPEh02NSSiPN4NcbjGf/2dwAwOk2thBqzt44Og+0/iaHm58tlOG0pmnH+xbsZ/Q
         1rQsdaxgpluAuCxq6hpOQJHC2mp9Qt7ymXaOUTN2guF41zbSZLJ0SRa8W6mtVMH6oN7m
         siuTrI60Vq0b6wDM2HkrlcZwUMOr2Ps9bzs8Z/mYiANS+9oG0Oup20ax7jkBwuJuekhT
         aCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ROcn/4oxIrk78fd7/QkF3w9hSG9pMZjyTBMvHwDSbjo=;
        b=YHsdgVZ6ETXz0x+kAoT9V3jRQUD+WSgMOHsDnKjh6gmVCrvHsqaWwTZUrCQVPjckIC
         nFymNqPJLT8HPGxGnE5CUdk4zO23I6lXWeVVUkOIDPj6ftYKoi5J4fC7wA70O4HxOFkg
         i3xRJpxwHj4zoieOeukmQVZR+5nDqGGbjbhgQ0ccvyDsrvkMcN+Gj5C2aQdz18hMtvLD
         wcNG5wWJeXCDF/pIqo/+iKw/WAW8QsBLYKpWAIwDGDcxaTaqFqj9UmBIJjtH9sGHOPIH
         YBgR1JrP9/BHiVUOH9czIKAix1Sj3ZzfAXHMFIpJ3Wjx4hDDaV8r4zHNMm+0tDzwZ4qA
         q0nA==
X-Gm-Message-State: AOAM530OspITy3WMhkM4q5YUAOqq2hckHVutv+XDia6EajlG/V0WwjkK
        ImsCK8NDcVQsdxeX+RRpi+L8V9NYaKcEypBE50c=
X-Google-Smtp-Source: ABdhPJwIO4T9YmBSwuhQPRydeECRZoEU1y8+Z0BHM67xgQtUU+iwA1lUMrRi0IgfGq+eD8drgLPJFHFqKbf4UGe2//o=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr21189050oti.162.1595264792757;
 Mon, 20 Jul 2020 10:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
 <20200717222819.26198-5-nramas@linux.microsoft.com> <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
 <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
In-Reply-To: <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Jul 2020 13:06:21 -0400
Message-ID: <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 20, 2020 at 11:17 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> Thanks for trying out the changes. Please let me know the defects you fin=
d.
>
> Just to let you know - I am making the following change (will update in
> the next patch):
>
>   =3D> Save the last policy hash and state string in selinux_state struct=
.
>   =3D> Measure policy and hash only if it has changed since the last
> measurement.
>   =3D> Also, suffix the IMA event name used with time stamp. For example,
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594
> selinux-state-1595257807:874963248
> 656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313=
b6e6574706565723d313b6f70656e7065726d3d313b657874736f636b636c6173733d313b61=
6c776179736e6574776f726b3d303b6367726f75707365636c6162656c3d313b6e6e706e6f7=
37569647472616e736974696f6e3d313b67656e66737365636c6162656c73796d6c696e6b3d=
303b
>
> 10 f4a7...9408 ima-buf sha256:4941...68fc
> selinux-policy-hash-1595257807:874963248
> 8d1d...1834
>
> The above will ensure the following sequence will be measured:
>   #1 State A - Measured
>   #2 Change from State A to State B - Measured
>   #3 Change from State B back to State A - Since the measured data is
> same as in #1, the change will be measured only if the event name is
> different between #1 and #3

Perhaps the timestamp / sequence number should be part of the hashed
data instead of the event name?
I can see the appraiser wanting to know two things:
1) The current state of the system (e.g. is it enforcing, is the
currently loaded policy the expected one?).
2) Has the system ever been in an unexpected state (e.g. was it
temporarily switched to permissive or had an unexpected policy
loaded?)

I applied the patch series on top of the next-integrity branch, added
measure func=3DLSM_STATE to ima-policy, and booted that kernel.  I get
the following entries in ascii_runtime_measurements, but seemingly
missing the final field:

10 8a09c48af4f8a817f59b495bd82971e096e2e367 ima-ng
sha256:21c3d7b09b62b4d0b3ed15ba990f816b94808f90b76787bfae755c4b3a44cd24
selinux-state
10 e610908931d70990a2855ddb33c16af2d82ce56a ima-ng
sha256:c8898652afd5527ef4eaf8d85f5fee1d91fcccee34bc97f6e55b96746bedb318
selinux-policy-hash

Thus, I cannot verify. What am I missing?
