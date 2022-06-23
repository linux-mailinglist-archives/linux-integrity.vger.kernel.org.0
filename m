Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0355725E
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jun 2022 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiFWErl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jun 2022 00:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiFWE1O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jun 2022 00:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FE6A2DAB6
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jun 2022 21:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655958431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IBxvMB+Edf2kNT2Bpm+WLvfut0GM6YsurjzoxFCucJo=;
        b=UQqko6fpr0DmJsKYE/STSJVGDV7GOCXK+q2vqnWsqS+L7AQ/7fokJKgWQDqK8S3sj9MpbG
        6ROJolwP83WkS0w7is9M2xakqh2L5Y1m8thflhX8R9yUya+buKTzBOi0l0t5Ge4c9gH+Vq
        0v7FHMwT3x/Wa/qEjfk3UlNQItRuF5Y=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-ri7QvMfUMXSL4xTivwpcuw-1; Thu, 23 Jun 2022 00:27:08 -0400
X-MC-Unique: ri7QvMfUMXSL4xTivwpcuw-1
Received: by mail-vk1-f197.google.com with SMTP id m63-20020a1fee42000000b0036c8981d9bdso979535vkh.16
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jun 2022 21:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IBxvMB+Edf2kNT2Bpm+WLvfut0GM6YsurjzoxFCucJo=;
        b=gLGCUw4RdSomVkWZ5TGpDEum0gq0cj5R1xi8UZz7Z9O/+k9S3uNWS2v2ZQkqgwhJyN
         WjT34p97QflOo/zpd3qkplLbPIH+ahS8agH+tOKVnEC/ABhekSHplSRX6X+lTIfI3JEX
         ZSBRvYvAX92UVWpM+Be6fmm30Du6fN3XoZ/MkZ3WfhiV+9yis/tX0gpSJsfGarIh829z
         a37RQBCm3S/u/FQnYufbiqEBWoqowHKoCKMvpiq1Xa3QAC3q53fnWTdttIhmUuWXJ+DK
         QCqthLASsYvUyXf5FOHzWEuIKmus+M9tGgQGpzTflij3HQG2GcGc7wnXRqFPnWZq2/Lt
         6ylg==
X-Gm-Message-State: AJIora+jfoFa9vpxhWqBevkYdfq4ruO3fjM2VbH9W6BTg8p2kxmXVcwz
        kxUH8sYnxNnorHMfNoVrnWYFMswybuGK7P663dz4Lp2ECM25VmbUg0Tfhg/BF4jgBMRKaE1rZtB
        om8Gu7zSyjqs0z+8SdZhiEeeVzLzih8ER573dw/Va+kvQ
X-Received: by 2002:a05:6102:390f:b0:34b:fd08:765b with SMTP id e15-20020a056102390f00b0034bfd08765bmr16297305vsu.20.1655958428191;
        Wed, 22 Jun 2022 21:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqAVgj7S1VnchuTdBup1a9JK6o0vYCVoY8GvaUXQmHuO1iT+OVscT0bHinyPB4lh4Jp/HzGkdPzdUSBdvBLl0=
X-Received: by 2002:a05:6102:390f:b0:34b:fd08:765b with SMTP id
 e15-20020a056102390f00b0034bfd08765bmr16297299vsu.20.1655958427918; Wed, 22
 Jun 2022 21:27:07 -0700 (PDT)
MIME-Version: 1.0
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Wed, 22 Jun 2022 21:26:42 -0700
Message-ID: <CALzcddsfNchgJhKdxbUDDb3zBhbHZfYLCtRt9o6o=pv-zk_w_g@mail.gmail.com>
Subject: efi_tpm_eventlog_init question
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Is this calling memblock_reserve() correctly for the final events log?

For the tpm events log it does:

memblock_reserve(efi.tpm_log, tbl_size);

For the final events log it does:

          memblock_reserve((unsigned long)final_tbl,
                           tbl_size + sizeof(*final_tbl));


which ends up with something like:

[    0.000000] memblock_reserve:
[0x000000005d7b5018-0x000000005d7b958a]
efi_tpm_eventlog_init+0x82/0x370
[    0.000000] memblock_reserve:
[0xffffffffff2c0000-0xffffffffff2c00e4]
efi_tpm_eventlog_init+0x324/0x370


Regards,
Jerry

