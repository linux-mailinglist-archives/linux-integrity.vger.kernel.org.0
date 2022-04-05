Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F44F5215
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiDFCfF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Apr 2022 22:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576523AbiDEXKp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Apr 2022 19:10:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCB4C798
        for <linux-integrity@vger.kernel.org>; Tue,  5 Apr 2022 14:41:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so430960ejd.5
        for <linux-integrity@vger.kernel.org>; Tue, 05 Apr 2022 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ao66c39lDXSZDrmfpWAolMn1IGH5i64J+LVad5/f4UM=;
        b=bo1JItiWD8iFpzoCKD8TgTyvXPkdFhsK50XGs87qiMpJcDml4olxlivsBLszqrfcz0
         +Kj6qbT2HyBDCbzeDho4WHl44Ymd0vj23aKHRtTgJCmlGE8nR3hPurNWByY9cAVNVKec
         WVhgIdYWbJCK5nj9ccJPGFYsdMfAqsRRADEpDNWhdXuxFo9LCKXy5gTpnvnSkM0hWZpF
         PNV3Oi8VHQLcqKgbdm6u1geV74Ma7Dtj9FZ+9mwECWwUmANV3wqCEheMDxtnTI/l2vpk
         PptATUWdgSmEW57gscbmHdSZAew8olunCN1mQE2ENlPhbrGEI0bHuTC0iv6MIznmc1of
         8HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ao66c39lDXSZDrmfpWAolMn1IGH5i64J+LVad5/f4UM=;
        b=p63xAOcczPGQBkcezOc6tLdSfOkrE24aKS06SKOo3iKnnuvdKrt+Msj+fPsjGIMDSB
         ONjwIEZ4QYuM/eVmysM/7iaoAotFLXXrSGNY2abVCNktsqC+R4ZaZCdjYt7tRqxvFi0t
         RleBMk/KxoBHvb9k1zj6JQNY7ZRBh5L1S69G+UA92Uo2hnfkIYOKo6XSKxfndDVjWHgd
         2PYyoms7OkpLQOJvZ4nryWzSf18JQhmSFBC/Xe87RMo1ihl1rdDXDJJPTkRqitnqaeN2
         Yrcc4Bwqm6+ceGAsfIEj5hcZYPEVJ0/05VGe1Sl/FsULf6Et5gKjRPW18Dw6d/ghcPYB
         XuGg==
X-Gm-Message-State: AOAM5309Ro4n/ZZJwDkHEIjEUCToKVxvXUoQklY0wKCsnMsmU0YufFEJ
        fKPRpmledwwM+0j3SNSi+8G69FcfrpZJA2gNLN4=
X-Google-Smtp-Source: ABdhPJyFDE/16osppxD7V/k1b0k3Gd311E4D8jEx0fbUCJZHbHSbpptOjBnmaMe5MNBFwIJscOCJA1gIieSPdSqCa4Y=
X-Received: by 2002:a17:907:1b10:b0:6e4:bac5:f080 with SMTP id
 mp16-20020a1709071b1000b006e4bac5f080mr5466982ejc.24.1649194899933; Tue, 05
 Apr 2022 14:41:39 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Tue, 5 Apr 2022 22:41:28 +0100
Message-ID: <CAHpNFcNYoz_VY0JBDw75ditAKXs5ghujShjBdYjM_nnFSTzcGg@mail.gmail.com>
Subject: LiberKHAOS - "So my 2k buffer is fine then." & We Wanted FINE ?
 #DEV-RAND #Chromium gcc-plugins: latent_entropy: use /dev/urandom
To:     torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

LiberKHAOS - "So my 2k buffer is fine then." & We Wanted FINE ?
#DEV-RAND #Chromium gcc-plugins: latent_entropy: use /dev/urandom

https://lkml.org/lkml/2022/4/5/2829

