Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3C2A98CB
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgKFPvF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 10:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFPvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 10:51:05 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EE6C0613CF;
        Fri,  6 Nov 2020 07:51:03 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id k9so1444308qki.6;
        Fri, 06 Nov 2020 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bq7XuOEfuXc9Pxiu4FSTXLphcTRNZb2mSIHK6qtCQCk=;
        b=mjrrY/TrHBNzxRXT+iKjtSkQbp40fh8bKyd66ktkoad6y6tAByVGWnxZ+FY6No0qx3
         vT6wtFQuaLecSBlLycrzJBUL7WqATxAZ7ic9YyApNlLcVdryQRdAdG+9b8lGo2Z5t88S
         QDiEzYoGIPvny3erZomiwAwMQjKbJezmLNEd/EW6BUwQyXJZwZl97pWiHHz8mqssanDi
         97qBJEBtUeJ0fSRTbwRqomNKmf69p860hhs1sVti5dveyoWC4FWKvlOaCamOfX/taweH
         qghfF+eczISUp/3jUKbgLA7mgWXZ4qi1DhWmHN+5WZ+ETsH2Oe6sK32F18v19f6JbwI2
         qMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bq7XuOEfuXc9Pxiu4FSTXLphcTRNZb2mSIHK6qtCQCk=;
        b=bwu4wIz81ZHps1MGAsYmMpjnmtaztQnGUdJ7eJiyTtnRzN1qrTBlgvEV2I2gXzFJcR
         ZgzCmp844l7GfSC3kBJwOUvKs1ey8Ha/hry8uhyzTbzRI0APbCMYYDLv/nzDPP4qQJx3
         A3rXKTXJ3qqCC87KMLTjVBwND2XgWoMmGznI+zZET7gF+bP/rKNkOYWazsTx3jqTRAXf
         EaJ6REwamg2WlLYi7hICgTQ+9gATaQGH6/lx1sBS1SIlMbYb4u7VSmb0tiRE67Y4Aki2
         7zoj2tBWbcz0CcJzZj6G0ZYFESuV64MwCqVFSb8ycHMDbvSiqtpyIepnrIYA/UYQCkM8
         8xJw==
X-Gm-Message-State: AOAM533d/Y6FOaOb19siHMRL0BD4M+v2Kgt7mq8B/mWfR5ivPdh0Vjvs
        koWlb7aJ0pB+n8ixknJPFzk/r1RF1yZR9Ezp2T9HFifPRn7PJA==
X-Google-Smtp-Source: ABdhPJwvVQaAyMIixz5y+7TlHbDQDNXNbgp4yP0UaGtTJ102N6nTPA6OVmXdZ93NXzNttLn355empaQ58Upty7VQmbY=
X-Received: by 2002:a37:4f0b:: with SMTP id d11mr2243897qkb.74.1604677862404;
 Fri, 06 Nov 2020 07:51:02 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
 <28afd683-8423-0331-4b7d-ec71d46be30c@rosalinux.ru>
In-Reply-To: <28afd683-8423-0331-4b7d-ec71d46be30c@rosalinux.ru>
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 6 Nov 2020 21:20:50 +0530
Message-ID: <CALUj-gtyVJ9nLYWYbX2Oa9=dcCYqc2H0RkO4HQcJKj2ejAfSYg@mail.gmail.com>
Subject: Re: Selinux policy for x509_ima.der public certificate loaded by
 kernel during boot
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 6, 2020 at 8:42 PM Mikhail Novosyolov
<m.novosyolov@rosalinux.ru> wrote:
>
> 06.11.2020 15:22, rishi gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I am getting below error as selinux is denying access to the .ima
> > keyring. Looking for guidance for asymmetric public key selinux
> > policy.
> >
> > [  172.014855] integrity: Request for unknown key 'id:87deb3bf' err -13
> I am getting the same error without selinux.
If I make selinux permissive, it works for me. So I know in my case
the problem is selinux.
> >
> > [  172.015035] audit: type=3D1800 audit(1604596570.579:240): pid=3D825
> > uid=3D1021 auid=3D4294967295 ses=3D4294967295
> > subj=3Dsystem_u:system_r:mydaemon_t:s0-s15:c0.c1023 op=3D"appraise_data=
"
> > cause=3D"invalid-signature" comm=3D"mydaemon"
> > name=3D"/usr/lib/libstdc++.so.6.0.25" dev=3D"ubifs" ino=3D14353 res=3D0
> Selinux context is just logged here. It has nothing to do with reasons of=
 ivalid signature. Public key seems to be not loaded.
Basically when we access a file, driver checks if selinux allow access
to it or not. In my case this function is returning -EACCES
https://github.com/torvalds/linux/blob/master/security/keys/permission.c#L8=
8
> >
> > (a) Do I need to set the selinux context of file
> > /etc/keys/x509_ima.der. If yes what it should be.
> > (b) Do I need to set some selinux rule for .ima keyring. If yes how. I
> > tried a lot but could not find any resource.
> Usually IMA policy is loaded before SELinux policy I think
I am using the policy defined in ima_policy driver as of now. My kernel is =
4.14.
> >
> > Regards,
> > Rishi
