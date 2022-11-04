Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4D619E08
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 18:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiKDREA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKDREA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 13:04:00 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1732C64C
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 10:03:58 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N3n5l3xVSzMqP72;
        Fri,  4 Nov 2022 18:03:55 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4N3n5k5nYNzMpprG;
        Fri,  4 Nov 2022 18:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667581435;
        bh=rDKlvs8YU46CKqX82hlxiACZy1AJYlqE6JjX6FipWvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C4wdECx7thGygxi5nrmA3/kCeEewHDEX338TkrABm3eCBt+52aGJsEpDx39JZs54+
         SbOE59h+HHFRl4V1yri2Lnl/43ykDhCcxJjBoQQNwn+1EulC3fTuJkL8lyJON/Xjlm
         PGn8iDj4oEvB8LSEmCrtuBIobYASOQyNZNfqvoCA=
Message-ID: <af0d6881-76c0-f570-0c5b-f664e261c4cf@digikod.net>
Date:   Fri, 4 Nov 2022 18:03:53 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [BUG] blacklist: Problem blacklisting hash (-13) during boot
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Thanks for this report. These error messages seem correct but I don't 
see any legitimate reason for the firmware to store duplicate 
blacklisted hashes.

According to the blacklist_init() function, the "blacklisting failed" 
message could be improved to explain that only a set of hashes failed, 
and why they failed. However, despite this message, this should work as 
expected and should not generate any issue.

Did you contact Lenovo to report this issue (i.e. duplicate hashes in 
their firmware)?

Could you please provide the list of duplicate hashes?

Regards,
  Mickaël


On 15/10/2022 05:16, Thomas Weißschuh wrote:
> Hi,
> 
> Since 5.19 during boot I see lots of the following entries in dmesg:
> 
> blacklist: Problem blacklisting hash (-13)
> 
> This happens because the firmware contains duplicate blacklist entries.
> As commit 6364d106e041 [0] modified the "blacklist" keyring to reject updates
> this now leads to the spurious error messages.
> 
> The machine is a Thinkpad X1 Cargon Gen9 with BIOS revision 1.56 and firmware
> revision 1.33.
> 
> [0] 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