DMAC yep Security Align 128Bits to Cache Array
Align that 128Bit Buffer to Cache Align = Pure, 32Bit,64Bit,128Bit
Align Quads & Float Quads -
HDD,SDD normally have the EIDD DDI Equivalent
Device Cache Align 'code align also speeds up prefetch' Radio AKA Wifi
is also aligned & Internet protocols

RS

https://lkml.org/lkml/2022/4/4/1254
https://lore.kernel.org/all/20220404194510.9206-2-mario.limonciello@amd.com/

Subject: Hardware Dual Encrypt & Decrypt : Hardware Accelerators


(indirect) - Plan & method RS

Modulus Dual Encrypt & Decrypt package : Processor feature (c)RS

AES-CCM & AES-GCM & Other Cypher Modulus + CCM & GCM can be
accelerated with a joint AES Crypto module,

Processor feature & package : Module list:

2 Decryption pipelines working in parallel,
With a Shared cache & RAM Module
Modulus & Semi-parallel modulating decryption & Encryption combined
with Encapsulation Cypher IP Protocol packet

Parallax Cryptographic Processing Unit: RS

The capacity To Multiply decryption on specific hardware in situations
such as lower Bit precision is to be implemented as follows:

On AES-NI & ARM Cryptographic processors; In particular PPS(ARM+) & SiMD ..

The capacity to exploit the fact that the nonce is 16Bit to 64Bit &
full float upto 128Bit for legal decryption (client) means there is a
simple method to use:

In situations that a AES-NI & ARM Cryptographic unit can process 2
threads on a 256Bit Function we can do both the main 128Bit/192Bit &
the nonce 16Bit to 64Bit & Enable a single instruction Roll to
Synchronise both The main HASH & Nonce.

AES & Crypto hardware can utilise the CPU/GPU/Processor FPU & SiMD to
decrypt the nonce (smaller so fast) & in the same 8bto to 64Bits of
code; Inline & parallax the cryptographic function.

With a 256Bit AES-NI & Cryptographic unit : Parallel Decryption &
Return Encryption by using 2x 128Bit & a Processor Enciphered Nonce.

(c)Rupert S

*reference* https://bit.ly/VESA_BT

Dual Encrypt & Decrypt : Hardware Accelerators (indirect)
https://lkml.org/lkml/2022/4/4/1153
https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@benyossef.com/T/#u,

Performance Comparison of AES-CCM and AES-GCM Authenticated Encryption Modes
http://worldcomp-proceedings.com/proc/p2016/SAM9746.pdf

Basic comparison of Modes for Authenticated-Encryption -IAPM, XCBC,
OCB, CCM, EAX, CWC, GCM, PCFB, CS
https://www.fi.muni.cz/~xsvenda/docs/AE_comparison_ipics04.pdf

*****

ICE-SSRTP GEA Replacement 2022 + (c)RS

"GEA-1 and GEA-2, which are very similar (GEA-2 is just an extension
of GEA-1 with a higher amount of processing, and apparently not
weakened) are bit-oriented stream ciphers."

GEA-2 > GEA-3 is therefor 64Bit Safe (Mobile calls) & 128Bit Safe
(Reasonable security)
SHA2, SHA3therefor 128Bit Safe (Reasonable security Mobile) ++
AES & PolyChaCha both provide a premise of 128Bit++

So by reason alone GEA has a place in our hearts.

*

ICE-SSRTP GEA Replacement 2022 + (c)RS

IiCE-SSR for digital channel infrastructure can help heal GPRS+ 3G+ 4G+ 5G+

Time NTP Protocols : is usable in 2G+ <> 5G+LTE Network SIM

ICE-SSRTP Encryption AES,Blake2, Poly ChaCha, SM4, SHA2, SHA3, GEA-1 and GEA-2
'Ideal for USB Dongle & Radio' in Rust RS ' Ideal for Quality TPM
Implementation'

