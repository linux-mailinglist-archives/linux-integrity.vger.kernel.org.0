Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2BB4ED26E
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Mar 2022 06:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiCaDs5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Mar 2022 23:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCaDs4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Mar 2022 23:48:56 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5828A02E
        for <linux-integrity@vger.kernel.org>; Wed, 30 Mar 2022 20:42:40 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id c62so26671687edf.5
        for <linux-integrity@vger.kernel.org>; Wed, 30 Mar 2022 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CCOr5pk3vSMtiJOP1fX/1K0uEtoSN1aksCDMiPaKahQ=;
        b=Ueg4ZkwYkJ0tkpNw0LKEAblt0x6p54CxjXVs7FoB5sjQlgLEZdpQXRaSeaJeimFQMb
         TrrbumdtViEGGH9ENKDeUK5QBBJB/ykDTDPjeVFgi3X1aeD0zzzplY/ZqJlcBTyimvXS
         8hZ/HDwfoUk53eHJIaggw0+bt+N6160iiGOuOFb6waekJgSvIl4nihR9VJMEFi0JDYwy
         qhu/RloE7TzbtZzmnuc2rY4nnFVNoskhMtDfyPDglQik0UEBp2s1ErOYV/10Lk9qDW02
         Tbz53R1Y5SOPb0HkKzthjQf0J6gDcGHSyXoIqkf5eo7ox/QbfXcENHcQZLclzMFMSQrp
         n2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CCOr5pk3vSMtiJOP1fX/1K0uEtoSN1aksCDMiPaKahQ=;
        b=1RAT0xsrCWSnmRM1WB5+RdX0oisNpCJK+TMep0UmzMBhSC0U0ta10LqLkjTa9RNtej
         iwgxQlfYIqOoP5B8MaX9+FGaSh/DlZCQ+CcEpQcw9lRwrnlILe+9XOzdocyBKOQixom/
         tREl4B3QRvsSwcO9pZhIVVTZ/8VNGxOe2aqaCJ2dE6Wj0VTBHHUFRTRcL3aEN2HqoMJR
         FvA+w/91b63mtuVyUe7Ujp3QQopKywAlxg5WlWTTA5iBZk210BuHa7FITBNs0rt7royg
         6rXbJVbD0ByGdrOfGARekIy6ulBnWi4iLcJdx/41YaqcnhFGVn5AaZuhGjzAmipioP4S
         Eekg==
X-Gm-Message-State: AOAM533N7TvBXU5aC1INnUwNuMMdkAekvCmgq+XheUmUBCXrDfR+bSoR
        YRgHq0M/XxJj84kbUU5Wgs3F6IVu2FXp5mIk0igiVQewyIbJRlFK
X-Google-Smtp-Source: ABdhPJy2HAc7r5WCokNQxGBfrf1K6XYqiIYpMJApgGKKmbQDWHng8FbzYO0QPdf8zefVZRLkP7rnMp+pr0YL/wFmhB8=
X-Received: by 2002:a05:6402:1347:b0:41b:79bf:cf12 with SMTP id
 y7-20020a056402134700b0041b79bfcf12mr1739801edw.195.1648695521732; Wed, 30
 Mar 2022 19:58:41 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Thu, 31 Mar 2022 03:58:38 +0100
Message-ID: <CAHpNFcMKUp_b7bv-OE5d9_x-vUL-hSudQ1REstTHC27vMFs0Ew@mail.gmail.com>
Subject: RISCV: implement cache-management : RISC Instructions : What do they
 all mean ? Todays manuel BLTU : https://passlab.github.io/CSE564/notes/lecture08_RISCV_Impl.pdf
To:     yan@oakland.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RISC Instructions : What do they all mean ? Todays manuel BLTU

signed magnitude (BLT/BGE) or unsigned magnitude (BLTU/ BGEU) =E2=80=A2 12-=
bit
immediate encodes branch target address as a signed o=EF=AC=80set from PC, =
in
units of 16-bits (i.e., shiR leR by 1 then add to

https://passlab.github.io/CSE564/notes/lecture08_RISCV_Impl.pdf

#CryptoFASTintFL Polynomial ROOFLINING : In terms of Entropy pool Int
& Timer collections Polynomial is a Cryptologic_Functiontion & should
be A : Rooflined B : Streamlined & C : In Crypto_hash_function.h
https://lkml.org/lkml/2022/3/30/1313

https://lkml.org/lkml/2022/3/30/1565

Rupert S
*****

Polynomial ROOFLINING : #CryptoFASTintFL

In terms of Entropy pool Int & Timer collections Polynomial is a
Cryptologic_Functiontion & should be A : Rooflined B : Streamlined & C
: In Crypto_hash_function.h

https://lkml.org/lkml/2022/3/30/1313

**Reference**

Multi Bit load operations for bitmap,Texture & Other tasks +ON+HighLowOP (c=
)RS
May take higher or lower bit depth & precisions: Rupert S 2021

MultiBit Serial & Parallel execution conversion inline of N*Bit -+

2 16 Bit loads is 32Bit but takes 2 cycles...

16 Bit loads with 32 Bit Stores & Math unit:

Operation 1

16Bit , 16Bit , 16Bit , 16Bit Operation
    \         /    \         /
           Inline Store
     32Bit Store 32Bit Store
           64Bit Store
       \     /
32Bit ADD/DIV x 2 or 64Bit ADD/DIV x1

Operation 2

32Bit ADD/DIV x 2 or 64Bit ADD/DIV x1
          \            /
          4x 16Bit Store

4 x 16Bit Operation

MultiBit Serial & Parallel execution conversion inline of N*Bit -+

In the case of ADD -+ Signed for example:(c)RS
Plus & - Lines ADD or Subtract (Signed, Bit Depth Irrelevant)

Multiples of 16Bit works in place of 32Bit or 64Bit

V1: 16Bit Values composing a total 128Bit number
V2: 16Bit Values composing a total 128Bit number - (Value less than V1)
V3: Result
NBit: Bit Depth

4x16Bit operations in the same cycle >
If Value =3D 16Bit =3D Store
If Value =3D V3=3DBit =3D Store * NBit

Stored 128Bit RAM or if remainder =3D less > 4x16Bit -1-1-1 ; 16Bit Value S=
tore

*

*RAND OP Ubuntu

https://pollinate.n-helix.com/

(Rn1 *<>/ Rn2 *<>/ Rn3)

-+
VAR(+-) Var =3D Rn1 +- Rn8

(Rn5 *<>/ Rn6 *<>/ Rn7)

4 Samples over N * Sample 1 to 4

Input into pool 1 Low half -+
Input into pool 1 High half -+

*RAND OP Recycle It

*

(c)RS https://bit.ly/DJ_EQ
