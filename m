Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2C42D6D0
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJNKOk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Oct 2021 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNKOk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Oct 2021 06:14:40 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B64C061570
        for <linux-integrity@vger.kernel.org>; Thu, 14 Oct 2021 03:12:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j12so3406539qvk.12
        for <linux-integrity@vger.kernel.org>; Thu, 14 Oct 2021 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oQo6yErOE+kmZHKb3afvDHE//KFfa691F3oddahpj/Q=;
        b=Ci6qceUHs8aV2nKa1xl00vMeZLiCai2v0/1K4F8baxCeUJDuTx3hU0d1N5Pty7/w6Q
         trz/DkL10Te0cIPsYrmw3/IUTnoDCYMtEv8eY/MSca6Og1gbbFaf/uIqsQSQI/7IEUdQ
         jmJ9QW164TbpULlGgQumI6V/eDUv2kyvEBBvElZUNx/iUZmBd0vbM6dqStzEXOA0tMOb
         xcxA3tLkmDn/5xaqS2R74HlpOeSCec0BxVdy+suRU/M3gmupZfgqQJrxJgUGN6Xxwb26
         HtBA5Eo7NXNbfSNXPxlcrBbGGGIL2nAlYHukUb3w3s59YXJkGyyxb+QJvwBpwDelyto8
         9LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oQo6yErOE+kmZHKb3afvDHE//KFfa691F3oddahpj/Q=;
        b=MP0QDSdNoUvLbFPe45UxdKEH5oubRYvw8USqgX7iUCsotnt6Q8tdajlcGy/a2SiKjB
         X6ztD8d1yfLt6J8CMjgCSN5wqgDyjlE0ZgUno2suyuoLbZzTBf5Y6JGmHPDnPb+6IPnw
         S6wJQolV3pJK1AdUT+A1KyrX/bwxaoD//N29ZAMipO6xp5caJv/mHx6ykmBNJV2j8UpD
         fpmfHUGvTYjILs5+I+9P0sBWh3FBH8PlF/xeoQFUOFkj/hTEVGEHQDlwSHoBzuIHbxzp
         RYHfgxFaHB2SfWj5l2HrLIOpg6I6bVzbz2S9hr9CtHeUDcuLPQ/r+4YxTZXbvYiuroxY
         GM7A==
X-Gm-Message-State: AOAM530/JG5BdDQKlaGmhSo4dm/fTCzhY8fkO6ZVhFkXC7B/Lfu5uKZa
        NLeLraI9oorzq0E1qJm1Y1VoHUVkiOSUtfhZl34=
X-Google-Smtp-Source: ABdhPJwaL5A5CXHiOAfL/490PqRzzcdMdadvRm6ZdIjsSK5OenurG6+nA74JQrpBiw/KgpkI9ZTWuK97bNQ88P0QE50=
X-Received: by 2002:a0c:90c4:: with SMTP id p62mr4361918qvp.50.1634206354894;
 Thu, 14 Oct 2021 03:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABtpKGVtgwZbvX9j0QNB3FyZkT_LgwHWdpKYijULeBZ1Z+Xw0w@mail.gmail.com>
 <de9e081e-154e-03c9-c23d-b3e624910975@linux.ibm.com>
In-Reply-To: <de9e081e-154e-03c9-c23d-b3e624910975@linux.ibm.com>
From:   Denis Semakin <0xsemakin@gmail.com>
Date:   Thu, 14 Oct 2021 13:12:24 +0300
Message-ID: <CABtpKGWqH4K2pSZczgqAF1BMYTE+g1Nn+d2sePsjpJEU+RxiuQ@mail.gmail.com>
Subject: Re: IMA namespaces
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        denis.semakin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The new statements look very similar to previous. A couple of the
items are already under development.
What about new capabilities CAP_INTEGRITY_ADMIN and
CAP_SECURITY_XATTR_ADMIN which are mentioned in the first original
edition of "Considerations..."

Br,
Denis

On Wed, Oct 13, 2021 at 10:14 PM Stefan Berger <stefanb@linux.ibm.com> wrot=
e:
>
>
> On 9/1/21 8:00 AM, Denis Semakin wrote:
> > Hello.
> > A few months ago we started a project dedicated to single IMA namespace=
s.
> > Last years there were a number of patch-sets about this problem, e.g.
> > the last one was from  Krzysztof Struczynski. But no one patch-set
> > wasn=E2=80=99t applied to the mainline.
> >
> > Also there is a document (thanks Mimi) that describes the main goal,
> > architecture and design - =E2=80=9CIMA Namespacing design consideration=
s=E2=80=9D.
> >
> > As a result of investigations: Krzysztof=E2=80=99s patches were success=
fully
> > adopted for Linux kernel v5.10.30 and tested,
> > at least that allowed to study integrity and IMA a source code a
> > little bit. But that patch-set does not match =E2=80=9C...design
> > considerations=E2=80=A6=E2=80=9D. Then we may take all patches as a bas=
e, use
> > =E2=80=9CConsiderations=E2=80=A6=E2=80=9D as architecture description a=
nd start to implement
> > but it is obvious that it does not make sense without community
> > (review, discussion, etc).
>
> We are working on another design document, which is based on the initial
> one, that lists the following design requirements for IMA namespacing:
>
> R1 Each container must have the possibility to spawn an independent IMA
> namespace
>    (IMA-ns). Each IMA-ns must have the following properties:
>    R1.1 An IMA-ns must have an independent IMA-policy with
>        (i)  an initial default policy, and
>        (ii) rules that provide the possibility to cause measurements and
> appraisal
>            in IMA-ns child namespaces.
>    R1.2 An IMA-ns must have independent IMA-measurement with
>        (i)  its own measurement list and
>        (ii) the possibility to measure and log files accessed in an
> IMA-ns child
>             namespace per the IMA-policy.
>    R1.3 An IMA-ns must have independent IMA-appraisal with
>        (i)  its own set of keyrings and
>        (ii) the possibility to appraise files accessed in an IMA-ns
> child namespace
>             per the IMA-policy.
>    R1.4 An IMA-ns must have independent IMA-audit with
>        (i)  its own emission of audit messages distinguishable from
> those audit
>             messages of other IMA-ns's and
>        (ii) the possibility to audit files accessed in an IMA-ns child
> namespaces.
> R2 As an additional requirement host root's actions in an IMA-ns must be
> measured
>     and audited (in all IMA namespaces) in the IMA root namespace,
> independent of
>     whether the IMA policy enables logging or auditing in child
> namespaces, if there
>     is an IMA measurements or auditing policy in the IMA root namespace.
>     The same may apply to a container root user whose actions in a
> child-IMA-ns need
>     to be measured and audited if there is an IMA measurement or
> audition policy in
>     the IMA-ns.
> R3 An independent instance of SecurityFS must be accessible to each
> IMA-ns showing
>     the IMA-policy, the IMA measurement list, and other information
> related to the
>     'owning' IMA-ns.
> R4 A container's root user must be able to
>     (i)  load the IMA policy inside a container using SecurityFS of its
> IMA-ns and
>     (ii) sign files inside a container.
> R5 An independent vTPM instance should be connectable to each IMA-ns
> where the
>     IMA-ns extends its measurements into the vTPM's PCRs.
>
>
> Maybe we can discuss those until we can share the document with a wider
> audience.
>
>     Stefan
>
>