"GEA-1 and GEA-2, which are very similar (GEA-2 is just an extension
of GEA-1 with a higher amount of processing, and apparently not
weakened) are bit-oriented stream ciphers."

IiCE-SSRTP : Interleaved Inverted Signal Send & Receive Time Crystal Protocol

Interleaved signals help Isolate noise from a Signal Send & Receive ...

Overlapping inverted waves are a profile for complex audio & FFT is the result.

Interleaved, Inverted & Compressed & a simple encryption?

*

Time differentiated : Interleave, Inversion & differentiating Elliptic curve.

We will be able to know and test the Cypher : PRINCIPLE OF INTENT TO TRUST

We know of a cypher but : (Principle RS)

We blend the cypher..
Interleaved pages of a cypher obfuscate : PAL CScam does this

Timed : Theoretically unique to you in principle for imprecision, But
we cannot really have imprecise in Crypto!

But we can have a set time & in effect Elliptic curve a transient variable T,
With this, Interleave the resulting pages (RAM Buffer Concept)

Invert them over Time Var = T

We can do all & principally this is relatively simple.

(c)RS

*

Modulus Dual Encrypt & Decrypt package : Processor feature (c)RS

AES-CCM & AES-GCM & Other Cypher Modulus + CCM & GCM can be
accelerated with a joint AES Crypto module,

Processor feature & package : Module list:

2 Decryption pipelines working in parallel,
With a Shared cache & RAM Module
Modulus & Semi-parallel modulating decryption & Encryption combined
with Encapsulation Cypher IP Protocol packet

Parallax Cryptographic Processing Unit: RS

The capacity To Multiply decryption on specific hardware in situations
such as lower Bit precision is to be implemented as follows:

On AES-NI & ARM Cryptographic processors; In particular PSP+PPS(ARM+) & SiMD ..

The capacity to exploit the fact that the nonce is 16Bit to 64Bit &
full float upto 128Bit for legal decryption (client) means there is a
simple method to use:

In situations that a AES-NI & ARM Cryptographic unit can process 2
threads on a 256Bit Function we can do both the main 128Bit/192Bit &
the nonce 16Bit to 64Bit & Enable a single instruction Roll to
Synchronise both The main HASH & Nonce.

AES & Crypto hardware can utilise the CPU/GPU/Processor FPU & SiMD to
decrypt the nonce (smaller so fast) & in the same 8bto to 64Bits of
code; Inline & parallax the cryptographic function.

With a 256Bit AES-NI & Cryptographic unit : Parallel Decryption &
Return Encryption by using 2x 128Bit & a Processor Enciphered Nonce.

(c)Rupert S

*reference*

Performance Comparison of AES-CCM and AES-GCM Authenticated Encryption Modes
http://worldcomp-proceedings.com/proc/p2016/SAM9746.pdf

Basic comparison of Modes for Authenticated-Encryption -IAPM, XCBC,
OCB, CCM, EAX, CWC, GCM, PCFB, CS
https://www.fi.muni.cz/~xsvenda/docs/AE_comparison_ipics04.pdf


*

Example of use:

Nostalgic TriBand : Independence RADIO : Send : Receive :Rebel-you trade marker

Nostalgic TriBand 5hz banding 2 to 5 bands, Close proximity..
Interleaved channel BAND.

Microchip clock and 50Mhz Risc Rio processor : 8Bit : 16Bit : 18Bit
Coprocessor digital channel selector &

channel Key selection based on unique..

Crystal time Quartz with Synced Tick (Regulated & modular)

All digital interface and resistor ring channel & sync selector with
micro band tuning firmware.

(c)Rupert S

*

Good for cables ? and noise ?

Presenting :  IiCE-SSR for digital channel infrastructure & cables
<Yes Even The Internet &+ Ethernet 5 Band>

So the question of interleaved Bands & or signal inversion is a simple
question but we have,

SSD & HDD Cables & does signal inversion help us? Do interleaving bands help us?

