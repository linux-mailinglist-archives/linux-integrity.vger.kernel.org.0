Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43465673A
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Dec 2022 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiL0EOn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Dec 2022 23:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiL0EOm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Dec 2022 23:14:42 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4A305
        for <linux-integrity@vger.kernel.org>; Mon, 26 Dec 2022 20:14:40 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id h4so779899vkn.3
        for <linux-integrity@vger.kernel.org>; Mon, 26 Dec 2022 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjdlqICv33EOX64nmJtOK4eeCybLMgO053G4bs/5DXk=;
        b=UQemiBq/jNd0yUioMpgUp+A3qwjeM7CxkNfj6MjcCid1BgBsBAgxXdpHAtm748v8ib
         vATyKVJafFHxh1puDfmUg0fRwoUMdOYw4vl3lcLwWnCxx6Y/FbfgZvSgArv/4PQbcrGM
         2VXQR6LODSwQqRPz8V7ARd/QtnzaqgRGgZ/ucDYHdWRTin/VkQ5nhfqR+hGmg+LRXzem
         03wWfSx6HDFcdrIcMwTjXYG/KzMzL6zGYEvToV6O8haCtXu8jf+C2PNkpa/EQJwKA3C/
         huq7r/fqsj47HuA57/EXvJo55hAd3EPk4jdkjjjyPpVU2+fWz0GIzwpsYPThylyNcDj6
         xCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjdlqICv33EOX64nmJtOK4eeCybLMgO053G4bs/5DXk=;
        b=xrbphNPUsfEP2/3OvqI3mKhmtJGVVvUOBH36ZY4zvfn0IBD1irfbfR6OukQjThG17r
         +qmnXXRZxTRa3/AqtzcykeKQ3ln6DR2GqSh0tfjBkmzYhrQArDaurJYEo7CSphtBQebb
         dscJ/9hukC9Oq65Rex6xH2ZNy0a277eY+6/088BN3F17VGCwCFlhyyyg1hGp0eEvUY3L
         JX/upkoLs8lRlkmBPCce0CrnxiiEbJb81nLhP1p9+73UYz4sCTlsqhmbrAn3bkYWOUs/
         Jkg2DzZI50Z+Xalr2CIn1WNn3tQus46QL0FbEd+et1LMRJNN2jdp8Xz5HKtSWuKndl2f
         VmYQ==
X-Gm-Message-State: AFqh2kq0n3UT9ogJLO5AEw/FM+yVr/cStUH04MskuoFaDPPwDVglF1re
        mbLNoTVbWofFz+TRZH1EcyUqXOp3HmhGyRMQug8NNG9IlQE+UFhC
X-Google-Smtp-Source: AMrXdXup0jfh6WM8yiM9FjWnkDizh8v2Dv+xIPZh/43ZS4YL8xF6Y2sGXtQhQdQtHp+Atzd7zdAi6i6FHi81anpCOAs=
X-Received: by 2002:a05:6122:334:b0:3d0:8328:c28e with SMTP id
 d20-20020a056122033400b003d08328c28emr1939449vko.33.1672114478970; Mon, 26
 Dec 2022 20:14:38 -0800 (PST)
MIME-Version: 1.0
From:   Sughosh Ganu <sughosh.ganu@linaro.org>
Date:   Tue, 27 Dec 2022 09:44:28 +0530
Message-ID: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
Subject: Seal/Unseal trusted keys against PCR policy
To:     linux-integrity@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hi,
I am looking to use PCR policy to seal and unseal trusted keys. I
tried using the interface described in the documentation [1], but I
get an unseal error at the time of a key load operation. I came across
a thread [2] which is pretty much the error that I get. As per my
understanding of what James had explained on that thread, the API was
broken for TPM2.0 based devices. Has that since been fixed. If so, has
there been a change in the user interface for sealing and unsealing
the trusted keys.

Here are the steps that I follow.

# tpm2_createpolicy --policy-pcr --pcr-list sha256:10 --policy
pcr10_bin.policy > pcr.policy

# cat pcr.policy
16ef916486174ed6f68b09629d2920dd7493d0918fff1247420934c3836100d3

#keyctl add trusted kmk-pcr "new 32 keyhandle=0x81000001 hash=sha256
policydigest=`cat pcr.policy`" @u
588568314

# keyctl pipe 588568314 > kmk-pcr.blob

On a reboot (or even w/o a reboot, after deleting the key)
#keyctl add trusted kmk-pcr "load `cat kmk-pcr.blob`
keyhandle=0x81000001 hash=sha256 policydigest=`cat pcr.policy`" @u
add_key: Operation not permitted

My setup is a Qemu arm64 virt platform running Debian11, linux kernel
built with current master branch, and swtpm 2.0 implementation as the
TPM backend.

-sughosh

[1] - Documentation/security/keys/trusted-encrypted.rst
[2] - https://lore.kernel.org/linux-integrity/20191206212031.GE9971@linux.intel.com/T/
