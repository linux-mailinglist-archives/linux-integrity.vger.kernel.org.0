Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD03B57BDFA
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jul 2022 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiGTSoA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jul 2022 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGTSn7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jul 2022 14:43:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E25162A7C;
        Wed, 20 Jul 2022 11:43:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b21so10906643qte.12;
        Wed, 20 Jul 2022 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :references:from:to:in-reply-to:content-transfer-encoding;
        bh=El+rsIB1bC6Euc05BiJGdo7Ei2NOu6zw0k6cXWb4www=;
        b=dsLlwhYS2bONBzwZHqYX6SDJBwVoFyQd4Tkh5XqkePZB1uposEYpC2TH9jdDzrfTja
         yAXfWFzIx46NuQWFWPQYKaUtquwjhCECWV9pH6/5fEhvJdr7bafUAnqhv4+ACTfGCS+m
         kN5qvURAdTc93497LG0MyClX45/p0XlCaHlB9zfn6te8zUixwpj2iFLAueRwH7VGrs7J
         0h4xM0Ryg9I3bNCU4Z3WMjTu3GytcdWOBW1n14+Q1YrP4c2MUYkPaZ4i3pA84vYAro0i
         XMd4+UStvB/ACO8UUrNc4xOR07hsImWap1sImXJyCVi5Ug+yn6cxHOdB00lNYK1rdXZo
         rk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:references:from:to:in-reply-to
         :content-transfer-encoding;
        bh=El+rsIB1bC6Euc05BiJGdo7Ei2NOu6zw0k6cXWb4www=;
        b=kiM5n4n8LUNG4RlJL7uIRPSq9u/2gR2rS118tgeLYtUvOwlzBEiWImOBl13JhvYsEH
         zLt4k7UjbXX6I34UDGbpxLgtewPtFeCiLaqgS1gsn7x+uD3SV9dA/O4x8N5XvVXt28Ex
         7iHG/OhDFU3QfeMHkbusRaiQ8b9HkoU48NO+hJw50IAVUDLOaut/GxCv0johyeQ0dIjJ
         TmQgV9sQe+tfbcJ60IlpbASGSjGpPeDolmEf35dmnkW6vBxLu/+F7JftCTkhG2uMmWtl
         lIgVm1rU7ZKAzNKZM4tn+mqJjVVTavJDrdZ6+0tPhevyWeb49efViQWr1Ai1hqDzhMDr
         twfA==
X-Gm-Message-State: AJIora+H2GwRxwmxKbCdrXZDGQpkdN4BIyTunTSMHjU2RgY/HpDAACyz
        4al/Gz4JoOWAEIkk/Vvwg3faFvgvV5NXrZnB
X-Google-Smtp-Source: AGRyM1spczEliFR1HeCco44UwM1D54J76gzKeECMu3HyYcpicnScR0FWHs4J6A5DSAlFuq6Qumj5QQ==
X-Received: by 2002:ac8:574f:0:b0:31e:d34a:971 with SMTP id 15-20020ac8574f000000b0031ed34a0971mr23645322qtx.126.1658342637313;
        Wed, 20 Jul 2022 11:43:57 -0700 (PDT)
Received: from [192.168.86.28] (c-75-69-133-154.hsd1.nh.comcast.net. [75.69.133.154])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b006a6ab259261sm16812634qkg.29.2022.07.20.11.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:43:57 -0700 (PDT)
Message-ID: <de0b6e61-2f6e-c215-65a9-428c3bf1bfb8@gmail.com>
Date:   Wed, 20 Jul 2022 14:43:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: keyrings, key usage, and trust models
Content-Language: en-US
References: <e3c62f26-861b-57c9-4d86-6af68c3433b0@gmail.com>
From:   Elaine Palmer <erpalmerny@gmail.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Dimitri Ledkov <dimitri.ledkov@canonical.com>,
        Joeyli <jlee@suse.com>, Eric Snowberg <eric.snowberg@oracle.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
In-Reply-To: <e3c62f26-861b-57c9-4d86-6af68c3433b0@gmail.com>
X-Forwarded-Message-Id: <e3c62f26-861b-57c9-4d86-6af68c3433b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


At LSS 2022 NA, a recent talk titled, "Establishing Trust
in Linux Keyrings – Is trust built-in, imputed, or transitive?"[1]
triggered some discussion, which is best continued here.

Background and current state as of Linux 5.18
---------------------------------------------
To save space, some terms are abbreviated:
 
  Official name           abbreviated  Origin of trust / who vouches
  -------------           -----------  ----------------------------- 
  secure boot keys        SB keys      hardware keys (if present)
  bootloader              bootloader   SB keys
  kernel signer           signer       bootloader
  .builtin_trusted_keys   builtin      kernel signer  
  .secondary_trusted_keys secondary    builtin & (new in 5.18) machine
  .ima                    ima          builtin & secondary
  .platform               platform     firmware, SB, MOK
  .machine                machine      MOK, management system
     
In simplified story form, hardware keys authorize secure boot keys,
which authorize the bootloader, which authorizes whoever signs
the kernel, who authorizes the builtin keys, which (along with
the machine keys) authorize the secondary keys, which
(along with builtin) authorize the ima keys.

The firmware, secure boot keys, or machine owner keys (MOK)
authorize the platform keys. MOK or a management system
authorizes the machine keys.

Key usage and restrictions
--------------------------
In addition to having different origins of trust, keys are used
for different purposes: verifying signatures on kernel modules
(code), on kexec'd kernel images (code), on data, and on other
keys. See [1] for more details. 

Unfortunately, key usage restrictions are not consistently
enforced throughout the kernel. For example, a key used to
verify code might be used to verify data or other keys. 

Insufficient functionality
--------------------------
Before the addition of the machine keyring, secondary keys
were only authorized by builtin and other secondary keys.
There was a well-defined, but inflexible source of trust.
Multiple distros needed a way to load keys from sources
unknown at kernel signing time. They used their own
out-of-tree patches to load additional keys onto the
secondary keyring.  

Today, the only way to *guarantee* proper enforcement of key
usage and restrictions is to create a new keyring and write
patches to limit its functionality.  The platform keyring,
used only for verifying kexec'd kernels, is a good example.
Even then, current needs are not met. For example, one vendor
wants to provide additional guidance such as, "Use key X1
only for verifying kernel modules from vendor X." Others want
to restrict keys to those linked to a hardware root of trust.

Additional problem
------------------
With the addition of the machine keyring, keys from a new
source of trust can be added to the secondary keyring.
Without proper enforcement of key usage and restrictions,
those keys can be used for any purpose.


Proposed solutions
------------------
1. In the short term, load only CA keys onto the machine keyring
   and re-enable IMA. Define a kernel configuration option to prevent
   breakage.  The kernel configuration option could either enable or
   disable CA-only keys.

2. Don't link the machine keyring to the secondary keyring.
   Just as there are limitations on usage of keys in platform,
   add limitations on keys in machine to a very specific stated
   purpose, clearly expressed in the cover letter and patch
   description, e.g., verifying kernel modules.

3. In the long term, work towards
   a) enforcement of key usage in the certificate, and
   b) implementing policy controls on keys.


[1]
https://static.sched.com/hosted_files/lssna2022/18/LSS%202022%20trust%20and%20keyrings.pdf

-----

-Elaine Palmer, IBM Research
