Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6172AC025
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Nov 2020 16:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgKIPo2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Nov 2020 10:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKIPo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Nov 2020 10:44:28 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C1C0613CF;
        Mon,  9 Nov 2020 07:44:28 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id y197so8288314qkb.7;
        Mon, 09 Nov 2020 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F11XWqHBkNs2G7N10KYRgvOsa+l8J0ZMIfdZaFwpxL0=;
        b=tV/G4/nKXC+vpSdtZQGn2yFncbijp47eVjDEJkY7SxySB1EuUgxPxVSXeLIvVDxatM
         w26l2+KWvyrfgHH6FGrxrlDa5N6sFm/o+LqkZ4eoez8jIcqkTf2Gzy6sxP3Wdh3Ael84
         RKwVzQE1ORPzx1/xysBt/vVj46flUFB13ucK3P2J67YSiyC/HapntfOo6pd9vsWF1lwy
         Vml3+bTUsn26+Zdi23ADwh1MnxBb4H9LTpgn5yhAFWkfYQltuj0cd88bhcqxfB3XP/aw
         AzV4fz1r5AYLKBvuRaCcZtFhQuhoXtBYWMf8IR1Uk8BDe3Xs/xqwBUDnKbcIVLscQACm
         6QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F11XWqHBkNs2G7N10KYRgvOsa+l8J0ZMIfdZaFwpxL0=;
        b=QeGJenlPNSlBoz71/2Z4EBdeYanT0vMdLrCS8q3qqiWzbJZOUW5RnTvw2oZctSXx6d
         6wyy6cNeKHZWj9CfjIPN5thsn0zAt6eRObLH0indMscUvrfwgNUOvv7YN81/n96aycjB
         YwDJvdLSkHslqDx7bu5QI+hIGju9+mmZJNYsLffobyg+MvqhoFV1y6xDA0VCsy39gbU1
         QMCM/UItTvRKyU6q1KdHd+rOAcbJRAVJF/zMSt26NQiTDjktO8/BeQHBlST9aBlruPBa
         t6h5N7Lat00cPQ3Rvv/wXjB/avNZhETowoQ//UN0Yn0v29ZqwByXHF67zq3dWZV5xS9x
         Rp+w==
X-Gm-Message-State: AOAM533tS2PQ6C+1pJZgOEmHM/O+vZMTBrN7s68r3RUgcykrPfJy/Xd7
        woL5caB98mamFRb+daFYxkokYwANQo7S2ApTlFFNj/tjv4izuw==
X-Google-Smtp-Source: ABdhPJzPjpm7yJ8DWaA96wDB1v7XhVSeHu4S+wDOr+zVKb6173ksFJUqJypqrddEfxmqfbGrJVJO6NllcW0CEDBPb84=
X-Received: by 2002:a37:f503:: with SMTP id l3mr13099138qkk.160.1604936666800;
 Mon, 09 Nov 2020 07:44:26 -0800 (PST)
MIME-Version: 1.0
References: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
 <28afd683-8423-0331-4b7d-ec71d46be30c@rosalinux.ru> <CALUj-gtyVJ9nLYWYbX2Oa9=dcCYqc2H0RkO4HQcJKj2ejAfSYg@mail.gmail.com>
 <bdd1becf-c72d-876a-cd9b-cef7b6fe55e9@rosalinux.ru>
In-Reply-To: <bdd1becf-c72d-876a-cd9b-cef7b6fe55e9@rosalinux.ru>
From:   rishi gupta <gupt21@gmail.com>
Date:   Mon, 9 Nov 2020 21:14:14 +0530
Message-ID: <CALUj-gtQsSnU0Yq5Syc7aOkN0PH_MHvziuuG1-9zotVUAJ2QoQ@mail.gmail.com>
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

On Sat, Nov 7, 2020 at 3:45 AM Mikhail Novosyolov
<m.novosyolov@rosalinux.ru> wrote:
>
>
> 06.11.2020 18:50, rishi gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Nov 6, 2020 at 8:42 PM Mikhail Novosyolov
> > <m.novosyolov@rosalinux.ru> wrote:
> >> 06.11.2020 15:22, rishi gupta =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> I am getting below error as selinux is denying access to the .ima
> >>> keyring. Looking for guidance for asymmetric public key selinux
> >>> policy.
> >>>
> >>> [  172.014855] integrity: Request for unknown key 'id:87deb3bf' err -=
13
> >> I am getting the same error without selinux.
> > If I make selinux permissive, it works for me. So I know in my case
> > the problem is selinux.
> >>> [  172.015035] audit: type=3D1800 audit(1604596570.579:240): pid=3D82=
5
> >>> uid=3D1021 auid=3D4294967295 ses=3D4294967295
> >>> subj=3Dsystem_u:system_r:mydaemon_t:s0-s15:c0.c1023 op=3D"appraise_da=
ta"
> >>> cause=3D"invalid-signature" comm=3D"mydaemon"
> >>> name=3D"/usr/lib/libstdc++.so.6.0.25" dev=3D"ubifs" ino=3D14353 res=
=3D0
> >> Selinux context is just logged here. It has nothing to do with reasons=
 of ivalid signature. Public key seems to be not loaded.
> > Basically when we access a file, driver checks if selinux allow access
> > to it or not. In my case this function is returning -EACCES
> > https://github.com/torvalds/linux/blob/master/security/keys/permission.=
c#L88
> >>> (a) Do I need to set the selinux context of file
> >>> /etc/keys/x509_ima.der. If yes what it should be.
> >>> (b) Do I need to set some selinux rule for .ima keyring. If yes how. =
I
> >>> tried a lot but could not find any resource.
> >> Usually IMA policy is loaded before SELinux policy I think
> > I am using the policy defined in ima_policy driver as of now. My kernel=
 is 4.14.
> What is "ima_policy driver"? How does selinux and IMA policies get loaded=
 on your system?

For test purpose I am using "ima_policy=3Dtcb ima_appraise_tcb" in the
commandline.
I have not changed anything in the policy defined in 4.14 kernel driver for=
 now.
https://github.com/torvalds/linux/blob/bebc6082da0a9f5d47a1ea2edc099bf67105=
8bd4/security/integrity/ima/ima_policy.c#L132
https://github.com/torvalds/linux/blob/bebc6082da0a9f5d47a1ea2edc099bf67105=
8bd4/security/integrity/ima/ima_policy.c#L88

> >>> Regards,
> >>> Rishi
