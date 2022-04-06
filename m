Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132A4F6648
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiDFRAJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiDFRAC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 13:00:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35093CDB66
        for <linux-integrity@vger.kernel.org>; Wed,  6 Apr 2022 07:23:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bq8so4587237ejb.10
        for <linux-integrity@vger.kernel.org>; Wed, 06 Apr 2022 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MSq8BRFJdjzhbIUWwVzTf9cp5VRLdJQGSKxEJP82+cg=;
        b=atkG5VJ/exTpitx1mzJ00ZRzmnHLJ8AtSgRAinAP7WoM2RJ4a7dV78PtHqsvAqrLYt
         u8GD6GJ9eLq1x1wRuQRD25EEVjjnu7tFFzN6OXVdLIj5oIQINUaES72cNs5vnRFr+PCv
         ILzQzmRB1EkTyAU2Q9XUX/p8sOaRwdrdoNaR5OVO/lJQjBBiyvF0dfxwD7MjvTnqM3ck
         DQiYe2cFkfnctie+sXqKIzPxNMSOPbU6Fy8XFcif3DUc8N8WXse9pPvPgehmsTxyRL4B
         IYpZ7PmsbPHPohuVwPDCZ77hFWel4clOJNQJrXtIlI+MNX6oZCqDazB2BXuaOgkRbGyp
         xRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MSq8BRFJdjzhbIUWwVzTf9cp5VRLdJQGSKxEJP82+cg=;
        b=kMXlp4GALp4TjSwnzHFGUNblKEqFQPlryuECVpvLBJncj66s0nDv7qcaCmVYjtBZUE
         XqdimiyKW6tjR0PGgJzxnj4pcDTYKcP37b096iakMo3xtCRHNusIXUH9b4EuQbgJuQug
         aF9QV1PKKFAuYaOsWGzs9QzuBtuVaAuLgdCROwtSjRIF68oOadHPRTT2uDhqUMb4cjDv
         UWqC0UGle5RmMuIdsJ3r6KgLH0leSjRMjzkOC8Fa3Q73znvKbFuHGB0Sq9S8TG+AbTrq
         0op8XEhhLxtvP66PSVQuX5HgvnWVBJUH3E23yCtSBphf/7zWvctA1T6STt1L7yJ5xAPN
         q8og==
X-Gm-Message-State: AOAM532VMIIZve5gq5G5NWa3gupUcok6WPbv1puc7R995jwemkOe1tm0
        VY4ro6eFq9/Q9KsDAvU6PYAELbW4EaHEnenBan4=
X-Google-Smtp-Source: ABdhPJxz18ixmDxSg+vjvmFrVVPSV5gayAFd1jUkWiLqfXb+dXqTHTmfZ2wlvyC3myZfR93k1E4l0iUcOHEZF9aHn84=
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id
 cr21-20020a170906d55500b006db148e05ccmr8314937ejc.63.1649255037129; Wed, 06
 Apr 2022 07:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpNFcP+bNHrrEPD=2bD25GGFu3BQmTi+Oen6_josJauA8wbyA@mail.gmail.com>
 <CAHpNFcNtokSx2sxA4bQBe_i8VKd=HXnUMrj8hDQwr9CwsJfGCg@mail.gmail.com>
 <CAHpNFcPmWHzDBtiwLD3tUi6eH35NsYfmR=sDUAP1QQs4AguPjA@mail.gmail.com>
 <CAHpNFcPPKLwgVuJe137S-Vt78Zkn617VZduJ-q6BtJwvFgLRng@mail.gmail.com> <CAHpNFcNM15KHnh_kusJ0Qzoqnb2KGOvrUe3Z9_gvknv1p2=L6Q@mail.gmail.com>
In-Reply-To: <CAHpNFcNM15KHnh_kusJ0Qzoqnb2KGOvrUe3Z9_gvknv1p2=L6Q@mail.gmail.com>
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 6 Apr 2022 15:23:45 +0100
Message-ID: <CAHpNFcPW_q2xrb1RGbWtZ_5LxVSKyW3PDYo0u8uCUYrr-UTBbA@mail.gmail.com>
Subject: Fwd: Display Stream Compression Support - 3D Mux , 3D Mu-X by GPU &
 CPU though SiMD & AVX 32Bit IfNotOR to a Singular planar Frame Buffer
To:     "ebiggers@kernel.org" <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Subject: Display Stream Compression Support - 3D Mux , 3D Mu-X by GPU
& CPU though SiMD & AVX 32Bit IfNotOR to a Singular planar Frame
Buffer
Date: Wed, Apr 6, 2022 at 3:13 PM

Display Stream Compression Support - 3D Mux , 3D Mu-X by GPU & CPU
though SiMD & AVX 32Bit IfNotOR to a Singular planar Frame Buffer

https://lkml.org/lkml/2022/4/6/401
https://lkml.org/lkml/2022/4/6/541

*
[PATCH v7 13/14] drm/msm: Update generated headers Vinod Koul
  [PATCH v7 07/14] drm/msm/disp/dpu1: Add support for DSC in encoder Vinod =
Koul
  [PATCH v7 09/14] drm/msm: Add missing num_dspp field documentation Vinod =
