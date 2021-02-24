Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B43240D8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 16:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhBXPaD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Feb 2021 10:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbhBXNuF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Feb 2021 08:50:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B58C061574;
        Wed, 24 Feb 2021 05:35:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t11so3091709ejx.6;
        Wed, 24 Feb 2021 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E35Anx43LiPy05GsYti9BfkgPBUJtvGhlU3qclOt8K4=;
        b=Qzae4gSdEODSQi/0QwqZBX1N+d+1Ib4hCbF6In4F2pJulVBJpk0rGiziSFVGIdtjk8
         wPdM97UUjXVmXu7WCjrzvIKG6GNshOfKbNcJHHzjfRFzfNGT9X2/q/vf9s2+HlrMOqtG
         BKAsdvevRzsxTgebyrfSG50JZtn+SiJa7Oa5ErIyySLihTr1vQzJtYh5/POtBBTwd+85
         o2lY3ydtCPE6mJIP30PuPJ7rKrPq4If5DKW+e0hJl9iCRuuqwTkg2GD8CjKTj8DZDn4R
         OJzrmHpNuG6j6SMvPe5VfA0SEZi5ynYd3SbTgN14yt/lxLKM5Y4niPwrdDBGL1axb4Yi
         lUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E35Anx43LiPy05GsYti9BfkgPBUJtvGhlU3qclOt8K4=;
        b=qLzkaXJT1Mor7hAQzMl/J5vREpManaMonSpZ44uP5Y+to5E6UiTCfKLrxadB2F9cZd
         JfyY2TqVdfG/P0KJ0D4zllJdffgMCh8kKgWa4YWG0w8jSZEWd1tOdJizJlSaLg71o3tZ
         FcTYknwwXofAzL94GSlfME/Mksw79Dpc6W7sZvJEzOwvWC31F8z/OWjk3iDdp57dko79
         J9nvOJ8Y/gq/ikzKufn6bjwn4gkNxCwXI7DQSkosQkb3DGMtiKytXI1bDqGuWQJOnOi+
         iDySdEwffSlOQm8mKvZEe64wYnpvxYLT0GhfaWs6X9lOxsVGWAI1yLW+pWXOemYQnuOe
         Ycug==
X-Gm-Message-State: AOAM533umbrn2hgvSAO8uI3EynAv+s9qtEleFaXQqWd+woufm78n7P7H
        1HpBZj3ZGaTAgqGr7/rn0flWU5aJwhVRzNn1tfbv49ddzHTlbEEt
X-Google-Smtp-Source: ABdhPJxdMG2w1tsGLAuwbXPxnUmA4TgmD+z8b3xwM7YVdIXnRFUmhM43Z/M81Vo2uxFwX106MXuGz8xFNSblmgKZlBU=
X-Received: by 2002:a17:906:e0cb:: with SMTP id gl11mr19893581ejb.87.1614173741708;
 Wed, 24 Feb 2021 05:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
 <20210222175850.1131780-1-saulo.alessandre@gmail.com> <2e829730-bb0c-47eb-70f2-731c184eba33@linux.ibm.com>
In-Reply-To: <2e829730-bb0c-47eb-70f2-731c184eba33@linux.ibm.com>
From:   Saulo Alessandre de Lima <saulo.alessandre@gmail.com>
Date:   Wed, 24 Feb 2021 10:35:30 -0300
Message-ID: <CABcgGGjc63+b+yp_bsVran5JKTBgLrOh-hoY0zcdoFbr_tTB1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] add params and ids to support nist_p384
To:     linux-crypto@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Em seg., 22 de fev. de 2021 =C3=A0s 17:26, Stefan Berger
<stefanb@linux.ibm.com> escreveu:
>
> On 2/22/21 12:58 PM, Saulo Alessandre wrote:
> > From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> >
> > * crypto/asymmetric_keys/x509_cert_parser.c
> >    - prepare x509 parser to load nist_secp384r1
> >
> > * crypto/ecc_curve_defs.h
> >    - add nist_p384 params
> >
> > * include/crypto/ecdh.h
> >    - add ECC_CURVE_NIST_P384
> >
> > * include/linux/oid_registry.h
> >    - reorder OID_id_ecdsa_with_sha1
> >    - add OID_id_secp384r1
> >
> > Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>
> I would separate this patch into an x509: and certs: part since it
> touches two subsystems.
>
> I can take this series of patches and post my v9 including them at the
> end. This would make it easier for others to test. I would massage them
> a bit, including the separation of the 1st patch into 2 patches, if you
> don't mind, preserving your Signed-off-by. I need to fix something in my
> v8 regarding registration failure handling. Let me know whether this is
> fine with you.

For me it's ok.

>
> I had tested your patches over the weekend with my endless test tool
> creating keys in user space and loading them into the kernel. It worked
> fine for NIST p256 & p384. Also signing kernel modules with NIST p384 is
> working fine.
>
> So, for the series:
>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Regards,
>
>      Stefan
>
>

Regards
--=20
[]'s
-----
Saulo Alessandre <saulo.alessandre@gmail.com>