In Audio inversion would be a strange way to hear! but the inversion
does help alleviate ...

Transistor emission fatigue...

IiCE-SSRTP : Interleaved Inverted Signal Send & Receive Time Crystal Protocol

Interleaved signals help Isolate noise from a Signal Send & Receive ...

Overlapping inverted waves are a profile for complex audio & FFT is the result.

Interleaved, Inverted & Compressed & a simple encryption?

Good for cables ? and noise ?

Presenting : IiCE for digital channel infrastructure & cables <Yes
Even The Internet &+ Ethernet 5 Band>

(c) Rupert S

https://science.n-helix.com/2018/12/rng.html

https://science.n-helix.com/2022/02/rdseed.html

https://science.n-helix.com/2017/04/rng-and-random-web.html

https://science.n-helix.com/2022/02/interrupt-entropy.html

https://science.n-helix.com/2021/11/monticarlo-workload-selector.html

https://science.n-helix.com/2022/03/security-aspect-leaf-hash-identifiers.html


Audio, Visual & Bluetooth & Headset & mobile developments only go so far:

https://science.n-helix.com/2022/02/visual-acuity-of-eye-replacements.html

https://science.n-helix.com/2022/03/ice-ssrtp.html

https://science.n-helix.com/2021/11/ihmtes.html

https://science.n-helix.com/2021/10/eccd-vr-3datmos-enhanced-codec.html
https://science.n-helix.com/2021/11/wave-focus-anc.html
https://science.n-helix.com/2021/12/3d-audio-plugin.html

Integral to Telecoms Security TRNG

*RAND OP Ubuntu :
https://manpages.ubuntu.com/manpages/trusty/man1/pollinate.1.html

https://pollinate.n-helix.com

*

***** Dukes Of THRUST ******

Nostalgic TriBand : Independence RADIO : Send : Receive :Rebel-you trade markerz

Nostalgic TriBand 5hz banding 2 to 5 bands, Close proximity..
Interleaved channel BAND.

Microchip clock and 50Mhz Risc Rio processor : 8Bit : 16Bit : 18Bit
Coprocessor digital channel selector &

channel Key selection based on unique..

Crystal time Quartz with Synced Tick (Regulated & modular)

All digital interface and resistor ring channel & sync selector with
micro band tuning firmware.

(c)Rupert S

Dev/Random : Importance

Dev/Random : Importance : Our C/T/RNG Can Help GEA-2 Open Software
implementation of 3 Bits (T/RNG) Not 1 : We need Chaos : GEA-1 and
GEA-2 Implementations we will improve with our /Dev/Random

Our C/T/RNG Can Help GEA-2 Open Software implementation of 3 Bits
(T/RNG) Not 1 : We need Chaos : GEA-1 and GEA-2 Implementations we
will improve with our /Dev/Random

We can improve GPRS 2G to 5G networks still need to save power, GPRS
Doubles a phones capacity to run all day,

Code can and will be improved, Proposals include:

Blake2
ChaCha
SM4
SHA2
SHA3

Elliptic Encipher
AES
Poly ChaCha

Firstly we need a good solid & stable /dev/random

So we can examine the issue with a true SEED!

Rupert S https://science.n-helix.com/2022/02/interrupt-entropy.html

TRNG Samples & Method DRAND Proud!

https://drive.google.com/file/d/1b_Sl1oI7qTlc6__ihLt-N601nyLsY7QU/view?usp=drive_web
https://drive.google.com/file/d/1yi4ERt0xdPc9ooh9vWrPY1LV_eXV-1Wc/view?usp=drive_web
https://drive.google.com/file/d/11dKUNl0ngouSIJzOD92lO546tfGwC0tu/view?usp=drive_web
https://drive.google.com/file/d/10a0E4Gh5S-itzBVh0fOaxS7JS9ru-68T/view?usp=drive_web

https://github.com/P1sec/gea-implementation