Koul
  [PATCH v7 06/14] drm/msm/disp/dpu1: Add DSC support in hw_ctl Vinod Koul
  [PATCH v7 08/14] drm/msm/dpu: don't use merge_3d if DSC merge topo
... Vinod Koul
  [PATCH v7 03/14] drm/msm/disp/dpu1: Add support for DSC Vinod Koul
  [PATCH v7 01/14] drm/msm/dsi: add support for dsc data Vinod Koul
[New] [PATCH v7 00/14] drm/msm: Add Display Stream Compression Support
Vinod Koul
*
3D Mux , 3D Mu-X by GPU & CPU though SiMD & AVX 32Bit IfNotOR to a
Single planar Frame Buffer is logical in the case of Multi Window
desktops,
A Blitter Frame Works well for X-OR.

The relevance is that a Single Frame buffer per Eye does 3D Imagery!
(Google Glass & MS & PS4 VR)

We can and will need more; For this Substance Called Flexibility we
need 2 Details:

ReDirectable DMA & Multi Frame Blitter...

By this method we can literally write every detail if we wish in
Shader, But we do not need to worry!

X-OR Blitter Recovers from Overwrite by detecting details that are new.

Simple is best but keep in mind that CPU Frame Buffer (In RAM & Cache)
& GPU Frame Buffer (in GPU) & Direct Access RAM : ReBAR to
Transparently access GPU RAM!

Allowing ALL.

****

Vector Compression VESA Standard Display protocol 3 +
DSC : Zero compression or low level compression version of DSC
1.2bc

Frame by Frame compression with vector prediction.

X-OR Frame Buffer Compression & Blank Space Compression:

X-OR X=3D1 New Data & X=3D0 being not sent,
Therefore Masking the frame buffer,

A Frame buffer needs a cleared aria; A curve or ellipsoid for example,
Draw the ellipsoid; This is the mask & can be in 3 levels:

X-OR : Draw or not Draw Aria : Blitter XOR
AND : Draw 1 Value & The other : Blitter Additive
Variable Value Resistor : Draw 1 Value +- The other : Blitter + or - Modifi=
er
*

Vector Compression VESA Standard Display protocol 3 : RS

SiMD Render - Vector Graphics, Boxes, Ellipses, Curves & Fonts
Improve Console & TV & BIOS & General Animated Render

Vector Display Standards with low relative CPU Weight
SiMD Polygon Font Method Render

Default option point scaling (the space) : Metadata Vector Fonts with
Curl mathematical vector :

16 Bit : SiMD 1 width
32 Bit : SiMD Double Width

High precision for AVX 32Bit to 256Bit width precision.

Vectoring with SiMD allows traditional CPU mastered VESA Emulation
desktops & safe mode to be super fast & displays to conform to VESA
render standards with little effort & a 1MB Table ROM.

Though the VESA & HDMI & DisplayPort standards Facilitates direct low
bandwidth transport of and transformation of 3D & 2D graphics & fonts
into directly Rendered Super High Fidelity SiMD & AVX Rendering Vector

Display Standards Vector Render : DSVR-SiMD Can and will be directly
rendered to a Surface for visual element : SfVE-Vec

As such transport of Vectors & transformation onto display (Monitor,
3D Unit, Render, TV, & Though HDMI, PCI Port & DP & RAM)

Directly resolve The total graphics pipeline into high quality output
or input & allow communication of almost infinite Floating point
values for all rendered 3D & 2D Elements on a given surface (RAM
Render Page or Surface)

In high precision that is almost unbeatable & yet consumes many levels
less RAM & Transport Protocol bandwidth,

Further more can also render Vector 3D & 2D Audio & other elements
though Vector 'Fonting' Systems, Examples exist : 3D Wave Tables,
Harmonic reproduction units for example Yamaha and Casio keyboards.

"QFT a Zero compression or low level compression version of DSC
1.2bc

X-OR Frame Buffer Compression & Blank Space Compression:
Vector Compression VESA Standard Display protocol 3"

"QFT transports each frame at a higher rate to decrease =E2=80=9Cdisplay
latency=E2=80=9D, which is the amount of time between a frame being ready f=
or
transport in the GPU and that frame being completely displayed. This
latency is the sum of the transport time through the source=E2=80=99s outpu=
t
circuits, the transport time across the interface, the processing of
the video data in the display, and the painting of the screen with the
new data. This overall latency affects the responsiveness of games:
how long it appears between a button is pressed to the time at which
the resultant action is observed on the screen.


While there are a lot of variables in this equation, not many are
adjustable from an HDMI specification perspective. QFT operates on the
transport portion of this equation by reducing the time it takes to
send only the active video across the cable. This results in reduced
display latency and increased responsiveness."
*

(c)Rupert S

Include vector today *important* RS
https://vesa.org/vesa-display-compression-codecs/

https://science.n-helix.com/2016/04/3d-desktop-virtualization.html

https://science.n-helix.com/2019/06/vulkan-stack.html

https://science.n-helix.com/2019/06/kernel.html

https://science.n-helix.com/2022/03/fsr-focal-length.html

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.ht=
ml

https://bit.ly/VESA_BT

Rupert S
