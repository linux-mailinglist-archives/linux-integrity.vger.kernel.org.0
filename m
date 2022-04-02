Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05F94F00CF
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Apr 2022 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354534AbiDBKye (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 2 Apr 2022 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354573AbiDBKyW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 2 Apr 2022 06:54:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DC014864B
        for <linux-integrity@vger.kernel.org>; Sat,  2 Apr 2022 03:52:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qh7so703154ejb.11
        for <linux-integrity@vger.kernel.org>; Sat, 02 Apr 2022 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Zu8eKPzRskdlQlbramfPaoD/f1fGti5TmNsQY/hQanM=;
        b=GY1j8tzy/iDpw5ZJczyjRnKh/rlWb7bFzscp7zALfPv6PUvQKhRLyFUClMnBwdOit1
         Qjco5r1NYNkX48o1HPbAJENvDQYr4Ji2z8feBQMHUpsmyTOkI7Z+Ag9eSCxya8oa3n13
         74HghIOf/UOx8ZIFpgRrXCOCquCfHl57OF+1OIPOSf1NeSK57R1iaDX+TZs6ZxdXEzhO
         ecK7nqqnlwYk5alg+boRREXT74AfNPKjmmw+stYPehetPDmT47qZJkQeOyT1AiAh4EBN
         BIcgOCVM2u1OYM2BM4BOXcBDsli3ZupoRbO2jV3QlrawgXFDX2KckQx8qcvAuq+fjHHo
         8Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Zu8eKPzRskdlQlbramfPaoD/f1fGti5TmNsQY/hQanM=;
        b=nLBpAT4gU5aCVZXWu75BIDT/A+Ky+I+Y3g64m/nloLTmROzqokczivKJ7PnYtMRrwN
         4Q9Jta0p1oiscrnEdfVekAAbElHnyP4Jj7giXjwmoobYFLPJa90YJJATBUeyu7teO1AC
         uTEVqio80scRwnHAKhfM93ebpkzzfccy6HAUDtDqMeYx04vWdNHrbQmQ8WRLOx76Kth1
         hGqqprkcta2hS7XoRsIlnuBcuS3749DM4brfnlm2nBsEFNW73AiiaR+CUuLDSSlceEd6
         4BOcT01ggcmtNAH8fn5rOS+21xvCyLC0+snZi2ZcJYQNnhYrLDs4G8uYgQq6txQixNDU
         mTxg==
X-Gm-Message-State: AOAM530qDtJixJh5u0fzERUH0pG4/9AW3IYFp9NJF20nQEQ1vXcltu1w
        xq8iqVt8tO2hEPVtiBYbw5LZzPC1v/OVhigLtoQ=
X-Google-Smtp-Source: ABdhPJz5+6PACXGqfh3RKI04rKN0HSLK/vS+N6oXQKeLI1lmw2daUD2eqc4MZA333CysDKTaGXC64G4Wduj0dDB9GmI=
X-Received: by 2002:a17:907:1b10:b0:6e4:bac5:f080 with SMTP id
 mp16-20020a1709071b1000b006e4bac5f080mr3434011ejc.24.1648896735229; Sat, 02
 Apr 2022 03:52:15 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Sat, 2 Apr 2022 11:52:16 +0100
Message-ID: <CAHpNFcOhLyPqE4-0f7vZ1rRRdC6BK6UgX17bJrM8_99GQ9T5bQ@mail.gmail.com>
Subject: VecSR is really good for secondary loading of sprites & text; In
 these terms very good for pre loading on for example the X86, RISC, AMIGA &
 Famicon type devices, With appropriate loading into Sprite buffers or
 Emulated Secondaries (Special Animations) or Font Buffers. RS
To:     torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VecSR is really good for secondary loading of sprites & text; In these
terms very good for pre loading on for example the X86, RISC, AMIGA &
Famicon type devices,
With appropriate loading into Sprite buffers or Emulated Secondaries
(Special Animations) or Font Buffers.

Although Large TT-SVG & OT-SVG fonts load well in 8MB Ram on the Amiga
with Integer & Emulated Float (Library); Traditional BitMap fonts work
well in a Set Size & can resize well if cached!

The full process leads upto the terminal & how to optimise CON,
We can & will need to exceed capacities of any system & To improve them!

presenting: Dev-Con-VectorE=C2=B2

Fast/dev/CON 3DText & Audio Almost any CPU & GPU ''SiMD & Float/int"
Class VESA Console +

With Console in VecSR you can 3DText & Audio,

VecSR Firmware update 2022 For immediate implementation in all
operating systems & ROM's

Potential is fast & useful

DT

https://lkml.org/lkml/2022/4/1/1451

*****

VecSR - Vector Standard Render

VESA Standards : Vector Graphics, Boxes, Ellipses, Curves & Fonts :
Consolas & other brilliant fonts : (c)RS

SiMD Render - Vector Graphics, Boxes, Ellipses, Curves & Fonts

OT-SVG Fonts & TT-SVG Obviously Rendered in Direct X 9+ & OpenGL 3+
Mode & Desktop Rendering modes

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

(c)Rupert S

https://science.n-helix.com/2016/04/3d-desktop-virtualization.html

https://science.n-helix.com/2019/06/vulkan-stack.html

https://science.n-helix.com/2019/06/kernel.html

https://science.n-helix.com/2022/03/fsr-focal-length.html

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.ht=
ml

https://bit.ly/VESA_BT

*

*Application of SiMD Polygon Font Method Render
*3D Render method with Console input DEMO : RS

3D Display access to correct display of fonts at angles in games &
apps without Utilizing 3rd Axis maths on a simple Shape polygon Vector
font or shape. (c)Rupert S

3rd dimensional access with vector fonts by a simple method:

Render text to virtual screen layer AKA a fully rendered monochrome, 2
colour or multi colour..

Bitmap/Texture,

Due to latency we have 3 frames ahead to render to bitmap DPT 3 / Dot 5

Can be higher resolution & we can sub sample with closer view priority...

We then rotate the texture on our output polygon & factor size differential=
.

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize

Why ? Because rotating a polygon is harder than subtracting or adding
width, Hight & direction to fully complex polygon Fonts & Polygon
lines or curves...

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize.

*

VecSR is really good for secondary loading of sprites & text; In these
terms very good for pre loading on for example the X86, RISC, AMIGA &
Famicon type devices,
With appropriate loading into Sprite buffers or Emulated Secondaries
(Special Animations) or Font Buffers.

Although Large TT-SVG & OT-SVG fonts load well in 8MB Ram on the Amiga
with Integer & Emulated Float (Library); Traditional BitMap fonts work
well in a Set Size & can resize well if cached!

The full process leads upto the terminal & how to optimise CON,
We can & will need to exceed capacities of any system & To improve them!

presenting: Dev-Con-VectorE=C2=B2
Fast/dev/CON 3DText & Audio Almost any CPU & GPU ''SiMD & Float/int"
Class VESA Console +

With Console in VecSR you can 3DText & Audio,

VecSR Firmware update 2022 For immediate implementation in all
operating systems & ROM's

Potential is fast & useful.

*

https://science.n-helix.com/2022/04/vecsr.html
