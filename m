Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04A61FA1A2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgFOUcL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbgFOUcK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 16:32:10 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFCC061A0E;
        Mon, 15 Jun 2020 13:32:10 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d67so17120235oig.6;
        Mon, 15 Jun 2020 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLVfcRpFW5Aj6KKAQq0GdGr+kv8j/Al0S7eZSYFMCko=;
        b=Iv/YrP4AHCQnhLjL010QvvMb7F5ILf7ZlURh1XuurOztBybIWm7+vT4F1FCdp5YGJw
         LoUvT3tFzO39ulQWYgPzAjV7ifE9IPTxG/VCBz5nFu0whlpYUX363uFx4dfT3kxWhY3R
         bmvxY1qArH9Ds8G9cly1KSeQrbxujb3gPr1w97BO3N+OkwuwtiMcp1hTV5fLt+YVd6N7
         NMRRkvVHUM20EJmfMQ8KopEgT6yu3nWKOO9pdnT3h9L8qoGGEBckbpmmPRyofPJzPNfq
         f2KCVsnTVn0aPG21HaiTQbk3tDeK37oH9w03FxtpBWkfrOq14AmxHIGd3uwvZGAb+wI1
         kH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLVfcRpFW5Aj6KKAQq0GdGr+kv8j/Al0S7eZSYFMCko=;
        b=N0GtXjpbkK4AHPXgUzAv9CytdlSRDhVg6K1s8oRyfRs+u7vG8NMOfBZSdTiwYepQC7
         Y3N3PtXWew3pQsiSviZiH0xj6HEMnafaOluedBN7FMUMLwc0pm1XpqxUmvB4NW5LhJI3
         3Zm2DBiJvhdEsaiGorOGOkFdXOFeOHF8Rj12wX4hDctmfPGT+b0izjv5ICJgRVh21ZKq
         BsBy/JvszRM5s1XwG5bQ939yUPYMGND90GLgwGHFew3HbSp+QDiSkiSNJBjxIHe7eLAr
         60Jj7UsuXOFgnbfyU9UiifHlz+W0vT7H3JJMi2+uoS1ECGfLAGOgQJE/y9Kc+7Ohnfzb
         pn0A==
X-Gm-Message-State: AOAM530JuzH2bGfhI+74PMgd78Axn6n6xD2HLLpRPQaVe3dxtjMRd9yO
        87mp9YR8pKGkdtDy/IHCgitZuHcEZ7iPqJ4lYXU=
X-Google-Smtp-Source: ABdhPJz6ExPhgMpFvKG9huRF6CgiiBVYhjKG3knTw0lTw9MHxqKR5uKJizKcQnMpxo+QKMaO+HwKyVnBA/rD/sJlHAU=
X-Received: by 2002:aca:3283:: with SMTP id y125mr955658oiy.140.1592253130159;
 Mon, 15 Jun 2020 13:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
 <20200613024130.3356-5-nramas@linux.microsoft.com> <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
 <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
In-Reply-To: <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 16:31:59 -0400
Message-ID: <CAEjxPJ4nD-3cNQHp8wjdL=_k3opjyU+zc9xCPZkOjkTxDN6g9A@mail.gmail.com>
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 15, 2020 at 12:45 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 6/15/20 4:57 AM, Stephen Smalley wrote:
> > I think I mentioned this on a previous version of these patches, but I
> > would recommend including more than just the enabled and enforcing
> > states in your measurement.  Other low-hanging fruit would be the
> > other selinux_state booleans (checkreqprot, initialized,
> > policycap[0..__POLICYDB_CAPABILITY_MAX]).  Going a bit further one
> > could take a hash of the loaded policy by using security_read_policy()
> > and then computing a hash using whatever hash ima prefers over the
> > returned data,len pair.  You likely also need to think about how to
> > allow future extensibility of the state in a backward-compatible
> > manner, so that future additions do not immediately break systems
> > relying on older measurements.
> >
>
> Sure - I will address this one in the next update.

Please add selinux list to the cc for future versions too.
