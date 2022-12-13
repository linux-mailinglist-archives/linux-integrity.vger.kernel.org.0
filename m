Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E072D64AD5C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Dec 2022 02:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiLMBzw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Dec 2022 20:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiLMBzw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Dec 2022 20:55:52 -0500
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 17:55:49 PST
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:103:465::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7609F1B1F0
        for <linux-integrity@vger.kernel.org>; Mon, 12 Dec 2022 17:55:49 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4NWLz04Qsdz9scZ
        for <linux-integrity@vger.kernel.org>; Tue, 13 Dec 2022 02:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunlashed.garden;
        s=MBO0001; t=1670896188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T4hqWm2eRjzLNaJ3q4DzYazW6WqU8Cr+It0s3hYAkx8=;
        b=1AhpQ40fYjmac+rS6GoB8D56AuBGzVvNCbgdaefeBQKqF2OobmGzyYC1soTx70osz9Q/j2
        FbNkWb0JqEb4FJ6k75IHW8Fw6NR/87J696lwSQkM+U7qGk3e9jyl3NnuMOGO6BK2QWnR6g
        /6NIlSdDLCwEIiGoj1joDCH8ksdKSKYt1c88DW9h/ys2F8pn1lknVLzZwyHtwDrexUHRcf
        VMxmmDH+X3rZz2/gAv+tnhQKS0nVv23HELE/OXjjgRV8ZScjoeGaVUmBXswPvzsAV4wAao
        VdixJw+qniXK9fQzrvh8h7XCmRr5RFQ3/u+rebVxrzu0pJ5COyFqaMXzO61oqA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Dec 2022 19:49:40 -0600
Message-Id: <CP0B9GMWHUP5.3VZOZJBZJ3ODC@arch>
Subject: Firmware bug on ASRock X370/Ryzen 2600 prevents use of TPM device
From:   "Genevieve" <genevieve@sunlashed.garden>
To:     <linux-integrity@vger.kernel.org>
X-Rspamd-Queue-Id: 4NWLz04Qsdz9scZ
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi there,

Apologies if this is the wrong mailing list for this query - feel free
to redirect me if so.

Looking into issues I'm having with systemd being unable to access the
TPM, it seems they occur because its firmware reports incorrect info
and the kernel or driver then can't expose a device for it.
(The device combination here is an ASRock X370 Killer SLI/AC motherboard
and a Ryzen 2600 CPU).

> tpm_crb MSFT0101:00: [Firmware Bug]: ACPI region does not cover the
> entire command/response buffer.
> [mem 0xec6c2000-0xec6c2fff flags 0x200] vs ec6c2000 4000
> fbcon: Taking over console
> tpm_crb MSFT0101:00: can't request region for resource
> [mem 0xec6c2000-0xec6c2fff]
> tpm_crb: probe of MSFT0101:00 failed with error -16

This leads to some errors later in boot when a TPM device is expected
but cannot be found:

> systemd-pcrphase[601]: ERROR:tcti:src/tss2-tcti/tcti-device.c:452:
> Tss2_Tcti_Device_Init() Failed to open specified TCTI device file
> /dev/tpmrm0: No such file or directory
> systemd-pcrphase[601]: Failed to initialize TCTI context:
> tcti:IO failure

(The initial bug report filed with systemd can be found here:
https://github.com/systemd/systemd/issues/25700)

It was suggested to me that it is possible to tweak the driver
to allow it to expose this device despite the issues with its
firmware, which is why I'm reaching out here.

Let me know if there's any other additional information I can provide,
and thanks for your time.

Best,

Genevieve
