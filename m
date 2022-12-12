Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9D649EA2
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Dec 2022 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiLLM3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Dec 2022 07:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLLM3G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Dec 2022 07:29:06 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1546386;
        Mon, 12 Dec 2022 04:29:04 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4008860293A85;
        Mon, 12 Dec 2022 13:29:01 +0100 (CET)
Message-ID: <c418e7aa-1fdc-8c09-80cc-ab9c2a293b99@molgen.mpg.de>
Date:   Mon, 12 Dec 2022 13:29:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/3] certs: Prevent spurious errors on repeated
 blacklisting
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20221118040343.2958-1-linux@weissschuh.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221118040343.2958-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Thomas,


Am 18.11.22 um 05:03 schrieb Thomas Weißschuh:

> [    0.890814] blacklist: Problem blacklisting hash (-13)

After updating the UEFI firmware of the MSI B350M-MORTAR [1] from BIOS 
1.MV 06/23/2020 to BIOS 1.O6 07/13/2022 (7A37v1O6 (Beta version)), the 
same (uninformative) errors were logged by Linux. With your patches, the 
errors are gone.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[1]: https://de.msi.com/Motherboard/B350M-MORTAR/support
