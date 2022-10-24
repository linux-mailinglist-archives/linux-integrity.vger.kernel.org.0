Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A212609874
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Oct 2022 05:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJXDHk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJXDHh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 23:07:37 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D774BBB
        for <linux-integrity@vger.kernel.org>; Sun, 23 Oct 2022 20:07:36 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2429833pji.0
        for <linux-integrity@vger.kernel.org>; Sun, 23 Oct 2022 20:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBS6W4GcIdd3PGdlMqMgZMuvtU7nNy5MNdHU8dmE4nA=;
        b=dJrpgMoTfiGKnmCNizXqtx2Kpp4hwhfuzt8Ln3w78NTjpYiMl10POzrD7uTafA3b73
         l6FdBlPS1PEmahwLYQe+LA2RdD5TRr+FqtZ6q3YZAMvH22athUMzbmMebfs4y6VgjQQn
         YjwnYrxr5FCauHtb6HQ7Dsvzt2AetsRxTP6Natejz+WE8laMQwSzO/hLqqnXRpucLwxq
         aO9zmlM9mfD2Wu1nYnqOSDptDskaRXSY+oI6tPNygFoorplbTGZROuFahNnKRVDPZl1e
         5pYLVytvFXTyghkgWWi+vvCIH58PQFDzD6XLJfswIv23mBzO3UBDrJZEBpbJiwjSKkQO
         4oiQ==
X-Gm-Message-State: ACrzQf0sNQnqp5N33/N7J0d66yXFPxn8EB2HyMB5LObQF5QYUrAv9uAB
        TsZaE4OrOCfZzH1iS+IneG+L2/wrvcE=
X-Google-Smtp-Source: AMsMyM6oONIDj2IyLVrSaqpzKj/GS90eKkrTqO6JDTuCtr5GGb5M3TQzDBfL5F61bHQV8truCya2uA==
X-Received: by 2002:a17:902:9b82:b0:183:fffb:1bfe with SMTP id y2-20020a1709029b8200b00183fffb1bfemr31717730plp.173.1666580856061;
        Sun, 23 Oct 2022 20:07:36 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b001784a45511asm18571317plb.79.2022.10.23.20.07.35
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 20:07:35 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso7853441pjc.5
        for <linux-integrity@vger.kernel.org>; Sun, 23 Oct 2022 20:07:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4c92:b0:213:13d2:381f with SMTP id
 my18-20020a17090b4c9200b0021313d2381fmr2777694pjb.219.1666580855434; Sun, 23
 Oct 2022 20:07:35 -0700 (PDT)
MIME-Version: 1.0
From:   Ken Williams <ken@williamsclan.us>
Date:   Sun, 23 Oct 2022 20:07:24 -0700
X-Gmail-Original-Message-ID: <CADrftwNYya==hLiZ+c=ZCJOt++JCVbCivjaeMWv8vKnF+pgOBw@mail.gmail.com>
Message-ID: <CADrftwNYya==hLiZ+c=ZCJOt++JCVbCivjaeMWv8vKnF+pgOBw@mail.gmail.com>
Subject: Expected appraisal behavior after script modification
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am interested in knowing the expected appraisal behavior after a
signed script has been modified.  I am asking because I observe that a
modified signed script can be executed.  In my effort, I did the
following:

0) Configure IMA with the only positive appraisal being:
appraise func=BPRM_CHECK appraise_type=imasig

1) Create s simple script, as shown here:
#!/bin/bash

echo "Hello World"

2) Try to execute the script and see a failure as expected:
# ./hello.sh
bash: ./hello.sh: /bin/bash: bad interpreter: Permission denied

and see:
journalctl | grep INTEG
Oct 24 02:26:32 ctx0700 audit[7135]: INTEGRITY_DATA pid=7135 uid=0
auid=0 ses=4 subj=root:staff_r:staff_t:s0-s0:c0.c1023
op="appraise_data" cause="IMA-signature-required" comm="bash"
name="/sysroot/home/root/hello.sh" dev="mmcblk0p6" ino=23072 res=0

3) Sign the script:
evmctl ima_sign -k /etc/keys/privkey_ima.pem ./hello.sh

4) Execute
# ./hello.sh
Hello World

5) Modify the script to read:
#!/bin/bash

echo "Hello World"
echo "Hello Again"

>>>>>>>>>  ****************** <<<<<<<<<<
6) Execute the script and observe that the modified script executes successfully
 This was unexpected.
# ./hello.sh
Hello World
Hello Again

The signature was unchanged.

In order to avoid crowding this email with too much info, I have
omitted some details such as the actual signature and the full policy
(with dont_appraise fs=xxxx) and kernel config, but will be glad to
augment this as requested.  But first, I want to start by
understanding if this behavior is expected.
I am running a 4.14.238 kernel.
